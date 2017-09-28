function syst=x3d_body(syst)

%% GPL here
% This function builds an x3d model

disp('Adding default body graphics data...');

color=[0.5;0.5;0.5];
x3d_tags = {'ground','upright','strut','wheel','chassis','bell','rack','a-arm','engine block'};  %% Define significant body names

for i=1:syst.data.nbodys  %% Loop over each body
	if(strfind(syst.data.bodys(i).x3d,'.x3d'))

		disp('Inserting listed x3d file...');
		x3d=[ '<Inline url=''"' syst.data.bodys(i).x3d '"''/>\n'];
		syst.data.bodys(i).x3d='';

	else
		x3d=[x3d_pnt([0;0;0],'cubes','rad',[0.08;0.08;0.08],'col',[1 0 0],'tran',0.3)];  %% Define default x3d string

		for j=1:length(x3d_tags)  %% Loop over each sig. name
			if(strfind(syst.data.bodys(i).name,x3d_tags{j}))  %% If the body name contains a sig. name, replace the default string

				lcn=syst.data.bodys(i).location;  %% Record that body's location

				switch (x3d_tags{j})  %% Which signame did we find?

					case 'ground'
						x3d=[x3d_cyl([[0;0;0] [0;0;-0.01]],'rad',3,'col',[0 0.5 0],'tran',0.5)];
						x3d=[x3d x3d_pnt([0;0;0],'cubes','rad',[3;1.5;0.01],'col',[0.5;0.5;0.5],'tran',0.5)];

					case 'upright'
						disp('Adding upright...');
						x3d=[x3d_pnt([0;0;0],'rad',0.03,'col',[1;0;0])];

					case 'strut'
						disp('Adding strut...');
						x3d=[x3d_pnt([0;0;0],'rad',0.03,'col',[1;0;0])];

					case 'a-arm'
						disp('Adding a-arm...');
						x3d=[x3d_pnt([0;0;0],'rad',0.03,'col',[1;0;0])];

					case 'wheel'
						disp('Adding wheel...');
						x3d=[x3d_pnt([[0;0;0]],'cubes','rad',[2.2*lcn(3);0.001;2.2*lcn(3)],'tran',0.8,'col',[1;1;1])];
						x3d=[x3d x3d_cyl([[0;abs(lcn(3))/4;0] [0;-abs(lcn(3))/4;0]],'rad',abs(lcn(3)),'col',0.1*[1;1;1],'tran',0.4)];
						x3d=[x3d x3d_cyl([[0;abs(lcn(3))/3.9;0] [0;-abs(lcn(3))/3.9;0]],'rad',0.8*abs(lcn(3)),'col',[0.5;0.5;0.5],'tran',0.6)];
	%					x3d=[x3d x3d_pnt([[0;0.047;lcn(3)-0.05]],'rad',0.03,'col',[1;1;1],'tran',0.6)];
	%					x3d=[x3d x3d_pnt([[0;-0.047;lcn(3)-0.05]],'rad',0.03,'col',[1;1;1],'tran',0.6)];

					case 'chassis'
						disp('Adding chassis...');
						color=rand(3,1);
						x3d=[x3d_pnt([0;0;0] ,'cubes','rad',[1.2;0.3;0.5],'tran',0.3,'col',color)];
						% x3d=[x3d x3d_pnt([0;0;0] ,'cubes','rad',[0.9;1.8;1],'tran',0.3,'col',color)];

					case 'bell'
						disp('Adding bellcrank...');
						color=[0.3 0.3 0.6];
						x3d=[x3d_pnt([0;0;0] ,'cubes','rad',[0.04 0.04 0.04],'col',color)];

					case 'rack'
						disp('Adding rack...');
						color=rand(3,1);
						x3d=[x3d_cyl([[0;-0.1;0] [0;0.1;0]],'rad',0.05,'col',color)];

					case 'engine block'
						disp('Adding engine block...');
						x3d=[x3d_pnt([0;0;0],'cubes','rad',[1;0.7;0.75],'col',[0.5 0.5 0.5],'tran',0.3)];
				end
			end
		end
	end
syst.data.bodys(i).x3d=[syst.data.bodys(i).x3d x3d];  %% Add the x3d to the body
end

end  %% Leave