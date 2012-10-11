Private
Extern "Win32"
	Function CreatePen(Style:Int,w:Int,color:Int)
	Function MoveToEx(hdc:Int,x:Int,y:Int,point:Int)
	Function LineTo(hdc:Int,x:Int,y:Int)
	Function SetTextColor(hdc:Int,color:Int)
	Function Ellipse(hdc:Int,leftRect:Int,topRect:Int,rightRect:Int,bottomRect:Int)
	Function SetPixel(hdc:Int,x:Int,y:Int,color:Int)
End Extern

Const PS_SOLID:Int = 0

Public

Rem
bbdoc: A maxgui panel that recieves EVENT_GADGETPAINT and provides an api for painting
about:
<span style="color:red;">If you are not on windows then please just ignore the fact it extends TWindowsPanel.</span><br />
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>The gadget will fire a EVENT_GADGETPAINT when it needs to be repainted. You can hook into this using normal maxgui event hooking methods.</p>
End Rem
Type Skn3PaintPanel Extends TWindowsPanel
	Field painting:Int
	Field paintingX:Int
	Field paintingY:Int
	Field paintingWidth:Int
	Field paintingHeight:Int
	
	Field deviceContext:Int
	
	Field oldPen:Int
	Field oldBrush:Int
	Field oldFont:Int
	Field oldBitmap:Int
	
	Field buffer:Int
	Field bufferWidth:Int
	Field bufferHeight:Int

	Field backgroundColor:Int[] = [-1,-1,-1]
	Field backgroundColorBrush:Int
	
	Field color1:Int[] = [-1,-1,-1]
	Field color1RGB:Int
	Field color1Brush:Int
	Field color2:Int[] = [-1,-1,-1]
	Field color2RGB:Int
	Field color2Brush:Int
	
	Field pen:Int
	Field penColor:Int[] = [-1,-1,-1]
	Field penWidth:Int
	
	Field font:TGuiFont
	
	'constructor/destructor
	Method Free()
		' --- free resources ---
		If backgroundColorBrush DeleteObject(backgroundColorBrush)
		If color1Brush DeleteObject(color1Brush)
		If color2Brush DeleteObject(color2Brush)
		If pen DeleteObject(pen)
		font = Null
		
		'call chain
		Super.Free()
	EndMethod
	
	'maxgui
	Method WndProc:Int(hwnd:Int,MSG:Int,wp:Int,lp:Int)
		' --- check for instant skip
		Select MSG
			Case WM_ERASEBKGND
				'this is custom render time
				deviceContext = wp
				
				'get update rect
				Local clientRect:Int[4], UpdateRect:Int[4], clipRect:Int[4], windowRect:Int[4]
				GetClipBox( deviceContext, clipRect )
				GetWindowRect( hwnd, windowRect)
				GetClientRect( hwnd, clientRect )
				If Not GetUpdateRect( hwnd, UpdateRect, False) UpdateRect = clipRect
				If IsRectEmpty(UpdateRect) UpdateRect = [0,0,windowRect[2]-windowRect[0],windowRect[3]-windowRect[1]]
				
				paintingX = UpdateRect[0]
				paintingY = UpdateRect[1]
				paintingWidth = UpdateRect[2]-UpdateRect[0]
				paintingHeight = UpdateRect[3]-UpdateRect[1]
				
				'create a double buffer
				bufferWidth = clientRect[2]-clientRect[0]
				bufferHeight = clientRect[3]-clientRect[1]
				
				If (hwnd <> _hwndclient) '(dunno why this if exists)
					deviceContext = CreateCompatibleDC(wp)
					buffer = CreateCompatibleBitmap(wp,windowRect[2]-windowRect[0],windowRect[3]-windowRect[1])
					SelectObject(deviceContext,buffer)
				EndIf
				
				'paint gadget background
				If backgroundColorBrush
					'draw a solid color
					FillRect(deviceContext,UpdateRect,backgroundColorBrush)
				Else
					'no background so to fake transparency we draw the parents background
					DrawParentBackground(deviceContext,hwnd)
				EndIf
				
				'make sure there are color brushes created
				If color1Brush = 0 And color2brush = 0
					SetPaintColor(0,0,0,0,0,0)
				ElseIf color1Brush = 0
					SetPaintColor(0,0,0)
				ElseIf color2Brush = 0
					SetPaintColor(-1,-1,-1,0,0,0)
				EndIf
				
				'callback for custom drawing
				painting = True
				EmitPaintPanelCallback(Self)
				painting = False
				
				'composite the drawing
				If _alpha < 1.0
					'render parent first
					DrawParentBackground( wp, hwnd )
					
					'alpha blend buffer on top
					Local blendfunction:Int = ((Int(_alpha*255)&$FF) Shl 16)
					AlphaBlend_(wp,updateRect[0],updateRect[1],updateRect[2]-updateRect[0],updateRect[3]-updateRect[1],deviceContext,updateRect[0],updateRect[1],updateRect[2]-updateRect[0],updateRect[3]-updateRect[1],blendfunction)
				Else
					'just draw solid buffer on top
					BitBlt(wp,0,0,windowRect[2]-windowRect[0],windowRect[3]-windowRect[1],deviceContext,0,0,ROP_SRCCOPY)
				EndIf
				
				'select old objects
				If oldPen SelectPen(oldPen)
				If oldBrush SelectPen(oldBrush)
				If oldFont SelectPen(oldFont)
				If oldBitmap SelectPen(oldBitmap)
				oldPen = 0
				oldBrush = 0
				oldFont = 0
				oldBitmap = 0
				
				'cleanup double buffer
				If buffer DeleteObject( buffer )
				DeleteDC(deviceContext)
				
				'clean up context
				deviceContext = 0
				buffer = 0
				
				'return code to block painting by previous
				Return 1
		End Select
		
		'call default behaviour
		Return Super.WndProc(hwnd,MSG,wp,lp)
	End Method
	
	'internal
	Method SelectPen(Handle:Int)
		' --- select a pen into context ---
		Local oldHandle:Int = SelectObject(deviceContext,Handle)
		If oldPen = 0
			oldPen = oldHandle
		ElseIf oldPen = Handle
			oldPen = 0
		EndIf
	End Method
	
	Method SelectBrush(Handle:Int)
		' --- select a brush into context ---
		Local oldHandle:Int = SelectObject(deviceContext,Handle)
		If oldBrush = 0
			oldBrush = oldHandle
		ElseIf oldBrush = Handle
			oldBrush = 0
		EndIf
	End Method
		
	Method SelectFont(Handle:Int)
		' --- select a font into context ---
		Local oldHandle:Int = SelectObject(deviceContext,Handle)
		If oldFont = 0
			oldFont = oldHandle
		ElseIf oldFont = Handle
			oldFont = 0
		EndIf
	End Method
	
	Method SelectBitmap(Handle:Int)
		' --- select a bitmap into context ---
		Local oldHandle:Int = SelectObject(deviceContext,Handle)
		If oldBitmap = 0
			oldBitmap = oldHandle
		ElseIf oldBitmap = Handle
			oldBitmap = 0
		EndIf
	End Method
	
	'paint set api
