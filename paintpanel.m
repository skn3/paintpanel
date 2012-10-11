#import <skn3.mod/paintpanel.mod/paintpanel.h>

//extended PanelViewContent
@implementation Skn3PaintPanelViewContent
//constructor/destructor
-(id)initWithFrame:(NSRect)rect{
	//call chain
	self = [super initWithFrame:rect];
	
	//call self
	//create basic objects
	color1 = [[self colorFromIntsRed:0 green:0 blue:0] retain];
	color2 = [[self colorFromIntsRed:0 green:0 blue:0] retain];
	font = [NSFont systemFontOfSize:[NSFont systemFontSize]];
	
	//return self
	return self;
}

-(void)dealloc{
	// --- free stuffs ---
	//cleanup myself!
	if (path) { [path release]; }
	if (gradient) { [gradient release]; }
	if (backgroundColor) { [backgroundColor release]; }
	[color1 release];
	[color2 release];
	
	//null stuff
	panel = nil;
	path = nil;
	color1 = nil;
	color2 = nil;
	backgroundColor = nil;
	
	//call chain
	[super dealloc];
}

//api
-(NSColor*)colorFromIntsRed:(int)red green:(int)green blue:(int)blue {
	// --- convert ints to float colors NSColor ---
	return [NSColor colorWithCalibratedRed:(1.0f/255.0f)*red green:(1.0f/255.0f)*green blue:(1.0f/255.0f)*blue alpha:1.0f];
}

-(void)drawRect:(NSRect)rect {
	// --- painting the gadget ---
	//flag painting
	painting = YES;
	
	//paint background
	if (backgroundColor) {
		[backgroundColor set];
		NSRectFill(rect);
	}
	
	//emit callback at blitz code
	skn3_paintpanel_Skn3PaintPanelDrawRectCallback(panel);
	
	//flag painting off
	painting = NO;
}

-(void)setPaintBackground:(int)r g:(int)g b:(int)b {
	// --- change background style ---
	if (r == -1 || g == -1 || b == -1) {
		//no color
		if (backgroundColor != nil) {
			[backgroundColor release];
			backgroundColor = nil;
		}
			
	} else {
		//yes, has color
		//release old one
		if (backgroundColor != nil) {
			[backgroundColor release];
			backgroundColor = nil;
		}
		
		//create new one
		backgroundColor = [[self colorFromIntsRed:r green:g blue:b] retain];
	}
}

-(void)setPaintColor:(int)r1 g1:(int)g1 b1:(int)b1 r2:(int)r2 g2:(int)g2 b2:(int)b2 {
	// --- change painting colors ---
	//color 1
	if (r1 != -1 && g1 != -1 && b1 != -1) {
		//release old
		if (color1) { [color1 release]; }
		
		//create new
		color1 = [[self colorFromIntsRed:r1 green:g1 blue:b1] retain];
	}
	
	//color 2
	if (r2 != -1 && g2 != -1 && b2 != -1) {
		//release old
		if (color2) { [color2 release]; }
		
		//create new
		color2 = [[self colorFromIntsRed:r2 green:g2 blue:b2] retain];
	}
}

-(void)setPaintFont:(NSFont*)newFont style:(int)Style {
	// --- change painting font ---
	if (newFont) { font = newFont; }
}

-(void)paintLine:(int)x1 y1:(int)y1 x2:(int)x2 y2:(int)y2 width:(int)width {
	// --- paint a line ---
	//make sure painting
	if (painting == NO) { return; }
	
	//create bezier if it does not exist
	if (path == nil) { path = [[NSBezierPath alloc] init]; }

	//set line width
	[path setLineWidth: width];

	//create points
	NSPoint startPoint = {  x1, y1 };
	NSPoint endPoint = { x2,y2 };

	//draw the path movement
	[path  moveToPoint: startPoint];
	[path lineToPoint: endPoint];
	[color1 set];
	[path stroke];

	//clean up points
	[path removeAllPoints];
}

-(void)paintGradient:(int)x y:(int)y width:(int)width height:(int)height vertical:(int)vertical {
	// --- paint a gradient rectangle ---
	//make sure painting
	if (painting == NO) { return; }
	
	//free old gradient
	if (gradient) { [gradient release]; }
	
	//creat enew gradient
	gradient = [[NSGradient alloc] initWithStartingColor:color1 endingColor:color2];
	
	//draw the gradient
	if (vertical) {
		[gradient drawInRect:NSMakeRect(x,y,width,height) angle:90.0];
	} else {
		[gradient drawInRect:NSMakeRect(x,y,width,height) angle:0.0];
	}
}

