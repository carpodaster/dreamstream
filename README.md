# DreamStream

A test bed for multi-threaded CSV exports streamed directly to the client.

## Motivation

## Installation
1. Clone
2. `bundle install`
3. `ruby app.rb`
4. Hit `http://localhost:4567/export/sequentially` and `http://localhost:4567/export/parallel` to see the difference

## Benchmark

### Sequential run

```
ab -c1 -n5 http://localhost:4567/export/sequentially

This is ApacheBench, Version 2.3 <$Revision: 1807734 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            4567

Document Path:          /export/sequentially
Document Length:        2392 bytes

Concurrency Level:      1
Time taken for tests:   51.228 seconds
Complete requests:      5
Failed requests:        0
Total transferred:      12710 bytes
HTML transferred:       11960 bytes
Requests per second:    0.10 [#/sec] (mean)
Time per request:       10245.522 [ms] (mean)
Time per request:       10245.522 [ms] (mean, across all concurrent requests)
Transfer rate:          0.24 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing: 10216 10245  23.4  10259   10267
Waiting:        1    1   0.2      1       1
Total:      10216 10245  23.4  10259   10267

Percentage of the requests served within a certain time (ms)
  50%  10252
  66%  10267
  75%  10267
  80%  10267
  90%  10267
  95%  10267
  98%  10267
  99%  10267
 100%  10267 (longest request)
 ```
 
 ### Multi-thread run
 
 ```
 ab -c1 -n5 http://localhost:4567/export/parallel
 This is ApacheBench, Version 2.3 <$Revision: 1807734 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            4567

Document Path:          /export/parallel
Document Length:        0 bytes

Concurrency Level:      1
Time taken for tests:   16.496 seconds
Complete requests:      5
Failed requests:        4
   (Connect: 0, Receive: 0, Length: 4, Exceptions: 0)
Total transferred:      8570 bytes
HTML transferred:       7820 bytes
Requests per second:    0.30 [#/sec] (mean)
Time per request:       3299.294 [ms] (mean)
Time per request:       3299.294 [ms] (mean, across all concurrent requests)
Transfer rate:          0.51 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:     1 3299 1843.6   4124    4138
Waiting:        1    1   0.2      1       1
Total:          1 3299 1843.6   4125    4138

Percentage of the requests served within a certain time (ms)
  50%   4112
  66%   4137
  75%   4137
  80%   4138
  90%   4138
  95%   4138
  98%   4138
  99%   4138
 100%   4138 (longest request)
 ```
