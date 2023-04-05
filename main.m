%% ѡ��Converge Case �����2D����ļ�·����.out��
% MATLAB R2019a �Լ� NewVersion ������ʹ��
clear all;clc;
FILENAME_2DOUT="I:\C_ConvergeCaseResultsBackup\Height16_SOA35_0401\AIA_0_20B5A"; %Converge Case �����2D����ļ�·�����޸Ĵ˴�����
species_mass_region1_filename=append(FILENAME_2DOUT, "\species_mass_region1.out");
species_mass_region2_filename=append(FILENAME_2DOUT,"\species_mass_region2.out");
species_mass_region3_filename=append(FILENAME_2DOUT,"\species_mass_region3.out");
regions_flow_filename=append(FILENAME_2DOUT,"\regions_flow.out");
%% ��.out�ļ���ȡ������MATLAB double����
simulation_time = import_simulation_time(species_mass_region1_filename);
O2_CO2_MassInCylinder = import_O2_CO2_MassCylinder(species_mass_region1_filename);    O2_CO2_MassInCylinder=O2_CO2_MassInCylinder.*1E06;
O2_CO2_MassInExhaust = import_O2_CO2_MassCylinder(species_mass_region2_filename);     O2_CO2_MassInExhaust=O2_CO2_MassInExhaust.*1E06;
O2_CO2_MassInIntake = import_O2_CO2_MassCylinder(species_mass_region3_filename);       O2_CO2_MassInIntake=O2_CO2_MassInIntake.*1E06;
EV_SP_flowrate= import_EV_SP_flowrate(regions_flow_filename);
total_mass_SP= import_total_mass_SP(regions_flow_filename);                                                 total_mass_SP=total_mass_SP.*1E06;
RGF_Cylider = O2_CO2_MassInCylinder(:,2)./44*29.8 ./ (O2_CO2_MassInCylinder(:,1)./32.*28.92+O2_CO2_MassInCylinder(:,2)./44*29.8);
RGF_Exhaust = O2_CO2_MassInExhaust(:,2)./44*29.8 ./ (O2_CO2_MassInExhaust(:,1)./32.*28.92+O2_CO2_MassInExhaust(:,2)./44*29.8);
RGF_Intake = O2_CO2_MassInIntake(:,2)./44*29.8 ./ (O2_CO2_MassInIntake(:,1)./32.*28.92+O2_CO2_MassInIntake(:,2)./44*29.8);
%% ����ɨ������
REF_MASS=468;   % ����״̬�¹����ݻ��ο�����:mg
max_deliveryFreshCharge=max(abs(total_mass_SP));
FreshCharge_retained=O2_CO2_MassInCylinder (end,1);
ResidualGas =O2_CO2_MassInCylinder (end,2);
TrappedCylinderCharge=ResidualGas+FreshCharge_retained;
TrappingEfficiency=FreshCharge_retained/max_deliveryFreshCharge;
DeliveryRatio=max_deliveryFreshCharge/REF_MASS;
ScavengingEfficiency=FreshCharge_retained/TrappedCylinderCharge;
ChargeEfficiency=DeliveryRatio*TrappingEfficiency;
%% ����EXCEL sheet1
%���ڲ����޸����·����excel�����M�ļ������ļ����� =_=
title_excel=["Time/s","O2 in Cylinder/mg","CO2 in Cylinder/mg", "O2 in Exhaust/mg","CO2 in Exhaust/mg","O2 in Intake/mg","CO2 in Intake/mg"...
"FlowRate at EV/kg s-1","FlowRate at SP/kg s-1","TotalMass at SP/mg"];
data_excel= [simulation_time O2_CO2_MassInCylinder O2_CO2_MassInExhaust O2_CO2_MassInIntake EV_SP_flowrate total_mass_SP]; %���뱣֤ά����Excel�������һ��
extract_casename=strsplit(FILENAME_2DOUT,'\');
name_excel=append(extract_casename(end),'_',Date_postfix(),'.xlsx');

writematrix(title_excel,name_excel,'Sheet',1,'Range','A1:J2') %���þ���д�� M.xlsx �ļ���1���������ӵ�x��x�п�ʼд�롣
writematrix(data_excel,name_excel,'Sheet',1,'Range','A2:J165') 
%% ����EXCEL sheet2
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



