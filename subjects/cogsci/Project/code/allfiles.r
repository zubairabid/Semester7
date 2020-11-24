root <- "/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/tfinal/"
files <- read.csv("/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/tfinal/data_fin.csv")
demoall <- function(left, right) {
    for (value in files[,6]) {
        filename <- paste(root, value, sep="")
        print(filename)
        
        x = read.table(filename)
        RT1 = x[left:right,8]
        RT2 = x[left:right,9]
        correct = x[left:right,10]==1 & x[left:right,11]==1
        soa = x[left:right,7]
        RT2 = RT2 + RT1 - soa
        soas = sort(unique(soa))
        realdata = x[left:right,1]==2
        
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
        print(r)
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

plotmean <- function(left, right) {
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
        RT1 = x[left:right,8]
        RT2 = x[left:right,9]
        correct = x[left:right,10]==1 & x[left:right,11]==1
        soa = x[left:right,7]
        RT2 = RT2 + RT1 - soa
        soas = sort(unique(soa))
        realdata = x[left:right,1]==2
        
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
    #png(filename="/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/code/finalinit.png")
    plot( soas, rt1 , col="red", ylim=r, ylab="Response times", xlab = "SOA (time between two stimuli)")
    lines( soas, rt1 , col="red")
    points( soas, rt2 , col="blue")
    lines( soas, rt2 , col="blue")
    legend("topright",c("RT1","RT2"),fill=c("red","blue"))
    #dev.off()
    
}

plotmeanage <- function(left, right) {
    youngallRT11 <-list()
    youngallRT12 <-list()
    youngallRT13 <-list()
    youngallRT14 <-list()
    youngallRT21 <-list()
    youngallRT22 <-list()
    youngallRT23 <-list()
    youngallRT24 <-list()
    
    oldallRT11 <-list()
    oldallRT12 <-list()
    oldallRT13 <-list()
    oldallRT14 <-list()
    oldallRT21 <-list()
    oldallRT22 <-list()
    oldallRT23 <-list()
    oldallRT24 <-list()
    
    
    for (i in 1:length(files[,1])) {
        value = files[i, 6]
        age = files[i, 4]
        dominant_hand = files[i, 5]
        time_taken = files[i, 9]
        
        filename <- paste(root, value, sep="")
        print(filename)
        
        x = read.table(filename)
        RT1 = x[left:right,8]
        RT2 = x[left:right,9]
        correct = x[left:right,10]==1 & x[left:right,11]==1
        soa = x[left:right,7]
        RT2 = RT2 + RT1 - soa
        soas = sort(unique(soa))
        realdata = x[left:right,1]==2
        
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
        
        if (age <= 22) {
            youngallRT11 <- unlist(append(youngallRT11, rt1[1]))
            youngallRT12 <- unlist(append(youngallRT12, rt1[2]))
            youngallRT13 <- unlist(append(youngallRT13, rt1[3]))
            youngallRT14 <- unlist(append(youngallRT14, rt1[4]))
            youngallRT21 <- unlist(append(youngallRT21, rt2[1]))
            youngallRT22 <- unlist(append(youngallRT22, rt2[2]))
            youngallRT23 <- unlist(append(youngallRT23, rt2[3]))
            youngallRT24 <- unlist(append(youngallRT24, rt2[4]))
        }
        else {
            oldallRT11 <- unlist(append(oldallRT11, rt1[1]))
            oldallRT12 <- unlist(append(oldallRT12, rt1[2]))
            oldallRT13 <- unlist(append(oldallRT13, rt1[3]))
            oldallRT14 <- unlist(append(oldallRT14, rt1[4]))
            oldallRT21 <- unlist(append(oldallRT21, rt2[1]))
            oldallRT22 <- unlist(append(oldallRT22, rt2[2]))
            oldallRT23 <- unlist(append(oldallRT23, rt2[3]))
            oldallRT24 <- unlist(append(oldallRT24, rt2[4]))
        }
        
    }
    
    youngrt1 = numeric(4)
    youngrt2 = numeric(4)
    oldrt1 = numeric(4)
    oldrt2 = numeric(4)
    
    oldrt1[1]=mean( oldallRT11 )
    oldrt1[2]=mean( oldallRT12 )
    oldrt1[3]=mean( oldallRT13 )
    oldrt1[4]=mean( oldallRT14 )
    
    oldrt2[1]=mean( oldallRT21 )
    oldrt2[2]=mean( oldallRT22 )
    oldrt2[3]=mean( oldallRT23 )
    oldrt2[4]=mean( oldallRT24 )
    
    youngrt1[1]=mean( youngallRT11 )
    youngrt1[2]=mean( youngallRT12 )
    youngrt1[3]=mean( youngallRT13 )
    youngrt1[4]=mean( youngallRT14 )
    
    youngrt2[1]=mean( youngallRT21 )
    youngrt2[2]=mean( youngallRT22 )
    youngrt2[3]=mean( youngallRT23 )
    youngrt2[4]=mean( youngallRT24 )
    
    r=c(min(c(youngrt1,youngrt2)),max(c(youngrt1,youngrt2)))
    png(filename="/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/code/finalyoung.png")
    plot( soas, youngrt1 , col="red", ylim=r, ylab="Response times (under 23)", xlab = "SOA (time between two stimuli)")
    lines( soas, youngrt1 , col="red")
    points( soas, youngrt2 , col="blue")
    lines( soas, youngrt2 , col="blue")
    legend("topright",c("RT1","RT2"),fill=c("red","blue"))
    dev.off()
    Sys.sleep(10)
    r=c(min(c(oldrt1,oldrt2)),max(c(oldrt1,oldrt2)))
    png(filename="/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/code/finalold.png")
    plot( soas, oldrt1 , col="red", ylim=r, ylab="Response times (after 23)", xlab = "SOA (time between two stimuli)")
    lines( soas, oldrt1 , col="red")
    points( soas, oldrt2 , col="blue")
    lines( soas, oldrt2 , col="blue")
    legend("topright",c("RT1","RT2"),fill=c("red","blue"))
    dev.off()
}

plotmeanhand <- function(left, right, handed) {
    # handed is 2 if right, 1 if left
    allRT11 <-list()
    allRT12 <-list()
    allRT13 <-list()
    allRT14 <-list()
    allRT21 <-list()
    allRT22 <-list()
    allRT23 <-list()
    allRT24 <-list()
    for (i in 1:length(files[,1])) {
        value = files[i, 6]
        age = files[i, 4]
        dominant_hand = files[i, 5]
        time_taken = files[i, 9]
        
        filename <- paste(root, value, sep="")
        print(filename)
        
        if (dominant_hand != handed) {
            next
        }
        
        x = read.table(filename)
        RT1 = x[left:right,8]
        RT2 = x[left:right,9]
        correct = x[left:right,10]==1 & x[left:right,11]==1
        soa = x[left:right,7]
        RT2 = RT2 + RT1 - soa
        soas = sort(unique(soa))
        realdata = x[left:right,1]==2
        
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
    
    postfix = ""
    if (handed == 1) {
        postfix = "left.png"
    }
    else {
        postfix = "right.png"
    }
    
    r=c(min(c(rt1,rt2)),max(c(rt1,rt2)))

    #png(filename=paste("/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/code/", postfix, sep = ""))
    plot( soas, rt1 , col="red", ylim=r, ylab="Response times", xlab = "SOA (time between two stimuli)")
    lines( soas, rt1 , col="red")
    points( soas, rt2 , col="blue")
    lines( soas, rt2 , col="blue")
    legend("topright",c("RT1","RT2"),fill=c("red","blue"))
    #dev.off()
    
}


demoall(21,120)
#plotmean(21,70)
plotmean(21,70)
plotmeanage(21,120)

plotmeanhand(21, 120, 1)

files <- read.csv("/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/tfinal/data_multiple.csv")
