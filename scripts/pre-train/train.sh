#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master
export CUDA_VISIBLE_DEVICES=0,1,2 && bash ${PROJECT_ROOT}/train/pre-train.sh ${PROJECT_ROOT}/experiments/example/configs/train/pre-train/transformer_big.yml