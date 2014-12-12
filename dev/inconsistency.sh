TMPDIR=/tmp

if [[ $1 == "sv-da" ]]; then
lt-expand ../apertium-sv-da.sv.dix | grep -v 'NON_ANALYSIS' | grep -v '<compound-' | grep -v '<prn><enc>' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../sv-da.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        apertium-transfer -b ../apertium-sv-da.sv-da.t1x  ../sv-da.t1x.bin  | tee $TMPDIR/tmp_testvoc3.txt |
        lt-proc -d ../sv-da.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc4.txt
	lt-proc -d ../da-sv.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt $TMPDIR/tmp_testvoc4.txt | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'
elif [[ $1 == "da-sv" ]]; then
lt-expand ../apertium-sv-da.da.dix | grep -v 'NON_ANALYSIS' | grep -v '<compound-' | grep -v '<prn><enc>' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../da-sv.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        apertium-transfer -b ../apertium-sv-da.da-sv.t1x  ../da-sv.t1x.bin | tee $TMPDIR/tmp_testvoc3.txt |
        lt-proc -d ../da-sv.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc4.txt
	lt-proc -d ../sv-da.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt $TMPDIR/tmp_testvoc4.txt  | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'
else
	echo "Unsupported mode.";
fi
