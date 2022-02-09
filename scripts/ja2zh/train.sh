#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master
finetune_yml=/home/being/PycharmProjects/mRASP-master/experiments/example/configs/train/fine-tune/ja2zh_transformer_big.yml
eval_yml=/home/being/PycharmProjects/mRASP-master/experiments/example/configs/eval/ja2zh_eval.yml
export CUDA_VISIBLE_DEVICES=0,1,2 && export EVAL_GPU_INDEX=-1 && bash ${PROJECT_ROOT}/train/fine-tune.sh ${finetune_yml} ${eval_yml}
