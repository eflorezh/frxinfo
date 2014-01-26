//+------------------------------------------------------------------+
//|                                           History_in_MathCAD.mq5 |
//|                                                    Privalov S.V. |
//|                           https://login.mql5.com/en/users/Prival |
//+------------------------------------------------------------------+
#include <stringlib.mqh>
#import "libmysql.dll"
   int mysql_init(int db);
   int mysql_errno(int TMYSQL);
   int mysql_real_connect(int TMYSQL, string& host, string& user, string& password,
                           string& DB,int port,int socket,int clientflag);
   int mysql_real_query(int TMYSQL,string& query, int lenght);
   void mysql_close(int TMSQL);                        
   string mysql_error(int TMYSQL); //string is ansi
#import
string MySqlHost   ="localhost"; //MySql Host:
string MySqlUser   ="root";     //MySQL User:
string MySqlPass   ="k4k4Zer0";      //MySQL Password:
string MySqlDB     ="frxInfo";     //MySQL Table:
int    MySqlPort   =3306;        //MySQL Port:
string MySqlSocket ="";          //MySQL Socket:
input int    MySqlFlag   =0;           //MySQL Flag:
int mysql   =0;
string query1="";
string query2="";
MqlTick tick;

int NQ = 12; //Buffer size to execute the query .

#property copyright "Privalov S.V."
#property link      "https://login.mql5.com/en/users/Prival"
#property version   "1.08"

//+------------------------------------------------------------------+
//|                                                      DA_Demo.mq5 |
//|                        Copyright 2011, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Artem Galeev"
#property link      "http://www.mql5.com"
#property version   "1.00"
//--- indicator input parameters
input int                BearsPower_PeriodBears=13;          // Bears Power period
input int                BullsPower_PeriodBulls=13;          // Bulls Power period 
input int                CCI_PeriodCCI         =13;           // CCI period
input ENUM_APPLIED_PRICE CCI_Applied           =PRICE_CLOSE; // CCI applied price
input int                DeM_PeriodDeM         =8;           // DeMarker period
input int                FraMA_PeriodMA        =12;          // FraMA period
input int                FraMA_Shift           =0;           // FraMA shift
input ENUM_APPLIED_PRICE FraMA_Applied         =PRICE_CLOSE; // FraMA applied price
input int                MACD_PeriodFast       =12;          // MACD fast MA period
input int                MACD_PeriodSlow       =24;          // MACD slow MA period
input int                MACD_PeriodSignal     =9;           // MACD signal line period
input ENUM_APPLIED_PRICE MACD_Applied          =PRICE_CLOSE; // MACD applied price
input int                RSI_PeriodRSI         =8;           // RSI period
input ENUM_APPLIED_PRICE RSI_Applied           =PRICE_CLOSE; // RSI applied price
input int                MFI_PeriodMFI         =7;           // MFI period
input int                RVI_PeriodRVI         =10;          // RVI period
input int                Stoch_PeriodK         =8;           // Stochastic K-period
input int                Stoch_PeriodD         =3;           // Stochastic D-period
input int                Stoch_PeriodSlow      =3;           // Stochastic Slowing period
input ENUM_STO_PRICE     Stoch_Applied         =STO_LOWHIGH; // Stochastic applied price
input int                WPR_PeriodWPR         =8;           // WPR period







//edwin

input int                AdaptativeMovAv_Period         =9;           // AMAI period
input int                AdaptativeMovAv_Desplazamiento         =0;           // AMAI period
input int                AdaptativeMovAv_Rapido         =2;           // AMAI period
input int                AdaptativeMovAv_Lento         =9;           // AMAI period
input ENUM_APPLIED_PRICE AdaptativeMovAv_Applied           =PRICE_CLOSE; // AMAI applied price

input int                AverageDirectionalMovAv_Period          =14;          // ADI period

input int                AverageDirectionalMovAvWil_Period         =14;          // ADWI period

input int                BB_Period           =20;             // BB period
input int                BB_Desplazamiento           =0;             // BB period
input int                BB_Desviacion           =2;             // BB period
input ENUM_APPLIED_PRICE BB_Applied         =PRICE_CLOSE;     // BB applied price

input int                DoubExpMA_Period           =14;             // DEMA period
input int                DoubExpMA_Desplazamiento           =0;             // BB period
input ENUM_APPLIED_PRICE DoubExpMA_Applied         =PRICE_CLOSE;     // DEMA applied price

input int                Envelopes_Period           =14;             // Envel period
input double             Envelopes_Desplazamiento           =0.1;             // BB period
input int                Envelopes_Desviacion           =1;             // BB period
input ENUM_APPLIED_PRICE Envelopes_Applied         =PRICE_CLOSE;     // Envel applied price
input ENUM_MA_METHOD     Envelopes_Method          =MODE_SMA;

input int                Ichimoku_Tenkan           =9;             // Ichimoku period
input int                Ichimoku_Kijun           =26;             // Ichimoku period
input int                Ichimoku_Senkou           =52;             // Ichimoku period


input int                MovingAver_Period     =10;           // MA period
input int                MovingAver_Desplazamiento     =0;           // MA period
input ENUM_APPLIED_PRICE MovingAver_Applied          =PRICE_CLOSE; // MA applied price
input ENUM_MA_METHOD     MovingAver_Method          =MODE_SMA;

input double                ParabolicSAR_Paso     =0.02;       // Parabolic paso
input double                ParabolicSAR_Maximo     =0.2;       // Parabolic paso

input int                StandarDesv_Period     =20;           // StandarDesv period
input int                StandarDesv_Desplazamiento     =0;           // StandarDesv period
input ENUM_APPLIED_PRICE StandarDesv_Applied          =PRICE_CLOSE; // StandarDesv applied price
input ENUM_MA_METHOD     StandarDesv_Method          =MODE_SMA;

input int                TripleExpMA_Period           =14;             // TripleExp period
input int                TripleExpMA_Desplazamiento     =1; 
input ENUM_APPLIED_PRICE TripleExpMA_Applied         =PRICE_CLOSE;     // TripleExp applied price

input int                VariableIndex_PeriodCMO           =9;             // VariableIndexp period CMO
input int                VariableIndex_Desplazamiento           =0;             // VariableIndexp period CMO
input int                VariableIndex_PeriodEMA           =12;             // VariableIndexp period EMA
input ENUM_APPLIED_PRICE VariableIndex_Applied         =PRICE_CLOSE;     // TripleExp applied price

input int                AverageTrue_Period           =14;             //  period

input int                ChaikinOsc_MArapida           =3;             //
input int                ChaikinOsc_MAlenta           =10;             // 
input ENUM_MA_METHOD     ChaikinOsc_Method          =MODE_SMA;
input ENUM_APPLIED_VOLUME ChaikinOsc_Applied         =PRICE_CLOSE;

input int                ForceIndex_Period     =13;           // period
input ENUM_MA_METHOD     ForceIndex_Method          =MODE_SMA;
input ENUM_APPLIED_VOLUME ForceIndex_Applied         =VOLUME_TICK;



input int                Momentum_Period           =14;             //  period
input ENUM_APPLIED_PRICE Momentum_Applied         =PRICE_CLOSE;     // applied price

input int                MovingAverOscill_PeriodFast     =12;           //  period
input int                MovingAverOscill_PeriodSlow     =26;           //  period
input int                MovingAverOscill_PeriodSignal     =9;           //  period
input ENUM_APPLIED_PRICE MovingAverOscill_Applied          =PRICE_CLOSE; // applied price

input int                RelativeVigor_Period     =10;           //  period

input int                MoneyFlowVolumen_Period           =14;             //  period
input ENUM_APPLIED_VOLUME MoneyFlowVolumen_Applied         =VOLUME_TICK; 

