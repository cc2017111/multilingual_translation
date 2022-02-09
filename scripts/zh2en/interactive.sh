#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy
CUDA_VISIBLE_DEVICES=0,1,2 lightseq-interactive ${PROJECT_ROOT}/data/test/zh2en/wmt14_head100/bin \
        --path ${PROJECT_ROOT}/models/fine-tune/transformer_big/zh2en/checkpoint_best.pt \
        --beam 5 --source-lang zh --target-lang en \
        --tokenizer moses \
        --bpe subword_nmt --bpe-codes ${PROJECT_ROOT}/vocab/codes.bpe.32000 \
        --remove-bpe



