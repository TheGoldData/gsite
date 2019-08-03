#!/bin/sh

PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`

[ -z "$GOLDSITE_HOME" ] && GOLDSITE_HOME=`cd "$PRGDIR/.." >/dev/null; pwd`

. "$GOLDSITE_HOME/bin/setclasspath.sh"

export GOLDSITE_HOME

_EXECJAVA=$_RUNJAVA

MAINCLASS=com.xst.golddata.AdminPasswdRecover
CLASSPATH=.:$GOLDSITE_HOME/libs/install-guide.jar
eval exec $_EXECJAVA -Dgoldsite.home="\"$GOLDSITE_HOME\"" -classpath $CLASSPATH $MAINCLASS

