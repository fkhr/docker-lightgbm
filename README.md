# docker-lightgbm

[LightGBM](https://github.com/Microsoft/LightGBM) docker image based alpine.

[libsvm](https://github.com/cjlin1/libsvm), [liblinear](https://github.com/cjlin1/liblinear) binary also included.
 
```
$ docker image build -t local/lightgbm .
$ docker run -it --rm -v $(pwd):/code -w /code local/lightgbm sh
```