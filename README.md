# setup
```
docker-compose run web rails db:setup
```

# やっていること
rails / nginxのログをjson形式の構造化ログにする。  
そのうえで、出力先を標準出力へ。その出力をFluent Bitへ。

FluentBitではjson-parseを行い、json形式でログをファイルに書き込んでいる。  
その際、tagに応じて出力ファイルを分けている。

## 出力結果
```text:nginx
nginx: [1670517719.000000000, {"container_id":"b2bcada506afebc3e49a69ca6caaf526048af85d4450c915ffb45af60e1100dd","container_name":"/metrics-sample-nginx-1","source":"stderr","log":"2022/12/08 16:41:59 [notice] 7#7: start worker process 11"}]
nginx: [1670517719.000000000, {"container_id":"b2bcada506afebc3e49a69ca6caaf526048af85d4450c915ffb45af60e1100dd","container_name":"/metrics-sample-nginx-1","source":"stderr","log":"2022/12/08 16:41:59 [notice] 7#7: start worker process 12"}]
nginx: [1670517719.000000000, {"log":"2022/12/08 16:41:59 [notice] 7#7: start worker process 13","container_id":"b2bcada506afebc3e49a69ca6caaf526048af85d4450c915ffb45af60e1100dd","container_name":"/metrics-sample-nginx-1","source":"stderr"}]
nginx: [1670517731.000000000, {"time":"2022-12-08T16:42:11+00:00","host":"172.20.0.1","vhost":"localhost","user":"","status":"200","protocol":"HTTP/1.1","method":"GET","path":"/users","req":"GET /users HTTP/1.1","size":"218","reqtime":"0.717","apptime":"0.717","ua":"curl/7.79.1","forwardedfor":"","forwardedproto":"","referrer":""}]
```

```text:rails
rails_dev: [1670517731.000000000, {"host":"23beac7dd7e0","application":"Semantic Logger","environment":"development","timestamp":"2022-12-08T16:42:11.561722Z","level":"debug","level_index":1,"pid":1,"thread":"puma srv tp 001","named_tags":{"request_id":"418e3b67-2aed-4e11-919f-7495dea7259d","ip":"172.20.0.1"},"name":"Rack","message":"Started","payload":{"method":"GET","path":"/users","ip":"172.20.0.1"}}]
rails_dev: [1670517731.000000000, {"host":"23beac7dd7e0","application":"Semantic Logger","environment":"development","timestamp":"2022-12-08T16:42:11.659298Z","level":"debug","level_index":1,"pid":1,"thread":"puma srv tp 001","duration_ms":0.552833080291748,"duration":"0.553ms","named_tags":{"request_id":"418e3b67-2aed-4e11-919f-7495dea7259d","ip":"172.20.0.1"},"name":"ActiveRecord","message":"ActiveRecord::SchemaMigration Pluck","payload":{"sql":"SELECT \"schema_migrations\".\"version\" FROM \"schema_migrations\" ORDER BY \"schema_migrations\".\"version\" ASC","allocations":11,"cached":null}}]
rails_dev: [1670517731.000000000, {"host":"23beac7dd7e0","application":"Semantic Logger","environment":"development","timestamp":"2022-12-08T16:42:11.681956Z","level":"debug","level_index":1,"pid":1,"thread":"puma srv tp 001","named_tags":{"request_id":"418e3b67-2aed-4e11-919f-7495dea7259d","ip":"172.20.0.1"},"name":"UsersController","message":"Processing #index"}]
rails_dev: [1670517731.000000000, {"host":"23beac7dd7e0","application":"Semantic Logger","environment":"development","timestamp":"2022-12-08T16:42:11.691614Z","level":"info","level_index":2,"pid":1,"thread":"puma srv tp 001","named_tags":{"request_id":"418e3b67-2aed-4e11-919f-7495dea7259d","ip":"172.20.0.1"},"name":"UsersController","payload":{"type":"message","content":"aiueo"}}]
rails_dev: [1670517731.000000000, {"host":"23beac7dd7e0","application":"Semantic Logger","environment":"development","timestamp":"2022-12-08T16:42:11.700081Z","level":"debug","level_index":1,"pid":1,"thread":"puma srv tp 001","duration_ms":0.6270627975463867,"duration":"0.627ms","named_tags":{"request_id":"418e3b67-2aed-4e11-919f-7495dea7259d","ip":"172.20.0.1"},"name":"ActiveRecord","message":"User Load","payload":{"sql":"SELECT \"users\".* FROM \"users\"","allocations":21,"cached":null}}]
rails_dev: [1670517731.000000000, {"host":"23beac7dd7e0","application":"Semantic Logger","environment":"development","timestamp":"2022-12-08T16:42:11.724566Z","level":"info","level_index":2,"pid":1,"thread":"puma srv tp 001","duration_ms":42.48352098464966,"duration":"42.5ms","named_tags":{"request_id":"418e3b67-2aed-4e11-919f-7495dea7259d","ip":"172.20.0.1"},"name":"UsersController","message":"Completed #index","payload":{"controller":"UsersController","action":"index","format":"*/*","method":"GET","path":"/users","status":200,"view_runtime":21.27,"db_runtime":4.14,"allocations":7269,"status_message":"OK"}}]
```