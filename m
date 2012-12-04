Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx.treblig.org ([80.68.94.177]:52711 "EHLO mx.treblig.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843Ab2LDOzA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 4 Dec 2012 09:55:00 -0500
Date: Tue, 4 Dec 2012 14:20:08 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: mj@ucw.cz
Cc: linux-pci@vger.kernel.org
Subject: pciutils pci_open seg with invalid arg to -i
Message-ID: <20121204142008.GB6117@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,
  I was looking at a bug reported in the Ubuntu bug database against lspci:

https://bugs.launchpad.net/ubuntu/+source/pciutils/+bug/690431

The reporter had called lspci -vvii    which ends up trying to open the
file 'i' as the pci-id and seg faults.

I can see a fix, but I can't quite see what the code is trying to do;
lib/names-parse.c:

 23 static pci_file pci_open(struct pci_access *a)
 24 {
 25   pci_file result;
 26   size_t len;
 27   char *new_name;
 28 
 29   result = gzopen(a->id_file_name, "rb");
 30   if (result)
 31     return result;
 32   len = strlen(a->id_file_name);
 33   if (len >= 3 && memcmp(a->id_file_name + len - 3, ".gz", 3) != 0)
 34     return result;
 35   new_name = malloc(len - 2);
 36   memcpy(new_name, a->id_file_name, len - 3);
 37   new_name[len - 3] = 0;
 38   pci_set_name_list_path(a, new_name, 1);
 39   return gzopen(a->id_file_name, "rb");
 40 }

The problem here is for a short filename we drop down to line 35 and
do an allocate of a -ve length, and then try and memcpy into it.

So I was going to suggest something like:

 33   if (len < 3 || memcmp(a->id_file_name + len - 3, ".gz", 3) != 0)
 34     return result;

which would mean that it would drop out if it was a short filename; but
then I started to try and understand the code more; it looks to me like:

   try and gzopen it.
   if that fails
     check it ended with a .gz (else fail)
     strip the .gz off the end
     gzopen it without the .gz

But why bother?  According to the zlib manual for gzopen :
  ( http://www.zlib.net/manual.html )
     
' gzopen can be used to read a file which is not in gzip format; in this case
gzread will directly read from the file without decompression. When reading,
this will be detected automatically by looking for the magic two-byte gzip
header. '

So what are lines 32-39 trying to do?

Dave (not subscribed to linux-pci, so please cc)
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
