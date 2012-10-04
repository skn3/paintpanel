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
Skn3PaintPanel^TNSGadget{
-New%()="_skn3_paintpanel_Skn3PaintPanel_New"
-Delete%()="_skn3_paintpanel_Skn3PaintPanel_Delete"
-SetPaintBackground%(r%=-1,g%=-1,b%=-1)="_skn3_paintpanel_Skn3PaintPanel_SetPaintBackground"
-SetPaintColor%(r1%=-1,g1%=-1,b1%=-1,r2%=-1,g2%=-1,b2%=-1)="_skn3_paintpanel_Skn3PaintPanel_SetPaintColor"
-SetPaintFont%(baseFont:TGuiFont)="_skn3_paintpanel_Skn3PaintPanel_SetPaintFont"
-PaintLine%(x1%,y1%,x2%,y2%,width%)="_skn3_paintpanel_Skn3PaintPanel_PaintLine"
-PaintGradient%(x%,y%,width%,height%,vertical%=1)="_skn3_paintpanel_Skn3PaintPanel_PaintGradient"
-PaintRect%(x%,y%,width%,height%)="_skn3_paintpanel_Skn3PaintPanel_PaintRect"
-PaintOval%(x%,y%,width%,height%)="_skn3_paintpanel_Skn3PaintPanel_PaintOval"
-PaintPoint%(x%,y%)="_skn3_paintpanel_Skn3PaintPanel_PaintPoint"
-PaintText%(text$,x%,y%,width%=0,height%=0,wrap%=0,hAlign%=0,vAlign%=0)="_skn3_paintpanel_Skn3PaintPanel_PaintText"
-PaintBitmap%(bitmap:Skn3PaintBitmap,x%,y%)="_skn3_paintpanel_Skn3PaintPanel_PaintBitmap"
-PaintSubBitmap%(bitmap:Skn3PaintBitmap,x%,y%,Width%,Height%,sourceX%=0,sourceY%=0,sourceWidth%=-1,sourceHeight%=-1)="_skn3_paintpanel_Skn3PaintPanel_PaintSubBitmap"
}="skn3_paintpanel_Skn3PaintPanel"
CreatePaintPanel:Skn3PaintPanel(x%,y%,width%,height%,group:TGadget,Style%=0)="skn3_paintpanel_CreatePaintPanel"
Skn3PaintPanelDrawRectCallback%(Handle%)="skn3_paintpanel_Skn3PaintPanelDrawRectCallback"
Skn3PaintBitmap^Object{
.bitmap%&
.Width%&
.Height%&
-New%()="_skn3_paintpanel_Skn3PaintBitmap_New"
-Delete%()="_skn3_paintpanel_Skn3PaintBitmap_Delete"
}="skn3_paintpanel_Skn3PaintBitmap"
LoadPaintBitmap:Skn3PaintBitmap(url:Object)="skn3_paintpanel_LoadPaintBitmap"
