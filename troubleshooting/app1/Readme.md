# APP 2

## Popis problému

* failovani probu
* nedostatek maximalnin alokovane paměti

## Postup

* podíval jsem se na deployment, jaké hodnoty jsou nastavené u r/l prob.
* Když mi pod padl na OOM, tak sem zbystřil, zároveň jsem kontroloval logy

## Řešení

* proby jsem z "HTTP probe" přepsal na "Exec proble". Http probe, dle mého nedává u této aplikace nedává žádny smysl.
* hodnotu u resources.limits.memory jsem nastavil na 1600Mi (Nez jsem resouurcy navýšil, tak jsem si ověřil v grafaně, že mnám dostatek prostředků). Což mi zajistilo dostatek paměti k tomu, aby celý pythonovksý script doběhl.

```log
Iteration # 1 of another 256MB of memory tested ...
Iteration # 2 of another 256MB of memory tested ...
Iteration # 3 of another 256MB of memory tested ...
Iteration # 4 of another 256MB of memory tested ...
Iteration # 5 of another 256MB of memory tested ...
Memory test finished!
```

### Lepší řešení

* Místo kind: Deployment bych zvoil kind: Job. Pokud se nepletu, tak script dojede a skončí, což spíše odpovídá jobu. Zároveň by se tím zamezilo opakovanému restartování.
