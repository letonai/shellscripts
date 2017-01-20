################
#Biblioteca de envio de mensagens ao usuario
#Por Ricardo Letonai
#Data: 20100824
#Exemplo de Uso
#message ok "Mensagem de OK"
#message info "Mensagem de Informacao"
#message alert "Mensagem de Alerta"
#message error "Mensagem de Erro"
#message answer "Pergunta ao usuario"
#message info "Mensangem com Variavel #STR# inserida no texto" "TESTE"
#message log "Mensagem sera gravada no log mas nao sera impressa na tela"
###################
#Adicionado log: 05/01/211
#Corrigido Log: 12/01/2011
#Adicionados comentário explicativos: 12/01/2011
#Adiconada opcao no Log sem printar na tela: 12/01/2011
##################

#Se a variavel log nção existir no script o log sera <nome do script>.log
LOG="$0.log"
DEBUG=1;
##################

#####Faz substituicao da variavel #STR# pela variavel $3 na chamada
function message(){
  TYPE=$1
  CONTEXT=$2
  GRAFT=$3
PLAIN=`echo $CONTEXT | sed 's/#STR#/'"$GRAFT"'/g'`;
if ! [ -z "$GRAFT" ]
then
GRAFT=`echo $GRAFT | sed "s#/#\\\\\/#g"`
#CONTEXT=`echo $CONTEXT | sed 's/#STR#/\\\e[1;37m'"$GRAFT"'/g'`
case $TYPE in

    "ok") CONTEXT=`echo $CONTEXT | sed 's/#STR#/\\\e[1;37m'"$GRAFT"'\\\e[0m\\\e[2;32m/g'`;;
  "info") CONTEXT=`echo $CONTEXT | sed 's/#STR#/\\\e[1;37m'"$GRAFT"'\\\e[0m\\\e[2;37m/g'`;;
 "alert") CONTEXT=`echo $CONTEXT | sed 's/#STR#/\\\e[1;37m'"$GRAFT"'\\\e[0m\\\e[2;33m/g'`;;
 "error") CONTEXT=`echo $CONTEXT | sed 's/#STR#/\\\e[1;37m'"$GRAFT"'\\\e[0m\\\e[2;31m/g'`;;
"answer") CONTEXT=`echo $CONTEXT | sed 's/#STR#/\\\e[1;37m'"$GRAFT"'\\\e[0m\\\e[2;34m/g'`;;
esac
fi
#############################################

################################
#Printa Log e Tela

if [ $DEBUG -eq 1 ]
then
  case $TYPE in
    "ok") echo -e "\e[1;32m[OK]\e[0m \e[2;32m$CONTEXT \e[0m";
	  echo -e "[`date +%d/%m/%Y-%H:%M:%S`][OK] $PLAIN " >> $LOG;;
  "info") echo -e "\e[1;37m[INFO]\e[0m \e[2;37m$CONTEXT \e[0m";
	  echo -e "[`date +%d/%m/%Y-%H:%M:%S`][INFO] $PLAIN " >> $LOG;;
 "alert") echo -e "\e[1;33m[ATTENTION]\e[0m \e[2;33m$CONTEXT \e[0m";
	  echo -e "[`date +%d/%m/%Y-%H:%M:%S`][ATTENTION] $PLAIN " >> $LOG;;
 "error") echo -e "\e[1;31m[ERROR]\e[0m \e[2;31m$CONTEXT \e[0m";
	  echo -e "[`date +%d/%m/%Y-%H:%M:%S`][ERROR] $PLAIN " >> $LOG;;
"answer") echo -e "\e[1;34m[QUESTION] $CONTEXT \e[0m";
	  echo -e "[`date +%d/%m/%Y-%H:%M:%S`][QUESTION] $PLAIN " >> $LOG;;
   "log") echo -e "[`date +%d/%m/%Y-%H:%M:%S`][DEBUG] $PLAIN " >> $LOG;;
  esac
else
  case $TYPE in
    "ok") echo -e "[`date +%d/%m/%Y-%H:%M:%S`][OK] $PLAIN " >> $LOG;;
  "info") echo -e "[`date +%d/%m/%Y-%H:%M:%S`][INFO] $PLAIN " >> $LOG;;
 "alert") echo -e "[`date +%d/%m/%Y-%H:%M:%S`][ATTENTION] $PLAIN " >> $LOG;;
 "error") echo -e "[`date +%d/%m/%Y-%H:%M:%S`][ERROR] $PLAIN " >> $LOG;;
"answer") echo -e "[`date +%d/%m/%Y-%H:%M:%S`][QUESTION] $PLAIN " >> $LOG;;
   "log") echo -e "[`date +%d/%m/%Y-%H:%M:%S`][DEBUG] $PLAIN " >> $LOG;;
  esac
fi
##########################
}


