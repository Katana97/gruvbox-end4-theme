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
    // CRITICAL: Don't use Layout.fillWidth - it pushes other items out
    Layout.fillWidth: false
    
    // FIX 1: Dynamic width with maximum constraint to prevent overlap with swap icon
    Layout.preferredWidth: {
        if (!activePlayer || !activePlayer.trackTitle) return 0;
        // Use actual text width but cap at 200px to ensure Resources (swap icon) stays visible
        return Math.min(scrollText.implicitWidth + 24, 200);
    }
    Layout.maximumWidth: 200
    
    implicitWidth: Layout.preferredWidth
    implicitHeight: Appearance.sizes.barHeight
    
    // Only show when there's actual media playing
    visible: activePlayer && activePlayer.trackTitle !== ""
    
    Timer {
        running: activePlayer?.playbackState == MprisPlaybackState.Playing
        interval: Config.options.resources.updateInterval
        repeat: true
        onTriggered: activePlayer.positionChanged()
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton | Qt.BackButton | Qt.ForwardButton | Qt.RightButton | Qt.LeftButton
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
            // FIX 1 continued: Use flexible width that respects the container
            Layout.preferredWidth: Math.min(scrollText.implicitWidth, 170)
            Layout.maximumWidth: 170  // Maximum to leave space for Resources icons
            Layout.fillHeight: true
            clip: true
            
            Row {
                id: scrollContainer
                height: parent.height
                spacing: 40
                
                // FIX 2: Proper x positioning for short text
                x: {
                    if (!scrollText.shouldScroll) {
                        // Text fits - add left padding
                        return 8;
                    } else {
                        // Text scrolls - use animation value
                        return scrollText.shouldScroll && activePlayer?.isPlaying ? scrollX : 8;
                    }
                }
                
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
                
                SequentialAnimation on scrollX {
                    running: scrollText.shouldScroll && activePlayer?.isPlaying
                    loops: Animation.Infinite
                    
                    // Pause at start with proper padding visible
                    PauseAnimation { duration: 1500 }
                    
                    NumberAnimation {
                        from: 8
                        to: -(scrollText.implicitWidth + 40 - 8)
                        duration: 8000
                        easing.type: Easing.Linear
                    }
                    
                    // Pause at end
                    PauseAnimation { duration: 1500 }
                    
                    // Quick reset
                    PropertyAction { 
                        target: scrollContainer
                        property: "scrollX"
                        value: 8
                    }
                }
            }
            
            StyledText {
                id: scrollText
                visible: false
                font.pixelSize: Appearance.font.pixelSize.small
                text: `${cleanedTitle}${activePlayer?.trackArtist ? ' • ' + activePlayer.trackArtist : ''}`
                // Check against the constrained width
                property bool shouldScroll: implicitWidth > 170
            }
        }
    }
}
