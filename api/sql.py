
from sqlalchemy import create_engine , Integer , String,Column,Boolean,and_
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import json

engine = create_engine('postgresql://sathvik:dQequMmP7GfAP8GqiMMCq10dzVnc8Xeu@dpg-cg7ctqt269v5l6127fbg-a.oregon-postgres.render.com/malgionlineclasses',echo=False)
Session = sessionmaker(bind=engine)
session = Session()

Base = declarative_base()

class Student(Base):
    __tablename__ = "student"
    id = Column(Integer,nullable=False,autoincrement=True,primary_key=True)
    username = Column(String(100))
    shille = Column(Integer,default=0)
    password = Column(String(50) )
  
    def disp(self,verbose):
        if verbose:
            print("id : ", self.id)
            print("username : ", self.username)
        return f"id : {self.id}\nusername : {self.username}\nshille : {self.shille}\n"
    # def toJSON(self):
    #     return json.dumps(self, default=lambda o: o.__dict__, 
    #         sort_keys=True, indent=4)
        
class Teacher(Base):
    __tablename__ = "teacher"
    id = Column(Integer,nullable=False,autoincrement=True,primary_key=True)
    username = Column(String(100))
    subject = Column(String(50))
    password = Column(String(50) )
    active = Column(Boolean,default=False)
    link = Column(String(150) )
    def disp(self,verbose):
        if verbose:
            print("id : ", self.id)
            print("username : ", self.username)
            print("subject : ", self.subject)
            print("active : ", self.active)

        return f"id : {self.id}\nusername : {self.username}\\nsubject : {self.subject}\nactive : {self.active}\n"
    # def toJSON(self):
    #     return json.dumps(self, default=lambda o: o.__dict__, 
    #         sort_keys=True, indent=4)
        
        
        
Base.metadata.create_all(engine)



def getallstudents(verbose):
    datacol =session.query(Student).all()
    docarray = []
    
    scol=''
    for doc in datacol:
        
        s =doc.disp(verbose = verbose)
        docarray.append(doc)
        scol+=s
    return docarray,scol

def getallteachers(verbose):
    datacol =session.query(Teacher).all()
    docarray = []
    
    scol=''
    for doc in datacol:
        
        s =doc.disp(verbose = verbose)
        docarray.append(doc)
        scol+=s
    return docarray,scol


def getactiveteachers(sub):
    datacol =session.query(Teacher).filter( and_(Teacher.active==True,Teacher.subject==sub)).order_by(Teacher.subject).all()
    docarray = []
    
    
    for doc in datacol:
        
        doc.disp(verbose = False)
        docarray.append(doc)
        
    finalret =[]
    
    for doc in docarray:
        obj={}
        obj["username"]  = doc.username  
        obj["link"]  = doc.link  
        obj["id"]  = doc.id  
        finalret.append(obj)
    
    return finalret

def newclass(name,link):
    guy = session.query(Teacher).filter(Teacher.username == name).first()
    guy.active=True
    guy.link = link
    session.commit()
    
def quitclass(name):
    guy = session.query(Teacher).filter(Teacher.username == name).first()
    guy.active=False
    guy.link = None
    session.commit()
    
    
def addshille(un,sh):
    guy = session.query(Student).filter(Student.username == un).first()
    if guy:
        
        guy.shille+=sh
        session.commit()
        return 0
    return -1
    
def getshille(un):
    guy = session.query(Student).filter(Student.username == un).first()
    if guy==None:
        return "-1"
        
    return str(guy.shille)

def reg_as_stud(un,pw):
    a = session.query(Student).filter(Student.username==un).first()
    if (a):
        if(a.password==pw):
            
            return 0
        return -1
    s1 = Student(username = un, password = pw)
    session.add(s1)
    session.commit()
    
def reg_as_tchr(un,pw,sub):
    a = session.query(Teacher).filter(and_(Teacher.username==un,Teacher.subject==sub)).first()
    if (a):
        if a.password==pw:
            
            return 0
        return -1
    t1 = Teacher(username = un, password = pw,subject= sub)
    session.add(t1)
    session.commit()
    
    
