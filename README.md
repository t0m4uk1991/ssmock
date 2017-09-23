# smock(Sinatra mocks) - the simple Sinatra-based app that allows to the mock set of services.

To build app navigate to application directory and execute bundler

Usage

1) define a set of endpoints in a mock.yaml configuration file located  шт config direcory. Example is below:
```yaml
mocks:
  - name: 'service1'
    port: 33666
    endpoints:
      - endpoint: '/test1'
        payload: 'example1.json'
        method: get
      - endpoint: '/test2'
        payload: 'example2.json'
        method: post
  - name: 'service2'
    port: 33667
    endpoints:
      - endpoint: '/test1'
        payload: 'example1.json'
        method: get
      - endpoint: '/test2'
        payload: 'example2.json'
        method: post

```
the payload for each endpoint should be located in public directory

2) use rake -T to list task
```bash
rake smock:example  # example
rake smock:kill     # kill mocks
rake smock:load     # run mocks
```

execute rake smock:generate   to genarete moking scripts
execute rake smock:run        to run services
execute rake smock:kill       to stop services services

TODO
* Fix problem with kill operation
* Refactor
