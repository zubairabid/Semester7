# x = read.table("/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Experiments/ZubairAbid_20171076_prp_20200924.txt")
x = read.table("/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Experiments/prp-r/shelly.txt")

RT1 = x[,8]
RT2 = x[,9]
correct = x[,10]==1 & x[,11]==1
soa = x[,7]
# RT1 = RT1 - soa
# RT2 = RT2 - soa

RT2 = RT2 + RT1 - soa

soas = sort(unique(soa))
realdata = x[,1]==2

rt1 = numeric(4)
rt2 = numeric(4)

#rt1[1]=median( RT1[ correct & realdata & soa==soas[1] ] )
#rt1[2]=median( RT1[ correct & realdata & soa==soas[2] ] )
#rt1[3]=median( RT1[ correct & realdata & soa==soas[3] ] )
#rt1[4]=median( RT1[ correct & realdata & soa==soas[4] ] )
rt1[1]=mean( RT1[ correct & realdata & soa==soas[1] ] )
rt1[2]=mean( RT1[ correct & realdata & soa==soas[2] ] )
rt1[3]=mean( RT1[ correct & realdata & soa==soas[3] ] )
rt1[4]=mean( RT1[ correct & realdata & soa==soas[4] ] )

#rt2[1]=median( RT2[ correct & realdata & soa==soas[1] ] )
#rt2[2]=median( RT2[ correct & realdata & soa==soas[2] ] )
#rt2[3]=median( RT2[ correct & realdata & soa==soas[3] ] )
#rt2[4]=median( RT2[ correct & realdata & soa==soas[4] ] )
rt2[1]=mean( RT2[ correct & realdata & soa==soas[1] ] )
rt2[2]=mean( RT2[ correct & realdata & soa==soas[2] ] )
rt2[3]=mean( RT2[ correct & realdata & soa==soas[3] ] )
rt2[4]=mean( RT2[ correct & realdata & soa==soas[4] ] )

r=c(min(c(rt1,rt2)),max(c(rt1,rt2)))
plot( soas, rt1 , col="green" ,ylim=r,type="b",las=1)
lines( soas, rt2 , ylim=r,col="blue",type="b")
legend("topright",c("RT1","RT2"),fill=c("green","blue"))

print( RT2[ correct & realdata & soa==soas[4]] )

