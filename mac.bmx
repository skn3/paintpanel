Private
Extern "macos"
	Function Skn3PaintPanelInit(gadget:TNSGadget)
	Function Skn3PaintPanelSetPaintBackground(gadget:TNSGadget,r:Int,g:Int,b:Int)
	Function Skn3PaintPanelSetPaintColor(gadget:TNSGadget,r1:Int,g1:Int,b1:Int,r2:Int,g2:Int,b2:Int)
	Function Skn3PaintPanelSetPaintFont(gadget:TNSGadget,font:Int,style:Int)
	Function Skn3PaintPanelPaintLine(gadget:TNSGadget,x1:Int,y1:Int,x2:Int,y2:Int,width:Int)
	Function Skn3PaintPanelPaintGradient(gadget:TNSGadget,x:Int,y:Int,width:Int,height:Int,vertical:Int)
	Function Skn3PaintPanelPaintRect(gadget:TNSGadget,x:Int,y:Int,width:Int,height:Int)
	Function Skn3PaintPanelPaintOval(gadget:TNSGadget,x:Int,y:Int,width:Int,height:Int)
	Function Skn3PaintPanelPaintText:Int[](Gadget:TNSGadget,text:String,x:Int,y:Int,Width:Int,Height:Int,wrap:Int,hAlign:Int,vAlign:Int)
	Function Skn3PaintPanelPaintTextDimensions:Int[](gadget:TNSGadget,text:String,x:Int,y:Int,width:Int,height:Int,wrap:Int,hAlign:Int,vAlign:Int)
	Function Skn3PaintPanelPaintBitmap(gadget:TNSGadget,image:Int,x:Int,y:Int)
	Function Skn3PaintPanelPaintSubBitmap(gadget:TNSGadget,image:Int,x:Int,y:Int,width:Int,height:Int,sourceX:Int,sourceY:Int,sourceWidth:Int,sourceHeight:Int)
End Extern

Function PreMultiplyAlpha:Int(argb:Int)
	Local a:Int = ((argb Shr 24) & $FF)
	Return ((((argb&$ff00ff)*a)Shr 8)&$ff00ff)|((((argb&$ff00)*a)Shr 8)&$ff00)|(a Shl 24)
End Function

Public

Type Skn3PaintPanel Extends TNSGadget
	Method SetPaintBackground(r:Int=-1,g:Int=-1,b:Int=-1)
		Skn3PaintPanelSetPaintBackground(Self,r,g,b)
	End Method
	
	Method SetPaintColor(r1:Int=-1,g1:Int=-1,b1:Int=-1,r2:Int=-1,g2:Int=-1,b2:Int=-1)
		Skn3PaintPanelSetPaintColor(Self,r1,g1,b1,r2,g2,b2)
	End Method
	
	Method SetPaintFont(baseFont:TGuiFont)
		Local font:TCocoaGuiFont = TCocoaGuiFont(baseFont)
		If font
			Skn3PaintPanelSetPaintFont(Self,font.handle,font.style)
		Else
			Skn3PaintPanelSetPaintFont(Self,0,0)
		EndIf
		If font = Null font = TCocoaMaxGUIDriver.CocoaGuiFont
	End Method
	
	Method PaintLine(x1:Int,y1:Int,x2:Int,y2:Int,width:Int)
		Skn3PaintPanelPaintLine(Self,x1,y1,x2,y2,width:Int)
	End Method
	
	Method PaintGradient(x:Int,y:Int,width:Int,height:Int,vertical:Int=True)
		Skn3PaintPanelPaintGradient(Self,x,y,width,height,vertical)
	End Method
	
	Method PaintRect(x:Int,y:Int,width:Int,height:Int)
		Skn3PaintPanelPaintRect(Self,x,y,width,height)
	End Method
	
	Method PaintOval(x:Int,y:Int,width:Int,height:Int)
		Skn3PaintPanelPaintOval(Self,x,y,width,height)
	End Method
	
	Method PaintPoint(x:Int,y:Int)
		Skn3PaintPanelPaintOval(Self,x,y,1,1)
	End Method
	
	Method PaintText:Int[](text:String,x:Int,y:Int,Width:Int=0,Height:Int=0,wrap:Int=False,hAlign:Int=ALIGN_LEFT,vAlign:Int=ALIGN_TOP)
		Skn3PaintPanelPaintText(Self,text,x,y,width,height,wrap,hAlign,vAlign)
	End Method
	
	Method PaintTextDimensions:Int[](text:String,x:Int=0,y:Int=0,Width:Int=0,Height:Int=0,wrap:Int=False,hAlign:Int=0,vAlign:Int=0)
		Return Skn3PaintPanelPaintTextDimensions(Self,text,x,y,Width,Height,wrap,hAlign,vAlign)
	End Method
	
	Method PaintBitmap(bitmap:Skn3PaintBitmap,x:Int,y:Int)
		Skn3PaintPanelPaintBitmap(Self,bitmap.bitmap,x,y)
	End Method
	
	Method PaintSubBitmap(bitmap:Skn3PaintBitmap,x:Int,y:Int,Width:Int,Height:Int,sourceX:Int=0,sourceY:Int=0,sourceWidth:Int=-1,sourceHeight:Int=-1)
		Skn3PaintPanelPaintSubBitmap(Self,bitmap.bitmap,x,y,width,height,sourceX,sourceY,sourceWidth,sourceHeight)
	End Method
