function [scale, elongate] = getFilterParameters(mode)

tmp = regexp(mode,'_','split');
match = cellfun(@(x) strcmp(x, 'malik'), tmp);
matchIdx = find(match);

scaleStr = tmp{matchIdx+1};
scaleStr = strrep(scaleStr, 'x', '.');
scale = str2double(scaleStr);

elongateStr = tmp{matchIdx+2};
elongateStr = strrep(elongateStr, 'x', '.');
elongate = str2double(elongateStr);
