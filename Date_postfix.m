function currentDateStr=Date_postfix()
% ��ȡ��ǰʱ��
currentTime = clock;

% ��ȡ������
currentYear = num2str(currentTime(1));
currentMonth = num2str(currentTime(2), '%02d');
currentDay = num2str(currentTime(3), '%02d');

% ���Ϊ�ַ�������
currentDateStr = [currentYear, '-', currentMonth, '-', currentDay];
end

