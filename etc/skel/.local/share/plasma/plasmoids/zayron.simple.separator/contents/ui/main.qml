import QtQuick 2.12
import QtQuick.Layouts 1.1
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    readonly property bool isVertical: Plasmoid.formFactor === PlasmaCore.Types.Vertical
    property int anchoDeSepardor: isVertical ? (width < 40) ? 1 : (width < 60) ? 1.5 : 2 : (height < 40) ? 1 : (height < 60) ? 1.5 : 2
    property int margins: Plasmoid.configuration.lengthMargin
    property bool customColorCheck: Plasmoid.configuration.checkColorCustom
    property string customColor: Plasmoid.configuration.customColors
    property int lengthPorcent: Plasmoid.configuration.lengthSeparator

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground | PlasmaCore.Types.ConfigurableBackground
    preferredRepresentation: fullRepresentation


          fullRepresentation: RowLayout {
             id: base
             Layout.minimumWidth: isVertical ? root.width : anchoDeSepardor + margins
             Layout.maximumHeight: isVertical ? anchoDeSepardor + margins : root.height
             Row {
                height: separator.height
                width: separator.width
                anchors.centerIn: parent

                Row {
                   id: separator
                   height: isVertical ? anchoDeSepardor + margins : root.height
                   width: isVertical ? root.height : anchoDeSepardor + margins
                   anchors.centerIn: parent
                   Rectangle {
                     width: isVertical ? root.width/100*lengthPorcent : anchoDeSepardor
                     height: isVertical ? anchoDeSepardor : root.height/100*lengthPorcent
                     color: customColorCheck ? customColor: Kirigami.Theme.textColor
                     opacity: 0.4
                     anchors.centerIn: parent
                   }

               }

             }

          }
}