Rem
bbdoc: Change panel cls color.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will set the panels background/cls color use (-1,-1,-1) to set transparent.</p>
End Rem
	Method SetPaintBackground(r:Int=-1,g:Int=-1,B:Int=-1)
		' --- set paint background DUH ---
		If r <> backgroundColor[0] Or g <> backgroundColor[1] Or B <> backgroundColor[2]
			backgroundColor[0] = r
			backgroundColor[1] = g
			backgroundColor[2] = B
		
			'free old color brush
			If backgroundColorBrush
				DeleteObject(backgroundColorBrush)
				backgroundColorBrush = 0
			EndIf
			
			'create new color brush
			If backgroundColor[0] <> -1 And backgroundColor[1] <> -1 And backgroundColor[2] <> -1 backgroundColorBrush = CreateSolidBrush((backgroundColor[2] Shl 16) | (backgroundColor[1] Shl 8) | backgroundColor[0])
		EndIf
	End Method

Rem
bbdoc: Set painting color.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>The last three params let you modify teh secondary painting color. The secondary painting color is used for operations that require two colors, such as gradients. If you pass -1,-1,-1 for either color then no modifications to that color will occur.
End Rem	
	Method SetPaintColor(r1:Int,g1:Int,b1:Int,r2:Int=-1,g2:Int=-1,b2:Int=-1)
		' --- change painting colors ---
		'color 1
		If r1 <> color1[0] Or g1 <> color1[1] Or b1 <> color1[2] And r1 <> -1 And g1 <> -1 And b1 <> -1
			color1[0] = r1
			color1[1] = g1
			color1[2] = b1
			color1RGB = (color1[2] Shl 16) | (color1[1] Shl 8) | color1[0]
			
			'remove old brush
			If color1Brush
				DeleteObject(color1Brush)
				color1Brush = 0
			EndIf
			
			'create new brush
			color1Brush = CreateSolidBrush((color1[2] Shl 16) | (color1[1] Shl 8) | color1[0])
		EndIf
		
		'color 2
		If r2 <> color2[0] Or g2 <> color2[1] Or b2 <> color2[2] And r2 <> -1 And g2 <> -1 And b2 <> -1
			color2[0] = r2
			color2[1] = g2
			color2[2] = b2
			color2RGB = (color2[2] Shl 16) | (color2[1] Shl 8) | color2[0]
			
			'remove old brush
			If color2Brush
				DeleteObject(color2Brush)
				color2Brush = 0
			EndIf
			
			'create new brush
			color2Brush = CreateSolidBrush((color2[2] Shl 16) | (color2[1] Shl 8) | color2[0])
		EndIf
	End Method

