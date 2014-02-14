apachebench
===========

Apache Bench Ruby Script

Apache Benchの結果をCSVで横一列に出力します。
CSVを複数行指定することで複数回測定もできます。

# ab-input.csv のフォーマット

[URL],[Number of multiple requests to make],[Number of requests to perform]

ヘッダ行はありません。

    http://example.com/,1,2
    http://example.com/,2,4

# 実行方法

    $ ./ab.rb

# 出力結果

    URL,C,N,Server Software,Server Hostname,Server Port,Document Path,Document Length[bytes],Concurrency Level,Time taken for tests[s],Complete requests,Failed requests,Write errors,Total transferred[bytes],HTML transferred[bytes],Requests per second[#/sec](mean),Time per request[ms](mean - across all concurrent requests),Transfer rate[bytes/s],Connect-min[ms],Connect-mean[ms],Connect-[+/-sd],Connect-median[ms],Connect-max[ms],Processing-min[ms],Processing-mean[ms],Processing-[+/-sd],Processing-median[ms],Processing-max[ms],Waiting-min[ms],Waiting-mean[ms],Waiting-[+/-sd],Waiting-median[ms],Waiting-max[ms],Total-min[ms],Total-mean[ms],Total-[+/-sd],Total-median[ms],Total-max[ms]
    http://example.com/,1,2,Apache/2.2.8,example.com,80,/,17483,1,0.513,2,0,0,35606,34966,3.90,256.568,67.76,217,229,16.6,240,240,27,28,0.8,29,29,0,0,0.0,0,0,244,256,17.4,269,269
    http://example.com/,2,4,Apache/2.2.8,example.com,80,/,17483,2,1.097,4,2,0,71212,69932,3.65,274.182,63.41,32,357,226.1,471,542,0,188,224.3,158,510,0,146,244.8,75,509,541,545,6.3,542,554
