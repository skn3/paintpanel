Import skn3.paintpanel

Global Window:TGadget = CreateWindow("",0,0,800,500,Null,WINDOW_TITLEBAR | WINDOW_CENTER | WINDOW_RESIZABLE)

'create panel
Global panel1:Skn3PaintPanel = CreatePaintPanel(15,15,400,300,window)
SetGadgetLayout(panel1,EDGE_ALIGNED,EDGE_ALIGNED,EDGE_ALIGNED,EDGE_ALIGNED)
panel1.SetPaintBackground(128,128,128)
panel1.SetPaintFont(LookupGuiFont(GUIFONT_SYSTEM,10))

'load a bitmap
Global bitmap1:Skn3PaintBitmap = LoadPaintBitmap("slime.png")

'add event hook
AddHook(EmitEventHook,EventHook)

'finalise with repaint of the gadget
RedrawGadget(panel1)

'main program
Repeat
	WaitEvent()
Forever

'event hook
Function EventHook:Object(id:Int,data:Object,conitemText:Object)
	Local event:TEvent = TEvent(data)
	
	'check valid event
	If event
		Select event.id
			Case EVENT_WINDOWCLOSE
				End
				
			Case EVENT_GADGETPAINT
				Select event.source
					Case panel1
						panel1.SetPaintColor(255,0,0,0,255,0)
						panel1.PaintGradient(5,5,50,50,True)
						panel1.SetPaintColor(0,0,0)
						panel1.PaintLine(100,100,300,10,5)
						panel1.SetPaintColor(0,0,255)
						panel1.PaintRect(5,100,32,32)
						
						panel1.SetPaintColor(0,0,0)
						panel1.PaintText("hello world this is a longer piece of text lets see what happens now, it should wrap",10,10,200,0,True)
						panel1.SetPaintColor(0,255,0)
						panel1.PaintText("hello world this is a longer piece of text lets see what happens now, it should wrap",9,9,200,0,True)
						
						panel1.SetPaintColor(255,128,0)
						panel1.PaintText("hello world this is a longer piece of text lets see what happens now, it should wrap",0,0,panel1.ClientWidth(),panel1.ClientHeight(),True,ALIGN_CENTER,ALIGN_CENTER)						
		
						panel1.SetPaintColor(0,0,128)
						panel1.PaintOval(200,150,60,90)
						
						'draw a sine wave
						panel1.SetPaintColor(0,0,0)
						For Local index:Int = 0 Until 100
							panel1.PaintPoint(200+index,80+(Sin(index*20)*20))
						Next
													
						panel1.PaintBitmap(bitmap1,50,50)
						panel1.PaintSubBitmap(bitmap1,20,200,128,64)
				End Select
		End Select
	EndIf
	
	'return
	Return data
EndFunction


