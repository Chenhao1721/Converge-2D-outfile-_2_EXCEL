function currentDateStr=Date_postfix()
% 获取当前时间
currentTime = clock;

% 提取年月日
currentYear = num2str(currentTime(1));
currentMonth = num2str(currentTime(2), '%02d');
currentDay = num2str(currentTime(3), '%02d');

% 组合为字符串数组
currentDateStr = [currentYear, '-', currentMonth, '-', currentDay];
end

