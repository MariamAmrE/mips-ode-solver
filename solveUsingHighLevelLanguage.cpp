#include <iostream>
#include <math.h>

using namespace std;


/*void solve_ODE_numerically_using_Euler (long long y0 , long long h , long long n ){


       long long y = y0 , yDash;
       long long i ;
       for( i=0; i<n ; i++){
                       yDash = 1 - i*h + 4*y;
                       y = y + h*(yDash);
                       cout<<i<<"       "<<i*h<<"       "<<y<<endl;
                      }

       cout<<"y("<<i*h<<")  =  "<<y;
}


long long main()
{
    long long n;
    long long y0 , h;
    cout<<"y(0) = ";
    cin>> y0;
    cout<<"h = ";
    cin>>h;
    cout<<"number of steps = ";
    cin>>n;
    solve_ODE_numerically_using_Euler( y0 , h , n);
    return 0;
}*/

//==============================================
///////////////////////

///////////////////////
/*long long power (long long x , long long power){

    long long x_times_x = 0;

    for(long long i = 1 ; i <= x ; i++){

      x_times_x += x;

    }

    if(power == 3){ return mul(x_times_x , x);}


    return x_times_x;

}*/
///////////////////////=========================================
/*long long mul (long long x , long long n){

    long long x_times_n = 0;
    if (n>=0){
            for(long long i = 0; i<n ; i++){
                   x_times_n += x;
                                            }
            return x_times_n;
            }

    else    {
            for(long long i = 0; i< -n ; i++){
                   x_times_n += x;
                                              }
            return -x_times_n;
            }


}*/
///////////////////////=========================================
//Multiplying using shift
int mul (int x , int n){
int diff, result , flag = 0;
if(n == 0 || x == 0) return 0;
if(n < 0) {n=-n;   flag = 1;}
for(int i = 0; i <= 31 ; i++){

if(n >= pow(2,i))
{
    diff = n - pow(2,i);
    result = x*pow(2,i);
    i = 32;
    for(int j = 0; j<diff ; j++){result += x;}
    if (flag == 1){result  = -result;}

}

}

return result;



}





/////////////////////============================================
//The function I'm writing in MIPs Assembly :(

/*long long solve_ODE_numerically_using_Euler (long long y0 , long long h , long long n ){


       long long y = y0 , yDash , x;

       for( long long i=0; i<n ; i++){
                       x = mul(i , h);

                       yDash = mul(157  , mul(x ,x) ) - mul(x , 78) + mul(408, mul(y , mul(y , y)) ) - mul(34 , mul(y,y) ) - mul(28 ,y) - 16;

                       y = y + mul(h, yDash);
                      }

       return y;
}*/
////////////////////////
int main(){

/*long long y0 , h , n;
cin>>y0>>h>>n;
cout<<solve_ODE_numerically_using_Euler(y0 , h , n);*/

cout<<mul(20, -44);

return 0;
}
