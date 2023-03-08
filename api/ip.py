from socket import gethostname, gethostbyname_ex


def getip():
    hn = gethostname()
    ip =gethostbyname_ex(hn)
    ipv4 = ip[-1][-1]
    with open("../lib/ip.txt","w") as f:
        f.write(f"http://{ipv4}:5000/")
    return ipv4