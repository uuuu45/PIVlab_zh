function generateUI % All the GUI elements are created here
handles = guihandles; %alle handles mit tag laden und ansprechbar machen
MainWindow=getappdata(0,'hgui');
guidata(MainWindow,handles)

panelwidth=gui.retr('panelwidth');
margin=gui.retr('margin');
panelheighttools=gui.retr('panelheighttools');
panelheightpanels=gui.retr('panelheightpanels');
Figure_Size = get(MainWindow, 'Position');

%% Toolspanel
handles.tools = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-panelheighttools-margin panelwidth panelheighttools],'title','工具', 'Tag','tools','fontweight','bold');
parentitem=get(handles.tools, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 1];
handles.text29 = uicontrol(handles.tools,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','当前点：');

item=[0 item(2)+item(4) parentitem(3)/2 1];
handles.u_cp = uicontrol(handles.tools,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','u_cp');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.v_cp = uicontrol(handles.tools,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','v_cp');

item=[0 item(2)+item(4) parentitem(3)/2 1];
handles.x_cp = uicontrol(handles.tools,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','x_cp');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.y_cp = uicontrol(handles.tools,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','y_cp');

item=[0 item(2)+item(4) parentitem(3) 1];
handles.scalar_cp = uicontrol(handles.tools,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','scalar_cp');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.filenameshow = uicontrol(handles.tools,'Style','text','units', 'characters','Horizontalalignment', 'center','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','filenameshow');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
handles.fileselector = uicontrol(handles.tools,'Style','slider','units', 'characters','Horizontalalignment', 'center','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'max',4,'min',1,'value',1,'sliderstep',[0.5 1],'Callback',@gui.fileselector_Callback,'tag','fileselector','TooltipString','在此浏览各帧','interruptible','off','BusyAction','cancel');%,'Interruptible','off','busyaction','cancel');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.togglepair = uicontrol(handles.tools,'Style','togglebutton','units', 'characters','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)], 'string','切换','Callback',@gui.togglepair_Callback,'tag','togglepair','TooltipString','在一帧内切换图像','interruptible','off','BusyAction','cancel');%,'Interruptible','off','busyaction','cancel');

item=[0  item(2)+item(4)+margin*0.2 parentitem(3)/2/2 parentitem(3)/2/2/4];
handles.toggle_parallel = uicontrol(handles.tools,'Style','togglebutton','units', 'characters','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@misc.toggle_parallel_Callback,'tag','toggle_parallel');

item=[parentitem(3)/2 item(2) parentitem(3)/2/2 parentitem(3)/2/2/4];
handles.zoomon = uicontrol(handles.tools,'Style','togglebutton','units', 'characters','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@gui.zoomon_Callback,'tag','zoomon','TooltipString','缩放');

item=[parentitem(3)/2+parentitem(3)/2/2 item(2) parentitem(3)/2/2 parentitem(3)/2/2/4];
handles.panon = uicontrol(handles.tools,'Style','togglebutton','units', 'characters','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@gui.panon_Callback,'tag','panon','TooltipString','平移');

load (fullfile('images','icons.mat'))
if gui.retr('darkmode')
    zoompic=1-zoompic+35/255;
    panpic=1-panpic+35/255;
    zoompic(zoompic>1)=1;
    panpic(panpic>1)=1;
end
set(handles.zoomon, 'cdata',zoompic);
set(handles.panon, 'cdata',panpic);

%% Quick access
iconwidth=5;
iconheight=2;
iconamount=6;
quickwidth = gui.retr('quickwidth')-iconwidth-0.5-0.25;
quickheight = gui.retr('quickheight');

handles.quick = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin*0.5 0+margin*0.5+panelheighttools+quickheight quickwidth quickheight],'title','主要任务快捷访问', 'Tag','quick','fontweight','bold','Visible','on');
handles.quick1 = uicontrol(handles.quick,'Style','togglebutton','units', 'characters','position',[1*(quickwidth/(iconamount-1))-(quickwidth/(iconamount-1)) 0.1 iconwidth iconheight],'Callback',@gui.quick1_Callback,'tag','quick1','TooltipString','加载图像');
handles.quick2 = uicontrol(handles.quick,'Style','togglebutton','units', 'characters','position',[2*(quickwidth/(iconamount-1))-(quickwidth/(iconamount-1)) 0.1 iconwidth iconheight],'Callback',@gui.quick2_Callback,'tag','quick2','TooltipString','遮罩生成');
handles.quick3 = uicontrol(handles.quick,'Style','togglebutton','units', 'characters','position',[3*(quickwidth/(iconamount-1))-(quickwidth/(iconamount-1)) 0.1 iconwidth iconheight],'Callback',@gui.quick3_Callback,'tag','quick3','TooltipString','预处理');
handles.quick4 = uicontrol(handles.quick,'Style','togglebutton','units', 'characters','position',[4*(quickwidth/(iconamount-1))-(quickwidth/(iconamount-1)) 0.1 iconwidth iconheight],'Callback',@gui.quick4_Callback,'tag','quick4','TooltipString','PIV 设置');
handles.quick5 = uicontrol(handles.quick,'Style','togglebutton','units', 'characters','position',[5*(quickwidth/(iconamount-1))-(quickwidth/(iconamount-1)) 0.1 iconwidth iconheight],'Callback',@gui.quick5_Callback,'tag','quick5','TooltipString','分析');
handles.quick6 = uicontrol(handles.quick,'Style','togglebutton','units', 'characters','position',[6*(quickwidth/(iconamount-1))-(quickwidth/(iconamount-1)) 0.1 iconwidth iconheight],'Callback',@gui.quick6_Callback,'tag','quick6','TooltipString','标定');

load (fullfile('images','icons_quick.mat'))
if gui.retr('darkmode')
    loadpic=255-loadpic+35;
    maskpic=255-maskpic+35;
    prepic=255-prepic+35;
    settpic=255-settpic+35;
    anapic=255-anapic+35;
    calpic=255-calpic+35;
end
set(handles.quick1, 'cdata',loadpic);
set(handles.quick2, 'cdata',maskpic);
set(handles.quick3, 'cdata',prepic);
set(handles.quick4, 'cdata',settpic);
set(handles.quick5, 'cdata',anapic);
set(handles.quick6, 'cdata',calpic);

%% Progress info / progress bar
handles.toolprogress = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin*0.5 0+margin*0.5+panelheighttools quickwidth quickheight],'title','进度', 'Tag','toolprogress','fontweight','bold','Visible','on');
parentitem=get(handles.toolprogress, 'Position');
item=[margin 0.4 parentitem(3) 1];
handles.toolprogress_bg = uicontrol(handles.toolprogress,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','','BackgroundColor',[0.85 0.85 0.85],'Enable','off');
handles.toolprogress_fg = uicontrol(handles.toolprogress,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) 0 item(4)],'String','','BackgroundColor','g','Enable','off');
gui.put('handle_toolprogress_bg',handles.toolprogress_bg); %for faster access in update loop
gui.put('handle_toolprogress_fg',handles.toolprogress_fg);


%% Multip01
handles.multip01 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','输入数据 (CTRL+N)', 'Tag','multip01','fontweight','bold');
parentitem=get(handles.multip01, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 2];
handles.stereocheckbox = uicontrol(handles.multip01,'Style','checkbox','Value',0,'String','立体 PIV 模式 (2D3C)','Units','characters', 'Fontunits','points','Fontsize',10,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @import.stereocheckbox_Callback,'Tag','stereocheckbox','TooltipString','启用立体 PIV 模式','Enable','off');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.loadimgsbutton = uicontrol(handles.multip01,'Style','pushbutton','String','导入图像','Units','characters', 'Fontunits','points','Fontsize',12,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', {@import.loadimgsbutton_Callback,1,[]},'TooltipString','加载图像数据');

%item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
%handles.loadvideobutton = uicontrol(handles.multip01,'Style','pushbutton','String','Import video','Units','characters', 'Fontunits','points','Fontsize',12,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @import.loadvideobutton_Callback,'TooltipString','Load video file');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.loadsessionbutton = uicontrol(handles.multip01,'Style','pushbutton','String','加载会话','Units','characters', 'Fontunits','points','Fontsize',12,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @import.load_session_Callback,'TooltipString','加载之前保存的会话文件');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.acquirebutton = uicontrol(handles.multip01,'Style','pushbutton','String','采集图像','Units','characters', 'Fontunits','points','Fontsize',12,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.capture_images_Callback,'TooltipString','在 PIVlab 中采集 PIV 图像');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.link_to_manual = uicontrol(handles.multip01,'Style','pushbutton','String','阅读手册','Units','characters', 'Fontunits','points','Fontsize',12,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @gui.pivlabmanual_Callback,'TooltipString','打开 PIVlab 手册','Foregroundcolor',[0.2 0.4 1],'Fontangle','italic','Fontweight','bold');

item=[0 item(2)+item(4)+margin*1.5 parentitem(3) 1];
handles.text2 = uicontrol(handles.multip01,'Style','text','units', 'characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','图像列表：');

PIVver=gui.retr('PIVver');
item=[0 item(2)+item(4) parentitem(3) 12];
handles.filenamebox = uicontrol(handles.multip01,'Style','ListBox','max',3,'min',1,'units','characters','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String',{['欢迎使用 PIVlab ' PIVver '.'] '点击上方“导入图像”按钮' '来添加图像。'},'Callback',@gui.filenamebox_Callback,'tag','filenamebox','TooltipString','此列表显示您当前已加载的帧');
gui.put('standard_bg_color',get(handles.filenamebox,'Backgroundcolor'));

item=[0 item(2)+item(4)+margin/8 parentitem(3)/3*2 2];
handles.remove_imgs = uicontrol(handles.multip01,'Style','pushbutton','String','移除图像','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @import.remove_images_from_list,'Tag','remove_imgs','TooltipString','从图像列表中移除图像','enable','off');

item=[0 item(2)+item(4)+0.4 parentitem(3) 3];
handles.text4 = uicontrol(handles.multip01,'Style','text','units','characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','使用“工具”面板中的滚动条浏览图像。');

item=[0 item(2)+item(4) parentitem(3) 4];
handles.imsize = uicontrol(handles.multip01,'Style','text','units','characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','imsize');

%% Multip02
handles.multip02 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','排除区域 (CTRL+E)', 'Tag','multip02','fontweight','bold');
parentitem=get(handles.multip02, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 12];
handles.uipanel5 = uipanel(handles.multip02, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','感兴趣区域','fontweight','bold');

parentitem=get(handles.uipanel5, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.roi_hint = uicontrol(handles.uipanel5,'Style','text','units','characters','Horizontalalignment', 'center','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','ROI 未激活','tag','roi_hint');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 2];
handles.roi_select = uicontrol(handles.uipanel5,'Style','pushbutton','String','选择 ROI','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @roi.select_Callback,'TooltipString','绘制矩形以选择感兴趣区域');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.clear_roi = uicontrol(handles.uipanel5,'Style','pushbutton','String','清除 ROI','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @roi.clear_roi_Callback,'TooltipString','移除 ROI');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/4 1.5];
handles.text155 = uicontrol(handles.uipanel5,'Style','text','units','characters','Horizontalalignment', 'left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','x：');

item=[parentitem(3)/4 item(2) parentitem(3)/4 1.5];
handles.text156 = uicontrol(handles.uipanel5,'Style','text','units','characters','Horizontalalignment', 'left','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','y：');

item=[parentitem(3)/4*2 item(2) parentitem(3)/4 1.5];
handles.text157 = uicontrol(handles.uipanel5,'Style','text','units','characters','Horizontalalignment', 'left','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','宽度：');

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 1.5];
handles.text158 = uicontrol(handles.uipanel5,'Style','text','units','characters','Horizontalalignment', 'left','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','高度：');

item=[parentitem(3)/4*0+margin item(2)+item(4) parentitem(3)/4 1.5];
handles.ROI_Man_x = uicontrol(handles.uipanel5,'Style','edit','units','characters','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','','tag','ROI_Man_x','Callback',@roi.Man_ROI_Callback);

item=[parentitem(3)/4*1+margin item(2) parentitem(3)/4 1.5];
handles.ROI_Man_y = uicontrol(handles.uipanel5,'Style','edit','units','characters','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','','tag','ROI_Man_y','Callback',@roi.Man_ROI_Callback);

item=[parentitem(3)/4*2+margin item(2) parentitem(3)/4 1.5];
handles.ROI_Man_w = uicontrol(handles.uipanel5,'Style','edit','units','characters','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','','tag','ROI_Man_w','Callback',@roi.Man_ROI_Callback);

item=[parentitem(3)/4*3+margin item(2) parentitem(3)/4 1.5];
handles.ROI_Man_h = uicontrol(handles.uipanel5,'Style','edit','units','characters','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','','tag','ROI_Man_h','Callback',@roi.Man_ROI_Callback);


%% Multip25 (new mask)
handles.multip25 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','图像遮罩', 'Tag','multip25','fontweight','bold');
parentitem=get(handles.multip25, 'Position');
item=[0 0 0 0];


%Edit or preview mode
item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 1.5];
handles.text252 = uicontrol(handles.multip25,'Style','text','String','模式：','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.mask_edit_mode = uicontrol(handles.multip25,'Style','popupmenu','String',{'编辑遮罩','预览遮罩'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','mask_edit_mode','Callback',@mask.edit_mode_Callback, 'TooltipString','在遮罩编辑模式与遮罩预览模式之间切换');


%basic or expert mask capabilities
item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 1.5];
handles.text251 = uicontrol(handles.multip25,'Style','text','String','功能：','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.mask_basic_expert = uicontrol(handles.multip25,'Style','popupmenu','String',{'基础','高级'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','mask_basic_expert','Callback',@mask.basic_expert_Callback, 'TooltipString','在基础遮罩生成与高级遮罩生成模式之间切换');

