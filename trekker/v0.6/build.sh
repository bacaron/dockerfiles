#!/bin/bash
set -ex
tag=0.6
docker build -t brainlife/trekker . 
docker tag brainlife/trekker brainlife/trekker:$tag
docker push brainlife/trekker:$tag
