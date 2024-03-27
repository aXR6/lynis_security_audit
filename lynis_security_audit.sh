#!/bin/bash

# Função para instalar o Lynis
install_lynis() {
    if [ -d "/opt/lynis" ]; then
        echo "O Lynis já está instalado em /opt/lynis."
    else
        echo "Instalando Lynis em /opt..."
        sudo git clone https://github.com/CISOfy/lynis.git /opt/lynis
    fi
}

# Função para executar uma auditoria completa
run_audit() {
    if [ ! -d "/opt/lynis" ]; then
        echo "O Lynis não está instalado. Escolha a opção 1 para instalar."
        return
    fi

    echo "Executando auditoria completa..."
    cd /opt/lynis && sudo ./lynis audit system
}

# Função para verificar atualizações do Lynis
check_updates() {
    if [ ! -d "/opt/lynis" ]; then
        echo "O Lynis não está instalado. Escolha a opção 1 para instalar."
        return
    fi

    echo "Verificando atualizações para o Lynis..."
    cd /opt/lynis && sudo git pull
}

# Função para exibir informações sobre o sistema
show_system_info() {
    if [ ! -d "/opt/lynis" ]; then
        echo "O Lynis não está instalado. Escolha a opção 1 para instalar."
        return
    fi

    echo "Exibindo informações do sistema..."
    cd /opt/lynis && sudo ./lynis show system
}

# Função para listar sistemas suportados
list_supported_systems() {
    echo "Sistemas Operacionais Suportados pelo Lynis:"
    echo "- AIX"
    echo "- FreeBSD"
    echo "- HP-UX"
    echo "- Linux"
    echo "- macOS"
    echo "- NetBSD"
    echo "- OpenBSD"
    echo "- Solaris"
    echo "- e outros Unix-like"
    echo ""
    read -p "Pressione qualquer tecla para voltar ao menu principal..."
}

# Menu principal
while true; do
    echo "Menu de Auditoria de Segurança com Lynis"
    echo "1. Instalar Lynis"
    echo "2. Executar auditoria completa"
    echo "3. Verificar atualizações do Lynis"
    echo "4. Exibir informações do sistema"
    echo "5. Escaneamento oportunista"
    echo "6. Verificações de segurança detalhadas"
    echo "7. Auditoria de segurança"
    echo "8. Testes de conformidade (PCI, HIPAA, SOx)"
    echo "9. Detecção e varredura de vulnerabilidades"
    echo "10. Hardening de sistemas"
    echo "11. Listar sistemas operacionais suportados"
    echo "12. Sair"
    echo -n "Escolha uma opção [1-12]: "
    read option

    case $option in
        1)
            install_lynis
            ;;
        2)
            run_audit
            ;;
        3)
            check_updates
            ;;
        4)
            show_system_info
            ;;
        5|6|7|8|9|10)
            echo "Esta opção executa uma auditoria completa, onde o Lynis automaticamente adapta as verificações ao sistema."
            run_audit
            ;;
        11)
            list_supported_systems
            ;;
        12)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac
done