%panel Polygon mask items
item=[0 item(2)+item(4)+margin/8 parentitem(3) 8];
handles.uipanel25_1 = uipanel(handles.multip25, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','多边形遮罩项', 'Tag','uipanel25_1','fontweight','bold');

parentitem=get(handles.uipanel25_1, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
handles.mask_add_freehand = uicontrol(handles.uipanel25_1,'Style','pushbutton','String','手绘','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', {@mask.add_Callback,'freehand'},'TooltipString','添加手绘遮罩');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.mask_add_assisted = uicontrol(handles.uipanel25_1,'Style','pushbutton','String','辅助手绘','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', {@mask.add_Callback,'assisted'},'TooltipString','添加辅助手绘遮罩');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
handles.mask_add_circle = uicontrol(handles.uipanel25_1,'Style','pushbutton','String','圆形','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', {@mask.add_Callback,'circle'},'TooltipString','添加圆形遮罩');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.mask_add_rectangle = uicontrol(handles.uipanel25_1,'Style','pushbutton','String','矩形','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', {@mask.add_Callback,'rectangle'},'TooltipString','添加矩形遮罩');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
handles.mask_add_polygon = uicontrol(handles.uipanel25_1,'Style','pushbutton','String','多边形','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', {@mask.add_Callback,'polygon'},'TooltipString','添加多边形遮罩');

item=[0 item(2)+item(4) parentitem(3) 1.5];
handles.mask_import = uicontrol(handles.uipanel25_1,'Style','pushbutton','String','导入像素遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.import_Callback,'Tag','mask_import','TooltipString','从二值图像文件导入用户生成的遮罩');

%panel expert mask

parentitem=get(handles.multip25, 'Position');

item=[0 3.75 parentitem(3) 23.25];
handles.uipanel25_2 = uipanel(handles.multip25, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','从 PIV 图像生成遮罩', 'Tag','uipanel25_2','fontweight','bold','Visible','off');
item=[0 0 0 0];
parentitem=get(handles.uipanel25_2, 'Position');


item=[0 0 parentitem(3) 1.5];
handles.mask_bright_or_dark = uicontrol(handles.uipanel25_2,'Style','popupmenu','String',{'亮区遮罩生成器','暗区遮罩生成器','低对比度区域遮罩生成器','自定义脚本（即将推出）'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','mask_bright_or_dark','Callback',@mask.bright_or_dark_Callback, 'TooltipString','在此选择不同的自动遮罩生成器');


%% bright area mask generator
item=[0 1.5+margin/2 parentitem(3) 14];
handles.uipanel25_3 = uipanel(handles.uipanel25_2, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','亮区遮罩生成器', 'Tag','uipanel25_3','fontweight','bold','Visible','on');
item=[0 0 0 0];
parentitem=get(handles.uipanel25_3, 'Position');

checkbox_width = parentitem(3)/10*1;
filter_text_width=parentitem(3)/10*4;
size_text_width=parentitem(3)/10*3;
size_width=parentitem(3)/10*1.5;

%binarize
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.binarize_enable = uicontrol(handles.uipanel25_3,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Callback',@mask.binarize_enable_Callback,'Tag','binarize_enable','TooltipString','启用此遮罩生成器');

item=[checkbox_width item(2) filter_text_width 1];
handles.binarize_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','启用','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.binarize_threshold_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','阈值：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.binarize_threshold = uicontrol(handles.uipanel25_3,'Style','edit', 'String','0.8','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','binarize_threshold','TooltipString','图像二值化阈值');


%medfilt
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_medfilt_enable = uicontrol(handles.uipanel25_3,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_medfilt_enable','TooltipString','使用中值滤波平滑二值化输入');

item=[checkbox_width item(2) filter_text_width 1];
handles.median_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','中值滤波','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.median_size_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.median_size = uicontrol(handles.uipanel25_3,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','median_size','TooltipString','中值核尺寸');



%Imopen/imclose
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.5];
handles.mask_imopen_imclose_enable = uicontrol(handles.uipanel25_3,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_imopen_imclose_enable','TooltipString','启用图像形态学开/闭运算');

item=[checkbox_width item(2) filter_text_width 1.5];
%handles.imopen_text = uicontrol(handles.uipanel25_2,'Style','text', 'String','imopen','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);
handles.imopen_imclose_selection = uicontrol(handles.uipanel25_3,'Style','popupmenu', 'String',{'形态学开运算','形态学闭运算'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imopen_imclose_selection','TooltipString','选择形态学开或闭运算');

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.imopen_imclose_size_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.imopen_imclose_size = uicontrol(handles.uipanel25_3,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imopen_imclose_size','TooltipString','结构元素尺寸');



%imdilate/imerode
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.5];
handles.mask_imdilate_imerode_enable = uicontrol(handles.uipanel25_3,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_imdilate_imerode_enable','TooltipString','启用图像膨胀或腐蚀');

item=[checkbox_width item(2) filter_text_width 1.5];
%handles.imclose_text = uicontrol(handles.uipanel25_2,'Style','text', 'String','imclose','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);
handles.imdilate_imerode_selection = uicontrol(handles.uipanel25_3,'Style','popupmenu', 'String',{'图像膨胀','图像腐蚀'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imdilate_imerode_selection','TooltipString','在腐蚀与膨胀之间选择');

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.imdilate_imerode_size_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.imdilate_imerode_size = uicontrol(handles.uipanel25_3,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imdilate_imerode_size','TooltipString','结构元素尺寸');



%remove small
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_remove_enable = uicontrol(handles.uipanel25_3,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_remove_enable','TooltipString','启用小块去除');

item=[checkbox_width item(2) filter_text_width 1];
handles.remove_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','移除斑点','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.remove_size_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.remove_size = uicontrol(handles.uipanel25_3,'Style','edit', 'String','1000','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','remove_size','TooltipString','要移除块的最大面积（像素）');

%fillholes
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_fill_enable = uicontrol(handles.uipanel25_3,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_fill_enable','TooltipString','启用孔洞填充');

item=[checkbox_width item(2) filter_text_width 1];
handles.fill_text = uicontrol(handles.uipanel25_3,'Style','text', 'String','填充孔洞','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

mask.binarize_enable_Callback

%% dark area mask generator
parentitem=get(handles.uipanel25_2, 'Position');
item=[0 1.5+margin/2 parentitem(3) 14];
handles.uipanel25_5 = uipanel(handles.uipanel25_2, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','暗区遮罩生成器', 'Tag','uipanel25_5','fontweight','bold','Visible','off');
item=[0 0 0 0];

parentitem=get(handles.uipanel25_5, 'Position');

%binarize
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.binarize_enable_2 = uicontrol(handles.uipanel25_5,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Callback',@mask.binarize_enable_2_Callback,'Tag','binarize_enable_2','TooltipString','启用此遮罩生成器');

item=[checkbox_width item(2) filter_text_width 1];
handles.binarize_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','启用','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.binarize_threshold_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','阈值：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.binarize_threshold_2 = uicontrol(handles.uipanel25_5,'Style','edit', 'String','0.01','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','binarize_threshold_2','TooltipString','图像二值化阈值');

%medfilt
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_medfilt_enable_2 = uicontrol(handles.uipanel25_5,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_medfilt_enable_2','TooltipString','使用中值滤波平滑二值化输入');

item=[checkbox_width item(2) filter_text_width 1];
handles.median_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','中值滤波','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.median_size_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.median_size_2 = uicontrol(handles.uipanel25_5,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','median_size_2','TooltipString','中值核尺寸');


%Imopen/imclose
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.5];
handles.mask_imopen_imclose_enable_2 = uicontrol(handles.uipanel25_5,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_imopen_imclose_enable_2','TooltipString','启用图像形态学开/闭运算');

item=[checkbox_width item(2) filter_text_width 1.5];
%handles.imopen_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','imopen','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);
handles.imopen_imclose_selection_2 = uicontrol(handles.uipanel25_5,'Style','popupmenu', 'String',{'形态学开运算','形态学闭运算'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imopen_imclose_selection_2','TooltipString','选择形态学开或闭运算');

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.imopen_imclose_size_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.imopen_imclose_size_2 = uicontrol(handles.uipanel25_5,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imopen_imclose_size_2','TooltipString','结构元素尺寸');

%imdilate/imerode
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.5];
handles.mask_imdilate_imerode_enable_2 = uicontrol(handles.uipanel25_5,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_imdilate_imerode_enable_2','TooltipString','启用图像膨胀或腐蚀');

item=[checkbox_width item(2) filter_text_width 1.5];
%handles.imclose_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','imclose','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);
handles.imdilate_imerode_selection_2 = uicontrol(handles.uipanel25_5,'Style','popupmenu', 'String',{'图像膨胀','图像腐蚀'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imdilate_imerode_selection_2','TooltipString','在腐蚀与膨胀之间选择');

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.imdilate_imerode_size_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.imdilate_imerode_size_2 = uicontrol(handles.uipanel25_5,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imdilate_imerode_size_2','TooltipString','结构元素尺寸');

%remove small
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_remove_enable_2 = uicontrol(handles.uipanel25_5,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_remove_enable_2','TooltipString','启用小块去除');

item=[checkbox_width item(2) filter_text_width 1];
handles.remove_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','移除斑点','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.remove_size_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.remove_size_2 = uicontrol(handles.uipanel25_5,'Style','edit', 'String','1000','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','remove_size_2','TooltipString','要移除块的最大面积（像素）');

%fillholes
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_fill_enable_2 = uicontrol(handles.uipanel25_5,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_fill_enable_2','TooltipString','启用孔洞填充');

item=[checkbox_width item(2) filter_text_width 1];
handles.fill_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','填充孔洞','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);



%% low contrast mask generator
parentitem=get(handles.uipanel25_2, 'Position');
item=[0 1.5+margin/2 parentitem(3) 14];
handles.uipanel25_7 = uipanel(handles.uipanel25_2, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','低对比度遮罩生成器', 'Tag','uipanel25_7','fontweight','bold','Visible','off');
item=[0 0 0 0];

parentitem=get(handles.uipanel25_7, 'Position');

%low contrast
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.low_contrast_mask_enable = uicontrol(handles.uipanel25_7,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Callback',@mask.low_contrast_mask_enable_Callback,'Tag','low_contrast_mask_enable','TooltipString','启用此遮罩生成器');

item=[checkbox_width item(2) filter_text_width-3 1];
handles.low_contrast_mask_text = uicontrol(handles.uipanel25_7,'Style','text', 'String','启用','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width-3 item(2) size_text_width 1];
handles.low_contrast_mask_text_2 = uicontrol(handles.uipanel25_7,'Style','text', 'String','阈值：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width-3+size_text_width item(2) size_width+3 1];
handles.low_contrast_mask_threshold = uicontrol(handles.uipanel25_7,'Style','edit', 'String','0.01','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','low_contrast_mask_threshold','TooltipString','图像二值化阈值');

item=[parentitem(3)/3  item(2)+item(4)+margin/8 parentitem(3)/3*2 1.5];
handles.low_contrast_mask_threshold_suggest = uicontrol(handles.uipanel25_7,'Style','pushbutton','String','建议阈值','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.low_contrast_threshold_suggest_Callback,'Tag','low_contrast_mask_threshold_suggest','TooltipString','建议一个合适的阈值起始点');


%medfilt
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_medfilt_enable_3 = uicontrol(handles.uipanel25_7,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_medfilt_enable_3','TooltipString','使用中值滤波平滑二值化输入');

item=[checkbox_width item(2) filter_text_width 1];
handles.median_text_3 = uicontrol(handles.uipanel25_7,'Style','text', 'String','中值滤波','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.median_size_text_3 = uicontrol(handles.uipanel25_7,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.median_size_3 = uicontrol(handles.uipanel25_7,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','median_size_3','TooltipString','中值核尺寸');


%Imopen/imclose
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.5];
handles.mask_imopen_imclose_enable_3 = uicontrol(handles.uipanel25_7,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_imopen_imclose_enable_3','TooltipString','启用图像形态学开/闭运算');

item=[checkbox_width item(2) filter_text_width 1.5];
%handles.imopen_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','imopen','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);
handles.imopen_imclose_selection_3 = uicontrol(handles.uipanel25_7,'Style','popupmenu', 'String',{'形态学开运算','形态学闭运算'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imopen_imclose_selection_3','TooltipString','选择形态学开或闭运算');

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.imopen_imclose_size_text_3 = uicontrol(handles.uipanel25_7,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.imopen_imclose_size_3 = uicontrol(handles.uipanel25_7,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imopen_imclose_size_3','TooltipString','结构元素尺寸');

%imdilate/imerode
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.5];
handles.mask_imdilate_imerode_enable_3 = uicontrol(handles.uipanel25_7,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_imdilate_imerode_enable_3','TooltipString','启用图像膨胀或腐蚀');

item=[checkbox_width item(2) filter_text_width 1.5];
%handles.imclose_text_2 = uicontrol(handles.uipanel25_5,'Style','text', 'String','imclose','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);
handles.imdilate_imerode_selection_3 = uicontrol(handles.uipanel25_7,'Style','popupmenu', 'String',{'图像膨胀','图像腐蚀'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imdilate_imerode_selection_3','TooltipString','在腐蚀与膨胀之间选择');

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.imdilate_imerode_size_text_3 = uicontrol(handles.uipanel25_7,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.imdilate_imerode_size_3 = uicontrol(handles.uipanel25_7,'Style','edit', 'String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','imdilate_imerode_size_3','TooltipString','结构元素尺寸');

%remove small
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_remove_enable_3 = uicontrol(handles.uipanel25_7,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_remove_enable_3','TooltipString','启用小块去除');

item=[checkbox_width item(2) filter_text_width 1];
handles.remove_text_3 = uicontrol(handles.uipanel25_7,'Style','text', 'String','移除斑点','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width item(2) size_text_width 1];
handles.remove_size_text_3 = uicontrol(handles.uipanel25_7,'Style','text', 'String','尺寸：','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);

item=[checkbox_width+filter_text_width+size_text_width item(2) size_width 1];
handles.remove_size_3 = uicontrol(handles.uipanel25_7,'Style','edit', 'String','1000','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','remove_size_3','TooltipString','要移除块的最大面积（像素）');

%fillholes
item=[margin/4 item(2)+item(4)+margin/2 checkbox_width 1.1];
handles.mask_fill_enable_3 = uicontrol(handles.uipanel25_7,'Style','checkbox', 'value',0, 'String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)],'Tag','mask_fill_enable_3','TooltipString','启用孔洞填充');

item=[checkbox_width item(2) filter_text_width 1];
handles.fill_text_3 = uicontrol(handles.uipanel25_7,'Style','text', 'String','填充孔洞','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin/4 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2/4 item(4)]);


%% mask operations apply etc

parentitem=get(handles.uipanel25_2, 'Position');

item=[0 16.5 parentitem(3) 1.5];
handles.automask_preview = uicontrol(handles.uipanel25_2,'Style','pushbutton','String','预览当前帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.automask_preview_Callback,'TooltipString','预览自动生成的遮罩');

item=[0 item(2)+item(4) parentitem(3) 1.5];
handles.automask_generate_current = uicontrol(handles.uipanel25_2,'Style','pushbutton','String','为当前帧生成遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.automask_generate_current_Callback,'TooltipString','为当前帧自动生成遮罩');

item=[0 item(2)+item(4) parentitem(3) 1.5];
handles.automask_generate_all = uicontrol(handles.uipanel25_2,'Style','pushbutton','String','为所有帧生成遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.automask_generate_all_Callback,'TooltipString','为所有帧自动生成遮罩');


%panel image display options
parentitem=get(handles.multip25, 'Position');
item=[0 12 parentitem(3) 5];
handles.uipanel25_10 = uipanel(handles.multip25, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','图像显示选项', 'Tag','uipanel25_10','fontweight','bold');

parentitem=get(handles.uipanel25_10, 'Position');
item=[0 0 parentitem(3)/2 1.5];
handles.mask_display_brighter = uicontrol(handles.uipanel25_10,'Style','pushbutton','String','更亮','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.display_brighter_darker_Callback,'Tag','mask_display_brighter','TooltipString','提高亮度');

item=[parentitem(3)/2 0 parentitem(3)/2 1.5];
handles.mask_display_darker = uicontrol(handles.uipanel25_10,'Style','pushbutton','String','更暗','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.display_brighter_darker_Callback,'Tag','mask_display_darker','TooltipString','降低亮度');

item=[0 0+item(4) parentitem(3)/2 1.5];
handles.mask_display_average = uicontrol(handles.uipanel25_10,'Style','pushbutton','String','显示平均值','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.display_average_Callback,'TooltipString','显示平均图像');


%panel mask modifications
parentitem=get(handles.multip25, 'Position');
item=[0 18 parentitem(3) 6.5];
handles.uipanel25_9 = uipanel(handles.multip25, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','遮罩修改', 'Tag','uipanel25_9','fontweight','bold');

parentitem=get(handles.uipanel25_9, 'Position');
item=[0 0 parentitem(3)/2 1.5];
handles.mask_shrink = uicontrol(handles.uipanel25_9,'Style','pushbutton','String','收缩遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.shrink_grow_Callback,'Tag','mask_shrink','TooltipString','收缩当前选中的遮罩');

item=[0+item(3) item(2) parentitem(3)/2 1.5];
handles.mask_grow = uicontrol(handles.uipanel25_9,'Style','pushbutton','String','扩展遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.shrink_grow_Callback,'Tag','mask_grow','TooltipString','扩展当前选中的遮罩');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
handles.mask_simplify = uicontrol(handles.uipanel25_9,'Style','pushbutton','String','简化','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.subdivide_simplify_Callback,'Tag','mask_simplify','TooltipString','简化当前选中的遮罩');



item=[0+item(3) item(2) parentitem(3)/2 1.5];
handles.mask_subdivide = uicontrol(handles.uipanel25_9,'Style','pushbutton','String','细分','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.subdivide_simplify_Callback,'Tag','mask_subdivide','TooltipString','细分当前选中的遮罩');


item=[0 item(2)+item(4) parentitem(3)/2 1.5];
handles.mask_optimize = uicontrol(handles.uipanel25_9,'Style','pushbutton','String','优化','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.subdivide_simplify_Callback,'Tag','mask_optimize','TooltipString','优化当前选中遮罩的路径点');


item=[0+item(3) item(2) parentitem(3)/2 1.5];
handles.mask_combine = uicontrol(handles.uipanel25_9,'Style','pushbutton','String','合并','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.combine_Callback,'TooltipString','合并当前帧所有重叠的遮罩');



%panel mask operations
item=[0 0 0 0];
parentitem=get(handles.multip25, 'Position');
item=[0 27 parentitem(3) 7.5];
handles.uipanel25_6 = uipanel(handles.multip25, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','遮罩操作','fontweight','bold');

item=[0 0 0 0];
parentitem=get(handles.uipanel25_6, 'Position');
item=[0 item(2)+item(4) parentitem(3)*0.6 1.5];
handles.mask_apply_to_current = uicontrol(handles.uipanel25_6,'Style','pushbutton','String','复制遮罩到帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.copy_to_all_Callback,'TooltipString','将当前帧的遮罩复制到所选帧');

item=[parentitem(3)*0.6 item(2) parentitem(3)*0.4 1.5];
handles.mask_copy_frames = uicontrol(handles.uipanel25_6,'Style','edit','String','1:end','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','mask_copy_frames','TooltipString','选择此操作适用的帧。例如 "1:end"、"1,4,7" 或 "10:15"。"end" = 最后一帧。');

item=[0 item(2)+item(4)+0.5 parentitem(3)*0.6 1.5];
handles.mask_delete_all = uicontrol(handles.uipanel25_6,'Style','pushbutton','String','清除帧中的遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.delete_all_Callback,'TooltipString','删除所选帧中的遮罩');

item=[parentitem(3)*0.6 item(2) parentitem(3)*0.4 1.5];
handles.mask_clear_frames = uicontrol(handles.uipanel25_6,'Style','edit','String','1:end','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','mask_clear_frames','TooltipString','选择此操作适用的帧。例如 "1:end"、"1,4,7" 或 "10:15"。"end" = 最后一帧。');

item=[0 item(2)+item(4)+0.5 parentitem(3)/2 1.5];
handles.mask_save = uicontrol(handles.uipanel25_6,'Style','pushbutton','String','保存所有遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.save_Callback,'TooltipString','将所有遮罩保存到 Matlab 文件以便复用');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.mask_load = uicontrol(handles.uipanel25_6,'Style','pushbutton','String','加载遮罩','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.load_Callback,'TooltipString','加载之前在 PIVlab 中创建的遮罩');


%% Multip03
handles.multip03 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','图像预处理 (CTRL+I)', 'Tag','multip03','fontweight','bold');
parentitem=get(handles.multip03, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.clahe_enable = uicontrol(handles.multip03,'Style','checkbox', 'value',1, 'String','启用 CLAHE','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','clahe_enable','TooltipString','对比度受限自适应直方图均衡化：增强对比度，建议启用');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text8 = uicontrol(handles.multip03,'Style','text', 'String','窗口尺寸 [px]','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.clahe_size = uicontrol(handles.multip03,'Style','edit', 'String','64','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','clahe_size','TooltipString','CLAHE 的块尺寸。大多数情况下默认设置即可');

item=[0 item(2)+item(4)+margin parentitem(3) 1.1];
handles.enable_highpass = uicontrol(handles.multip03,'Style','checkbox', 'value',0, 'String','启用高通滤波','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','enable_highpass','TooltipString','对图像数据高通滤波。仅在特殊情况下需要');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text9 = uicontrol(handles.multip03,'Style','text', 'String','核尺寸 [px]','Units','characters','HorizontalAlignment','right', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.highp_size = uicontrol(handles.multip03,'Style','edit', 'String','15','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','highp_size','TooltipString','从原始图像中减去的低通滤波图像的核尺寸');

item=[0 item(2)+item(4)+margin parentitem(3) 1.1];
handles.enable_intenscap = uicontrol(handles.multip03,'Style','checkbox', 'value',0, 'String','启用强度截断','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','enable_intenscap','TooltipString','强度截断。仅在特殊情况下需要');

item=[0 item(2)+item(4)+margin parentitem(3) 1.1];
handles.wienerwurst = uicontrol(handles.multip03,'Style','checkbox', 'value',0, 'String','Wiener2 去噪与低通','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','wienerwurst','TooltipString','Wiener 去噪滤波和高斯低通。仅在特殊情况下需要');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text159 = uicontrol(handles.multip03,'Style','text', 'String','窗口尺寸 [px]','HorizontalAlignment','right','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text159');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.wienerwurstsize = uicontrol(handles.multip03,'Style','edit', 'String','15','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','wienerwurstsize','TooltipString','Wiener 去噪滤波的窗口尺寸');

item=[0 item(2)+item(4)+margin*2 parentitem(3) 1.1];
handles.Autolimit = uicontrol(handles.multip03,'Style','checkbox', 'value',1, 'String','自动对比度拉伸','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','Autolimit','TooltipString','自动拉伸图像强度直方图。对 16 位图像很重要。');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 1];
handles.text162 = uicontrol(handles.multip03,'Style','text', 'String','最小值：','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text162');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.text163 = uicontrol(handles.multip03,'Style','text', 'String','最大值：','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text163');

item=[0 item(2)+item(4) parentitem(3)/3*1 1];
handles.minintens = uicontrol(handles.multip03,'Style','edit', 'String','0','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','minintens','Callback',@preproc.maxintens_Callback,'TooltipString','直方图下界 [0...1]');

item=[parentitem(3)/2 item(2) parentitem(3)/3*1 1];
handles.maxintens = uicontrol(handles.multip03,'Style','edit', 'String','1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','maxintens','Callback',@preproc.minintens_Callback,'TooltipString','直方图上界 [0...1]');

item=[0 item(2)+item(4)+margin*1.5 parentitem(3) 7];
handles.uipanel351 = uipanel(handles.multip03, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','背景扣除','fontweight','bold');

parentitem=get(handles.uipanel351, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4)+margin/4 parentitem(3)/3 1.5];
handles.bg_subtract = uicontrol(handles.uipanel351,'Style','popupmenu', 'String',{'关闭','减去平均强度','减去最小强度'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','bg_subtract','Callback',@preproc.remove_bg_img, 'TooltipString','从所有图像中计算平均或最小图像，然后从每张图像中减去该图像。');

item=[parentitem(3)/3 item(2) parentitem(3)/3*2 1.5];
handles.bg_view = uicontrol(handles.uipanel351,'Style','pushbutton','String','查看背景图像','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.bg_view_Callback,'TooltipString','显示生成的背景图像。再次点击可在背景 A 和 B 之间切换。');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1.5];
handles.bg_save = uicontrol(handles.uipanel351,'Style','pushbutton','String','保存','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.bg_save_Callback,'TooltipString','保存背景图像');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.bg_load = uicontrol(handles.uipanel351,'Style','pushbutton','String','加载','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.bg_load_Callback,'TooltipString','加载背景图像');

parentitem=get(handles.multip03, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4)+32 parentitem(3) 2];
handles.preview_preprocess = uicontrol(handles.multip03,'Style','pushbutton','String','应用并预览当前帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.preview_preprocess_Callback,'Tag','preview_preprocess','TooltipString','预览图像预处理效果');

item=[0+item(3)/2 item(2)+item(4)+margin/4 parentitem(3)/2 1.5];
handles.export_preprocess = uicontrol(handles.multip03,'Style','pushbutton','String','导出预览','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @export.preprocess_Callback,'TooltipString','导出预处理后的图像（使用切换按钮在图像 A 和 B 之间切换）');


%% Multip04
handles.multip04 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','PIV 设置 (CTRL+S)', 'Tag','multip04','fontweight','bold');
parentitem=get(handles.multip04, 'Position');
item=[0 0 0 0];
%neu
item=[0 item(2)+item(4) parentitem(3)/4 1.5];
handles.textSuggest = uicontrol(handles.multip04,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','帮助：','tag','textSuggest');

item=[parentitem(3)/4 item(2)+margin/2 parentitem(3)/1.85 1.5];
handles.SuggestSettings = uicontrol(handles.multip04,'Style','pushbutton','String','建议设置','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @piv.SuggestPIVsettings,'Tag','SuggestSettings','TooltipString','根据当前帧的图像数据建议 PIV 设置');

item=[0 item(2)+item(4)+margin/3 parentitem(3) 4];
handles.uipanel35 = uipanel(handles.multip04, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','PIV 算法','fontweight','bold');

parentitem=get(handles.uipanel35, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.algorithm_selection = uicontrol(handles.uipanel35,'Style','popupmenu', 'String',{'多通道 FFT 窗口变形','系综多通道 FFT 窗口变形','单通道直接互相关 (DCC)','光流（基于小波）'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','algorithm_selection','TooltipString',sprintf('* 多通道 FFT 窗口变形是标准算法，适用于大多数情况。\n* 系综相关适用于稀疏播撒流动（如微 PIV）。\n* DCC 是 PIVlab 中实现的第一个算法。\n* 光流在合适的图像数据下可获得更高分辨率（但更慢），由 case.edu 的 Schmidt 等人实现。'),'Callback',@piv.algorithm_selection_Callback);

parentitem=get(handles.multip04, 'Position');
item=[0 0 0 0];

%OFV UI items
item=[0 7 parentitem(3) 8];
handles.uipanel_ofv1 = uipanel(handles.multip04, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','光流设置', 'Tag','uipanel_ofv1','fontweight','bold','Visible','off');
parentitem=get(handles.uipanel_ofv1, 'Position');
item=[0 0 0 0];


item=[0 item(2)+item(4) parentitem(3) 3];
handles.text_parallelpatches = uicontrol(handles.uipanel_ofv1,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','并行处理分块：','Tag','text_parallelpatches');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.ofv_parallelpatches = uicontrol(handles.uipanel_ofv1,'Style','popupmenu', 'String',{'关闭' '128' '256' '512' '1024' '默认'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ofv_parallelpatches','TooltipString','分块并行处理');
set (handles.ofv_parallelpatches,'Value',6);

item=[0 item(2)+item(4) parentitem(3)/3*2 1.5];
handles.text_ofv_median = uicontrol(handles.uipanel_ofv1,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','通道间中值滤波：');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.ofv_median = uicontrol(handles.uipanel_ofv1,'Style','popupmenu', 'String',{'关闭' '3x3' '5x5' '9x9'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ofv_median','TooltipString','金字塔层之间的中值滤波');

item=[0 item(2)+item(4) parentitem(3)/3*2 1.5];
handles.text_ofv_pyramid_levels = uicontrol(handles.uipanel_ofv1,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','金字塔层数：');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.ofv_pyramid_levels = uicontrol(handles.uipanel_ofv1,'Style','popupmenu', 'String',{'5' '4' '3' '2' '1'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ofv_pyramid_levels','TooltipString','由粗到细的步数，位移越大所需数值越大');
handles.ofv_pyramid_levels.Value = 3; %set default

item=[0 item(2)+item(4) parentitem(3)/3*2 1.5];
handles.text_ofv_eta = uicontrol(handles.uipanel_ofv1,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','平滑度 (eta)：');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.ofv_eta = uicontrol(handles.uipanel_ofv1,'Style','edit', 'String','40','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ofv_eta','TooltipString','平滑度由正则化参数决定');


parentitem=get(handles.multip04, 'Position');
item=[0 0 0 0];

item=[0 7+8.5 parentitem(3) 12];

handles.uipanel_ofv2 = uipanel(handles.multip04, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','参考文献', 'Tag','uipanel_ofv2','fontweight','bold','Visible','off');
parentitem=get(handles.uipanel_ofv2, 'Position');
item=[0 0 0 0];


item=[0 item(2)+item(4) parentitem(3) 5];
handles.text_source = uicontrol(handles.uipanel_ofv2,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','Schmidt, B. E., and J. A. Sutton. "High-resolution velocimetry from tracer particle fields using a wavelet-based optical flow method." Experiments in Fluids 60.3 (2019): 37.');

item=[0 item(2)+item(4) parentitem(3) 5];
handles.text_source = uicontrol(handles.uipanel_ofv2,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','Jassal, G.R., Thielicke, W. and Schmidt, B.E. (2025) "An Optical Flow Algorithm with Automatic Parameter Adjustment for Fluid Velocimetry", Journal of Open Research Software, 13(1), p. 22.');


parentitem=get(handles.multip04, 'Position');
item=[0 7 parentitem(3) 6];
handles.uipanel41 = uipanel(handles.multip04, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','第 1 遍', 'Tag','uipanel41','fontweight','bold');

parentitem=get(handles.uipanel41, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1];
handles.text11 = uicontrol(handles.uipanel41,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','询问区尺寸 [px]');

item=[parentitem(3)/3*2 item(2)+margin/2 parentitem(3)/3 1];
handles.text12 = uicontrol(handles.uipanel41,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','步长 [px]');

item=[0 item(2)+item(4) parentitem(3)/3*1 1];
handles.intarea = uicontrol(handles.uipanel41,'Style','edit', 'String','64','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@piv.intarea_Callback,'Tag','intarea','TooltipString','第一遍询问窗边长。应小于最大位移的 0.25 倍');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.step = uicontrol(handles.uipanel41,'Style','edit', 'String','32','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@piv.step_Callback,'Tag','step','TooltipString','询问窗的水平与垂直偏移或步长。通常为询问窗边长的 50%（询问区）');

item=[parentitem(3)/3*2 item(2)+item(4) parentitem(3)/3*1 1];
handles.steppercentage = uicontrol(handles.uipanel41,'Style','text', 'String','N/A','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','steppercentage');

parentitem=get(handles.multip04, 'Position');
item=[0 0 0 0];

item=[0 13.5 parentitem(3) 7.5];
handles.uipanel42 = uipanel(handles.multip04, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','第 2...4 遍', 'Tag','uipanel42','fontweight','bold');

parentitem=get(handles.uipanel42, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1];
handles.text129 = uicontrol(handles.uipanel42,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','询问区尺寸 [px]');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.text130 = uicontrol(handles.uipanel42,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','步长 [px]');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2.5 1.1];
handles.checkbox26 = uicontrol(handles.uipanel42,'Style','checkbox', 'String','第 2 遍','Value',1,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','checkbox26','Callback',@piv.pass2_checkbox_Callback);

item=[parentitem(3)/2.5 item(2) parentitem(3)/4*1 1];
handles.edit50 = uicontrol(handles.uipanel42,'Style','edit', 'String','32','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@piv.pass2_size_Callback,'Tag','edit50','TooltipString','第二遍询问窗边长（询问区）。必须 <= 上一遍');

item=[parentitem(3)/3*2 item(2) parentitem(3)/4*1 1];
handles.text126 = uicontrol(handles.uipanel42,'Style','text', 'String','16','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text126');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2.5 1.1];
handles.checkbox27= uicontrol(handles.uipanel42,'Style','checkbox', 'String','第 3 遍','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','checkbox27','Callback',@piv.pass3_checkbox_Callback);

item=[parentitem(3)/2.5 item(2) parentitem(3)/4*1 1];
handles.edit51 = uicontrol(handles.uipanel42,'Style','edit', 'String','32','Units','characters','enable','off', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@piv.pass3_size_Callback,'Tag','edit51','TooltipString','第三遍询问窗边长（询问区）。必须 <= 上一遍');

item=[parentitem(3)/3*2 item(2) parentitem(3)/4*1 1];
handles.text127 = uicontrol(handles.uipanel42,'Style','text', 'String','16','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text127');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2.5 1.1];
handles.checkbox28= uicontrol(handles.uipanel42,'Style','checkbox', 'String','第 4 遍','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','checkbox28','Callback',@piv.pass4_checkbox_Callback);

item=[parentitem(3)/2.5 item(2) parentitem(3)/4*1 1];
handles.edit52 = uicontrol(handles.uipanel42,'Style','edit', 'String','32','Units','characters','enable','off', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@piv.pass4_size_Callback,'Tag','edit52','TooltipString','第四遍询问窗边长（询问区）。必须 <= 上一遍');

item=[parentitem(3)/3*2 item(2) parentitem(3)/4*1 1];
handles.text128 = uicontrol(handles.uipanel42,'Style','text', 'String','16','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text128');


item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.repeat_last= uicontrol(handles.uipanel42,'Style','checkbox', 'String','重复最后一遍直到','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@piv.repeat_last_Callback,'Tag','repeat_last','TooltipString','将重复多遍分析的最后一遍，直到与上一遍的平均差异小于“质量斜率”。','visible','off');

item=[0 item(2)+item(4) parentitem(3)/2 1];
handles.text128x = uicontrol(handles.uipanel42,'Style','text', 'String','质量斜率 <','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'visible','off','Tag','text128x');

item=[parentitem(3)/2 item(2) parentitem(3)/3.5 1];
handles.edit52x = uicontrol(handles.uipanel42,'Style','edit', 'String','0.025','Units','characters','enable','off', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@piv.repeated_thesh_Callback,'Tag','edit52x','TooltipString','将重复多遍分析的最后一遍，直到与上一遍的平均差异小于“质量斜率”。','visible','off');

parentitem=get(handles.multip04, 'Position');
item=[0 0 0 0];

item=[0 5+5+11.5+margin/3 parentitem(3) 1];
handles.text14 = uicontrol(handles.multip04,'Style','text', 'String','亚像素估计器','Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text14');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.subpix = uicontrol(handles.multip04,'Style','popupmenu', 'String',{'高斯 2x3 点','二维高斯'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','subpix','TooltipString','亚像素估计技术。对于含运动模糊的图像数据，二维高斯应更准确，但差异很小');

%item=[0 item(2)+item(4)+margin parentitem(3) 1];
%handles.Repeated_box = uicontrol(handles.multip04,'Style','checkbox', 'String','5 x repeated correlation','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','Repeated_box','TooltipString','With very bad image data, enabling the repeated correlation will enhance data yield. But it''s pretty slow');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.mask_auto_box = uicontrol(handles.multip04,'Style','checkbox', 'String','禁用自相关','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','mask_auto_box','TooltipString','这将禁止接近零的位移。当存在很强的背景信号时很有用');

item=[0 item(2)+item(4)+margin/1.5 parentitem(3) 1];
handles.text914 = uicontrol(handles.multip04,'Style','text', 'String','相关稳健性','Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text914');

item=[0 item(2)+item(4)+margin/6 parentitem(3) 2];
handles.CorrQuality = uicontrol(handles.multip04,'Style','popupmenu', 'String',{'标准（推荐）','高','极高'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','CorrQuality','TooltipString','相关质量。更好 = 更慢...');

item=[0 item(2)+item(4)+margin/6 parentitem(3) 1.5];
handles.checkbox_uncertainty = uicontrol(handles.multip04,'Style','checkbox', 'String','估算不确定度（慢）','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','checkbox_uncertainty','Visible','on','TooltipString','估算速度测量不确定度（Sciacchitano 2013）。分析时间加倍！');


item=[0 item(2)+item(4)+margin*1.5 parentitem(3) 2];
handles.Settings_Apply_current = uicontrol(handles.multip04,'Style','pushbutton','String','分析当前帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @piv.AnalyzeSingle_Callback,'Tag','Settings_Apply_current','TooltipString','将 PIV 设置应用于当前帧');

%% Multip05
handles.multip05 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','分析 (CTRL+A)', 'Tag','multip05','fontweight','bold');
parentitem=get(handles.multip05, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 2];
handles.AnalyzeSingle = uicontrol(handles.multip05,'Style','pushbutton','String','分析当前帧','Units','characters', 'Fontunits','points','Fontsize',12,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @piv.AnalyzeSingle_Callback,'Tag','AnalyzeSingle','TooltipString','对当前帧执行 PIV 分析');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.AnalyzeAll = uicontrol(handles.multip05,'Style','pushbutton','String','分析所有帧','Units','characters', 'Fontunits','points','Fontsize',12,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @piv.AnalyzeAll_Callback,'Tag','AnalyzeAll','TooltipString','对所有帧执行 PIV 分析');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/4*2.5 2.5];
handles.update_display_checkbox = uicontrol(handles.multip05,'Style','checkbox', 'value',0, 'String','刷新显示','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','update_display_checkbox','TooltipString','分析期间刷新显示。禁用可提高处理速度。');

item=[parentitem(3)/4*2.5 item(2) parentitem(3)/4*1.5 2.5];
handles.cancelbutt = uicontrol(handles.multip05,'Style','pushbutton','String','取消','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @piv.cancelbutt_Callback,'Tag','cancelbutt','TooltipString','取消分析');

item=[0 item(2)+item(4)+margin parentitem(3) 1.5];
handles.clear_everything = uicontrol(handles.multip05,'Style','pushbutton','String','清除所有结果','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @misc.clear_everything_Callback,'TooltipString','清除所有结果');

item=[0 item(2)+item(4)+margin*2 parentitem(3) 2];
handles.progress = uicontrol(handles.multip05,'Style','text','String','帧进度：N/A','Units','characters', 'HorizontalAlignment','left','Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','progress','Visible','off');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.overall = uicontrol(handles.multip05,'Style','text','String','总进度：N/A','Units','characters', 'HorizontalAlignment','left','Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','overall');

item=[0 item(2)+item(4)+margin*3 parentitem(3) 2];
handles.totaltime = uicontrol(handles.multip05,'Style','text','String','剩余时间：N/A','Units','characters', 'HorizontalAlignment','left','Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','totaltime');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.messagetext = uicontrol(handles.multip05,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','messagetext');

%% Multip06
handles.multip06 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','矢量验证 (CTRL+V)', 'Tag','multip06','fontweight','bold');
parentitem=get(handles.multip06, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4) parentitem(3) 13];

handles.uipanel42x = uipanel(handles.multip06, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','速度限制','fontweight','bold');
parentitem=get(handles.uipanel42x, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3 2];
handles.vel_limit = uicontrol(handles.uipanel42x,'Style','pushbutton','String','矩形','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.vel_limit_Callback,'Tag','vel_limit','TooltipString','显示速度散点图并在允许的速度周围绘制窗口');

item=[parentitem(3)/3*1 item(2) parentitem(3)/3 2];
handles.vel_limit_freehand = uicontrol(handles.uipanel42x,'Style','pushbutton','String','手绘','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.vel_limit_Callback,'Tag','vel_limit_freehand','TooltipString','显示速度散点图并在允许的速度周围自由绘制');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 2];
handles.vel_limit_auto = uicontrol(handles.uipanel42x,'Style','pushbutton','String','自动','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.vel_limit_Callback,'Tag','vel_limit_auto','TooltipString','显示速度散点图并自动在其周围绘制形状');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.1];
handles.meanofall = uicontrol(handles.uipanel42x,'Style','checkbox','Value',1,'String','在散点图中显示所有帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','meanofall','TooltipString','在速度散点图中使用所有帧的速度数据');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.vel_limit_active = uicontrol(handles.uipanel42x,'Style','text','String','未启用限制','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','vel_limit_active');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 3];
handles.limittext = uicontrol(handles.uipanel42x,'Style','text','String','','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','limittext');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.clear_vel_limit = uicontrol(handles.uipanel42x,'Style','pushbutton','String','清除所有速度限制','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.clear_vel_limit_Callback,'TooltipString','移除速度限制');


parentitem=get(handles.multip06, 'Position');
item=[0 0 0 0];

item=[0 13+margin/2 parentitem(3) 1.1];
handles.stdev_check = uicontrol(handles.multip06,'Style','checkbox','String','标准差滤波','Value',1,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','stdev_check','TooltipString','通过移除超出平均速度 ± n 倍标准差范围的速度来滤波');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text18 = uicontrol(handles.multip06,'Style','text','String','阈值 [n*标准差]','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.stdev_thresh = uicontrol(handles.multip06,'Style','edit','String','4.7','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@validate.stdev_thresh_Callback,'Tag','stdev_thresh','TooltipString','标准差滤波的阈值。超出平均速度 ± n 倍标准差范围的速度将被移除');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.loc_median = uicontrol(handles.multip06,'Style','checkbox','String','局部中值滤波','Value',1,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','loc_median','TooltipString','Westerweel 和 Scarano (2005) 的归一化局部中值检验');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text19 = uicontrol(handles.multip06,'Style','text','String','阈值','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.loc_med_thresh = uicontrol(handles.multip06,'Style','edit','String','3','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@validate.loc_med_thresh_Callback,'Tag','loc_med_thresh');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.notch_filter = uicontrol(handles.multip06,'Style','checkbox','String','幅度陷波滤波','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','notch_filter','TooltipString','陷波滤波：丢弃 vL 到 vH 指定范围内的速度');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.textnotchL = uicontrol(handles.multip06,'Style','text','String','vL','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','textnotchL');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.notch_L_thresh = uicontrol(handles.multip06,'Style','edit','String','-1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@validate.notch_L_thresh_Callback,'Tag','notch_L_thresh');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.textnotchH = uicontrol(handles.multip06,'Style','text','String','vH','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','textnotchH');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.notch_H_thresh = uicontrol(handles.multip06,'Style','edit','String','1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@validate.notch_H_thresh_Callback,'Tag','notch_H_thresh');

%item=[0 item(2)+item(4) parentitem(3)/3*2 1];
%handles.text20 = uicontrol(handles.multip06,'Style','text','String','Epsilon','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

%item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
%handles.epsilon = uicontrol(handles.multip06,'Style','edit','String','0.1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@epsilon_Callback,'Tag','epsilon');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.rejectsingle = uicontrol(handles.multip06,'Style','pushbutton','String','手动剔除矢量','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.rejectsingle_Callback,'TooltipString','手动移除矢量。点击要丢弃矢量的起点');

item=[0 item(2)+item(4)+margin parentitem(3) 1.1];
handles.interpol_missing = uicontrol(handles.multip06,'Style','checkbox','String','插值缺失数据','Value',1,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','interpol_missing','TooltipString','插值缺失的速度数据。插值数据显示为橙色矢量','Callback',@validate.set_other_interpol_checkbox);

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.apply_filter_current = uicontrol(handles.multip06,'Style','pushbutton','String','应用于当前帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.apply_filter_current_Callback,'TooltipString','将滤波应用于当前帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.apply_filter_all = uicontrol(handles.multip06,'Style','pushbutton','String','应用于所有帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.apply_filter_all_Callback,'Tag','apply_filter_all','TooltipString','将滤波应用于所有帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.restore_all = uicontrol(handles.multip06,'Style','pushbutton','String','撤销所有验证（所有帧）','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.restore_all_Callback,'TooltipString','移除所有帧的所有速度滤波');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1];
handles.amount_nans = uicontrol(handles.multip06,'Style','text','String','有效检测概率（VDP）：100 %','HorizontalAlignment','center','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','amount_nans','TooltipString','有效检测概率（百分比）');

% Vector color legend: colored swatches showing the three vector types.
% Valid and interpolated colors mirror "Modify plot appearance" settings and
% are updated dynamically in validate.count_discarded_data.
swatch_w = 3; swatch_gap = 0.3;
swatch_x = margin;
label_x  = swatch_x + swatch_w + swatch_gap;
label_w  = parentitem(3) - margin*2 - swatch_w - swatch_gap;

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.0];
handles.veccolor_valid_swatch = uicontrol(handles.multip06,'Style','text','String','','Units','characters', ...
    'Position',[swatch_x parentitem(4)-item(4)-margin-item(2) swatch_w item(4)], ...
    'Tag','veccolor_valid_swatch','BackgroundColor',[0 1 0], ...
    'TooltipString','有效矢量颜色 — 可在“修改绘图外观”中配置');
handles.validtxt1 = uicontrol(handles.multip06,'Style','text','String','有效矢量（第 1 峰值）','HorizontalAlignment','left', ...
    'Units','characters','Position',[label_x parentitem(4)-item(4)-margin-item(2) label_w item(4)],'tag','validtxt1');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.0];
handles.veccolor_secondpeak_swatch = uicontrol(handles.multip06,'Style','text','String','','Units','characters', ...
    'Position',[swatch_x parentitem(4)-item(4)-margin-item(2) swatch_w item(4)], ...
    'Tag','veccolor_secondpeak_swatch','BackgroundColor',[0 0.8 1], ...
    'TooltipString','第 2 峰值矢量颜色 — 可在“修改绘图外观”中配置');
handles.secondpeaktxt1 = uicontrol(handles.multip06,'Style','text','String','有效矢量（第 2 峰值）','HorizontalAlignment','left', ...
    'Units','characters','Position',[label_x parentitem(4)-item(4)-margin-item(2) label_w item(4)],'tag','secondpeaktxt1');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.0];
handles.veccolor_interp_swatch = uicontrol(handles.multip06,'Style','text','String','','Units','characters', ...
    'Position',[swatch_x parentitem(4)-item(4)-margin-item(2) swatch_w item(4)], ...
    'Tag','veccolor_interp_swatch','BackgroundColor',[1 0.5 0], ...
    'TooltipString','已剔除/插值矢量颜色 — 可在“修改绘图外观”中配置');
handles.rejectedtxt1=uicontrol(handles.multip06,'Style','text','String','已剔除 / 已插值','HorizontalAlignment','left', ...
    'Units','characters','Position',[label_x parentitem(4)-item(4)-margin-item(2) label_w item(4)],'tag','rejectedtxt1');

%% Multip07
handles.multip07 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','标定 (CTRL+Z)', 'Tag','multip07','fontweight','bold');
parentitem=get(handles.multip07, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 2];
handles.load_ext_img = uicontrol(handles.multip07,'Style','pushbutton','String','加载标定图像（可选）','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @calibrate.load_ext_img_Callback,'TooltipString','加载标定参考图像（如果您录制过）');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.1];
handles.optimize_calib_img = uicontrol(handles.multip07,'Style','checkbox','Value',1,'String','增强图像对比度','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','optimize_calib_img','Callback',@calibrate.optimize_calib_img_Callback, 'TooltipString','增强标定图像的显示');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1];
uicontrol(handles.multip07,'Style','text','String','设置比例','FontWeight','bold','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.draw_line = uicontrol(handles.multip07,'Style','pushbutton','String','选取参考长度 [px]','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @calibrate.draw_line_Callback,'TooltipString','在图像中绘制一条线作为距离参考');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/3*2 1.5];
handles.text26b = uicontrol(handles.multip07,'Style','text','String','参考长度（px）','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.pixeldist = uicontrol(handles.multip07,'Style','edit','String','1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','pixeldist','Callback',@calibrate.pixeldist_changed_Callback,'TooltipString','参考长度（像素）。可直接在此输入或点击“选取参考长度”按钮');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1.5];
handles.text26 = uicontrol(handles.multip07,'Style','text','String','实际距离（mm）','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.realdist = uicontrol(handles.multip07,'Style','edit','String','1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@calibrate.realdist_Callback,'Tag','realdist','TooltipString','在此输入该线的实际长度（毫米）');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1.5];
handles.text27 = uicontrol(handles.multip07,'Style','text','String','时间步长（ms）','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.time_inp = uicontrol(handles.multip07,'Style','edit','String','1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@calibrate.time_inp_Callback,'Tag','time_inp','TooltipString','在此输入两幅图像之间的时间差。如果想测量位移而非速度，请输入 0。');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 8];
handles.uipanel_offsets = uipanel(handles.multip07, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','设置偏移', 'Tag','uipanel_offsets','fontweight','bold');
parentitem=get(handles.uipanel_offsets, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3)/4*3 1];
handles.text27a = uicontrol(handles.uipanel_offsets,'Style','text','String','x 增大的方向为','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.x_axis_direction = uicontrol(handles.uipanel_offsets,'Style','popupmenu','String',{'向右','向左'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','x_axis_direction','TooltipString','x 轴方向');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/4*3 1];
handles.text27b = uicontrol(handles.uipanel_offsets,'Style','text','String','y 增大的方向为','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1.5];
handles.y_axis_direction = uicontrol(handles.uipanel_offsets,'Style','popupmenu','String',{'向下','向上'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','y_axis_direction','TooltipString','y 轴方向');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/1.5 2];
handles.set_x_offset = uicontrol(handles.uipanel_offsets,'Style','pushbutton','String','设置 x 与 y 偏移','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @calibrate.set_offset_Callback,'TooltipString','在标定图像中点击，并告知 PIVlab 该点代表的物理 x 和 y 坐标。');

item=[0 0 0 0];
parentitem=get(handles.multip07, 'Position');

item=[0 23 parentitem(3) 5];
handles.calidisp = uicontrol(handles.multip07,'Style','text','String','未标定','HorizontalAlignment','center','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calidisp');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.apply_cali = uicontrol(handles.multip07,'Style','pushbutton','String','应用标定','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @calibrate.apply_cali_Callback,'TooltipString','将标定应用于整个会话');
item=[0 item(2)+item(4)+margin*0.5 parentitem(3) 2];
handles.clear_cali = uicontrol(handles.multip07,'Style','pushbutton','String','清除标定','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @calibrate.clear_cali_Callback,'TooltipString','移除标定');

%% Multip08
handles.multip08 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','导出参数 (CTRL+D)', 'Tag','multip08','fontweight','bold');
parentitem=get(handles.multip08, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 1];
handles.text33 = uicontrol(handles.multip08,'Style','text','String','显示参数','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.derivchoice = uicontrol(handles.multip08,'Style','popupmenu','String','N/A','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.derivchoice_Callback,'Tag','derivchoice','TooltipString','选择要以颜色编码叠加显示的参数');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1];
handles.LIChint1 = uicontrol(handles.multip08,'Style','text','String','LIC 分辨率','Units','characters','visible','off', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','LIChint1');

item=[parentitem(3)/2 item(2) parentitem(3)/3 1];
handles.licres = uicontrol(handles.multip08,'Style','slider','sliderstep',[0.25 0.25],'max',2,'min',0.1,'value',0.7,'String','显示参数','visible','off','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','licres','TooltipString','LIC 图像的分辨率。数值越大计算时间越长','Callback',@plot.licres_Callback);

item=[parentitem(3)/2+parentitem(3)/3 item(2) parentitem(3)/6 1];
handles.LIChint2 = uicontrol(handles.multip08,'Style','text','String','0.7','Units','characters', 'visible','off','HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','LIChint2');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1.6];
handles.text32 = uicontrol(handles.multip08,'Style','text','String','数据平滑','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.6];
handles.smooth_mode = uicontrol(handles.multip08,'Style','popupmenu','String',{'无';'二维';'时间（移动平均）';'二维 + 时间'},'Value',1,'Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','smooth_mode','Callback',@plot.smooth_mode_Callback,'TooltipString','数据平滑。“二维”= 每帧的空间平滑（使用 Damien Garcia 的“smoothn”）。“时间”= 帧间移动平均。“二维 + 时间”两者都应用（先二维，后时间）。');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1.5];
handles.text_smooth_param = uicontrol(handles.multip08,'Style','text','String','平滑参数','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text_smooth_param');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1.5];
handles.smooth_param = uicontrol(handles.multip08,'Style','edit','String','0.2','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','smooth_param','TooltipString','传递给 "smoothn" 用于二维平滑的平滑参数 S。越大越平滑（通常 0.1 ... 1）。');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1.5];
handles.text_temporal_window = uicontrol(handles.multip08,'Style','text','String','时间窗口（±帧）','Units','characters', 'HorizontalAlignment','Left','Visible','off','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text_temporal_window');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1.5];
handles.temporal_window = uicontrol(handles.multip08,'Style','edit','String','2','Units','characters', 'Visible','off','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','temporal_window','Callback',@plot.temporal_window_Callback,'TooltipString','当前帧两侧使用的相邻帧数。各帧以三角（Bartlett）窗组合，因此越近的帧权重越大。');

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.text34 = uicontrol(handles.multip08,'Style','text','String','减去流动','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3 1.5];
handles.text35 = uicontrol(handles.multip08,'Style','text','String','u：','Units','characters', 'HorizontalAlignment','right','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text35');

item=[parentitem(3)/3 item(2) parentitem(3)/3 1.5];
handles.subtr_u = uicontrol(handles.multip08,'Style','edit','String','0','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.subtr_u_Callback,'Tag','subtr_u','TooltipString','从结果中减去恒定的 u 速度（水平）');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1.5];
handles.mean_u = uicontrol(handles.multip08,'Style','pushbutton','String','平均 u','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.mean_u_Callback,'TooltipString','从结果中减去平均 u 速度','Tag','mean_u');

item=[0 item(2)+item(4) parentitem(3)/3 1.5];
handles.text36 = uicontrol(handles.multip08,'Style','text','String','v：','Units','characters', 'HorizontalAlignment','right','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text36');

item=[parentitem(3)/3 item(2) parentitem(3)/3 1.5];
handles.subtr_v = uicontrol(handles.multip08,'Style','edit','String','0','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.subtr_v_Callback,'Tag','subtr_v','TooltipString','从结果中减去恒定的 v 速度（垂直）');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1.5];
handles.mean_v = uicontrol(handles.multip08,'Style','pushbutton','String','平均 v','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.mean_v_Callback,'TooltipString','从结果中减去平均 v 速度','Tag','mean_v');

item=[0 item(2)+item(4)+margin parentitem(3)/2 1];
handles.text41 = uicontrol(handles.multip08,'Style','text','String','颜色图范围','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.1];
handles.autoscaler = uicontrol(handles.multip08,'Style','checkbox','String','自动缩放','Value',1,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.autoscaler_Callback,'Tag','autoscaler','TooltipString','自动缩放颜色图，使其拉伸到每帧的最小值和最大值。渲染视频等时应禁用。');

item=[0 item(2)+item(4) parentitem(3)/2 1];
handles.text39 = uicontrol(handles.multip08,'Style','text','String','最小：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text39');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.text40 = uicontrol(handles.multip08,'Style','text','String','最大：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text40');

item=[0 item(2)+item(4) parentitem(3)/4 1];
handles.mapscale_min = uicontrol(handles.multip08,'Style','edit','String','-1','Enable','off','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.mapscale_min_Callback,'Tag','mapscale_min','TooltipString','颜色图最小值');

item=[parentitem(3)/2 item(2) parentitem(3)/4 1];
handles.mapscale_max = uicontrol(handles.multip08,'Style','edit','String','1','Enable','off','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.mapscale_max_Callback,'Tag','mapscale_max','TooltipString','颜色图最大值');

item=[0 item(2)+item(4)+margin parentitem(3) 1.1];
handles.highp_vectors = uicontrol(handles.multip08,'Style','checkbox','String','高通矢量场','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','highp_vectors','TooltipString','对矢量场高通滤波。当您想减去非均匀背景流时很有用。修改后的数据不会保存');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 1];
handles.text83 = uicontrol(handles.multip08,'Style','text','String','强度：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text83');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.highpass_strength = uicontrol(handles.multip08,'Style','slider','sliderstep',[0.1 0.1],'max',51,'min',1,'value',30,'Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','highpass_strength','TooltipString','高通强度。修改后的数据不会保存');

item=[0 item(2)+item(4)+margin parentitem(3) 1.1];
handles.extrapolate_border = uicontrol(handles.multip08,'Style','checkbox','String','外推边界','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','extrapolate_border','TooltipString','使用弹簧修复将颜色图外推到边界区域，而不是用平均值填充。较慢但显示更平滑。');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.apply_deriv = uicontrol(handles.multip08,'Style','pushbutton','String','应用于当前帧','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.apply_deriv_Callback,'TooltipString','将设置应用于当前帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.apply_deriv_all = uicontrol(handles.multip08,'Style','pushbutton','String','应用于所有帧','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.apply_deriv_all_Callback, 'Tag','apply_deriv_all','TooltipString','将设置应用于所有帧');
%{
item=[0 item(2)+item(4)+margin/3*2 parentitem(3) 7];
handles.uipanel43 = uipanel(handles.multip08, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','Calculate mean / sum','fontweight','bold');

parentitem=get(handles.uipanel43, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4) parentitem(3)/2 2];
handles.text153 = uicontrol(handles.uipanel43,'Style','text','String','Frames to calc mean / sum:','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.selectedFramesMean = uicontrol(handles.uipanel43,'Style','edit','String','1:end','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','selectedFramesMean','TooltipString','选择要纳入平均速度计算的帧。例如 "1,3,4,8:10"。如需多次平均（如相位平均），请输入行向量："[1:10:end;2:10:end;3:10:end]" -> 每行一个平均帧。');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 2];
handles.meanmaker = uicontrol(handles.uipanel43,'Style','pushbutton','String','Calc. mean','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@temporal_operation_Callback, 1},'TooltipString','计算平均速度并追加一个结果帧');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.summaker = uicontrol(handles.uipanel43,'Style','pushbutton','String','Calc. sum','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@temporal_operation_Callback, 0},'TooltipString','计算位移总和并追加一个结果帧');
%}
%% Multip09
handles.multip09 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','修改绘图外观 (CTRL+M)', 'Tag','multip09','fontweight','bold');
parentitem=get(handles.multip09, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.1];
handles.autoscale_vec = uicontrol(handles.multip09,'Style','checkbox','String','自动缩放矢量','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.autoscale_vec_Callback,'Tag','autoscale_vec','TooltipString','启用矢量显示的自动缩放');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text43 = uicontrol(handles.multip09,'Style','text','String','矢量比例','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4*1 1];
handles.vectorscale = uicontrol(handles.multip09,'Style','edit','String','5','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.vectorscale_Callback,'Tag','vectorscale','TooltipString','在此手动输入矢量比例因子');

item=[0 item(2)+item(4)+margin/4*0 parentitem(3)/4*3 1];
handles.text114 = uicontrol(handles.multip09,'Style','text','String','矢量线宽','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 1];
handles.vecwidth = uicontrol(handles.multip09,'Style','edit','String','0.5','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.vecwidth_Callback,'Tag','vecwidth','TooltipString','矢量线宽');

item=[0 item(2)+item(4)+margin/4*0 parentitem(3)/4*3 1];
handles.text132 = uicontrol(handles.multip09,'Style','text','String','每第 n 个矢量绘图，n =','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','tex132');

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 1];
handles.nthvect = uicontrol(handles.multip09,'Style','edit','String','1','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','nthvect','TooltipString','如果屏幕上的箭头数量让您困惑，可以在此减少数量。');

item=[0 item(2)+item(4) parentitem(3) 1.1];
handles.suppress_vec = uicontrol(handles.multip09,'Style','checkbox','String','隐藏矢量','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.suppress_vec_Callback,'TooltipString','在显示中隐藏矢量');

item=[0 item(2)+item(4)+margin/4*0 parentitem(3)/4*3 1];
handles.text200 = uicontrol(handles.multip09,'Style','text','String','遮罩透明度 [%]','Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 1];
handles.masktransp = uicontrol(handles.multip09,'Style','edit','String','50','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','masktransp','Callback',@mask.transp_Callback,'TooltipString','遮罩区域显示（红色）的透明度');

item=[0 item(2)+item(4) parentitem(3) 1.1];
handles.uniform_vector_scale = uicontrol(handles.multip09,'Style','checkbox','String','统一矢量比例','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','uniform_vector_scale','TooltipString','以相同尺寸绘制所有矢量，与速度无关','Callback',@plot.vector_scale_Callback);

item=[0 item(2)+item(4) parentitem(3)/4*3 1.1];
handles.power_vector_scale = uicontrol(handles.multip09,'Style','checkbox','String','幂律矢量比例','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','power_vector_scale','TooltipString','使用亚线性幂函数绘制矢量比例：指数越小，大矢量长度衰减越多。','Callback',@plot.vector_scale_Callback);
item=[parentitem(3)/4*3 item(2) parentitem(3)/4*1 1.1];
handles.power_vector_scale_factor = uicontrol(handles.multip09,'Style','edit','String','0.3','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','power_vector_scale_factor','TooltipString','使用亚线性幂函数绘制矢量比例：指数越小，大矢量长度衰减越多。','Callback',@plot.vector_scale_Callback);

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1];
handles.displ_image_txt = uicontrol(handles.multip09,'Style','text','String','背景：', 'HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.displ_image = uicontrol(handles.multip09,'Style','popupmenu', 'String',{'显示 PIV 图像','纯黑','纯白'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','displ_image','TooltipString','在背景中显示 PIV 图像');



item=[0 item(2)+item(4)+margin/8 parentitem(3) 8.75];
handles.uipanel37 = uipanel(handles.multip09,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','矢量颜色','fontweight','bold');

parentitem=get(handles.uipanel37, 'Position');
item=[0 0 0 0];
colors_cell = gui.vec_preset_colors();
color_names = colors_cell(:,1)';

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 1.5];
uicontrol(handles.uipanel37,'Style','text','String','有效（第 1 峰值）','HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);
item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.valid_color = uicontrol(handles.uipanel37,'Style','popupmenu','String',color_names,'Value',1,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','valid_color');

item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 1.5];
uicontrol(handles.uipanel37,'Style','text','String','有效（第 2 峰值）','HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);
item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.secondpeak_color = uicontrol(handles.uipanel37,'Style','popupmenu','String',color_names,'Value',2,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','secondpeak_color');

item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 1.5];
uicontrol(handles.uipanel37,'Style','text','String','已替换 / 已插值','HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);
item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.interp_color = uicontrol(handles.uipanel37,'Style','popupmenu','String',color_names,'Value',3,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','interp_color');

item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 1.5];
uicontrol(handles.uipanel37,'Style','text','String','导出参数上','HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);
item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.deriv_color = uicontrol(handles.uipanel37,'Style','popupmenu','String',color_names,'Value',4,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','deriv_color');

parentitem=get(handles.multip09, 'Position');
item=[0 12.5+6.5+2 parentitem(3) 8.5];
handles.uipanel27 = uipanel(handles.multip09, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','导出参数外观','fontweight','bold');

parentitem=get(handles.uipanel27, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1];
handles.text43c = uicontrol(handles.uipanel27,'Style','text','String','颜色图不透明度 [%]','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4*1 1];
handles.colormapopacity = uicontrol(handles.uipanel27,'Style','edit','String','75','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','colormapopacity','TooltipString','颜色图不透明度 (0...1)');

item=[0 item(2)+item(4)+margin/3 parentitem(3)/2 1];
handles.text143 = uicontrol(handles.uipanel27,'Style','text','String','颜色图','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0+item(3) item(2) parentitem(3)/2 1];
handles.text143a = uicontrol(handles.uipanel27,'Style','text','String','步数','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text143a');

item=[0 item(2)+item(4) parentitem(3)/2 2];
handles.colormap_choice = uicontrol(handles.uipanel27,'Style','popupmenu', 'String',{'Parula','HSV','Jet','HSB','Hot','Cool','Spring','Summer','Autumn','Winter','Gray','Bone','Copper','Pink','Lines','Plasma'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','colormap_choice','TooltipString','在此选择用于显示导出参数的颜色图');

item=[0+item(3) item(2) parentitem(3)/2 2];
handles.colormap_steps = uicontrol(handles.uipanel27,'Style','popupmenu', 'String',{'256','128','64','32','16','8','4','2'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','colormap_steps','TooltipString','选择颜色图中的颜色数量');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/5*3 1];
handles.text143b = uicontrol(handles.uipanel27,'Style','text','String','图像插值','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text143b');

item=[0+item(3) item(2)-0.2 parentitem(3)/5*2 2];
handles.colormap_interpolation = uicontrol(handles.uipanel27,'Style','popupmenu', 'String',{'bilinear','bicubic','nearest'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','colormap_interpolation','TooltipString','显示导出参数的图像插值方法。默认为双线性');

%item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.img_not_mask = uicontrol(handles.uipanel27,'Style','checkbox','String','不显示遮罩','Units','characters','Visible','off','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','img_not_mask');

parentitem=get(handles.multip09, 'Position');
item=[0 12.5+6.5+1.5+9.4 parentitem(3) 5.7];
handles.uipanel27b = uipanel(handles.multip09, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','颜色图例','fontweight','bold');

parentitem=get(handles.uipanel27b, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3)/5*3 1];
handles.displ_colorbar = uicontrol(handles.uipanel27b,'Style','text','String','显示颜色条：', 'HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'TooltipString','为导出参数显示颜色条');

item=[parentitem(3)/5*3 item(2) parentitem(3)/5*2 2];
handles.colorbarpos = uicontrol(handles.uipanel27b,'Style','popupmenu', 'String',{'None' 'SouthOutside','NorthOutside','EastOutside','WestOutside'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','colorbarpos','TooltipString','颜色条位置');

item=[0 item(2)+item(4) parentitem(3)/5*3 1];
handles.colorbarnumberformattxt = uicontrol(handles.uipanel27b,'Style','text','String','颜色条数字格式：', 'HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/5*3 item(2) parentitem(3)/5*2 2];
handles.colorbarnumberformat = uicontrol(handles.uipanel27b,'Style','popupmenu', 'String',{'紧凑记法','科学记法','固定小数'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','colorbarnumberformat','TooltipString','颜色条数字格式');

parentitem=get(handles.multip09, 'Position');
item=[0 17.5+4+14.2+margin/4 parentitem(3)/2 2];
handles.ref_vect_txt = uicontrol(handles.multip09,'Style','text','String','参考矢量比例：', 'HorizontalAlignment','left','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'TooltipString','显示参考矢量');

item=[parentitem(3)/2 item(2) parentitem(3)/6 1.5];
handles.ref_vect_scl = uicontrol(handles.multip09,'Style','edit','String','1','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ref_vect_scl','TooltipString','参考矢量的比例。单位与矢量单位相同。');

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 2];
handles.ref_vect_pos = uicontrol(handles.multip09,'Style','popupmenu', 'String',{'关闭','左上','右上','右下','左下'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ref_vect_pos','TooltipString','参考矢量位置');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.1];
handles.enhance_images = uicontrol(handles.multip09,'Style','checkbox','String','增强 PIV 图像显示','Value',1,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','enhance_images','TooltipString','改善 PIV 图像的显示对比度');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.dummy = uicontrol(handles.multip09,'Style','pushbutton','String','应用','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.dummy_Callback,'TooltipString','应用设置');

%% Multip10
handles.multip10 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','导出为文本文件 (ASCII)', 'Tag','multip10','fontweight','bold');
parentitem=get(handles.multip10, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 1.5];
handles.addfileinfo = uicontrol(handles.multip10,'Style','checkbox','String','添加文件信息','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','addfileinfo','TooltipString','将图像文件名等信息添加到输出文件');

item=[0 item(2)+item(4)+margin parentitem(3) 1.5];
handles.add_header = uicontrol(handles.multip10,'Style','checkbox','String','添加列标题','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','add_header','TooltipString','为每列添加标题');

item=[0 item(2)+item(4)+margin parentitem(3) 1.5];
handles.export_vort = uicontrol(handles.multip10,'Style','checkbox','String','包含导出参数','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','export_vort','TooltipString','计算并导出导出参数');

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.delimitertext = uicontrol(handles.multip10,'Style','text','String','分隔符：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/6 parentitem(3) 1.5];
handles.delimiter = uicontrol(handles.multip10,'Style','popupmenu','String',{'逗号','制表符','空格'},'Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','delimiter','TooltipString','在此选择分隔符');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.ascii_current = uicontrol(handles.multip10,'Style','pushbutton','String','导出当前帧','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.ascii_current_Callback,'TooltipString','仅导出当前帧数据');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.ascii_all = uicontrol(handles.multip10,'Style','pushbutton','String','导出所有帧','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.ascii_all_Callback,'Tag','ascii_all','TooltipString','导出所有帧数据');


%% Multip11
handles.multip11 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','保存为 MATLAB 文件', 'Tag','multip11','fontweight','bold');
parentitem=get(handles.multip11, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin parentitem(3) 4];
handles.matlab_text = uicontrol(handles.multip11,'Style','text','String','导出 x、y、速度、标定和矢量类型。勾选“包含导出参数”可同时计算并导出涡量、速度大小、散度、Q 判据、剪切、应变、矢量角度和相关系数。','Units','characters','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin parentitem(3) 1.5];
handles.export_mat_derivatives = uicontrol(handles.multip11,'Style','checkbox','String','包含导出参数','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','export_mat_derivatives','TooltipString','计算并包含所有导出参数（涡量、速度大小、散度、Q 判据、剪切、应变、矢量角度、相关系数）');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.save_mat_current = uicontrol(handles.multip11,'Style','pushbutton','String','导出当前帧','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.save_mat_current_Callback,'TooltipString','仅导出当前帧数据');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.save_mat_all = uicontrol(handles.multip11,'Style','pushbutton','String','导出所有帧','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.save_mat_all_Callback,'Tag','save_mat_all','TooltipString','导出所有帧数据');

%% Multip12
handles.multip12 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','从折线提取参数', 'Tag','multip12','fontweight','bold');
parentitem=get(handles.multip12, 'Position');
item=[0 0 0 0];

%item=[0 item(2)+item(4) parentitem(3) 2];
%handles.text55 = uicontrol(handles.multip12,'Style','text','String','Draw a line or circle and extract derived parameters from it.','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

%item=[0 item(2)+item(4) parentitem(3) 7];
%handles.text91 = uicontrol(handles.multip12,'Style','text','String','Draw a poly-line by clicking with left mouse button. Right mouse button ends the poly-line. Draw a circle by clicking twice with the left mouse button: First click is for the centre, second click for radius.','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1];
handles.text57 = uicontrol(handles.multip12,'Style','text','String','类型：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.draw_what = uicontrol(handles.multip12,'Style','popupmenu','String',{'折线','圆','圆序列（仅切向速度）'},'Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.draw_what_Callback,'Tag','draw_what','TooltipString','选择要绘制并提取数据的对象类型');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.draw_stuff = uicontrol(handles.multip12,'Style','pushbutton','String','绘制！','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.draw_extraction_coordinates_Callback,'Tag','draw_stuff','TooltipString','绘制您上面选择的对象');

%%new buttons, load and save polylines
item=[0 item(2)+item(4) parentitem(3)/2 2];
handles.save_polyline = uicontrol(handles.multip12,'Style','pushbutton','String','保存坐标','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.save_polyline_Callback,'TooltipString','将折线坐标保存到 *.mat 文件');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.load_polyline = uicontrol(handles.multip12,'Style','pushbutton','String','加载坐标','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.load_polyline_Callback,'Tag','load_polyline','TooltipString','从 *.mat 文件加载折线坐标');

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.text56 = uicontrol(handles.multip12,'Style','text','String','要提取的数据：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.extraction_choice = uicontrol(handles.multip12,'Style','popupmenu','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.extraction_choice_Callback,'Tag','extraction_choice','TooltipString','您想沿线/圆提取什么参数？');

item=[0 item(2)+item(4)+margin parentitem(3)/2 2];
handles.plot_data = uicontrol(handles.multip12,'Style','pushbutton','String','提取数据','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.plot_data_Callback,'Tag','plot_data','TooltipString','绘制完线/圆后，可按此按钮沿线/圆绘制数据');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.clear_plot = uicontrol(handles.multip12,'Style','pushbutton','String','清除数据','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.clear_plot_Callback,'TooltipString','清除线/圆数据');

item=[0 item(2)+item(4)+margin*2 parentitem(3) 1];
handles.iLoveLenaMaliaAndLine = uicontrol(handles.multip12,'Style','text','String','保存提取结果','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 1.1];
handles.extractLineAll = uicontrol(handles.multip12,'Style','checkbox','String','提取并保存所有帧','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','extractLineAll','TooltipString','提取当前会话所有帧的数据');

item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 2];
handles.extractionLine_fileformat = uicontrol(handles.multip12,'Style','popupmenu','String',{'Excel 文件','文本文件'},'Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','extractionLine_fileformat','TooltipString','数据保存的格式');

item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 2];
handles.save_data = uicontrol(handles.multip12,'Style','pushbutton','String','导出数据','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.save_data_Callback,'TooltipString','提取数据并将结果保存到文本文件');

%% Multip13
handles.multip13 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','测量距离与角度 (CTRL+T)', 'Tag','multip13','fontweight','bold');
parentitem=get(handles.multip13, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 10];
handles.uipanel40 = uipanel(handles.multip13, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','距离与角度','fontweight','bold');

parentitem=get(handles.uipanel40, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.set_points = uicontrol(handles.uipanel40,'Style','pushbutton','String','绘制线段','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.set_points_Callback,'TooltipString','绘制一条线以测量距离和角度');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/3*2 1];
handles.text50 = uicontrol(handles.uipanel40,'Style','text','String','Δx：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.deltax = uicontrol(handles.uipanel40,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','deltax');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text51 = uicontrol(handles.uipanel40,'Style','text','String','Δy：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.deltay = uicontrol(handles.uipanel40,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','deltay');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text52 = uicontrol(handles.uipanel40,'Style','text','String','长度：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.length = uicontrol(handles.uipanel40,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','length');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text53 = uicontrol(handles.uipanel40,'Style','text','String','与水平夹角（度）：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.alpha = uicontrol(handles.uipanel40,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','alpha');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text54 = uicontrol(handles.uipanel40,'Style','text','String','与垂直夹角（度）：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.beta = uicontrol(handles.uipanel40,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','beta');

parentitem=get(handles.multip13, 'Position');
item=[0 0 0 0];
item=[0 11.5 parentitem(3) 10];
handles.uipanel39 = uipanel(handles.multip13, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','标记','fontweight','bold');

parentitem=get(handles.uipanel39, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3) 3];
handles.text146 = uicontrol(handles.uipanel39,'Style','text','String','在分析中高亮标记点。即使开始新会话，标记也会被记住。','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3)/2 2];
handles.putmarkers = uicontrol(handles.uipanel39,'Style','pushbutton','String','设置标记','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.putmarkers_Callback,'TooltipString','在图像中点击以放置标记。右键结束');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.delmarkers = uicontrol(handles.uipanel39,'Style','pushbutton','String','清除标记','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.delmarkers_Callback,'TooltipString','清除所有标记');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.holdmarkers = uicontrol(handles.uipanel39,'Style','checkbox','String','保持标记','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','holdmarkers','TooltipString','即使开始新会话也记住标记。仅在重启 PIVlab 时清除');

item=[0 item(2)+item(4) parentitem(3) 1.1];
handles.displmarker = uicontrol(handles.uipanel39,'Style','checkbox','String','显示标记','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.displmarker_Callback,'Tag','displmarker','TooltipString','显示或隐藏标记');

parentitem=get(handles.multip13, 'Position');
item=[0 22+margin/2 parentitem(3) 2];
handles.markers_display_average = uicontrol(handles.multip13,'Style','pushbutton','String','显示平均值','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @mask.display_average_Callback,'TooltipString','显示平均图像');

%% Multip14
handles.multip14 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','统计 (CTRL+B)', 'Tag','multip14','fontweight','bold');
parentitem=get(handles.multip14, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*1 1];
handles.text59 = uicontrol(handles.multip14,'Style','text','String','平均 u：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*1 item(2) parentitem(3)/3*2 1];
handles.meanu = uicontrol(handles.multip14,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','meanu');

item=[0 item(2)+item(4) parentitem(3)/3*1 1];
handles.text60 = uicontrol(handles.multip14,'Style','text','String','平均 v：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*1 item(2) parentitem(3)/3*2 1];
handles.meanv = uicontrol(handles.multip14,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','meanv');

item=[0 item(2)+item(4) parentitem(3)/3*1 1];
handles.text59a = uicontrol(handles.multip14,'Style','text','String','最大 u：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*1 item(2) parentitem(3)/3*2 1];
handles.maxu = uicontrol(handles.multip14,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','maxu');

item=[0 item(2)+item(4) parentitem(3)/3*1 1];
handles.text60a = uicontrol(handles.multip14,'Style','text','String','最小 u：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*1 item(2) parentitem(3)/3*2 1];
handles.minu = uicontrol(handles.multip14,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','minu');

item=[0 item(2)+item(4) parentitem(3)/3*1 1];
handles.text59b = uicontrol(handles.multip14,'Style','text','String','最大 v：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*1 item(2) parentitem(3)/3*2 1];
handles.maxv = uicontrol(handles.multip14,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','maxv');

item=[0 item(2)+item(4) parentitem(3)/3*1 1];
handles.text60b = uicontrol(handles.multip14,'Style','text','String','最小 v：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*1 item(2) parentitem(3)/3*2 1];
handles.minv = uicontrol(handles.multip14,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','minv');

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.text67 = uicontrol(handles.multip14,'Style','text','String','直方图','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 2];
handles.hist_select = uicontrol(handles.multip14,'Style','popupmenu','String',{'u 速度','v 速度','速度大小','亚像素'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','hist_select','TooltipString','在直方图中显示什么数据');

item=[parentitem(3)/2 item(2) parentitem(3)/4 2];
handles.text66 = uicontrol(handles.multip14,'Style','text','String','分箱数：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 2];
handles.nrofbins = uicontrol(handles.multip14,'Style','edit','String','100','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','nrofbins','TooltipString','直方图中的分箱数');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.histdraw = uicontrol(handles.multip14,'Style','pushbutton','String','直方图','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.histdraw_Callback,'TooltipString','绘制直方图');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.scatterplotter = uicontrol(handles.multip14,'Style','pushbutton','String','u 与 v 散点图','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.scatterplotter_Callback,'TooltipString','u 与 v 速度散点图');

%% Multip15
handles.multip15 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','粒子图像生成 (CTRL+G)', 'Tag','multip15','fontweight','bold');
parentitem=get(handles.multip15, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 1];
handles.text68 = uicontrol(handles.multip15,'Style','text','String','流动模拟：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.flow_sim = uicontrol(handles.multip15,'Style','popupmenu','String',{'兰金涡','哈梅尔-奥森涡','线性平移','旋转','膜变形'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.flow_sim_Callback,'Tag','flow_sim','TooltipString','在此选择模拟的速度场');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1];
handles.text77 = uicontrol(handles.multip15,'Style','text','String','图像尺寸 x [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 1];
handles.img_sizex = uicontrol(handles.multip15,'Style','edit','String','800','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','img_sizex','TooltipString','图像宽度（像素）');

item=[0 item(2)+item(4) parentitem(3)/2 1];
handles.text96 = uicontrol(handles.multip15,'Style','text','String','图像尺寸 y [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 1];
handles.img_sizey = uicontrol(handles.multip15,'Style','edit','String','600','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','img_sizey','TooltipString','图像高度（像素）');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 8];
handles.uipanel24 = uipanel(handles.multip15, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','粒子模拟','fontweight','bold');

parentitem=get(handles.uipanel24, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text70 = uicontrol(handles.uipanel24,'Style','text','String','粒子数量','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.part_am = uicontrol(handles.uipanel24,'Style','edit','String','200000','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.part_am_Callback,'Tag','part_am','TooltipString','模拟使用的粒子数量');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text71 = uicontrol(handles.uipanel24,'Style','text','String','粒子直径 [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.part_size = uicontrol(handles.uipanel24,'Style','edit','String','3','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.part_size_Callback,'Tag','part_size','TooltipString','平均粒子图像直径');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text72 = uicontrol(handles.uipanel24,'Style','text','String','随机尺寸 [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.part_var = uicontrol(handles.uipanel24,'Style','edit','String','1','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.part_var_Callback,'Tag','part_var','TooltipString','粒子图像直径变化');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text98 = uicontrol(handles.uipanel24,'Style','text','String','片光厚度 [0...1]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.sheetthick = uicontrol(handles.uipanel24,'Style','edit','String','0.5','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.sheetthick_Callback,'Tag','sheetthick','TooltipString','模拟激光片光厚度。片光越薄，每个粒子获得的光越多');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text73 = uicontrol(handles.uipanel24,'Style','text','String','噪声','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.part_noise = uicontrol(handles.uipanel24,'Style','edit','String','0.001','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.part_noise_Callback,'Tag','part_noise','TooltipString','模拟图像传感器噪声');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text115 = uicontrol(handles.uipanel24,'Style','text','String','随机 z 位置 [%]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.part_z = uicontrol(handles.uipanel24,'Style','edit','String','10','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.part_z_Callback,'Tag','part_z','TooltipString','粒子垂直于片光的运动（离面运动）');

%rankinepanel
parentitem=get(handles.multip15, 'Position');
item=[0 0 0 0];

item=[0 14+margin parentitem(3) 11];
handles.rankinepanel = uipanel(handles.multip15, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','兰金涡', 'Tag','rankinepanel','fontweight','bold');

parentitem=get(handles.rankinepanel, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4) parentitem(3) 2];
handles.singledoublerankine = uicontrol(handles.rankinepanel,'Style','popupmenu','String',{'单涡','涡对'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.singledoublerankine_Callback,'Tag','singledoublerankine','TooltipString','模拟单涡或涡对');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/3*2 1];
handles.text74 = uicontrol(handles.rankinepanel,'Style','text','String','核半径 [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.rank_core = uicontrol(handles.rankinepanel,'Style','edit','String','100','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.rank_core_Callback,'Tag','rank_core','TooltipString','刚体旋转核半径');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text75 = uicontrol(handles.rankinepanel,'Style','text','String','最大位移 [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.rank_displ = uicontrol(handles.rankinepanel,'Style','edit','String','8','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.rank_displ_Callback,'Tag','rank_displ','TooltipString','图像中粒子的最大位移');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1];
handles.text99 = uicontrol(handles.rankinepanel,'Style','text','String','涡 1 中心','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.text102 = uicontrol(handles.rankinepanel,'Style','text','Visible','off','String','涡 2 中心','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text102');

item=[0 item(2)+item(4) parentitem(3)/8 1];
handles.text100 = uicontrol(handles.rankinepanel,'Style','text','String','x','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.rankx1 = uicontrol(handles.rankinepanel,'Style','edit','String','200','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.rankx1_Callback,'Tag','rankx1','TooltipString','第一个涡的 x 中心');

item=[parentitem(3)/2 item(2) parentitem(3)/8 1];
handles.text103 = uicontrol(handles.rankinepanel,'Style','text','Visible','off','String','x','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text103');

item=[parentitem(3)/2+parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.rankx2 = uicontrol(handles.rankinepanel,'Style','edit','Visible','off','String','600','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.rankx2_Callback,'Tag','rankx2','TooltipString','第二个涡的 x 中心');

item=[0 item(2)+item(4) parentitem(3)/8 1];
handles.text101 = uicontrol(handles.rankinepanel,'Style','text','String','y','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.ranky1 = uicontrol(handles.rankinepanel,'Style','edit','String','300','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.ranky1_Callback,'Tag','ranky1','TooltipString','第一个涡的 y 中心');

item=[parentitem(3)/2 item(2) parentitem(3)/8 1];
handles.text104 = uicontrol(handles.rankinepanel,'Style','text','Visible','off','String','y','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text104');

item=[parentitem(3)/2+parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.ranky2 = uicontrol(handles.rankinepanel,'Style','edit','Visible','off','String','300','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.ranky2_Callback,'Tag','ranky2','TooltipString','第二个涡的 y 中心');

%------------oseen panel
parentitem=get(handles.multip15, 'Position');
item=[0 0 0 0];

item=[0 14+margin parentitem(3) 11];
handles.oseenpanel = uipanel(handles.multip15, 'Units','characters','Visible','off', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','哈梅尔-奥森涡', 'Tag','oseenpanel','fontweight','bold');

parentitem=get(handles.oseenpanel, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4) parentitem(3) 2];
handles.singledoubleoseen = uicontrol(handles.oseenpanel,'Style','popupmenu','String',{'单涡','涡对'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.singledoubleoseen_Callback,'Tag','singledoubleoseen','TooltipString','模拟单涡或涡对');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/3*2 1];
handles.text106 = uicontrol(handles.oseenpanel,'Style','text','String','最大位移 [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.oseen_displ = uicontrol(handles.oseenpanel,'Style','edit','String','5','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.oseen_displ_Callback,'Tag','oseen_displ','TooltipString','粒子的最大位移');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text113 = uicontrol(handles.oseenpanel,'Style','text','String','时间 [0...1]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.oseen_time = uicontrol(handles.oseenpanel,'Style','edit','String','0.05','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.oseen_time_Callback,'Tag','oseen_time','TooltipString','哈梅尔-奥森模拟的时间分量：随时间增加，涡量衰减');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1];
handles.text107 = uicontrol(handles.oseenpanel,'Style','text','String','涡 1 中心','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.text110 = uicontrol(handles.oseenpanel,'Style','text','Visible','off','String','涡 2 中心','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text110');

item=[0 item(2)+item(4) parentitem(3)/8 1];
handles.text108 = uicontrol(handles.oseenpanel,'Style','text','String','x','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.oseenx1 = uicontrol(handles.oseenpanel,'Style','edit','String','200','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.oseenx1_Callback,'Tag','oseenx1','TooltipString','第一个涡的 x 中心');

item=[parentitem(3)/2 item(2) parentitem(3)/8 1];
handles.text111 = uicontrol(handles.oseenpanel,'Style','text','Visible','off','String','x','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text111');

item=[parentitem(3)/2+parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.oseenx2 = uicontrol(handles.oseenpanel,'Style','edit','Visible','off','String','600','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.oseenx2_Callback,'Tag','oseenx2','TooltipString','第二个涡的 x 中心');

item=[0 item(2)+item(4) parentitem(3)/8 1];
handles.text109 = uicontrol(handles.oseenpanel,'Style','text','String','y','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.oseeny1 = uicontrol(handles.oseenpanel,'Style','edit','String','300','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.oseeny1_Callback,'Tag','oseeny1','TooltipString','第一个涡的 y 中心');

item=[parentitem(3)/2 item(2) parentitem(3)/8 1];
handles.text112 = uicontrol(handles.oseenpanel,'Style','text','Visible','off','String','y','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','text112');

item=[parentitem(3)/2+parentitem(3)/8 item(2) parentitem(3)/4 1];
handles.oseeny2 = uicontrol(handles.oseenpanel,'Style','edit','Visible','off','String','300','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.oseeny2_Callback,'Tag','oseeny2','TooltipString','第二个涡的 y 中心');

%rotationpanel
parentitem=get(handles.multip15, 'Position');
item=[0 0 0 0];

item=[0 14+margin parentitem(3) 10];
handles.rotationpanel = uipanel(handles.multip15, 'Units','characters','Visible','off', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','旋转', 'Tag','rotationpanel','fontweight','bold');

parentitem=get(handles.rotationpanel, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4) parentitem(3) 1];
handles.text76 = uicontrol(handles.rotationpanel,'Style','text','String','最大位移 [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.rotationdislacement = uicontrol(handles.rotationpanel,'Style','edit','String','5','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.rotationdisplacement_Callback,'Tag','rotationdislacement','TooltipString','粒子的最大位移');

%linear shiftpanel
parentitem=get(handles.multip15, 'Position');
item=[0 0 0 0];

item=[0 14+margin parentitem(3) 10];
handles.shiftpanel = uipanel(handles.multip15, 'Units','characters', 'Visible','off','Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','线性平移', 'Tag','shiftpanel','fontweight','bold');

parentitem=get(handles.shiftpanel, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4) parentitem(3) 1];
handles.text97 = uicontrol(handles.shiftpanel,'Style','text','String','最大位移 [px]','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.shiftdisplacement = uicontrol(handles.shiftpanel,'Style','edit','String','5','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.shiftdisplacement_Callback,'Tag','shiftdisplacement','TooltipString','粒子的最大位移');
%--------------- rest unter panels
parentitem=get(handles.multip15, 'Position');
item=[0 0 0 0];

item=[0 27 parentitem(3) 1];
handles.status_creation = uicontrol(handles.multip15,'Style','text','String','N/A','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','status_creation');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.generate_it = uicontrol(handles.multip15,'Style','pushbutton','String','生成图像','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.generate_it_Callback,'TooltipString','启动粒子模拟并创建图像对');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.save_imgs = uicontrol(handles.multip15,'Style','pushbutton','String','保存图像','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@simulate.save_imgs_Callback,'TooltipString','保存当前的粒子模拟图像集（例如，如果您想将其导入 PIVlab）');

%% Multip16
handles.multip16 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','保存图像（序列）', 'Tag','multip16','fontweight','bold');
parentitem=get(handles.multip16, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];

handles.export_still_or_animation = uicontrol(handles.multip16,'Style','popupmenu','String',{'请稍候...'},'Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.still_or_animation_Callback,'Tag','export_still_or_animation','TooltipString','选择导出类型。');

item=[0 item(2)+item(4)+margin parentitem(3)/3*2 1];
handles.qualstring = uicontrol(handles.multip16,'Style','text','String','质量 (%)','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.quality_setting = uicontrol(handles.multip16,'Style','edit','String','100','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','quality_setting','TooltipString','导出文件的质量设置');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.fpsstring = uicontrol(handles.multip16,'Style','text','String','帧率 (Hz)','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
handles.fps_setting = uicontrol(handles.multip16,'Style','edit','String','30','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','fps_setting','TooltipString','视频文件的帧率');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
if ~isMATLABReleaseOlderThan("R2025a")
    handles.resolutionstring = uicontrol(handles.multip16,'Style','text','String','图像尺寸 (%)','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);
else
    handles.resolutionstring = uicontrol(handles.multip16,'Style','text','String','分辨率 (dpi)','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);
end
item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1];
if ~isMATLABReleaseOlderThan("R2025a")
    handles.resolution_setting = uicontrol(handles.multip16,'Style','edit','String','100','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','resolution_setting','TooltipString','输出文件的缩放（相对于原始输入图像）');
else
    handles.resolution_setting = uicontrol(handles.multip16,'Style','edit','String','150','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','resolution_setting','TooltipString','输出图像的分辨率');
end
item=[0 item(2)+item(4)+margin*2 parentitem(3) 2];
handles.do_export_pixel_data_single = uicontrol(handles.multip16,'Style','pushbutton','String','导出单帧','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.do_export_pixel_data_Callback,'Tag','do_export_pixel_data_single','TooltipString','保存当前活动帧的图像');

item=[0 item(2)+item(4)+margin*2 parentitem(3)/2 1];
handles.text87 = uicontrol(handles.multip16,'Style','text','String','起始帧','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[ parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.text88 = uicontrol(handles.multip16,'Style','text','String','结束帧','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3)/3 1];
handles.firstframe = uicontrol(handles.multip16,'Style','edit','String','N/A','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','firstframe','TooltipString','要导出的起始帧');

item=[parentitem(3)/2 item(2) parentitem(3)/3 1];
handles.lastframe = uicontrol(handles.multip16,'Style','edit','String','N/A','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','lastframe','TooltipString','要导出的结束帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.do_export_pixel_data = uicontrol(handles.multip16,'Style','pushbutton','String','导出多帧','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.do_export_pixel_data_Callback,'Tag','do_export_pixel_data','TooltipString','为所选帧保存图像序列');

%% Multip17
handles.multip17 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','从区域提取参数', 'Tag','multip17','fontweight','bold');
parentitem=get(handles.multip17, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1];
handles.text57a = uicontrol(handles.multip17,'Style','text','String','类型：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.draw_what_area = uicontrol(handles.multip17,'Style','popupmenu','String',{'矩形','多边形','圆','圆序列'},'Units','characters', 'HorizontalAlignment','Left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','draw_what_area','TooltipString','选择要绘制并提取数据的对象类型');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.draw_stuff_area = uicontrol(handles.multip17,'Style','pushbutton','String','绘制！','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.draw_extraction_coordinates_Callback,'Tag','draw_stuff_area','TooltipString','绘制您上面选择的对象');

item=[0 item(2)+item(4) parentitem(3)/2 2];
handles.save_area_coordinates = uicontrol(handles.multip17,'Style','pushbutton','String','保存坐标','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.save_polyline_Callback,'TooltipString','将区域坐标保存到 *.mat 文件');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.load_area_coordinates = uicontrol(handles.multip17,'Style','pushbutton','String','加载坐标','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.load_polyline_Callback,'Tag','load_area_coordinates','TooltipString','从 *.mat 文件加载区域坐标');

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.text56a = uicontrol(handles.multip17,'Style','text','String','计算平均值：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.extraction_choice_area = uicontrol(handles.multip17,'Style','popupmenu','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','extraction_choice_area','TooltipString','您想从该区域提取什么参数？');

item=[0 item(2)+item(4)+margin parentitem(3)/2 2];
handles.plot_data_area = uicontrol(handles.multip17,'Style','pushbutton','String','提取数据','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.plot_data_area_Callback,'TooltipString','提取所绘制区域的数据');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.clear_plot_area = uicontrol(handles.multip17,'Style','pushbutton','String','清除数据','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.clear_plot_Callback,'TooltipString','清除区域数据');

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.results_txts = uicontrol(handles.multip17,'Style','text','String','结果：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/4 parentitem(3) 4];
handles.area_results = uicontrol(handles.multip17,'Style','edit','String',{''},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','area_results','TooltipString','区域提取结果','Max',4,'Min',1,'Horizontalalignment','left');

item=[0 item(2)+item(4)+margin*2 parentitem(3) 1];
handles.save_plot_data_area = uicontrol(handles.multip17,'Style','text','String','保存提取结果','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 1.1];
handles.extractAreaAll = uicontrol(handles.multip17,'Style','checkbox','String','提取并保存所有帧','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','extractAreaAll','TooltipString','提取当前会话所有帧的数据');

item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 2];
handles.extractionArea_fileformat = uicontrol(handles.multip17,'Style','popupmenu','String',{'Excel 文件','文本文件'},'Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','extractionArea_fileformat','TooltipString','数据保存的格式');

item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 2];
handles.save_data_area = uicontrol(handles.multip17,'Style','pushbutton','String','导出数据','Units','characters', 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@extract.save_data_area_Callback,'TooltipString','提取数据并将结果保存到文本文件');



%% Multip18
handles.multip18 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','流线', 'Tag','multip18','fontweight','bold');
parentitem=get(handles.multip18, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 3];
handles.text117 = uicontrol(handles.multip18,'Style','text','String','流线是全局的，即它们适用于当前会话的所有帧。','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 1.1];
handles.holdstream = uicontrol(handles.multip18,'Style','checkbox','String','保持流线','Value',1,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','holdstream','TooltipString','启用后，您绘制的每条流线都会添加到流线列表中，而不是覆盖流线列表');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.drawstreamlines = uicontrol(handles.multip18,'Style','pushbutton','String','绘制流线','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.drawstreamlines_Callback,'TooltipString','每次点击添加一条流线。右键结束');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.streamrake = uicontrol(handles.multip18,'Style','pushbutton','String','绘制流线耙','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.streamrake_Callback,'TooltipString','绘制流线耙：第一次点击是耙的起点，第二次点击是终点');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 2];
handles.text118 = uicontrol(handles.multip18,'Style','text','String','耙上流线数量','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2)+0.5 parentitem(3)/3 1];
handles.streamlamount = uicontrol(handles.multip18,'Style','edit','String','10','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','streamlamount','TooltipString','耙上的流线数量');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.streamslice = uicontrol(handles.multip18,'Style','pushbutton','String','绘制流切片','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.streamslice_Callback,'TooltipString','使用 MATLAB 的 streamslice 函数自动绘制覆盖整个速度场的流线');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 2];
handles.text_streamslicedensity = uicontrol(handles.multip18,'Style','text','String','流切片密度','Units','characters','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2)+0.5 parentitem(3)/3 1];
handles.streamslicedensity = uicontrol(handles.multip18,'Style','edit','String','1','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','streamslicedensity','TooltipString','流切片流线的密度（默认：1，数值越大流线越多）');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.deletestreamlines = uicontrol(handles.multip18,'Style','pushbutton','String','删除所有流线','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.deletestreamlines_Callback,'TooltipString','移除所有流线');

item=[0 item(2)+item(4)+margin*3 parentitem(3)/2 2];
handles.text119 = uicontrol(handles.multip18,'Style','text','String','颜色','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.streamlcolor = uicontrol(handles.multip18,'Style','popupmenu','String',{'y','r','b','k','w'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','streamlcolor','TooltipString','流线颜色');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 2];
handles.text120 = uicontrol(handles.multip18,'Style','text','String','线宽','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.streamlwidth = uicontrol(handles.multip18,'Style','popupmenu','String',{'1','2','3'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','streamlwidth','TooltipString','流线线宽');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.applycolorwidth = uicontrol(handles.multip18,'Style','pushbutton','String','应用颜色与线宽','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.applycolorwidth_Callback,'TooltipString','应用颜色和宽度设置');

%% Multip19
handles.multip19 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','保存为 Paraview VTK 文件', 'Tag','multip19','fontweight','bold');
parentitem=get(handles.multip19, 'Position');
item=[0 0 0 0];
item=[0 item(2)+item(4) parentitem(3) 2];
handles.paraview_current = uicontrol(handles.multip19,'Style','pushbutton','String','保存当前帧','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.paraview_current_Callback,'TooltipString','将当前帧保存为 Paraview 文件');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.paraview_all = uicontrol(handles.multip19,'Style','pushbutton','String','保存所有帧','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.paraview_all_Callback,'Tag','paraview_all','TooltipString','将所有帧保存为 Paraview 文件');

%% Multip20
handles.multip20 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','保存为 TECPLOT 文件', 'Tag','multip20','fontweight','bold');
parentitem=get(handles.multip20, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 1.5];
handles.export_vort_tec = uicontrol(handles.multip20,'Style','checkbox','String','包含导出参数','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','export_vort_tec','TooltipString','在导出文件中包含涡量等导出参数');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.tecplot_current = uicontrol(handles.multip20,'Style','pushbutton','String','保存当前帧','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.tecplot_current_Callback,'TooltipString','仅将当前帧保存为 Tecplot 文件');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.tecplot_all = uicontrol(handles.multip20,'Style','pushbutton','String','保存所有帧','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@export.tecplot_all_Callback,'Tag','tecplot_all','TooltipString','将所有帧保存为 Tecplot 文件');

%% Multip21
handles.multip21 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','首选项', 'Tag','multip21','fontweight','bold');
parentitem=get(handles.multip21, 'Position');
item=[0 0 0 0]; %reset positioning

if ~verLessThan('Matlab','25')
    item=[0 item(2)+item(4)+margin/4 parentitem(3) 1];
    handles.matlab_theme_txt = uicontrol(handles.multip21,'Style','text','String','颜色主题','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

    item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
    handles.matlab_theme = uicontrol(handles.multip21,'Style','popupmenu','String',{'深色','浅色'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','matlab_theme','TooltipString','更改 Matlab 主题','Callback',@gui.change_theme);


    current_theme = MainWindow.Theme.BaseColorStyle;

    if strcmpi(current_theme, 'Dark')
        set( handles.matlab_theme,'Value',1);
    elseif strcmpi(current_theme, 'Light')
        set( handles.matlab_theme,'Value',2);
    end
end

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.paneltext = uicontrol(handles.multip21,'Style','text','String','面板宽度','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3)/2 2];
handles.panelslider = uicontrol(handles.multip21,'Style','slider','max',80,'min',30,'sliderstep',[0.05 0.05],'Value',50,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','panelslider','TooltipString','左侧面板的宽度');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.pref_apply = uicontrol(handles.multip21,'Style','pushbutton','String','应用','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@gui.pref_apply_Callback,'Tag','prefapply','TooltipString','应用新的宽度。界面中的所有数据将被清除');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 3];
handles.paneltext2 = uicontrol(handles.multip21,'Style','text','String','如果某些按钮文字被截断或不可读，请尝试在此增大面板宽度。','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/2 parentitem(3) 3];
handles.paneltext2 = uicontrol(handles.multip21,'Style','text','String','警告：当前结果和设置将被清除。','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin parentitem(3) 1];
handles.paneltext3 = uicontrol(handles.multip21,'Style','text','String','更改字体大小','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3)/2 2];
handles.textsizeup = uicontrol(handles.multip21,'Style','pushbutton','String','增大','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@gui.font_size_change,1},'TooltipString','增大按钮等文字大小');

item=[parentitem(3)/2 item(2) parentitem(3)/2 2];
handles.textsizedown = uicontrol(handles.multip21,'Style','pushbutton','String','减小','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@gui.font_size_change,-1},'TooltipString','减小按钮等文字大小');

item=[0 item(2)+item(4)+margin parentitem(3) 4];
handles.paneltext4 = uicontrol(handles.multip21,'Style','text','String','请注意：此设置当前不会被保存，否则可能会永久破坏您的用户界面。','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.flash_sync = uicontrol(handles.multip21,'Style','pushbutton','String','向同步器烧写固件','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@gui.flash_sync_Callback,'TooltipString','向 OPTOLUTION 同步器烧写新固件');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.detect_cam = uicontrol(handles.multip21,'Style','pushbutton','String','检测已连接相机','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@acquisition.camera_info,'TooltipString','检测已连接相机');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.detect_dongle = uicontrol(handles.multip21,'Style','pushbutton','String','检测串口加密狗','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@acquisition.serial_info,'TooltipString','检测加密狗驱动是否已安装');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.test_sync = uicontrol(handles.multip21,'Style','pushbutton','String','发送测试字符串（禁用联锁！）','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@gui.test_sync_Callback,'TooltipString','检查同步器的所有通道（警告！关闭联锁！）');


%% Multip22
handles.multip22 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','导出时间参数', 'Tag','multip22','fontweight','bold');
parentitem=get(handles.multip22, 'Position');
item=[0 0 0 0];

%item=[0 item(2)+item(4)+margin/3*2 parentitem(3) 7];
%handles.uipanel43 = uipanel(handles.multip22, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','Calculate mean / sum','fontweight','bold');

item=[0 item(2)+item(4) parentitem(3) 2];
handles.text153 = uicontrol(handles.multip22,'Style','text','String','要处理的帧：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];
handles.selectedFramesMean = uicontrol(handles.multip22,'Style','edit','String','1:end','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','selectedFramesMean','TooltipString','选择要纳入平均速度计算的帧。例如 "1,3,4,8:10"。如需多次平均（如相位平均），请输入行向量："[1:10:end;2:10:end;3:10:end]" -> 每行一个平均帧。');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.append_replace = uicontrol(handles.multip22,'Style','popupmenu', 'Value', 1, 'String',{'追加到数据集','替换所有现有数据'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','append_replace','TooltipString','将新计算的矢量场追加到当前会话，或替换先前计算的矢量场');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.meanmaker = uicontrol(handles.multip22,'Style','pushbutton','String','计算平均值','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@plot.temporal_operation_Callback, 1},'TooltipString','计算平均速度并追加一个结果帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.summaker = uicontrol(handles.multip22,'Style','pushbutton','String','计算总和','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@plot.temporal_operation_Callback, 0},'TooltipString','计算位移总和并追加一个结果帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.stdmaker = uicontrol(handles.multip22,'Style','pushbutton','String','计算标准差','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@plot.temporal_operation_Callback, 2},'TooltipString','计算位移标准差并追加一个结果帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.tkemaker = uicontrol(handles.multip22,'Style','pushbutton','String','计算湍流动能','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',{@plot.temporal_operation_Callback, 3},'TooltipString','计算湍流动能并追加一个结果帧');

item=[0 item(2)+item(4)+margin parentitem(3) 2];
handles.remove_temporal_frame = uicontrol(handles.multip22,'Style','pushbutton','String','移除当前','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback',@plot.remove_temporal_frame_Callback,'TooltipString','移除当前显示的帧');


%% multip23
handles.multip23 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','基于图像的验证', 'Tag','multip23','fontweight','bold');
parentitem=get(handles.multip23, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.do_contrast_filter = uicontrol(handles.multip23,'Style','checkbox','String','过滤低对比度','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','do_contrast_filter','TooltipString','此滤波移除输入图像对比度较低区域中的矢量。');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text19a = uicontrol(handles.multip23,'Style','text','String','阈值','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.contrast_filter_thresh = uicontrol(handles.multip23,'Style','edit','String','0.001','Units','characters', 'Fontunits','points','Callback',@validate.contrast_filter_thresh_Callback, 'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','contrast_filter_thresh');

item=[0 item(2)+item(4) parentitem(3)/3*2 1.5];
handles.suggest_contrast_filter = uicontrol(handles.multip23,'Style','pushbutton','String','建议阈值','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'TooltipString','找到一个阈值，丢弃图像对比度较低区域的矢量。仅作为起点使用。','Callback', @validate.suggest_contrast_filter_Callback);

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.do_bright_filter = uicontrol(handles.multip23,'Style','checkbox','String','过滤亮目标','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','do_bright_filter','TooltipString','此滤波移除输入图像存在连通亮目标区域中的矢量。');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text19b = uicontrol(handles.multip23,'Style','text','String','阈值','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.bright_filter_thresh = uicontrol(handles.multip23,'Style','edit','String','0.001','Units','characters', 'Fontunits','points','Callback',@validate.bright_filter_thresh_Callback,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','bright_filter_thresh');

item=[0 item(2)+item(4) parentitem(3)/3*2 1.5];
handles.suggest_bright_filter = uicontrol(handles.multip23,'Style','pushbutton','String','建议阈值','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'TooltipString','找到一个阈值，丢弃存在亮目标区域的矢量。仅作为起点使用。','Callback', @validate.suggest_bright_filter_Callback);

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.1];
handles.do_corr2_filter = uicontrol(handles.multip23,'Style','checkbox','String','相关系数滤波','Value',0,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','do_corr2_filter','TooltipString','此滤波移除图像 A 与 B 之间相关性较低区域中的矢量。在移除背景信号后尤其有用。');

item=[0 item(2)+item(4) parentitem(3)/3*2 1];
handles.text19corrfilter = uicontrol(handles.multip23,'Style','text','String','阈值','HorizontalAlignment','left','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3*1 1];
handles.corr_filter_thresh = uicontrol(handles.multip23,'Style','edit','String','0.5','Units','characters', 'Fontunits','points','Callback',@validate.corr_filter_thresh_Callback,'Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','corr_filter_thresh');

item=[0 item(2)+item(4)+margin parentitem(3) 1.1];
handles.interpol_missing2 = uicontrol(handles.multip23,'Style','checkbox','String','插值缺失数据','Value',1,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','interpol_missing2','TooltipString','插值缺失的速度数据。插值数据显示为橙色矢量','Callback',@validate.set_other_interpol_checkbox);

item=[0 item(2)+item(4)+margin/2 parentitem(3) 2];
handles.apply_filter_current = uicontrol(handles.multip23,'Style','pushbutton','String','应用于当前帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.apply_filter_current_Callback,'TooltipString','将滤波应用于当前帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.apply_filter_all = uicontrol(handles.multip23,'Style','pushbutton','String','应用于所有帧','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.apply_filter_all_Callback,'Tag','apply_filter_all','TooltipString','将滤波应用于所有帧');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 2];
handles.restore_all = uicontrol(handles.multip23,'Style','pushbutton','String','撤销所有验证（所有帧）','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @validate.restore_all_Callback,'TooltipString','移除所有帧的所有速度滤波');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1];
handles.amount_nans = uicontrol(handles.multip23,'Style','text','String','已过滤数据：0 %','HorizontalAlignment','center','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','amount_nans');

% Vector color legend — mirrors the one in the Vector validation panel.
% Swatch colors are updated dynamically in validate.count_discarded_data.
swatch_w = 3; swatch_gap = 0.3;
swatch_x = margin;
label_x  = swatch_x + swatch_w + swatch_gap;
label_w  = parentitem(3) - margin*2 - swatch_w - swatch_gap;

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.0];
handles.veccolor_valid_swatch2 = uicontrol(handles.multip23,'Style','text','String','','Units','characters', ...
    'Position',[swatch_x parentitem(4)-item(4)-margin-item(2) swatch_w item(4)], ...
    'Tag','veccolor_valid_swatch2','BackgroundColor',[0 1 0], ...
    'TooltipString','有效矢量颜色 — 可在“修改绘图外观”中配置');
handles.validtxt2 = uicontrol(handles.multip23,'Style','text','String','有效矢量（第 1 峰值）','HorizontalAlignment','left', ...
    'Units','characters','Position',[label_x parentitem(4)-item(4)-margin-item(2) label_w item(4)],'tag','validtxt2');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.0];
handles.veccolor_secondpeak_swatch2 = uicontrol(handles.multip23,'Style','text','String','','Units','characters', ...
    'Position',[swatch_x parentitem(4)-item(4)-margin-item(2) swatch_w item(4)], ...
    'Tag','veccolor_secondpeak_swatch2','BackgroundColor',[0 0.8 1], ...
    'TooltipString','第 2 峰值矢量颜色 — 可在“修改绘图外观”中配置');
handles.secondpeaktxt2=uicontrol(handles.multip23,'Style','text','String','有效矢量（第 2 峰值）','HorizontalAlignment','left', ...
    'Units','characters','Position',[label_x parentitem(4)-item(4)-margin-item(2) label_w item(4)],'tag','secondpeaktxt2');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.0];
handles.veccolor_interp_swatch2 = uicontrol(handles.multip23,'Style','text','String','','Units','characters', ...
    'Position',[swatch_x parentitem(4)-item(4)-margin-item(2) swatch_w item(4)], ...
    'Tag','veccolor_interp_swatch2','BackgroundColor',[1 0.5 0], ...
    'TooltipString','已剔除/插值矢量颜色 — 可在“修改绘图外观”中配置');
handles.rejectedtxt2 = uicontrol(handles.multip23,'Style','text','String','已剔除 / 已插值','HorizontalAlignment','left', ...
    'Units','characters','Position',[label_x parentitem(4)-item(4)-margin-item(2) label_w item(4)],'tag','rejectedtxt2');

%% Multip24
% General
handles.multip24 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','图像采集', 'Tag','multip24','fontweight','bold');
parentitem=get(handles.multip24, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 10];
handles.uipanelac_general = uipanel(handles.multip24, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','常规设置','fontweight','bold');

parentitem=get(handles.uipanelac_general, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 1];
handles.ac_projecttxt = uicontrol(handles.uipanelac_general,'Style','text', 'String','项目路径：','Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3)/1.5 1.5];
handles.ac_project = uicontrol(handles.uipanelac_general,'Style','edit','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','','tag','ac_project');
set(handles.ac_project,'Fontsize', get(handles.ac_project,'Fontsize')-1);

item=[parentitem(3)/1.5 item(2) parentitem(3)/3 1.5];
handles.ac_browse = uicontrol(handles.uipanelac_general,'Style','pushbutton','String','浏览...','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.browse_Callback,'TooltipString','浏览项目文件夹。图像和配置将存储在此。');

item=[0 item(2)+item(4)+margin*0.05 parentitem(3) 1];
handles.ac_configtxt = uicontrol(handles.uipanelac_general,'Style','text', 'String','选择配置：','Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4) parentitem(3) 2];

available_PIV_configurations = { ...
    %	'Nd:YAG (SimpleSync) + pco.pixelfly usb' ...
    %	'Nd:YAG (SimpleSync) + pco.panda 26 DS' ...
    'Webcam demo (no synchronizer)' ...
    'PIVlab LD-PS + OPTOcam 2/80' ...
    'PIVlab LD-PS + pco.edge 26 DS CLHS' ...
    'PIVlab LD-PS + pco.panda 26 DS' ...
    'PIVlab LD-PS + pco.pixelfly usb' ...
    'PIVlab LD-PS + OPTRONIS Cyclone' ...
    'PIVlab LD-PS + Chronos' ...
    'PIVlab LD-PS + Basler acA2000-165um' ...
    'PIVlab LD-PS + FLIR FFY-U3-16S2M' ...
    };

handles.ac_config = uicontrol(handles.uipanelac_general,'Style','popupmenu', 'Value', 1, 'String',available_PIV_configurations,'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ac_config','TooltipString','列出可用配置（同步器 + 相机）','Callback',@acquisition.select_capture_config_Callback);

item=[0 item(2)+item(4)+0.25 parentitem(3)/2 2];
handles.ac_comport = uicontrol(handles.uipanelac_general,'Style','popupmenu', 'String',{'COM1'},'Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ac_comport');

item=[parentitem(3)/2 item(2) parentitem(3)/2*0.9 2];
handles.ac_connect = uicontrol(handles.uipanelac_general,'Style','pushbutton','String','连接','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.connect_Callback,'Tag','ac_connect','TooltipString','连接到 PIVlab-SimpleSync');

IndicatorPos=get(handles.ac_connect,'Position');

handles.ac_serialstatus = uicontrol(handles.uipanelac_general,'Style','edit','units','characters','HorizontalAlignment','center','position',[IndicatorPos(1)+IndicatorPos(3) IndicatorPos(2) 2 IndicatorPos(4)],'String','','tag','ac_serialstatus','BackgroundColor',[1 0 0],'Foregroundcolor',[1 1 1],'Enable','inactive','TooltipString','与 PIVlab-SimpleSync 的串口连接状态');


% Sync control
parentitem=get(handles.multip24, 'Position');
item=[0 10.5 parentitem(3) 12+0.5];
handles.uipanelac_laser = uipanel(handles.multip24, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','同步器控制','fontweight','bold');

parentitem=get(handles.uipanelac_laser, 'Position');
item=[0 0 0 0];

item=[0 0 parentitem(3)/4*2.5 2];
handles.ac_fpstxt = uicontrol(handles.uipanelac_laser,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','帧率（Hz）：');

item=[parentitem(3)/4*2.5 item(2) parentitem(3)/4*1.5 1.6];
handles.ac_fps = uicontrol(handles.uipanelac_laser,'Style','popupmenu','String',{'5' '3' '1.5' '1'},'Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.sync_settings_Callback,'Tag','ac_fps','TooltipString','PIV 图像采集期间的帧率','interruptible','off','busyaction','cancel');

item=[0 item(2)+item(4)+margin*0.3 parentitem(3)/4*2.5 1];
handles.ac_interpulstxt = uicontrol(handles.uipanelac_laser,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','脉冲间隔（µs）：');

item=[parentitem(3)/4*2.5 item(2) parentitem(3)/4*1.5 1];
handles.ac_interpuls = uicontrol(handles.uipanelac_laser,'Style','edit','String','250','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.sync_settings_Callback,'Tag','ac_interpuls','TooltipString','激光脉冲间隔','interruptible','off','busyaction','cancel');

item=[0 item(2)+item(4)+margin*0.2 parentitem(3)/4*2.5 1];
handles.ac_powertxt = uicontrol(handles.uipanelac_laser,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','激光能量（%）：');

item=[parentitem(3)/4*2.5 item(2) parentitem(3)/4*1.5 1];
handles.ac_power = uicontrol(handles.uipanelac_laser,'Style','edit','String','100','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.sync_settings_Callback,'Tag','ac_power','TooltipString','激光能量','interruptible','off','busyaction','cancel');

item=[0 item(2)+item(4)+margin*0.1 parentitem(3) 1];
handles.ac_pulselengthtxt = uicontrol(handles.uipanelac_laser,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','脉冲长度：0 µs','tag','ac_pulselengthtxt');

item=[0 item(2)+item(4)+margin*0.2 parentitem(3) 1.1];
handles.ac_enable_straddling_figure = uicontrol(handles.uipanelac_laser,'Style','checkbox','String','时序图','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ac_enable_straddling_figure','TooltipString','显示相机和激光脉冲的时序图','Callback', @acquisition.sync_settings_Callback);

item=[0 item(2)+item(4)+margin*0.2 parentitem(3)/4*2 2];
handles.ac_laserstatus = uicontrol(handles.uipanelac_laser,'Style','edit','units','characters','HorizontalAlignment','center','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','N/A','tag','ac_laserstatus','FontName','FixedWidth','BackgroundColor',[1 0 0],'Foregroundcolor',[0 0 0],'Enable','inactive','Fontweight','bold','TooltipString','激光状态');

item=[parentitem(3)/4*2 item(2) parentitem(3)/4*2 2];
handles.ac_lasertoggle = uicontrol(handles.uipanelac_laser,'Style','Pushbutton','String','切换激光','Fontweight','bold','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.lasertoggle_Callback,'Tag','ac_lasertoggle','TooltipString','打开和关闭激光','interruptible','off','busyaction','cancel');

item=[0 item(2)+item(4)+margin*0.1 parentitem(3)/2 1.5];
handles.ac_enable_ext_trigger = uicontrol(handles.uipanelac_laser,'Style','checkbox','String','外部触发','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ac_enable_ext_trigger','TooltipString','使用 PIVlab-SimpleSync 的外部触发输入','Callback', @acquisition.ext_trigger_xmsync_settings_Callback,'Visible','off');

item=[0 item(2) parentitem(3)/2 1.5];
handles.ac_enable_ext_trigger_oltsync = uicontrol(handles.uipanelac_laser,'Style','Pushbutton','String','触发模式','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ac_enable_ext_trigger_oltsync','TooltipString','配置 PIVlab-SimpleSync 的触发输入','Callback', @acquisition.ext_trigger_oltsync_settings_Callback,'Visible','off');

item=[item(3) item(2) parentitem(3)/2 1.5];
handles.ac_device_control = uicontrol(handles.uipanelac_laser,'Style','pushbutton','String','设备','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'TooltipString','设置外部设备（如遥控播撒装置等）','Callback',@acquisition.device_control_Callback);


%item=[parentitem(3)/4*2.5 item(2) parentitem(3)/4*1.5 2];
%handles.ac_ext_trigger_settings = uicontrol(handles.uipanelac_laser,'Style','Pushbutton','String','设置','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @ac_ext_trigger_settings_Callback,'TooltipString','Setup external trigger input on PIVlab-SimpleSync');


% Camera settings
parentitem=get(handles.multip24, 'Position');
item=[0 23.5 parentitem(3) 7+1.5];
handles.uipanelac_camsettings = uipanel(handles.multip24, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','相机设置','fontweight','bold');

parentitem=get(handles.uipanelac_camsettings, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/8 parentitem(3)/4.1 1.5];
handles.ac_calibBinning = uicontrol(handles.uipanelac_camsettings,'Style','pushbutton','String','像素合并','Units','characters', 'Fontunits','points','Position',[item(1)+margin*0.1 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2*0.1 item(4)],'Callback', @acquisition.calibBinning_Callback,'Tag','ac_calibBinning','TooltipString','选择像素合并');

item=[parentitem(3)/4.1*1  item(2) parentitem(3)/4.1 1.5];
handles.ac_calibROI = uicontrol(handles.uipanelac_camsettings,'Style','pushbutton','String','ROI','Units','characters', 'Fontunits','points','Position',[item(1)+margin*0.1 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2*0.1 item(4)],'Callback', @acquisition.calibROI_Callback,'Tag','ac_calibROI','TooltipString','在相机图像中选择 ROI');

item=[parentitem(3)/4.1*2  item(2) parentitem(3)/4.1 1.5];
handles.ac_lensctrl = uicontrol(handles.uipanelac_camsettings,'Style','pushbutton','String','镜头','Units','characters', 'Fontunits','points','Position',[item(1)+margin*0.1 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2*0.1 item(4)],'Callback', @acquisition.lens_control_Callback,'Tag','ac_lensctrl','TooltipString','控制相机镜头');

item=[parentitem(3)/4.1*3  item(2) parentitem(3)/4.1 1.5];
handles.ac_camera_setup = uicontrol(handles.uipanelac_camsettings,'Style','pushbutton','String','设置','Units','characters', 'Fontunits','points','Position',[item(1)+margin*0.1 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2*0.1 item(4)],'Callback', @acquisition.camera_setup_Callback,'Tag','ac_camera_setup','TooltipString','配置所选相机');


item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.ac_cam_helper_txt = uicontrol(handles.uipanelac_camsettings,'Style','text','units','characters','HorizontalAlignment','left','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','显示（实时叠加）：');
item=[0 item(2)+item(4)+margin/8 parentitem(3)/2 1.5];
handles.ac_displ_sharp = uicontrol(handles.uipanelac_camsettings,'Style','checkbox','String','清晰度','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin/2-item(2) item(3)-margin*1 item(4)],'Tag','ac_displ_sharp','TooltipString','显示清晰度','Callback', @acquisition.display_cam_overlay_Callback,'Visible','on');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.ac_displ_grid = uicontrol(handles.uipanelac_camsettings,'Style','checkbox','String','网格','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin/2-item(2) item(3)-margin*1 item(4)],'Tag','ac_displ_grid','TooltipString','显示网格','Callback', @acquisition.display_cam_overlay_Callback,'Visible','on');

%item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1.5];
%not working at the moment...
handles.ac_displ_hist = uicontrol(handles.uipanelac_camsettings,'Style','checkbox','String','直方图','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin/2-item(2) item(3)-margin*1 item(4)],'Tag','ac_displ_hist','TooltipString','显示直方图','Callback', @acquisition.display_cam_overlay_Callback,'Visible','off');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
handles.calib_dolivedetect = uicontrol(handles.uipanelac_camsettings,'Style','checkbox','String','标定','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin/2-item(2) item(3)-margin*1 item(4)],'Tag','calib_dolivedetect','TooltipString','实时标记检测与图像存储。','Callback',@preproc.cam_live_detect_Callback);

item=[parentitem(3)/2*1 item(2) parentitem(3)/2 1.5];
handles.ac_realtime_PIV = uicontrol(handles.uipanelac_camsettings,'Style','checkbox','String','位移','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin/2-item(2) item(3)-margin*1 item(4)],'Tag','ac_realtime_PIV','TooltipString','实时位移估算');


% Calib capture

parentitem=get(handles.multip24, 'Position');
item=[0 27.5+3.5+1.75 parentitem(3) 4.5];

handles.uipanelac_calib = uipanel(handles.multip24, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','实时图像','fontweight','bold');

parentitem=get(handles.uipanelac_calib, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3)/2 1];
handles.ac_expotxt = uicontrol(handles.uipanelac_calib,'Style','text', 'String','曝光时间（ms）：','Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1];
handles.ac_expo = uicontrol(handles.uipanelac_calib,'Style','edit','units','characters','HorizontalAlignment','right','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','50','tag','ac_expo','TooltipString','标定图像采集期间的相机曝光','Callback', @acquisition.exposure_Callback);

item=[0 item(2)+item(4)+margin*0.25 parentitem(3)/4 1.5];
handles.ac_calibcapture = uicontrol(handles.uipanelac_calib,'Style','pushbutton','String','开始','Units','characters', 'Fontunits','points','Position',[item(1)+margin*0.25 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2*0.25 item(4)],'Callback', @acquisition.calibcapture_Callback,'Tag','ac_calibcapture','TooltipString','开始相机实时预览','interruptible','on','BusyAction','queue');

item=[parentitem(3)/4*1 item(2) parentitem(3)/4 1.5];
handles.ac_calibsnapshot = uicontrol(handles.uipanelac_calib,'Style','pushbutton','String','快照','Units','characters', 'Fontunits','points','Position',[item(1)+margin*0.25 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2*0.25 item(4)],'Callback', @acquisition.camera_snapshot_Callback,'Tag','ac_calibsnapshot','TooltipString','保存当前显示','enable','on','interruptible','on','BusyAction','queue');

item=[parentitem(3)/4*2 item(2) parentitem(3)/4 1.5];
handles.ac_calibsave = uicontrol(handles.uipanelac_calib,'Style','pushbutton','String','保存','Units','characters', 'Fontunits','points','Position',[item(1)+margin*0.25 parentitem(4)-item(4)-margin-item(2) item(3)-margin*2*0.25 item(4)],'Callback', @acquisition.camera_stop_Callback,'Tag','ac_calibsave','TooltipString','保存最后一幅图像','enable','off');

% PIV capture
parentitem=get(handles.multip24, 'Position');
item=[0 33+3.5+1.75 parentitem(3) 5];
handles.uipanelac_capture = uipanel(handles.multip24, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','采集 PIV 图像', 'Tag','uipanelac_capture','fontweight','bold');

parentitem=get(handles.uipanelac_capture, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 1];
handles.ac_imgamounttxt = uicontrol(handles.uipanelac_capture,'Style','text', 'String','图像数量：','Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/4 1];
handles.ac_imgamount = uicontrol(handles.uipanelac_capture,'Style','edit','units','characters','HorizontalAlignment','right', 'enable','off','position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'String','100','tag','ac_imgamount','TooltipString','要采集的双图像数量。若为红色：内存很可能不足。','Callback',@acquisition.image_amount_Callback);

%live PIV preview disabled
item=[parentitem(3)/2+parentitem(3)/4 item(2) parentitem(3)/4 1];
handles.ac_realtime = uicontrol(handles.uipanelac_capture,'Style','checkbox','units','characters','HorizontalAlignment','right','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3) item(4)],'Value',0,'String','实时','tag','ac_realtime','TooltipString','启用实时 PIV','Callback',@acquisition.realtime_Callback,'Visible','off');

item=[0 item(2)+item(4)+margin*0.25 parentitem(3)/3 1.5];
handles.ac_pivcapture = uicontrol(handles.uipanelac_capture,'Style','pushbutton','String','开始','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.piv_capture_Callback,'TooltipString','开始 PIV 图像采集和激光','interruptible','on','BusyAction','queue');

item=[parentitem(3)/3*1 item(2) parentitem(3)/5 1.5];
handles.ac_pivcapture_save = uicontrol(handles.uipanelac_capture,'Style','checkbox','units','characters','HorizontalAlignment','right','position',[item(1) parentitem(4)-item(4)-margin-item(2) item(3) item(4)],'Value',0,'String','保存','tag','ac_pivcapture_save','TooltipString','保存 PIV 双图像','Callback',@acquisition.pivcapture_save_Callback);

item=[parentitem(3)/3*1+parentitem(3)/5 item(2) parentitem(3)/5 1.5];
handles.ac_auto_interframe = uicontrol(handles.uipanelac_capture,'Style','Pushbutton','String','自动','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ac_auto_interframe','TooltipString','自动确定合适的帧间时间','Callback', @acquisition.automatic_interframe,'Visible','off');


item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1.5];
handles.ac_pivstop = uicontrol(handles.uipanelac_capture,'Style','pushbutton','String','中止','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @acquisition.camera_stop_Callback,'Tag','ac_pivstop','TooltipString','取消采集并丢弃图像');

parentitem=get(handles.multip24, 'Position');
item=[0 30.5 parentitem(3) 2];
handles.ac_msgbox = uicontrol(handles.multip24,'Style','edit', 'Fontname','fixedwidth', 'enable','inactive','Max', 3, 'min', 1, 'String',{'欢迎使用 PIVlab','图像采集！'},'Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','ac_msgbox','TooltipString','消息','visible','off');
set(handles.ac_msgbox,'BackgroundColor', get (handles.ac_msgbox,'BackgroundColor')*0.95); %dim msgbox color


%% camera calibration
handles.multip26 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','相机标定', 'Tag','multip26','fontweight','bold');
parentitem=get(handles.multip26, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 34];
handles.calib_imagedata = uipanel(handles.multip26, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','标定图像数据','fontweight','bold');

parentitem=get(handles.calib_imagedata, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.calib_undist_cam_label=uicontrol(handles.calib_imagedata,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'FontWeight','bold','Tag','calib_undist_cam_label');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.calib_load_imgs = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','加载标定板图像','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_calibration_loadimages_Callback,'TooltipString','加载标定板图像');

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.calib_use_tilted_model = uicontrol(handles.calib_imagedata,'Style','checkbox','String','Scheimpflug 适配器（倾斜传感器模型）','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_use_tilted_model','Callback', @preproc.cam_togglescheimpflug_Callback,'TooltipString','为带 Scheimpflug 适配器的相机启用 CALIB_TILTED_MODEL');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.calib_estimateparams = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','估算相机参数','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_estimateparams_Callback,'TooltipString','检测 Charuco 标记并估算相机参数');

item=[0 item(2)+item(4)+margin/2 parentitem(3)/2 1.5];
handles.calib_saveparams = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','保存参数','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_saveparams_Callback,'TooltipString','将相机参数保存到文件');

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.calib_loadparams = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','加载参数','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_loadparams_Callback,'TooltipString','从文件加载相机参数');

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 1.5];
handles.calib_clearparams = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','清除参数','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_clearparams_Callback,'TooltipString','清除相机参数');

item=[0 item(2)+item(4)+margin parentitem(3) 1.5];
uicontrol(handles.calib_imagedata,'Style','text', 'String','标定检查','Fontweight','bold','Units','characters', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.calib_showreproject = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','显示重投影误差','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_showreproject_Callback,'TooltipString','显示重投影误差（有效去畸变应低于 1 像素）');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.calib_showcams = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','显示相机位置','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_show_cam_position_Callback,'TooltipString','显示相机位置');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.calib_showdistortion = uicontrol(handles.calib_imagedata,'Style','pushbutton','String','显示镜头畸变','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_showdistortion_Callback,'TooltipString','显示相机镜头畸变');

item=[0 item(2)+item(4)+margin parentitem(3) 1.5];
uicontrol(handles.calib_imagedata,'Style','text', 'String','应用标定','Units','characters','Fontweight','bold', 'Fontunits','points','HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[0 item(2)+item(4)+margin/4 parentitem(3)/3*2 1.5];
uicontrol(handles.calib_imagedata,'Style','text','String','输出图像尺寸：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/3*2 item(2) parentitem(3)/3 1.5];
handles.calib_viewtype = uicontrol(handles.calib_imagedata,'Style','popupmenu','String',{'裁掉黑边','与输入图像同尺寸','包含黑边'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_viewtype','TooltipString','选择如何处理黑边','Callback',@preproc.cam_change_viewtype_Callback);

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.calib_usecalibration = uicontrol(handles.calib_imagedata,'Style','checkbox','String','启用相机标定', 'Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_usecalibration','TooltipString','启用相机标定/去畸变','Callback', @preproc.cam_enable_cam_calib_Callback);

%% camera rectification
handles.multip27 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','图像校正', 'Tag','multip27','fontweight','bold');
parentitem=get(handles.multip27, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 32];
handles.rect_imagedata = uipanel(handles.multip27, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','校正图像数据','fontweight','bold');

parentitem=get(handles.rect_imagedata, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.calib_rect_cam_label=uicontrol(handles.rect_imagedata,'Style','text','String','N/A','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'FontWeight','bold','Tag','calib_rect_cam_label');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.rect_load_imgs = uicontrol(handles.rect_imagedata,'Style','pushbutton','String','加载标定板图像','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_rectification_loadimages_Callback,'TooltipString','加载一张与目标坐标系对齐且在激光片光内的标定板图像。');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.rect_show_points = uicontrol(handles.rect_imagedata,'Style','pushbutton','String','显示检测到的标记','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_rectification_show_points_Callback,'TooltipString','显示所有可检测的点');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.rect_show_rectified = uicontrol(handles.rect_imagedata,'Style','pushbutton','String','显示校正后的标定板','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_rectification_show_rectified_Callback,'TooltipString','显示去畸变后的标定板预览');

item=[0 item(2)+item(4)+margin/2 parentitem(3) 1.5];
handles.rect_show_cam_position = uicontrol(handles.rect_imagedata,'Style','pushbutton','String','显示相机位置','Units','characters', 'Fontunits','points','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_rectification_show_cam_position_Callback,'TooltipString','显示相机和标定板位置的 3D 场景');

item=[0 item(2)+item(4)+margin parentitem(3)/2 1.5];
uicontrol(handles.rect_imagedata,'Style','text','String','上采样：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/4*3 item(2) parentitem(3)/4 1.5];
handles.calib_upscale = uicontrol(handles.rect_imagedata,'Style','popupmenu','String',{'1x' '2x'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_upscale','TooltipString','上采样因子可减少图像插值的影响，但会使分析变慢','Callback', @preproc.cam_rectification_upscale_Callback);

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.calib_userectification = uicontrol(handles.rect_imagedata,'Style','checkbox','String','启用图像校正', 'Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_userectification','TooltipString','使用图像校正','Callback', @preproc.cam_enable_cam_rectification_Callback);


%% Marker board setup
handles.multip28 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','标定板设置', 'Tag','multip28','fontweight','bold');
parentitem=get(handles.multip28, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 15];
handles.calib_markersetup = uipanel(handles.multip28, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','属性','fontweight','bold');

parentitem=get(handles.calib_markersetup, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3)/2 1.5];
uicontrol(handles.calib_markersetup,'Style','text','String','标定板类型：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.calib_boardtype = uicontrol(handles.calib_markersetup,'Style','popupmenu','String',{'ChArUco DICT_4X4_1000'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_boardtype','TooltipString','选择标定板类型');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
uicontrol(handles.calib_markersetup,'Style','text','String','原点颜色：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.calib_origincolor = uicontrol(handles.calib_markersetup,'Style','popupmenu','String',{'Black' 'White'},'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_origincolor','TooltipString','左上角棋盘格的颜色');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
uicontrol(handles.calib_markersetup,'Style','text','String','行数：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.calib_rows = uicontrol(handles.calib_markersetup,'Style','edit','String','23','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_rows','TooltipString','棋盘格的行数');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
uicontrol(handles.calib_markersetup,'Style','text','String','列数：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.calib_columns = uicontrol(handles.calib_markersetup,'Style','edit','String','24','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_columns','TooltipString','棋盘格的列数');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
uicontrol(handles.calib_markersetup,'Style','text','String','棋盘格尺寸：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.calib_checkersize = uicontrol(handles.calib_markersetup,'Style','edit','String','10','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_checkersize','TooltipString','棋盘格尺寸');

item=[0 item(2)+item(4) parentitem(3)/2 1.5];
uicontrol(handles.calib_markersetup,'Style','text','String','标记尺寸：','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);

item=[parentitem(3)/2 item(2) parentitem(3)/2 1.5];
handles.calib_markersize = uicontrol(handles.calib_markersetup,'Style','edit','String','8','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Tag','calib_markersize','TooltipString','标记尺寸');

item=[0 item(2)+item(4)+margin parentitem(3)/1.5 1.5];
handles.calib_find_params = uicontrol(handles.calib_markersetup,'Style','pushbutton','String','猜测参数','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'TooltipString','自动猜测 Charuco 参数','Callback', @preproc.cam_find_charuco_parameters_Callback);

%{
item=[0 0 0 0];
parentitem=get(handles.multip28, 'Position');
item=[0 item(2)+item(4)+15+margin parentitem(3) 5];
handles.calib_livedetection = uipanel(handles.multip28, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','Image acquisition settings','fontweight','bold');
parentitem=get(handles.calib_livedetection, 'Position');
item=[0 0 0 0];

item=[0 item(2)+margin / 4 parentitem(3) 1.5];
handles.calib_dolivedetect = uicontrol(handles.calib_livedetection,'Style','checkbox','String','Enable live detection + storage','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_live_detect_Callback,'Tag','calib_dolivedetect','TooltipString','实时标记检测与图像存储。');
%}
item=[0 0 0 0];
parentitem=get(handles.multip28, 'Position');
item=[0 item(2)+item(4)+20+margin*2 parentitem(3) 5];
handles.calib_generate = uipanel(handles.multip28, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','标定板生成','fontweight','bold');
parentitem=get(handles.calib_generate, 'Position');
item=[0 0 0 0];

item=[0 item(2)+margin / 4 parentitem(3) 1.5];
handles.calib_generateboard = uicontrol(handles.calib_generate,'Style','pushbutton','String','生成 Charuco 标定板','Value',0,'Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'Callback', @preproc.cam_generateboard_Callback,'TooltipString','生成合适的 Charuco 标定板');

%% Marker board setup
handles.multip29 = uipanel(MainWindow, 'Units','characters', 'Position', [0+margin Figure_Size(4)-panelheightpanels-margin panelwidth panelheightpanels],'title','显示相关矩阵', 'Tag','multip29','fontweight','bold');
parentitem=get(handles.multip29, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4) parentitem(3) 15];
handles.plot_correlation_matrices= uipanel(handles.multip29, 'Units','characters', 'Position', [item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'title','属性','fontweight','bold');

parentitem=get(handles.plot_correlation_matrices, 'Position');
item=[0 0 0 0];

item=[0 item(2)+item(4)+margin/4 parentitem(3) 1.5];
handles.retrieve_correlation_matrices = uicontrol(handles.plot_correlation_matrices,'Style','pushbutton','String','获取相关矩阵','Units','characters','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)],'TooltipString','获取当前显示帧所有遍的相关矩阵','Callback', @plot.correlation_matrices_calculate);

item=[0 item(2)+item(4)+margin/4 parentitem(3) 5];
uicontrol(handles.plot_correlation_matrices,'Style','text','String','获取相关矩阵后，点击矢量可查看所有遍的相关矩阵。','Units','characters', 'HorizontalAlignment','left','Position',[item(1)+margin parentitem(4)-item(4)-margin-item(2) item(3)-margin*2 item(4)]);



%% Image acquisition: load last device and COM port
try
    warning off
    load('PIVlab_settings_default.mat','last_selected_device','last_selected_fps','last_selected_pulsedist','last_selected_energy');
    if exist('last_selected_device','var')
        if ~isempty(last_selected_device)
            set(handles.ac_config, 'value',last_selected_device);
        else
            set(handles.ac_config, 'value',1);
        end
    end
    if exist('last_selected_fps','var')
        if ~isempty(last_selected_fps)
            pause(0.01)
            set(handles.ac_fps, 'value',last_selected_fps);
        else
            set(handles.ac_fps, 'value',1);
        end
    end
    if exist('last_selected_pulsedist','var')
        set(handles.ac_interpuls, 'String',last_selected_pulsedist);
    end
    if exist('last_selected_energy','var')
        set(handles.ac_power, 'String',last_selected_energy);
    end
    load('PIVlab_settings_default.mat','selected_com_port');
    if exist('selected_com_port','var') && ~isempty(selected_com_port)
        gui.put('selected_com_port',selected_com_port);
    end
    %warning on
catch
end
gui.put('multitiff',0); %default for compatibility: Not a multitiff.
gui.put('pcopanda_dbl_image',0); %default for compatibility: Not a multitiff.
gui.put('stereomode',0); % default: Not stereo mode
disp('-> UI generated.')