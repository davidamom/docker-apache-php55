
apache-php
===================================

Uma imagem docker baseada em Ubuntu, servindo PHP 5.5 rodando como um Módulo Apache. Útil para webdevs quais precisam de uma versão fixa do PHP. Além, a configuração `error_reporting` em php.ini é configurável por container via variáveis de ambiente.

Tags
-----

* latest: Ubuntu 14.04 (LTS), Apache 2.4, PHP 5.5.9 com suporte para a configuração `error_reporting`

Utilização
------

```
$ docker run -d -P davidamom/apache-php55
```

Com todas as opçõoes:

```bash
$ docker run -d -p 8080:80 \
    -v $HOME/www:/var/www \
    -e PHP_ERROR_REPORTING='E_ALL & ~E_STRICT' \
    davidamom/apache-php55
```

* `-v [diretório local]:/var/www` cria um volume mapeando o diretório webroot do container com o diretório local maps.
* `-p [local port]:80` mapeia uma porta local com a porta HTTP 80 do container.
* `-e PHP_ERROR_REPORTING=[opções de configuração de error_reporting]` seta o valor de `error_reporting` no arquivo php.ini.

### Acessar logs apache

Apache está configurado para mostar os logs de acesso e de erros para STDOUT. Pode-se simplesmente rodar `docker logs` para pegar a saída dos logs:

`docker logs -f id-do-container`


Pacotes instalados
-------------------
* Ubuntu Server 14.04, baseado na imagem do Ubuntu
* apache2
* php5
* php5-cli
* libapache2-mod-php5
* php5-gd
* php5-json
* php5-ldap
* php5-mysql
* php5-pgsql

Configurações
----------------

* Apache: .htaccess-Enabled em webroot (mod_rewrite com AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL & ~E_DEPRECATED & ~E_NOTICE (padrão, mas sobrescrito por variável de ambiente)