End Type

Function CreatePaintPanel:Skn3PaintPanel(x:Int,y:Int,width:Int,height:Int,group:TGadget,Style:Int=0)
	'code ripped/modified from cocoagui.bmx
	Local panel:Skn3PaintPanel = New Skn3PaintPanel

	'fix group
	group = GetCreationGroup(group)
	If Not group group = Desktop()
	
	'set properties
	panel.origclass = GADGET_PANEL
	panel.internalclass = GADGET_PANEL
	panel.parent = group
	panel.SetRect x,y,Width,Height	'setarea
	panel.style = style
	panel.font = TCocoaMaxGUIDriver.CocoaGUIFont
	
	If TNSGadget(group) Then
		panel.forceDisable = Not (TNSGadget(group).enabled And Not TNSGadget(group).forceDisable)
	EndIf
	
	'-----------------------------------------------------------------
	'this is where we call our own function to init the extended class
	Skn3PaintPanelInit(panel)
	'-----------------------------------------------------------------
	
	panel.name = Null
	GadgetMap.Insert TIntWrapper.Create(panel.handle),panel
	If panel.view And panel.handle <> panel.view Then GadgetMap.Insert TIntWrapper.Create(panel.view),panel
	
	panel.LockLayout()
	panel.SetEnabled(panel.enabled)
	panel.SetLayout(EDGE_CENTERED,EDGE_CENTERED,EDGE_CENTERED,EDGE_CENTERED)
	
	If group Then panel._SetParent group
	panel.LinkView
	
	Return panel
End Function

Function Skn3PaintPanelDrawRectCallback(Handle:Int)
	' --- incoming callback from the drawRect ---
	'we basically need to convert the handle into a paint panel before sending it to the generic callback emitter
	EmitPaintPanelCallback(Skn3PaintPanel(GadgetFromHandle(Handle)))
End Function

'bitmaps
Type Skn3PaintBitmap
	Field bitmap:Int
	Field Width:Int
	Field Height:Int
	
	Method Delete()
		If bitmap
			NSRelease(bitmap)
			bitmap = 0
		EndIf
	End Method
End Type

Function LoadPaintBitmap:Skn3PaintBitmap(url:Object)
	' --- load a new paintpanel bitmap ---
	Local bitmap:Skn3PaintBitmap = New Skn3PaintBitmap
	
	'check if we need to load a pixmap
	Local Pixmap:TPixmap = TPixmap(url)
	If Pixmap = Null Pixmap = LoadPixmap(url)
	If pixmap = Null Return Null
	
	'convert the pixmap into an nsimage
	Local x:Int
	Local y:Int
	
	Select pixmap.format
		Case PF_I8,PF_BGR888
			pixmap = pixmap.Convert( PF_RGB888 )
		Case PF_A8,PF_BGRA8888
			pixmap = pixmap.Convert( PF_RGBA8888 )
	End Select
	
	'premultiply alpha
	If AlphaBitsPerPixel[pixmap.format]
		For y = 0 Until pixmap.height
			For x = 0 Until pixmap.width
				pixmap.WritePixel(x,y,PreMultiplyAlpha(pixmap.ReadPixel(x,y)))
			Next
		Next
	EndIf
	
	'convert the pixmap into nsimage
	bitmap.bitmap = NSPixmapImage(pixmap)
	
	'save dimensions
	bitmap.Width = Pixmap.Width
	bitmap.Height = Pixmap.Height
	
	'return it
	Return bitmap
End Function