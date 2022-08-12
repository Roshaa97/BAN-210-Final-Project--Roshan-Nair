*------------------------------------------------------------*;
* Neural: Create decision matrix;
*------------------------------------------------------------*;
data WORK.mpg(label="mpg");
  length   mpg                                  8
           ;

 mpg=10;
output;
 mpg=46.6;
output;
 mpg=23.5238993710691;
output;
;
run;
proc datasets lib=work nolist;
modify mpg(type=PROFIT label=mpg);
run;
quit;
data EM_Neural;
set EMWS2.Varsel_TRAIN(keep=
G_horsepower PWR_displacement SQRT_weight acceleration model mpg origin);
run;
*------------------------------------------------------------* ;
* Neural: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    G_horsepower(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    PWR_displacement SQRT_weight acceleration model mpg origin
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural
dmdbcat=WORK.Neural_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
mpg
;
run;
quit;
*------------------------------------------------------------* ;
* Neural: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    PWR_displacement SQRT_weight acceleration model origin
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    G_horsepower
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural dmdbcat=WORK.Neural_DMDB
validdata = EMWS2.Varsel_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %NOMINPUTS / level=nominal id=nom
;
target
mpg
/ level=interval id=intervalTargets
bias
;
arch MLP
Hidden=5
direct
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS2.Neural_PRELIM_OUTEST
;
save network=EMWS2.Neural_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS2.Neural_outest estiter=1
Outfit=EMWS2.Neural_OUTFIT
;
run;
quit;
proc sort data=EMWS2.Neural_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS2.Neural_INITIAL;
set EMWS2.Neural_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural dmdbcat=WORK.Neural_DMDB
validdata = EMWS2.Varsel_VALIDATE
network = EMWS2.Neural_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS2.Neural_INITIAL;
train tech=NONE;
code file="C:\Users\AutoLogon\Desktop\Roshan Seneca\SEM 2\ROSHAN SEM 2\BAN 210\Final Project\Final Project-Roshan Nair\Workspaces\EMWS2\Neural\SCORECODE.sas"
group=Neural
;
;
code file="C:\Users\AutoLogon\Desktop\Roshan Seneca\SEM 2\ROSHAN SEM 2\BAN 210\Final Project\Final Project-Roshan Nair\Workspaces\EMWS2\Neural\RESIDUALSCORECODE.sas"
group=Neural
residual
;
;
score data=EMWS2.Varsel_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS2.Neural_OUTKEY;
score data=EMWS2.Varsel_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS2.Neural_OUTKEY;
run;
quit;
data EMWS2.Neural_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS2.Neural_EMESTIMATE;
set EMWS2.Neural_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural;
run;
quit;
