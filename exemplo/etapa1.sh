#!/bin/bash

rm ./etapa1/*
mkdir -p ./etapa1

for arquivo in ./arquivos_entrada/*.csv; do

  gawk -F';' 'NF < 19' "$arquivo" > "./etapa1/$(basename "$arquivo")"

done

#Field separator é o ponto-vírgula
#Imprime se o número de campos for menor que 19
# O > é um operador para "canalizar" o stdout. Neste caso o > está jogando em um arquivo novo.
