import qs.modules.common
import qs.modules.common.widgets
import qs.services
import qs
import qs.modules.common.functions
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland
Item {
    id: root
    property bool borderless: Config.options.bar.borderless
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property string cleanedTitle: StringUtils.cleanMusicTitle(activePlayer?.trackTitle) || Translation.tr("No media")
    Layout.fillHeight: true
    Layout.fillWidth: false
    
    Layout.preferredWidth: {
        if (!activePlayer || !activePlayer.trackTitle) return 80;
        return Math.min(scrollText.implicitWidth + 24, 200);
    }
    Layout.maximumWidth: 200
    
    implicitWidth: Layout.preferredWidth
    implicitHeight: Appearance.sizes.barHeight
    
    visible: true
    
    Timer {
        running: activePlayer?.playbackState == MprisPlaybackState.Playing
        interval: Config.options.resources.updateInterval
        repeat: true
        onTriggered: activePlayer.positionChanged()
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton | Qt.BackButton | Qt.ForwardButton | Qt.RightButton | Qt.LeftButton
        hoverEnabled: false
        onPressed: (event) => {
            if (event.button === Qt.MiddleButton) {
                activePlayer.togglePlaying();
            } else if (event.button === Qt.BackButton) {
                activePlayer.previous();
            } else if (event.button === Qt.ForwardButton || event.button === Qt.RightButton) {
                activePlayer.next();
            } else if (event.button === Qt.LeftButton) {
                GlobalStates.mediaControlsOpen = !GlobalStates.mediaControlsOpen
            }
        }
    }
    RowLayout {
        id: rowLayout
        spacing: 4
        anchors.fill: parent
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        ClippedFilledCircularProgress {
            id: mediaCircProg
            Layout.alignment: Qt.AlignVCenter
            lineWidth: Appearance.rounding.unsharpen
            value: activePlayer?.position / activePlayer?.length
            implicitSize: 20
            colPrimary: "#d65d0e"
            enableAnimation: false
            visible: activePlayer && activePlayer.trackTitle !== ""
            Item {
                anchors.centerIn: parent
                width: mediaCircProg.implicitSize
                height: mediaCircProg.implicitSize
                MaterialSymbol {
                    anchors.centerIn: parent
                    font.weight: Font.DemiBold
                    fill: 1
                    text: activePlayer?.isPlaying ? "pause" : "music_note"
                    iconSize: Appearance.font.pixelSize.normal
                    color: "#d65d0e"
                }
            }
        }
        Item {
            Layout.preferredWidth: Math.min(scrollText.implicitWidth + 16, 170)
            Layout.maximumWidth: 170
            Layout.fillHeight: true
            clip: true
            
            Row {
                id: scrollContainer
                height: parent.height
                spacing: 40
                
                x: scrollText.shouldScroll ? scrollX : 8
                property real scrollX: 8
                
                Repeater {
                    model: scrollText.shouldScroll ? 2 : 1
                    
                    StyledText {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: Appearance.font.pixelSize.small
                        color: Appearance.colors.colOnLayer1
                        text: `${cleanedTitle}${activePlayer?.trackArtist ? ' • ' + activePlayer.trackArtist : ''}`
                    }
                }
            }
            
            StyledText {
                id: scrollText
                visible: false
                font.pixelSize: Appearance.font.pixelSize.small
                text: `${cleanedTitle}${activePlayer?.trackArtist ? ' • ' + activePlayer.trackArtist : ''}`
                property bool shouldScroll: implicitWidth > 170
            }
            
            // FIX: Timer-based smooth scrolling (frame-by-frame)
            Timer {
                id: scrollTimer
                interval: 20  // 50fps - smooth and not too CPU intensive
                repeat: true
                running: scrollText.shouldScroll && 
                         activePlayer !== null && 
                         activePlayer.playbackState === MprisPlaybackState.Playing &&
                         activePlayer.trackTitle !== null &&
                         activePlayer.trackTitle !== ""
                
                property real pixelsPerFrame: 0.4  // Speed: adjust this for faster/slower
                
                onTriggered: {
                    // Move text left
                    scrollContainer.scrollX -= pixelsPerFrame;
                    
                    // Seamless reset when first copy fully scrolled
                    var resetPoint = -(scrollText.implicitWidth + 40);
                    if (scrollContainer.scrollX <= resetPoint) {
                        scrollContainer.scrollX = 8;
                    }
                }
                
                onRunningChanged: {
                    if (running) {
                        // Start from beginning when animation starts
                        scrollContainer.scrollX = 8;
                    }
                }
            }
            
            // Reset position when text changes
            Connections {
                target: root
                function onCleanedTitleChanged() {
                    scrollContainer.scrollX = 8;
                }
            }
        }
    }
}
