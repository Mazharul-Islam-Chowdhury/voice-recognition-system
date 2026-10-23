function feat = mfcc_basic(y, fs, fsTargetLocal, numCoeffsLocal)
    if size(y,2) > 1, y = mean(y,2); end
    if fs ~= fsTargetLocal
        y = resample(y, fsTargetLocal, fs);
        fs = fsTargetLocal;
    end
    y = y ./ max(1e-9, max(abs(y))); % normalize
    preEmph = 0.97;
    y = filter([1 -preEmph], 1, y);
    frameLen = round(0.025*fs);
    frameHop = round(0.010*fs);
    Nfft = 2^nextpow2(frameLen);
    if length(y) < frameLen
        y(end+1:frameLen) = 0;
    end
    numFrames = floor((length(y)-frameLen)/frameHop)+1;
    frames = zeros(frameLen,numFrames);
    for ii = 1:numFrames
        idx = (1:frameLen) + (ii-1)*frameHop;
        frames(:,ii) = y(idx).*hamming(frameLen);
    end
    S = abs(fft(frames,Nfft)).^2;
    S = S(1:Nfft/2+1,:);
    % Mel filterbank (manual, no melbankm)
    numFilters = 26;
    fmin = 0; fmax = fs/2;
    mel = @(f) 2595*log10(1 + f/700);
    invmel = @(m) 700*(10.^(m/2595)-1);
    mels = linspace(mel(fmin), mel(fmax), numFilters+2);
    hz = invmel(mels);
    bins = floor((Nfft+1)*hz/fs);
    H = zeros(numFilters, size(S,1));
    for m = 1:numFilters
        f_m_minus = bins(m);
        f_m = bins(m+1);
        f_m_plus = bins(m+2);
        for k = max(1,f_m_minus):min(size(S,1), f_m)
            H(m,k) = (k - f_m_minus) / max(1,(f_m - f_m_minus));
        end
        for k = max(1,f_m):min(size(S,1), f_m_plus)
            H(m,k) = (f_m_plus - k) / max(1,(f_m_plus - f_m));
        end
    end
    E = H*S; E(E<=1e-12)=1e-12;
    logE = log(E);
    coeffs = dct(logE);
    coeffs = coeffs(1:numCoeffsLocal,:);
    feat = mean(coeffs,2)';
end
