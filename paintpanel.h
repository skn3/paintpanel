#import <maxgui.mod/cocoamaxgui.mod/cocoa.macos.m>
#import <maxgui.mod/maxgui.mod/maxgui.h>
#import <pub.mod/macos.mod/macos.h>

@interface Skn3PaintPanelViewContent:PanelViewContent{
	BOOL painting;
	PanelView *panel;
	NSBezierPath *path;
	NSColor *backgroundColor;
	NSColor *color1;
	NSColor *color2;
	NSGradient *gradient;
	NSFont *font;
}
-(id)initWithFrame:(NSRect)rect;
-(void)dealloc;
-(NSColor*)colorFromIntsRed:(int)red green:(int)green blue:(int)blue;
-(void)drawRect:(NSRect)rect;
-(void)setPaintBackground:(int)r g:(int)g b:(int)b;
-(void)setPaintColor:(int)r1 g1:(int)g1 b1:(int)b1 r2:(int)r2 g2:(int)g2 b2:(int)b2;
-(void)setPaintFont:(NSFont*)newFont style:(int)Style;
-(void)paintLine:(int)x1 y1:(int)y1 x2:(int)x2 y2:(int)y2 width:(int)width;
-(void)paintGradient:(int)x y:(int)y width:(int)width height:(int)height vertical:(int)vertical;
-(void)paintRect:(int)x y:(int)y width:(int)width height:(int)height;
-(void)paintOval:(int)x y:(int)y width:(int)width height:(int)height;
-(BBArray *)paintText:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height wrap:(int)wrap hAlign:(int)hAlign vAlign:(int)vAlign;
-(BBArray *)paintTextDimensions:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height wrap:(int)wrap hAlign:(int)hAlign vAlign:(int)vAlign;
-(void)paintBitmap:(NSImage*)image x:(int)x y:(int)y;
-(void)paintSubBitmap:(NSImage*)image x:(int)x y:(int)y width:(int)width height:(int)height sourceX:(int)sourceX sourceY:(int)sourceY sourceWidth:(int)sourceWidth sourceHeight:(int)sourceHeight;
@end

void skn3_paintpanel_Skn3PaintPanelDrawRectCallback(void *handle);

void Skn3PaintPanelInit(nsgadget *gadget);
void skn3PaintPanelSetPaintBackground(nsgadget *gadget,int r,int g, int b);
void Skn3PaintPanelSetPaintColor(nsgadget *gadget,int r1,int g1,int b1,int r2,int g2,int b2);
void Skn3PaintPanelSetPaintFont(nsgadget *gadget,NSFont *font,int style);
void Skn3PaintPanelPaintLine(nsgadget *gadget,int x1,int y1, int x2, int y2,int width);
void Skn3PaintPanelPaintGradient(nsgadget *gadget,int x,int y, int width, int height,int vertical);
void Skn3PaintPanelPaintRect(nsgadget *gadget,int x,int y, int width, int height);
void Skn3PaintPanelPaintOval(nsgadget *gadget,int x,int y, int width, int height);
BBArray * Skn3PaintPanelPaintText(nsgadget *gadget,BBString *text,int x,int y,int width,int height,int wrap,int hAlign,int vAlign);
BBArray * Skn3PaintPanelPaintTextDimensions(nsgadget *gadget,BBString *text,int x,int y,int width,int height,int wrap,int hAlign,int vAlign);
void Skn3PaintPanelPaintBitmap(nsgadget *gadget,NSImage *image,int x,int y);
void Skn3PaintPanelPaintSubBitmap(nsgadget *gadget,NSImage *image,int x,int y,int width,int height,int sourceX,int sourceY,int sourceWidth,int sourceHeight);