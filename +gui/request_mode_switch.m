function switched = request_mode_switch(new_mode)
% request_mode_switch  Handle an interactive Basic/Advanced mode change.
%
% Switching modes resets all GUI settings to their defaults.  If the user has
% already produced analysis results (resultslist populated), a confirmation
% dialog is shown first, because those results were produced with the current
% (about to be reset) settings.  With no results there is nothing to lose, so
% the switch happens silently.
%
% Returns true if the mode was actually switched, false if unchanged/cancelled.

switched = false;
hgui = getappdata(0,'hgui');

current = gui.retr('ui_mode');
if isempty(current); current = 'advanced'; end
if strcmp(new_mode, current)
    return   % already in this mode — nothing to do
end

% Warn only when there is analysis work that the reset could devalue.
resultslist = gui.retr('resultslist');
if ~isempty(resultslist)
    answer = gui.custom_msgbox('quest', hgui, '切换界面模式', ...
        ['切换界面模式会将所有设置重置为默认值。' newline newline ...
         '您的分析结果会保留，但产生这些结果的设置 ' ...
         '将被还原。' newline newline '继续？'], ...
        'modal', {'是','否'}, '否');
    if ~strcmp(answer, '是')
        return   % user cancelled — leave everything as it is
    end
end

gui.reset_to_defaults();
gui.apply_ui_mode(new_mode);

% Remember the choice in the default settings file (consistent with the rest
% of PIVlab's settings storage).
ui_mode = new_mode;
try
    save('PIVlab_settings_default.mat','ui_mode','-append');
catch
end

switched = true;
end
