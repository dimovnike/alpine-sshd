SSHD server. 

use with:

docker run -p<port>:22 -v /path/to/folder/with/authorized\_keys/:/root/.ssh

If you dont provide a folder with authorized\_keys file you will not be able to login.
