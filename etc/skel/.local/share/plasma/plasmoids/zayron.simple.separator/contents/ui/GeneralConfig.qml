import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11


Item {
    id: configRoot

    property alias cfg_checkColorCustom: checkColorCustom.checked
    property alias cfg_lengthMargin: lengthMargin.value
    property alias cfg_opacity: porcetageOpacity.value
    property alias cfg_lengthSeparator: lengthSeparator.value
    property alias cfg_thicknessSeparator: thickness.value
    property alias cfg_customColors: colorcustom.text
    property alias cfg_pointDesing: checkPoinDesing.checked

    ColumnLayout {
        spacing: units.largeSpacing
        Layout.fillWidth: true

        GridLayout{
            columns: 2

            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("replace linear design with point:")
                horizontalAlignment: Text.AlignRight
            }

            CheckBox {
                id: checkPoinDesing
            }
            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("Margin length:")
                horizontalAlignment: Text.AlignRight
            }

            SpinBox{
                id: lengthMargin

                from: 5
                to: 100
                stepSize: 5
                // suffix: " " + i18nc("pixels","px.")
            }

            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("separator length percentage:")
                horizontalAlignment: Text.AlignRight
            }

            SpinBox{
                id: lengthSeparator

                from: 10
                to: 100
                stepSize: 10
                // suffix: " " + i18nc("pixels","px.")
            }
            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("thickness:")
                horizontalAlignment: Text.AlignRight
                visible: !checkPoinDesing.checked
            }
            SpinBox{
                id: thickness

                from: 1
                to: 4
                stepSize: 1
                // suffix: " " + i18nc("pixels","px.")
                visible: !checkPoinDesing.checked
            }
            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("Custom RGB Color:")
                horizontalAlignment: Text.AlignRight
            }
            CheckBox {
                id: checkColorCustom
            }
            Label {

            }
            TextField {
                id: colorcustom
                width: 200
                enabled: checkColorCustom.checked
            }
            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("Opacity:")
                horizontalAlignment: Text.AlignRight
            }

            SpinBox{
                id: porcetageOpacity

                from: 30
                to: 100
                stepSize: 5
                // suffix: " " + i18nc("pixels","px.")
            }
        }

    }

}
