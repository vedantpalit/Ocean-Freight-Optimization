/*********************************************
 * OPL 12.5 Model
 * Author: QEDM
 * Creation Date: Apr 5, 2023 at 10:07:32 AM
 *********************************************/
int Q= ...;
int num_ships=...;
int num_locations=...;
int serv_time=...;
range locations=1..num_locations+1;
range loc=1..num_locations;
range ships=1..num_ships;
float dist_matrix[locations][locations]=...;
int demand[locations]=...;
int et[locations]=...;
int st[locations]=...;
int lt[locations]=...;
int M=10000;
dvar boolean x[locations][locations];
dvar int+ y[locations];
dvar int+ z[locations];

minimize sum(i,j in locations)x[i][j]*dist_matrix[i][j];

subject to{
  forall(i in loc)sum(j in locations) x[i+1][j]==1;
  forall(j in loc)sum(i in locations) x[i][j+1]==1;
  
  sum(j in locations)x[1][j]==num_ships;
  sum(i in locations)x[i][1]==num_ships;
  
  forall(j in loc)y[j+1]<=Q;
  forall(j in loc)y[j+1]>=demand[j+1];
  forall(i,j in loc)y[j+1]>=(y[i+1]+demand[j+1]*x[i+1][j+1]-Q*(1-x[i+1][j+1]));
  
  forall(j in loc)z[j+1]<=(lt[j+1]-serv_time)*60;
  forall(j in loc)z[j+1]>=(et[j+1]-serv_time)*60;
  forall(i,j in loc)z[j+1]>=(z[i+1]+(st[i+1]+(dist_matrix[i+1,j+1]/100))*x[i+1][j+1]-M*(1-x[i+1][j+1]));
} 
execute{ 
writeln(" x = " ,"\n");
writeln(x);
writeln(" y = " ,"\n")
writeln(y);
writeln(" z = " ,"\n")
writeln(z);}

   
