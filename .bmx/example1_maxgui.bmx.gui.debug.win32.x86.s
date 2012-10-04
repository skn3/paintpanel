	format	MS COFF
	extrn	___bb_appstub_appstub
	extrn	___bb_audio_audio
	extrn	___bb_basic_basic
	extrn	___bb_blitz_blitz
	extrn	___bb_bmploader_bmploader
	extrn	___bb_d3d7max2d_d3d7max2d
	extrn	___bb_d3d9max2d_d3d9max2d
	extrn	___bb_data_data
	extrn	___bb_directsoundaudio_directsoundaudio
	extrn	___bb_eventqueue_eventqueue
	extrn	___bb_freeaudioaudio_freeaudioaudio
	extrn	___bb_freejoy_freejoy
	extrn	___bb_freeprocess_freeprocess
	extrn	___bb_freetypefont_freetypefont
	extrn	___bb_glew_glew
	extrn	___bb_gnet_gnet
	extrn	___bb_jpgloader_jpgloader
	extrn	___bb_macos_macos
	extrn	___bb_maxlua_maxlua
	extrn	___bb_maxutil_maxutil
	extrn	___bb_oggloader_oggloader
	extrn	___bb_openalaudio_openalaudio
	extrn	___bb_paintpanel_paintpanel
	extrn	___bb_pngloader_pngloader
	extrn	___bb_retro_retro
	extrn	___bb_tgaloader_tgaloader
	extrn	___bb_threads_threads
	extrn	___bb_timer_timer
	extrn	___bb_wavloader_wavloader
	extrn	_bbEnd
	extrn	_bbFloatToInt
	extrn	_bbNullObject
	extrn	_bbObjectDowncast
	extrn	_bbOnDebugEnterScope
	extrn	_bbOnDebugEnterStm
	extrn	_bbOnDebugLeaveScope
	extrn	_bbSin
	extrn	_bbStringClass
	extrn	_brl_blitz_NullObjectError
	extrn	_brl_event_EmitEventHook
	extrn	_brl_event_TEvent
	extrn	_brl_eventqueue_WaitEvent
	extrn	_brl_hook_AddHook
	extrn	_maxgui_maxgui_CreateWindow
	extrn	_maxgui_maxgui_LookupGuiFont
	extrn	_maxgui_maxgui_RedrawGadget
	extrn	_maxgui_maxgui_SetGadgetLayout
	extrn	_skn3_paintpanel_CreatePaintPanel
	extrn	_skn3_paintpanel_LoadPaintBitmap
	public	__bb_main
	public	_bb_EventHook
	public	_bb_Window
	public	_bb_bitmap1
	public	_bb_panel1
	section	"code" code
__bb_main:
	push	ebp
	mov	ebp,esp
	push	ebx
	cmp	dword [_72],0
	je	_73
	mov	eax,0
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_73:
	mov	dword [_72],1
	push	ebp
	push	_64
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	call	___bb_blitz_blitz
	call	___bb_paintpanel_paintpanel
	call	___bb_appstub_appstub
	call	___bb_audio_audio
	call	___bb_basic_basic
	call	___bb_bmploader_bmploader
	call	___bb_d3d7max2d_d3d7max2d
	call	___bb_d3d9max2d_d3d9max2d
	call	___bb_data_data
	call	___bb_directsoundaudio_directsoundaudio
	call	___bb_eventqueue_eventqueue
	call	___bb_freeaudioaudio_freeaudioaudio
	call	___bb_freetypefont_freetypefont
	call	___bb_gnet_gnet
	call	___bb_jpgloader_jpgloader
	call	___bb_maxlua_maxlua
	call	___bb_maxutil_maxutil
	call	___bb_oggloader_oggloader
	call	___bb_openalaudio_openalaudio
	call	___bb_pngloader_pngloader
	call	___bb_retro_retro
	call	___bb_tgaloader_tgaloader
	call	___bb_threads_threads
	call	___bb_timer_timer
	call	___bb_wavloader_wavloader
	call	___bb_freejoy_freejoy
	call	___bb_freeprocess_freeprocess
	call	___bb_glew_glew
	call	___bb_macos_macos
	push	_42
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [_45]
	and	eax,1
	cmp	eax,0
	jne	_46
	push	515
	push	_bbNullObject
	push	500
	push	800
	push	0
	push	0
	push	_1
	call	_maxgui_maxgui_CreateWindow
	add	esp,28
	inc	dword [eax+4]
	mov	dword [_bb_Window],eax
	or	dword [_45],1
