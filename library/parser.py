#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import sys
from pyparsing import alphas, alphanums, nums, ZeroOrMore, Word, Group, Suppress, Combine, quotedString

LEVELS = ['#', '=']

class Section(list):
    def __init__(self, name):
        list.__init__(self)
        self.name = name
        self.defs = {}
        self.elems = []
        

class Parser(object):
    def __init__(self):
        self.sections = {}
        self.levels_sections = []
        
        def_ = Group(Combine(Word(alphanums) + Suppress(": ")) + Word(quotedString))
        self.record = def_
    
    def feedfile(self, fp):
        lines = fp.readlines()
        i = 0
        for line in lines:
            if lines[i + 1] and lines[i + 1][0] in LEVELS:
                # Es una sección
                for level in LEVELS:
                    if not level == lines[i + 1][0]: continue
                    index = LEVELS.index(level)
                    if index < len(self.levels_sections) - 1:
                        # Se cierran los niveles anteriores del árbol
                        self.levels_sections = self.levels_sections[0:index]
                    section = Section(line)
                    if self.levels_sections:
                        self.levels_sections[-1].append(section)
                    self.levels_sections.append(section)
            else:
                try:
                    res = self.record.parseString(line)
                except:
                    res = ''
                print(res)
            i += 1

if __name__ == '__main__':
    parser = Parser()
    parser.feedfile(open(sys.argv[1]))