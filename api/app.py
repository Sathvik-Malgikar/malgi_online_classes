from flask import Flask,request,redirect,send_from_directory,Response
from flask_cors import CORS,cross_origin
from ip import getip

from sql import getallteachers,getallstudents,getactiveteachers,newclass,addshille,getshille,reg_as_stud,reg_as_tchr,quitclass


app = Flask(__name__)

CORS(app)

@app.after_request
def cmnhdrs(resp):
    if(request.method=="OPTIONS"):
        print("OPTIONS")
    resp.headers['Access-Control-Allow-Methods'] = 'GET,POST,OPTIONS,PUT,HEAD,DELETE'
    resp.headers['Access-Control-Request-Headers']= '*'
    resp.headers['Access-Control-Allow-Origin']= '*'
    return resp


@app.route("/api")
@app.route("/")
@cross_origin()
def home():
    data, datastr = getallstudents(verbose=True)
    datat, datastrt = getallteachers(verbose=True)
    return datastr+datastrt

@app.route("/api/reg_as_std",methods=["GET","POST","OPTIONS"])
@cross_origin()
def regstd():
    if request.method=="GET" :
        return "only post allowed"
    print("recieved at std")
    
    data = request.get_json()
    print(data)
    rcode = reg_as_stud(data["username"],data["password"])
    if rcode==-1:
        return "already taken"
    return "Success"
    
@app.route("/api/reg_as_tchr",methods=["GET","POST","OPTIONS"])
@cross_origin()
def regtchr():
    if request.method=="GET" :
        return "only post allowed"
    print("recieved at tchr")

    data = request.get_json()

    print(data)
    rcode =reg_as_tchr(data["username"] , data["password"] , data["subject"])
    if rcode==-1:
        return "already taken"
    return "Success"
    
@app.route("/api/makecls",methods=["GET","POST","OPTIONS"])
@cross_origin()
def makecls():
    if request.method=="GET" :
        return "only post allowed"
    print("recieved at makecls")

    data = request.get_json()

    print(data)
    newclass(data["username"] , data["class_url"])
    return "Success !"

@app.route("/api/quitcls",methods=["GET","POST","OPTIONS"])
@cross_origin()
def quitcls():
    if request.method=="GET" :
        return "only post allowed"
    print("recieved at quitcls")

    data = request.get_json()

    print(data)
    quitclass(data["username"])
    return "Success !"

@app.route("/api/malgicoin",methods=["GET","POST","OPTIONS"])
@cross_origin()
def malgicoin():
    if request.method=="GET" :
        data = request.args
        return getshille(data["acc"])
    print("recieved at malgicoin")

    data = request.get_json()

    print(data)
    retv = addshille(data["username"],data["amount"])
    if retv==-1:
        return "fail"
    return "Success !"

@app.route("/api/findcls")
@cross_origin()
def findcls():
    
    print("recieved at findcls")

    data = request.args

    # print(data)
    arofdict =  getactiveteachers(data["sub"])
    print(arofdict)
    return arofdict
    


# getip()

if __name__ == "__main__":
    app.run(host='0.0.0.0')
else:
    gunicorn_app = app

