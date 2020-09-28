x = read.table("data.txt")

RT1 = x[,8]
RT2 = x[,9]
correct = x[,10]==1 & x[,11]==1
soa = x[,7]
soas = sort(unique(soa))
realdata = x[,1]==2

rt1 = numeric(4)
rt2 = numeric(4)

rt1[1]=mean( RT1[ correct & realdata & soa==soas[1] ] )
rt1[2]=mean( RT1[ correct & realdata & soa==soas[1] ] )
rt1[3]=mean( RT1[ correct & realdata & soa==soas[1] ] )
rt1[4]=mean( RT1[ correct & realdata & soa==soas[1] ] )

rt2[1]=mean( RT2[ correct & realdata & soa==soas[1] ] )
rt2[2]=mean( RT2[ correct & realdata & soa==soas[1] ] )
rt2[3]=mean( RT2[ correct & realdata & soa==soas[1] ] )
rt2[4]=mean( RT2[ correct & realdata & soa==soas[1] ] )

r=c(min(c(rt1,rt2)),max(c(rt1,rt2)))
plot( soas, rt1 , col="red" ,ylim=r,type="b",las=1)
lines( soas, rt2 , ylim=r,col="blue",type="b")
legend("topright",c("RT1","RT2"),fill=c("red","blue"))

