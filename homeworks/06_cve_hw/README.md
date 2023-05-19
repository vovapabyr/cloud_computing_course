# Instructions and results
 1. Run trivy in docker to detect vulnerabilities of the ```ghcr.io/mlflow/mlflow:v2.3.0``` image: 
 ```
 docker run --rm -v ~/.trivy:/root/.cache/ aquasec/trivy:0.40.0 image --severity HIGH,CRITICAL --ignore-unfixed ghcr.io/mlflow/mlflow:v2.3.0
 ```
 ![trivy](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/68c97a5c-716e-4219-b399-cf617f949b66)
 2. Run grype in docker to detect vulnerabilities of the ```ghcr.io/mlflow/mlflow:v2.3.0``` image: 
```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e GRYPE_LOG_LEVEL=error anchore/grype:v0.54.0 ghcr.io/mlflow/mlflow:v2.3.0 --only-fixed | grep -E 'Critical|High'
``` 
There is an issue with the latest version of grype which shows suppressed lines even without ```--show-suppressed``` option (https://github.com/anchore/grype/issues/1053) specified, that's why I used older version (v0.54.0).
![grype](https://github.com/vovapabyr/cloud_computing_course/assets/25819135/04b30cf8-65d8-4603-92d5-87437cda9fd0)

# Summary
Both trivy (0.40.0) and grype (0.54.0) detected the same number of vulnerabilities: 2 critical and 5 high.
