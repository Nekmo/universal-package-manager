import sqlite3

        
class SQLite(object):
    def __init__(self, dbfile):
        self.dbfile = dbfile
        self.conn = sqlite3.connect(dbfile)
        self.c = self.conn.cursor()
        
    def execute(self, code, *args, **kwargs):
        return self.c.execute(code, *args, **kwargs)
        
    def executescript(self, code, *args, **kwargs):
        return self.c.executescript(code, *args, **kwargs)
        
    def commit(self, *args, **args):
        return self.c.commit(*args, **kwargs)
        
    def clsoe(self, *args, **args):
        return self.c.close(*args, **kwargs)
        
def create_db(file):
    d = SQLite(file)
    d.executescript(code)
    d.commit()
    d.close()