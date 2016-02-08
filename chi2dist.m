function d = chi2dist(h1, h2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the chi^2 distance between two histograms
%
% Input:
%       h1, h2,     input histograms
% Output:
%       d,          distance between histograms
%
% ----------------
% Aleksandrs Ecins
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Normalize the histograms
h1 = h1 ./ (sum(h1) + eps);
h2 = h2 ./ (sum(h2) + eps);

% Compute distance
d = 1/2 * ((h1-h2).^2)' * (1./(h1+h2+eps));
