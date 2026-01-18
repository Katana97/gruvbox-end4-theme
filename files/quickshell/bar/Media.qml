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
    implicitWidth: rowLayout.implicitWidth + rowLayout.spacing * 2
    implicitHeight: Appearance.sizes.barHeight
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
            Layout.preferredWidth: 180
            Layout.maximumWidth: 180
            Layout.fillHeight: true
            clip: true
            
            Row {
                id: scrollContainer
                height: parent.height
                spacing: 40
                
                Repeater {
                    model: scrollText.shouldScroll ? 2 : 1
                    
                    StyledText {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: Appearance.font.pixelSize.small
                        color: Appearance.colors.colOnLayer1
                        text: `${cleanedTitle}${activePlayer?.trackArtist ? ' • ' + activePlayer.trackArtist : ''}`
                    }
                }
                
                SequentialAnimation on x {
                    running: scrollText.shouldScroll && activePlayer?.isPlaying
                    loops: Animation.Infinite
                    
                    NumberAnimation {
                        from: 0
                        to: -(scrollText.implicitWidth + 40)
                        duration: 8000
                        easing.type: Easing.Linear
                    }
                    
                    PropertyAction { 
                        target: scrollContainer
                        property: "x"
                        value: 0
                    }
                }
            }
            
            StyledText {
                id: scrollText
                visible: false
                font.pixelSize: Appearance.font.pixelSize.small
                text: `${cleanedTitle}${activePlayer?.trackArtist ? ' • ' + activePlayer.trackArtist : ''}`
                property bool shouldScroll: implicitWidth > 180
            }
        }
    }
}