Rem
bbdoc: change the font used for text paint operations.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This uses the maxgui font objects see #LoadGuiFont or #LookupGuiFont</p>
End Rem	
	Method SetPaintFont(font:TGuiFont)
		' --- change the painting font ---
		If font <> Self.font Self.font = font
	End Method
	
	'paint PAINT api
Rem
bbdoc: Paint a rectangle gradient.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>Use #SetPaintColor to modify the start and finish gradient colors.</p>
End Rem
	Method PaintGradient(x:Int,y:Int,Width:Int,Height:Int,vertical:Int=True)
		' --- draw a gradient rect ---
		'make sure painting
		If painting = False Return
	
		Local previousBrush:Int
		
		Local gradientPosition:Int
		Local gradientBrush:Int
		Local gradientRect:Int[4]
		Local gradientR:Float
		Local gradientG:Float
		Local gradientB:Float
		Local gradientStepR:Float
		Local gradientStepG:Float
		Local gradientStepB:Float
		
		'which direction
		If vertical
			'get update step
			gradientStepR = Float(color2[0] - color1[0]) / Height
			gradientStepG = Float(color2[1] - color1[1]) / Height
			gradientStepB = Float(color2[2] - color1[2]) / Height
			
			'iterate gradient
			gradientR = color1[0]
			gradientG = color1[1]
			gradientB = color1[2]
			
			gradientRect[0] = x
			gradientRect[1] = y
			gradientRect[2] = x+Width
			gradientRect[3] = y
			
			For gradientPosition = 0 Until Height
				'create color brush
				gradientBrush = CreateSolidBrush((Int(gradientB) Shl 16) | (Int(gradientG) Shl 8) | Int(gradientR))
				previousBrush = SelectObject(deviceContext,gradientBrush)
				
				'update drawing rect
				gradientRect[1] = y+gradientPosition
				gradientRect[3] = y+gradientPosition+1
				
				'fill the color
				FillRect(deviceContext,gradientRect,gradientBrush)
				
				'remove color brush
				SelectObject(deviceContext,previousBrush)
				DeleteObject(gradientBrush)
				
				'increase gradient counters
				gradientR :+ gradientStepR
				gradientG :+ gradientStepG
				gradientB :+ gradientStepB
			Next
		Else
		EndIf
	End Method

Rem
bbdoc: Paint a solid rectangle..
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will paint a rectangle with the current painting color.</p>
End Rem	
	Method PaintRect(x:Int,y:Int,Width:Int,Height:Int)
		' --- draw a solid rect ---
		'make sure painting
		If painting = False Return
		
		Local rect:Int[] = [x,y,x+Width,y+Height]
		
		FillRect(deviceContext,rect,color1Brush)
	End Method

