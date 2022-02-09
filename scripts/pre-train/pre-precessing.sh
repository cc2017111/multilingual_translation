#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master
#TRAIN_CONFIG_YML=/home/being/PycharmProjects/mRASP-master/experiments/example/configs/preprocess/train.yml
#DEV_CONFIG_YML=/home/being/PycharmProjects/mRASP-master/experiments/example/configs/preprocess/dev.yml
#bash ${PROJECT_ROOT}/preprocess/multilingual_preprocess_main.sh ${TRAIN_CONFIG_YML}
#bash ${PROJECT_ROOT}/preprocess/multilingual_preprocess_main.sh ${DEV_CONFIG_YML}
bash ${PROJECT_ROOT}/experiments/example/bin_pretrain.sh
# #pretrain_model_dir: /home/being/PycharmProjects/mRASP-master/experiments/example/data/toy/models/pre-train/transformer_big
# #data_path: /media/being/_dev_dva/test