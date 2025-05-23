#property copyright "JaguarForex"
#property link      "https://www.jaguarforex.com"
#property strict

#define   program      "BollingerReversalPro"
#property version   "1.1"
#define   version   "1.1"
#define   ref       "Ken" // Whose advisor (referral, issued to, or from whom)
#define   perc      30 // Referrer payout percentage
#define   domen     "license.cashrewardforex.com" // Server to connect, without https://
#define   path      "metatrader"
#define   port      443 // Server port 80\443
#define   URLbuy    "https://my.jaguarforex.com" // Site address where "License Purchase"
#define   URLupdate "https://my.jaguarforex.com" // Site address where "Version Update" can be directed to the download page
#define   check     6 // Activation check frequency in hours (Recommended no more than 2)
#define   shTxt     20 // Shifting labels from the top
//- Подключение
#include <MyLicense.mqh> // Folder MQL4/5 => Include
#define PACKAGE_INFO_LABEL "PackageInfoLabel"


string EA_NAME = "Bollinger Reversal Pro"; //Change The EA Name and Press F7 to save it
string Contact_Person="Jaguar Forex";

string Limitation_Setting    = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
bool DemoAccount_Only=false; //Run Only On Demo Account
int MaxCloseTrades=10000000;//EA stop trades when close order more than 100 trades on demo version
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||
string Expired_com= "Demo Version HAS EXPIRED ";
bool ExpiredTime_ON=false;
int eyear=2031;  int emonth=06;  int expired_date=01; //Expired Time EA, after change press F7 to save it

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||
bool ProtectBy_ACC_NUMBER=false;
int ACC_NUMBER   = 0;// input login number for run ea on account number that you specific
string invalid_ac="YOUR ARE NOT ALLOWED TO TRADE ON THIS ACCOUNT NUMBER" ;
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||

string Line1="-----------------------------------------------";
color ClrLine=clrMagenta;
bool  Filter_Time_For_Trial=false;
string     Trial_Time  ="2015.10.23";//Limited backtest periode/time
string Trial_version="" ;
string Trial_version2="" ;
//----------------------------------------------------------------------||
// Donot change the source code below.....!!!!!!
//----------------------------------------------------------------------||

enum MODE 
  {
   MODE_1=1,//MACD
   MODE_2=2,//Heiken Ashi
   MODE_3=3,//Bollinger Band
   MODE_4=4,//PipFinite (TrendPro)
  }; 

enum MODE2 
  {
   Immediately=2,//Immediately
   NextSignal=1,// Next Bollinger Signal
  };

input string BBB="--------< Bollinger Band Parameters >-------";//::-------------------------::
input int sensitivity = 500.0;  //Trade Sensitivity (Upperband-LowerBand)
input int BandsPeriod=20;//Bollinger Period
input double Deviations=2.0;//Deviations
input ENUM_APPLIED_PRICE Band_Price=0;//Apply to
double BandUpper,BandLower,BandMiddle;
 bool CloseOnOpppositeSignal=false; 

input string GM2="------------- < General Setting > -------------";//::--:: 
 MODE2 TRADES=1; //Initial placement of Order 
 MODE Trade_Mode=3; //Initial Trade Signal

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
string MoneyManagement="";//Money Management
 bool Autolot=false;
 double AutoMM =1000;//Lot=Balance Divide
int Lot_Digits;
input double Initial_Lot=0.01;//Initial Lot Size
double MR,FM,LMB,LMS;
input double  FirstTrade_TP =5;//First Order Take Profit 
input double     Stoploss =0; //Stop loss in Pip
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
 string GM="------------- < Recovery Settings > -------------";//::--:: 
bool Average_ALL=true;
 bool SignalFilter=true;//Second & Other Order Base  Signal Filter
 bool MinimumDistance=true;//Minimum Recovery Distance
input double GridStep=15; //Minimum Recovery Distance
double GridStepMultiplier=1; //GridStep Multiplier
input double Average_TP  =5;//Recovery TakeProfit

double BreakenTrailAmount=25;

double GridStepX,GridStepY;
input string GM10="------------- <  Recovery > -------------";//::--:: 
input bool Martingale_ON=true;//Recovery Strategy 
enum Lot_Type 
  {
   Lot_Type1=1,//Manual Entry 
   Lot_Type2=2,//Multiplier
  }; 
input Lot_Type MartingaleLot_Type=1;//LotSize Calculation
input double lotsizemultiplier=2;//Lot Size Multiplier
input string GM12="------------- <Recovery LotSize Manual Entry Settings > -------------";//::--::
 double LS1=0.01;//Lotsize of Trade 1
input double Lot2=0.02;//2nd recovery lotsize
input double Lot3=0.03; // 3rd recovery lotsize
input double Lot4=0.04;//  4th recovery lotsize
input double Lot5=0.05;//  5th recovery lotsize
input double Lot6=0.06;// 6th recovery lotsize
input double Lot7=0.07;//  7th recovery lotsize
input double Lot8=0.08;//  8th recovery lotsize
input double Lot9=0.09;// 9th recovery lotsize
input double Lot10=0.10; // 10th recovery lotsize
input double Lot11=0.11;//  11th recovery lotsize
input double Lot12=0.12;// 12th recovery lotsize
input double Lot13=0.13;//  13th recovery lotsize
input double Lot14=0.14;//  14th recovery lotsize
input double Lot15=0.15;//  15th recovery lotsize
input double Lot16=0.16;//  16th recovery lotsize
input double Lot17=0.17;//  17th recovery lotsize
input double Lot18=0.18;// 18th recovery lotsize
input double Lot19=0.19;// 19th recovery lotsize
input double Lot20=0.20;// 20th recovery lotsize
input double Lot21=0.21;// 21th recovery lotsize
input double Lot22=0.22;// 22th recovery lotsize
input double Lot23=0.23;// 23th recovery lotsize
input double Lot24=0.24;// 24th recovery lotsize
input double Lot25=0.25;// 25th recovery lotsize
input double Lot26=0.26;// 26th recovery lotsize
input double Lot27=0.27;// 27th recovery lotsize
input double Lot28=0.28;// 28th recovery lotsize
input double Lot29=0.29;// 29th recovery lotsize
input double Lot30=0.30;//  30th recovery lotsize


 bool OneTradePerBar =true;//One Trade Per Candle
 string MDD="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";//Setting Filter Max DD Stop Martingale Trade  
 bool MAX_DrawDawn=false;//Filter Max DD Stop Martingale 
 double MaxDD_StopMartingale=10;

 string GM1="------------- < Trailing For Single Trades Setting > -------------";//::--:: 
 bool Trailing_Stop_ON=false;
  double Trailing_Stop =20; //Start Trail
 double Trailing_Start =10;// Trail Stoploss
 double    TrailingStep =1; // Trail Step
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||


//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
  string XXXXXXXXXXXXXXXXXXXXXX  = "Exit All Base On Account Currency";//::--::
 double AmountOf_Total_Profit          =0;//AmountOf Total Profit Both Side
 bool HitProfit_ExpertRemoves=true;//HitProfit ExpertRemoves
 double AmountOf_Total_Loss            =0;//AmountOf Total Loss Both Side
 bool HitLoss_ExpertRemoves=true;//HitLoss_ExpertRemoves

input  string EQ  = "------------< Risk Management >------------";//::--::
 string XXXXXXXXXXX1XXXXXXXXXX  = "Exit All Base On Percentage of Balance.";//::--::
input bool HitPercentagePro_ExpertRemoves=false;// Hit % profit - Remove EA on the chart
input double  PercentOf_Total_Profit         =0;//Percentage of Profit
input bool HitPercentageLoss_ExpertRemoves=false; //Hit % of Loss - Remove EA on the Chart
input double  PercentOf_Total_Loss          =0; //Percentage of Loss

 string XXXXXXXXXXXIIXXXXXXXXXX  = "StopTrades when Reach Max Drawdawn";
 bool Stoptrades         =false;//StopTrades When Reach DD ( in % ) ON 
 double Max_DD         =0;//Max Drawdawn 
input  string EQ2  = "------------< Risk Management 2 >------------";//::--::
input int MaxTrades=30;//Maximum No. of Trades
input bool FilterMaximumLot=false;//Filter Lotsize 
input double MaximumLot=0.4; //Max Lotsize Allowed
input bool Filter_MaxSpread =false;//Allow Spread Filter
input double Max_Spread=5;//Spread Filter Value
input int     slippage     = 50;//Slippage Filter
input int Magic_Number     = 8881 ;//MagicNumber

 input string TradingTime3="------------<Filter Trading Time >------------";//::--::
input bool Filter_TradingTime=false;// Filter Trading Time
input string Time_Start         ="00:00"; //Time Start 
input string Time_End          = "23:59"; //Time Stop  

 string TradingTime2="------------<Stop Trading  Time On Friday >------------";//::--::
 bool Filter_TradingTime2=false;//Stop Trading  Time
 string Time_StopFriday         ="15:00"; //Time Stop 

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||   
 string IND="-----------<----- Technical Indicator ----->-----------";//::-------------------------::  
 string Indicator2para="------------<Trend Pro Parameters- >------------";//::--::

 int period=3;//Periode
 double target=2.0;//Target Factor
 int MaximumBars=1000;//Maximum History Bar



int modif;
int cnt,OC;
double  Range, Spread,Balance,Equity,Profit,DD,Lev,St_Out;
color l_text,r_text ;
string Running_Price,Range_Price,AB,AE,AP,Persen_DD,Leverage;
double SLB,SLS,TPB,TPS;
int OpenBuy ,OpenSell ;
int OpenOrders  ;
int select,ord_send,ord_close,ord_del;
int tolerance;
bool ACCOUNT_INFO=true;
int text_size=12; 
color color_text=clrWhite;
int text_corner=1;
string Day1="MONDAY";
string Day2="TUESDAY";
string Day3="WEDNESDAY";
string Day4="THURSDAY";
string Day5="FRIDAY";
string Day6="SATURDAY";
string Day7="SUNDAY";
string hari;