Rem
bbdoc: Paint a line with variable width.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will paint a line between two points using the current color. You can specify an optional width with the last param.</p>
End Rem	
	Method PaintLine(x1:Int,y1:Int,x2:Int,y2:Int,width:Int=1)
		' --- draw a line ---
		'make sure painting
		If painting = False Return
		
		'do we need to create a new pen
		If pen = 0 Or width <> penWidth Or penColor[0] <> color1[0] Or penColor[1] <> color1[1] Or penColor[2] <> color1[2]
			penColor[0] = color1[0]
			penColor[1] = color1[1]
			penColor[2] = color1[2]
			penWidth = width
		
			'delete old pen
			If pen DeleteObject(pen)
			
			'create new pen
			pen = CreatePen(PS_SOLID,penWidth,color1RGB)
		EndIf
		
		'paint the line with the pen
		SelectPen(pen)
		MoveToEx(deviceContext,x1,y1,0)
		LineTo(deviceContext,x2,y2)
	End Method

Rem
bbdoc: Paint an oval/ellipse.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will paint an oval/ellipse using the current color.</p>
End Rem	
	Method PaintOval(x:Int,y:Int,Width:Int,Height:Int)
		' --- render an oval ---
		'make sure painting
		If painting = False Return
		
		SelectBrush(color1Brush)
		SelectPen(GetStockObject(NULL_PEN))
		Ellipse(deviceContext,x,y,x+Width,y+Height)		
	End Method

Rem
bbdoc: Paint a pixel/point.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will paint a single pixel/point using the current color.</p>
End Rem	
	Method PaintPoint(x:Int,y:Int)
		' --- render a pixel ---
		'make sure painting
		If painting = False Return
		
		SetPixel(deviceContext,x,y,color1RGB)
	End Method

Rem
bbdoc: Draw text on a single line or wrapped in a box.
returns: an array containing x,y,width,height for the drawn text. This will return a blank array [0,0,0,0] if you are not currently in a painting event.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will let you render text in teh current color using various options.</p>
<p><b>Drawing on a single line similar to DrawText()</b><br />To do this simply call PaintText("hello world",x,y)</p>
<p><b>Drawing aligned text</b><br />You can align a line of text within a box by providing width, height and alignment params. To draw a single line of text in teh center of an area you would call PaintText("hello world",0,0,200,200,false,ALIGN_CENTER,ALIGN_CENTER)</p>
<p><b>Drawing wrapped text</b><br />If you need to wrap your text then provide the width and wrap params. You can also specify alignment values and the function will align the entire block of text.</p>
End Rem	
	Method PaintText:Int[](text:String,x:Int,y:Int,Width:Int=0,Height:Int=0,wrap:Int=False,hAlign:Int=0,vAlign:Int=0)
		' --- render text ---
		'make sure painting
		If painting = False Return [0,0,0,0]
		
		Local rect:Int[4]
		
		'set the correct font
		If font SelectFont(font.Handle)
		
		'calculate content dimensions
		Local contentX:Int
		Local contentY:Int
		Local contentWidth:Int
		Local contentHeight:Int
		rect[0] = 0
		rect[1] = 0
		rect[2] = Width
		rect[3] = 0
		
		'text rect flags
		Local calcStyle:Int = DT_CALCRECT | DT_NOCLIP
		If Width > 0 And wrap calcStyle :| DT_WORDBREAK
			
		'calculate the size and alignment
		DrawTextW(deviceContext,text,-1,rect,calcStyle)
		
		contentWidth = rect[2]
		contentHeight = rect[3]
		
		If Width = 0 Width = contentWidth
		If Height = 0 Height = contentHeight
		
		Select hAlign
			Case 0
				contentX = 0
			Case 1
				contentX = (Width /2) - (contentWidth/2)
			Case 2
				contentX = Width - contentWidth
		End Select
		
		Select vAlign
			Case 0
				contentY = 0
			Case 1
				contentY = (Height/2) - (contentHeight/2)
			Case 2
				contentY = Height-contentHeight
		End Select
		
		'build style
		Local Style:Int = DT_LEFT | DT_TOP
		If wrap = False
			Style :| DT_SINGLELINE
		Else
			Style :| DT_WORDBREAK
		EndIf
		
		'draw it
		rect[0] = x+contentX
		rect[1] = y+contentY
		rect[2] = rect[0]+contentWidth
		rect[3] = rect[1]+contentHeight
		SetBkMode(deviceContext,TRANSPARENT)
		.SetTextColor(deviceContext,color1RGB)
		DrawTextW(deviceContext,text,-1,rect,Style)
		
		'return it
		Return rect
	End Method
	