-(void)paintRect:(int)x y:(int)y width:(int)width height:(int)height {
	// --- paint a rect ---
	//make sure painting
	if (painting == NO) { return; }
	
	[color1 set];
	NSRectFill(NSMakeRect(x,y,width,height));
}

-(void)paintOval:(int)x y:(int)y width:(int)width height:(int)height {
	// --- paint a oval ---
	//make sure painting
	if (painting == NO) { return; }
	
	//create bezier if it does not exist
	if (path == nil) { path = [[NSBezierPath alloc] init]; }
	
	//create shape
	[path appendBezierPathWithOvalInRect:NSMakeRect(x,y,width,height)];
	
	//draw the path
	[color1 set];
	[path fill];
	
	//clean up points
	[path removeAllPoints];
}

-(BBArray *)paintText:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height wrap:(int)wrap hAlign:(int)hAlign vAlign:(int)vAlign {
	// --- paint some text ---
	BBArray *result = bbArrayNew1D("i",4);
	int *resultPointer = (int*)BBARRAYDATA(result,1);
	resultPointer[0] = 0;
	resultPointer[1] = 0;
	resultPointer[2] = 0;
	resultPointer[3] = 0;
	
	//make sure painting
	if (painting == NO) { return result; }
	
	//this should be moved out of here at some point
	NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:color1, NSForegroundColorAttributeName, font, NSFontAttributeName,nil];
	
	//get content size
	NSSize maxSize;
	if (wrap == 0 || width == 0) {
		maxSize = NSMakeSize(0.0,0.0);
	} else {
		maxSize = NSMakeSize(width,0.0);
	}
	NSRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingDisableScreenFontSubstitution attributes:textAttributes];
	
	if (width == 0) { width = rect.size.width; }
	if (height == 0) { height = rect.size.height; }
	
	//align content position
	switch(hAlign) {
		case 0:
			//left
			rect.origin.x = x;
			break;
		case 1:
			//center
			rect.origin.x = x+(width/2)-(rect.size.width/2);
			break;
		case 2:
			//right
			rect.origin.x = x+width-rect.size.width;;
			break;
	}
	
	switch(vAlign) {
		case 0:
			//top
			rect.origin.y = y;
			break;
		case 1:
			//center
			rect.origin.y = y+(height/2)-(rect.size.height/2);
			break;
		case 2:
			//bottom
			rect.origin.y = y+height-rect.size.height;;
			break;
	}
	
	//draw
	[text drawInRect:rect withAttributes:textAttributes];
	
	//now return the dimensions as a blitz array
	resultPointer[0] = (int)rect.origin.x;
	resultPointer[1] = (int)rect.origin.y;
	resultPointer[2] = (int)rect.size.width;
	resultPointer[3] = (int)rect.size.height;
	return result;
}

-(BBArray *)paintTextDimensions:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height wrap:(int)wrap hAlign:(int)hAlign vAlign:(int)vAlign {
	// --- paint some text ---
	BBArray *result = bbArrayNew1D("i",4);
	int *resultPointer = (int*)BBARRAYDATA(result,1);

	//this should be moved out of here at some point
	NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:color1, NSForegroundColorAttributeName, font, NSFontAttributeName,nil];
	
	//get content size
	NSSize maxSize;
	if (wrap == 0 || width == 0) {
		maxSize = NSMakeSize(0.0,0.0);
	} else {
		maxSize = NSMakeSize(width,0.0);
	}
	NSRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingDisableScreenFontSubstitution attributes:textAttributes];
	
	if (width == 0) { width = rect.size.width; }
	if (height == 0) { height = rect.size.height; }
	
	//align content position
	switch(hAlign) {
		case 0:
			//left
			rect.origin.x = x;
			break;
		case 1:
			//center
			rect.origin.x = x+(width/2)-(rect.size.width/2);
			break;
		case 2:
			//right
			rect.origin.x = x+width-rect.size.width;;
			break;
	}
	
	switch(vAlign) {
		case 0:
			//top
			rect.origin.y = y;
			break;
		case 1:
			//center
			rect.origin.y = y+(height/2)-(rect.size.height/2);
			break;
		case 2:
			//bottom
			rect.origin.y = y+height-rect.size.height;;
			break;
	}
	
	//now return the dimensions as a blitz array
	resultPointer[0] = (int)rect.origin.x;
	resultPointer[1] = (int)rect.origin.y;
	resultPointer[2] = (int)rect.size.width;
	resultPointer[3] = (int)rect.size.height;
	return result;
}

-(void)paintBitmap:(NSImage*)image x:(int)x y:(int)y {
	// --- paint a bitmap ---
	//make sure painting and valid
	if (painting == NO || image == nil) { return; }
	
	//prepare image
	[image setFlipped:YES];
	
	//draw image
	[image drawAtPoint:NSMakePoint(x,y) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0f];
}

