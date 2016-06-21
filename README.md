# arukas-check
 docker image for check ENV &amp; CMD function on Arukas service

[Arukas](https://arukas.io) is a container hosting service.
Run this container image on Arukas setting below, You can check ENV & CMD functions on Arukas Service.

## SETTING

### Port
TCP 80

### ENV
key:SAMPLEENV  val:hogehoge
key:NEXTENV    val:hogehoge

### CMD
/cmd.sh

### curl sample 
(use [Arukas api](https://arukas.io/en/documents-en/arukas-api-reference-en/))

```
curl -n -X POST https://app.arukas.io/api/app-sets \
  -d '{
  "data": [
    {
      "type": "containers",
      "attributes": {
        "image_name": "fkatkit:arukas-check",
        "instances": 1,
        "mem": 256,
        "cmd": "/cmd.sh",
        "envs": [
          {
            "key": "SAMPLEENV",
            "value": "daijobu!"
          },
          {
            "key": "NEXTENV",
            "value": "eeyo!"
          }
        ],
        "ports": [
          {
            "number": 80,
            "protocol": "tcp"
          }
        ]
      },
      "name": "endpointhogehoge"
    },
    {
      "type": "apps",
      "attributes": {
        "name": "envsample"
      }
    }
  ]
}' \
  -H "Content-Type: application/vnd.api+json"  \
  -H "Accept: application/vnd.api+json"
  ```
  
### ENV check

```
SAMPLEENV = Success! 
NEXTENV = unabled 
```
"unabled" is shown when env set empty or Arukas server has got troubles.

### CMD check

```
CMD is working =P
```
or 
```
CMD is not working!!
```

## Demo
https://envcmdtest.arukascloud.io/

https://envsvalue.arukascloud.io/
