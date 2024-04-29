import QtQuick 2
import QtQuick.Layouts 1
import org.kde.plasma.core 2 as PlasmaCore
import org.kde.plasma.plasmoid 2
import org.kde.kwindowsystem 1

Item {
    id: root

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    // Use KWindowSystem from KDeclarative for easy access to compositingActiveChanged signal
    KWindowSystem {
        id: kwindowsystem
    }

    property bool compActive: kwindowsystem.compositingActive

    // Connecting sources to a DataSource while its engine property is set to "executable"
    // allows us to run shell commands
    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            exited(sourceName, exitCode, exitStatus, stdout, stderr)
            disconnectSource(sourceName)
        }
        function exec(cmd) {
            connectSource(cmd)
        }
        signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
    }


    Plasmoid.compactRepresentation: Item {
        id: panelItem
        anchors.fill: parent
        readonly property int minSize: Math.min(width, height)
        PlasmaCore.SvgItem {
            id: svgItem
            property var compOnIcon: plasmoid.configuration.defaultIcon ? plasmoid.file('', 'ui/comp-on.svg') : (plasmoid.configuration.whiteIcon ? plasmoid.file('', 'ui/comp-on-white.svg') : (plasmoid.configuration.blackIcon ? plasmoid.file('', 'ui/comp-on-black.svg') : (plasmoid.configuration.customCompOnIcon || plasmoid.file('', 'ui/comp-on.svg'))))
            property var compOffIcon: plasmoid.configuration.defaultIcon ? plasmoid.file('', 'ui/comp-off.svg') : (plasmoid.configuration.whiteIcon ? plasmoid.file('', 'ui/comp-off-white.svg') : (plasmoid.configuration.blackIcon ? plasmoid.file('', 'ui/comp-off-black.svg') : (plasmoid.configuration.customCompOffIcon || plasmoid.file('', 'ui/comp-off.svg'))))
            //active: compactMouseArea.containsMouse
            //source: compActive ? "comp-on.svg" : "comp-off.svg"
            anchors.centerIn: parent
            readonly property real minSize: Math.min(naturalSize.width, naturalSize.height)
            readonly property real widthRatio: naturalSize.width / svgItem.minSize
            readonly property real heightRatio: naturalSize.height / svgItem.minSize
            width: panelItem.minSize * widthRatio
            height: panelItem.minSize * heightRatio
            smooth: true
            PlasmaCore.IconItem {
                id: svg
                anchors.centerIn: parent
                anchors.fill: parent
                source: (compActive ? svgItem.compOnIcon : svgItem.compOffIcon)
            }

            MouseArea {
                id: compactMouseArea
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton
                onClicked: toggleCompositing();
            }
        }
    }

    Plasmoid.toolTipMainText: "Toggle Compositing"
    Plasmoid.toolTipSubText: {
        return "Compositing is " + (compActive ? "enabled" : "disabled");
    }

    function toggleCompositing() {
//         var action = compActive ? "suspend" : "resume";
//         executable.exec("qdbus org.kde.KWin /Compositor " + action);

        // The dbus method used above is bugged and doesn't always work.
        // If you suspend compositing using KWin's keyboard shortcut,
        // the resume() dbus method won't work. I suspect this bug has
        // something to do with the bitwise operations being done with
        // m_suspend in the source code for KWin:
        // https://invent.kde.org/plasma/kwin/-/blob/b8d69a326c2edfdb7955a94274a7918aaa5daa7f/src/composite.cpp

        // Rather than toggle the compositor directly, we need to invoke
        // the same action that happens when we trigger the "Suspend Compositing"
        // KWin keyboard shortcut.
        executable.exec("qdbus org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.invokeShortcut 'Suspend Compositing'");
    }
}
