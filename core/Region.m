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
               row = bow(1); startCol=bow(2); endCol=bow(3);
               if (row < obj.boxHeight && startCol < obj.boxWidth && endCol < obj.boxWidth)
                   if (row<1)
                       row=row+(1-row);
                   end
                   if (startCol<1)
                       startCol=startCol+(1-startCol);
                   end
                   img(row, startCol:endCol) = 1;
               end
           end
       end
       
       function pack(obj)
           old = 1; new = 1;
           if (obj.numBows ~= 1)
              newBows = zeros(1,3);
              while (old<obj.numBows)
                  %copy a bow
                  newBows(new,:) = obj.bows(old,:);
                  old=old+1;
                  %summarize bows which overlap
                  while ((old < obj.numBows) && ...
                          newBows(new,3)+1 >= obj.bows(old,2) && ...
                          newBows(new,1) == obj.bows(old,1))
                      if (newBows(new,3) < obj.bows(old,3))
                          newBows(new,3) = obj.bows(old,3);
                      end
                      old=old+1;
                  end
                  new=new+1;
              end
              obj.bows=newBows;
              obj.numBows=size(obj.bows(:,1)); %TODO
           end
       end
       
   end
   
   %morphological methods
   methods(Static)
       function [Merged] = merge(Region1, Region2)
           Merged = Region;
           Merged.boxWidth = Region1.boxWidth;
           Merged.boxHeight = Region1.boxHeight;
           Merged.numBows = Region1.numBows + Region2.numBows;
           i = 1; j = 1; k = 1; % loop indices for Region1, Region2, Merged
           while(true)
               if(Region1.bows(i,1) < Region2.bows(j,1) || ...
                       (Region1.bows(i,1) == Region2.bows(j,1) && ...
                       Region1.bows(i,2) < Region2.bows(j,2)) )
                   Merged.bows(k,:) = Region1.bows(i,:);
                   i=i+1; k=k+1;
                   if (i == Region1.numBows)
                       while (j ~= Region2.numBows) 
                           Merged.bows(k,:) = Region2.bows(j,:); j=j+1; k=k+1; 
                       end
                       %Merged.numBows=Merged.numBows-1; %TODO
                       break 
                   end
               else
                   Merged.bows(k,:) = Region2.bows(j,:);
                   j=j+1; k=k+1;
                   if (j == Region2.numBows)
                       while (i ~= Region1.numBows) 
                           Merged.bows(k,:) = Region1.bows(i,:); i=i+1; k=k+1; 
                       end
                       %Merged.numBows=Merged.numBows-1; %TODO
                       break 
                   end
               end
           end
           Merged.numBows=size(Merged.bows(:,1)); %TODO
       end
       
       %translate Region1 into Trans using translation vector T=[x,y]
       %TODO: is it useful to scale box too?
       function [Trans] = translate(Region1, T)
           Trans = Region;
           Trans.numBows = Region1.numBows;
           Trans.boxWidth = Region1.boxWidth;% + T(1);
           Trans.boxHeight = Region1.boxHeight;% + T(2);
           for  i = 1:Region1.numBows
               old = Region1.bows(i,:);
               Trans.bows(i,:) = [old(1)+T(2), old(2:3)+T(1)];
           end
       end
       
       
   end
    
end