#!/usr/bin/env python2
# -*- coding: utf-8 -*-
from functools import wraps
import ConfigParser as configparser
import db
import os

class Base(object):
    def __init__(self, dbfile, configfile):
        self.config = configparser.ConfigParser()
        self.config.read(configfile)
        self.dbfile = dbfile
    
    def load_db(mode):
        def fnct(f):
            @wraps(f)
            def f2(f_, *args, **kwargs):
                self = args[0]
                self.db = db.SQLite(self.dbfile)
                return f(f_, *args, **kwargs)
            return f2
        return fnct
    
    def _sync_repo(self, section, server):
        self.db.
    
    @load_db
    def sync(self, force=False):
        for section in self.config.sections():
            if section in ['master']: continue
            if 'Server' in self.config.options(section):
                server = self.config.get(section, 'Server')
            self._sync_repo(section, server)
        
    
if __name__ == '__main__':
    config = configparser.ConfigParser()
    config.read('options.cfg')
    db_file = config.get('options', 'db_file')
    configfile = config.get('options', 'configfile')
    if not os.path.exists(db_file):
        db.create_db(db_file)
    base = Base()