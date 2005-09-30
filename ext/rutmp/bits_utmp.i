/* The `struct utmp' type, describing entries in the utmp file.  GNU version.
   Copyright (C) 1993, 1996, 1997, 1998, 1999, 2002
   Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */


#define UT_LINESIZE	32
#define UT_NAMESIZE	32
#define UT_HOSTSIZE	256


/* The structure describing an entry in the database of
   previous logins.  */
struct lastlog
  {
    int ll_time;
    char ll_line[UT_LINESIZE];
    char ll_host[UT_HOSTSIZE];
  };


/* The structure describing the status of a terminated process.  This
   type is used in `struct utmp' below.  */
struct exit_status
  {
    short int e_termination;	/* Process termination status.  */
    short int e_exit;		/* Process exit status.  */
  };

/* The structure describing an entry in the user accounting database.  */
struct utmp
{
  short int ut_type;		/* Type of login.  */
  int ut_pid;			/* Process ID of login process.  */
  char ut_line[UT_LINESIZE];	/* Devicename.  */
  char ut_id[4];		/* Inittab ID.  */
  char ut_user[UT_NAMESIZE];	/* Username.  */
  char ut_host[UT_HOSTSIZE];	/* Hostname for remote login.  */
  struct exit_status ut_exit;	/* Exit status of a process marked
				   as DEAD_PROCESS.  */

  int ut_session;		/* Session ID, used for windowing.  */
  struct
  {
    int tv_sec;		/* Seconds.  */
    int tv_usec;		/* Microseconds.  */
  } ut_tv;			/* Time entry was made.  */

  int ut_addr;
};

/* Values for the `ut_type' field of a `struct utmp'.  */
#define EMPTY		0	/* No valid user accounting information.  */

#define RUN_LVL		1	/* The system's runlevel.  */
#define BOOT_TIME	2	/* Time of system boot.  */
#define NEW_TIME	3	/* Time after system clock changed.  */
#define OLD_TIME	4	/* Time when system clock changed.  */

#define INIT_PROCESS	5	/* Process spawned by the init process.  */
#define LOGIN_PROCESS	6	/* Session leader of a logged in user.  */
#define USER_PROCESS	7	/* Normal process.  */
#define DEAD_PROCESS	8	/* Terminated process.  */

#define ACCOUNTING	9

/* Old Linux name for the EMPTY type.  */
#define UT_UNKNOWN	EMPTY


// vim:filetype=c
