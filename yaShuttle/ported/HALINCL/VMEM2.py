#!/usr/bin/env python3
'''
License:    The author, Ron Burkey, declares this program to be in the Public
            Domain, and may be used or modified in any way desired.
Filename:   VMEM2.py
Purpose:    This is part of the port of the original XPL source code for 
            HAL/S-FC into Python.
Contact:    The Virtual AGC Project (www.ibiblio.org/apollo).
History:    2023-09-22 RSB  Began porting process from XPL.
'''

from HALINCL.VMEM1 import *
import g
import HALINCL.COMMON as h

'''
 VIRTUAL MEMORY DECLARES FOR THE XPL PROGRAMMING SYSTEM
 EDIT LEVEL 002             23 AUGUST 1977         VERSION 1.1

 THE FOLLOWING DECLARES MUST PRECEDE THE INCLUSION OF THIS MEMBER:
   DECLARE VMEM_FILE# LITERALLY '6',
           VMEM_TOTAL_PAGES LITERALLY '399',
           VMEM_PAGE_SIZE LITERALLY '1024',
           VMEM_LIM_PAGES LITERALLY '2';

  ... WHERE VMEM_FILE# IS THE LOGICAL NUMBER OF THE XPL FILE TO BE
     USED FOR THE VIRTUAL MEMORY, VMEM_TOTAL_PAGES IS THE MAXIMUM
     ALLOWABLE NUMBER OF BLOCKS IN THE VIRTUAL MEMORY (LESS 1),
     VMEM_PAGE_SIZE IS THE PHYSICAL SIZE OF A VIRTUAL MEMORY BLOCK
     (IN BYTES), AND VMEM_LIM_PAGES IS THE MAXIMUM ALLOWABLE NUMBER
     OF IN-CORE "SLOTS" (ALSO LESS 1).

 INITIALIZATION PROCEDURES: THE FOLLOWING TYPE OF CODE SEQUENCE SHOULD
 BE USED ---
         CALL VMEM_INIT;
         DO I = 0 TO VMEM_MAX_PAGE;
            VMEM_PAD_PAGE(I) = -1;
            CALL STORAGE_MGT(ADDR(VMEM_PAD_ADDR(I)),VMEM_PAGE_SIZE);
         END;
'''

VMEM_LOC_PTR = 0                        # LAST LOCATED VIR. MEM. PTR
VMEM_LOC_ADDR = 0                       # LAST LOCATED VIR. MEM. ADDR
VMEM_LOC_CNT = 0                        # NUMBER OF VIR. MEM. LOCATES
VMEM_READ_CNT = 0                       # NUMBER OF VIR. MEM. READS
VMEM_WRITE_CNT = 0                      # NUMBER OF VIR. MEM. WRITES
VMEM_RESV_CNT = 0                       # NUMBER OF VIR. MEM. RESERVES
VMEM_PRIOR_PAGE = 0                     # LAST LOCATED PAGE NUMBER
VMEM_LOOK_AHEAD_PAGE = 0                # PAGE BEING READ INTO
VMEM_MAX_PAGE = 0                       # NUMBER OF ACTUAL INCORE PAGES
VMEM_LAST_PAGE = 0                      # ACTUAL LAST PAGE
VMEM_OLD_NDX = 0                        # INDEX OF LAST LOCATED PAGE
VMEM_LOOK_AHEAD = 0                     # 1 --> LOOK AHEAD STATE

VMEM_PAD_PAGE = [0] * (VMEM_LIM_PAGES + 1)            # VIR. MEM. PAGE NUMBER
VMEM_PAD_ADDR = [0] * (VMEM_LIM_PAGES + 1)            # VIR. MEM. PAGE ADDRESS
VMEM_PAD_DISP = [0] * (VMEM_LIM_PAGES + 1)            # MODIFY BIT & RESV CNT
VMEM_PAD_CNT = [0] * (VMEM_LIM_PAGES + 1)             # USAGE COUNTER
VMEM_PAGE_TO_NDX = [0] * (VMEM_TOTAL_PAGES + 1)       # PAGE TO INDEX
VMEM_PAGE_AVAIL_SPACE = [0] * (VMEM_TOTAL_PAGES + 1)

# FLAG DEFINITIONS

MODF = 0x04       # VIR. MEM. PAGE IS MODIFIED
RESV = 0x01       # RESERVE VIR. MEM. PAGE IN CORE
RELS = 0x02       # RELEASE VIR. MEM. PAGE

