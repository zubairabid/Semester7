root <- "/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/tfinal/"
files <- read.csv("/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/tfinal/data_fin.csv")
demoall <- function() {
    for (value in files[,6]) {
        filename <- paste(root, value, sep="")
        print(filename)
        
        x = read.table(filename)
        RT1 = x[,8]
        RT2 = x[,9]
        correct = x[,10]==1 & x[,11]==1
        soa = x[,7]
        RT2 = RT2 + RT1 - soa
        soas = sort(unique(soa))
        realdata = x[,1]==2
        
        rt1 = numeric(4)
        rt2 = numeric(4)
        
        rt1[1]=mean( RT1[ correct & realdata & soa==soas[1] ] )
        rt1[2]=mean( RT1[ correct & realdata & soa==soas[2] ] )
        rt1[3]=mean( RT1[ correct & realdata & soa==soas[3] ] )
        rt1[4]=mean( RT1[ correct & realdata & soa==soas[4] ] )
        
        rt2[1]=mean( RT2[ correct & realdata & soa==soas[1] ] )
        rt2[2]=mean( RT2[ correct & realdata & soa==soas[2] ] )
        rt2[3]=mean( RT2[ correct & realdata & soa==soas[3] ] )
        rt2[4]=mean( RT2[ correct & realdata & soa==soas[4] ] )
        
        r=c(min(c(rt1,rt2)),max(c(rt1,rt2)))
        png(paste(filename, ".png", sep=""))
        plot( soas, rt1 , col="red", ylim=r, ylab="Response times", xlab = "SOA (time between two stimuli)")
        lines( soas, rt1 , col="red")
        points( soas, rt2 , col="blue")
        lines( soas, rt2 , col="blue")
        legend("topright",c("RT1","RT2"),fill=c("red","blue"))
        Sys.sleep(1)
        dev.off()
    }
}

plotmean <- function() {
    allRT11 <-list()
    allRT12 <-list()
    allRT13 <-list()
    allRT14 <-list()
    allRT21 <-list()
    allRT22 <-list()
    allRT23 <-list()
    allRT24 <-list()
    for (value in files[,6]) {
        filename <- paste(root, value, sep="")
        print(filename)
        
        x = read.table(filename)
        RT1 = x[,8]
        RT2 = x[,9]
        correct = x[,10]==1 & x[,11]==1
        soa = x[,7]
        RT2 = RT2 + RT1 - soa
        soas = sort(unique(soa))
        realdata = x[,1]==2
        
        rt1 = numeric(4)
        rt2 = numeric(4)
        
        rt1[1]=mean( RT1[ correct & realdata & soa==soas[1] ] )
        rt1[2]=mean( RT1[ correct & realdata & soa==soas[2] ] )
        rt1[3]=mean( RT1[ correct & realdata & soa==soas[3] ] )
        rt1[4]=mean( RT1[ correct & realdata & soa==soas[4] ] )
        
        rt2[1]=mean( RT2[ correct & realdata & soa==soas[1][1] ] )
        rt2[2]=mean( RT2[ correct & realdata & soa==soas[2] ] )
        rt2[3]=mean( RT2[ correct & realdata & soa==soas[3] ] )
        rt2[4]=mean( RT2[ correct & realdata & soa==soas[4] ] )
        
        allRT11 <- unlist(append(allRT11, rt1[1]))
        allRT12 <- unlist(append(allRT12, rt1[2]))
        allRT13 <- unlist(append(allRT13, rt1[3]))
        allRT14 <- unlist(append(allRT14, rt1[4]))
        allRT21 <- unlist(append(allRT21, rt2[1]))
        allRT22 <- unlist(append(allRT22, rt2[2]))
        allRT23 <- unlist(append(allRT23, rt2[3]))
        allRT24 <- unlist(append(allRT24, rt2[4]))
    }
    
    rt1 = numeric(4)
    rt2 = numeric(4)
    
    rt1[1]=mean( allRT11 )
    rt1[2]=mean( allRT12 )
    rt1[3]=mean( allRT13 )
    rt1[4]=mean( allRT14 )
    
    rt2[1]=mean( allRT21 )
    rt2[2]=mean( allRT22 )
    rt2[3]=mean( allRT23 )
    rt2[4]=mean( allRT24 )
    
    r=c(min(c(rt1,rt2)),max(c(rt1,rt2)))
    png(filename="/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/code/final.png")
    plot( soas, rt1 , col="red", ylim=r, ylab="Response times", xlab = "SOA (time between two stimuli)")
    lines( soas, rt1 , col="red")
    points( soas, rt2 , col="blue")
    lines( soas, rt2 , col="blue")
    legend("topright",c("RT1","RT2"),fill=c("red","blue"))
    dev.off()
    
}
demoall()
plotmean()

