#!/bin/bash

# Escreva um shellscript completo (bash) que contenha uma função (e execute a mesma) onde em um laço, mostre na tela em intervalos de 1 segundo a data, uso de discos, usuários logados e total de arquivos do diretório corrente. Caso o total de arquivos deste diretório ultrapasse 20, então compacte os arquivos pdf deste diretório sem exibir erros na tela. Para sair do programa, deverá ser pressionado CTRL-C.

atribui_valores_informacoes()
{
	data=$(date +"%A, %d/%m/%y - %H:%M:%S")
	uso_disco=$(df -h)
	usuarios_logados=$(users)
	arquivos_visiveis=$(ls|wc -l)
	arquivos_ocultos=$[$(ls -d .*|wc -l) - 2]
	total_arquivos=$(ls -A|wc -l)
	[[ $total_arquivos -gt 20 ]] && compactar_pdf=true || compactar_pdf=false
}

mostra_informacoes()
{
	echo "
------------------------------------------
=====
DATA: $data
=====

--> USO DO DISCO:
$uso_disco

--> USUARIOS LOGADOS:
$usuarios_logados

--> ARQUIVOS VISIVEIS: $arquivos_visiveis

--> ARQUIVOS OCULTOS: $arquivos_ocultos

--> TOTAL DE ARQUIVOS: $total_arquivos

------------------------------------------
	"
}

compacta_pdf()
{
	[[ $compactar_pdf = "true" ]] && tar -czf pdfs_compactados.tar.gz *.pdf 2>/dev/null
}

while :
do
	atribui_valores_informacoes
	mostra_informacoes
	compacta_pdf
	sleep 1
done