// Function to check if the distance between UpperBand and LowerBand is greater than or equal to sensitivity (chatgpt)
bool CheckBandDistance(double UpperBand, double LowerBand, double sensitivity) {
    double bandDifference = MathAbs(UpperBand - LowerBand) / Point; // Calculate the difference in pips

    if (bandDifference >= sensitivity) {
        return true;  // Proceed with Buy/Sell checks
    } else {
        return false; // Skip Buy/Sell checks
    }
}

//
double CalculateLotSize(double current_lot_size, double multiplier)
{
    // Calculate the new lot size by applying the multiplier
    double new_lot_size = current_lot_size * multiplier;
    
    // Custom rounding: round up to the nearest valid lot size increment (0.01)
    // We use ceil to ensure we round up to the nearest valid lot size
    double valid_increment = 0.01; // Assuming 0.01 is the smallest increment allowed by the broker
    new_lot_size = MathCeil(new_lot_size / valid_increment) * valid_increment;
    
    return new_lot_size;
}
double x_price ,y_price,xx_price,yy_price;
double SLS_PRICE,SLB_PRICE, TPB_PRICE,TPS_PRICE;
double PS;
//double total=0;
int pip;
int x_orders,y_orders; 
double xy_vol;
 double pv,tz,bep_x,bep_y,bep;
 double x_vol,y_vol,x_pl,y_pl,bep_buy,bep_sell;
 double initial_buy,initial_sell;
 double  Martin_Buy,Martin_Sell, Martin_TPB,Martin_TPS, Martin_SLB,Martin_SLS;
 double modif_tpb, modif_tps;
double modif_tpb2,modif_tps2;
double XYZ;
double last_vol;
double total_xp,total_yp,total_xv,total_yv,avg_xx,avg_yy; 
 double Diff_B,Diff_S, Total_Profit_X,Total_ProfitY; 
int Ord_Modif;
double close_allxy;
double  Lot_MultiB,Lot_MultiS;

datetime Loss_XT,Loss_YT,CO_Time;
int CO_Orders;
double his_xy,his_x,his_y;
double bcp,Close_BL, scp,Close_SL;

int Select,Ord_delete,ticket;



double BEP_YYY,BEP_XXX;
int jarak_y,jarak_x;
color color_text10;
double COPL, COPLx,COPLy;
int CO_Ordersx,CO_Ordersy;
bool isMaxPackage = false;
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
int MG = -1; // Magic advisor else -1
int OnInit()

{  
    //= Authorization ==========================================+
  if(DataOnInit(domen,path,port,check,program,version,    //|
                URLbuy,URLupdate,ref,perc,shTxt,MG,"abc"))//|
    return(INIT_FAILED);                                  //|
//==========================================================+
   // #include <InitChecks.mqh>
return(0);
 }
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||


//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
void OnDeinit(const int reason)  
{
DataOnDeinit(reason); 
CleanUp();

}
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
int start()
{ 

 if(!Activation()) {
    lSetLabel(prog+"Work_1","EA locked: Register To Resume",clrCadetBlue,20,20,CORNER_LEFT_UPPER,12,"Arial",ANCHOR_LEFT_UPPER,false,false,"\n");
    
  }
  if(YesKey==false){  } ;
//==========================================================+


 if (DemoAccount_Only==true)
   {
  if (IsDemo()==false )
    {
    
  if(ObjectFind("DemoAccount") != 0) 
   {
     ObjectCreate("DemoAccount", OBJ_LABEL, 0,0,0);
     ObjectSetText("DemoAccount","Trial Version, EA can run only on Demo Account " ,14, "Impact", clrMagenta);
     ObjectSet("DemoAccount", OBJPROP_XDISTANCE,5);
     ObjectSet("DemoAccount", OBJPROP_YDISTANCE,15);
     ObjectSet("DemoAccount", OBJPROP_CORNER, 1);
     
     ObjectCreate("DemoAccount2", OBJ_LABEL, 0,0,0);
     ObjectSetText("DemoAccount2",Contact_Person,14, "Impact", clrLime);
     ObjectSet("DemoAccount2", OBJPROP_XDISTANCE,5);
     ObjectSet("DemoAccount2", OBJPROP_YDISTANCE,5);
     ObjectSet("DemoAccount2", OBJPROP_CORNER, 3);// 
   }
    return(0);
   } 
  } 

//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||


//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

 if (ProtectBy_ACC_NUMBER==true)
   {
  if ( AccountNumber()!=ACC_NUMBER && ACC_NUMBER>0 )
    {
  if(ObjectFind("Key_Word2") != 0 ) 

   {
     ObjectCreate("Key_Word2", OBJ_LABEL, 0,0,0);
     ObjectSetText("Key_Word2",invalid_ac ,14, "Impact", Blue);
     ObjectSet("Key_Word2", OBJPROP_XDISTANCE,5);
     ObjectSet("Key_Word2", OBJPROP_YDISTANCE,15);
     ObjectSet("Key_Word2", OBJPROP_CORNER, 1);
     
     ObjectCreate("Key_Word1", OBJ_LABEL, 0,0,0);
     ObjectSetText("Key_Word1",Contact_Person,14, "Impact", Lime);
     ObjectSet("Key_Word1", OBJPROP_XDISTANCE,5);
     ObjectSet("Key_Word1", OBJPROP_YDISTANCE,5);
     ObjectSet("Key_Word1", OBJPROP_CORNER, 3);// 
   }
     return(0);
   } 
  }      
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

 
if(Digits==5||Digits==3) pip=10; else pip=1;
Spread = (Ask-Bid)/Point/pip;


MinLot=MarketInfo(NULL,MODE_MINLOT);  
MaxLot=MarketInfo(NULL,MODE_MAXLOT);     
     
if (MinLot==0.01 ) Lot_Digits=2;
if (MinLot==0.1 ) Lot_Digits=1;
if (MinLot==1 ) Lot_Digits=0; 

//HideTestIndicators(true);
if(Digits==5||Digits==3) pip=10; else pip=1;

 if (DayOfWeek()==1) hari= Day1;
  if (DayOfWeek()==2) hari= Day2;
  if (DayOfWeek()==3) hari= Day3;
  if (DayOfWeek()==4) hari= Day4;
  if (DayOfWeek()==5) hari= Day5;
  if (DayOfWeek()==6) hari= Day6;
  if (DayOfWeek()==7) hari= Day7;
    
 
pv=NormalizeDouble(MarketInfo(NULL,MODE_TICKVALUE),Digits); 

 
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
if( ExpiredTime_ON)
{
 if ((Year()>eyear) || (Year()==eyear && Month()>emonth) || (Year()==eyear && Month()==emonth && Day()>expired_date))
    {
    
   if(ObjectFind("expiredlabel") != 0)
   {  
     ObjectCreate("expiredlabel", OBJ_LABEL, 0,0,0);
     ObjectSetText("expiredlabel",Expired_com,14, "Impact", Red);
     ObjectSet("expiredlabel", OBJPROP_XDISTANCE,5);
     ObjectSet("expiredlabel", OBJPROP_YDISTANCE,30);
     ObjectSet("expiredlabel", OBJPROP_CORNER, 0);
     
     ObjectCreate("Contact_Me", OBJ_LABEL, 0,0,0);
     ObjectSetText("Contact_Me",Contact_Person ,14, "Impact", SkyBlue);
     ObjectSet("Contact_Me", OBJPROP_XDISTANCE,5);
     ObjectSet("Contact_Me", OBJPROP_YDISTANCE,50);
     ObjectSet("Contact_Me", OBJPROP_CORNER, 0);
   }
     return(0);
   } 
   }
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||



CO_Orders=0; COPL=0; COPLWH=0; CO_Ordersx=0; COPLx=0; CO_Ordersy=0; COPLy=0;
for(cnt=0; cnt<OrdersHistoryTotal(); cnt++)  
   {
     select=OrderSelect(cnt, SELECT_BY_POS, MODE_HISTORY);
	  if( OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number )
	    {
	     his_xy=OrderType();
	     CO_Orders++;
	     COPL+=OrderProfit()+OrderSwap()+OrderCommission() ;
	     }
	     
	  if( OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number &&
	   iBarShift(_Symbol,PERIOD_W1,TimeCurrent())==iBarShift(_Symbol,PERIOD_W1,OrderCloseTime()) )
	     {
	     COPLWH+=OrderProfit()+OrderSwap()+OrderCommission();
	     } 
	     else{ COPLWH+=0;}
	     

	   if ( OrderSymbol()==Symbol() && OrderType()==0&& OrderMagicNumber() == Magic_Number && OrderClosePrice()==OrderStopLoss() )
	     {
	     Loss_XT=OrderCloseTime();
        scp= OrderClosePrice();
        Close_SL= OrderStopLoss();  
        
	     }
	     
	     if ( OrderSymbol()==Symbol() && OrderType()==1 && OrderMagicNumber() == Magic_Number  )
	     {
	     CO_Ordersy++;
        COPLy+=OrderProfit()+OrderSwap()+OrderCommission() ; 
	     } 
	     
	     
	      if ( OrderSymbol()==Symbol() && OrderType()==0&& OrderMagicNumber() == Magic_Number )
	     {
	     CO_Ordersx++;
	     CO_Time=OrderCloseTime();
        COPLx+=OrderProfit()+OrderSwap()+OrderCommission() ; 
	     } 
    }
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||   

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNXXXXX 
 if(Digits()==3|| Digits()==5)
 {
 tolerance= slippage*10;
 } 
 else
 
  {
  tolerance= slippage*1;
  }

   Local_Time = TimeLocal();
   Server_Time = TimeCurrent();
  
   Time_Local =TimeToStr(Local_Time,TIME_MINUTES|TIME_SECONDS);
   Time_Serv =TimeToStr(Server_Time,TIME_MINUTES|TIME_SECONDS);

 
 //NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNXXXXX

 OpenBuy    = 0;      OpenSell    = 0;
 OpenOrders    = 0;
 x_price=0; y_price=0;
 xx_price=0; yy_price=0;
 XYZ=0;
 Profit=0;
 total_xp=0;total_yp=0;total_xv=0;total_yv=0;
 avg_xx=0; avg_yy=0; COPLWC=0;
for( cnt=0; cnt<OrdersTotal(); cnt++)   
   {
     select=OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
     {
	  if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number)
	     {
	     OpenOrders++;
	     xy_vol=OrderLots();
	     XYZ+=(OrderProfit() +OrderCommission()+OrderSwap());
	     Profit +=OrderProfit();
	     last_vol=OrderLots();
	     }
	    
	   if( OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number && iTime(NULL,PERIOD_W1,0) )
	    {
	    COPLWC+=OrderProfit()+OrderSwap()+OrderCommission() ;
	    }  
	     
	     if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number && OrderType()==1 )
	     {
	     OpenSell++;
	     y_vol=OrderLots();
	     Sell_Price=OrderOpenPrice();
	     SLS_PRICE=OrderStopLoss();
	     TPS_PRICE=OrderTakeProfit();
	     y_price +=OrderOpenPrice();;
	     yy_price =NormalizeDouble ( (y_price/OpenSell),Digits);
	     total_yv +=OrderLots();
	     total_yp +=(OrderProfit()+OrderCommission()+OrderSwap());
	     avg_yy= NormalizeDouble(total_yp/total_yv/pv,Digits);
	     TimeY=OrderOpenTime();
	     } 
	     
	     if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number && OrderType()==OP_BUY )
	     {
	     x_vol=OrderLots();
	     OpenBuy++;
	     total_xp +=(OrderProfit()+OrderCommission()+OrderSwap());
	     Buy_Price=OrderOpenPrice();
	     SLB_PRICE=OrderStopLoss();
	     TPB_PRICE=OrderTakeProfit();
	     x_price +=OrderOpenPrice();
	     xx_price =NormalizeDouble ( (x_price/OpenBuy),Digits);
	     total_xv +=OrderLots();
	     avg_xx= NormalizeDouble(total_xp/total_xv/pv,Digits);
	     TimeX=OrderOpenTime();
	     }
	     
   }
}
//=======================================================================================================================||

