

forplotsender0(:,:)=0;
forplotsender1(:,:)=0;

gesturelist={"circle"}


for gesturename=1:7
filen=sprintf('/Users/komalsharan/Desktop/BigData/data/%s/%s',string(gesturelist(gesturename)),'*.log');
fnames = dir(filen);
numfids = length(fnames);
vals = cell(1,numfids);

for K = 1:numfids
    
%opening a file and extracting gesture name and mote number from its name
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



%reading byte by byte from the binary file
data=fread(fid,Inf,'uint16');
tmp=uint16(data);
column=8
sampleid=1
sampleid0=1
sampleid1=1
count=0
[row]=size(tmp);

% popluting array containing the intensity values sampleid by sampleid for
% the graph

for i=1:row-2
   j=1;
     while j<column
      if count == 0
        j=j+3;
        count=1;
      end
      if count == 1 
        j=j+4;
        count = 0;
      
      end
       k=j-1;
       if tmp(k)== 0
        
        forplotsender0(str2double(char(mote)),sampleid0)=tmp(j);
        sampleid0=sampleid0+1;
       end
       if tmp(k)== 256
         
        forplotsender1(str2double(char(mote)),sampleid1)=tmp(j);
        sampleid1=sampleid1+1;
       end
       % sampleid=sampleid+1;
       
      
    end
      
      
end

fclose(fid);
end
[rows_0,columns_0]=size(forplotsender0);
[rows_1,columns_1]=size(forplotsender1);


%figure
%subplot(2,1,1)
%for i=1:13
%plot(1:columns_0, forplotsender0(i,:));

%hold on;

%end
%title(gesturelabel)

%subplot(2,1,2) 
%for i=1:13 
%plot(1:columns_1, forplotsender1(i,:));
%hold on;
% i++;
%end

%title(gesturelabel)

end




 



  














