@echo off
FOR %%I IN (.) DO set CurrentDir=%%~nI%%~xI

set CompDate=test
set WebBase="E:\web\portfolio\gymphotos"
set BackupBase="H:\Pictures\Photos\Gymnastics"
set CFDir="G:\DCIM\100EOS7D"

set WebDir="%WebBase%\%CompDate%"
if not exist %WebDir% mkdir %WebDir%
set BackupDir="%BackupBase%\%CompDate%"
if not exist %BackupDir% mkdir %BackupDir%
set Index="%WebDir%\index.md"

echo Copying files to local drive
REM copy /y %CFDir%\_YML*.CR2 .
echo Finished copying to local drive
REM start cmd /c "copy /y _YML*.CR2 %BackupDir%"

>%Index% (
	for %%L in (
		"---"
		"title: Gymnastics Photographs by Andrew Reece"
		"---"
		"<link href='/style.css' rel='stylesheet'/>"
		"<style>"
		"p{display: inline-block; text-align: center; font-weight: bold; margin-bottom: 2rem}"
		"img{margin-bottom: -1rem;}"
		"form{display: inline-block;}"
		".markdown-body{text-align: center;}"
		"</style>"
		"<h1>Gymnastics photos from %CompDate%</h1>"
		"<div id='paypal-form'>"
		"<form action='https://www.paypal.com/cgi-bin/webscr' method='post' target='_top'>"
		"<input type='hidden' name='cmd' value='_s-xclick'>"
		"<input type='hidden' name='hosted_button_id' value='TZVZSSM5635N8'>"
		"<table>"
		"<tr><td><input type='hidden' name='on0' value='Number of photos'>Number of photos</td></tr><tr><td><select name='os0'>"
		"<option value='1'>1 photo - £4.00 GBP</option>"
		"<option value='2'>2 photos - £7.00 GBP</option>"
		"<option value='3'>3 photos - £10.00 GBP</option>"
		"<option value='5'>5 photos - £15.00 GBP</option>"
		"<option value='8'>8 photos - £20.00 GBP</option>"
		"<option value='10'>10 photos - £24.00 GBP</option>"
		"<option value='15'>15 photos - £35.00 GBP</option>"
		"<option value='20'>20 photos - £42.00 GBP</option>"
		"</select> </td></tr>"
		"<tr><td><input type='hidden' name='on1' value='ID #s (eg 4111, 5346, 9832...)'>ID #s (eg 4111, 5346, 9832...)</td></tr><tr><td><input type='text' name='os1' maxlength='200'></td></tr>"
		"</table>"
		"<input type='hidden' name='currency_code' value='GBP'>"
		"<input type='image' src='https://www.paypalobjects.com/en_GB/i/btn/btn_buynow_SM.gif' border='0' name='submit' alt='PayPal – The safer, easier way to pay online!'>"
		"<img alt='' border='0' src='https://www.paypalobjects.com/en_GB/i/scr/pixel.gif' width='1' height='1'>"
		"</form>"
		"</div>"

		""
	) do echo.%%~L
)

SETLOCAL EnableDelayedExpansion
for %%f in (*.CR2) do (
	set fname=%%~nf
	dcraw64.exe -h -a %%f
	gm mogrify -geometry 40%% %%~nf.ppm
	gm composite -gravity Center -quality 70 Watermark.png %%~nf.ppm %WebDir%\!fname:~-4!.jpg
	rm %%~nf.ppm
	echo Converted %%f
)
SETLOCAL DisableDelayedExpansion
echo All conversions finished

for %%f in (%WebDir%\*.jpg) do (
	>>%Index% (
		for %%L in (
			"![Gym photo from %CompDate%](https://github.com/azmr/portfolio/raw/master/gymphotos/%CompDate%/%%~nf.jpg)  "
			"%%~nf"
			""
		) do echo.%%~L
	)
)
echo Web page finished

pushd %WebDir%
REM git add .
REM git status
REM git commit -m "Add photos at %Date% %Time%"
REM git push
echo Web page online
popd %WebDir%
REM pause
