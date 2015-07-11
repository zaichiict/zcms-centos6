# Auto Install ZCMS 2
ZCMS 2 is a PHP CMS on Phalcon Framework 2.0. See ZCMS in https://github.com/zaichiict/zcms

* PHP 5.6
* Postgresql 9.4
* Nginx
* Redis
* MySql
* Phalcon 2.0.x
* ZCMS Command

## Install Command
*Copy and pate in your terminal*
```
curl https://raw.githubusercontent.com/zaichiict/zcms-centos6/master/install_zcms | sh
```

## Command Instal and Update latest ZCMS
```
# 1. Install
zcms install

# 2. Update latest ZCMS
zcms update
```

## ZCMS Command
```
# 1. Create new project
zcms new {Project Name}
or
zcms create {Project Name}

# 2. Start all service
zcms start

# 3. Stop all service
zcms stop

# 4. Restart all service
zcms restart
```