//------------------------------------------------------------------------------------------------|| 
//---------------------------------------------------------------------------------------------------||





//---------------------------------------------------------------------------------------------------||


if(Trade_Mode==1 )
{
C_MACD= iMACD(NULL,0,Fast_EMA,Slow_EMA,MACD_SMA,MACD_Price,MODE_MAIN,1);
P_MACD= iMACD(NULL,0,Fast_EMA,Slow_EMA,MACD_SMA,MACD_Price,MODE_MAIN,2);
C_SMACD=iMACD(NULL,0,Fast_EMA,Slow_EMA,MACD_SMA,MACD_Price,MODE_SIGNAL,1); 
P_SMACD=iMACD(NULL,0,Fast_EMA,Slow_EMA,MACD_SMA,MACD_Price,MODE_SIGNAL,2);

if( (TRADES==1&&C_MACD>C_SMACD && P_MACD<=P_SMACD )//BUY
   ||(TRADES==2&&C_MACD>C_SMACD))
{ SendBUY="UP"; ExitSell="YES"; }  else  { SendBUY="NONE"; ExitSell="NONE"; }

if((TRADES==1&&C_MACD<C_SMACD && P_MACD>=P_SMACD )//SELL
 ||(TRADES==2&&C_MACD<C_SMACD ))
{ SendSELL="DN"; ExitBUY="YES"; }  else  { SendSELL="NONE"; ExitBUY="NONE";}
}


//------------------------------------------------------------------------||
if(Trade_Mode==2 )
{
C_HA1=iCustom(NULL,0,"Heiken Ashi",2,CandleBase);//open
P_HA1=iCustom(NULL,0,"Heiken Ashi",2,CandleBase+1);
C_HA2=iCustom(NULL,0,"Heiken Ashi",3,CandleBase);//close
P_HA2=iCustom(NULL,0,"Heiken Ashi",3,CandleBase+1);

if ( (C_HA1< C_HA2 &&P_HA1>= P_HA2 && TRADES==1)
|| (C_HA1< C_HA2 && TRADES==2) )
{ SendBUY="UP"; ExitSell="YES"; }  else  { SendBUY="NONE"; ExitSell="None";}

if ( (C_HA1> C_HA2 &&P_HA1<= P_HA2 && TRADES==1)
   ||(C_HA1> C_HA2&& TRADES==2))
{ SendSELL="DN"; ExitBUY="YES"; }   else  { SendSELL="NONE"; ExitBUY="NONE"; }
}





if(Trade_Mode==3 )
{
BandUpper  =iBands(Symbol(),0,BandsPeriod,Deviations,0,Band_Price,MODE_UPPER,1);
BandLower  =iBands(Symbol(),0,BandsPeriod,Deviations,0,Band_Price,MODE_LOWER,1);
BandMiddle=iBands(Symbol(),0,BandsPeriod,Deviations,0,Band_Price,MODE_MAIN,1);

// Check if the distance between the bands meets the sensitivity criteria
        if (CheckBandDistance(BandUpper, BandLower, sensitivity)) {
            if (Bid > BandUpper) {
                SendSELL = "DN";
                ExitBUY = "YES";
            } else {
                SendSELL = "NONE";
                ExitBUY = "NONE";
            }

            if (Bid < BandLower) {
                SendBUY = "UP";
                ExitSell = "YES";
            } else {
                SendBUY = "NONE";
                ExitSell = "NONE";
            }
        } else {
            // If the band distance is less than the sensitivity, skip trade checks
            SendSELL = "NONE";
            SendBUY = "NONE";
            ExitBUY = "NONE";
            ExitSell = "NONE";
        }


//if(Bid>BandUpper )
//{ SendSELL="DN"; ExitBUY="YES"; }   else  { SendSELL="NONE"; ExitBUY="NONE"; }
//
//if(Bid<BandLower )
//{ SendBUY="UP"; ExitSell="YES"; }  else  { SendBUY="NONE"; ExitSell="NONE"; }
}
//------------------------------------------------------------------------||

 

//------------------------------------------------------------------------||
if(Trade_Mode==4 )
{
buffer1=GetIndicatorValue(8);
buffer2=GetIndicatorValue(9);

//if (buffer1>1){buffer1=0;} else {buffer1=GetIndicatorValue(11);}
//if (buffer2>1){buffer2=0;} else {buffer2=GetIndicatorValue(10);}

if(OpenOrders==0 && buffer1>0 ) 
{ SendBUY="UP";ExitSell="YES"; }  else  { SendBUY="NONE";ExitSell="NONE"; }

if(OpenOrders==0 && buffer2>0 ) 
{ SendSELL="DN"; ExitBUY="YES";}   else  { SendSELL="NONE"; ExitBUY="NONE";}
}

/*
if(Trade_Mode==5 )
{
buffer1=GetIndicatorValue(2);
buffer2=GetIndicatorValue(3);

if (buffer1>1000000){buffer1=0;} else {buffer1=GetIndicatorValue(2);}
if (buffer2>1000000){buffer2=0;} else {buffer2=GetIndicatorValue(3);}

if(OpenOrders==0 && buffer1>0 ) 
{ SendSELL="DN"; }   else  { SendSELL="NONE"; }

if(OpenOrders==0 && buffer2>0 )
{ SendBUY="UP"; }  else  { SendBUY="NONE"; }
}
//------------------------------------------------------------------------||
*/


//------------------------------------------------------------------------------------------------||  


if(Digits()==3 || Digits()==5) { pip=10; } else {pip=1;}

if(Stoploss==0)
{
SLB=0;
SLS=0;
}

if(Stoploss>0)
{
SLB=NormalizeDouble(Ask-Stoploss*pip*Point,Digits);
SLS=NormalizeDouble(Bid+Stoploss*pip*Point,Digits);
}

if( FirstTrade_TP>0)
{
TPB=NormalizeDouble(Ask+FirstTrade_TP*pip*Point,Digits);
TPS=NormalizeDouble(Bid-FirstTrade_TP*pip*Point,Digits);
}
if( FirstTrade_TP==0 )
{
TPB=0;
TPS=0;
}
 //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||

