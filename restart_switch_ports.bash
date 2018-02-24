#交互时需使用expect环境及命令, 先安装expect
#指定expect路径及环境
#!/usr/bin/expect

spawn ssh root@10.1.130.xx #用spawn使用bash环境命令
expect "password:" #待出现特定字符串时
send "wwwww\r" #发送命令并回车
after 200
expect "01>"
send "enable\r"
after 100
send "configure terminal\r"
after 100
send "interface range gigabitethernet 1/0/1-36\r"
after 100
send "shutdown\r"
after 20000
send "no shutdown\r"
after 200
send "logout\r"