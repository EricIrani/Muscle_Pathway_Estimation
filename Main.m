clear all
Pardata=importdata('C:\MyCloud\GitHub\AddresseforMusclepathwayproject.txt');
Data.Basepath=Pardata{1};
Data.Subject=["p7"];
% Data.Knee = ["K0","K30","K60","K90","K110"];
Data.Knee = ["K30"];
% Data.Ankle = ["0","D10","P30"];
Data.Ankle = ["0"];
Data.Trial = ["1","2","3"];
% US_Data_prepration(Data);
% Running_IK(Data);
% CombiningData(Data);
% MCP_Calculator(Data);
WrapObject_Calculator(Data);
FinalData=Momentarm_Calculator(Data);