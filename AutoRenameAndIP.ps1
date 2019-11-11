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
$SSHSession = New-SSHSession -ComputerName 192.168.1.15 -Credential $(Get-Credential) -Verbose
$SSH = $SSHSession | New-SSHShellStream
#$Credential = Get-Credential
#$Comp = Get-WmiObject Win32_ComputerSystem -ComputerName $OldName -Authentication 6
#$OS   = Get-WmiObject Win32_OperatingSystem -ComputerName $OldName
#----------------------------------
#Получение списка MAC-адресов по порядку портов
#----------------------------------

for ($i = 1; $i -lt 15; $i++){
    $command = "sh fdb port ${i}"
    $SSH.WriteLine($command)
    $answer = $SSH.read()
    $answer
    $macs[$i] = $answer.Substring(229,17)
}
$macs

#----------------------------------
#Получение IP-адресов
#----------------------------------

#for($i=0;$i -lt 15; $i++){
#    ips[$i] = (Get-NetNeighbor -LinkLayerAddress macs[$i] -AddressFamily IPv4).IPAddress
#}

#----------------------------------
#Переименование компьютеров и смена IP-адреса
#----------------------------------

#$Comp.Rename($NewName,$Credential.GetNetworkCredential().Password,$Credential.Username)
#$OS.Reboot()

#----------------------------------