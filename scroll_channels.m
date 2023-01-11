function f = scroll_channels(raw,lims,varargin)
    
    ognargin = nargin;
    % chan x time
    % ylimits
    % OPTIONAL : second data set to plot of equal size.
    
    f = figure('Position',[ 119 1063 2277 509]);
    
    ax=axes(f)
    zoomed=axes(f,'position',[.55 .77 .35 .15]);box on 
    set(f,'CurrentAxes',ax)
    p = uipanel(f,'Position',[0 0 1 0.075]);
    c = uicontrol(p,'Style','slider');    
    c.Position = [500 10 1000 15]
    c.Min = 0;c.Max = 1;
    
    if size(raw,1)==1
        c.SliderStep = [1 1];
    else
        c.SliderStep = [1/(size(raw,1)-1) 1/(size(raw,1)-1)];
    end
    set(c,'Callback',@SliderChangeFunction);
    
    
    
    plot(ax,raw(1,:),'Color','k');ylim(ax,lims);xlim(ax,[1 size(raw,2)])
    p2 = plot(zoomed,raw(1,1:round(size(raw,2)/50)),'Color','k');;ylim(zoomed,get(zoomed,'YLim'));xlim(zoomed,[1 round(size(raw,2)/50)])

    
    a=annotation('textbox',[.92 .65 .3 .3],'String',sprintf('Channel: %i / %i',1,size(raw,1)),'FitBoxToText','on');

    if ognargin > 2
        hold on;plot(varargin{1}(1,:),'Color',[.6 .6 .6]);end
    
        function SliderChangeFunction(hObject,eventdata)
          delete(a)
          slidervalues = linspace(0,1,size(raw,1));
          [~,ind2plot]=min(abs((hObject.Value - slidervalues)));      
          a=annotation('textbox',[.92 .65 .3 .3],'String',sprintf('Channel: %i / %i',ind2plot,size(raw,1)),'FitBoxToText','on');
          cla
          plot(ax,raw(ind2plot,:),'Color','k');ylim(ax,lims);xlim(ax,[1 size(raw,2)])
          p2 = plot(zoomed,raw(ind2plot,1:round(size(raw,2)/50)),'Color','k');ylim(zoomed,get(zoomed,'YLim'));xlim(zoomed,[1 round(size(raw,2)/50)])

          if ognargin > 2
            hold on;plot(varargin{1}(ind2plot,:),'Color',[.6 .6 .6]);end

        end
    

end