if(Package=="MINI" || Package=="MAX") {
    /* BLOCK 1 */ lSetLabel(prog+"Work_1","EA Expiration: "+(string)_ansTime,clrMediumTurquoise,5,20,CORNER_LEFT_UPPER,10,"Arial",ANCHOR_LEFT_UPPER,false,false,"\n");
 
 
 // Set the package mode
isMaxPackage = (Package == "MAX");

// Set the label based on the package type
if(isMaxPackage) {
    // Display "Premium EA" in the lower left corner
    lSetLabel(
        PACKAGE_INFO_LABEL,                                     // Label name
        "Premium EA: All Features Working",                                           // Text
        clrDarkGreen,                                               // Text color
        10,                                                     // X distance from corner
        20,                                                    // Y distance from corner (adjust as needed)
        CORNER_LEFT_LOWER,                                      // Corner (lower left)
        12,                                                     // Font size
        "Arial",                                                // Font type
        ANCHOR_LEFT_LOWER,                                      // Anchor point
        false,                                                  // Selectable
        false,                                                  // Back
        ""                                                      // Tooltip
    );
} else {
    // Display warning message in the lower left corner for MINI package
    lSetLabel(
        PACKAGE_INFO_LABEL,                                     // Label name
        "Limited Functionality: Risk Management and Trailing Disabled", // Text
        clrRed,                                                 // Text color
        10,                                                     // X distance from corner
        20,                                                    // Y distance from corner (adjust as needed)
        CORNER_LEFT_LOWER,                                      // Corner (lower left)
        11,                                                     // Font size
        "Arial",                                                // Font type
        ANCHOR_LEFT_LOWER,                                      // Anchor point
        false,                                                  // Selectable
        false,                                                  // Back
        ""                                                      // Tooltip
    );
}

 
 //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
if (OpenBuy==0 &&OpenOrders==0 &&Filter_TImeFriday() && Filter_TIme() && MaxSpread()&& SendBUY=="UP" && Filter_Trial()&& DemoON() )


{
  if (AccountFreeMargin()<MarketInfo(NULL,MODE_MARGINREQUIRED)*MinLot ) 
    {    Print("Not Enought Money to open trade ,Or Volume trade too big"); return(0); }
   else   
   {    
   ord_send=OrderSend (Symbol(),0,AutoLot(),Ask,slippage*pip,SLB,TPB,"- BUY Order : " +DoubleToStr(1,0)//"BUY : " +DoubleToStr(Magic_Number,0)
   ,Magic_Number,0,Blue);
   }
}

if ( OpenSell==0 && OpenOrders==0 &&Filter_TImeFriday() && Filter_TIme()&& MaxSpread() && SendSELL=="DN"  && Filter_Trial()  && DemoON()  )


    {  
    if (AccountFreeMargin()<MarketInfo(NULL,MODE_MARGINREQUIRED)*MinLot ) 
        {    Print("Not Enought Money to open trade ,Or Volume trade too big"); return(0); }
   else
   {    
   ord_send= OrderSend(Symbol(),1,AutoLot(),Bid,slippage*pip,SLS,TPS,"- SELL Order : " +DoubleToStr(1,0)//"SELL : " +DoubleToStr(Magic_Number,0)
   ,Magic_Number,0,Red); 
   }
}
}
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||



MR=MarketInfo(NULL,MODE_MARGINREQUIRED);
FM=AccountFreeMargin();


//-----------------------------------------------------------------------------------||
if(MartingaleLot_Type==1)
{
if (OpenBuy==1)
{
LMB=NormalizeDouble(Lot2,Lot_Digits);
}

if (OpenBuy==2)
{
LMB=NormalizeDouble(Lot3,Lot_Digits);
}

if (OpenBuy==3)
{
LMB=NormalizeDouble(Lot4,Lot_Digits);
}

if (OpenBuy==4)
{
LMB=NormalizeDouble(Lot5,Lot_Digits);
}
if (OpenBuy==5)
{
LMB=NormalizeDouble(Lot6,Lot_Digits);
}

if (OpenBuy==6)
{
LMB=NormalizeDouble(Lot7,Lot_Digits);
}

if (OpenBuy==7)
{
LMB=NormalizeDouble(Lot8,Lot_Digits);
}

if (OpenBuy==8)
{
LMB=NormalizeDouble(Lot9,Lot_Digits);
}
if (OpenBuy==9)
{
LMB=NormalizeDouble(Lot10,Lot_Digits);
}

if (OpenBuy==10)
{
LMB=NormalizeDouble(Lot11,Lot_Digits);
}

if (OpenBuy==11)
{
LMB=NormalizeDouble(Lot12,Lot_Digits);
}

if (OpenBuy==12)
{
LMB=NormalizeDouble(Lot13,Lot_Digits);
}
if (OpenBuy==13)
{
LMB=NormalizeDouble(Lot14,Lot_Digits);
}

if (OpenBuy==14)
{
LMB=NormalizeDouble(Lot15,Lot_Digits);
}

if (OpenBuy==15)
{
LMB=NormalizeDouble(Lot16,Lot_Digits);
}

if (OpenBuy==16)
{
LMB=NormalizeDouble(Lot17,Lot_Digits);
}
if (OpenBuy==17)
{
LMB=NormalizeDouble(Lot18,Lot_Digits);
}


if (OpenBuy==18)
{
LMB=NormalizeDouble(Lot19,Lot_Digits);
}

if (OpenBuy==19)
{
LMB=NormalizeDouble(Lot20,Lot_Digits);
}

if (OpenBuy==20)
{
LMB=NormalizeDouble(Lot21,Lot_Digits);
}
if (OpenBuy==21)
{
LMB=NormalizeDouble(Lot22,Lot_Digits);
}

if (OpenBuy==22)
{
LMB=NormalizeDouble(Lot23,Lot_Digits);
}
if (OpenBuy==23)
{
LMB=NormalizeDouble(Lot24,Lot_Digits);
}

if (OpenBuy==24)
{
LMB=NormalizeDouble(Lot25,Lot_Digits);
}
if (OpenBuy==25)
{
LMB=NormalizeDouble(Lot26,Lot_Digits);
}

if (OpenBuy==26)
{
LMB=NormalizeDouble(Lot27,Lot_Digits);
}
if (OpenBuy==27)
{
LMB=NormalizeDouble(Lot28,Lot_Digits);
}
if (OpenBuy==28)
{
LMB=NormalizeDouble(Lot29,Lot_Digits);
}
if (OpenBuy==29)
{
LMB=NormalizeDouble(Lot30,Lot_Digits);
}
//-----------------------------------------------------------------------------------||

//-----------------------------------------------------------------------------------||
if (OpenSell==1)
{
LMS=NormalizeDouble(Lot2,Lot_Digits);
}

if (OpenSell==2)
{
LMS=NormalizeDouble(Lot3,Lot_Digits);
}
if (OpenSell==3)
{
LMS=NormalizeDouble(Lot4,Lot_Digits);
}
if (OpenSell==4)
{
LMS=NormalizeDouble(Lot5,Lot_Digits);
}
if (OpenSell==5)
{
LMS=NormalizeDouble(Lot6,Lot_Digits);
}
if (OpenSell==6)
{
LMS=NormalizeDouble(Lot7,Lot_Digits);
}
if (OpenSell==7)
{
LMS=NormalizeDouble(Lot8,Lot_Digits);
}
if (OpenSell==8)
{
LMS=NormalizeDouble(Lot9,Lot_Digits);
}
if (OpenSell==9)
{
LMS=NormalizeDouble(Lot10,Lot_Digits);
}
if (OpenSell==10)
{
LMS=NormalizeDouble(Lot11,Lot_Digits);
}
if (OpenSell==11)
{
LMS=NormalizeDouble(Lot12,Lot_Digits);
}
if (OpenSell==12)
{
LMS=NormalizeDouble(Lot13,Lot_Digits);
}
if (OpenSell==13)
{
LMS=NormalizeDouble(Lot14,Lot_Digits);
}
if (OpenSell==14)
{
LMS=NormalizeDouble(Lot15,Lot_Digits);
}
if (OpenSell==15)
{
LMS=NormalizeDouble(Lot16,Lot_Digits);
}
if (OpenSell==16)
{
LMS=NormalizeDouble(Lot17,Lot_Digits);
}
if (OpenSell==17)
{
LMS=NormalizeDouble(Lot18,Lot_Digits);
}

if (OpenSell==18)
{
LMS=NormalizeDouble(Lot19,Lot_Digits);
}
if (OpenSell==19)
{
LMS=NormalizeDouble(Lot20,Lot_Digits);
}

if (OpenSell==20)
{
LMS=NormalizeDouble(Lot21,Lot_Digits);
}
if (OpenSell==21)
{
LMS=NormalizeDouble(Lot22,Lot_Digits);
}

if (OpenSell==22)
{
LMS=NormalizeDouble(Lot23,Lot_Digits);
}
if (OpenSell==23)
{
LMS=NormalizeDouble(Lot24,Lot_Digits);
}
if (OpenSell==24)
{
LMS=NormalizeDouble(Lot25,Lot_Digits);
}
if (OpenSell==25)
{
LMS=NormalizeDouble(Lot26,Lot_Digits);
}

if (OpenSell==26)
{
LMS=NormalizeDouble(Lot27,Lot_Digits);
}

if (OpenSell==27)
{
LMS=NormalizeDouble(Lot28,Lot_Digits);
}
if (OpenSell==28)
{
LMS=NormalizeDouble(Lot29,Lot_Digits);
}
if (OpenSell==29)
{
LMS=NormalizeDouble(Lot30,Lot_Digits);
}

}
//+++++++++++++++ chatgpt, 


// Example usage in the order placement section:
if(MartingaleLot_Type == 2)
{
    if (OrderType() == OP_BUY && OrderMagicNumber() == Magic_Number && TotalOpenBuyOrders())
    {
        double previous_lot_size = TotalOpenBuyLots();
        LMB = CalculateLotSize(previous_lot_size, lotsizemultiplier);
    }

    if (OrderType() == OP_SELL && OrderMagicNumber() == Magic_Number && TotalOpenSellOrders())
    {
        double previous_lot_size = TotalOpenSellLots();
        LMS = CalculateLotSize(previous_lot_size, lotsizemultiplier);
    }
}

//-----------------------------------------------------------------------------------||
 
//Multiplier=(100.0-BreakenTrailAmount)/BreakenTrailAmount;
   //lotsize=Initial_Lot;
   //commented
//if(MartingaleLot_Type==2)
//     {
//      if( OrderType()==OP_BUY && OrderMagicNumber()==Magic_Number && TotalOpenBuyOrders())
//         LMB=TotalOpenBuyLots()*lotsizemultiplier;
//         //LMB=TotalOpenBuyLots()*Multiplier;
//      if( OrderType()==OP_SELL && OrderMagicNumber()==Magic_Number  && TotalOpenSellOrders())
//         LMS=TotalOpenSellLots()*lotsizemultiplier;
//         //LMS=TotalOpenSellLots()*Multiplier;
//     }
//

  
   
 //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||
  
if(OpenSell==1)   
{//ProfitTargetY=FirstTPAmount; 
GridStepY=GridStep;}