input int                Alligator_Mandibulas           =13;        
input int                Alligator_Desplazamiento1      =8;
input int                Alligator_Dientes              =8;
input int                Alligator_Desplazamiento2      =5;
input int                Alligator_Labios               =5;
input int                Alligator_Desplazamiento3      =3;
input ENUM_MA_METHOD     Alligator_Method          =MODE_SMA;
input ENUM_APPLIED_PRICE Alligator_Applied         =PRICE_MEDIAN;     //  applied price


input int                Gator_Mandibulas           =13;        
input int                Gator_Desplazamiento1      =8;
input int                Gator_Dientes              =8;
input int                Gator_Desplazamiento2      =5;
input int                Gator_Labios               =5;
input int                Gator_Desplazamiento3      =3;
input ENUM_MA_METHOD     Gator_Method          =MODE_SMA;
input ENUM_APPLIED_PRICE Gator_Applied         =PRICE_MEDIAN;     //  applied price


input int                TripleExpMAOscillator_Period           =14;             // TripleExp period
input ENUM_APPLIED_PRICE TripleExpMAOscillator_Applied         =PRICE_CLOSE;     // TripleExp applied price


//--- indicator input parameters for slow
input int                BearsPower_PeriodBears_s=26;          // Bears Power period
input int                BullsPower_PeriodBulls_s=26;          // Bulls Power period 
input int                CCI_PeriodCCI_s        =16;           // CCI period
input int                DeM_PeriodDeM_s         =16;           // DeMarker period
input int                FraMA_PeriodMA_s        =24;          // FraMA period
input int                MACD_PeriodFast_s       =24;          // MACD fast MA period
input int                MACD_PeriodSlow_s       =48;          // MACD slow MA period
input int                MACD_PeriodSignal_s     =18;           // MACD signal line period
input int                RSI_PeriodRSI_s         =16;           // RSI period
input int                MFI_PeriodMFI_s         =14;           // MFI period
input int                RVI_PeriodRVI_s         =20;          // RVI period
input int                Stoch_PeriodK_s         =16;           // Stochastic K-period
input int                Stoch_PeriodD_s         =6;           // Stochastic D-period
input int                Stoch_PeriodSlow_s      =6;           // Stochastic Slowing period
input int                WPR_PeriodWPR_s         =16;           // WPR period



//edwin

input int                AdaptativeMovAv_Period_s         =18;           // AMAI period
input int                AdaptativeMovAv_Rapido_s         =4;           // AMAI period
input int                AdaptativeMovAv_Lento_s         =36;           // AMAI period

input int                AverageDirectionalMovAv_Period_s          =28;          // ADI period

input int                AverageDirectionalMovAvWil_Period_s         =28;          // ADWI period

input int                BB_Period_s           =40;             // BB period
input int                BB_Desviacion_s           =4;             // BB period

input int                DoubExpMA_Period_s           =28;             // DEMA period

input int                Envelopes_Period_s           =28;             // Envel period

input int                Ichimoku_Tenkan_s           =18;             // Ichimoku period
input int                Ichimoku_Kijun_s           =52;             // Ichimoku period
input int                Ichimoku_Senkou_s           =104;             // Ichimoku period

input int                MovingAver_Period_s     =20;           // MA period

input double                ParabolicSAR_Paso_s     =0.04;       // Parabolic paso

input int                StandarDesv_Period_s     =40;           // StandarDesv period

input int                TripleExpMA_Period_s           =28;             // TripleExp period

input int                VariableIndex_PeriodCMO_s           =18;             // VariableIndexp period CMO
input int                VariableIndex_PeriodEMA_s           =24;             // VariableIndexp period EMA

input int                AverageTrue_Period_s           =28;             //  period

input int                ChaikinOsc_MArapida_s           =6;             //
input int                ChaikinOsc_MAlenta_s           =20;             // 

input int                ForceIndex_Period_s     =26;           // period

input int                Momentum_Period_s           =28;             //  period

input int                MovingAverOscill_PeriodFast_s     =24;           //  period
input int                MovingAverOscill_PeriodSlow_s     =32;           //  period

input int                RelativeVigor_Period_s     =20;           //  period

input int                MoneyFlowVolumen_Period_s           =28;             //  period

input int                Alligator_Mandibulas_s           =26;        
input int                Alligator_Dientes_s              =16;
input int                Alligator_Labios_s               =10;

input int                Gator_Mandibulas_s           =26;        
input int                Gator_Dientes_s              =16;
input int                Gator_Labios_s               =10;


input int                TripleExpMAOscillator_Period_s           =28;             // TripleExp period



//--- indicator handles
int h_AC,h_BearsPower,h_BullsPower,h_AO,h_CCI,h_DeMarker,h_FrAMA;
int h_MACD,h_RSI,h_MFI,h_Stoch,h_WPR;
int h_BearsPower_s,h_BullsPower_s,h_CCI_s,h_DeMarker_s,h_FrAMA_s;
int h_MACD_s,h_RSI_s,h_MFI_s,h_Stoch_s,h_WPR_s;
int h_BearsPower_f,h_BullsPower_f,h_CCI_f,h_DeMarker_f,h_FrAMA_f;
int h_MACD_f,h_RSI_f,h_RVI_f,h_Stoch_f,h_WPR_f;


//edwin
int h_AdaptativeMovAv,h_AverageDirectionalMovAv,h_AverageDirectionalMovAvWil,h_BB,h_DoubExpMA,h_Envelopes;
int h_Ichimoku,h_MovingAver,h_ParabolicSAR,h_StandarDesv,h_TripleExpMA,h_VariableIndex,h_AverageTrue,h_ChaikinOsc;
int h_ForceIndex,h_Momentum,h_MovingAverOscill,h_RelativeVigor,h_MoneyFlowVolumen,h_Alligator,h_Gator,h_TripleExpMAOscillator;
int h_AdaptativeMovAv_s,h_AverageDirectionalMovAv_s,h_AverageDirectionalMovAvWil_s,h_BB_s,h_DoubExpMA_s,h_Envelopes_s;
int h_Ichimoku_s,h_MovingAver_s,h_ParabolicSAR_s,h_StandarDesv_s,h_TripleExpMA_s,h_VariableIndex_s,h_AverageTrue_s,h_ChaikinOsc_s;
int h_ForceIndex_s,h_Momentum_s,h_MovingAverOscill_s,h_RelativeVigor_s,h_MoneyFlowVolumen_s,h_Alligator_s,h_Gator_s,h_TripleExpMAOscillator_s;
int h_AdaptativeMovAv_f,h_AverageDirectionalMovAv_f,h_AverageDirectionalMovAvWil_f,h_BB_f,h_DoubExpMA_f,h_Envelopes_f;
int h_Ichimoku_f,h_MovingAver_f,h_ParabolicSAR_f,h_StandarDesv_f,h_TripleExpMA_f,h_VariableIndex_f,h_AverageTrue_f,h_ChaikinOsc_f;
int h_ForceIndex_f,h_Momentum_f,h_MovingAverOscill_f,h_RelativeVigor_f,h_MoneyFlowVolumen_f,h_Alligator_f,h_Gator_f,h_TripleExpMAOscillator_f;




//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
      //Data base opening connection
      int res0 = initDB();
      int res1 = initIndicators();
      
      int year0 = 2011;
      int month0 = 1;
      int day = 1;
      
      WriteMonth(day,month0,year0); 
      
      //Para cada año
      /*for(int i=year0;i<=yearF;i++){
         int fromM = 1;
         int toM=12;
         if(i==year0)
            fromM = month0;
         if(i==yearF)
            toM = monthF;
         //Para cada mes
         for(int j=fromM;j<=toM;j++){
            
         } 
      }*/
      mysql_close(mysql);
      return;// script completed
  }
  
