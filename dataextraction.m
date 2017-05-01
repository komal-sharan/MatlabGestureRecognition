
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%creatinggraphs from raw data for each
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%gesture and mote%%%%%%%%%%%%%%%%%%%%%%
forplotsender0(:,:)=0;
forplotsender1(:,:)=0;
forplotsendertest(:,:)=0;


gesturelist={"circle","dodge","jump","kick","punch","rand","wave","void"}
windowing(:,:)=0;


for gesturename=1:1
  
filen=sprintf('/Users/komalsharan/Desktop/BigData/data/%s/%s',string(gesturelist(gesturename)),'*.log');
fnames = dir(filen);
numfids = length(fnames);
vals = cell(1,numfids);

for K = 1:numfids
    
% opening a file and extracting gesture name and mote number from its name
forfid=sprintf('/Users/komalsharan/Desktop/BigData/data/%s/%s',string(gesturelist(gesturename)),fnames(K).name);
fid=fopen(forfid);
gesture=strsplit(fnames(K).name,'_') ;
gesturelabel=gesture(1);
disp(gesturelabel);
mote=gesture(3);
mote=char(mote);
mote=strsplit(mote,'B');
mote=char(mote(2));
mote=strsplit(mote,'.');
mote=mote(1);



% reading byte by byte from the binary file
data=fread(fid,Inf,'int16');
tmp=uint16(data);

sampleid=1
sampleid0=1
sampleid1=1
count=0
[row,column]=size(tmp);
i=4;
disp(row);
% popluting array containing the intensity values sampleid by sampleid for
% the graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while i<row-2
 
       j=i-2;
       A=typecast(tmp(j),'uint8');
       
       if A(2) == 1
           
         forplotsender0(str2double(char(mote)),sampleid0)=swapbytes(uint16(tmp(i))); 
         
         sampleid0=sampleid0+1;
       end
       
       if A(2) == 2
         forplotsender1(str2double(char(mote)),sampleid1)=swapbytes((tmp(i))); 
         
         sampleid1=sampleid1+1;
       end   
     i=i+4;    
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose(fid);
end
[rows_0,columns_0]=size(forplotsender0);
[rows_1,columns_1]=size(forplotsender1);



figure
subplot(2,1,1)
for i=1:13
plot(1:columns_0, forplotsender0(i,:));

hold on;

end
title(gesturelabel)

subplot(2,1,2) 
for i=1:13 
plot(1:columns_1, forplotsender1(i,:));
hold on;

end

title(gesturelabel)
end






for eventname=1:1
eventfilen=sprintf('/Users/komalsharan/Desktop/BigData/event /%s/%s',string(gesturelist(eventname)),'*.event');
%hardcodedname='circle_tt.event';

fnames = dir(eventfilen);
numfids = length(fnames);
vals = cell(1,numfids);
% for K = 1:numfids
disp("imhere");
% forfidevent=sprintf('/Users/komalsharan/Desktop/BigData/event /%s/%s',string(gesturelist(eventname)),fnames(K).name);
fid=fopen(hardcodedname); 

[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14]=textread(hardcodedname,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s');
A(:,:,:,:,:,:,:,:,:,:,:,:,:)=[str2double(str(m1)),str2double(str(m2)),str2double(str(m3)),str2double(str(m4)),str2double(str(m5)),str2double(str(m6)),str2double(str(m7)),str2double(str(m8)),str2double(str(m9)),str2double(str(m10)),str2double(str(m11)),str2double(str(m12)),str2double(str(m13)),str2double(str(m14))]
disp(A)
x=cell2str(str2double(A(1,1)));
windownum=1;
values=1
j=1
for i=1:13
    while j<41
        windownum=windownum+1
        start=A(j,i)/4 +4
        ends=A(j+1,i)/4 +4
     for sample=start:ends
       windowing(windownum,values)=forplotsender0(str2double(mote),sample) 
       disp(windowing)
       values=values+1
     end
    end
end
  
% end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%windowingends%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         
% 
% 
% 
% 
% 
% 





