%module rutmp
%{
#include <utmp.h>
%}
%include "bits_utmp.i"
%include "utmp.i"

// vim: filetype=c 
