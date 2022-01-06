---
title: "Introduction to R"
output:
  html_document: default
layout: post
---

### Tutorials ###

First, if you are completely new to R, download this tutorial and work through the exercises:
(http://www.nceas.ucsb.edu/files/scicomp/Dloads/RProgramming/BestFirstRTutorial.pdf)

### Logistic growth exercise ###

The difference equation for logistic growth is:

$N_{t+1} = N_t + rN_t(1 - N_t / K)$	 

Let's first set this up in a spreadsheet. Label column 1 "Parameters," and type "r" and then  "K" into the first two cells of column 1, respectively. Label column 2 "Values" and assign a value for r between 0 and 0.5, and any value of K you want. Label column 3 "Time" and fill in a series from 1:100 down the column.  

Label column 4 "N." Enter "2" in the first cell, but leave the rest blank. In the second cell of this column, you will enter the formula above. "r" and "K" will refer to the values you entered in column 2; make sure you use the $ sign to fix the cell address.  Nt should refer to the cell above (cell 1 of column 4 in this case). Once the formula is entered, and you have checked that it works, copy and paste it down the column, as far as your "Time" variable extends. Do the numbers make sense? How about when you change r or K?

Now we will do the same exercise in R. First, open R, then go to File>New script. This is where we will code the script. (Try not to look at my example code below until you get totally stuck!) Your script will need to contain the following steps:

1. Assign values to "r" and "K" (hint: all you will need is the "=" sign)

2. Create a "Time" vector, just as we did on the spreadsheet (hint: use the `seq()` function). To make sure this worked, you can copy and paste from the script editor into the R command line, or you can select the line, and go to Edit>Run line or selection.

3. Create an "N" vector using rep(). I recommend filling it with zeros or NAs. To assign an initial value to `N` at time 1, use `N[1] =` .

4. (Optional) Create a logistic growth function (use `function()`). This will probably be the trickiest 	part of  the program. Refer back the section in the first tutorial on creating functions, or ask me for help.

5. Set up a `for()` loop to step through time, just as we stepped down the Time column on the	spreadsheet. Remember, to reference a particular value in the N vector, you use `N[1]`, or `N[2]`, or (hint!) `N[i-1]` where i might be the loop index. You will "call" your logistic growth 	function within this loop.

6. Graph the results using `plot()`.

When you are done, *submit your finished script on Canvas*. Please submit 
it as a .R or .txt file (not Word or pdf).

### Other online resources ###

* A cheat-sheet of R functions I put together: (http://www.nceas.ucsb.edu/files/scicomp/Dloads/RCourse/PeterAdlerRCheatSheet.pdf)

* A more in-depth tutorial: (http://www.nceas.ucsb.edu/files/scicomp/Dloads/RProgramming/RForBeginners.pdf)

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
for(i in 2:length(Time)){
	N[i] = growth(r=r,K=K,N=N[i-1])
}

plot(Time,N,type="l")

```
