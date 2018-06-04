function feats=ch_temko(sig,sc,len, fs_orig,fs,Num,Den,olap,i)    
    % load feature list of Temko features
    load('feature_list.mat')
    data = double(sig{i}*sc);
    dat = filter(Num, Den, data); 
    dat = resample(dat,fs,fs_orig);
    feats_ch=cell(1);
    n=0;
    for ii=4*fs+1:(len-olap)*fs:length(dat)
        n=n+1;
        % check for the end of data
        if ii+len*fs-1 > length(dat)
            break
        else
            epoch=dat(ii:ii+len*fs-1);
            % check for half epoch imp checks
            tt=len*fs/2;
            if mean(abs(epoch(1:tt)))<10^-4
                feats_ch{n}=ones(1,55)*NaN;
            elseif mean(abs(epoch(tt:end)))<10^-4
                feats_ch{n}=ones(1,55)*NaN;
            else
                feats_ch{n}=feats_temko(epoch,fs,feature_list);
            end
        end
        
    end
    feats=feats_ch;
end