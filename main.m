%% 选择Converge Case 输出的2D结果文件路径（.out）
% MATLAB R2019a 以及 NewVersion 可正常使用
clear all;clc;
FILENAME_2DOUT="I:\C_ConvergeCaseResultsBackup\Height16_SOA35_0401\AIA_0_20B5A"; %Converge Case 输出的2D结果文件路径，修改此处即可
species_mass_region1_filename=append(FILENAME_2DOUT, "\species_mass_region1.out");
species_mass_region2_filename=append(FILENAME_2DOUT,"\species_mass_region2.out");
species_mass_region3_filename=append(FILENAME_2DOUT,"\species_mass_region3.out");
regions_flow_filename=append(FILENAME_2DOUT,"\regions_flow.out");
%% 从.out文件提取数据至MATLAB double变量
simulation_time = import_simulation_time(species_mass_region1_filename);
O2_CO2_MassInCylinder = import_O2_CO2_MassCylinder(species_mass_region1_filename);    O2_CO2_MassInCylinder=O2_CO2_MassInCylinder.*1E06;
O2_CO2_MassInExhaust = import_O2_CO2_MassCylinder(species_mass_region2_filename);     O2_CO2_MassInExhaust=O2_CO2_MassInExhaust.*1E06;
O2_CO2_MassInIntake = import_O2_CO2_MassCylinder(species_mass_region3_filename);       O2_CO2_MassInIntake=O2_CO2_MassInIntake.*1E06;
EV_SP_flowrate= import_EV_SP_flowrate(regions_flow_filename);
total_mass_SP= import_total_mass_SP(regions_flow_filename);                                                 total_mass_SP=total_mass_SP.*1E06;
RGF_Cylider = O2_CO2_MassInCylinder(:,2)./44*29.8 ./ (O2_CO2_MassInCylinder(:,1)./32.*28.92+O2_CO2_MassInCylinder(:,2)./44*29.8);
RGF_Exhaust = O2_CO2_MassInExhaust(:,2)./44*29.8 ./ (O2_CO2_MassInExhaust(:,1)./32.*28.92+O2_CO2_MassInExhaust(:,2)./44*29.8);
RGF_Intake = O2_CO2_MassInIntake(:,2)./44*29.8 ./ (O2_CO2_MassInIntake(:,1)./32.*28.92+O2_CO2_MassInIntake(:,2)./44*29.8);
%% 计算扫气参数
REF_MASS=468;   % 进气状态下工作容积参考充量:mg
max_deliveryFreshCharge=max(abs(total_mass_SP));
FreshCharge_retained=O2_CO2_MassInCylinder (end,1);
ResidualGas =O2_CO2_MassInCylinder (end,2);
TrappedCylinderCharge=ResidualGas+FreshCharge_retained;
TrappingEfficiency=FreshCharge_retained/max_deliveryFreshCharge;
DeliveryRatio=max_deliveryFreshCharge/REF_MASS;
ScavengingEfficiency=FreshCharge_retained/TrappedCylinderCharge;
ChargeEfficiency=DeliveryRatio*TrappingEfficiency;
%% 生成EXCEL sheet1
%由于不会修改输出路径，excel输出在M文件所在文件夹下 =_=
title_excel=["Time/s","O2 in Cylinder/mg","CO2 in Cylinder/mg", "O2 in Exhaust/mg","CO2 in Exhaust/mg","O2 in Intake/mg","CO2 in Intake/mg"...
"FlowRate at EV/kg s-1","FlowRate at SP/kg s-1","TotalMass at SP/mg"];
data_excel= [simulation_time O2_CO2_MassInCylinder O2_CO2_MassInExhaust O2_CO2_MassInIntake EV_SP_flowrate total_mass_SP]; %必须保证维度与Excel输出区域一致
extract_casename=strsplit(FILENAME_2DOUT,'\');
name_excel=append(extract_casename(end),'_',Date_postfix(),'.xlsx');

writematrix(title_excel,name_excel,'Sheet',1,'Range','A1:J2') %将该矩阵写入 M.xlsx 文件第1个工作表，从第x行x列开始写入。
writematrix(data_excel,name_excel,'Sheet',1,'Range','A2:J165') 
%% 生成EXCEL sheet2
title_excel_basic=["FreshChargeRetained/mg","ResidualGas/mg","DeliveryFreshCharge/mg","TrappedCylinderCharge/mg"];
data_excel_basic= [FreshCharge_retained ResidualGas max_deliveryFreshCharge TrappedCylinderCharge];
writematrix(title_excel_basic,name_excel,'Sheet',2,'Range','A1:D1') 
writematrix(data_excel_basic,name_excel,'Sheet',2,'Range','A2:D2') 

title_excel_Parameters=["DeliveryRatio/-";"TrappingEfficiency/-";"ChargeEfficiency/-";"ScavengingEfficiency/-"];
data_excel_Parameters= [DeliveryRatio;TrappingEfficiency;ChargeEfficiency;ScavengingEfficiency;];
writematrix(title_excel_Parameters,name_excel,'Sheet',2,'Range','A4:A7') 
writematrix(data_excel_Parameters,name_excel,'Sheet',2,'Range','B4:B7') 

title_excel_name=["CaseName"];
data_excel_name= extract_casename(end);
writematrix(title_excel_name,name_excel,'Sheet',2,'Range','A10:A10') 
writematrix(data_excel_name,name_excel,'Sheet',2,'Range','B10:B10') 