Rem
bbdoc: Get the dimensions for the given text using the panels current font.
returns: an array containing x,y,width,height for the drawn text.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will let you get teh dimensions for the given text. See #PaintText for further details about the params.</p>
End Rem	
	Method PaintTextDimensions:Int[](text:String,x:Int=0,y:Int=0,Width:Int=0,Height:Int=0,wrap:Int=False,hAlign:Int=0,vAlign:Int=0)
		' --- get dimensions for text ---
		Local rect:Int[4]
		
		'get the device context we are using
		Local hwnd:Int
		Local deviceContext:Int = Self.deviceContext
		If deviceContext = 0
			hwnd = QueryGadget(Self,QUERY_HWND)
			deviceContext = GetDC(hwnd)
		EndIf
		
		'set the correct font
		If font SelectFont(font.Handle)
		
		'calculate content dimensions
		rect[0] = 0
		rect[1] = 0
		rect[2] = Width
		rect[3] = 0

		Local calcStyle:Int = DT_CALCRECT | DT_NOCLIP
		If Width > 0 And wrap calcStyle :| DT_WORDBREAK
		DrawTextW(deviceContext,text,-1,rect,calcStyle)
		
		'align it
		Local contentX:Int
		Local contentY:Int
		Local contentWidth:Int = rect[2]
		Local contentHeight:Int = rect[3]
		If Width = 0 Width = contentWidth
		If Height = 0 Height = contentHeight
		
		Select hAlign
			Case 0
				contentX = 0
			Case 1
				contentX = (Width /2) - (contentWidth/2)
			Case 2
				contentX = Width - contentWidth
		End Select
		
		Select vAlign
			Case 0
				contentY = 0
			Case 1
				contentY = (Height/2) - (contentHeight/2)
			Case 2
				contentY = Height-contentHeight
		End Select
		
		'release stuff
		If Self.deviceContext = 0 ReleaseDC(hwnd,deviceContext)
		
		'return it
		rect[0] = x+contentX
		rect[1] = y+contentY
		rect[2] = rect[0]+contentWidth
		rect[3] = rect[1]+contentHeight
		Return rect
	End Method

Rem
bbdoc: Paint a whole bitmap at given location.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will paint a a bitmap at the given location. See #LoadPaintBitmap to load a bitmap.</p>
End Rem		
	Method PaintBitmap(bitmap:Skn3PaintBitmap,x:Int,y:Int)
		' --- paint a bitmap onto the gadget ---
		'this just calls the sub bitmap func
		PaintSubBitmap(bitmap,x,y,bitmap.Width,bitmap.Height,0,0,bitmap.Width,bitmap.Height)
	End Method
	
Rem
bbdoc: Paint part of a bitmap stretched.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will allow you to paint part of a bitmap at the given location and dimensions. See #LoadPaintBitmap to load a bitmap.</p>
End Rem		
	Method PaintSubBitmap(bitmap:Skn3PaintBitmap,x:Int,y:Int,Width:Int,Height:Int,sourceX:Int=0,sourceY:Int=0,sourceWidth:Int=-1,sourceHeight:Int=-1)
		' --- paint PART of a bitmap onto the gadget --- 
		'make sure painting and valid
		If painting = False Or bitmap = Null Return		
		
		'create a dc with this bitmap in
		Local hdcBitmap:Int = CreateCompatibleDC(deviceContext)
		Local oldBitmap:Int = SelectObject(hdcBitmap,bitmap.bitmap)
		
		'do auto sizes for source dimensions
		If sourceWidth = -1 Or sourceHeight = -1
			sourceWidth = bitmap.Width - sourceX
			sourceHeight = bitmap.Height - sourceY
		EndIf
		
		'paint it
		If bitmap.hasAlpha
			AlphaBlend_(deviceContext,x,y,Width,Height,hdcBitmap,sourceX,sourceY,sourceWidth,sourceHeight,$01ff0000)
		Else
			If sourceX = 0 And sourceY = 0 And sourceWidth = Width And sourceHeight = Height
				'no stretch
				BitBlt(deviceContext,x,y,bitmap.Width,bitmap.Height,hdcBitmap,0,0,ROP_SRCCOPY)
			Else
				'stretch
				StretchBlt(deviceContext,x,y,Width,Height,hdcBitmap,sourceX,sourceY,sourceWidth,sourceHeight,ROP_SRCCOPY)
			EndIf
		EndIf
		
		'free it
		SelectObject(hdcBitmap,oldBitmap)
		DeleteDC(hdcBitmap)
	End Method
