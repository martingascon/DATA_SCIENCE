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


cat(sprintf(div))
######################################################### calculate the variance of this table 
# The uncertainty on a binomial distribution B(n,p) where n = nr and p = 0.1 is var = np(1-p). 
# Sample Proportions: var(X/n) = p(1-p)/n => var(X/n) = 0.1*0.9/nrow(x)
# Calculation of variance for both cases: old-page and new-page

p1<-(nrow(co1)+nrow(to1))/(tot1<-nrow(co1)+nrow(co0)+nrow(to0)+nrow(to1))
p2<-(nrow(cn1)+nrow(tn1))/(tot2<-nrow(cn1)+nrow(cn0)+nrow(tn0)+nrow(tn1))
print(paste0("Variance for old_page (control+treatment): ",round(p1*(1-p1)/tot1*100,7)," %)"))
print(paste0("Variance for new_page (only treatment): ",round(p2*(1-p2)/tot2*100,7)," %)"))
