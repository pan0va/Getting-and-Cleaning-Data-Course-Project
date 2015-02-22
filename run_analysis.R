#reading train, test data
f1<-scan("train/X_train.txt")
f2<-scan("test/X_test.txt")
#reading feature labels
a1<-scan("train/y_train.txt")
a2<-scan("test/y_test.txt")
#merging f = train and test data
f<-c(f1,f2)
#merging vector of feature labels
a<-data.frame(c(a1,a2))
names(a)<-c("V1")

#setting dimensions for f data 
dim(f)<-c(561,length(f)/561)

#choosing colums with needed features (mean and st dev)
cols<-read.table("features.txt",header=FALSE)
m<-grep("mean()",cols[,2])
s<-grep("std()",cols[,2])

#loading test/trainsubjects and merging
subj1<-scan("train/subject_train.txt")
subj2<-scan("test/subject_test.txt")

subj=c(subj1,subj2)

#reading activity labels
acts<-data.frame(read.table("activity_labels.txt",header=FALSE))

#extracting into one data frame columns needed, cbinding with subjects and activity rescriptions
ff<-data.frame(cbind(subj,as.character(merge(a,acts)[,2]),t(data.frame(f[cols$V1[c(m,s)],]))))

#setting descriptive variable names
rownames(ff)<-as.character(merge(a,acts)[,2])
colnames(ff)<-c("subj","act", as.character(cols$V2[c(m,s)]))

clean<-aggregate(.~subj+act, data=ff, FUN="mean")

write.table ("clean.txt", row.names=FALSE)



