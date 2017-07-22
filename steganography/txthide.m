function []=txthide(arg)
% TXTHIDE Hides text message (MSG) within an image, using a key (KEY).
% After typing txthide at the command line, a GUI appears that will guide
% the user through the process of encoding the text. The maximum length of
% text that can be encoded is 1000 characters. This could be
% modified, but represents a good comprimise between speed and
% functionality on the author's computer.
% Text can be hidden in a bitmap (*.bmp), a tif (*.tif) or a jpg (*.jpg ).
% However, the encoded image can only be saved as a bitmap or
% tif; the jpg format uses compression and the decoder will not return the
% correct MSG if the user tries to save the encoded image in this
% format.
% Any character from a common keyboard can be encoded, including the
% shifted characters and numbers, such as !@#$%^&*()_+123 etc.
%---------USER NOTES--------%
% 1. User may hit the 'Return' key while typing the MSG, but this is NOT
% recommended, as the formatting will not be preserved on decoding,
% and the string length counter will not display the correct string
% length. Similarly for the 'Tab' key, use spaces instead.
% 2. User should NOT hit the 'Return' key as part of the decoding KEY.
if nargin==0
    arg = 'initialize';
else
% Retrieve/redefine (See definitions below) Mainly for easy reading.
hands = get(gcf,'userdata');
pos = get(gcbf,'position');
checkd = hands(1); % For user to choose to decode a MSG.
checke = hands(2); % For user to choose to encode a MSG.
edit1 = hands(3); % Space for user to enter MSG.
edit2 = hands(4); % Space for user to enter key.
frame1 = hands(5);
frame2 = hands(6);
push1 = hands(7); % Indicates user is done entering MSG.
push2 = hands(8); % Indicates user is done entering KEY.
static1 = hands(9);
static2 = hands(10);
static3 = hands(11);
static4 = hands(12);
static5 = hands(13);
end
switch arg
case 'initialize' % Creation of GUI and storage of handles.
counter=0; % This is where the length of MSG is stored.
h_fig = figure('name','Text Hider','position',[460 760 300 80],...
'menubar','none','resize','off');
col = get(h_fig,'color');
checkd=uicontrol(h_fig,'style','checkbox','position',[140 20 60 20],...
'string','Decode','backgroundcolor',col,'callback',...
'txthide(''decode'')','fontweight','bold');
checke=uicontrol(h_fig,'style','checkbox','position',[140 50 60 20],...
'string','Encode','fontweight','bold',...
'backgroundcolor',col,'callback',...
'txthide(''encode'')');
edit1=uicontrol(h_fig,'style','edit','horizontalalignment','left',...
'max',9,'min',1,'visible','off','KeyPressFcn',...
'txthide(''count'')','userdata',counter);
edit2=uicontrol(h_fig,'style','edit','horizontalalignment','left',...
'max',9,'min',1,'visible','off');
frame1=uicontrol(h_fig,'style','frame','visible','off');
frame2=uicontrol(h_fig,'style','frame','visible','off');
push1=uicontrol(h_fig,'style','pushbutton','string','done',...
'callback','txthide(''done1'')','visible','off');
push2=uicontrol(h_fig,'style','pushbutton',...
'string','done','callback','txthide(''done2'')',...
'visible','off');
static1=uicontrol(h_fig,'style','text','visible','off',...'string','Enter the message you wish to hide.',...
'fontweight','bold','backgroundcolor',col);
static2=uicontrol(h_fig,'style','text','position',[30 33 75 20],...
'strin','Choose one:','fontweight','bold',...
'backgroundcolor',col);
static3=uicontrol(h_fig,'style','text','visible','off',...
'string','Enter the key for decoding.',...
'fontweight','bold','backgroundcolor',col);
static4=uicontrol(h_fig,'style','text','visible','off',...'string','Message Length:',...
'fontweight','bold','backgroundcolor',col);
static5=uicontrol(h_fig,'style','text','visible','off',...'string','0','foregroundcolor','blue',...
'fontweight','bold','backgroundcolor',col);
hands=[checkd checke edit1 edit2 frame1 frame2 push1 push2 static1...
static2 static3 static4 static5];
set(h_fig,'userdata',hands); % Store handles in figures userdata.
case 'encode' % The user has chosen to encode a MSG.
set(gcbf,'position',[pos(1) pos(2)-300 300 380]);
set(checkd,'enable','off','position',[140 320 60 20]);
set(checke,'position',[140 350 60 20],'enable','off');
set(edit1,'visible','on','position',[30 50 245 200],'fontsize',...
10,'string',[' Maximum Number of Characters ',...
' is 1000. See Counter Below'],'foregroundcolor',...
'red'); % Issue a reminder about the max MSG length.
set(frame1,'visible','on','position',[30 295 245 3],...
'backgroundcolor','black');
set(push1,'visible','on','position',[230 10 45 28]);
set(static1,'visible','on','position',[30 260 245 20]);
set(static2,'position',[30 333 75 20]);
set(static4,'visible','on','position',[28 4 100 28]);
set(static5,'visible','on','position',[130 4 50 28]);
pause(1.75); % Displays reminder only a short time.
set(edit1,'foregroundcolor','black','string','','fontsize',9)
case 'decode' % The user has decided to decode a MSG.
set(gcbf,'position',[pos(1) pos(2)-110 300 190]);
set(checkd,'enable','off','position',[140 130 60 20]);
set(checke,'enable','off','position',[140 160 60 20]);
set(edit2,'visible','on','position',[30 40 245 30]);
set(frame1,'position',[30 110 245 3],'visible','on',...
'backgroundcolor','black');
set(push2,'visible','on','position',[130 7 45 28]);
set(static2,'position',[30 143 75 20]);
set(static3,'visible','on','position',[30 75 245 20]);
case 'done1' % The user is done entering the MSG to encode.
set(gcbf,'position',[pos(1) pos(2)-140 300 520]);
set(checkd,'position',[140 460 60 20]);
set(checke,'position',[140 490 60 20]);
set(edit1,'position',[30 190 245 200],'enable','off');
set(edit2,'visible','on','position',[30 60 245 30]);
set(frame1,'position',[30 435 245 3]);
set(frame2,'position',[30 133 245 3],'visible','on',...
'backgroundcolor','black');
set(push1,'position',[230 150 45 28],'enable','off');
set(push2,'visible','on','position',[130 20 45 28]);
set(static1,'position',[30 400 245 20]);
set(static2,'position',[30 473 75 20]);
set(static3,'visible','on','position',[30 95 245 20]);
set(static4,'position',[28 144 100 28]);
set(static5,'position',[130 144 50 28])
if isempty(get(edit1,'string')) % User tried to encode nothing!
fprintf('\n\t\t No message entered, try again.\n\n')
close(gcbf)
return
end
case 'done2' % User has entered the key for use in encoding/decoding.
en_or_de = get(checke,'value'); % Is user encoding or decoding?
if en_or_de==1 % Encoding.
key = get(edit2,'string');
if isempty(key) % Check if user tried to encode with no KEY.
fprintf('\n\t\t No key entered, try again.\n\n');
close(gcbf);
return
end
msg = get(edit1,'string');
[i j] = size(msg); % Useful if user hit 'return' in MSG.
if i >1
msg = reshape(msg',1,i*j); % MSG should be 1 by n.
end
close(gcbf);
wrkd = encode(msg,key); % Pass to encode function.
if isempty(wrkd) % User hit cancel when choosing a file.
close(gcbf);
fprintf('\n\t\t Operation aborted.\n\n');
return
end
fprintf('\t\t\n Your message was encoded.\n\n');
else % Decoding.
key = get(edit2,'string');
if isempty(key) % Check if user tried to dencode with no KEY.
close(gcbf)
fprintf('\n\t\t No key entered, try again.\n\n')
return
end
msg=decode(key); % Pass to decode function.
if isempty(msg) % User hit cancel when choosing a file.
close(gcbf)
fprintf('\n \t\t Operation aborted.\n\n')
return
end
close(gcbf); % New figure is created next to display MSG.
h_fig = figure('name','The Message','position',...
[460 460 300 380],'menubar','none');
col=get(h_fig,'color');
stat = uicontrol(h_fig,'style','edit','position',...
[30 40 245 300],'string',msg,'fontsize',9,...
'horizontalalignment','left','max',9,'min',1);%#ok
stat2 = uicontrol(h_fig,'style','text','position',...
[30 355 245 20],'string','Your Message:',...
'fontweight','bold','backgroundcolor',col,...
'horizontalalignment','left','fontsize',12);%#ok
end
case 'count' % This is where the length of MSG is counted.
ch=get(gcbf,'currentcharacter');
if isempty(ch) || ch==13
return
elseif ch==8
counter = get(edit1,'userdata')-1;
else
counter = get(edit1,'userdata')+1; % Retrieve current length.
end
set(edit1,'userdata',counter);
set(static5,'string',num2str(counter));
if counter > 990 % Issue a warning when getting close to limit.
set(static5,'foregroundcolor','red');
end
end % End switch