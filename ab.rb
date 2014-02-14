#!/usr/bin/ruby
require 'csv'
require 'nkf'

AB_PATH="ab"


f = open("ab-output.csv", "w")
f.print "URL,C,N,Server Software,Server Hostname,Server Port," +
  "Document Path,Document Length[bytes]," +
  "Concurrency Level,Time taken for tests[s]," +
  "Complete requests,Failed requests,Write errors," +
  "Total transferred[bytes],HTML transferred[bytes]," +
  "Requests per second[#/sec](mean),Time per request[ms](mean - across all concurrent requests)," +
  "Transfer rate[bytes/s]," +
  "Connect-min[ms],Connect-mean[ms],Connect-[+/-sd],Connect-median[ms],Connect-max[ms]," +
  "Processing-min[ms],Processing-mean[ms],Processing-[+/-sd],Processing-median[ms],Processing-max[ms]," +
  "Waiting-min[ms],Waiting-mean[ms],Waiting-[+/-sd],Waiting-median[ms],Waiting-max[ms]," +
  "Total-min[ms],Total-mean[ms],Total-[+/-sd],Total-median[ms],Total-max[ms]" +
  "\n"

csv = CSV.open('ab-input.csv', 'r')
csv.each do |row|

 url=row[0]
 c = row[1]
 n = row[2]

 h = {}
 IO.popen("#{AB_PATH} -c #{c} -n #{n} #{url}", "r") {|io|
  while str = io.gets
   e = str.scan(/^(.+):\s+(.+)/)
   h[e[0][0]] = e[0][1] if e.length > 0
  end
 }

 f.print "#{url},#{c},#{n},#{h['Server Software']},#{h['Server Hostname']},#{h['Server Port']}," + 
  "#{h['Document Path']},#{h['Document Length'].scan(/\d+/).pop}," + 
  "#{h['Concurrency Level']},#{h['Time taken for tests'].scan(/[\d\.]+/).pop}," +
  "#{h['Complete requests']},#{h['Failed requests']},#{h['Write errors']}," + 
  "#{h['Total transferred'].scan(/\d+/).pop},#{h['HTML transferred'].scan(/\d+/).pop}," +
  "#{h['Requests per second'].scan(/[\d\.]+/).pop},#{h['Time per request'].scan(/[\d\.]+/).pop}," +
  "#{h['Transfer rate'].scan(/[\d\.]+/).pop}," + 
  "#{h['Connect'].gsub(/[\s\t]+/,',')},#{h['Processing'].gsub(/[\s\t]+/,',')},#{h['Waiting'].gsub(/[\s\t]+/,',')},#{h['Total'].gsub(/[\s\t]+/,',')}" +
  "\n"
end
f.close

#{ "This is ApacheBench, Version 2.3 <$Revision"=>"655654 $>", "Server Software"=>"Apache/2.2.8", "Server Hostname"=>"www.flatz.jp", "Server Port"=>"80", "Document Path"=>"/", "Document Length"=>"17617 bytes", "Concurrency Level"=>"1", "Time taken for tests"=>"0.258 seconds", "Complete requests"=>"1", "Failed requests"=>"0", "Write errors"=>"0", "Total transferred"=>"17937 bytes", "HTML transferred"=>"17617 bytes", "Requests per second"=>"3.88 [#/sec] (mean)", "Time per request"=>"257.995 [ms] (mean, across all concurrent requests)", "Transfer rate"=>"67.90 [Kbytes/sec] received", "Connect"=>"230  230   0.0    230     230", "Processing"=>"28   28   0.0     28      28", "Waiting"=>"0    0   0.0      0       0", "Total"=>"258  258   0.0    258     258"}

