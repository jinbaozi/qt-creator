// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

import QtQuick
import HelperWidgets as HelperWidgets
import StudioControls as StudioControls
import StudioTheme as StudioTheme
import EffectComposerBackend

Rectangle {
    id: root

    height: StudioTheme.Values.toolbarHeight
    color: StudioTheme.Values.themeToolbarBackground

    readonly property var backendModel: EffectComposerBackend.effectComposerModel

    signal addClicked
    signal saveClicked
    signal saveAsClicked
    signal assignToSelectedClicked
    signal openShadersCodeEditor

    Row {
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter

        HelperWidgets.AbstractButton {
            style: StudioTheme.Values.viewBarButtonStyle
            buttonIcon: StudioTheme.Constants.add_medium
            tooltip: qsTr("Add new composition")
            enabled: root.backendModel ? root.backendModel.isEnabled : false
            onClicked: root.addClicked()
        }

        HelperWidgets.AbstractButton {
            style: StudioTheme.Values.viewBarButtonStyle
            buttonIcon: StudioTheme.Constants.save_medium
            tooltip: qsTr("Save current composition")
            enabled: root.backendModel ? root.backendModel.isEnabled
                                         && (root.backendModel.hasUnsavedChanges
                                             || root.backendModel.currentComposition === "")
                                       : false

            onClicked: root.saveClicked()
        }

        HelperWidgets.AbstractButton {
            style: StudioTheme.Values.viewBarButtonStyle
            buttonIcon: StudioTheme.Constants.saveAs_medium
            tooltip: qsTr("Save current composition with a new name")
            enabled: root.backendModel ? root.backendModel.isEnabled
                                         && root.backendModel.currentComposition !== ""
                                       : false

            onClicked: root.saveAsClicked()
        }

        HelperWidgets.AbstractButton {
            style: StudioTheme.Values.viewBarButtonStyle
            buttonIcon: StudioTheme.Constants.codeEditor_medium
            tooltip: qsTr("Open Code")
            enabled: root.backendModel ? root.backendModel.isEnabled
                                         && root.backendModel.currentComposition !== ""
                                       : false

            onClicked: root.openShadersCodeEditor()
        }

        HelperWidgets.AbstractButton {
            style: StudioTheme.Values.viewBarButtonStyle
            buttonIcon: StudioTheme.Constants.assignTo_medium
            tooltip: qsTr("Assign current composition to selected item")
            enabled: root.backendModel ? root.backendModel.hasValidTarget
                                         && root.backendModel.isEnabled
                                         && root.backendModel.currentComposition !== ""
                                       : false

            onClicked: root.assignToSelectedClicked()
        }
    }


    Text {
        readonly property string compName: root.backendModel ? root.backendModel.currentComposition
                                                             : ""

        text: compName !== "" ? compName : qsTr("Untitled")
        anchors.centerIn: parent
        color: StudioTheme.Values.themeTextColor
    }

    HelperWidgets.AbstractButton {
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 5
        anchors.right: parent.right

        style: StudioTheme.Values.viewBarButtonStyle
        buttonIcon: StudioTheme.Constants.help
        tooltip: qsTr("How to use Effect Composer:
1. Click \"+ Add Effect\" to add effect node
2. Adjust the effect nodes properties
3. Change the order of the effects, if you like
4. See the preview
5. Save in the assets library, if you wish to reuse the effect later")

        onClicked: Qt.openUrlExternally("https://doc.qt.io/qtdesignstudio/qtquick-effect-composer-view.html")
    }
}