if(OpenSell>=2)  
{//ProfitTargetY=GridTP*GridTP_Multiplier*OpenSell;
GridStepY=NormalizeDouble(GridStep*(MathPow(GridStepMultiplier,(OpenSell-1) )),Lot_Digits);
}


if(OpenBuy==1)
{//ProfitTargetX=FirstTPAmount;
GridStepX=GridStep;}

if(OpenBuy>=2)
{//ProfitTargetX=GridTP*GridTP_Multiplier*OpenBuy;
GridStepX=NormalizeDouble(GridStep*(MathPow(GridStepMultiplier,(OpenBuy-1) )),Lot_Digits);
} 
 
 
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||
  if (Martingale_ON==true )
 {
 

 
 if( OpenBuy>0 &&XSignal() && X_Distance() && XTradePerBar() && MaxSpread() && OpenBuy<MaxTrades
 && MAX_DD()&& MaxLotX() 
 )// && FM<NormalizeDouble( LMB *MR,2) )
 
 {
  if (NormalizeDouble( FM,0)<NormalizeDouble( LMB *MR,2))   
  {   Print("Volume trade too big,Or Not Enought Money to open trade");
      return(0);
   }  else  
   ord_send=OrderSend (Symbol(),OP_BUY,LMB,Ask,slippage*pip,SLB_PRICE,0,"- BUY Order : " +DoubleToStr(OpenBuy+1,0)//+DoubleToStr(Magic_Number,0)
   ,Magic_Number,0,Aqua);
 }
 
 
   
 if( OpenSell>0 &&YSignal()&& Y_Distance() && YTradePerBar()&& MaxSpread()  && OpenSell<MaxTrades && MaxLotY()
 && MAX_DD() // && LMS<= Max_Lot
 )//&& FM<NormalizeDouble( LMS *MR,2) )
  
  { 
    if (FM<NormalizeDouble( LMS *MR,2) )
  { Print("Volume trade too big,Or Not Enought Money to open trade"); 
   return(0); }    else 
   ord_send=OrderSend (Symbol(),OP_SELL,LMS,Bid,slippage*pip,SLS_PRICE,0 ,"- SELL Order : " +DoubleToStr(OpenSell+1,0)//+DoubleToStr(Magic_Number,0)
   ,Magic_Number,0,Magenta);
   } 
   
 }
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||  

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
if(OpenBuy>0 )
{
BEP_XXX= NormalizeDouble ( (Bid-avg_xx*Point),Digits);
TPB_ALL=NormalizeDouble( (BEP_XXX+( Average_TP*pip*Point) ),Digits);
}
if(OpenSell>0 )
{
BEP_YYY= NormalizeDouble ( (Ask+avg_yy*Point),Digits);
TPS_ALL=NormalizeDouble( ( BEP_YYY - (Average_TP*pip*Point)),Digits);
} 
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

 
if(OpenSell>1 && BEP_YYY>0)
{
if(ObjectFind("BEP_YYY") != 0 )
{
   ObjectCreate("BEP_YYY", OBJ_HLINE, 0, Time[0], NormalizeDouble( BEP_YYY,Digits));
   ObjectSet("BEP_YYY", OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet("BEP_YYY", OBJPROP_WIDTH,1);
   ObjectSet("BEP_YYY", OBJPROP_COLOR, clrMagenta);
}
}

double BepSell,BepBuy;

BepSell= ObjectGet("BEP_YYY",OBJPROP_PRICE1) ;
if(OpenSell==0 || MathAbs(NormalizeDouble( BepSell,Digits) -NormalizeDouble(BEP_YYY,Digits))>1*pip*Point ) 
{ObjectDelete("BEP_YYY");} 
 
 
 
if(OpenBuy>1 && BEP_XXX>0)
{
if(ObjectFind("BEP_XXX") != 0 )
{
   ObjectCreate("BEP_XXX", OBJ_HLINE, 0, Time[0], NormalizeDouble( BEP_XXX,Digits));
   ObjectSet("BEP_XXX", OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet("BEP_XXX", OBJPROP_WIDTH,1);
   ObjectSet("BEP_XXX", OBJPROP_COLOR, clrMagenta);
}
}


BepBuy= ObjectGet("BEP_XXX",OBJPROP_PRICE1) ;
if(OpenBuy==0 || MathAbs(NormalizeDouble( BepBuy,Digits)-NormalizeDouble(BEP_XXX,Digits) )>1*pip*Point) 
{ObjectDelete("BEP_XXX");} 

 
if(Average_ALL==true && Average_TP>0 )
   {
   cnt=0;
      for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
        { 
         select=OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_Number)
           {       
           
                 
            if(OrderType()==OP_SELL && OpenSell>1&& TPS_PRICE==0   )
                    {
modif=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),NormalizeDouble( ( BEP_YYY - (Average_TP*pip*Point)),Digits)
                     ,0,Yellow);
                    }
        if(OrderType()==OP_BUY && OpenBuy>1  && TPB_PRICE==0  )
              {
              
 modif=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),NormalizeDouble( (BEP_XXX+( Average_TP*pip*Point)),Digits)
                        ,0,Yellow); 
                    }
              //===
              
                 }
                 
              }
         }
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
double TSP;

TSP=( TrailingStep+Trailing_Start)*pip;
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
if (isMaxPackage && Trailing_Stop_ON)
{
for( cnt=OrdersTotal()-1;cnt>=0;cnt--)
	    {
	      select=OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		   if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number) 
		      {
		   	  if (OrderType()==OP_BUY &&OpenBuy==1 ) 
		   	   { 
		   	  if(Trailing_Stop>0)  
              {           
               if(Bid-OrderOpenPrice()>=Point*Trailing_Stop*pip)
                 {
                  if( ( OrderStopLoss()<= Bid-Point*TSP )|| (OrderStopLoss()==0) ) 
                    {
                     Ord_Modif=OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(Bid-(Point*Trailing_Start*pip),Digits)
                     ,OrderTakeProfit(),0,Lime);
                     return(0);
                    }
                 }
              }
           } 
		   	 
		   	else  if (OrderType()==OP_SELL &&OpenSell==1)
		   	 {
		   	  if(Trailing_Stop>0)  
              {                 
               if((OrderOpenPrice()-Ask)>=Point*Trailing_Stop*pip)
                 {
                  if( (OrderStopLoss()>=Ask+ Point*TSP )  || (OrderStopLoss()==0))
                    {
                     Ord_Modif=OrderModify(OrderTicket(),OrderOpenPrice(),
                     NormalizeDouble(Ask+(Point*Trailing_Start*pip),Digits),OrderTakeProfit(),0,Red);
                     return(0);
                    }
                 }
              }
           }
        
        	      }
	               }
	                 }
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||

//-----------------------------------------------------------------------------------------||
if (CloseOnOpppositeSignal )
{
	 for( cnt=OrdersTotal()-1; cnt>=0;cnt--)
	    {
	      Select= OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		   if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number)
		      {
		   	  if ( OrderType()==OP_BUY && OpenBuy>0 &&ExitBUY=="YES" )
		   	   {
		   	    int Close_Order=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slippage,clrAqua);
		   	    }
		   	    
		   	    
			     if( OrderType()==OP_SELL && OpenSell>0 &&  ExitSell=="YES" )
			     {
			      int Close_Order=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slippage,clrMagenta);
			      }   
		      }
	    }
	 }
//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

 WeeklyPL=NormalizeDouble( ((XYZ+COPLWH) /AccountBalance())*100,2);	 
//----------------------------------------------------------------------------------------||


// Risk Management 1: Total Profit and Loss
if(isMaxPackage) {

//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW


if(AmountOf_Total_Profit>0 && OpenOrders>0 )
{
if (( NormalizeDouble( XYZ ,2)  >=AmountOf_Total_Profit) )
   {	  
	 for( cnt=OrdersTotal()-1; cnt>=0; cnt--)
	    {
	      select= OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		   if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number) 
		      {
		   	  if (OrderType()<2) 
		   	   { ord_close=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),tolerance,Blue); }
		   	  if(HitProfit_ExpertRemoves==true) 
		   	   {ExpertRemove();}
			    }
	    }
	 } 
}    



//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

if( AmountOf_Total_Loss>0 )
{
if (  ( NormalizeDouble( XYZ ,2) <= -AmountOf_Total_Loss) )
   {	  
	 for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
	    {
	      select= OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		   if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number) 
		      { 
		   	  if (OrderType()<2) 
		   	   { ord_close=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),tolerance,Blue); }
			     if(HitLoss_ExpertRemoves==true) 
		   	   {ExpertRemove();}
			      }
	      }
	 } 
} 
   


//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

if(PercentOf_Total_Profit>0  && OpenOrders>0 )
{
if (( NormalizeDouble( ( (XYZ+COPLWH) /AccountBalance())*100,2)  >=PercentOf_Total_Profit))
   {	  
	 for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
	    {
	      select= OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		     if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number) 
		       {
		   	  if (OrderType()<2 ) 
		   	   { ord_close=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),tolerance,Blue); }
			      if(HitPercentagePro_ExpertRemoves==true) 
		   	   {ExpertRemove();}
			     }
	     }
	 } 
}    
//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

if(PercentOf_Total_Loss>0  && OpenOrders>0 )
{
if (( NormalizeDouble( ((XYZ+COPLWH) /AccountBalance())*100,2)  <=-PercentOf_Total_Loss) )
   {	  
	 for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
	    {
	      select= OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		  if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number) 
		      { 
		   	  if (OrderType()<2) 
		   	   { ord_close=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),tolerance,Blue); }
			     if(HitPercentageLoss_ExpertRemoves==true) 
		   	   {ExpertRemove();}
			   
			      }
	    }
	 } 
	 }  
	 }  
//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

