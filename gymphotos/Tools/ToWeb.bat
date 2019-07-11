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
		"<link href='http://andrewreece.co.uk/assets/css/style.css?v=950a1d7525720e023a8cdcea9ef68b753b135472' rel='stylesheet'>"
		"<link href='/style.css' rel='stylesheet'/>"
		"<img style='display: inline-block; margin: 1rem' src='http://andrewreece.co.uk/img/AR_logo.svg' alt='AR logo' class='svg' id='ar-logo'>"
		"Please have a look at the photos taken on %CompDate%. They are organized by session start time."
		""
	) do echo.%%~L
)

>%SessionIndex% (
	for %%L in (
		"<html><head><title>Gymnastics Photographs by Andrew Reece</title></head>"
		"<body style='max-width:960; text-align:center'>"
		"<link href='http://andrewreece.co.uk/assets/css/style.css?v=950a1d7525720e023a8cdcea9ef68b753b135472' rel='stylesheet'>"
		"<link href='/style.css' rel='stylesheet'/>"
		"<style>"
		"p{display: inline-block; text-align: center; font-weight: bold; margin-bottom: 2rem}"
		"img{margin-bottom: -1rem;}"
		"form{display: inline-block;}"
		".markdown-body{text-align: center;}"
		"</style>"
		"<img style='display: inline-block; margin: 1rem; margin-top: 10rem' src='http://andrewreece.co.uk/img/AR_logo.svg' alt='AR logo' class='svg' id='ar-logo'>"
		"<h1>Gymnastics photos from the %SessionName% session on %CompDate%</h1>"
		"<p style='text-align:left'>The photos load a bit after the webpage, so please try again after a few minutes if they are not showing up."
		"<br/><br/>If you would like photos in a format not listed above, please email me at azmreece [at] gmail [dot] com</p>"
		"<div id='paypal-form' style='position:fixed;left:0;top:0;background-color: #bce;width: 100%%;padding: 0.6rem;padding-bottom:0.2rem;box-shadow: 0 0 0.4rem 0px;'>"
		"<form target='paypal' action='https://www.paypal.com/cgi-bin/webscr' method='post'>"
			"<input type='hidden' name='cmd' value='_s-xclick'>"
			"<input type='hidden' name='hosted_button_id' value='YV8D84EBYQ2PW'>"
			"<table>"
			"<tr><td><input type='hidden' name='on0' value='6x4 (Postcard) photo prints'>6x4&quot; (Postcard) photo prints</td></tr><tr><td><select name='os0'>"
			"<option value='1'>1 &#163;4.00 GBP</option>"
			"<option value='2'>2 &#163;7.00 GBP</option>"
			"<option value='3'>3 &#163;10.00 GBP</option>"
			"<option value='5'>5 &#163;15.00 GBP</option>"
			"<option value='8'>8 &#163;20.00 GBP</option>"
			"<option value='10'>10 &#163;24.00 GBP</option>"
			"<option value='15'>15 &#163;35.00 GBP</option>"
			"<option value='20'>20 &#163;42.00 GBP</option>"
			"</select> </td></tr>"
			"<tr><td><input type='hidden' name='on1' value='ID #s (eg 4111, 5346, 9832...)'>ID #s (eg 4111, 5346, 9832...)</td></tr><tr><td><input type='text' name='os1' maxlength='200'></td></tr>"
			"</table>"
			"<input type='hidden' name='currency_code' value='GBP'>"
			"<input type='image' src='https://www.paypalobjects.com/en_GB/i/btn/btn_cart_SM.gif' border='0' name='submit' alt='PayPal – The safer, easier way to pay online!'>"
			"<img alt='' border='0' src='https://www.paypalobjects.com/en_GB/i/scr/pixel.gif' width='1' height='1'>"
		"</form>"
		"<form target='paypal' action='https://www.paypal.com/cgi-bin/webscr' method='post'>"
			"<input type='hidden' name='cmd' value='_s-xclick'>"
			"<input type='hidden' name='hosted_button_id' value='JS8CH9MA4GG9N'>"
			"<table>"
			"<tr><td><input type='hidden' name='on0' value='12x8 prints'>12x8&quot; prints</td></tr><tr><td><select name='os0'>"
			"<option value='1'>1 &#163;8.00 GBP</option>"
			"<option value='2'>2 &#163;14.00 GBP</option>"
			"<option value='3'>3 &#163;20.00 GBP</option>"
			"<option value='5'>5 &#163;30.00 GBP</option>"
			"<option value='8'>8 &#163;40.00 GBP</option>"
			"<option value='10'>10 &#163;48.00 GBP</option>"
			"<option value='15'>15 &#163;70.00 GBP</option>"
			"<option value='20'>20 &#163;84.00 GBP</option>"
			"</select> </td></tr>"
			"<tr><td><input type='hidden' name='on1' value='ID #s (eg 4111, 5346, 9832...)'>ID #s (eg 4111, 5346, 9832...)</td></tr><tr><td><input type='text' name='os1' maxlength='200'></td></tr>"
			"</table>"
			"<input type='hidden' name='currency_code' value='GBP'>"
			"<input type='image' src='https://www.paypalobjects.com/en_GB/i/btn/btn_cart_SM.gif' border='0' name='submit' alt='PayPal – The safer, easier way to pay online!'>"
			"<img alt='' border='0' src='https://www.paypalobjects.com/en_GB/i/scr/pixel.gif' width='1' height='1'>"
		"</form>"
		"<form target='paypal' action='https://www.paypal.com/cgi-bin/webscr' method='post'>"
			"<input type='hidden' name='cmd' value='_s-xclick'>"
			"<input type='hidden' name='hosted_button_id' value='V2CPAFY3T2B9G'>"
			"<table>"
			"<tr><td><input type='hidden' name='on0' value='18x12' prints'>18x12&quot; prints</td></tr><tr><td><select name='os0'>"
				"<option value='1'>1 &#163;12.00 GBP</option>"
				"<option value='2'>2 &#163;21.00 GBP</option>"
				"<option value='3'>3 &#163;30.00 GBP</option>"
				"<option value='5'>5 &#163;45.00 GBP</option>"
				"<option value='8'>8 &#163;60.00 GBP</option>"
				"<option value='10'>10 &#163;72.00 GBP</option>"
				"<option value='15'>15 &#163;105.00 GBP</option>"
				"<option value='20'>20 &#163;126.00 GBP</option>"
			"</select> </td></tr>"
			"<tr><td><input type='hidden' name='on1' value='ID #s (eg 4111, 5346, 9832...)'>ID #s (eg 4111, 5346, 9832...)</td></tr><tr><td><input type='text' name='os1' maxlength='200'></td></tr>"
			"</table>"
			"<input type='hidden' name='currency_code' value='GBP'>"
			"<input type='image' src='https://www.paypalobjects.com/en_GB/i/btn/btn_cart_SM.gif' border='0' name='submit' alt='PayPal – The safer, easier way to pay online!'>"
			"<img alt='' border='0' src='https://www.paypalobjects.com/en_GB/i/scr/pixel.gif' width='1' height='1'>"
		"</form>"
		"<form target='paypal' action='https://www.paypal.com/cgi-bin/webscr' method='post'>"
			"<input type='hidden' name='cmd' value='_s-xclick'>"
			"<input type='hidden' name='encrypted' value='-----BEGIN PKCS7-----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-----END PKCS7-----'>"
			"<input type='image' src='https://www.paypalobjects.com/en_GB/i/btn/btn_viewcart_SM.gif' border='0' name='submit' alt='PayPal – The safer, easier way to pay online!'>"
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
