file=/data/publicdata/wikiarticles/enwiki-latest.text
record_num=3977902
read_num=2000000
dirname=/mnt/datamemory

rm -rf $dirname/*

export TMPDIR=$dirname
echo $TMPDIR

cp ../terarkschema/dbmeta_wikiarticles_no_index.json $dirname/dbmeta.json

echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export NarkDb_WrSegCacheSizeMB=64
../db_wikiarticles_terark --benchmarks=fillrandom --num=$record_num --reads=$read_num --sync_index=0 --db=$dirname --resource_data=$file
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export NarkDb_WrSegCacheSizeMB=64
../db_wikiarticles_terark --benchmarks=readrandom --num=$record_num --reads=$read_num --sync_index=0 --db=$dirname --resource_data=$file
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export NarkDb_WrSegCacheSizeMB=64
../db_wikiarticles_terark --benchmarks=readrandom --num=$record_num --reads=$read_num --sync_index=0 --threads=8 --db=$dirname --resource_data=$file
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export NarkDb_WrSegCacheSizeMB=64
../db_wikiarticles_terark --benchmarks=readrandom --num=$record_num --reads=$read_num --sync_index=0 --threads=16 --db=$dirname --resource_data=$file
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

echo "####Now, running terark benchmark"
echo 3 > /proc/sys/vm/drop_caches
free -m
date
export NarkDb_WrSegCacheSizeMB=64
../db_wikiarticles_terark --benchmarks=readrandom --num=$record_num --reads=$read_num --sync_index=0 --threads=24 --db=$dirname --resource_data=$file
free -m
date
echo "####terark benchmark finish"
du -s -b $dirname

dstatpid=`ps aux | grep dstat | awk '{if($0 !~ "grep"){print $2}}'`
for i in $dstatpid
do
        kill -9 $i
done
