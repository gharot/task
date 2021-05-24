# APP 2

## Popis problému

* z logu aplikace bylo zřejmé, že se nemůže připojit do databáze
* port v SVC/ingrerssu se kryl s portem, který jsem již měl nastaven (nejspíš jde o náhodu)

## Postup

* podíval jsem se na deployment, jaké hodnoty jsou u proměnných nastavené.
* podíval jsem se na SVC/Ingress na nastavený port

## Řešení

* zedivoal jsem values pro proměnné host a password, tak aby odpovídali realite
* port v SVC/ingress jsem změnil na 2000

Aplikace mě hezky pozdravila z prohlížeče:

```txt
Hello! I am database verion: ('PostgreSQL 11.12 on x86_64-pc-linux-gnu, compiled by gcc (Debian 8.3.0-6) 8.3.0, 64-bit',)
```

### Lepší řešení

* celou část env: přepsat pomocí configmap/secretů, tak jak to mám u ostatních aplikací