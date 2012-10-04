ModuleInfo "History: 1.01"
ModuleInfo "History: Mac version done"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release To Public"
import brl.blitz
import brl.linkedlist
import brl.pixmap
import maxgui.drivers
ALIGN_LEFT%=0
ALIGN_CENTER%=1
ALIGN_RIGHT%=2
ALIGN_TOP%=0
ALIGN_BOTTOM%=2
Skn3PaintPanel^maxgui.win32maxguiex.TWindowsPanel{
.painting%&
.paintingX%&
.paintingY%&
.paintingWidth%&
.paintingHeight%&
.deviceContext%&
.oldPen%&
.oldBrush%&
.oldFont%&
.oldBitmap%&
.buffer%&
.bufferWidth%&
.bufferHeight%&
.backgroundColor%&[]&
.backgroundColorBrush%&
.color1%&[]&
.color1RGB%&
.color1Brush%&
.color2%&[]&
.color2RGB%&
.color2Brush%&
.pen%&
.penColor%&[]&
.penWidth%&
.font:maxgui.maxgui.TGuiFont&
-New%()="_skn3_paintpanel_Skn3PaintPanel_New"
-Delete%()="_skn3_paintpanel_Skn3PaintPanel_Delete"
-Free%()="_skn3_paintpanel_Skn3PaintPanel_Free"
-WndProc%(hwnd%,MSG%,wp%,lp%)="_skn3_paintpanel_Skn3PaintPanel_WndProc"
-SelectPen%(Handle%)="_skn3_paintpanel_Skn3PaintPanel_SelectPen"
-SelectBrush%(Handle%)="_skn3_paintpanel_Skn3PaintPanel_SelectBrush"
-SelectFont%(Handle%)="_skn3_paintpanel_Skn3PaintPanel_SelectFont"
-SelectBitmap%(Handle%)="_skn3_paintpanel_Skn3PaintPanel_SelectBitmap"
-SetPaintBackground%(r%=-1,g%=-1,B%=-1)="_skn3_paintpanel_Skn3PaintPanel_SetPaintBackground"
-SetPaintColor%(r1%,g1%,b1%,r2%=-1,g2%=-1,b2%=-1)="_skn3_paintpanel_Skn3PaintPanel_SetPaintColor"
-SetPaintFont%(font:maxgui.maxgui.TGuiFont)="_skn3_paintpanel_Skn3PaintPanel_SetPaintFont"
-PaintGradient%(x%,y%,Width%,Height%,vertical%=1)="_skn3_paintpanel_Skn3PaintPanel_PaintGradient"
-PaintRect%(x%,y%,Width%,Height%)="_skn3_paintpanel_Skn3PaintPanel_PaintRect"
-PaintLine%(x1%,y1%,x2%,y2%,width%=1)="_skn3_paintpanel_Skn3PaintPanel_PaintLine"
-PaintOval%(x%,y%,Width%,Height%)="_skn3_paintpanel_Skn3PaintPanel_PaintOval"
-PaintPoint%(x%,y%)="_skn3_paintpanel_Skn3PaintPanel_PaintPoint"
-PaintText%(text$,x%,y%,Width%=0,Height%=0,wrap%=0,hAlign%=0,vAlign%=0)="_skn3_paintpanel_Skn3PaintPanel_PaintText"
-PaintBitmap%(bitmap:Skn3PaintBitmap,x%,y%)="_skn3_paintpanel_Skn3PaintPanel_PaintBitmap"
-PaintSubBitmap%(bitmap:Skn3PaintBitmap,x%,y%,Width%,Height%,sourceX%=0,sourceY%=0,sourceWidth%=-1,sourceHeight%=-1)="_skn3_paintpanel_Skn3PaintPanel_PaintSubBitmap"
}="skn3_paintpanel_Skn3PaintPanel"
CreatePaintPanel:Skn3PaintPanel(x%,y%,Width%,Height%,group:maxgui.maxgui.TGadget,Style%=0)="skn3_paintpanel_CreatePaintPanel"
Skn3PaintBitmap^brl.blitz.Object{
.bitmap%&
.Width%&
.Height%&
.hasAlpha%&
-New%()="_skn3_paintpanel_Skn3PaintBitmap_New"
-Delete%()="_skn3_paintpanel_Skn3PaintBitmap_Delete"
}="skn3_paintpanel_Skn3PaintBitmap"
LoadPaintBitmap:Skn3PaintBitmap(url:Object)="skn3_paintpanel_LoadPaintBitmap"
