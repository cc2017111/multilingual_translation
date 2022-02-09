#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy
CUDA_VISIBLE_DEVICES=0,1,2 fairseq-interactive ${PROJECT_ROOT}/data/fine-tune/ja2zh \
        --path ${PROJECT_ROOT}/models/fine-tune/transformer_big/ja2zh/checkpoint31.pt \
        --beam 5 --source-lang ja --target-lang zh \
        --tokenizer moses \
        --bpe subword_nmt --bpe-codes ${PROJECT_ROOT}/vocab/codes.bpe.32000 \
        --remove-bpe
