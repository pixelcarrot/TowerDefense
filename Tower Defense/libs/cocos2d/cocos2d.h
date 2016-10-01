/*
 * cocos2d for iPhone: http://www.cocos2d-iphone.org
 *
 * Copyright (c) 2008-2010 Ricardo Quesada
 * Copyright (c) 2011 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/** @mainpage cocos2d for iPhone API reference
 *
 * @image html Icon.png
 *
 * @section intro Introduction
 * This is cocos2d API reference
 *
 * The programming guide is hosted here: http://www.cocos2d-iphone.org/wiki/doku.php/prog_guide:index
 *
 * <hr>
 *
 * @todo A native English speaker should check the grammar. We need your help!
 *
 */

// 0x00 HI ME LO
// 00   02 01 00
#define COCOS2D_VERSION 0x00020100


//
// all cocos2d include files
//
#import "ccConfig.h"	// should be included first

#import "CCActionManager.h"
#import "CCAction.h"
#import "CCActionInstant.h"
#import "CCActionInterval.h"
#import "CCActionEase.h"
#import "CCActionCamera.h"
#import "CCActionTween.h"
#import "CCActionEase.h"
#import "CCActionTiledGrid.h"
#import "CCActionGrid3D.h"
#import "CCActionGrid.h"
#import "CCActionProgressTimer.h"
#import "CCActionPageTurn3D.h"
#import "CCActionCatmullRom.h"

#import "CCAnimation.h"
#import "CCAnimationCache.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "CCSpriteBatchNode.h"
#import "CCSpriteFrameCache.h"

#import "CCLabelTTF.h"
#import "CCLabelBMFont.h"
#import "CCLabelAtlas.h"

#import "CCParticleSystem.h"
#import "CCParticleSystemQuad.h"
#import "CCParticleExamples.h"
#import "CCParticleBatchNode.h"

#import "CCTexture2D.h"
#import "CCTexturePVR.h"
#import "CCTextureCache.h"
#import "CCTextureAtlas.h"

#import "CCTransition.h"
#import "CCTransitionPageTurn.h"
#import "CCTransitionProgress.h"

#import "CCTMXTiledMap.h"
#import "CCTMXLayer.h"
#import "CCTMXObjectGroup.h"
#import "CCTMXXMLParser.h"
#import "CCTileMapAtlas.h"

#import "CCLayer.h"
#import "CCMenu.h"
#import "CCMenuItem.h"
#import "CCDrawingPrimitives.h"
#import "CCScene.h"
#import "CCScheduler.h"
#import "CCCamera.h"
#import "CCProtocols.h"
#import "CCNode.h"
#import "CCNode+Debug.h"
#import "CCDirector.h"
#import "CCAtlasNode.h"
#import "CCGrabber.h"
#import "CCGrid.h"
#import "CCParallaxNode.h"
#import "CCRenderTexture.h"
#import "CCMotionStreak.h"
#import "CCConfiguration.h"
#import "CCDrawNode.h"
#import "CCClippingNode.h"

#import "ccFPSImages.h"

// Shaders
#import "CCGLProgram.h"
#import "ccGLStateCache.h"
#import "CCShaderCache.h"
#import "ccShaders.h"

// Physics integration
// Box2d integration should include these 2 files manually
#if CC_ENABLE_CHIPMUNK_INTEGRATION
#import CC_CHIPMUNK_IMPORT
#import "CCPhysicsSprite.h"
#import "CCPhysicsDebugNode.h"
#endif

//
// cocos2d macros
//
#import "ccTypes.h"
#import "ccMacros.h"

//
// Deprecated methods/classes/functions since v1.0
//
#import "ccDeprecated.h"

// Platform common
#import "Platforms/CCGL.h"
#import "Platforms/CCNS.h"

