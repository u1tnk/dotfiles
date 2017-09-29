#! /bin/bash

CURRENT=`dirname $0`

/usr/local/bin/xremap $CURRENT/init.rb >> /tmp/xremap.log 2>&1
