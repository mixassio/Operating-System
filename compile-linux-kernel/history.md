# Процесс пересборки ядра
## Подготовка
### Первоначальная версия системы
```
[vagrant@10 ~]$ uname -a
Linux 10.0.2.15 3.10.0-862.14.4.el7.x86_64 #1 SMP Wed Sep 26 15:12:11 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
[vagrant@10 ~]$ uname -r
3.10.0-862.14.4.el7.x86_64
```
### Скачиваем и распаковываем ядро
`https://www.kernel.org`

```
vagrant@10 ~]$ cd /vagrant
[vagrant@10 vagrant]$ ls
history.md  linux-4.18.15.tar.xz  Vagrantfile
[vagrant@10 vagrant]$ sudo tar xvfvJ linux-4.18.15.tar.xz -C /usr/src
[vagrant@10 vagrant]$ cd /usr/src/linux-4.18.15/
[vagrant@10 src]$ sudo ln -s linux-4.18.15 linux
```
### Скачиваем необходимые пакеты
```
sudo yum groupinstall "Development Tools"
sudo yum install ncurses-devel
```

## Настройка

### Конфигураци (на все вопросы да и по умолчанию)
```
sudo sh -c 'yes "" | make oldconfig'
```

### Компиляция ядра
```
[vagrant@10 linux]$ sudo make
```

### Сборка ядра
```
sudo make modules_install
sudo make install
```

## Настройка загрузки
### Конфигурирование
```
[vagrant@10 ~]$ sudo grub2-mkconfig
[vagrant@10 ~]$ sudo grub2-set-default 'CentOS Linux 7 (Core), with Linux 4.18.15'
```
### Перезагрузка и проверка версии
```
[vagrant@10 ~]$ exit
192:compile-linux-kernel mixassio$ vagrant reload
192:compile-linux-kernel mixassio$ vagrant ssh
[vagrant@10 ~]$ uname -r
4.18.15
```