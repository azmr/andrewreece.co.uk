@echo off

set CompDate=2018-07-16
set WebBase=C:\Users\Liz\Pictures\Gymnastics\portfolio\gymphotos
set BackupBase="E:\Gymnastics"
set CFDir="F:\DCIM\100EOS7D"
set CR2Base="C:\Users\Liz\Pictures\Gymnastics\CR2"

set SessionName=%~n1
set SessionID=%SessionName: =-%

set WebDir=%WebBase%\%CompDate%
if not exist %WebDir% mkdir %WebDir%
set BackupDir="%BackupBase%\%CompDate%\%SessionName%"
if not exist %BackupDir% mkdir %BackupDir%
set CR2Dir="%CR2Base%\%CompDate%\%SessionName%"
if not exist %CR2Dir% mkdir %CR2Dir%
set WebIndex="%WebDir%\index.md"
set SessionDir=%WebDir%\%SessionName%
set SessionIndex="%SessionDir%\index.html"
set Tools=%WebBase%\Tools

echo Copying files to local drive
copy /y %CFDir%\*.CR2 %CR2Dir%
echo Finished copying to local drive
pushd %CR2Dir%
start cmd /c "copy /y *.CR2 %BackupDir%"

>%WebIndex% (
	for %%L in (
		"---"
		"title: Gymnastics Photographs by Andrew Reece"
		"---"
		"<link href='/style.css' rel='stylesheet'/>"
		"Please have a look at the photos taken on %CompDate%. They are organized by session start time."
		""
	) do echo.%%~L
)

>%SessionIndex% (
	for %%L in (
		"<html><head><title>Gymnastics Photographs by Andrew Reece</title></head>"
		"<body>"
		"<link href='/style.css' rel='stylesheet'/>"
		"<style>"
		"p{display: inline-block; text-align: center; font-weight: bold; margin-bottom: 2rem}"
		"img{margin-bottom: -1rem;}"
		"form{display: inline-block;}"
		".markdown-body{text-align: center;}"
		"</style>"
		"<h1>Gymnastics photos from %CompDate% in the %SessionName% session</h1>"
		"<p style='text-align:left'>The photos load a bit after the webpage, so please try again after a few minutes if they are not showing up.</p>"
		"<p style='text-align:left'>If you would like photos in a format not listed below, please email me at azmreece [at] gmail [dot] com</p>"
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
	%Tools%\dcraw64.exe -h -a %%f
	gm mogrify -geometry 40%% %%~nf.ppm
	gm composite -gravity Center -quality 70 %Tools%\Watermark.png %%~nf.ppm "%SessionDir%\!fname:~-4!.jpg"
	del %%~nf.ppm
	echo Converted %%f
)
SETLOCAL DisableDelayedExpansion
echo All conversions finished
popd

:: TODO ignore empty folders
for /d %%d in (%WebDir%\*) do (
	>>%WebIndex% (
		for %%L in (
			"[%%~nd](%%~nd)"
			""
		) do echo.%%~L
	)
)

for %%f in ("%SessionDir%\*.jpg") do (
	>>%SessionIndex% (
		for %%L in (
			"<p><img src='https://github.com/azmr/portfolio/raw/master/gymphotos/%CompDate%/%SessionName%/%%~nf.jpg' alt='Gym photo from %CompDate% in the %SessionName% session'>  "
			"<br/>%%~nf</p>"
			""
		) do echo.%%~L
	)
	echo %%f
)
echo ^</body^>^</html^> >> %SessionIndex%

echo Encrypting...
call staticrypt -f "%Tools%\template.html" -t "Password Protected Photos" -i "Please enter the password to continue" %SessionIndex% Portishead -o %SessionIndex%
echo Web page finished

pushd %WebDir%
git add *.md */*.html */*.jpg
git status
git commit -m "Add photos at %Date% %Time%"
git push
echo Web page online
popd %WebDir%
pause
