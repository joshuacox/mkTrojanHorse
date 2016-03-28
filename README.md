# mkTrojanHorse

This will make a linux machine into a Trojan Horse, 
and by that I mean we'll add a line to rc.local 
that starts autossh to create a reverse tunnel
This enables you to connect back to this machine no matter where it pops 
up on the internet at large, despite its many nefarious uses, this is my preferred method
for accessing a raspberryPi remotely when you put it up behind a consumer internet connection
i.e. dynamic IP address and NAT firewall
I, also, put this sort of thing on my mom's computer so that I can update her machine or give 
her other tech support from afar.

### Usage

Just just use the default recipe

```
make trojan
```

you will be prompted for everything else.


### NSFW

This is Not Safe For Work, it is very appropriate in certain situation and can be used without punity,
but make sure both management and the heads of IT understand and give you permission for this one
BEFORE you implement this.

My intended use is to be able to log into a remote raspberryPi and pull down updated code, reconfigure things, etc.
This can also be used to break into corporate firewalls so you can chat like you are at work after you've gone home
and other nasty uses, so it's best to be very clear about usage with the owners of any network before implementing this.

That being said, it is also really hard to detect and prove, as you cannot distinguish this connection
from another outbound ssh connection to the same machine that does not have the reverse tunnel inside of it.

However, if someone has access to the internal machine a quick `ps aux|grep ssh` will show something like this:

```
 root       283  0.0  0.1   1724  1192 ?        Ss   13:46   0:00 /usr/lib/autossh/autossh -M 66666 -N    -o PubkeyAuthentication=yes -o PasswordAuthentication=no -i /root/.ssh/id_ecdsa -R 
```

There are many other ways your own machine can rat you out. 

You've been warned, use this on machines and networks that you are the owner/administrator of only to be safe.

For example, the opposite seems totally appropriate to me, 
i.e. not to access work computers from home, but rather to access home computers from work.
e.g. if you were to access a raspberryPi on your home network
from behind a dynamic IP + NAT firewall using this method from your work computer. Say to mount your music collection
via sshfs.  But again, if in doubt talk to your management.

### ~/.ssh/config additions

I leave [this](https://github.com/joshuacox/octossh) docker container up on a static IP, and that is my remote jump box
it usually runs on a nonstandard port (i.e. like 2222), 

```
docker run -it -e -p22:2222 KEY_URL=https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/keys joshuacox/octossh
```

Notice you can fork my 'keys' repo and remove all the keys, or create your own where there is a file 'keys' that contains
valid ssh keys

Now when you `make trojan` the remote ssh host information will be for the above jump box

###### For more related errata:
[joshuacox.github.io](http://joshuacox.github.io/)
