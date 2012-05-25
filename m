Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:32478 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758153Ab2EYTRn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 May 2012 15:17:43 -0400
Date: Fri, 25 May 2012 14:11:39 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] lspci: zero address in IO isn't always unassigned
Message-ID: <f0307c62-e3e1-4cb7-a037-f410a12383cb@zimbra>
In-Reply-To: <bf63b3bc-e471-4928-b871-7327f790bca1@zimbra>
Content-Type: text/plain; charset=ISO-8859-1
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Zero is a valid address in I/O space, so display it and it's associated
size when IO is enabled in the PCI command register.

>From arch/powerpc/kernel/pci-common.c:

/* Here, we are a bit different than memory as typically IO space
 * starting at low addresses -is- valid. What we do instead [is] that
 * we consider as unassigned anything that doesn't have IO enabled
 * in the PCI command register, and that's it.
 */

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 lib/sysfs.c |    2 +-
 lspci.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 1ec4afb..2197fab 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -125,7 +125,7 @@ sysfs_get_resources(struct pci_dev *d)
 	break;
       if (sscanf(buf, "%llx %llx %llx", &start, &end, &flags) != 3)
 	a->error("Syntax error in %s", namebuf);
-      if (start)
+      if (end > start)
 	size = end - start + 1;
       else
 	size = 0;
diff --git a/lspci.c b/lspci.c
index 681ef6a..a67a516 100644
--- a/lspci.c
+++ b/lspci.c
@@ -372,7 +372,7 @@ show_bases(struct device *d, int cnt)
 	{
 	  pciaddr_t a = pos & PCI_BASE_ADDRESS_IO_MASK;
 	  printf("I/O ports at ");
-	  if (a)
+	  if (a || (cmd & PCI_COMMAND_IO))
 	    printf(PCIADDR_PORT_FMT, a);
 	  else if (flg & PCI_BASE_ADDRESS_IO_MASK)
 	    printf("<ignored>");
-- 
1.7.0.4
