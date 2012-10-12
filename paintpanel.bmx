Rem
bbdoc: A custom maxgui panel that can perform native painting.
about:
<p>With this moudle you can create a paintpanel which acts like a maxgui panel. The paintpanel will recieve paint messages which allows you to render custom gadgets with native drawing operations.</p>
<p><b>Important!</b><br />This module only works for windows and osx!</p>
End Rem
Module skn3.paintpanel
SuperStrict

ModuleInfo "History: 1.03"
ModuleInfo "History: Fixed devicecontext font selection issue with using PaintTextDimensions outside of EVENT_GADGETPAINT"
ModuleInfo "History: 1.02"
ModuleInfo "History: Added PaintTextDimensions method"
ModuleInfo "History: Added PaintText now returns [x,y,width,height] of the text that was just drawn"
ModuleInfo "History: 1.01"
ModuleInfo "History: Mac version done"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release To Public"

'genreal imports
Import brl.linkedlist
Import brl.pixmap
Import maxgui.drivers

'platform speciffic imports
?MacOs
Import "paintpanel.m"
?

'skn3 framework code
rem
Import skn3.callback
Import skn3.funcs

Global CALLBACK_PAINT_PANEL_PAINT:Int = AllocCallbackId("Paint Panel Paint")

Private
Function EmitPaintPanelCallback(panel:Skn3PaintPanel)
	' --- perform the paintpanel user hookable operation ---
	If panel
		'fire skn3 callback
		Local data:skn3CallbackData = CallbackDataObject()
		data.object1 = panel
		FireCallback(CALLBACK_PAINT_PANEL_PAINT,data)
	EndIf
End Function
Public
endrem

'maxgui stock code
'rem
Const ALIGN_LEFT:Int = 0
Const ALIGN_CENTER:Int = 1
Const ALIGN_RIGHT:Int = 2
Const ALIGN_TOP:Int = 0
Const ALIGN_BOTTOM:Int = 2

Private
Function EmitPaintPanelCallback(panel:Skn3PaintPanel)
	' --- perform the paintpanel user hookable operation ---
	'fire maxgui event
	If panel EmitEvent(CreateEvent(EVENT_GADGETPAINT,panel,0,0,0,0))
End Function
Public
'endrem

Private
Function GetCreationGroup:TGadget(Gadget:TGadget)
	' --- converts the gadget into the correct group for creating gadget ---
	'this is also duplicated in maxguiex and stock maxgui (should have been public function)
	Local tmpProxy:TProxyGadget = TProxyGadget(Gadget)
	If tmpProxy Then Return GetCreationGroup(tmpProxy.proxy)
	Return gadget
EndFunction
Public

?win32
Include "win.bmx"
?macos
Include "mac.bmx"
?