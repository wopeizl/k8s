if [ ! -d "tmp_for_split" ]; then
    mkdir tmp_for_split
fi
splitnum=10
trainfile=train.txt
#trainfile=readme.txt
testfile=test.txt
#testfile=readme.txt
trainnum=$(wc -l ${trainfile} | awk '{print $1}')
testnum=$(wc -l ${testfile} | awk '{print $1}')
trainlines=$(( trainnum / splitnum ))
testlines=$(( testnum / splitnum ))
split -a 1 -l ${trainlines} ${trainfile} train_split
split -a 1 -l ${testlines} ${testfile} test_split
for i in a b c d e f g h i j
do
    train_split_filename="train_split${i}"
    mv ${train_split_filename} tmp_for_split/train.txt
    test_split_filename="test_split${i}"
    mv ${test_split_filename} tmp_for_split/test.txt
    dac_file="dac${i}.tar.gz"
    cd tmp_for_split && tar zcf ${dac_file} train.txt test.txt 
    mv ${dac_file} .. && cd ..
    rm tmp_for_split/train.txt tmp_for_split/test.txt
done
rmdir tmp_for_split

