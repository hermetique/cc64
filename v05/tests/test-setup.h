
#include "rt-c64-0801.h"

extern _chrout() *= 0xffd2 ;

int puts(s)
char *s;
{
  while(*s != 0)
     _chrout(*s++);
}

extern int __chkout() *= 0xffc9 ;

int _chkout(lfn)
int lfn;
{ return(__chkout(lfn<<8)); }

extern int _close() *= 0xffc3 ;
extern _clrchn() *= 0xffcc ;
extern char __open() *= 0xffc0 ;

extern char _kernal_fnam_len /= 0xb7;
extern char _kernal_lfn /= 0xb8;
extern char _kernal_sa /= 0xb9;
extern char _kernal_fa /= 0xba;
extern int _kernal_fnam /= 0xbb;

int _open(lfn, fa, sa, fnam)
char lfn, fa, sa;
char *fnam;
{
  char *p;
  for(p=fnam; *p; ++p);
  _kernal_fnam_len = p-fnam;
  _kernal_lfn = lfn;
  _kernal_fa = fa;
  _kernal_sa = sa;
  _kernal_fnam = fnam;
  return(__open());
}