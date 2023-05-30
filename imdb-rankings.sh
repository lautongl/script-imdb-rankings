#!/usr/bin/env bash
# Autor:      Glaucia Lauton
# Contato:    dontcallme@gmail.com 
# --------------------------------------------------------------------------- #
# Nome: imdb-rankings.sh
# Descrição:
#
#  Este programa mostrará os 20 filmes e séries mais populares e os mais bem 
#  avaliados segundo o site IMDb.
#
# --------------------------------------------------------------------------- #
# Exemplo de utilização:
#      $ ./imdb-rankings.sh 
#      Utilizar as informações exibidas no menu para selecionar a opção desejada.
# --------------------------------------------------------------------------- #
# --------------------------------------------------------------------------- #
# Testado em:
#   bash 4.4.19
# --------------------------------------------------------------------------- #
# 
# -------------------------------- VARIÁVEIS -------------------------------- #
MOSTPOPULAR_TV=popular-tv.txt
MPTV=0
TOPRATED_TV=top-rated-tvshows.txt
TPTV=0


MOSTPOPULAR_MOVIES=popular-movies.txt
MPMV=0
TOPRATED_MOVIES=top-rated-movies.txt
TPMV=0


RED='\033[0;31m'
CYAN='\033[0;36m'

echo -e "
---------------------------------------------------------------------------
Ranking Top 20 IMDb 
---------------------------------------------------------------------------
Select:

 [ 1 ] - Most Popular TV Shows
 [ 2 ] - Most Popular Movies
 [ 3 ] - Top Rated TV Shows
 [ 4 ] - Top Rated Movies
 [ 0 ] - Exit

 Type the number: "; read OPC
#
# -------------------------------- TESTES ----------------------------------- #
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y
#Verifica se o lynx está instalado. Caso não esteja (!), o utilitário será instalado.
#
# -------------------------------- FUNÇÕES ---------------------------------- #
function LerArquivo (){
    while read -r linha
    do
        echo -e "${RED}$NOME: ${CYAN}$linha" 
    done < $ARQUIVO
}

function ReturnMenu (){
    echo -e "
Return:
[ 1 ] Yes    [ 2 ] No
    
Type: "; read OPTION

    if [ $OPTION -eq 1 ]
    then 
        clear && ./imdb-rankings.sh
    else
        exit 0
    fi
    }
#
# -------------------------------- EXECUÇÃO --------------------------------- #
case $OPC in
    1) MPTV=1       ;;
    2) MPMV=1       ;;
    3) TPTV=1       ;;
    4) TPMV=1       ;;
    0) exit & clear ;;
    *) echo "Invalid option."
esac

[ $MPTV -eq 1 ] && lynx -source https://www.imdb.com/chart/tvmeter/?ref_=nv_tvv_mptv | grep 'jpg" width="45" height="67" alt="' | sed 's/>.*="//;s/".*>//' | head -20 > $MOSTPOPULAR_TV && ARQUIVO=$MOSTPOPULAR_TV && NOME="TV Show Title" && LerArquivo && ReturnMenu
[ $MPMV -eq 1 ] && lynx -source https://www.imdb.com/chart/tvmeter/?ref_=nv_tvv_mptv | grep 'jpg" width="45" height="67" alt="' | sed 's/>.*="//;s/".*>//' | head -20 > $MOSTPOPULAR_MOVIES && ARQUIVO=$MOSTPOPULAR_MOVIES && NOME="Movie Title" && LerArquivo && ReturnMenu
[ $TPTV -eq 1 ] && lynx -source https://www.imdb.com/chart/tvmeter/?ref_=nv_tvv_mptv | grep 'jpg" width="45" height="67" alt="' | sed 's/>.*="//;s/".*>//' | head -20 > $TOPRATED_TV && ARQUIVO=$TOPRATED_TV && NOME="Top Rated TV Show Title" && LerArquivo && ReturnMenu
[ $TPMV -eq 1 ] && lynx -source https://www.imdb.com/chart/tvmeter/?ref_=nv_tvv_mptv | grep 'jpg" width="45" height="67" alt="' | sed 's/>.*="//;s/".*>//' | head -20 > $TOPRATED_MOVIES && ARQUIVO=$TOPRATED_MOVIES && NOME="Top Rated TV Show Title" && LerArquivo && ReturnMenu


