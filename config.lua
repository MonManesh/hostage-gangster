_imageQuality = 'SD' — "SD"/"HD"
_buildType = 'debug' — "debug"/"release"
_serverType = 'local' — "local"/"global/iran/test"
_storeType = 'bazar' — "sibche"/"bazar"/"appstore"/"google"/"cando"...
_mainLang = 'fa' — "en"/"fa"
_supportEmail = 'hello@fruitcraft.co' --"hello@fruitcraft.ir/hello@fruitcraft.com
_webSite = 'fruitcraft.co'
_ignoresDeviceLang = true -- set to true for sibche builds since persian isn't a system language
_crossPromotionsEnabled = true -- we need to wait for Tap for Tap and AppRever to crete updates for their crap to fix their bugs before we can enable this.
_analyticsEnabled = true
_isWinter = false



local imgSuffix = {}
if _imageQuality == "HD" then
 imgSuffix["@2x"] = 1.5
 imgSuffix["@4x"] = 3.0
else
 imgSuffix["@2x"] = 1.5
end

print("device model is : " .. system.getInfo("model") )

print("width is : " .. display.pixelWidth)
print("height is : " .. display.pixelHeight)
print ("ratio is" .. display.contentHeight / display.contentWidth )


if string.sub(system.getInfo("model"),1,4) == "iPad" then
 application = 
 {
 content =
 {
 width = 360,
 height = 480,
 scale = "letterBox",
 xAlign = "center",
 yAlign = "center",
 imageSuffix = imgSuffix,
 antialias = true,
 },
 
 }
elseif string.sub(system.getInfo("model"),1,2) == "iP" and display.pixelHeight/display.pixelWidth == 1920/1080 then


 print( "iPhone 6 Plus")
 application = 
 {
 content =
 {
 width = 270,
 height = 480,
 scale = "letterBox",
 xAlign = "center",
 yAlign = "center",
 imageSuffix = imgSuffix,
 antialias = true,
 },
 
 }
 

elseif string.sub(system.getInfo("model"),1,2) == "iP" and display.pixelHeight/display.pixelWidth == 1334/750 then


 print( "iPhone 6")
 application = 
 {
 content =
 {
 width = 375,
 height = 667,
 scale = "letterBox",
 xAlign = "center",
 yAlign = "center",
 imageSuffix = imgSuffix,
 antialias = true,
 },
 
 }

elseif string.sub(system.getInfo("model"),1,2) == "iP" and display.pixelHeight > 960 then

 print("iPhone 5")
 application = 
 {
 content =
 {
 width = 320,
 height = 568,
 scale = "letterBox",
 xAlign = "center",
 yAlign = "center",
 imageSuffix = imgSuffix,
 antialias = true,
 },
 }

elseif string.sub(system.getInfo("model"),1,2) == "iP" or display.pixelHeight / display.pixelWidth == 1.5 then
 application = 
 {
 content =
 {
 width = 320,
 height = 480,
 scale = "letterBox",
 xAlign = "center",
 yAlign = "center",
 imageSuffix = imgSuffix,
 antialias = true,
 },
 
 }
elseif display.pixelHeight / display.pixelWidth > 1.72 then
 application = 
 {
 content =
 {
 width = 320,
 height = 568,
 scale = "letterBox",
 xAlign = "center",
 yAlign = "center",
 imageSuffix = imgSuffix,
 
 },

 }
else
 application = 
 {
 content =
 {
 width = 320,
 height = 512,
 scale = "letterBox",
 xAlign = "center",
 yAlign = "center",
 imageSuffix = imgSuffix,
 
 },
 }
end


-- application.notification.google.projectNumber = 110550898629