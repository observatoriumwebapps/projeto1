#!/bin/bash

rm ./etapa2/*
mkdir -p ./etapa2

for arquivo in etapa1/*.csv; do

    nome_arquivo=$(basename "$arquivo")

    gawk -F";" 'BEGIN {
    
        #Cria-se a primeira linha, printando o string completo que vai na primeira linha que vai servir de rótulo.
        print "DT_PRI_SIN;DT_NASC;DT_ENCERRA;DT_OBITO;PCR_COVID;ANTIG_COVID;PCR_INFLUENZA;ANTIG_INFLUENZA;EVOLUCAO;FEBRE;TOSSE;CORIZA;DIARREIA;TABAGISTA;ETILISTA;RENAL;CARDIOPATI;CANCER;VACINA"
    }

    #Este bloco vai rodar da segunda linha em diante, saindo da linha de rótulo.
    NR > 1 {
    
        #COPIA DIRETA
        DT_PRI_SIN = $1
        DT_NASC = $2
        DT_ENCERRA = $3
        DT_OBITO = $4
        PCR_COVID = $5
        ANTIG_COVID = $6
        PCR_INFLUENZA = $7
        ANTIG_INFLUENZA = $8
        EVOLUCAO = $9

        #INICIALIZANDO NOVAS COLUNAS
        FEBRE = TOSSE = CORIZA = DIARREIA = TABAGISTA = ETILISTA = RENAL = CARDIOPATI = CANCER = VACINA = 0

        texto = tolower($13)

        if (texto ~ /febre/)     FEBRE = 1
        if (texto ~ /tosse/)     TOSSE = 1
        if (texto ~ /coriza|hialina/) CORIZA = 1
        if (texto ~ /diarreia/)  DIARREIA = 1
        if (texto ~ /fumante|tabag/) TABAGISTA = 1
        if (texto ~ /etili|alcool/)  ETILISTA = 1
        if (texto ~ /renal|rin/) RENAL = 1
        if (texto ~ /cardio|coracao/) CARDIOPATI = 1
        if (texto ~ /cancer/)    CANCER = 1

        VACINA = $15 + $16 + $17 + $18

        #Este print imprime uma string tipo fstring, concatenando em string e as variáveis que criamos no bloco do NR > 1 (segundo bloco)
        print DT_PRI_SIN ";" DT_NASC ";" DT_ENCERRA ";" DT_OBITO ";" PCR_COVID ";" ANTIG_COVID ";" PCR_INFLUENZA ";" ANTIG_INFLUENZA ";" EVOLUCAO ";" FEBRE ";" TOSSE ";" CORIZA ";" DIARREIA ";" TABAGISTA ";" ETILISTA ";" RENAL ";" CARDIOPATI ";" CANCER ";" VACINA
    }' "$arquivo" > "./etapa2/$nome_arquivo"

done