#ifdef __CC_PLATFORM_IOS
#import "Platforms/iOS/CCTouchDispatcher.h"
#import "Platforms/iOS/CCTouchDelegateProtocol.h"
#import "Platforms/iOS/CCTouchHandler.h"
#import "Platforms/iOS/CCGLView.h"
#import "Platforms/iOS/CCDirectorIOS.h"

#elif defined(__CC_PLATFORM_MAC)
#import "Platforms/Mac/CCGLView.h"
#import "Platforms/Mac/CCDirectorMac.h"
#import "Platforms/Mac/CCWindow.h"
#import "Platforms/Mac/CCEventDispatcher.h"
#endif

//
// cocos2d helper files
//
#import "Support/OpenGL_Internal.h"
#import "Support/CCFileUtils.h"
#import "Support/CGPointExtension.h"
#import "Support/ccCArray.h"
#import "Support/CCArray.h"
#import "Support/ccUtils.h"
#import "Support/TransformUtils.h"
#import "Support/CCProfiling.h"
#import "Support/NSThread+performBlock.h"
#import "Support/uthash.h"
#import "Support/utlist.h"

//
// external
//
#import "kazmath/kazmath.h"
#import "kazmath/GL/matrix.h"



#ifdef __cplusplus
extern "C" {
#endif

// free functions
NSString * cocos2dVersion(void);
extern const char * cocos2d_version;

#ifdef __cplusplus
}
#endif

	
#ifdef __CC_PLATFORM_IOS
#ifndef __IPHONE_4_0
#error "If you are targeting iPad, you should set BASE SDK = 4.0 (or 4.1, or 4.2), and set the 'iOS deploy target' = 3.2"
#endif
#endif

