#!/usr/bin/env bash
#  此处进行了修改，原文件在copy备份里
echo "  tokenizer=${tokenizer}"
if [[ ${tokenizer} == "None" ]]; then
    echo "    Tokenize = None, do nothing"

elif [[ ${tokenizer} == "MosesTokenizer" ]]; then
    process_cmd="${process_cmd} | perl ${tokenize_script_dir}/moses_tokenizer.pl -a -q -l ${language} -no-escape -threads ${num_cpus} "

elif [[ ${tokenizer} == "Char" ]]; then
    process_cmd="${process_cmd} | perl ${tokenize_script_dir}/to_character.pl -l ${language} -t ${num_cpus}"

elif [[ ${tokenizer} == "jieba" ]]; then
    process_cmd="${process_cmd} | python -m jieba -d "

elif [[ ${tokenizer} == "kytea" ]]; then
    [[ -z ${kytea_model} ]] && echo "Please provide ${kytea_model}" && exit 1;
    process_cmd="${process_cmd} | python ${tokenize_script_dir}/kytea.py -m ${kytea_model}"
elif [[ ${tokenizer} == "mecab" ]]; then
    process_cmd="${process_cmd} | python ${tokenize_script_dir}/mecab_lyf.py "
else
    echo "    Unrecognized tokenizer ${tokenizer}"
    exit 1;
fi

