import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12

Item {
    required property var level
    required property var enabled
    property int boxHeight: height
    property int boxWidth: (width / bins) - innerMargin
    property string meterColor: enabled ? (virtualstudio.darkMode ? "5B5858" : "D3D4D4") : (virtualstudio.darkMode ? "7b7979" : "EAECEC")
    property string meterGreen: "61C554"
    property string meterYellow: "F5BF4F"
    property string meterRed: "F21B1B"

    function getBoxColor (idx) {
        // Case where the meter should not be filled
        if (!enabled || level <= (idx / bins)) {
            return meterColor;
        }
        // Case where the meter should be filled
        let fillColor = meterGreen;
        if (idx > 0.5*bins && idx <= 0.8*bins) {
            fillColor = meterYellow;
        } else if (idx > 0.8*bins) {
            fillColor = meterRed;
        }
        return fillColor;
    }

    RowLayout {
        anchors.fill: parent
        spacing: innerMargin

        Repeater {
            model: bins
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                x: (boxWidth) * index + innerMargin * index;
                y: 0
                z: 1
                width: boxWidth
                height: boxHeight
                color: `#${getBoxColor(index)}`
                radius: boxRadius
                layer.enabled: getBoxColor(index) != meterColor
                layer.effect: Glow {
                    radius: 6
                    samples: 13
                    color: `#66${getBoxColor(index)}`
                    transparentBorder: true
                    visible: getBoxColor(index) != meterColor
                }
            }
        }
    }
}
