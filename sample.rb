require 'pry'
require './SVClient/GCWebPos'
require './SVClient/SVProperties'

webposprops = SVProperties.new({
              'serverURL' => 'http://google.com',
              'ForwardingEntityId' => 'fEI',
              'ForwardingEntityPwd' => 'fEP',
              'TerminalId' => 'tI',
              'UserId' => 'u',
              'Password' => 'p'
           })

GCWebPos.initlibrary webposprops
