function [hxFitP,hyFitP] = computeSecondOrderCorrection()

    % Load the data from C415 chip1
    % y -> Difference between the measured value and the target one
    xHxM = [-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13];
    xHyM = [-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13];
    yHxM = [11.9187418507416,14.0635501563865,10.1228545179180,6.59431798377239,6.09135391013828,5.19679108956824,3.46781548570905,2.73815401549856,3.37352987585388,0.481358117598666,-2.44278981363264,-5.43307627774381,-7.52947966326611,-6.73831846204881,-6.12842742111352,-4.98762869063661,-2.38533810996795,0.951763966037212,3.09412425787273,3.48405697989941,4.07589228342985,4.94866503536259,4.63647160303397,3.44597027254714,4.02727589139591,2.88113842315967,2.03071230315713];
    yHyM = [-9.96198914914731,-8.88891274741983,-6.60310860322886,-8.58575746777701,-8.69653677926613,-8.93195045173709,-6.07823723881549,-8.15877724950083,-7.95367777057461,-6.22117090062693,-4.46463166260815,-3.05609550937506,-2.09618100910190,-2.44840199424457,-2.94028541328738,-4.00971849183514,-4.77095217367751,-5.56910234809951,-6.03423329100651,-7.07881093498922,-7.59844298635206,-8.96972830521102,-8.71140606365899,-8.44555123644721,-7.12815537869526,-8.02587829172676,-9.30133212578011];
    
    % Restrict the holes considered on the range -10:10
    hInd = and(xHxM<=10,xHxM>=-10);
    
    % Data to fit
    xD = xHxM(hInd);
    hxD = yHxM(hInd);
    hyD = yHyM(hInd);
    
    % Fitting the generalized gaussian
    hxFitP = lsqcurvefit(@genGauss,[5 -12 2 2],xD,hxD);
    hyFitP = lsqcurvefit(@genGauss,[-8 6 2 2],xD,hyD);
    
    % Fitted curve
    hxFit = genGauss(hxFitP,xD);
    hyFit = genGauss(hyFitP,xD);
    
    % Plot the result
    figure;
    plot(xD,hxD,'xb');
    hold on;
    plot(xD,hxFit,'-b');
    plot(xD,hyD,'xr');
    plot(xD,hyFit,'-r');
    grid on;
    xlabel('Hole index','FontSize',17);
    ylabel('L_{meas} - L_{design}','FontSize',17);
    legend('hx - data','hx - fit','hy - data','hy - fit','Location','Best');%,'FontSize',17)
    set(gca,'FontSize',17);
    
    

end