int initDB(){
   //Data base opening connection
   string host,user,pass,DB;
  if(MQL5InfoInteger(MQL5_DLLS_ALLOWED)==0)
      {
        Alert("DLL calling not allowed. Allow and try again!");
      }
   mysql=mysql_init(0);
   Print("obiectul mysql=",mysql);
   host=UNICODE2ANSI(MySqlHost);
   user=UNICODE2ANSI(MySqlUser);
   pass=UNICODE2ANSI(MySqlPass);
   DB=UNICODE2ANSI(MySqlDB);
   int res=mysql_real_connect(mysql,host,user,pass,DB,MySqlPort,MySqlSocket,MySqlFlag);
   Print("connection result=",res);
   if (res==mysql)
      Print("Successfully connected to the MySQL server!");
   else
     { 
      string s;
      s=mysql_error(mysql);     
      Print("Eroare de conectare = ",ANSI2UNICODE(s));
      return(0);
     } 
   return res;
}  

int initIndicators(){
   //--- initialization of indicators
   Print("Periodo ",fTimeFrameName(_Period));
   h_AC=iAC(Symbol(),Period());
   h_BearsPower=iBearsPower(Symbol(),Period(),BearsPower_PeriodBears);
   h_BullsPower=iBullsPower(Symbol(),Period(),BullsPower_PeriodBulls);
   h_AO=iAO(Symbol(),Period());
   h_CCI=iCCI(Symbol(),Period(),CCI_PeriodCCI,CCI_Applied);
   h_DeMarker=iDeMarker(Symbol(),Period(),DeM_PeriodDeM);
   h_FrAMA=iFrAMA(Symbol(),Period(),FraMA_PeriodMA,FraMA_Shift,FraMA_Applied);
   h_MACD=iMACD(Symbol(),Period(),MACD_PeriodFast,MACD_PeriodSlow,MACD_PeriodSignal,MACD_Applied);
   h_RSI=iRSI(Symbol(),Period(),RSI_PeriodRSI,RSI_Applied);
   h_MFI=iMFI(Symbol(),Period(),MFI_PeriodMFI,VOLUME_TICK);
   h_Stoch=iStochastic(Symbol(),Period(),Stoch_PeriodK,Stoch_PeriodD,Stoch_PeriodSlow,MODE_SMA,Stoch_Applied);
   h_WPR=iWPR(Symbol(),Period(),WPR_PeriodWPR);
   
   
   
   //edwin   
   h_AdaptativeMovAv=iAMA(Symbol(),Period(),AdaptativeMovAv_Period,AdaptativeMovAv_Rapido,AdaptativeMovAv_Lento,AdaptativeMovAv_Desplazamiento,AdaptativeMovAv_Applied);
   h_AverageDirectionalMovAv=iADX(Symbol(),Period(),AverageDirectionalMovAv_Period);
   h_AverageDirectionalMovAvWil=iADXWilder(Symbol(),Period(),AverageDirectionalMovAvWil_Period);
   h_BB=iBands(Symbol(),Period(),BB_Period,BB_Desplazamiento,BB_Desviacion,BB_Applied);
   h_DoubExpMA=iDEMA(Symbol(),Period(),DoubExpMA_Period,DoubExpMA_Desplazamiento,DoubExpMA_Applied);
   h_Envelopes=iEnvelopes(Symbol(),Period(),Envelopes_Period,Envelopes_Desplazamiento,Envelopes_Method,Envelopes_Applied,Envelopes_Desviacion);
   h_Ichimoku=iIchimoku(Symbol(),Period(),Ichimoku_Tenkan,Ichimoku_Kijun,Ichimoku_Senkou);
   h_MovingAver=iMA(Symbol(),Period(),MovingAver_Period,MovingAver_Desplazamiento,MovingAver_Method,MovingAver_Applied);
   h_ParabolicSAR=iSAR(Symbol(),Period(),ParabolicSAR_Paso,ParabolicSAR_Maximo);
   h_StandarDesv=iStdDev(Symbol(),Period(),StandarDesv_Period,StandarDesv_Desplazamiento,StandarDesv_Method,StandarDesv_Applied);
   h_TripleExpMA=iTEMA(Symbol(),Period(),TripleExpMA_Period,TripleExpMA_Desplazamiento,TripleExpMA_Applied);
   h_VariableIndex=iVIDyA(Symbol(),Period(),VariableIndex_PeriodCMO,VariableIndex_PeriodEMA,VariableIndex_Desplazamiento,VariableIndex_Applied);
   h_AverageTrue=iATR(Symbol(),Period(),AverageTrue_Period);
   h_ChaikinOsc=iChaikin(Symbol(),Period(),ChaikinOsc_MArapida,ChaikinOsc_MAlenta,ChaikinOsc_Method,ChaikinOsc_Applied);
   h_ForceIndex=iForce(Symbol(),Period(),ForceIndex_Period,ForceIndex_Method,ForceIndex_Applied);
   h_Momentum=iMomentum(Symbol(),Period(),Momentum_Period,Momentum_Applied);
   h_MovingAverOscill=iOsMA(Symbol(),Period(),MovingAverOscill_PeriodFast,MovingAverOscill_PeriodSlow,MovingAverOscill_PeriodSignal,MovingAverOscill_Applied);
   h_RelativeVigor=iRVI(Symbol(),Period(),RelativeVigor_Period);
   h_MoneyFlowVolumen=iMFI(Symbol(),Period(),MoneyFlowVolumen_Period,MoneyFlowVolumen_Applied);
   h_Alligator=iAlligator(Symbol(),Period(),Alligator_Mandibulas,Alligator_Desplazamiento1,Alligator_Dientes,Alligator_Desplazamiento2,Alligator_Labios,Alligator_Desplazamiento3,Alligator_Method,Alligator_Applied);
   h_Gator=iGator(Symbol(),Period(),Gator_Mandibulas,Gator_Desplazamiento1,Gator_Dientes,Gator_Desplazamiento2,Gator_Labios,Gator_Desplazamiento3,Gator_Method,Gator_Applied);
   h_TripleExpMAOscillator=iTriX(Symbol(),Period(),TripleExpMAOscillator_Period,TripleExpMAOscillator_Applied);
   
   
   //slow
   h_BearsPower_s=iBearsPower(Symbol(),Period(),BearsPower_PeriodBears_s);
   h_BullsPower_s=iBullsPower(Symbol(),Period(),BullsPower_PeriodBulls_s);
   h_CCI_s=iCCI(Symbol(),Period(),CCI_PeriodCCI_s,CCI_Applied);
   h_DeMarker_s=iDeMarker(Symbol(),Period(),DeM_PeriodDeM_s);
   h_FrAMA_s=iFrAMA(Symbol(),Period(),FraMA_PeriodMA_s,FraMA_Shift,FraMA_Applied);
   h_MACD_s=iMACD(Symbol(),Period(),MACD_PeriodFast_s,MACD_PeriodSlow_s,MACD_PeriodSignal_s,MACD_Applied);
   h_RSI_s=iRSI(Symbol(),Period(),RSI_PeriodRSI_s,RSI_Applied);
   h_MFI_s=iMFI(Symbol(),Period(),MFI_PeriodMFI_s,VOLUME_TICK);
   h_Stoch_s=iStochastic(Symbol(),Period(),Stoch_PeriodK_s,Stoch_PeriodD_s,Stoch_PeriodSlow_s,MODE_SMA,Stoch_Applied);
   h_WPR_s=iWPR(Symbol(),Period(),WPR_PeriodWPR_s);
   
   
   //edwin
   h_AdaptativeMovAv_s=iAMA(Symbol(),Period(),AdaptativeMovAv_Period_s,AdaptativeMovAv_Rapido_s,AdaptativeMovAv_Lento_s,AdaptativeMovAv_Desplazamiento,AdaptativeMovAv_Applied);
   h_AverageDirectionalMovAv_s=iADX(Symbol(),Period(),AverageDirectionalMovAv_Period_s);
   h_AverageDirectionalMovAvWil_s=iADXWilder(Symbol(),Period(),AverageDirectionalMovAvWil_Period_s);
   h_BB_s=iBands(Symbol(),Period(),BB_Period_s,BB_Desplazamiento,BB_Desviacion_s,BB_Applied);
   h_DoubExpMA_s=iDEMA(Symbol(),Period(),DoubExpMA_Period_s,DoubExpMA_Desplazamiento,DoubExpMA_Applied);
   h_Envelopes_s=iEnvelopes(Symbol(),Period(),Envelopes_Period_s,Envelopes_Desplazamiento,Envelopes_Method,Envelopes_Applied,Envelopes_Desviacion);
   h_Ichimoku_s=iIchimoku(Symbol(),Period(),Ichimoku_Tenkan_s,Ichimoku_Kijun_s,Ichimoku_Senkou_s);
   h_MovingAver_s=iMA(Symbol(),Period(),MovingAver_Period_s,MovingAver_Desplazamiento,MovingAver_Method,MovingAver_Applied);
   h_ParabolicSAR_s=iSAR(Symbol(),Period(),ParabolicSAR_Paso_s,ParabolicSAR_Maximo);
   h_StandarDesv_s=iStdDev(Symbol(),Period(),StandarDesv_Period_s,StandarDesv_Desplazamiento,StandarDesv_Method,StandarDesv_Applied);
   h_TripleExpMA_s=iTEMA(Symbol(),Period(),TripleExpMA_Period_s,TripleExpMA_Desplazamiento,TripleExpMA_Applied);
   h_VariableIndex_s=iVIDyA(Symbol(),Period(),VariableIndex_PeriodCMO_s,VariableIndex_PeriodEMA_s,VariableIndex_Desplazamiento,VariableIndex_Applied);
   h_AverageTrue_s=iATR(Symbol(),Period(),AverageTrue_Period_s);
   h_ChaikinOsc_s=iChaikin(Symbol(),Period(),ChaikinOsc_MArapida_s,ChaikinOsc_MAlenta_s,ChaikinOsc_Method,ChaikinOsc_Applied);
   h_ForceIndex_s=iForce(Symbol(),Period(),ForceIndex_Period_s,ForceIndex_Method,ForceIndex_Applied);
   h_Momentum_s=iMomentum(Symbol(),Period(),Momentum_Period_s,Momentum_Applied);
   h_MovingAverOscill_s=iOsMA(Symbol(),Period(),MovingAverOscill_PeriodFast_s,MovingAverOscill_PeriodSlow_s,MovingAverOscill_PeriodSignal,MovingAverOscill_Applied);
   h_RelativeVigor_s=iRVI(Symbol(),Period(),RelativeVigor_Period_s);
   h_MoneyFlowVolumen_s=iMFI(Symbol(),Period(),MoneyFlowVolumen_Period_s,MoneyFlowVolumen_Applied);
   h_Alligator_s=iAlligator(Symbol(),Period(),Alligator_Mandibulas_s,Alligator_Desplazamiento1,Alligator_Dientes_s,Alligator_Desplazamiento2,Alligator_Labios_s,Alligator_Desplazamiento3,Alligator_Method,Alligator_Applied);
   h_Gator_s=iGator(Symbol(),Period(),Gator_Mandibulas_s,Gator_Desplazamiento1,Gator_Dientes_s,Gator_Desplazamiento2,Gator_Labios_s,Gator_Desplazamiento3,Gator_Method,Gator_Applied);
   h_TripleExpMAOscillator_s=iTriX(Symbol(),Period(),TripleExpMAOscillator_Period_s,TripleExpMAOscillator_Applied);
   
     
   if(h_AC==INVALID_HANDLE || h_BearsPower==INVALID_HANDLE || 
      h_BullsPower==INVALID_HANDLE || h_AO==INVALID_HANDLE || 
      h_CCI==INVALID_HANDLE || h_DeMarker==INVALID_HANDLE || 
      h_FrAMA==INVALID_HANDLE || h_MACD==INVALID_HANDLE || 
      h_RSI==INVALID_HANDLE ||  
      h_Stoch==INVALID_HANDLE || h_WPR==INVALID_HANDLE ||
      h_BearsPower_s==INVALID_HANDLE || h_BullsPower_s==INVALID_HANDLE ||  
      h_CCI_s==INVALID_HANDLE || h_DeMarker_s==INVALID_HANDLE || 
      h_FrAMA_s==INVALID_HANDLE || h_MACD_s==INVALID_HANDLE || 
      h_RSI_s==INVALID_HANDLE ||  
      h_Stoch_s==INVALID_HANDLE || h_WPR_s==INVALID_HANDLE ||
      h_BearsPower_f==INVALID_HANDLE || h_BullsPower_f==INVALID_HANDLE ||  
      h_CCI_f==INVALID_HANDLE || h_DeMarker_f==INVALID_HANDLE || 
      h_FrAMA_f==INVALID_HANDLE || h_MACD_f==INVALID_HANDLE || 
      h_RSI_f==INVALID_HANDLE || h_RVI_f==INVALID_HANDLE || 
      h_Stoch_f==INVALID_HANDLE || h_WPR_f==INVALID_HANDLE ||
      h_MFI==INVALID_HANDLE || h_MFI_s==INVALID_HANDLE ||
      
      
      //edwin      
      h_AdaptativeMovAv==INVALID_HANDLE || h_AverageDirectionalMovAv==INVALID_HANDLE || h_AverageDirectionalMovAvWil==INVALID_HANDLE || h_BB==INVALID_HANDLE || h_DoubExpMA==INVALID_HANDLE || h_Envelopes==INVALID_HANDLE || 
      h_Ichimoku==INVALID_HANDLE || h_MovingAver==INVALID_HANDLE || h_ParabolicSAR==INVALID_HANDLE || h_StandarDesv==INVALID_HANDLE || h_TripleExpMA==INVALID_HANDLE || h_VariableIndex==INVALID_HANDLE || h_AverageTrue==INVALID_HANDLE || h_ChaikinOsc==INVALID_HANDLE || 
      h_ForceIndex==INVALID_HANDLE || h_Momentum==INVALID_HANDLE || h_MovingAverOscill==INVALID_HANDLE || h_RelativeVigor==INVALID_HANDLE || h_MoneyFlowVolumen==INVALID_HANDLE || h_Alligator==INVALID_HANDLE || h_Gator==INVALID_HANDLE || h_TripleExpMAOscillator==INVALID_HANDLE || 
      h_AdaptativeMovAv_s==INVALID_HANDLE || h_AverageDirectionalMovAv_s==INVALID_HANDLE || h_AverageDirectionalMovAvWil_s==INVALID_HANDLE || h_BB_s==INVALID_HANDLE || h_DoubExpMA_s==INVALID_HANDLE || h_Envelopes_s==INVALID_HANDLE ||  
      h_Ichimoku_s==INVALID_HANDLE || h_MovingAver_s==INVALID_HANDLE || h_ParabolicSAR_s==INVALID_HANDLE || h_StandarDesv_s==INVALID_HANDLE || h_TripleExpMA_s==INVALID_HANDLE || h_VariableIndex_s==INVALID_HANDLE || h_AverageTrue_s==INVALID_HANDLE || h_ChaikinOsc_s==INVALID_HANDLE || 
      h_ForceIndex_s==INVALID_HANDLE || h_Momentum_s==INVALID_HANDLE || h_MovingAverOscill_s==INVALID_HANDLE || h_RelativeVigor_s==INVALID_HANDLE || h_MoneyFlowVolumen_s==INVALID_HANDLE || h_Alligator_s==INVALID_HANDLE || h_Gator_s==INVALID_HANDLE || h_TripleExpMAOscillator_s==INVALID_HANDLE || 
      h_AdaptativeMovAv_f==INVALID_HANDLE || h_AverageDirectionalMovAv_f==INVALID_HANDLE || h_AverageDirectionalMovAvWil_f==INVALID_HANDLE || h_BB_f==INVALID_HANDLE || h_DoubExpMA_f==INVALID_HANDLE || h_Envelopes_f==INVALID_HANDLE || 
      h_Ichimoku_f==INVALID_HANDLE || h_MovingAver_f==INVALID_HANDLE || h_ParabolicSAR_f==INVALID_HANDLE || h_StandarDesv_f==INVALID_HANDLE || h_TripleExpMA_f==INVALID_HANDLE || h_VariableIndex_f==INVALID_HANDLE || h_AverageTrue_f==INVALID_HANDLE || h_ChaikinOsc_f==INVALID_HANDLE || 
      h_ForceIndex_f==INVALID_HANDLE || h_Momentum_f==INVALID_HANDLE || h_MovingAverOscill_f==INVALID_HANDLE || h_RelativeVigor_f==INVALID_HANDLE || 
      h_MoneyFlowVolumen_f==INVALID_HANDLE || h_Alligator_f==INVALID_HANDLE || h_Gator_f==INVALID_HANDLE || h_TripleExpMAOscillator_f==INVALID_HANDLE)      
      
      
      
      
     {
      Print("Error creating indicators");
      return(1);
     }
     
  
      Print("h_AdaptativeMovAv"+ h_AdaptativeMovAv);
      Print("h_AverageDirectionalMovAv"+  h_AverageDirectionalMovAv);
      Print("h_AverageDirectionalMovAvWil"+  h_AverageDirectionalMovAvWil);
      Print(" h_BB"+  h_BB);
      Print(" h_DoubExpMA"+  h_DoubExpMA);
      Print(" h_Envelopes"+  h_Envelopes);
      Print(" h_Ichimoku"+  h_Ichimoku);
      Print(" h_MovingAver"+  h_MovingAver);
      Print(" h_ParabolicSAR"+  h_ParabolicSAR);
      Print(" h_StandarDesv"+  h_StandarDesv);
      Print(" h_TripleExpMA"+  h_TripleExpMA);
      Print(" h_VariableIndex"+  h_VariableIndex);
      Print(" h_AverageTrue"+  h_AverageTrue);
      Print(" h_ChaikinOsc"+  h_ChaikinOsc);
      Print(" h_ForceIndex"+  h_ForceIndex);
      Print(" h_Momentum"+  h_Momentum);
      Print(" h_MovingAverOscill"+  h_MovingAverOscill);
      Print(" h_RelativeVigor"+  h_RelativeVigor);
      Print(" h_MoneyFlowVolumen"+  h_MoneyFlowVolumen);
      Print(" h_Alligator"+  h_Alligator);
      Print(" h_Gator"+  h_Gator);
      Print(" h_TripleExpMAOscillator"+  h_TripleExpMAOscillator);   
      Print(" h_AdaptativeMovAv_s"+  h_AdaptativeMovAv_s);
      Print(" h_AverageDirectionalMovAv_s"+  h_AverageDirectionalMovAv_s);
      Print(" h_AverageDirectionalMovAvWil_s"+  h_AverageDirectionalMovAvWil_s);
      Print(" h_BB_s"+  h_BB_s);
      Print(" h_DoubExpMA_s"+  h_DoubExpMA_s);
      Print(" h_Envelopes_s"+  h_Envelopes_s);
      Print(" h_Ichimoku_s"+  h_Ichimoku_s);
      Print(" h_MovingAver_s"+  h_MovingAver_s);
      Print(" h_ParabolicSAR_s"+  h_ParabolicSAR_s);
      Print(" h_StandarDesv_s"+  h_StandarDesv_s);
      Print(" h_TripleExpMA_s"+  h_TripleExpMA_s);
      Print(" h_VariableIndex_s"+  h_VariableIndex_s);
      Print(" h_AverageTrue_s"+  h_AverageTrue_s);
      Print(" h_ChaikinOsc_s"+  h_ChaikinOsc_s);
      Print(" h_ForceIndex_s"+  h_ForceIndex_s);
      Print(" h_Momentum_s"+  h_Momentum_s);
      Print(" h_MovingAverOscill_s"+  h_MovingAverOscill_s);
      Print(" h_RelativeVigor_s"+  h_RelativeVigor_s);
      Print(" h_MoneyFlowVolumen_s"+  h_MoneyFlowVolumen_s);
      Print(" h_Alligator_s"+  h_Alligator_s);
      Print(" h_Gator_s"+  h_Gator_s);
      Print(" h_TripleExpMAOscillator_s"+  h_TripleExpMAOscillator_s);   
   
      
     return 0;
}
  
