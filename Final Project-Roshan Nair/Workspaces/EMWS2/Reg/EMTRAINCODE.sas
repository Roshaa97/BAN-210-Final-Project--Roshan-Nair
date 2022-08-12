*------------------------------------------------------------*;
* Reg: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS2.Trans_TRAIN(keep=
PWR_displacement SQRT_cylinders SQRT_weight acceleration car_name horsepower
model mpg origin);
run;
*------------------------------------------------------------* ;
* Reg: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    car_name(ASC) horsepower(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    PWR_displacement SQRT_cylinders SQRT_weight acceleration model mpg origin
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
mpg
;
run;
quit;
*------------------------------------------------------------*;
* Reg: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg_DMDB
validata = EMWS2.Trans_VALIDATE
outest = EMWS2.Reg_EMESTIMATE
outterms = EMWS2.Reg_OUTTERMS
outmap= EMWS2.Reg_MAPDS namelen=200
;
class
car_name
horsepower
;
model mpg =
PWR_displacement
SQRT_cylinders
SQRT_weight
acceleration
car_name
horsepower
model
origin
PWR_displacement*PWR_displacement
PWR_displacement*SQRT_cylinders
PWR_displacement*SQRT_weight
PWR_displacement*acceleration
PWR_displacement*model
PWR_displacement*origin
SQRT_cylinders*SQRT_cylinders
SQRT_cylinders*SQRT_weight
SQRT_cylinders*acceleration
SQRT_cylinders*model
SQRT_cylinders*origin
SQRT_weight*SQRT_weight
SQRT_weight*acceleration
SQRT_weight*model
SQRT_weight*origin
acceleration*acceleration
acceleration*model
acceleration*origin
model*model
model*origin
origin*origin
/error=normal
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=VERROR
Hierarchy=CLASS
Rule=NONE
SlEntry=1
SlStay=0.5
Start=0
Stop=0
include=0
MaxStep=30
;
;
code file="C:\Users\AutoLogon\Desktop\Roshan Seneca\SEM 2\ROSHAN SEM 2\BAN 210\Final Project\Final Project-Roshan Nair\Workspaces\EMWS2\Reg\EMPUBLISHSCORE.sas"
group=Reg
;
code file="C:\Users\AutoLogon\Desktop\Roshan Seneca\SEM 2\ROSHAN SEM 2\BAN 210\Final Project\Final Project-Roshan Nair\Workspaces\EMWS2\Reg\EMFLOWSCORE.sas"
group=Reg
residual
;
run;
quit;
