*------------------------------------------------------------* ;
* EM: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    horsepower(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* EM: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    PWR_displacement SQRT_cylinders SQRT_weight acceleration model mpg origin
%mend DMDBVar;
*------------------------------------------------------------*;
* EM: Create DMDB;
*------------------------------------------------------------*;
libname _spdslib SPDE "C:\Users\AutoLogon\AppData\Local\Temp\SAS Temporary Files\_TD4632_NHLOAN-L-B0BD_\Prc2";
proc dmdb batch data=EMWS2.Impt_TRAIN
dmdbcat=WORK.EM_DMDB
maxlevel = 101
out=_spdslib.EM_DMDB
;
class %DMDBClass;
var %DMDBVar;
target
mpg
;
run;
quit;
*------------------------------------------------------------* ;
* Varsel: Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INPUTS;
               PWR_DISPLACEMENT SQRT_CYLINDERS SQRT_WEIGHT ACCELERATION HORSEPOWER MODEL
   origin
%mend INPUTS;
proc dmine data=_spdslib.EM_DMDB dmdbcat=WORK.EM_DMDB
minr2=0.005 maxrows=3000 stopr2=0.0005 NOAOV16 NOINTER USEGROUPS OUTGROUP=EMWS2.Varsel_OUTGROUP outest=EMWS2.Varsel_OUTESTDMINE outeffect=EMWS2.Varsel_OUTEFFECT outrsquare =EMWS2.Varsel_OUTRSQUARE
NOMONITOR
PSHORT
;
var %INPUTS;
target mpg;
code file="C:\Users\AutoLogon\Desktop\Roshan Seneca\SEM 2\ROSHAN SEM 2\BAN 210\Final Project\Final Project-Roshan Nair\Workspaces\EMWS2\Varsel\EMFLOWSCORE.sas";
code file="C:\Users\AutoLogon\Desktop\Roshan Seneca\SEM 2\ROSHAN SEM 2\BAN 210\Final Project\Final Project-Roshan Nair\Workspaces\EMWS2\Varsel\EMPUBLISHSCORE.sas";
run;
quit;
/*      proc print data =EMWS2.Varsel_OUTEFFECT;      proc print data =EMWS2.Varsel_OUTRSQUARE;      */
run;
