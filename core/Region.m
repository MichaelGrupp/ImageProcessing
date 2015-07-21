%A Region is a memory-efficient way to store segmented image regions
%each line of the region consists of bows that define neighbouring pixels
classdef Region <handle
   properties
       bows = zeros(1,3); %matrix of bows, a bow consists of row, startCol, endCol
       numBows = 1;
       boxWidth
       boxHeight
   end
   
   methods
       %extract the bows from a segmented image
       %all pixels inside the region have to equal 1
       function extractBows(obj, img)
          [m,n] = size(img);
          obj.boxHeight=m; obj.boxWidth=n;
          bowCount = 0; found=0;
          for i = 1:m
              for j = 1:n
                if (found==0 && img(i,j)==1)
                    found = 1;
                    obj.numBows = obj.numBows+1;
                    bowCount=bowCount+1;
                    obj.bows(bowCount,:)=[i,j,j]; %a bow start was found
                elseif (found==1 && img(i,j)==0)
                    found = 0;
                    obj.bows(bowCount,3)=j-1; %end of a bow at j-1
                end
              end
              if (found==1)
                  obj.bows(bowCount,3)=j; %end of a bow at right border
                  found = 0;
              end
          end
          obj.numBows=obj.numBows-1; %needed because we init with 1...
       end
       
       function [img] = draw(obj)
           img = zeros(obj.boxHeight, obj.boxWidth);
           for i = 1:obj.numBows
               bow = obj.bows(i,:);
               %row = bow(1); startCol=bow(2); endCol=bow(3);
               img(bow(1), bow(2):bow(3)) = 1;
           end
       end
       
   end
   
   %morphological methods
   methods(Static)
       function [Merged] = merge(Region1, Region2)
           Merged = Region;
           Merged.numBows = Region1.numBows + Region2.numBows;
           i = 1; j = 1; k = 1; % loop indices for Region1, Region2, Merged
           while(true)
               if(Region1.bows(i,1) < Region2.bows(j,1) || (Region1.bows(i,1) == Region2.bows(j,1) && Region1.bows(i,2) < Region2.bows(j,2)) )
                   Merged.bows(k,:) = Region1.bows(i,:);
                   i=i+1; k=k+1;
                   if (i > Region1.numBows)
                       while (j ~= Region2.numBows) Merged.bows(k,:) = Region2.bows(j,:); j=j+1; k=k+1; end
                       Merged.numBows=Merged.numBows-1; %TODO
                       break 
                   end
               else
                   Merged.bows(k,:) = Region2.bows(j,:);
                   j=j+1; k=k+1;
                   if (j > Region2.numBows)
                       while (i ~= Region1.numBows) Merged.bows(k,:) = Region1.bows(i,:); i=i+1; k=k+1; end
                       Merged.numBows=Merged.numBows-1; %TODO
                       break 
                   end
               end
           end
       end
   end
    
end