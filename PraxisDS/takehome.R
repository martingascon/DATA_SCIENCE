 run <-function(){  
setwd('~/Dropbox/Personal/DS/PraxisDS/')                        # define directory
options(digits=4)
div <-"*******************************************************\n"
x = read.csv("takehome.csv",head=TRUE)                            # read the file
print(paste0("Number of rows: ",nr<-nrow(x) ))                    # number of rows
########################################################## table functions ########################################################
table<-function(a,b,c,d){
  t<-(a+b+c+d)/100
  ab<-a+b;   cd<-c+d;  ac<-a+c;  bd<-b+d;
  mat <- matrix(c(a,a/t,b,b/t,ab,ab/t,c,c/t,d,d/t,cd,cd/t,ac,ac/t,bd,bd/t,t*100,t/t*100), nrow = 3, ncol = 6, 
                byrow = TRUE, dimnames = list(c("control","treatment","cont+treat"),
                                              c(" old_page","/in perc.", " new_page","/in perc.", "  total   ","/in perc.")))
  print(mat)
}

table_perc<-function(a,b,c,d,e,f,g,h){
  ab<-a+b; cd<-c+d; ac<-a+c; bd<-b+d; ef<-e+f; gh<-g+h;  eg<-e+g;  fh<-f+h;
  mat <- matrix(c(a/ab*100,c/cd*100, ac/(ab+cd)*100,e/ef*100,g/gh*100,eg/(ef+gh)*100,(a+e)/(ab+ef)*100,(c+g)/(cd+gh)*100,100), nrow = 3, ncol = 3, 
                byrow = TRUE, dimnames = list(c("control","treatment", "cont+treat"),
                                              c(" old_page", "  new_page   ","  total   ")))
  print(mat)
}

######## Define a few variables to simplify the code #####################################################################################

c<-'control';  t<-'treatment'; o<-'old_page'; n<-'new_page';
xid<-x$user_id; xts<-x$ts; xab<-x$ab; xlp<-x$landing_page; 
cat(sprintf(div))

################################################################################## create subsets 
co <-subset(x,xab==c & xlp==o)   ## 90815    
cn <-subset(x,xab==c & xlp==n)   ## 0       
to <-subset(x,xab==t & xlp==o)   ## 4759
tn <-subset(x,xab==t & xlp==n)   ## 95574

print("Table 1: Cases and percetages of total")
table(nrow(co),nrow(cn),nrow(to),nrow(tn))
cat(sprintf(div))

print('Conclusion: Effectively 50% goes to Old page and 50% goes to new Page.')
print('Note that there are some treatment cases going to old page.')
cat(sprintf(div))
############################################################################ calculate percentages without considering the user_id or timestamp
xco<-co$converted; xcn<-cn$converted;xto<-to$converted;xtn<-tn$converted;
co1 <-subset(co, xco == 1)       
co0 <-subset(co, xco == 0)   
cn1 <-subset(cn, xcn == 1)       
cn0 <-subset(cn, xcn == 0)  
to1 <-subset(to, xto == 1)
to0 <-subset(to, xto == 0)     
tn1 <-subset(tn, xtn == 1)     
tn0 <-subset(tn, xtn == 0)   

print("Table 2: Completion Rates in percetages")
table_perc(nrow(co1),nrow(co0),nrow(cn1),nrow(cn0),nrow(to1),nrow(to0),nrow(tn1),nrow(tn0))

cat(sprintf(div))

print('Conclusion: Completion Rate in the old page is 10.08%  while in the new page is 10.14%')
print('Which means there is a lift of only 0.6%.')
cat(sprintf(div))

############################################################################ calculate percentages removing duplicated users
print('If we want to consider only independent cases, we have to eleminate duplicated users')
y<-subset(x,!duplicated(x$user_id))
print(paste0("Duplicated users: ",nr-nrow(y)))

## calculate percentages after removing duplicated users 
yid<-y$user_id; yts<-y$ts; yab<-y$ab; ylp<-y$landing_page; 

# create subsets 
co <-subset(y,yab==c & ylp==o)   ## 90811   (4 missing)
cn <-subset(y,yab==c & ylp==n)   ## 0       
to <-subset(y,yab==t & ylp==o)   #  0       (all of them were repetead)
tn <-subset(y,yab==t & ylp==n)   ## 95573  ( 1 missing)

print("Table 3: Cases and percetages of total (no duplicates)")
table(nrow(co),nrow(cn),nrow(to),nrow(tn))
cat(sprintf(div))

## calculate percentages (no duplicates)
yco<-co$converted; ycn<-cn$converted;yto<-to$converted;ytn<-tn$converted;
co1 <-subset(co, yco == 1)       
co0 <-subset(co, yco == 0)   
cn1 <-subset(cn, ycn == 1)       
cn0 <-subset(cn, ycn == 0)  
to1 <-subset(to, yto == 1)
to0 <-subset(to, yto == 0)     
tn1 <-subset(tn, ytn == 1)     
tn0 <-subset(tn, ytn == 0)   

print("Table 4: Completion Rates in percetages (no duplicates)")
table_perc(nrow(co1),nrow(co0),nrow(cn1),nrow(cn0),nrow(to1),nrow(to0),nrow(tn1),nrow(tn0))


print('Conclusion: Completion Rate in the old page is 10.04%  while in the new page is 10.14%')
print('Which means there is a lift of  1.001%, which explains why the experiment is stopped.')

# T-test looks a the differences between two groups on some variable of interest (converted)
# We want to perform a two sample t-test for comparing treatment and control groups.
# mu1 = mean(treatment), mu2 = mean(control)  Hypothesis H0: mu1=mu2  H1: m1>m2

print(t.test(ytn, yco, alternative="g",mu=0, var.equal=TRUE,test.conf=0.95))  

#Since the p-value is 0.2 all I can say is that I don't have enough evidence to reject the null hypothesis (that the means are equal). 
#In other words, the evidence doesn't show that the mean of the first group is greater than the mean of the second.
cat(sprintf(div))

# If we start with the hypotesis that treatment is 1% higher than control. 
# mu1 = mean(treatment), mu2 = mean(control)  Hypothesis H0: mu1 = 1.01*mu2 (1% diff) H1: m1< 1.01*mu2
print(t.test(ytn, yco, alternative="l",mu=0.01, test.conf=0.95))
 
#Since the p-value is 5e-11, I can say is that I have enough evidence to reject the null hypothesis (that m1=1.01*m2). 
#Therefore the evidence show that the alternative is true. In other words, the m1 < 1.01*mu2

print('Conclusions: After running the t-test we see that the difference is not statistically significant and therefore the experiment needs more data.')


}
