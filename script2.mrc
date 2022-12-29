alias Lond.nickcompletion {
  var %Lond.complete = $1-
  if ( $left($gettok(%Lond.complete,1,32),1) == $chr(167) ) {
    var %Lond.opcode = $right($gettok(%Lond.complete,1,32),-1)
    var %Lond.complete = $deltok(%Lond.complete,1,32)
  }

  if ( $len(%Lond.complete) < 3 ) {
    return %Lond.complete
  }
  var %Lond.x 1
  var %Lond.tam $nick(%Lond.nc.canal,0)
  while ( %Lond.x <= %Lond.tam ) {
    if ( %Lond.complete == $nick(%lond.nc.canal,%Lond.x) ) {
      ;if ( %Lond.opcode == noad) {
        return $nick(%Lond.nc.canal,%Lond.x)
      ;}
      ;return [ %Lond.nc.antes ] $+ $nick(%Lond.nc.canal,%Lond.x) $+ [ %Lond.nc.depois ]
    }
    else if ( %Lond.complete isin $nick(%Lond.nc.canal,%Lond.x) ) {
      var %Lond.nicklist = $addtok(%Lond.nicklist,$nick(%Lond.nc.canal,%Lond.x),32)
    }
    inc %Lond.x
  }
  var %Lond.nicklist = $sorttok(%Lond.nicklist,32,a)
  var %Lond.quantos $numtok(%Lond.nicklist,32)
  if ( %Lond.quantos > 1 ) {
    var %Lond.x 1
    if ( $gettok(%Lond.nicklist,%Lond.x,32) == $me ) {
      inc %Lond.x
    }
    ;if ( %Lond.opcode == noad ) {
      return $gettok(%Lond.nicklist,%Lond.x,32)
    ;}
    ;return [ %Lond.nc.antes ] $+ $gettok(%Lond.nicklist,%Lond.x,32) $+ [ %Lond.nc.depois ]
  }
  else if ( %Lond.quantos == 1 ) {
    ;if ( %Lond.opcode == noad ) {
      return $gettok(%Lond.nicklist,1,32)
    ;}
    ;return [ %Lond.nc.antes ] $+ $gettok(%Lond.nicklist,1,32) $+ [ %Lond.nc.depois ]
  }
  else {
    return %Lond.complete
  }
}