_46:
	push	_47
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [_45]
	and	eax,2
	cmp	eax,0
	jne	_49
	push	0
	push	dword [_bb_Window]
	push	300
	push	400
	push	15
	push	15
	call	_skn3_paintpanel_CreatePaintPanel
	add	esp,24
	inc	dword [eax+4]
	mov	dword [_bb_panel1],eax
	or	dword [_45],2
_49:
	push	_50
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	push	1
	push	1
	push	1
	push	dword [_bb_panel1]
	call	_maxgui_maxgui_SetGadgetLayout
	add	esp,20
	push	_51
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_53
	call	_brl_blitz_NullObjectError
_53:
	push	128
	push	128
	push	128
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+596]
	add	esp,16
	push	_54
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_56
	call	_brl_blitz_NullObjectError
_56:
	push	0
	fld	qword [_164]
	sub	esp,8
	fstp	qword [esp]
	push	1
	call	_maxgui_maxgui_LookupGuiFont
	add	esp,16
	push	eax
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+604]
	add	esp,8
	push	_57
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [_45]
	and	eax,4
	cmp	eax,0
	jne	_59
	push	_27
	call	_skn3_paintpanel_LoadPaintBitmap
	add	esp,4
	inc	dword [eax+4]
	mov	dword [_bb_bitmap1],eax
	or	dword [_45],4
_59:
	push	_60
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	_bbNullObject
	push	_bb_EventHook
	push	dword [_brl_event_EmitEventHook]
	call	_brl_hook_AddHook
	add	esp,16
	push	_61
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	dword [_bb_panel1]
	call	_maxgui_maxgui_RedrawGadget
	add	esp,4
	push	_62
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
_30:
_28:
	push	_63
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_brl_eventqueue_WaitEvent
	jmp	_30
_bb_EventHook:
	push	ebp
	mov	ebp,esp
	sub	esp,32
	push	ebx
	push	esi
	push	edi
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	mov	eax,dword [ebp+12]
	mov	dword [ebp-8],eax
	mov	eax,dword [ebp+16]
	mov	dword [ebp-12],eax
	mov	dword [ebp-16],_bbNullObject
	mov	dword [ebp-20],0
	mov	eax,ebp
	push	eax
	push	_154
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_74
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_brl_event_TEvent
	push	dword [ebp-8]
	call	_bbObjectDowncast
	add	esp,8
	mov	dword [ebp-16],eax
	push	_76
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	cmp	dword [ebp-16],_bbNullObject
	je	_77
	push	_78
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-16]
	cmp	ebx,_bbNullObject
	jne	_80
	call	_brl_blitz_NullObjectError
_80:
	mov	eax,dword [ebx+8]
	cmp	eax,16387
	je	_83
	cmp	eax,8194
	je	_84
	jmp	_82
_83:
	push	_85
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bbEnd
	jmp	_82
_84:
	push	_86
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-16]
	cmp	ebx,_bbNullObject
	jne	_88
	call	_brl_blitz_NullObjectError
_88:
	mov	eax,dword [ebx+12]
	cmp	eax,dword [_bb_panel1]
	je	_91
	jmp	_90
_91:
	push	_92
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_94
	call	_brl_blitz_NullObjectError
_94:
	push	0
	push	255
	push	0
	push	0
	push	0
	push	255
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_95
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_97
	call	_brl_blitz_NullObjectError
_97:
	push	1
	push	50
	push	50
	push	5
	push	5
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+608]
	add	esp,24
	push	_98
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_100
	call	_brl_blitz_NullObjectError
_100:
	push	-1
	push	-1
	push	-1
	push	0
	push	0
	push	0
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_101
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_103
	call	_brl_blitz_NullObjectError
_103:
	push	5
	push	10
	push	300
	push	100
	push	100
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+616]
	add	esp,24
	push	_104
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_106
	call	_brl_blitz_NullObjectError
_106:
	push	-1
	push	-1
	push	-1
	push	255
	push	0
	push	0
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_107
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_109
	call	_brl_blitz_NullObjectError
_109:
	push	32
	push	32
	push	100
	push	5
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+612]
	add	esp,20
	push	_110
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_112
	call	_brl_blitz_NullObjectError
_112:
	push	-1
	push	-1
	push	-1
	push	0
	push	0
	push	0
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_113
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_115
	call	_brl_blitz_NullObjectError
