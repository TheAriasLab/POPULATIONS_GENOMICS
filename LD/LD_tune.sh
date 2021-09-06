ls | grep c1.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c1_LD -bin1 800000 -bin2 6000000  -break 100000000
y
ls | grep c2.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c2_LD -bin1 2000 -bin2 3000000 -break 600

ls | grep c3.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c3_LD -bin1 2000 -bin2 1000000 -break 600

ls | grep c4.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c4_LD -bin1 2000 -bin2 1000000 -break 600

ls | grep pacific.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output pacific_LD -bin1 2000 -bin2 1000000 -break 600

Plot_MultiPop.pl -inList multi.list -output all -keepR
