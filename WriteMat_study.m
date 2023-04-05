M = magic(5)
title=["Mercury/mg","Gemini","Apollo", "Skylab","Skylab B"]
writematrix(title,'M.xls','Sheet',1,'Range','A2:E2') %将该矩阵写入 M.xls 文件中的第1个工作表，从第三行开始写入。
writematrix(M,'M.xls','Sheet',1,'Range','A3:E8') %将该矩阵写入 M.xls 文件中的第1个工作表，从第三行开始写入。