_115:
	push	0
	push	0
	push	1
	push	0
	push	200
	push	10
	push	10
	push	_31
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+628]
	add	esp,36
	push	_116
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_118
	call	_brl_blitz_NullObjectError
_118:
	push	-1
	push	-1
	push	-1
	push	0
	push	255
	push	0
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_119
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_121
	call	_brl_blitz_NullObjectError
_121:
	push	0
	push	0
	push	1
	push	0
	push	200
	push	9
	push	9
	push	_31
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+628]
	add	esp,36
	push	_122
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_124
	call	_brl_blitz_NullObjectError
_124:
	push	-1
	push	-1
	push	-1
	push	0
	push	128
	push	255
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_125
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	edi,dword [_bb_panel1]
	cmp	edi,_bbNullObject
	jne	_127
	call	_brl_blitz_NullObjectError
_127:
	mov	esi,dword [_bb_panel1]
	cmp	esi,_bbNullObject
	jne	_129
	call	_brl_blitz_NullObjectError
_129:
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_131
	call	_brl_blitz_NullObjectError
_131:
	push	1
	push	1
	push	1
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+224]
	add	esp,4
	push	eax
	push	esi
	mov	eax,dword [esi]
	call	dword [eax+220]
	add	esp,4
	push	eax
	push	0
	push	0
	push	_31
	push	edi
	mov	eax,dword [edi]
	call	dword [eax+628]
	add	esp,36
	push	_132
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_134
	call	_brl_blitz_NullObjectError
_134:
	push	-1
	push	-1
	push	-1
	push	128
	push	0
	push	0
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_135
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_137
	call	_brl_blitz_NullObjectError
_137:
	push	90
	push	60
	push	150
	push	200
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+620]
	add	esp,20
	push	_138
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_140
	call	_brl_blitz_NullObjectError
_140:
	push	-1
	push	-1
	push	-1
	push	0
	push	0
	push	0
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+600]
	add	esp,28
	push	_141
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	dword [ebp-20],0
	mov	dword [ebp-20],0
	jmp	_143
_34:
	push	_144
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_146
	call	_brl_blitz_NullObjectError
_146:
	fld	qword [_173]
	fstp	qword [ebp-28]
	mov	eax,dword [ebp-20]
	imul	eax,20
	mov	dword [ebp+-32],eax
	fild	dword [ebp+-32]
	sub	esp,8
	fstp	qword [esp]
	call	_bbSin
	add	esp,8
	fld	qword [_174]
	fmulp	st1,st0
	fld	qword [ebp-28]
	faddp	st1,st0
	fstp	qword [ebp-28]
	fld	qword [ebp-28]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	push	eax
	mov	eax,dword [ebp-20]
	add	eax,200
	push	eax
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+624]
	add	esp,12
_32:
	add	dword [ebp-20],1
_143:
	cmp	dword [ebp-20],100
	jl	_34
_33:
	push	_147
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_149
	call	_brl_blitz_NullObjectError
_149:
	push	50
	push	50
	push	dword [_bb_bitmap1]
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+632]
	add	esp,16
	push	_150
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [_bb_panel1]
	cmp	ebx,_bbNullObject
	jne	_152
	call	_brl_blitz_NullObjectError
_152:
	push	-1
	push	-1
	push	0
	push	0
	push	64
	push	128
	push	200
	push	20
	push	dword [_bb_bitmap1]
	push	ebx
	mov	eax,dword [ebx]
	call	dword [eax+636]
	add	esp,40
	jmp	_90
_90:
	jmp	_82
_82:
_77:
	push	_153
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-8]
	jmp	_40
_40:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
	section	"data" data writeable align 8
	align	4
_72:
	dd	0
_65:
	db	"example1_maxgui",0
_66:
	db	"Window",0
_67:
	db	":maxgui.maxgui.TGadget",0
	align	4
_bb_Window:
	dd	_bbNullObject
_68:
	db	"panel1",0
_69:
	db	":skn3.paintpanel.Skn3PaintPanel",0
	align	4
_bb_panel1:
	dd	_bbNullObject
_70:
	db	"bitmap1",0
_71:
	db	":skn3.paintpanel.Skn3PaintBitmap",0
	align	4
_bb_bitmap1:
	dd	_bbNullObject
	align	4
_64:
	dd	1
	dd	_65
	dd	4
	dd	_66
	dd	_67
	dd	_bb_Window
	dd	4
	dd	_68
	dd	_69
	dd	_bb_panel1
	dd	4
	dd	_70
	dd	_71
	dd	_bb_bitmap1
	dd	0
