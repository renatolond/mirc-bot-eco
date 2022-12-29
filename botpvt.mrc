on ^*:TEXT:*:?:{
  var %Lond.comm $strip($1)
  var %Lond.i 0
  while ( %Lond.i < $chan(0) ) {
    inc %Lond.i
    if ( $nick ison $chan(%Lond.i) ) {
      dec %Lond.i
      break
    }
  }
  if ( %Lond.i != $chan(0) ) {
    haltdef
    if ( %Lond.comm == !pvt ) {
      if ( $strip($2) == $null ) {
        .msg $nick Você precisa informar pra quem é a mensagem.
        halt
      }
      var %Lond.x 0
      var %Lond.cid = $cid
      var %Lond.tam = $scon(0)
      while ( %Lond.x < %Lond.tam ) {
        inc %Lond.x
        if ( $scon(%Lond.x).cid != %Lond.cid ) {
          scon %Lond.x
          .msg $strip($2) < $+ [ $nick ] $+ > $3-
        }
      }
      halt
    }
    if ( %Lond.comm == !sess ) {
      if ( $strip($2) == $null ) {
        if ( [ [ $+(%,session.,$cid,., [ $nick ] ) ] ] != $null ) {
          .msg $nick Você está com uma sessão aberta com [ [ $+(%,session.,$cid,., [ $nick ] ) ] ]
        }
        else {
          .msg $nick Você não tem sessão aberta.
        }
        halt
      }
      if ( [ [ $+(%,session.,$cid,., [ $nick ] ) ] ] != $null ) {
        .msg $nick Alterando sua sessão de pvt para $strip($2)
      }
      else {
        .msg $nick Abrindo uma sessão de pvt com $strip($2)
      }
      set $+(%,session.,$cid,., [ $nick ] ) $strip($2)
      halt
    }

    if ( %Lond.comm == !close ) {
      .msg $nick Sua sessão está sendo fechada
      if ( [ [ $+(%,session.,$cid,., [ $nick ] ) ] ] != $null ) {
        unset $+(%,session.,$cid,., [ $nick ] )
      }
    }

    if ( %Lond.comm == !whois ) {
      halt
    }

    if ( [ [ $+(%,session.,$cid,., [ $nick ] ) ] ] != $null ) {
      var %Lond.x 0
      var %Lond.cid = $cid
      var %Lond.tam = $scon(0)
      while ( %Lond.x < %Lond.tam ) {
        inc %Lond.x
        if ( $scon(%Lond.x).cid != %Lond.cid ) {
          scon %Lond.x
          .msg [ [ $+(%,session.,%Lond.cid,., [ $nick ] ) ] ] < $+ [ $nick ] $+ > $1-
        }
      }
      halt
    }
    .msg $nick Desculpe, mas você não tem uma sessão aberta.
    .msg $nick Digite 4!sess 3<nick> para abrir uma ou envie mensagem usando 4!pvt 3<nick> 2<mensagem>
    halt
  }
  .msg $nick Desculpe, é preciso que você esteja em um dos meus canais para poder usar
  .msg $nick minhas funções. :(
}

on ^*:ACTION:*:?:{
  var %Lond.comm $strip($1)
  var %Lond.i 0
  while ( %Lond.i < $chan(0) ) {
    inc %Lond.i
    if ( $nick ison $chan(%Lond.i) ) {
      dec %Lond.i
      break
    }
  }
  if ( %Lond.i != $chan(0) ) {
    haltdef
    if ( [ [ $+(%,session.,$cid,., [ $nick ] ) ] ] != $null ) {
      var %Lond.x 0
      var %Lond.cid = $cid
      var %Lond.tam = $scon(0)
      while ( %Lond.x < %Lond.tam ) {
        inc %Lond.x
        if ( $scon(%Lond.x).cid != %Lond.cid ) {
          scon %Lond.x
          .msg [ [ $+(%,session.,%Lond.cid,., [ $nick ] ) ] ] 6* $nick $1-
        }
      }
      halt
    }
    .msg $nick Desculpe, mas você não tem uma sessão aberta.
    .msg $nick Digite 4!sess 3<nick> para abrir uma ou envie mensagem usando 4!pvt 3<nick> 2<mensagem>
    halt
  }
  .msg $nick Desculpe, é preciso que você esteja em um dos meus canais para poder usar
  .msg $nick minhas funções. :(
}

on *:QUIT:{
  if ( [ [ $+(%,session.,$cid,., [ $nick ] ) ] ] != $null ) {
    unset $+(%,session.,$cid,., [ $nick ] )
  }
}

on *:PART:*:{
  if ( [ [ $+(%,session.,$cid,., [ $nick ] ) ] ] != $null ) {
    unset $+(%,session.,$cid,., [ $nick ] )
  }
}
