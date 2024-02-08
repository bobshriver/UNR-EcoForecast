


## DD population model lab##

The difference equation for logistic growth is:

$N_{t+1} = N_t + rN_t(1 - N_t / K)$	 

First, open R, then go to File>New script. This is where we will code the script. (Try not to look at my example code below until you get totally stuck!) Your script will need to contain the following steps:

1. Assign values to "r" and "K" 

2. Create a "Time" vector (hint: use the `seq()` function). To make sure this worked, you can copy and paste from the script editor into the R command line, or you can select the line, and go to Edit>Run line or selection.

3. Create an "N" vector using rep(). I recommend filling it with zeros or NAs. To assign an initial value to `N` at time 1, use `N[1] =` .

4. (Optional) Create a logistic growth function (use `function()`). This will probably be the trickiest 	part of  the program. Refer back the section in the first tutorial on creating functions, or ask me for help.

5. Set up a `for()` loop to step through time. Remember, to reference a particular value in the N vector, you use `N[1]`, or `N[2]`, or (hint!) `N[i-1]` where i might be the loop index. You will "call" your logistic growth 	function within this loop.

6. Graph the results using `plot()`.

When you are done, *submit your finished script to Bob on webcampus*. Please submit 
it as a .R or .txt file (not Word or pdf).

### Other online resources ###

* The official R manuals are found under the Help menu of the user interface.

### If you get stuck.... ###

My script for logistic growth:

```R
# assign parameters
r = 1.02
K = 500
initialN = 2

# initialize Time and N vectors
Time = seq(1:200)
N = rep(NA,length(Time))
N[1] = initialN

#  the logistic growth function
growth = function(r,K,N){
	updatedN = N +r*N*(1-N/K)
	return(updatedN)
}

# the main loop (notice I start the loop at 2, 
# since N[1] is already assigned the initial value)
for(t in 2:length(Time)){
	N[t] = growth(r=r,K=K,N=N[t-1])
}

plot(Time,N,type="l")


```
