function c3dtotrc (filedata)
Basepath=filedata.Basepath;
load([Basepath '\US_raw.mat']);
Knee=filedata.Knee;
Ankle=filedata.Ankle;
Trial=filedata.Trial;
Subject=filedata.Subject;
filedata.trial=[];
newFPS=20;

for S=1:length(Subject) 
    Trc_path=append(filedata.Basepath,'\Moca\',Subject,'\');
for K=1:length(Knee)
    for A=1:length(Ankle)
        for T=1:length(Trial)
            fname=append(Knee(K),"_",Ankle(A),"_L_",Trial(T));
            markdatastruct = c3d_getdata(char(fullfile(Trc_path,append(fname,"_edited.c3d"))), 0);
            jupdata=markdatastruct.marker_data.Info.frequency/newFPS;
            Markerset=fieldnames(markdatastruct.marker_data.Markers);
            Markerset=Markerset(~contains(Markerset,'C_'));
            if (contains(Markerset,"US5")&contains(Markerset,"US4"))
                markdatastruct=marker_check(markdatastruct);
            end
            MarkerData=[markdatastruct.marker_data.Time(1:jupdata:end)];
            for i = 1:length(Markerset)
                RawMarker=markdatastruct.marker_data.Markers.(Markerset{i});
                [bb,aa] = butter(4, 0.05,'low');
                %     datafilt=filtfilt(bb,aa,MTable(:,5));
%                 offset=rawmarker(1,:);
                MarerDatafilt=filtfilt(bb,aa,RawMarker);
                MarkerData =[MarkerData MarerDatafilt(1:jupdata:end,:)];
            end
            [r,c]=size(MarkerData);
            markdatastruct.marker_data.Info.frequency=newFPS;
            markdatastruct.marker_data.Info.Last_Frame=r;
            markdatastruct.marker_data.Info.NumFrames=r;
            markdatastruct.marker_data.Info.Filename=erase(markdatastruct.marker_data.Info.Filename,'_edited');
            
            generate_Marker_Trc(Markerset,MarkerData,markdatastruct.marker_data.Info);
        end
    end
end
end
end