//! AliceBlue color (240,248,255)
static const ccColor3B ccALICEBLUE={240,248,255};
//! AntiqueWhite color (250,235,215)
static const ccColor3B ccANTIQUEWHITE={250,235,215};
//! Aqua color (0,255,255)
static const ccColor3B ccAQUA={0,255,255};
//! Aquamarine color (127,255,212)
static const ccColor3B ccAQUAMARINE={127,255,212};
//! Azure color (240,255,255)
static const ccColor3B ccAZURE={240,255,255};
//! Beige color (245,245,220)
static const ccColor3B ccBEIGE={245,245,220};
//! Bisque color (255,228,196)
static const ccColor3B ccBISQUE={255,228,196};
//! BlanchedAlmond color (255,235,205)
static const ccColor3B ccBLANCHEDALMOND={255,235,205};
//! BlueViolet color (138,43,226)
static const ccColor3B ccBLUEVIOLET={138,43,226};
//! Brown color (165,42,42)
static const ccColor3B ccBROWN={165,42,42};
//! BurlyWood color (222,184,135)
static const ccColor3B ccBURLYWOOD={222,184,135};
//! CadetBlue color (95,158,160)
static const ccColor3B ccCADETBLUE={95,158,160};
//! Chartreuse color (127,255,0)
static const ccColor3B ccCHARTREUSE={127,255,0};
//! Chocolate color (210,105,30)
static const ccColor3B ccCHOCOLATE={210,105,30};
//! Coral color (255,127,80)
static const ccColor3B ccCORAL={255,127,80};
//! CornflowerBlue color (100,149,237)
static const ccColor3B ccCORNFLOWERBLUE={100,149,237};
//! Cornsilk color (255,248,220)
static const ccColor3B ccCORNSILK={255,248,220};
//! Crimson color (220,20,60)
static const ccColor3B ccCRIMSON={220,20,60};
//! Cyan color (0,255,255)
static const ccColor3B ccCYAN={0,255,255};
//! DarkBlue color (0,0,139)
static const ccColor3B ccDARKBLUE={0,0,139};
//! DarkCyan color (0,139,139)
static const ccColor3B ccDARKCYAN={0,139,139};
//! DarkGoldenRod color (184,134,11)
static const ccColor3B ccDARKGOLDENROD={184,134,11};
//! DarkGray color (169,169,169)
static const ccColor3B ccDARKGRAY={169,169,169};
//! DarkGreen color (0,100,0)
static const ccColor3B ccDARKGREEN={0,100,0};
//! DarkKhaki color (189,183,107)
static const ccColor3B ccDARKKHAKI={189,183,107};
//! DarkMagenta color (139,0,139)
static const ccColor3B ccDARKMAGENTA={139,0,139};
//! DarkOliveGreen color (85,107,47)
static const ccColor3B ccDARKOLIVEGREEN={85,107,47};
//! Darkorange color (255,140,0)
static const ccColor3B ccDARKORANGE={255,140,0};
//! DarkOrchid color (153,50,204)
static const ccColor3B ccDARKORCHID={153,50,204};
//! DarkRed color (139,0,0)
static const ccColor3B ccDARKRED={139,0,0};
//! DarkSalmon color (233,150,122)
static const ccColor3B ccDARKSALMON={233,150,122};
//! DarkSeaGreen color (143,188,143)
static const ccColor3B ccDARKSEAGREEN={143,188,143};
//! DarkSlateBlue color (72,61,139)
static const ccColor3B ccDARKSLATEBLUE={72,61,139};
//! DarkSlateGray color (47,79,79)
static const ccColor3B ccDARKSLATEGRAY={47,79,79};
//! DarkTurquoise color (0,206,209)
static const ccColor3B ccDARKTURQUOISE={0,206,209};
//! DarkViolet color (148,0,211)
static const ccColor3B ccDARKVIOLET={148,0,211};
//! DeepPink color (255,20,147)
static const ccColor3B ccDEEPPINK={255,20,147};
//! DeepSkyBlue color (0,191,255)
static const ccColor3B ccDEEPSKYBLUE={0,191,255};
//! DimGray color (105,105,105)
static const ccColor3B ccDIMGRAY={105,105,105};
//! DodgerBlue color (30,144,255)
static const ccColor3B ccDODGERBLUE={30,144,255};
//! FireBrick color (178,34,34)
static const ccColor3B ccFIREBRICK={178,34,34};
//! FloralWhite color (255,250,240)
static const ccColor3B ccFLORALWHITE={255,250,240};
//! ForestGreen color (34,139,34)
static const ccColor3B ccFORESTGREEN={34,139,34};
//! Fuchsia color (255,0,255)
static const ccColor3B ccFUCHSIA={255,0,255};
//! Gainsboro color (220,220,220)
static const ccColor3B ccGAINSBORO={220,220,220};
//! GhostWhite color (248,248,255)
static const ccColor3B ccGHOSTWHITE={248,248,255};
//! Gold color (255,215,0)
static const ccColor3B ccGOLD={255,215,0};
//! GoldenRod color (218,165,32)
static const ccColor3B ccGOLDENROD={218,165,32};
//! GreenYellow color (173,255,47)
static const ccColor3B ccGREENYELLOW={173,255,47};
//! HoneyDew color (240,255,240)
static const ccColor3B ccHONEYDEW={240,255,240};
//! HotPink color (255,105,180)
static const ccColor3B ccHOTPINK={255,105,180};
//! IndianRed color (205,92,92)
static const ccColor3B ccINDIANRED={205,92,92};
//! Indigo color (75,0,130)
static const ccColor3B ccINDIGO={75,0,130};
//! Ivory color (255,255,240)
static const ccColor3B ccIVORY={255,255,240};
//! Khaki color (240,230,140)
static const ccColor3B ccKHAKI={240,230,140};
//! Lavender color (230,230,250)
static const ccColor3B ccLAVENDER={230,230,250};
//! LavenderBlush color (255,240,245)
static const ccColor3B ccLAVENDERBLUSH={255,240,245};
//! LawnGreen color (124,252,0)
static const ccColor3B ccLAWNGREEN={124,252,0};
//! LemonChiffon color (255,250,205)
static const ccColor3B ccLEMONCHIFFON={255,250,205};
//! LightBlue color (173,216,230)
static const ccColor3B ccLIGHTBLUE={173,216,230};
//! LightCoral color (240,128,128)
static const ccColor3B ccLIGHTCORAL={240,128,128};
//! LightCyan color (224,255,255)
static const ccColor3B ccLIGHTCYAN={224,255,255};
//! LightGoldenRodYellow color (250,250,210)
static const ccColor3B ccLIGHTGOLDENRODYELLOW={250,250,210};
//! LightGrey color (211,211,211)
static const ccColor3B ccLIGHTGREY={211,211,211};
//! LightGreen color (144,238,144)
static const ccColor3B ccLIGHTGREEN={144,238,144};
//! LightPink color (255,182,193)
static const ccColor3B ccLIGHTPINK={255,182,193};
//! LightSalmon color (255,160,122)
static const ccColor3B ccLIGHTSALMON={255,160,122};
//! LightSeaGreen color (32,178,170)
static const ccColor3B ccLIGHTSEAGREEN={32,178,170};
//! LightSkyBlue color (135,206,250)
static const ccColor3B ccLIGHTSKYBLUE={135,206,250};
//! LightSlateGray color (119,136,153)
static const ccColor3B ccLIGHTSLATEGRAY={119,136,153};
//! LightSteelBlue color (176,196,222)
static const ccColor3B ccLIGHTSTEELBLUE={176,196,222};
//! LightYellow color (255,255,224)
static const ccColor3B ccLIGHTYELLOW={255,255,224};
//! Lime color (0,255,0)
static const ccColor3B ccLIME={0,255,0};
//! LimeGreen color (50,205,50)
static const ccColor3B ccLIMEGREEN={50,205,50};
//! Linen color (250,240,230)
static const ccColor3B ccLINEN={250,240,230};
//! Maroon color (128,0,0)
static const ccColor3B ccMAROON={128,0,0};
//! MediumAquaMarine color (102,205,170)
static const ccColor3B ccMEDIUMAQUAMARINE={102,205,170};
//! MediumBlue color (0,0,205)
static const ccColor3B ccMEDIUMBLUE={0,0,205};
//! MediumOrchid color (186,85,211)
static const ccColor3B ccMEDIUMORCHID={186,85,211};
//! MediumPurple color (147,112,216)
static const ccColor3B ccMEDIUMPURPLE={147,112,216};
//! MediumSeaGreen color (60,179,113)
static const ccColor3B ccMEDIUMSEAGREEN={60,179,113};
//! MediumSlateBlue color (123,104,238)
static const ccColor3B ccMEDIUMSLATEBLUE={123,104,238};
//! MediumSpringGreen color (0,250,154)
static const ccColor3B ccMEDIUMSPRINGGREEN={0,250,154};
//! MediumTurquoise color (72,209,204)
static const ccColor3B ccMEDIUMTURQUOISE={72,209,204};
//! MediumVioletRed color (199,21,133)
static const ccColor3B ccMEDIUMVIOLETRED={199,21,133};
//! MidnightBlue color (25,25,112)
static const ccColor3B ccMIDNIGHTBLUE={25,25,112};
//! MintCream color (245,255,250)
static const ccColor3B ccMINTCREAM={245,255,250};
//! MistyRose color (255,228,225)
static const ccColor3B ccMISTYROSE={255,228,225};
//! Moccasin color (255,228,181)
static const ccColor3B ccMOCCASIN={255,228,181};
//! NavajoWhite color (255,222,173)
static const ccColor3B ccNAVAJOWHITE={255,222,173};
//! Navy color (0,0,128)
static const ccColor3B ccNAVY={0,0,128};
//! OldLace color (253,245,230)
static const ccColor3B ccOLDLACE={253,245,230};
//! Olive color (128,128,0)
static const ccColor3B ccOLIVE={128,128,0};
//! OliveDrab color (107,142,35)
static const ccColor3B ccOLIVEDRAB={107,142,35};
//! OrangeRed color (255,69,0)
static const ccColor3B ccORANGERED={255,69,0};
//! Orchid color (218,112,214)
static const ccColor3B ccORCHID={218,112,214};
//! PaleGoldenRod color (238,232,170)
static const ccColor3B ccPALEGOLDENROD={238,232,170};
//! PaleGreen color (152,251,152)
static const ccColor3B ccPALEGREEN={152,251,152};
//! PaleTurquoise color (175,238,238)
static const ccColor3B ccPALETURQUOISE={175,238,238};
//! PaleVioletRed color (216,112,147)
static const ccColor3B ccPALEVIOLETRED={216,112,147};
//! PapayaWhip color (255,239,213)
static const ccColor3B ccPAPAYAWHIP={255,239,213};
//! PeachPuff color (255,218,185)
static const ccColor3B ccPEACHPUFF={255,218,185};
//! Peru color (205,133,63)
static const ccColor3B ccPERU={205,133,63};
//! Pink color (255,192,203)
static const ccColor3B ccPINK={255,192,203};
//! Plum color (221,160,221)
static const ccColor3B ccPLUM={221,160,221};
//! PowderBlue color (176,224,230)
static const ccColor3B ccPOWDERBLUE={176,224,230};
//! Purple color (128,0,128)
static const ccColor3B ccPURPLE={128,0,128};
//! RosyBrown color (188,143,143)
static const ccColor3B ccROSYBROWN={188,143,143};
//! RoyalBlue color (65,105,225)
static const ccColor3B ccROYALBLUE={65,105,225};
//! SaddleBrown color (139,69,19)
static const ccColor3B ccSADDLEBROWN={139,69,19};
//! Salmon color (250,128,114)
static const ccColor3B ccSALMON={250,128,114};
//! SandyBrown color (244,164,96)
static const ccColor3B ccSANDYBROWN={244,164,96};
//! SeaGreen color (46,139,87)
static const ccColor3B ccSEAGREEN={46,139,87};
//! SeaShell color (255,245,238)
static const ccColor3B ccSEASHELL={255,245,238};
//! Sienna color (160,82,45)
static const ccColor3B ccSIENNA={160,82,45};
//! Silver color (192,192,192)
static const ccColor3B ccSILVER={192,192,192};
//! SkyBlue color (135,206,235)
static const ccColor3B ccSKYBLUE={135,206,235};
//! SlateBlue color (106,90,205)
static const ccColor3B ccSLATEBLUE={106,90,205};
//! SlateGray color (112,128,144)
static const ccColor3B ccSLATEGRAY={112,128,144};
//! Snow color (255,250,250)
static const ccColor3B ccSNOW={255,250,250};
//! SpringGreen color (0,255,127)
static const ccColor3B ccSPRINGGREEN={0,255,127};
//! SteelBlue color (70,130,180)
static const ccColor3B ccSTEELBLUE={70,130,180};
//! Tan color (210,180,140)
static const ccColor3B ccTAN={210,180,140};
//! Teal color (0,128,128)
static const ccColor3B ccTEAL={0,128,128};
//! Thistle color (216,191,216)
static const ccColor3B ccTHISTLE={216,191,216};
//! Tomato color (255,99,71)
static const ccColor3B ccTOMATO={255,99,71};
//! Turquoise color (64,224,208)
static const ccColor3B ccTURQUOISE={64,224,208};
//! Violet color (238,130,238)
static const ccColor3B ccVIOLET={238,130,238};
//! Wheat color (245,222,179)
static const ccColor3B ccWHEAT={245,222,179};
//! WhiteSmoke color (245,245,245)
static const ccColor3B ccWHITESMOKE={245,245,245};
//! YellowGreen color (154,205,50)
static const ccColor3B ccYELLOWGREEN={154,205,50};

