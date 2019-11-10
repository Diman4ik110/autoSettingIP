#Переменные для программы
#----------------------------------

#Для сохранения порта 
$current = 0
#Для списка com-портов
$coms = 0
#Команда для d-link
$command = "show fdb port "
#Логин администратора домена
$ADLogin = ""
#Пароль администратора домена
$ADPass = ""
#Логин от коммутатора
$SWLogin = "admin"
#Пароль от коммутатора
$SWPAss = "7550055"
#Шаблон имени компьютера кабинета Пример: kab512comp
$kabNumber = "kab512comp"
#Шаблон IP адреса, меняются последние два октета
$ipMaska = "192.168.1."
#Начальное число последнего октета
$startNum = 65
#Массив для mac-адресов
$macs[14] = @()
#Массив для IP
$ips[14] = @()
#Массив для имен
$names[14] = @()

#----------------------------------
#Инициализация программы
#----------------------------------

cls
$coms = Get-WmiObject Win32_SerialPort
$spisok = "1." + $coms.Name
echo "------------------------------------"
echo "Доступные консольные порты: "
$spisok
echo "------------------------------------"
#$current = Read-Host -Prompt "Введите номер"
#$port= new-Object System.IO.Ports.SerialPort $coms[$current-1].Name,9600,None,8,one
$Credential = Get-Credential
$Comp = Get-WmiObject Win32_ComputerSystem -ComputerName $OldName -Authentication 6
$OS   = Get-WmiObject Win32_OperatingSystem -ComputerName $OldName
$arp = arp -a
$arp
#----------------------------------
#Получение списка MAC-адресов по порядку портов
#----------------------------------

#$port.open()
#for ($i = 0; $i -lt 15; $i++){
#    $port.Read()
#}
#$port.Close()

#----------------------------------
#Получение IP-адресов
#----------------------------------

#for($i=0;$i -lt 15; $i++){
#    ips[$i] = (Get-NetNeighbor -LinkLayerAddress macs[$i] -AddressFamily IPv4).IPAddress
#}

#----------------------------------
#Переименование компьютеров и смена IP-адреса
#----------------------------------

$Comp.Rename($NewName,$Credential.GetNetworkCredential().Password,$Credential.Username)
$OS.Reboot()

#----------------------------------