End Type

Rem
bbdoc: Create a new Skn3PaintPanel gadget.
returns: Skn3PaintPanel gadget.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>This will create a new paintpanel gadget. The gadget can be treated like any other maxgui gadget</p>
<p>Make sure you call RedrawGadget(panel1) after the gadget is created and after your eventhook is setup.
End Rem	
Function CreatePaintPanel:Skn3PaintPanel(x:Int,y:Int,Width:Int,Height:Int,group:TGadget,Style:Int=0)
	' --- create a new panel ex gadget ---
	'fix group
	group = GetCreationGroup(group)
	
	'these bits of code are ripped and tweaked versions of maxgui functions.
	'they simply inject some additional stuff in at the right moment.
	'code ripped/modified from win32maxguiex
	Local panel:TGadget = New Skn3PaintPanel.Create(group,Style)
	
	If group Then panel._setparent group
	panel.SetShape(x,y,Width,Height)
	
	'v0.51: Gadgets are now only shown when they have been sized, and the text set.
	If TWindowsGadget(panel) Then
		panel.SetFont(TWindowsGUIDriver.GDIFont)
		If TWindowsGadget(group) Then
			TWindowsGadget(panel)._forceDisable = Not( TWindowsGadget(group)._enabled And Not TWindowsGadget(group)._forceDisable )
			panel.SetEnabled(Not (panel.State()&STATE_DISABLED))
		EndIf
		panel.SetShow(True)
	EndIf
	
	If TWindowsGadget(panel) Then TWindowsGadget(panel).Sensitize()
	
	'return it
	Return Skn3PaintPanel(panel)
End Function

'bitmaps
Type Skn3PaintBitmap
	Field bitmap:Int
	Field Width:Int
	Field Height:Int
	Field hasAlpha:Int
	
	Method Delete()
		If bitmap
			DeleteObject(bitmap)
			bitmap = 0
		EndIf
	End Method
End Type

Rem
bbdoc: Load a bitmap from file or existing pixmap for use with the paintpanel.
returns: nothing.
about:
<b>Supported Platforms</b>
<ul>
	<li>Windows</li>
	<li>Mac</li>
</ul>
<b>Info</b>
<p>You must load images that you want to use on a paintpanel using this function and not blitz built in Image functions. Url can be any valid blitzmax url providing you have enbalbed the apropriate modules.</p>
End Rem	
Function LoadPaintBitmap:Skn3PaintBitmap(url:Object)
	' --- load a new paintpanel bitmap ---
	Local bitmap:Skn3PaintBitmap = New Skn3PaintBitmap
	
	'check if we need to load a pixmap
	Local Pixmap:TPixmap = TPixmap(url)
	If Pixmap = Null Pixmap = LoadPixmap(url)
	If pixmap = Null Return Null
	
	'prepare the pixmap premultiplied
	If Pixmap.format = PF_RGBA8888 Or Pixmap.format = PF_BGRA8888 bitmap.bitmap = TWindowsGraphic.PreMultipliedBitmapFromPixmap32(Pixmap)
	
	'check for non multiplied or fail
	If bitmap.bitmap
		bitmap.hasAlpha = True
	Else
		bitmap.bitmap = TWindowsGraphic.BitmapFromPixmap(Pixmap,False)
		bitmap.hasAlpha = False
	EndIf
	
	'save dimensions
	bitmap.Width = Pixmap.Width
	bitmap.Height = Pixmap.Height
	
	'return it
	Return bitmap
End Function