if (OrdersTotal()>0)
{
plall= NormalizeDouble ( AccountEquity()-AccountBalance() ,2 ) ;
DDall =NormalizeDouble ( plall/AccountBalance() *100 ,2 ) ;
}
else
{
plall=0;
DDall=0;
}
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
if(Filter_MaxSpread ==true &&MarketInfo(NULL,MODE_SPREAD)>Max_Spread*pip)
{
   string_window( "FMS", 5, 30, 0); //
   ObjectSetText( "FMS"," Maximum Spread Reach", text_size, "Cambria", clrRed);  
   ObjectSet( "FMS", OBJPROP_CORNER,0);  
   } else {  ObjectDelete("FMS");}
   
   
       
    if (AccountEquity()<AccountBalance()){color_text10=Red;} else{color_text10=Lime;}
    if( MAX_DrawDawn==true)
   {
   string_window( "DDall", 5, 30, 0); //
   ObjectSetText( "DDall","DD All : " + DoubleToStr(DDall,2) +"( % )", text_size, "Cambria", color_text10);  
   ObjectSet( "DDall", OBJPROP_CORNER,0);  
   } else {  ObjectDelete("DDall");}

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||

if ( Filter_Trial()==false)
      
     {
   string_window( "EA Trial", 5, 15, 0); 
   ObjectSetText( "EA Trial",Trial_version , 30, "Impact", Red);  
   ObjectSet( "EA Trial", OBJPROP_CORNER,0); 
   
   string_window( "EA Trial2", 5, 55, 0); 
  // ObjectSetText( "EA Trial2",Trial_version2 +" : " +Trial_Time , 15, "Impact", Blue);  
   ObjectSet( "EA Trial2", OBJPROP_CORNER,0); 
  }  else{ ObjectDelete("EA Trial"); ObjectDelete("EA Trial2"); }
    




if( DemoAccount_Only==true && CO_Orders> MaxCloseTrades && OpenOrders==0)
 {
 string_window( "DM", 5, 10, 0); 
   ObjectSetText( "DM","Trial Version Has over  " , 20, "Impact", clrBlue);  
   ObjectSet( "DM", OBJPROP_CORNER,0); 
   
   string_window( "CloseTrades", 5, 15+20, 0); 
   ObjectSetText( "CloseTrades","Close Trades More Than  " +DoubleToStr(MaxCloseTrades,0) +" Orders", 25, "Impact", clrRed);  
   ObjectSet( "CloseTrades", OBJPROP_CORNER,0); 
   
   string_window( "CloseTrades2", 5, 50+20, 0); 
   ObjectSetText( "CloseTrades2","EA Stop trades : " +Contact_Person, 16, "Impact", clrAquamarine);  
   ObjectSet( "CloseTrades2", OBJPROP_CORNER,0); 
   
   string_window( "CloseTrades3", 5, 80+20, 0); 
   ObjectSetText( "CloseTrades3"," Close Trades Profit : " +DoubleToStr(COPL,2)+" Close Trades : " +DoubleToStr(CO_Orders,0), 16, "Impact", clrAquamarine);  
   ObjectSet( "CloseTrades3", OBJPROP_CORNER,0); 
   
   ExpertRemove(); 
 }  else{ ObjectDelete("CloseTrades");   ObjectDelete("CloseTrades2");  ObjectDelete("CloseTrades3");  ObjectDelete("DM");}

   
   if(ACCOUNT_INFO)
   {
    Balance = AccountBalance();
    Equity = AccountEquity();
    Range= NormalizeDouble( ( iHigh(NULL,1440,0)-iLow(NULL,1440,0) )/Point/pip,2);
    if (OpenOrders>0 && XYZ !=0)
    {
    DD = NormalizeDouble  ( (XYZ /AccountBalance())*100,2) ;
    }
    else{ DD=0; }
    Spread =NormalizeDouble( (Ask-Bid)/Point/pip,2);
    Lev = AccountLeverage();
    Running_Price = DoubleToStr (Bid,Digits);
    Range_Price   = DoubleToStr (Range,2);
    AB            = DoubleToStr(Balance,2);
    AE            = DoubleToStr(Equity,2);
    Persen_DD     = DoubleToStr(DD,2);
    Leverage             = DoubleToStr (Lev,0);
    

    
    
if ( Filter_Trial()==false)
      
     {
   string_window( "EA Trial", 5, 30, 0); 
   ObjectSetText( "EA Trial",Trial_version , 15, "Impact", Red);  
   ObjectSet( "EA Trial", OBJPROP_CORNER,0); 
   
   string_window( "EA Trial2", 5, 55, 0); 
   ObjectSetText( "EA Trial2",Trial_version2 +"  "  , 15, "Impact", Blue);  
   ObjectSet( "EA Trial2", OBJPROP_CORNER,0); 
     
     }  else{ ObjectDelete("EA Trial"); ObjectDelete("EA Trial");}

int MoveTx_down=15;


   string_window( "Line11", 5, 20, 0); 
   ObjectSetText( "Line11", Line1, text_size, "Impact", ClrLine);  
   ObjectSet( "Line11", OBJPROP_CORNER,text_corner); 
     
    string_window( "hari", 5, 20+MoveTx_down, 0); //
   ObjectSetText( "hari",hari +", "+DoubleToStr( Day(),0)+" - "+DoubleToStr(Month(),0) +" - "
   +DoubleToStr(Year(),0) ,text_size+1, "Impact", clrYellow);  
   ObjectSet( "hari", OBJPROP_CORNER,text_corner);  
 
   string_window( "ACB", 5, 35+MoveTx_down, 0); //
   ObjectSetText( "ACB","Account Name : " +AccountName(), text_size, "Cambria", color_text);  
   ObjectSet( "ACB", OBJPROP_CORNER,text_corner);  
   
   string_window( "ACN", 5, 50+MoveTx_down, 0); //
   ObjectSetText( "ACN","Company : " + AccountCompany() , text_size, "Cambria", color_text);  
   ObjectSet( "ACN", OBJPROP_CORNER,text_corner);  
   
   
   string_window( "Balance", 5, 65+MoveTx_down, 0); //
   ObjectSetText( "Balance","Balance   : " + AB , text_size, "Cambria", color_text);  
   ObjectSet( "Balance", OBJPROP_CORNER,text_corner);  
   
   string_window( "Equity", 5, 80+MoveTx_down, 0); //
   ObjectSetText( "Equity","Equity     : " + AE , text_size, "Cambria", color_text); 
   ObjectSet( "Equity", OBJPROP_CORNER, text_corner); 
   
   string_window( "Spread", 5,95+MoveTx_down, 0);
   ObjectSetText( "Spread","FreeMargin : " + DoubleToStr(AccountFreeMargin(),2) , text_size, "Cambria", color_text);
    ObjectSet( "Spread", OBJPROP_CORNER, text_corner); 
  
   string_window( "Profit", 5, 110+MoveTx_down, 0); 
   ObjectSetText( "Profit", "Curtent Profit : " +DoubleToStr( XYZ,2) +" | DD : "+DoubleToStr( DD,2) +" % "
   , text_size, "Cambria", color_text); 
   ObjectSet( "Profit", OBJPROP_CORNER, text_corner);
   
   
   string_window( "Leverage", 5,125+MoveTx_down, 0);
   ObjectSetText( "Leverage","Weekly P/L : " + DoubleToStr(COPLWH,2)
                             + " | " + DoubleToStr(WeeklyPL,2)+" %" , text_size, "Impact", clrAqua);
   ObjectSet( "Leverage", OBJPROP_CORNER, text_corner);
   
   


   
    string_window( "Range", 5, 140+MoveTx_down, 0); //
   ObjectSetText( "Range","Fixed equity target in % : " + DoubleToStr(PercentOf_Total_Profit,2) , text_size, "Cambria", color_text); 
   ObjectSet( "Range", OBJPROP_CORNER, text_corner); 
   
   string_window( "Price", 5, 155+MoveTx_down, 0); //
   ObjectSetText( "Price","Fixed Equity in amount : " + DoubleToStr(AmountOf_Total_Profit,2) , text_size, "Cambria", color_text); 
   ObjectSet( "Price", OBJPROP_CORNER, text_corner); 
   
   string_window( "CO_Ordersall", 5, 170+MoveTx_down, 0); 
   ObjectSetText( "CO_Ordersall"," Close Trades : " +DoubleToStr(CO_Orders,0)+ " | P/L : " +DoubleToStr(COPL,2), text_size, "Impact", clrYellow);  
   ObjectSet( "CO_Ordersall", OBJPROP_CORNER,text_corner);
   
   string_window( "Line1", 5, 185+MoveTx_down, 0); 
   ObjectSetText( "Line1", Line1, text_size, "Impact", ClrLine);  
   ObjectSet( "Line1", OBJPROP_CORNER,text_corner);
 
 if (OpenSell>=1&&OpenBuy<=0) jarak_y=200+MoveTx_down; else jarak_y=220+MoveTx_down+30;
 if (OpenBuy>0) jarak_x=200+MoveTx_down;
 
    if (OpenSell>0)
    {
   string_window( "sellt2", 5, jarak_y, 0); 
   ObjectSetText( "sellt2","Last Sell Price : " +DoubleToStr(Sell_Price,Digits) , text_size, "Impact", clrRed);  
   ObjectSet( "sellt2", OBJPROP_CORNER,text_corner);  
   
   string_window( "sell", 5, jarak_y+15, 0); //
   ObjectSetText( "sell","Sell Order : " + DoubleToStr(OpenSell,0) +" | Sell Lot : "  + DoubleToStr(total_yv,2)
    , text_size, "Cambria", clrWhite); 
   ObjectSet( "sell", OBJPROP_CORNER, text_corner); 
   
    string_window( "sellt", 5, jarak_y+30, 0); //
   ObjectSetText( "sellt","SELL P/L  Amount : " + DoubleToStr(total_yp,2)  , text_size, "Cambria", clrWhite); 
   ObjectSet( "sellt", OBJPROP_CORNER, text_corner);
   
   }else {ObjectDelete("Tps");  ObjectDelete("SLs"); ObjectDelete("sell");  ObjectDelete("sellt2"); ObjectDelete("sellt");}
  
   if (OpenBuy>0)
   {
   string_window( "buyt2", 5, jarak_x, 0); //
   ObjectSetText( "buyt2","Last Buy Price :  " + DoubleToStr(Buy_Price,Digits) , text_size, "Impact", clrLime); 
   ObjectSet( "buyt2", OBJPROP_CORNER, text_corner);
   
   string_window( "buy", 5, jarak_x+15, 0); //
   ObjectSetText( "buy","Buy Order : " + DoubleToStr(OpenBuy,0)  +" |Buy Lot : " + DoubleToStr(total_xv,2)
   , text_size, "Cambria", clrWhite); 
   ObjectSet( "buy", OBJPROP_CORNER, text_corner); 
   
   string_window( "buyt", 5, jarak_x+30, 0); //
   ObjectSetText( "buyt","BUY P/L  Amount :  " + DoubleToStr(total_xp,2) , text_size, "Cambria", clrWhite); 
   ObjectSet( "buyt", OBJPROP_CORNER, text_corner); 
 
   } else {ObjectDelete("Tp");  ObjectDelete("SL"); ObjectDelete("buy");    ObjectDelete("buyt");  ObjectDelete("buyt2");}
   
   }
   
   string_window( "EA_NAME", 5, 5, 0); 
   ObjectSetText( "EA_NAME",EA_NAME , text_size+3, "Impact", clrSkyBlue);   
   ObjectSet( "EA_NAME", OBJPROP_CORNER, 3); 
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM   
   return(0);
  }
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
void CleanUp()
{
   ObjectDelete("ACB"); ObjectDelete("ACN");  
   ObjectDelete("CloseButton");
   ObjectDelete("SellButton");
   ObjectDelete("BuyButton"); 
   ObjectDelete("Lot");  
   ObjectDelete("LOT INPUT"); 
   ObjectDelete("TP");  
   ObjectDelete("TP INPUT"); 
   ObjectDelete("SL");  
   ObjectDelete("SL INPUT"); 
   ObjectDelete("BTNP_"); 
   ObjectDelete("EA_NAME");  
   ObjectDelete("expiredlabel");  
   ObjectDelete("expiredlabel");  
   ObjectDelete("Contact_Me");
   ObjectDelete("Key_Word2");
   ObjectDelete("Key_Word1"); 
   ObjectDelete("EA Trial"); 
   ObjectDelete("EA Trial2");
   ObjectDelete("DB_");
   ObjectDelete("SettingLot");
   ObjectDelete("Diff");
   ObjectDelete("CloseButtonY");
   ObjectDelete("Spread");
   ObjectDelete("Leverage");
   ObjectDelete("Equity");
   ObjectDelete("Balance");
   ObjectDelete("Price"); 
   ObjectDelete("Profit");
   ObjectDelete("Trade_Mode");
   ObjectDelete("Lot");
   ObjectDelete("EnterLot"); 
   ObjectDelete("Spread");
   ObjectDelete("EA Expired"); 
   ObjectDelete("Range"); 
   ObjectDelete("hari");
   ObjectDelete("Email");
   ObjectDelete("Mobile");
    ObjectDelete("sell"); ObjectDelete("sellt");
   ObjectDelete("Tps");
   ObjectDelete("SLs");
   ObjectDelete("SL");
   ObjectDelete("Tp");
   ObjectDelete("buy"); ObjectDelete("buyt");
   ObjectDelete("BEP_XXX");
   ObjectDelete("BEP_XXX2");
   ObjectDelete("Check_Info");
   ObjectDelete("Diff_B");ObjectDelete("Total_Profit_X");
   ObjectDelete("Diff_S");   ObjectDelete("Total_Profit_Y");
   ObjectDelete("DemoAccount");    ObjectDelete("Contact_Person"); 
   ObjectDelete("DemoAccount2");  ObjectDelete("CO_Ordersall"); 
   ObjectDelete("Line1");  ObjectDelete("Line11");  
   ObjectDelete("buyt2");  ObjectDelete("sellt2"); 
   ObjectDelete(PACKAGE_INFO_LABEL); // Delete the package info label    

}
//---------------------------------------------------------------------||
//---------------------------------------------------------------------||
int string_window( string n, int xoff, int yoff, int WindowToUse )
   {
   ObjectCreate( n, OBJ_LABEL, WindowToUse, 0, 0 );
   ObjectSet( n, OBJPROP_CORNER, 1 );
   ObjectSet( n, OBJPROP_XDISTANCE, xoff );
   ObjectSet( n, OBJPROP_YDISTANCE, yoff );
   ObjectSet( n, OBJPROP_BACK, true );
   return (0);
   }
