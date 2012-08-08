#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.6.1
	Author:         2quader

#ce ----------------------------------------------------------------------------
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>

#Region ### START Koda GUI section ###
$frmMain = GUICreate("cpPic2", 487, 99, 199, 165)
$txtIn = GUICtrlCreateInput("", 8, 8, 313, 21)
$btnIn = GUICtrlCreateButton("Bildverzeichnis (Kamera)", 328, 8, 147, 25, $WS_GROUP)
$txtOut = GUICtrlCreateInput("", 8, 40, 313, 21)
$btnOut = GUICtrlCreateButton("Bildverzeichnis (PC)", 328, 40, 147, 25, $WS_GROUP)
$btnStart = GUICtrlCreateButton("Start", 9, 64, 127, 25, $WS_GROUP)
$txtPrg = GUICtrlCreateInput("txtPrg", 416, 72, 57, 21)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $btnIn
			$inDir = FileSelectFolder("Wählen Sie einen Ordner aus.", "", 4)
			GUICtrlSetData($txtIn, $inDir)
		Case $btnOut
			$outDir = FileSelectFolder("Wählen Sie einen Ordner aus.", "", 5)
			GUICtrlSetData($txtOut, $outDir)
		Case $btnStart
			$fileArray = _FileListToArray($inDir, "*.jpg", 1)
			For $i = 1 To $fileArray[0]
				$t = FileGetTime($inDir & "\" & $fileArray[$i])
				$name = $t[0] & "_" & $t[1] & "_" & $t[2]

				if not FileExists($outDir & "\" & $name) Then
					DirCreate($outDir & "\" & $name)
				EndIf

				FileCopy($inDir & "\" & $fileArray[$i], $outDir & "\" & $name)
				GUICtrlSetData($txtPrg, $i & "/" & $fileArray[0])
			Next
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd