import QtQuick 2
import QtQuick.Controls 2
import QtQuick.Layouts 1
import org.kde.plasma.core 2 as PlasmaCore
import org.kde.kquickcontrolsaddons 2 as KQuickAddons

Item {
    id: page
    property alias cfg_defaultIcon: defaultIconRadio.checked
    property alias cfg_whiteIcon: whiteIconRadio.checked
    property alias cfg_blackIcon: blackIconRadio.checked
    property alias cfg_customIcon: customIconRadio.checked
    property alias cfg_customCompOnIcon: compOnIconButton.compOnIconString
    property alias cfg_customCompOffIcon: compOffIconButton.compOffIconString

    KQuickAddons.IconDialog {
        id: compOnIconDialog

        function setCustomButtonImage(image) {
            compOnIconButton.compOnIconString = image
        }

        onIconNameChanged: setCustomButtonImage(iconName);
    }

    KQuickAddons.IconDialog {
        id: compOffIconDialog

        function setCustomButtonImage(image) {
            compOffIconButton.compOffIconString = image
        }

        onIconNameChanged: setCustomButtonImage(iconName);
    }

    Column{

        RadioButton {
        id: defaultIconRadio
        text: "Use Red/Green Icons"
        }

        RadioButton {
        id: whiteIconRadio
        text: "Use White Icons"
        }

        RadioButton {
        id: blackIconRadio
        text: "Use black Icons"
        }

        RadioButton {
            id: customIconRadio
            text: "Use Custom Icons"
            Column {
                enabled: customIconRadio.checked
                anchors.left: customIconRadio.horizontalCenter
                anchors.top: customIconRadio.bottom
                Row {
                    spacing: 10

                    Label {
                        text: "Compositing On:  "
                        anchors.verticalCenter: compOnIconButton.verticalCenter
                    }
                    Button {
                        id: compOnIconButton
                        property string compOnIconString
                        onClicked: {
                            compOnIconDialog.open()
                        }
                        property var margin: 15
                        property var previewSize: 48
                        width: previewSize + margin
                        height: previewSize + margin
                        PlasmaCore.FrameSvgItem {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            imagePath: plasmoid.location === PlasmaCore.Types.Vertical || plasmoid.location === PlasmaCore.Types.Horizontal ? "widgets/panel-background" : "widgets/background"
                            PlasmaCore.IconItem {
                                width: previewSize
                                height: previewSize
                                anchors.centerIn: parent
                                source: compOnIconButton.compOnIconString || plasmoid.file('', 'ui/comp-on.svg')
                            }
                        }
                    }
                }

                Row {
                    spacing: 10

                    Label {
                        text: "Compositing Off: "
                        anchors.verticalCenter: compOffIconButton.verticalCenter
                    }
                    Button {
                        id: compOffIconButton
                        property string compOffIconString
                        onClicked: {
                            compOffIconDialog.open()
                        }
                        property var margin: 15
                        property var previewSize: 48
                        width: previewSize + margin
                        height: previewSize + margin
                        PlasmaCore.FrameSvgItem {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            imagePath: plasmoid.location === PlasmaCore.Types.Vertical || plasmoid.location === PlasmaCore.Types.Horizontal ? "widgets/panel-background" : "widgets/background"
                            PlasmaCore.IconItem {
                                width: previewSize
                                height: previewSize
                                anchors.centerIn: parent
                                source: compOffIconButton.compOffIconString || plasmoid.file('', 'ui/comp-off.svg')
                            }
                        }
                    }
                }
            }
        }
    }
}
