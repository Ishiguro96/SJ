function comp_hist(X, bin)

figure;
histfit(X, bin, 'Normal');

% Normalize histogram
Y = get(gca, 'YTick');
set(gca, 'YTick', Y, 'YTickLabel', Y/numel(X));

end