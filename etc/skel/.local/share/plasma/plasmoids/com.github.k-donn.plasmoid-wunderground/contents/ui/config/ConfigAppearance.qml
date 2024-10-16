/*
 * Copyright 2024  Kevin Donnelly
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

import "../lib"

KCM.SimpleKCM {
    id: appearanceConfig

    property alias cfg_autoFontAndSize: autoFontAndSizeRadioButton.checked

    property alias cfg_fontFamily: fontDialog.fontChosen.family
    property alias cfg_boldText: fontDialog.fontChosen.bold
    property alias cfg_italicText: fontDialog.fontChosen.italic
    property alias cfg_fontWeight: fontDialog.fontChosen.weight
    property alias cfg_fontStyleName: fontDialog.fontChosen.styleName
    property alias cfg_fontSize: fontDialog.fontChosen.pointSize


    property alias cfg_propHeadPointSize: propHeadPointSize.value
    property alias cfg_propPointSize: propPointSize.value
    property alias cfg_tempPointSize: tempPointSize.value
    property alias cfg_useSystemThemeIcons: useSystemIcons.checked
    property alias cfg_tempAutoColor: tempAutoColor.checked
    property alias cfg_defaultLoadPage: defaultLoadPage.currentIndex
    property alias cfg_showPresTrend: showPresTrend.checked

    Kirigami.FormLayout {
        anchors.fill: parent

        Kirigami.Separator {
            Kirigami.FormData.label: i18nd("plasma_applet_org.kde.desktopcontainment", "Show Background")
            Kirigami.FormData.isSection: true
        }

        BackgroundToggle {}

        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Compact Representation")
            Kirigami.FormData.isSection: true
        }

        ButtonGroup {
            buttons: [autoFontAndSizeRadioButton, manualFontAndSizeRadioButton]
        }

        RadioButton {
            id: autoFontAndSizeRadioButton
            Kirigami.FormData.label: i18nc("@label:group", "Text display:")
            text: i18nc("@option:radio", "Automatic")
        }

        Label {
            text: i18nc("@label", "Text will follow the system font and expand to fill the available space.")
            textFormat: Text.PlainText
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            font: Kirigami.Theme.smallFont
        }

        RowLayout {
            spacing: Kirigami.Units.smallSpacing

            RadioButton {
                id: manualFontAndSizeRadioButton
                text: i18nc("@option:radio setting for manually configuring the font settings", "Manual")
                checked: !cfg_autoFontAndSize
                onClicked: {
                    if (cfg_fontFamily === "") {
                        fontDialog.fontChosen = Kirigami.Theme.defaultFont
                    }
                }
            }

            Button {
                text: i18nc("@action:button", "Choose Style…")
                icon.name: "settings-configure"
                enabled: manualFontAndSizeRadioButton.checked
                onClicked: {
                    fontDialog.selectedFont = fontDialog.fontChosen
                    fontDialog.open()
                }
            }

        }

        FontDialog {
            id: fontDialog
            title: i18nc("@title:window", "Choose a Font")
            modality: Qt.WindowModal
            parentWindow: appearanceConfig.Window.window

            property font fontChosen: Qt.font()

            onAccepted: {
                fontChosen = selectedFont
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Full Representation")
            Kirigami.FormData.isSection: true
        }

        SpinBox {
            id: propHeadPointSize

            editable: true

            Kirigami.FormData.label: i18n("Property header text size")
        }

        SpinBox {
            id: propPointSize

            editable: true

            Kirigami.FormData.label: i18n("Property text size")
        }

        SpinBox {
            id: tempPointSize

            editable: true

            Kirigami.FormData.label: i18n("Temperature text size")
        }

        CheckBox {
            id: useSystemIcons

            Kirigami.FormData.label: i18n("Use system theme icons:")
        }

        CheckBox {
            id: tempAutoColor

            Kirigami.FormData.label: i18n("Auto-color temperature:")
        }

        ComboBox {
            id: defaultLoadPage

            model: [i18n("Weather Details"), i18n("Forecast"), i18n("More Info")]

            Kirigami.FormData.label: i18n("Default page shown:")
        }
        CheckBox {
            id: showPresTrend

            Kirigami.FormData.label: i18n("Show pressure trend:")
        }
    }
}
