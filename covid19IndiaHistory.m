%author
%Astick Banerjee
%Disclaimer: since it is Spline Interpotlation the expected value may not
%be correct

%Covid-19 India Unofficial json api of official data
history_api= 'https://api.rootnet.in/covid19-in/stats/history';
char expectedValue;
%covidPatientDataIndia = webread(api);
covidHistoryData = webread(history_api);
data = covidHistoryData.data;
n = length(data);
totalArray = [];
for i =1:n
    date = data(i).day;
    total = data(i).summary.total;
    totalArray = [totalArray,total];
    %disp(date)
    %disp(totalArray)
end
%Exact data of covid-19 India
today = data(n).day;
%disp(today)
dayArray = 1:1:n;
plot(dayArray,totalArray,'bo'); hold on;

%Interpolation using Spline
% n+2 denotes the next two day prediction 
dayA = 1:1:n+1;
sArr = spline(dayArray,totalArray,dayA);
plot(dayA,sArr,'-k');hold on;
text(dayArray(n)+.3,sArr(n),['(' today ' , '  num2str(sArr(n)),')'])
plot(dayA(n+1),sArr(n+1),'ro');
title('Covid - 19 India Case Prediction')
%tday = split(today,"-");
%u =str2double(tday(3))+3;
%disp(u)
text(dayA(n+1)+.3,sArr(n+1),['( Tomorrow ,'  num2str(int32(sArr(n+1))),')'])
xlabel('Days')
ylabel('Total Case')
legend({'Original', 'Spline Interpolation', 'Expected'},'Location','northwest' );
expectedValue = int32(sArr(n+1));
disp("Today's total Covid-19 +ve Case : " + int32(sArr(n)))
disp("Tomorrow will be (expected): " + expectedValue)