_43:
	db	"D:/dev/projects/blitzmax/modules/skn3.mod/paintpanel.mod/example1_maxgui.bmx",0
	align	4
_42:
	dd	_43
	dd	3
	dd	1
	align	4
_45:
	dd	0
	align	4
_1:
	dd	_bbStringClass
	dd	2147483647
	dd	0
	align	4
_47:
	dd	_43
	dd	6
	dd	1
	align	4
_50:
	dd	_43
	dd	7
	dd	1
	align	4
_51:
	dd	_43
	dd	8
	dd	1
	align	4
_54:
	dd	_43
	dd	9
	dd	1
	align	8
_164:
	dd	0x0,0x40240000
	align	4
_57:
	dd	_43
	dd	12
	dd	1
	align	4
_27:
	dd	_bbStringClass
	dd	2147483647
	dd	9
	dw	115,108,105,109,101,46,112,110,103
	align	4
_60:
	dd	_43
	dd	15
	dd	1
	align	4
_61:
	dd	_43
	dd	18
	dd	1
	align	4
_62:
	dd	_43
	dd	23
	dd	1
	align	4
_63:
	dd	_43
	dd	22
	dd	2
_155:
	db	"EventHook",0
_156:
	db	"id",0
_157:
	db	"i",0
_158:
	db	"data",0
_159:
	db	":Object",0
_160:
	db	"conitemText",0
_161:
	db	"event",0
_162:
	db	":brl.event.TEvent",0
_163:
	db	"index",0
	align	4
_154:
	dd	1
	dd	_155
	dd	2
	dd	_156
	dd	_157
	dd	-4
	dd	2
	dd	_158
	dd	_159
	dd	-8
	dd	2
	dd	_160
	dd	_159
	dd	-12
	dd	2
	dd	_161
	dd	_162
	dd	-16
	dd	2
	dd	_163
	dd	_157
	dd	-20
	dd	0
	align	4
_74:
	dd	_43
	dd	27
	dd	2
	align	4
_76:
	dd	_43
	dd	30
	dd	2
	align	4
_78:
	dd	_43
	dd	31
	dd	3
	align	4
_85:
	dd	_43
	dd	33
	dd	5
	align	4
_86:
	dd	_43
	dd	36
	dd	5
	align	4
_92:
	dd	_43
	dd	38
	dd	7
	align	4
_95:
	dd	_43
	dd	39
	dd	7
	align	4
_98:
	dd	_43
	dd	40
	dd	7
	align	4
_101:
	dd	_43
	dd	41
	dd	7
	align	4
_104:
	dd	_43
	dd	42
	dd	7
	align	4
_107:
	dd	_43
	dd	43
	dd	7
	align	4
_110:
	dd	_43
	dd	45
	dd	7
	align	4
_113:
	dd	_43
	dd	46
	dd	7
	align	4
_31:
	dd	_bbStringClass
	dd	2147483647
	dd	84
	dw	104,101,108,108,111,32,119,111,114,108,100,32,116,104,105,115
	dw	32,105,115,32,97,32,108,111,110,103,101,114,32,112,105,101
	dw	99,101,32,111,102,32,116,101,120,116,32,108,101,116,115,32
	dw	115,101,101,32,119,104,97,116,32,104,97,112,112,101,110,115
	dw	32,110,111,119,44,32,105,116,32,115,104,111,117,108,100,32
	dw	119,114,97,112
	align	4
_116:
	dd	_43
	dd	47
	dd	7
	align	4
_119:
	dd	_43
	dd	48
	dd	7
	align	4
_122:
	dd	_43
	dd	50
	dd	7
	align	4
_125:
	dd	_43
	dd	51
	dd	7
	align	4
_132:
	dd	_43
	dd	53
	dd	7
	align	4
_135:
	dd	_43
	dd	54
	dd	7
	align	4
_138:
	dd	_43
	dd	57
	dd	7
	align	4
_141:
	dd	_43
	dd	58
	dd	7
	align	4
_144:
	dd	_43
	dd	59
	dd	8
	align	8
_173:
	dd	0x0,0x40540000
	align	8
_174:
	dd	0x0,0x40340000
	align	4
_147:
	dd	_43
	dd	62
	dd	7
	align	4
_150:
	dd	_43
	dd	63
	dd	7
	align	4
_153:
	dd	_43
	dd	69
	dd	2
