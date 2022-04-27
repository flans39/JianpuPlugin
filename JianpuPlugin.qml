//==============================================
//  MuseScore
//
//  Jianpu Numbered Notation plugin (Improved)
//  Adapted from https://musescore.org/en/project/jianpu-numbered-notation-0
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.9
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import MuseScore 3.0

import Qt.labs.settings 1.0

MuseScore {
    menuPath: "Plugins.Jianpu (Numbered Notation)"
    version: "1.0"
    description: qsTr("A Jianpu (Numbered Notation) Plugin for MuseScore")
    pluginType: "dialog"

    id: window
    width:285
    height:285

    ExclusiveGroup {
        id: exclusiveGroupKey
    }

    property var fontJianpu : "Freestyle Script"

    property var fileExist :true

    property var seplines

    property var valCenterCInit : 60
    property var fontListInitNumber : 0
    property var fontListInitName : "b,#"
    property var fontSizeInit : 12
    property var yPositionInit : 3
    property var xPositionInit : 0
    property var partListInit : 0
    property var colorListInit : 0

    property var fontName: ["b,#","♭,♯"]
    property var fontNameSel : 0
    // Item positions in menu window
    property var itemX1 : 10
    property var itemX2 : 150
    property var itemY1 : 10
    property var itemDY : 25

    RowLayout {
        //======================  FONT
        id: row1
        x :itemX1
        y :itemY1+itemDY*0.5
        Label {
            text: "♭♯ Font"
        }
    }

    RowLayout {
        id: row1R
        x :itemX2
        y :itemY1+itemDY*0.5
        ComboBox {
            currentIndex: fontListInitNumber
            model: ListModel {
                id: fontList
                property var key
                ListElement {
                    text: "b,#"; fName: 0
                }
                ListElement {
                    text: "♭,♯"; fName: 1
                }
            }
            width: 100
            onCurrentIndexChanged: {
                fontList.key = fontList.get(currentIndex).fName
            }
        } // end ComboBox
    }

    RowLayout {
        //======================  FONT SIZE
        id: row2
        x :itemX1
        y :itemY1+itemDY*2
        Label {
            text: "Font Size"
        }
    }

    RowLayout {
        id: row2R
        x :itemX2
        y :itemY1+itemDY*2
        SpinBox {
            id: valFontSize
            implicitWidth: 55
            decimals: 0
            minimumValue: 4
            maximumValue: 36
            value: fontSizeInit
        }
    }

    RowLayout {
        //======================  Y POSITION
        id: row3
        x :itemX1
        y :itemY1+itemDY*4
        Label {
            text: "Y position"
        }
    }

    RowLayout {
        id: row3R
        x :itemX2
        y :itemY1+itemDY*4
        SpinBox {
            id: valYPosition
            implicitWidth: 55
            decimals: 0
            minimumValue: -20
            maximumValue: 30
            value: yPositionInit
        }
    }

    RowLayout {
        //======================  Jianpu Notation Middle C MIDI note number
        id: rowJ
        x :itemX1
        y :itemY1+itemDY*3+5
        Label {
            text: "1's MIDI number"
        }
    }

    RowLayout {
        id: rowJR
        x :itemX2
        y :itemY1+itemDY*3+5
        SpinBox {
            id: valCenterC
            implicitWidth: 55
            decimals: 0
            minimumValue: 0
            maximumValue: 127
            value: valCenterCInit
        }
    }

    RowLayout {
        //======================  X POSITION
        id: row4
        x :itemX1
        y :itemY1+itemDY*4+40
        Label {
            //      font.pointSize: fontSizeMenu
            text: "X position"
        }
    }

    RowLayout {
        id: row4R
        x :itemX2
        y :itemY1+itemDY*4+40
        SpinBox {
            id: valXPosition
            implicitWidth: 55
            decimals: 1
            minimumValue: -5
            maximumValue: 5
            value: xPositionInit
            stepSize: 0.1
        }
    }

    RowLayout {
        //======================  PART
        id: row5
        x :itemX1
        y :itemY1+itemDY*5+40
        Label {
            text: "Part"
        }
    }

    RowLayout {
        id: row5R
        x :itemX2
        y :itemY1+itemDY*5+40
        ComboBox {
            currentIndex: partListInit
            model: ListModel {
                id: partList
                property var key
                ListElement {
                    text: "Part 1"; pName: 0
                }
                ListElement {
                    text: "Part 2"; pName: 1
                }
                ListElement {
                    text: "Part 3"; pName: 2
                }
                ListElement {
                    text: "Part 4"; pName: 3
                }
            }

            width: 60
            onCurrentIndexChanged: {
                partList.key = partList.get(currentIndex).pName
            }
        } // end ComboBox
    }

    RowLayout {
        //======================  COLOR
        id: row6
        x :itemX1
        y :itemY1+itemDY*6+40
        Label {
            text: "Color"
        }
    }

    RowLayout {
        id: row6R
        x :itemX2
        y :itemY1+itemDY*6+40
        ComboBox {
            currentIndex: colorListInit
            model: ListModel {
                id: colorList
                property var key
                ListElement {
                    text: "Black"; cName: 0
                }
                ListElement {
                    text: "Red"; cName: 1
                }
                ListElement {
                    text: "Blue"; cName: 2
                }
                ListElement {
                    text: "Green"; cName: 3
                }
                ListElement {
                    text: "Purple"; cName: 4
                }
                ListElement {
                    text: "Gray"; cName: 5
                }
            }
            width: 60
            onCurrentIndexChanged: {
                colorList.key = colorList.get(currentIndex).cName
            }
        } // end ComboBox
    }

    RowLayout {
        //============ Ver. No. ================
        id: rowVerNo
        x : 10
        y : 260
        Label {
            font.pointSize: 10
            text: "V"+version
        }
    }

    RowLayout {
        //======================  CANCEL  /  OK
        id: row7
        x : 110
        y : 250
        Button {
            id: closeButton
            text: "Cancel"
            onClicked: {
                Qt.quit()
            }
        }
        Button {
            id: okButton
            text: "Ok"
            onClicked: {
                apply()
                Qt.quit()
            }
        }
    }

    function apply() {
        curScore.startCmd()
        applyToSelection()
        curScore.endCmd()
    }

    onRun: {
        if (typeof curScore === 'undefined')
            Qt.quit();
    }

    function applyToSelection() {

        var cursor = curScore.newCursor();
        var startStaff;
        var endStaff;
        var endTick;
        var fullScore = false;

        var yPos = valYPosition.value;
        var xPos = valXPosition.value;
        var fontSize = valFontSize.value;

        var fontSizeTag="<font size=\""+fontSize+"\"/>";
        var fontFaceTag="<font face=\""+fontJianpu+"\"/>";

        var selPart=0;
        //               RGB color  Black, Red, Blue, Green, Purple, Gray
        var colorData= ["#000000" ,"#FF0000" ,"#0000FF" ,"#00FF00" ,"#C007C0" ,"#888888"];
        var fontColor=colorData[colorList.key];

        cursor.rewind(1); // rewind to start of selection
        if (!cursor.segment) {
            // no selection
            fullScore = true;
            startStaff = 0; // start with 1st staff
            endStaff  = curScore.nstaves - 1; // and end with last
        } else {
            startStaff = cursor.staffIdx;
            cursor.rewind(2); // rewind to end of selection
            if (cursor.tick == 0) {
                endTick = curScore.lastSegment.tick + 1;
            } else {
                endTick = cursor.tick;
            }
            endStaff   = cursor.staffIdx;
        }

        for (var staff = startStaff; staff <= endStaff; staff++) {
            //      for (var voice = 0; voice < 4; voice++) {
            var voice=partList.key;

            cursor.rewind(1); // beginning of selection
            cursor.voice    = voice;
            cursor.staffIdx = staff;

            if (fullScore) // no selection
                cursor.rewind(0); // beginning of score

            while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                var text = newElement(Element.STAFF_TEXT);
                if (cursor.element && cursor.element.type == Element.CHORD) {
                    var text = newElement(Element.STAFF_TEXT);
                    text.placement = Placement.BELOW;
                    text.autoplace = true;
                    // ######################## GRACE #####################################
                    var graceChords = cursor.element.graceNotes;
                    for (var i = 0; i < graceChords.length; i++) {
                        var notes = graceChords[i].notes;
                        nameChord(notes, text, fontList.key, fontSize);
                        text.offsetX =xPos -2.0 * (graceChords.length - i); // X position of Grace note
                        switch (voice) {
                            case 0: text.offsetY = yPos; break;
                            case 1: text.offsetY = yPos+2; break;
                            case 2: text.offsetY = yPos+4; break;
                            case 3: text.offsetY = yPos+6; break;
                        }
                        text.color= fontColor;
                        text.text= fontSizeTag + fontFaceTag + text.text;
                        text.placement = Placement.BELOW;
                        text.autoplace = true;
                        cursor.add(text);
                        text  = newElement(Element.STAFF_TEXT);
                    } // end graceChorde
                    //####################################################################
                    var notes = cursor.element.notes;
                    nameChord(notes, text, fontList.key, fontSize);
                    switch (voice) {
                        case 0: text.offsetY = yPos; break;
                        case 1: text.offsetY = yPos+2; break;
                        case 2: text.offsetY = yPos+4; break;
                        case 3: text.offsetY = yPos+6; break;
                    }
                    text.color= fontColor;
                    text.offsetX= xPos;
                    cursor.add(text);
                } // end if CHORD
                cursor.next();
            } // end while segment
            //      } // end for voice
        } // end for staff
        Qt.quit();
    } // end onRun

    function nameChord (notes, text, fontListNo, fontSize) {
        if (fontListNo==0) {
            var JianpuS= ["1","#1","2","#2","3","4","#4","5","#5","6","#6","7"]
            var JianpuF= ["1","b2","2","b3","3","4","b5","5","b6","6","b7","7"]
        } else {
            var JianpuS= ["1","♯1","2","♯2","3","4","♯4","5","♯5","6","♯6","7"]
            var JianpuF= ["1","♭2","2","♭3","3","4","♭5","5","♭6","6","♭7","7"]
        }

        var fontSizeTag="<font size=\""+fontSize+"\"/>";
        var fontSizeSTag="<font size=\""+(fontSize-3)+"\"/>";
        var fontFaceTag="<font face=\""+fontJianpu+"\"/>";

        for (var i = 0; i < notes.length; i++) {
            var sep = "\n"; //  ","; // change to "\n" if you want them vertically
            if (i > 0) text.text = sep + text.text;
            if (notes[i].tieBack == null) {
                text.text=text.text;
                var pitchShift=valCenterC.value-60;
                var pitchIndex1=parseInt((notes[i].pitch -pitchShift)/12)-5;
                var pitchIndex2=parseInt((notes[i].pitch-pitchShift) % 12) ;
                var After="";
                var Before="";
                if (pitchIndex1==-5) After="̣̣̣̣̣";
                if (pitchIndex1==-4) After="̣̣̣̣";
                if (pitchIndex1==-3) After="̣̣̣";
                if (pitchIndex1==-2) After="̣̣";
                if (pitchIndex1==-1) After="̣";
                if (pitchIndex1==0) After="";
                if (pitchIndex1==0) After="";
                if (pitchIndex1==1) After="̇";
                if (pitchIndex1==2) After="̇̇";
                if (pitchIndex1==3) After="̇̇̇";
                if (pitchIndex1==4) After="̇̇̇̇";
                if (pitchIndex1==5) After="̇̇̇̇̇";

                if (notes[i].tpc>=6 && notes[i].tpc<=12 && JianpuF[pitchIndex2].length==2) {
                    if (fontListNo==0) text.text= fontSizeTag   + fontFaceTag +qsTr(JianpuF[pitchIndex2].substr(0,1)+ Before+qsTr(JianpuF[pitchIndex2].substr(1))+After) +text.text ; // b
                    else if (fontListNo==1) text.text= fontSizeSTag + fontFaceTag +qsTr(JianpuF[pitchIndex2].substr(0,1)+ fontSizeTag+Before+JianpuF[pitchIndex2].substr(1)+After) +text.text ; // ♭
                } else if (notes[i].tpc>=20 && notes[i].tpc<=26 && JianpuF[pitchIndex2].length==2) {
                    if (fontListNo==0) text.text= fontSizeTag   + fontFaceTag +qsTr(JianpuS[pitchIndex2].substr(0,1)+ Before+JianpuS[pitchIndex2].substr(1)+After) +text.text ; // #
                    else if (fontListNo==1) text.text= fontSizeSTag + fontFaceTag +qsTr(JianpuS[pitchIndex2].substr(0,1)+ fontSizeTag+Before+JianpuS[pitchIndex2].substr(1)+After) +text.text ; // ♯
                } else {
                    text.text= fontSizeTag + fontFaceTag +qsTr(Before+JianpuS[pitchIndex2]+After) +text.text ;
                }
            } // end for tieBack
        } // end for note
    } // end function
} // end MuseScore
