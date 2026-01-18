import qs.modules.common
import qs.services
import QtQuick
import QtQuick.Layouts
MouseArea {
    id: root
    property bool borderless: Config.options.bar.borderless
    property bool alwaysShowAllResources: false
    implicitWidth: rowLayout.implicitWidth + rowLayout.anchors.leftMargin + rowLayout.anchors.rightMargin
    implicitHeight: Appearance.sizes.barHeight
    hoverEnabled: !Config.options.bar.tooltips.clickToShow
    RowLayout {
        id: rowLayout
        spacing: 0
        anchors.fill: parent
        anchors.leftMargin: 4
        anchors.rightMargin: 4
        Resource {
            iconName: "memory"
            percentage: ResourceUsage.memoryUsedPercentage
            warningThreshold: Config.options.bar.resources.memoryWarningThreshold
            customColor: "#fabd2f"
        }
        Resource {
            iconName: "swap_horiz"
            percentage: ResourceUsage.swapUsedPercentage
            // FIX: Always show swap icon, even when media is playing
            shown: (Config.options.bar.resources.alwaysShowSwap && percentage > 0) || 
                root.alwaysShowAllResources ||
                true  // Always show (removed the media title check)
            Layout.leftMargin: shown ? 6 : 0
            warningThreshold: Config.options.bar.resources.swapWarningThreshold
            customColor: "#458588"
        }
        Resource {
            iconName: "planner_review"
            percentage: ResourceUsage.cpuUsage
            shown: Config.options.bar.resources.alwaysShowCpu || 
                !(MprisController.activePlayer?.trackTitle?.length > 0) ||
                root.alwaysShowAllResources
            Layout.leftMargin: shown ? 6 : 0
            warningThreshold: Config.options.bar.resources.cpuWarningThreshold
            customColor: "#fb4934"
        }
    }
    ResourcesPopup {
        hoverTarget: root
    }
}
