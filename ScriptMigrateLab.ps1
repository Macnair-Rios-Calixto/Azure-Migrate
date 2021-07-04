# Instalar o Hyper-V
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart

## Preparando a rede do Hyper-V 
# Criar um novo Switch em modo NAT
New-VMSwitch -Name "InternalSwitchNAT" -SwitchType Internal

# Checcando os indexes das interfaces de rede
Get-NetAdapter

# Configure o IP address para a vEthernet (InternalSwitchNAT)
New-NetIPAddress -IPAddress 192.168.1.1 -PrefixLength 24 -InterfaceIndex 20

# Criar um novo virtual network e definir o endereço
New-NetNat -Name "InternalNATnet" -InternalIPInterfaceAddressPrefix 192.168.1.0/24

# Configurando a regra de NAT no Firewall 
New-NetFirewallRule -RemoteAddress 192.168.1.0/24 -DisplayName "Allow-NAT-Hyper-V" -Profile Any -Action Allow

# Definir o IP para as VMs clientes
#VM-WEB01
IP address 192.168.1.10
Mask 255.255.255.0
Default gateway: 192.168.1.1 <vEthernet (InternalSwitchNAT>
DNS Server1: 8.8.8.8
DNS Server2: 192.168.1.1 <vEthernet (InternalSwitchNAT>