//+------------------------------------------------------------------+
//| WriteMonth                                                        |
//+------------------------------------------------------------------+
int WriteMonth(int Day,int Month,int Year)
  {
//--- if Day<1, then we get data from the beginning of month
   if(Day<1) Day=1;

   //string FileName="";
   int copied=0;
   //int FileHandle=0;

//--- file name formation, (Symbol+Period+Month) EURUSD_M1_09.txt
  // FileName=Symbol()+"_"+fTimeFrameName(_Period)+"_"+IntegerToString(Month,2,'0')+".TXT";
   MqlRates rates[];
   MqlDateTime tm;
   ArraySetAsSeries(rates,true);

   string   start_time=IntegerToString(Year)+"."+IntegerToString(Month,2,'0')+"."+IntegerToString(Day,2,'0');  // ñ êàêîé äàòû

   ResetLastError();

   copied=CopyRates(Symbol(),_Period,StringToTime(start_time),TimeCurrent(),rates);
   //--- arrays
   double buf_AC[],buf_BearsPower[],buf_BullsPower[],buf_AO[],buf_CCI[];
   double buf_DeMarker[],buf_FrAMA[],buf_MACD_m[],buf_MACD_s[],buf_RSI[];
   double buf_MFI[], buf_Stoch_m[],buf_Stoch_s[],buf_WPR[];
   double buf_BearsPower_s[],buf_BullsPower_s[],buf_CCI_s[];
   double buf_DeMarker_s[],buf_FrAMA_s[],buf_MACD_m_s[],buf_MACD_s_s[],buf_RSI_s[];
   double buf_MFI_s[],buf_Stoch_m_s[],buf_Stoch_s_s[],buf_WPR_s[];
   
   
   
   //edwin         
   double buf_AdaptativeMovAv[], buf_AverageDirectionalMovAv[], buf_AverageDirectionalMovAvWil[], buf_BB[], buf_DoubExpMA[], buf_Envelopes[];
   double buf_Ichimoku[], buf_MovingAver[], buf_ParabolicSAR[], buf_StandarDesv[], buf_TripleExpMA[], buf_VariableIndex[], buf_AverageTrue[], buf_ChaikinOsc[];
   double buf_ForceIndex[], buf_Momentum[], buf_MovingAverOscill[], buf_RelativeVigor[], buf_MoneyFlowVolumen[], buf_Alligator[], buf_Gator[],buf_TripleExpMAOscillator[];
   double buf_AdaptativeMovAv_s[], buf_AverageDirectionalMovAv_s[], buf_AverageDirectionalMovAvWil_s[], buf_BB_s[], buf_DoubExpMA_s[], buf_Envelopes_s[];
   double buf_Ichimoku_s[], buf_MovingAver_s[], buf_ParabolicSAR_s[], buf_StandarDesv_s[], buf_TripleExpMA_s[], buf_VariableIndex_s[], buf_AverageTrue_s[], buf_ChaikinOsc_s[];
   double buf_ForceIndex_s[], buf_Momentum_s[], buf_MovingAverOscill_s[], buf_RelativeVigor_s[], buf_MoneyFlowVolumen_s[], buf_Alligator_s[], buf_Gator_s[],buf_TripleExpMAOscillator_s[];
      
   
 
   //--- filling the arrays with values of the indicators
   bool copy_result=true;
   copy_result=copy_result && FillArrayFromBuffer1(buf_AC,h_AC,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_BearsPower,h_BearsPower,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_BullsPower,h_BullsPower,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_AO,h_AO,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_CCI,h_CCI,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_DeMarker,h_DeMarker,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_FrAMA,h_FrAMA,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArraysFromBuffers2(buf_MACD_m,buf_MACD_s,h_MACD,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_RSI,h_RSI,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_MFI,h_MFI,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArraysFromBuffers2(buf_Stoch_m,buf_Stoch_s,h_Stoch,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_WPR,h_WPR,StringToTime(start_time),TimeCurrent());

   copy_result=copy_result && FillArrayFromBuffer1(buf_BearsPower_s,h_BearsPower_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_BullsPower_s,h_BullsPower_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_CCI_s,h_CCI_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_DeMarker_s,h_DeMarker_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_FrAMA_s,h_FrAMA_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArraysFromBuffers2(buf_MACD_m_s,buf_MACD_s_s,h_MACD_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_RSI_s,h_RSI_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_MFI_s,h_MFI_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArraysFromBuffers2(buf_Stoch_m_s,buf_Stoch_s_s,h_Stoch_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_WPR_s,h_WPR_s,StringToTime(start_time),TimeCurrent());
   
   
   
   //edwin
   copy_result=copy_result && FillArrayFromBuffer1(buf_AdaptativeMovAv,h_AdaptativeMovAv,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_AverageDirectionalMovAv, h_AverageDirectionalMovAv,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_AverageDirectionalMovAvWil, h_AverageDirectionalMovAvWil,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_BB, h_BB,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_DoubExpMA, h_DoubExpMA,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Envelopes, h_Envelopes,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1(buf_Ichimoku, h_Ichimoku,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_MovingAver, h_MovingAver,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_ParabolicSAR, h_ParabolicSAR,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_StandarDesv, h_StandarDesv,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_TripleExpMA, h_TripleExpMA,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_VariableIndex, h_VariableIndex,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_AverageTrue, h_AverageTrue,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_ChaikinOsc, h_ChaikinOsc,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_ForceIndex, h_ForceIndex,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Momentum, h_Momentum,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_MovingAverOscill, h_MovingAverOscill,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_RelativeVigor, h_RelativeVigor,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_MoneyFlowVolumen, h_MoneyFlowVolumen,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Alligator, h_Alligator,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Gator, h_Gator,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_TripleExpMAOscillator, h_TripleExpMAOscillator,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_AdaptativeMovAv_s, h_AdaptativeMovAv_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_AverageDirectionalMovAv_s, h_AverageDirectionalMovAv_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_AverageDirectionalMovAvWil_s, h_AverageDirectionalMovAvWil_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_BB_s, h_BB_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_DoubExpMA_s, h_DoubExpMA_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Envelopes_s, h_Envelopes_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Ichimoku_s, h_Ichimoku_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_MovingAver_s, h_MovingAver_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_ParabolicSAR_s, h_ParabolicSAR_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_StandarDesv_s, h_StandarDesv_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_TripleExpMA_s, h_TripleExpMA_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_VariableIndex_s, h_VariableIndex_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_AverageTrue_s, h_AverageTrue_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_ChaikinOsc_s, h_ChaikinOsc_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_ForceIndex_s, h_ForceIndex_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Momentum_s, h_Momentum_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_MovingAverOscill_s, h_MovingAverOscill_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_RelativeVigor_s, h_RelativeVigor_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_MoneyFlowVolumen_s, h_MoneyFlowVolumen_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Alligator_s, h_Alligator_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_Gator_s, h_Gator_s,StringToTime(start_time),TimeCurrent());
   copy_result=copy_result && FillArrayFromBuffer1( buf_TripleExpMAOscillator_s, h_TripleExpMAOscillator_s,StringToTime(start_time),TimeCurrent());
      

   //--- checking the accuracy of copying all data
   if(!(copy_result==true&&copied>0)){
      Print("Data copy error");
      return -1;
    }
   Print("Copied nb: "+copy_result);
   
   int count = 0;
   string queryPre1 = "insert into pair(open,high,low,close,tick_volume,real_volume,symbol, period,time,time_id,year,mon,day,hour,min,day_of_week,day_of_year) values(";
   string queryPre2 = "insert into indicator(indicator_name,value1,value2,symbol,period,time,time_id,year,mon,day,hour,min,day_of_week,day_of_year) values(";
   string constant_key = "";
   
   for(int i=copied-3;i>=0;i--){
   
     if(count == 0){
         StringConcatenate(query1, queryPre1, "");
         StringConcatenate(query2, queryPre2, "");
     }
     
     TimeToStruct(rates[i].time,tm);
     constant_key = "";
     StringConcatenate(constant_key,"\"",
                         Symbol(),"\",\"",
                         fTimeFrameName(_Period),"\",\"",
                         TimeToString(rates[i].time), "\",",                //The current time. Example: 2014.01.01 12:00
                         DoubleToString(rates[i].time,0),",",    // number of seconds, passed from 1st January 1970
                         tm.year,",",                            // your
                         tm.mon,",",                             // month
                         tm.day,",",                             // day
                         tm.hour,",",                            // hour
                         tm.min,",",                             // minutes
                         tm.day_of_week,",",                     // week day (0-sunday, 1-monday)
                         tm.day_of_year                     // day index in the year (1st January is the 0-th day of the year)
      );
      //Guardar la información de la paridad para este instante
     
      
      StringConcatenate(query1, query1,
      rates[i].open,",",                      // Open
      rates[i].high,",",                      // High
      rates[i].low,",",                       // Low
      rates[i].close,",",                     // Close
      rates[i].tick_volume,",",               // Tick Volume
      rates[i].real_volume,",",               // Real Volume
      constant_key,")");                                                                               
      
      TimeToStruct(rates[i+1].time,tm);
      constant_key = "";
      StringConcatenate(constant_key,"\"",
                         Symbol(),"\",\"",
                         fTimeFrameName(_Period),"\",\"",
                         TimeToString(rates[i+1].time), "\",",                //The current time. Example: 2014.01.01 12:00
                         DoubleToString(rates[i+1].time,0),",",    // number of seconds, passed from 1st January 1970
                         tm.year,",",                            // your
                         tm.mon,",",                             // month
                         tm.day,",",                             // day
                         tm.hour,",",                            // hour
                         tm.min,",",                             // minutes
                         tm.day_of_week,",",                     // week day (0-sunday, 1-monday)
                         tm.day_of_year                     // day index in the year (1st January is the 0-th day of the year)
      );
      
       //Guardar la información de los indicadores
      
      StringConcatenate(query2, query2, "\"price\",",((rates[i+1].close-rates[i+2].close)/_Point),",",((rates[i].close-rates[i+1].close)/_Point),",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AC\",",buf_AC[i+1],",",buf_AC[i+1]-buf_AC[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Bears\",",buf_BearsPower[i+1],",",buf_BearsPower[i+1]-buf_BearsPower[i+2],",",constant_key,"),("); 
      StringConcatenate(query2, query2, "\"Bulls\",",buf_BullsPower[i+1],",",buf_BullsPower[i+1]-buf_BullsPower[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AO\",",buf_AO[i+1],",",buf_AO[i+1]-buf_AO[i+2],",",constant_key,"),("); 
      StringConcatenate(query2, query2, "\"CCI\",",buf_CCI[i+1],",",buf_CCI[i+1]-buf_CCI[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"DeMarker\",",buf_DeMarker[i+1],",",buf_DeMarker[i+1]-buf_DeMarker[i+2],",",constant_key,"),("); 
      StringConcatenate(query2, query2, "\"dFrAMA\",",buf_FrAMA[i+1]-buf_FrAMA[i+2],",0,",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MACDm\",",buf_MACD_m[i+1],",",buf_MACD_m[i+1]-buf_MACD_m[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MACDs\",",buf_MACD_s[i+1],",",buf_MACD_s[i+1]-buf_MACD_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MACDms\",",buf_MACD_m[i+1]-buf_MACD_s[i+1],",",buf_MACD_m[i+1]-buf_MACD_s[i+1]-buf_MACD_m[i+2]+buf_MACD_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"RSI\",",buf_RSI[i+1],",",buf_RSI[i+1]-buf_RSI[i+2],",",constant_key,"),(");                                      
      StringConcatenate(query2, query2, "\"MFI\",",buf_MFI[i+1],",",buf_MFI[i+1]-buf_MFI[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Stoch_m\",",buf_Stoch_m[i+1],",",buf_Stoch_m[i+1]-buf_Stoch_m[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Stoch_s\",", buf_Stoch_s[i+1],",",buf_Stoch_s[i+1]-buf_Stoch_s[i+2],",",constant_key,"),(");  
      StringConcatenate(query2, query2, "\"Stoch_ms\",",buf_Stoch_m[i+1]-buf_Stoch_s[i+1],",",buf_Stoch_m[i+1]-buf_Stoch_s[i+1]-buf_Stoch_m[i+2]+buf_Stoch_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"WPR\",",buf_WPR[i+1],",",buf_WPR[i+1]-buf_WPR[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Bears_p\",",buf_BearsPower_s[i+1],",",buf_BearsPower_s[i+1]-buf_BearsPower_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Bulls_p\",",buf_BullsPower_s[i+1],",",buf_BullsPower_s[i+1]-buf_BullsPower_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"CCI_p\",",buf_CCI_s[i+1],",",buf_CCI_s[i+1]-buf_CCI_s[i+2],",",constant_key,"),(");                        
      StringConcatenate(query2, query2, "\"DeMarker_p\",",buf_DeMarker_s[i+1],",",buf_DeMarker_s[i+1]-buf_DeMarker_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"dFrAMA_p\",",buf_FrAMA_s[i+1]-buf_FrAMA_s[i+2],",0,",constant_key,"),(");                      
      StringConcatenate(query2, query2, "\"MACDm_p\",",buf_MACD_m_s[i+1],",",buf_MACD_m_s[i+1]-buf_MACD_m_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MACDm_p\",",buf_MACD_m_s[i+1],",",buf_MACD_m_s[i+1]-buf_MACD_m_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MACDs_p\",",buf_MACD_s_s[i+1],",",buf_MACD_s_s[i+1]-buf_MACD_s_s[i+2],",",constant_key,"),(");   
      StringConcatenate(query2, query2, "\"MACDms_p\",",buf_MACD_m_s[i+1]-buf_MACD_s_s[i+1],",",buf_MACD_m_s[i+1]-buf_MACD_s_s[i+1]-buf_MACD_m_s[i+2]+buf_MACD_s_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"RSI_p\",",buf_RSI_s[i+1],",",buf_RSI_s[i+1]-buf_RSI_s[i+2],",",constant_key,"),("); 
      StringConcatenate(query2, query2, "\"MFI_p\",",buf_MFI_s[i+1],",",buf_MFI_s[i+1]-buf_MFI_s[i+2],",",constant_key,"),(");                       
      StringConcatenate(query2, query2, "\"Stoch_m_p\",",buf_Stoch_m_s[i+1],",",buf_Stoch_m_s[i+1]-buf_Stoch_m_s[i+2],",",constant_key,"),(");                       
      StringConcatenate(query2, query2, "\"Stoch_s_p\",",buf_Stoch_s_s[i+1],",",buf_Stoch_s_s[i+1]-buf_Stoch_s_s[i+2],",",constant_key,"),(");                          
      StringConcatenate(query2, query2, "\"Stoch_ms_p\",",buf_Stoch_m_s[i+1]-buf_Stoch_s_s[i+1],",",buf_Stoch_m_s[i+1]-buf_Stoch_s_s[i+1]-buf_Stoch_m_s[i+2]+buf_Stoch_s_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"WPR_p\",",buf_WPR_s[i+1],",",buf_WPR_s[i+1]-buf_WPR_s[i+2],",",constant_key,"),(");                                                                          
      
      //edwin      
      
      StringConcatenate(query2, query2, "\"AdaptativeMovAv\",",buf_AdaptativeMovAv[i+1],",",buf_AdaptativeMovAv[i+1]-buf_AdaptativeMovAv[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AverageDirectionalMovAv\",", buf_AverageDirectionalMovAv[i+1],",", buf_AverageDirectionalMovAv[i+1]- buf_AverageDirectionalMovAv[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AverageDirectionalMovAvWil\",", buf_AverageDirectionalMovAvWil[i+1],",", buf_AverageDirectionalMovAvWil[i+1]- buf_AverageDirectionalMovAvWil[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"BB\",", buf_BB[i+1],",", buf_BB[i+1]- buf_BB[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"DoubExpMA\",", buf_DoubExpMA[i+1],",", buf_DoubExpMA[i+1]- buf_DoubExpMA[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Envelopes\",", buf_Envelopes[i+1],",", buf_Envelopes[i+1]- buf_Envelopes[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Ichimoku\",",buf_Ichimoku[i+1],",",buf_Ichimoku[i+1]-buf_Ichimoku[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MovingAver\",", buf_MovingAver[i+1],",", buf_MovingAver[i+1]- buf_MovingAver[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"ParabolicSAR\",", buf_ParabolicSAR[i+1],",", buf_ParabolicSAR[i+1]- buf_ParabolicSAR[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"StandarDesv\",", buf_StandarDesv[i+1],",", buf_StandarDesv[i+1]- buf_StandarDesv[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"TripleExpMA\",", buf_TripleExpMA[i+1],",", buf_TripleExpMA[i+1]- buf_TripleExpMA[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"VariableIndex\",", buf_VariableIndex[i+1],",", buf_VariableIndex[i+1]- buf_VariableIndex[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AverageTrue\",", buf_AverageTrue[i+1],",", buf_AverageTrue[i+1]- buf_AverageTrue[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"ChaikinOsc\",", buf_ChaikinOsc[i+1],",", buf_ChaikinOsc[i+1]- buf_ChaikinOsc[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"ForceIndex\",", buf_ForceIndex[i+1],",", buf_ForceIndex[i+1]- buf_ForceIndex[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Momentum\",", buf_Momentum[i+1],",", buf_Momentum[i+1]- buf_Momentum[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MovingAverOscill\",", buf_MovingAverOscill[i+1],",", buf_MovingAverOscill[i+1]- buf_MovingAverOscill[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"RelativeVigor\",", buf_RelativeVigor[i+1],",", buf_RelativeVigor[i+1]- buf_RelativeVigor[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MoneyFlowVolumen\",", buf_MoneyFlowVolumen[i+1],",", buf_MoneyFlowVolumen[i+1]- buf_MoneyFlowVolumen[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Alligator\",", buf_Alligator[i+1],",", buf_Alligator[i+1]- buf_Alligator[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Gator\",", buf_Gator[i+1],",", buf_Gator[i+1]- buf_Gator[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"TripleExpMAOscillator\",",buf_TripleExpMAOscillator[i+1],",",buf_TripleExpMAOscillator[i+1]-buf_TripleExpMAOscillator[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AdaptativeMovAv_s\",", buf_AdaptativeMovAv_s[i+1],",", buf_AdaptativeMovAv_s[i+1]- buf_AdaptativeMovAv_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AverageDirectionalMovAv_s\",", buf_AverageDirectionalMovAv_s[i+1],",", buf_AverageDirectionalMovAv_s[i+1]- buf_AverageDirectionalMovAv_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AverageDirectionalMovAvWil_s\",", buf_AverageDirectionalMovAvWil_s[i+1],",", buf_AverageDirectionalMovAvWil_s[i+1]- buf_AverageDirectionalMovAvWil_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"BB_s\",", buf_BB_s[i+1],",", buf_BB_s[i+1]- buf_BB_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"DoubExpMA_s\",", buf_DoubExpMA_s[i+1],",", buf_DoubExpMA_s[i+1]- buf_DoubExpMA_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Envelopes_s\",", buf_Envelopes_s[i+1],",", buf_Envelopes_s[i+1]- buf_Envelopes_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Ichimoku_s\",", buf_Ichimoku_s[i+1],",", buf_Ichimoku_s[i+1]- buf_Ichimoku_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MovingAver_s\",", buf_MovingAver_s[i+1],",", buf_MovingAver_s[i+1]- buf_MovingAver_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"ParabolicSAR_s\",", buf_ParabolicSAR_s[i+1],",", buf_ParabolicSAR_s[i+1]- buf_ParabolicSAR_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"StandarDesv_s\",", buf_StandarDesv_s[i+1],",", buf_StandarDesv_s[i+1]- buf_StandarDesv_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"TripleExpMA_s\",", buf_TripleExpMA_s[i+1],",", buf_TripleExpMA_s[i+1]- buf_TripleExpMA_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"VariableIndex_s\",", buf_VariableIndex_s[i+1],",", buf_VariableIndex_s[i+1]- buf_VariableIndex_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"AverageTrue_s\",", buf_AverageTrue_s[i+1],",", buf_AverageTrue_s[i+1]- buf_AverageTrue_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"ChaikinOsc_s\",", buf_ChaikinOsc_s[i+1],",", buf_ChaikinOsc_s[i+1]- buf_ChaikinOsc_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"ForceIndex_s\",", buf_ForceIndex_s[i+1],",", buf_ForceIndex_s[i+1]- buf_ForceIndex_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Momentum_s\",", buf_Momentum_s[i+1],",", buf_Momentum_s[i+1]- buf_Momentum_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MovingAverOscill_s\",", buf_MovingAverOscill_s[i+1],",", buf_MovingAverOscill_s[i+1]- buf_MovingAverOscill_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"RelativeVigor_s\",", buf_RelativeVigor_s[i+1],",", buf_RelativeVigor_s[i+1]- buf_RelativeVigor_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"MoneyFlowVolumen_s\",", buf_MoneyFlowVolumen_s[i+1],",", buf_MoneyFlowVolumen_s[i+1]- buf_MoneyFlowVolumen_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Alligator_s\",", buf_Alligator_s[i+1],",", buf_Alligator_s[i+1]- buf_Alligator_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"Gator_s\",", buf_Gator_s[i+1],",", buf_Gator_s[i+1]- buf_Gator_s[i+2],",",constant_key,"),(");
      StringConcatenate(query2, query2, "\"TripleExpMAOscillator_s\",",buf_TripleExpMAOscillator_s[i+1],",",buf_TripleExpMAOscillator_s[i+1]-buf_TripleExpMAOscillator_s[i+2],",",constant_key,")");
      
      //Only executes the query when the buffer is fullfilled. 
      count++;
      if(count==NQ||i==0){
         StringConcatenate(query1, query1,";");
         sql_query(query1);
         StringConcatenate(query2, query2,";");
         sql_query(query2);
         count = 0;
      }
      else{
         StringConcatenate(query1, query1,",(");
         StringConcatenate(query2, query2,",(");
      }
      
   }
   Print("Data of the ",IntegerToString(Month,2,'0')," month ",Year," year written to database ");
   return(0);
}
  
void sql_query(string _query){
    string ansiquery;
    int length=StringLen(_query);
    ansiquery=UNICODE2ANSI(_query);
    //Print(_query);
    mysql_real_query(mysql,ansiquery,length);
    int mysqlerr=mysql_errno(mysql);
    if (mysqlerr>0)
      {
       Print("Query: ",_query);
       Print("Returned error: ",ANSI2UNICODE(mysql_error(mysql)) );       
      }      
    return;
}

//+------------------------------------------------------------------+
//|Filling the indicator buffer from the single buffer indicator       |
//+------------------------------------------------------------------+
bool FillArrayFromBuffer1(double &buffer[],  // indicator buffer of values 
                          int ind_handle,    // indicator handle 
                          datetime start_time,        // start date and time
                          datetime stop_time)        // number of copied values
  {
   //--- resetting error code
   ResetLastError();
   //--- filling a part of the buffer array with the values from the indicator buffer with index 0
   int copied = CopyBuffer(ind_handle,0,start_time,stop_time,buffer);
   ArraySetAsSeries(buffer,true);
   //Print("Ind nb: "+copied);
   if(copied<0)
     {
      //--- if the copying fails, report the error code
      PrintFormat("Failed to copy data from the indicator, error code %d",GetLastError());
      //--- quitting with zero result - it means that the indicator will be considered as not calculated
      return(false);
     }
   //--- success
   return(true);
  }
//+------------------------------------------------------------------+
//| filling the indicator buffers from the double buffer indicator     |
//+------------------------------------------------------------------+
bool FillArraysFromBuffers2(double &buffer1[], // indicator buffer 1
                            double &buffer2[], // indicator buffer 2 
                            int ind_handle,
                            datetime start_time,        // start date and time
                            datetime stop_time){   // indicator handle
   //--- resetting error code
   ResetLastError();
   //--- filling a part of the buffer1 array with the values from the indicator buffer with index 0
   int copied = CopyBuffer(ind_handle,0,start_time,stop_time,buffer1);
   ArraySetAsSeries(buffer1,true);
   if(copied<0)
     {
      //--- if the copying fails, report the error code
      PrintFormat("Failed to copy data from the indicator buffer 1, error code %d",GetLastError());
      //--- quitting with zero result - it means that the indicator will be considered as not calculated
      return(false);
     }
   copied = CopyBuffer(ind_handle,1,start_time,stop_time,buffer2);
   ArraySetAsSeries(buffer2,true);
   //--- filling a part of the buffer2 array with the values from the indicator buffer with index 1
   if(copied<0)
     {
      //--- if the copying fails, report the error code
      PrintFormat("Failed to copy data from the indicator buffer 2, error code %d",GetLastError());
      //--- quitting with zero result - it means that the indicator will be considered as not calculated
      return(false);
     }
   //--- success
   return(true);
}
//+------------------------------------------------------------------+
//| fTimeFrameName                                                   |
//+------------------------------------------------------------------+
string fTimeFrameName(int arg)
  {
   int v;
   if(arg==0)
     {
      v=_Period;
     }
   else
     {
      v=arg;
     }
   switch(v)
     {
      case PERIOD_M1:    return("M1");
      case PERIOD_M2:    return("M2");
      case PERIOD_M3:    return("M3");
      case PERIOD_M4:    return("M4");
      case PERIOD_M5:    return("M5");
      case PERIOD_M6:    return("M6");
      case PERIOD_M10:   return("M10");
      case PERIOD_M12:   return("M12");
      case PERIOD_M15:   return("M15");
      case PERIOD_M20:   return("M20");
      case PERIOD_M30:   return("M30");
      case PERIOD_H1:    return("H1");
      case PERIOD_H2:    return("H2");
      case PERIOD_H3:    return("H3");
      case PERIOD_H4:    return("H4");
      case PERIOD_H6:    return("H6");
      case PERIOD_H8:    return("H8");
      case PERIOD_H12:   return("H12");
      case PERIOD_D1:    return("D1");
      case PERIOD_W1:    return("W1");
      case PERIOD_MN1:   return("MN1");
      default:    return("?");
     }
  }