//---------------------------------------------------------------------||

 //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM 
double Start_Lot,Lots,MinLot,MaxLot; 
 
 double AutoLot()
 {
  if (Autolot==false)
  {
  Lots=Initial_Lot;
  if ( Lots<MinLot) Lots=MinLot;
  if ( Lots>MaxLot) Lots=MaxLot;
  }
  
 if (Autolot==true)
  {
  Lots=// NormalizeDouble(Initial_Lot*(AutoMM/100),Lot_Digits);
  NormalizeDouble(MathFloor(AccountBalance()/AutoMM)*MinLot,Lot_Digits); 
  
  if ( Lots<MinLot) Lots=MinLot;
  if ( Lots>MaxLot) Lots=MaxLot;
  if (Lots > NormalizeDouble(AccountFreeMargin()/MarketInfo(NULL,MODE_MARGINREQUIRED),Lot_Digits)) 
  Lots=NormalizeDouble(MinLot,Lot_Digits);
  }   
  
 
return(Lots);
}
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
 bool Filter_Trial()
  {
if(Filter_Time_For_Trial )
     { if (TimeCurrent()>=StrToTime(Trial_Time)  )      
     {return true; }    
      else {return false;}
     }  
   return true;
  }   
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

 bool MaxLotX()
  {
if(FilterMaximumLot )
     {      
     if ( LMB<MaximumLot)
      return true; else return false;
     }  
   return true;
  } 
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||  
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
  bool MaxLotY()
  {       
  if(FilterMaximumLot)
     {
      if ( LMS<MaximumLot)
       return true;  else return false;
     }  
   return true;
  }   
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||




//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

 bool X_Distance()
  {
if(MinimumDistance )
     {      
     if ( Ask <=Buy_Price-GridStepX*pip *Point)
      return true; else return false;
     }  
   return true;
  } 
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||  
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
  bool Y_Distance()
  {       
  if(MinimumDistance)
     {
       if ( Bid >=Sell_Price+GridStepY*pip *Point)
       return true;  else return false;
     }  
   return true;
  }   
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
 
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 

 bool MaxSpread()
  {
if(Filter_MaxSpread )
     {     
     if ( MarketInfo(NULL,MODE_SPREAD)<=Max_Spread*pip)
     {return true; }   else {return false; }
     }  
   return true;
  }   
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 



//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 
datetime TimeX,TimeY;

 bool XTradePerBar()
  {
if(OneTradePerBar )
     {     
     if (Time[0]-TimeX>0 )
     {return true; }   else {return false; }
     }  
   return true;
  }   
  
 bool YTradePerBar()
  {
if(OneTradePerBar )
     {     
     if (Time[0]-TimeY>0)
     {return true; }   else {return false; }
     }  
   return true;
  }     
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 






//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 
 bool XSignal()
  {
if(SignalFilter )
     {     
     if (SendBUY=="UP" &&Time[0]-TimeX>0)
     {return true; }   else {return false; }
     }  
   return true;
  }   
  
 bool YSignal()
  {
if(SignalFilter )
     {     
     if ( SendSELL=="DN" && Time[0]-TimeY>0)
     {return true; }   else {return false; }
     }  
   return true;
  }     
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 


//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 

 bool DemoON()
  {
if( DemoAccount_Only==true)
     {     
     if (CO_Orders> MaxCloseTrades)
     {return false; }   else {return true; }
     }  
   return true;
  } 
      
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 

//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 

 bool MAX_DD()
  {
if(MAX_DrawDawn )
     {     
     if ( DDall<-MaxDD_StopMartingale )
     {return false; }   else {return true; }
     }  
   return true;
  }     
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 


//+------------------------------------------------------------------+
//| Get Indicator Buffer Value                                       |
//+------------------------------------------------------------------+
int shift=1;
double GetIndicatorValue(int buffer)
{

    return ( iCustom (
     
                              NULL,                                                                
                              0,                                     
                              "Entry1", //File Path of indicator 
                                                       
                              //NEXT LINES WILL BE INDCATOR INPUTS                                  
                              " ",
                              period,
                              target,
                              MaximumBars,                               
                              //END FOR INPUTS
                                                              
                              buffer,//Index Buffer                               
                              shift                                  
                              
                       ));

}  
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM|| 
double plall,DDall;


datetime Local_Time ,Server_Time;
string Time_Local ,Time_Serv; 
 //KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 
bool Filter_TIme()
  {
if(Filter_TradingTime )
     {
     if ( (Time_Serv>=Time_Start && Time_Serv<=Time_End ) )
     {return true; }    else {return false;}
     }  
   return true;
  }
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

 //KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 
bool Filter_TImeFriday()
  {
if(Filter_TradingTime2 )
     {
     if ( (Time_Serv>Time_StopFriday && DayOfWeek()==5) )
     {return false; }    else {return true;}
     }  
   return true;
  }
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 

//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 
enum CandleCheck 
  {
   CurrentBar=0,//CurrentBar 
   CloseBar=1,//Close Bar
   };    
 CandleCheck CandleBase=1;// Bar Use For Entry