-(void)paintSubBitmap:(NSImage*)image x:(int)x y:(int)y width:(int)width height:(int)height sourceX:(int)sourceX sourceY:(int)sourceY sourceWidth:(int)sourceWidth sourceHeight:(int)sourceHeight{
	// --- paint a portion of the image ---
	//make sure painting and valid
	if (painting == NO || image == nil) { return; }
	
	//figure out sizes
	if (sourceWidth == -1) { sourceWidth = image.size.width-sourceX; }
	if (sourceHeight == -1) { sourceHeight = image.size.height-sourceY; }

	//prepare image
	[image setFlipped:YES];
	
	//draw image
	[image drawInRect:NSMakeRect(x,y,width,height) fromRect:NSMakeRect(sourceX,sourceY,sourceWidth,sourceHeight) operation:NSCompositeSourceOver fraction:1.0f];
}
@end

//GLUE GLUE GLUE !!!
void Skn3PaintPanelInit(nsgadget *gadget) {
	NSRect 				rect,vis;
	NSView				*view;
	PanelView			*panel;
	Skn3PaintPanelViewContent	*pnlcontent;
	nsgadget			*group;
	int 				style,flags;
	
	rect=NSMakeRect(gadget->x,gadget->y,gadget->w,gadget->h);
	style=gadget->style;flags=0;
	group=gadget->group;
	if (group==(nsgadget*)&bbNullObject) group=0;
	if (group) view=gadget->group->view;
	
	switch (gadget->internalclass){
		case GADGET_PANEL:
			panel=[[PanelView alloc] initWithFrame:rect];
			[panel setContentViewMargins:NSMakeSize(0.0,0.0)];
			pnlcontent = [[Skn3PaintPanelViewContent alloc] initWithFrame:[[panel contentView] frame]];
			pnlcontent->panel = panel;
			
			[pnlcontent setAutoresizesSubviews:NO];
			[panel setContentView:pnlcontent];
			[panel setGadget:gadget];
			[panel setStyle:style];
			[panel setEnabled:true];
			[pnlcontent setAlpha:1.0];
			if (view) [view addSubview:panel];
			gadget->view=pnlcontent;
			gadget->handle=panel;
			break;
	}

}

void Skn3PaintPanelSetPaintBackground(nsgadget *gadget,int r,int g,int b) {
	[gadget->view setPaintBackground:r g:g b:b];
}

void Skn3PaintPanelSetPaintColor(nsgadget *gadget,int r1,int g1,int b1,int r2,int g2,int b2) {
	[gadget->view setPaintColor:r1 g1:g1 b1:b1 r2:r2 g2:g2 b2:b2];
}

void Skn3PaintPanelSetPaintFont(nsgadget *gadget,NSFont *font,int style) {
	[gadget->view setPaintFont:font style:style];
}

void Skn3PaintPanelPaintLine(nsgadget *gadget,int x1,int y1, int x2, int y2,int width) {
	[gadget->view paintLine:x1 y1:y1 x2:x2 y2:y2 width:width];
}

void Skn3PaintPanelPaintGradient(nsgadget *gadget,int x,int y, int width, int height,int vertical) {
	[gadget->view paintGradient:x y:y width:width height:height vertical:vertical];
}

void Skn3PaintPanelPaintRect(nsgadget *gadget,int x,int y, int width, int height) {
	[gadget->view paintRect:x y:y width:width height:height];
}

void Skn3PaintPanelPaintOval(nsgadget *gadget,int x,int y, int width, int height) {
	[gadget->view paintOval:x y:y width:width height:height];
}

BBArray * Skn3PaintPanelPaintText(nsgadget *gadget,BBString *text,int x,int y,int width,int height,int wrap,int hAlign,int vAlign) {
	[gadget->view paintText:[NSString stringWithCString:bbStringToCString(text)] x:x y:y width:width height:height wrap:wrap hAlign:hAlign vAlign:vAlign];
}

void Skn3PaintPanelPaintBitmap(nsgadget *gadget,NSImage *image,int x,int y) {
	[gadget->view paintBitmap:image x:x y:y];
}

void Skn3PaintPanelPaintSubBitmap(nsgadget *gadget,NSImage *image,int x,int y,int width,int height,int sourceX,int sourceY,int sourceWidth,int sourceHeight) {
	[gadget->view paintSubBitmap:image x:x y:y width:width height:height sourceX:sourceX sourceY:sourceY sourceWidth:sourceWidth sourceHeight:sourceHeight];
}
