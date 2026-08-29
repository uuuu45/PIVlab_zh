function generateMenu
MainWindow=getappdata(0,'hgui');
%% Menu items
m1 = uimenu(MainWindow,'Label','文件');
uimenu(m1,'Label','新建会话','Callback',@import.loadimgs_Callback,'Accelerator','N');
m2 = uimenu(m1,'Label','加载');
uimenu(m2,'Label','加载图像','Callback',@load_images_dummy);
uimenu(m2,'Label','导入 PIVlab 设置','Callback',@import.load_settings_Callback);
uimenu(m2,'Label','加载 PIVlab 会话','Separator','on','Callback',@import.load_session_Callback);
m3 = uimenu(m1,'Label','保存');
uimenu(m3,'Label','保存当前 PIVlab 设置','Callback',@export.save_settings_Callback);
uimenu(m3,'Label','保存 PIVlab 会话','Separator','on','Callback',@export.save_session_Callback);
m14 = uimenu(m1,'Label','导出');
uimenu(m14,'Label','静态图像或动画','Callback',@export.pixel_data);
uimenu(m14,'Label','文本文件 (ASCII)','Callback',@export.ascii_chart_Callback);
uimenu(m14,'Label','MAT 文件','Callback',@export.matlab_file_Callback);
uimenu(m14,'Label','Tecplot 文件','Callback',@export.tecplot_file_Callback);
uimenu(m14,'Label','Paraview 二进制 VTK','Callback',@export.paraview_Callback);
uimenu(m14,'Label','所有结果到 Matlab 工作区','Callback',@export.write_workspace_Callback);
uimenu(m1,'Label','首选项','Callback',@gui.preferences_Callback);
m_mode = uimenu(m1,'Label','模式');
uimenu(m_mode,'Label','基础','Tag','menu_mode_basic','Callback',@(~,~) gui.request_mode_switch('basic'));
uimenu(m_mode,'Label','高级','Tag','menu_mode_advanced','Callback',@(~,~) gui.request_mode_switch('advanced'));
m4 = uimenu(m1,'Label','退出','Separator','on','Callback',@gui.exitpivlab_Callback);
m51 = uimenu(MainWindow,'Label','图像采集');
uimenu(m51,'Label','采集 PIV 图像','Callback',@acquisition.capture_images_Callback);
m5 = uimenu(MainWindow,'Label','图像设置');
m5_1=uimenu(m5,'Label','相机标定（镜头/畸变）','Tag','menu_camcalib');
uimenu(m5_1,'Label','设置/定义/生成标定板','Callback',@preproc.cam_marker_setup_Callback);
m5_2=uimenu(m5_1,'Label','相机标定（去畸变）');
uimenu(m5_2,'Label','相机 1','Callback',@preproc.cam_calibration_Callback);
uimenu(m5_2,'Label','相机 2','Callback',@preproc.cam_calibration_Callback,'enable','off');
m5_3=uimenu(m5_1,'Label','图像校正/对齐');
uimenu(m5_3,'Label','相机 1','Callback',@preproc.cam_rectification_Callback);
uimenu(m5_3,'Label','相机 2','Callback',@preproc.cam_rectification_Callback,'enable','off');
uimenu(m5,'Label','图像预处理/增强','Callback',@preproc.Uielement_Callback,'Accelerator','I');

uimenu(m5,'Label','定义感兴趣区域 (ROI)','Callback',@roi.img_ROI_Callback,'Accelerator','E');
uimenu(m5,'Label','定义遮罩（从分析中排除区域）','Callback',@mask.img_mask_new_Callback);

m6 = uimenu(MainWindow,'Label','分析');
uimenu(m6,'Label','PIV 设置','Callback',@piv.sett_Callback,'Accelerator','S');
m6a=uimenu(m6,'Label','立体 PIV 设置','Callback',[],'Tag','menu_stereopiv');
uimenu(m6a,'Label','视差校正','Callback',[],'Enable','off');
uimenu(m6,'Label','分析！','Callback',@piv.do_analys_Callback,'Accelerator','A');
m7 = uimenu(MainWindow,'Label','验证');
uimenu(m7,'Label','基于速度的验证','Callback',@validate.vector_val_Callback,'Accelerator','V');
uimenu(m7,'Label','基于图像的验证','Callback',@validate.image_val_Callback,'Tag','menu_imgvalidation');
m8 = uimenu(MainWindow,'Label','空间标定（px → mm）');
uimenu(m8,'Label','使用当前或外部图像标定','Callback',@calibrate.cal_actual_Callback,'Accelerator','Z');
m9 = uimenu(MainWindow,'Label','绘图');
uimenu(m9,'Label','空间：导出参数/修改数据','Callback',@plot.derivs_Callback,'Accelerator','D');
uimenu(m9,'Label','时间：导出参数','Callback',@plot.temporal_derivs_Callback);
uimenu(m9,'Label','修改绘图外观','Callback',@plot.modif_plot_Callback,'Accelerator','M');
uimenu(m9,'Label','流线','Callback',@plot.streamlines_Callback);
uimenu(m9,'Label','标记/距离/角度','Callback',@extract.dist_angle_Callback,'Accelerator','T');
uimenu(m9,'Label','相关矩阵','Callback',@plot.correlation_matrices_Callback,'Tag','menu_corrmatrices');
uimenu(m9,'Label','第二显示器显示（实验性）','Separator','on','Callback',@gui.toggle_second_monitor_Callback,'tag','2ndmonitor');
m10 = uimenu(MainWindow,'Label','提取');
uimenu(m10,'Label','折线参数','Callback',@extract.poly_extract_Callback,'Accelerator','P');
uimenu(m10,'Label','区域参数','Callback',@extract.area_panel_activation_Callback,'Accelerator','Q');
m11 = uimenu(MainWindow,'Label','统计');
uimenu(m11,'Label','统计','Callback',@plot.statistics_Callback,'Accelerator','B');
m12 = uimenu(MainWindow,'Label','合成粒子图像生成','Tag','menu_partgen');
uimenu(m12,'Label','设置','Callback',@simulate.part_img_sett_Callback,'Accelerator','G');
m13 = uimenu(MainWindow,'Label','学习！');
uimenu(m13,'Label','教程视频','Callback',@gui.pivlabyoutube_Callback);
uimenu(m13,'Label','入门手册','Callback',@gui.pivlabhelp_Callback,'Accelerator','H');
uimenu(m13,'Label','PIVlab 手册','Callback',@gui.pivlabmanual_Callback);
uimenu(m13,'Label','论坛','Callback',@misc.Forum_Callback);
uimenu(m13,'Label','交互式相关演示','Callback',@misc.correlation_demo_Callback);
uimenu(m13,'Label','键盘快捷键列表','Callback',@misc.shortcuts_Callback);
uimenu(m13,'Label','关于','Callback',@gui.aboutpiv_Callback);
uimenu(m13,'Label','网站','Callback',@misc.Website_Callback);
uimenu(m13,'Label','如何引用 PIVlab','Callback',@misc.howtocite_Callback);
menuhandles = findall(getappdata(0,'hgui'),'type','uimenu'); %das soll gemacht werden laut Hilfe
set(menuhandles,'HandleVisibility','off');
disp('-> Menu generated.')

function load_images_dummy(~,~,~) % dummy function that performs two callbacks for loading images.
    import.loadimgs_Callback
    drawnow
    import.loadimgsbutton_Callback([],[],1,[])