/*Qualquer variável relacionada a esse módulo é prefixada por %Lond.id.
*/
on *:NOTICE:*:?:{
  if ( %Lond.autoidentify != $null ) {
    if ( ( *caso contr* iswm $1- ) || ( *choose a different nick* iswm $1- ) ) {
      var %Lond.x 0
      var %Lond.tam = $ini(docs/ail.ini,0)
      while ( %Lond.x < %Lond.tam ) {
        inc %Lond.x
        var %Lond.id.info = $ini(docs/ail.ini,%Lond.x)
        if ( $gettok(%Lond.id.info,1,45) == $me && $gettok(%Lond.id.info,2,45) == $network ) {
          nickserv identify $decode($readini(docs/ail.ini,%Lond.id.info,id),m)
          .halt
        }
      }
      echo 5 -ta Você não possui uma senha cadastrada para esse nick. Identifique-se manualmente.
    }
  }
}

alias lond.identify.write {
  var %Lond.id.nick = $gettok($1-,1,32)
  var %Lond.id.rede = $gettok($1-,2,32)
  var %Lond.id.id = $encode($gettok($1-,3,32),m)

  writeini -n docs/ail.ini %Lond.id.nick $+ - $+ %Lond.id.rede id %Lond.id.id
}

alias lond.identify.erase {
  var %Lond.id.nick = $gettok($1-,1,32)
  var %Lond.id.rede = $gettok($1-,2,32)

  remini docs/ail.ini %Lond.id.nick $+ - $+ %Lond.id.rede
}

dialog autoident {
  title "Nickserv: Auto Identify"
  size -1 -1 230 120
  option dbu
  box "Identificados", 1, 2 0 107 118
  check "Ligado", 2, 4 8 27 10
  list 3, 6 31 96 68, size
  text "Nicks sendo identificados ( Nick / Rede )", 4, 7 22 95 8
  button "Remover selecionado", 5, 6 102 65 12
  box "Novo", 6, 110 0 119 97
  text "Ao adicionar um novo nick tenha em mente o nome do servidor que é mostrado no botão de Status quando está conectado. Esse é o nome que você deve colocar em 'rede'. A senha não será visível. ", 7, 113 9 111 34
  text "Nick:", 8, 113 48 12 8
  edit "", 9, 127 47 98 10
  text "Senha:", 10, 113 59 17 8
  edit "", 11, 133 58 92 10, pass
  text "Rede:", 12, 113 70 15 8
  edit "", 13, 131 69 94 10
  button "Adicionar", 14, 150 81 37 12
  button "Salvar e Sair", 15, 189 105 37 12, ok cancel
}

alias lond.autoident {
  dialog -md autoident autoident
  :error
  if ( *name in use* iswm $error ) {
    dialog -v autoident
    reseterror
  }
}

on *:dialog:autoident:*:*:{
  if ( $devent == init && $did == 0 ) {
    var %Lond.x 0
    var %Lond.tam = $ini(docs/ail.ini,0)
    while ( %Lond.x < %Lond.tam ) {
      inc %Lond.x
      did -i $dname 3 %Lond.x $replace($ini(docs/ail.ini,%Lond.x),$chr(45), $chr(32) $+ $chr(47) $+ $chr(32))
    }
    did -a $dname 13 $network
    if ( %Lond.autoidentify != $null ) { did -c $dname 2 }
  }
  if ( $devent == sclick ) {
    if ( $did == 5 ) {
      var %Lond.x = $did($dname,3).sel
      var %Lond.info = $replace($ini(docs/ail.ini,%Lond.x),$chr(45),$chr(32))
      lond.identify.erase %Lond.info
      did -d $dname 3 %Lond.x
    }
    else if ( $did == 14 ) {
      if ( $did($dname,13) != $null && $did($dname,11) != $null && $did($dname,9) != $null ) {
        var %Lond.temp $ini(docs/ail.ini,$did($dname,9) $+ - $+ $did($dname,13))
        if ( %Lond.temp != $null && %Lond.temp != 0 ) {
          if ( $?!="Já existe uma senha para esse nick nessa rede, deseja continuar?" == $false ) {
            dialog -v autoident
            halt
          }
          dialog -v autoident
          lond.identify.write $did($dname,9) $did($dname,13) $did($dname,11)
          did -r $dname 9
          did -r $dname 11
          halt
        }
        lond.identify.write $did($dname,9) $did($dname,13) $did($dname,11)
        did -i $dname 3 $calc($did($dname,3).lines + 1) $did($dname,9) / $did($dname,13)
        did -r $dname 9
        did -r $dname 11
      }
    }
  }
  if ( $devent == close && $did == 0 ) {
    if ( $did($dname,2).state == 1 ) { set %Lond.autoidentify 1 }
    else { unset %Lond.autoidentify }
  }
}