/*
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX||
input string ABC="------------------------------------------------------------";//::
input string MA1="-----------<Fast MA Parameters>-----------";//::-------------------------::
input int FMA =15;//Fast MA Periode
input ENUM_MA_METHOD FMA_Type=1;//Fast MA Type
input ENUM_APPLIED_PRICE FMA_Price=0; //Apply To
input string MA2="-----------<SLOW MA Parameters>-----------";//::-------------------------::
input int SlowMA =30;//Slow MA Periode
input ENUM_MA_METHOD SlowMA_Type=1;//Slow MA Type
input ENUM_APPLIED_PRICE SlowMA_Price=0; //Apply To
double C_FMA,P_FMA,C_SMA,P_SMA;
input string BB="-----------<BBTrend Parameters>-----------";//::-------------------------::
input int Lenght=20; 
input int Deviation=2;
input double MoneyRisk=1.0;
input int Signal=1;
input int Lines=1;//Line
input int nBars=1000;
*/



string MACDBUY,MACDSELL;
 string MACD="-----------< MACD Parameters >-----------";//::-------------------------::
 int Fast_EMA=12; 
 int Slow_EMA=26;
 int MACD_SMA=9;
 ENUM_APPLIED_PRICE MACD_Price=0;
double C_MACD,P_MACD,C_SMACD,P_SMACD;


string BBBUY,BBSELL;


//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK|| 
double Buy_Price,Sell_Price; 
double TPB_ALL,TPS_ALL;
double y_bep,x_bep;
 
double RANGE;;
double tt_p, tt_lot, avg_p,coun_sl;
string SendBUY,SendSELL;
double buffer1,buffer2;
 double COPLWH,COPLWC;
 double WeeklyPL;
 string ExitBUY,ExitSell;
 
 
 double C_HA1, C_HA2 ,P_HA1,P_HA2;
 
 
 
 
 
 //+------------------------------------------------------------------+
//Total of ALL orders place by this expert.
//+------------------------------------------------------------------+
int TotalOpenOrders()
  {
   int total=0;
   for( j=OrdersTotal()-1; j>=0; j--)
     {
      if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES)){
         if(OrderMagicNumber()==Magic_Number)
            total++;
      }      
      else Print(__FUNCTION__,"Failed to select order ",GetLastError());
     }
   return (total);
  }
//+------------------------------------------------------------------+
//Total of all SELL orders place by this expert.
//+------------------------------------------------------------------+
int TotalOpenSellOrders()
  {
   int total=0;
   for( j=OrdersTotal()-j; j>=0; j--)
     {
      if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderMagicNumber()==Magic_Number)
            if(OrderType()==OP_SELL)
               total++;
        }
      else Print(__FUNCTION__,"Failed to select order ",j," ",GetLastError());
     }
   return (total);
  }
//+------------------------------------------------------------------+
//Total of all BUY orders place by this expert.
//+------------------------------------------------------------------+
int TotalOpenBuyOrders()
  {
   double total=0;
   for( j=OrdersTotal()-1; j>=0; j--)
     {
      if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderMagicNumber()==Magic_Number)
            if(OrderType()==OP_BUY)
               total++;
        }
      else Print(__FUNCTION__,"Failed to select order",GetLastError());
     }
   return (total);
  }
//+------------------------------------------------------------------+
//Total of all SELL lots place by this expert.
//+------------------------------------------------------------------+
double TotalOpenSellLots()
  {
 double total=0;
  //for( i=OrdersTotal()-1; i>=0; i--)
  for( j=0; j<OrdersTotal(); j++) 
    
     {
      if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderMagicNumber()==Magic_Number)
            if(OrderType()==OP_SELL)
              total=OrderLots();
        }
      else Print(__FUNCTION__,"Failed to select order ",j," ",GetLastError());
     }
   return (total);
  }
//+------------------------------------------------------------------+
//Total of all BUY lots place by this expert.
//+------------------------------------------------------------------+
double TotalOpenBuyLots()
  {
  double total=0;
   //for( i=OrdersTotal()-1; i>=0; i--)
   for( j=0; j<OrdersTotal(); j++)  
     {
      if(OrderSelect(j,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderMagicNumber()==Magic_Number)
            if(OrderType()==OP_BUY)
               total=OrderLots();
        }
      else Print(__FUNCTION__,"Failed to select order",GetLastError());
     }
   return (total);
  }
//+------------------------------------------------------------------+
//| find the price of the highest sell that is open                  |
//+------------------------------------------------------------------+
double HighestSellPosition()
  {
   double HighestOpenPrice=0.0;
   for( cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderMagicNumber()==Magic_Number)
            if(OrderType()==OP_SELL)
               if(OrderOpenPrice()>HighestOpenPrice)
                  HighestOpenPrice=OrderOpenPrice();
     }
   return(HighestOpenPrice);
  }
//+------------------------------------------------------------------+
//| find the price of the lowest buy that's open.                    |
//+------------------------------------------------------------------+

double LowestBuyPosition()
  {
   double LowestOpenPrice=0.0;
   for( cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)){
         if(OrderMagicNumber()==Magic_Number){
            if(OrderType()==OP_BUY){
               if(LowestOpenPrice==0.0)
                  LowestOpenPrice=OrderOpenPrice();
               else if(OrderOpenPrice()<LowestOpenPrice)
               LowestOpenPrice=OrderOpenPrice();
            }//if buy
         }//if magic
      }//if orderselect
     }//for loop
   return(LowestOpenPrice);
  }
//+------------------------------------------------------------------+
//| Calculates Breakeven of Open Sell Orders.                                                                  |
//+------------------------------------------------------------------+
double BreakevenOfSells()
  {
   double TotalLots=0,
   price= 0,
   lots =0,
   pricetimeslots=0,
   Total=0,
   TotalPriceTimesLots=0;
   for( cnt=0;cnt<OrdersTotal();cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)){
         if(OrderMagicNumber()==Magic_Number){
            if(OrderType()==OP_SELL)
              {
               price= OrderOpenPrice();
               lots = OrderLots();
               pricetimeslots=price*lots;
               TotalLots+=lots;
               TotalPriceTimesLots+=pricetimeslots;
              }//if sell
      }//if magic
      }//if orderselect
     }// for loop
   if(TotalLots)//if total is NOT zero.. 
      Total=TotalPriceTimesLots/TotalLots;
   return(Total);
  }
//+------------------------------------------------------------------+
//| Calculates Breakeven of Open Buy Orders.                                                                  |
//+------------------------------------------------------------------+
double BreakevenOfBuys()
  {
   double TotalLots=0,
   price= 0,
   lots =0,
   pricetimeslots=0,
   Total=0,
   TotalPriceTimesLots=0;
   for( cnt=0;cnt<OrdersTotal();cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)){
         if(OrderMagicNumber()==Magic_Number){
            if(OrderType()==OP_BUY)
              {
               price= OrderOpenPrice();
               lots = OrderLots();
               pricetimeslots=price*lots;
               TotalLots+=lots;
               TotalPriceTimesLots+=pricetimeslots;
              }//if buy
        }//if magic
      }//if orderselect
     }//for loop
   if(TotalLots)
      Total=TotalPriceTimesLots/TotalLots;
   return(Total);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CalculatedLotSize(int type)
  {
   double lotsize=0;
   int tradeNumber=0;
   if(type==OP_SELL)
      tradeNumber=TotalOpenSellOrders()+1;
   else if(type==OP_BUY)
      tradeNumber=TotalOpenBuyOrders()+1;

   switch(tradeNumber)
     {
      case 1: lotsize = LS1;break;
      case 2: lotsize = LS2;break;
      case 3: lotsize = LS3;break;
      case 4: lotsize = LS4;break;
      case 5: lotsize = LS5;break;
      case 6: lotsize = LS6;break;
      case 7: lotsize = LS7;break;
      case 8: lotsize = LS8;break;
      case 9: lotsize = LS9;break;
      case 10: lotsize = LS10;break;
      case 11: lotsize = LS11;break;
      case 12: lotsize = LS12;break;
      case 13: lotsize = LS13;break;
      case 14: lotsize = LS14;break;
      case 15: lotsize = LS15;break;
      case 16: lotsize = LS16;break;
      case 17: lotsize = LS17;break;
      case 18: lotsize = LS18;break;
      case 19: lotsize = LS19;break;
      case 20: lotsize = LS20;break;
      default:lotsize=LS1;
     }
   return(lotsize);
  }
//+------------------------------------------------------------------+

int j;
//int i;

double LS2 = 0.02;//Lotsize of Trade 2.
double LS3 = 0.03;//Lotsize of Trade 3.
double LS4 = 0.04;//Lotsize of Trade 4.
double LS5 = 0.05;//Lotsize of Trade 5.
double LS6 = 0.06;//Lotsize of Trade 6.
double LS7 = 0.07;//Lotsize of Trade 7.
double LS8 = 0.08;//Lotsize of Trade 8.
double LS9 = 0.09;//Lotsize of Trade 9.
double LS10 = 0.10;//Lotsize of Trade 10.
double LS11 = 0.11;//Lotsize of Trade 11.
double LS12 = 0.12;//Lotsize of Trade 12.
double LS13 = 0.13;//Lotsize of Trade 13.
double LS14 = 0.14;//Lotsize of Trade 14.
double LS15 = 0.15;//Lotsize of Trade 15.
double LS16 = 0.16;//Lotsize of Trade 16.
double LS17 = 0.17;//Lotsize of Trade 17.
double LS18 = 0.18;//Lotsize of Trade 18.
double LS19 = 0.19;//Lotsize of Trade 19.
double LS20 = 0.20;//Lotsize of Trade 20.


//--------------------

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{

//= Authorization =========================================+
  ChartEventA(id,sparam);                                //|
//=========================================================+
}
//+------------------------------------------------------------------+
