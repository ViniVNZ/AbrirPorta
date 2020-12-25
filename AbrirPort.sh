    #!/bin/bash

    RED='\033[31;1m'
    GREEN='\033[32;1m'
    BLUE='\033[34;1m'
    YELLOW='\033[33;1m'
    END='\033[m'

    ARG1=$1
    ARG2=$2


    trap __Ctrl_c__ INT

    __Ctrl_c__() {
        __ClearFolder__
        echo -e "${RED}\n\nAção abortada!\n\n${END}"
        exit 1
    }

    __Banner__() {
        echo
        echo -e "${YELLOW}#################################################################################${END}"
        echo -e "${YELLOW}#                                                                               #${END}"
        echo -e "${YELLOW}#                            ABRIRPORTA                                         #${END}"
        echo -e "${YELLOW}#                             By: Vszn                                          #${END}"
        echo -e "${YELLOW}#                                                                               #${END}"
        echo -e "${YELLOW}#################################################################################${END}"
        echo
        echo -e "Usar: ${GREEN}$0${END} ${YELLOW}[Porta] ${BLUE}[TIPO]"
        echo -e "Exemplo: ${GREEN}$0${END} 8080 tcp"
        echo
    }

    __Verification__() {

        if [ "$ARG1" == "" ]; then
            __Banner__
            exit 1
        elif [[ "$ARG2" == "" ]]; then
            __Banner__
            exit 1
        fi
    }
    __Abrir__(){

        echo -e "Abrindo ${YELLOW}INPUT${END}, Tipo ${RED}${ARG2}${END}, Porta ${GREEN}${ARG1}${END}"
        iptables -A INPUT -p ${ARG2} --dport ${ARG1} -j ACCEPT
        iptables -A INPUT -p ${ARG2} --sport ${ARG1} -j ACCEPT

        echo -e "Abrindo ${YELLOW}OUTPUT${END}, Tipo ${RED}${ARG2}${END}, Porta ${GREEN}${ARG1}${END}"
        iptables -A OUTPUT -p ${ARG2} --dport ${ARG1} -j ACCEPT
        iptables -A OUTPUT -p ${ARG2} --sport ${ARG1} -j ACCEPT

        echo -e "Abrindo ${YELLOW}FORWARD${END}, Tipo ${RED}${ARG2}${END}, Porta ${GREEN}${ARG1}${END}"
        iptables -A FORWARD -p ${ARG2} --dport ${ARG1} -j ACCEPT
        iptables -A FORWARD -p ${ARG2} --sport ${ARG1} -j ACCEPT
    }


    __Main__() {
    __Verification__

    __Abrir__
    }



    __Main__


