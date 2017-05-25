#!/bin/bash
mkdir -p output/test
for f in test/*.in
do
    ./a.out < $f > output/"${f%.in}.out" /dev/null 2>&1
done

for f in test/*.out
do
    echo -n "Judging $f "
    msg=$(diff $f output/$f)
    if [[ $? -eq 0  ]]; then
        echo "[AC]"
    else
        echo "[WA]"
        echo "Correct Output:"
        printf "$msg\n"
        echo "^ Your Output."
    fi
done

rm -r output