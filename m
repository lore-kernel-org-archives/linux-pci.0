Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33949 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbHXTcd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 15:32:33 -0400
Received: by pabzx8 with SMTP id zx8so13248962pab.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2015 12:32:33 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH] pciutils: Fix sysfs_get_string to handle invalid read
Date: Mon, 24 Aug 2015 12:32:25 -0700
Message-Id: <1440444745-7560-1-git-send-email-2ameya@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 - Fix minor indentation alignment

Signed-off-by: Ameya Palande <2ameya@gmail.com>
---
 lib/sysfs.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 9f348bb..90ed013 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -99,15 +99,21 @@ sysfs_get_string(struct pci_dev *d, char *object, char *buf, int mandatory)
   if (fd < 0)
     {
       if (mandatory)
-	a->error("Cannot open %s: %s", namebuf, strerror(errno));
+        a->error("Cannot open %s: %s", namebuf, strerror(errno));
       return 0;
     }
   n = read(fd, buf, OBJBUFSIZE);
   close(fd);
-  if (n < 0)
-    a->error("Error reading %s: %s", namebuf, strerror(errno));
-  if (n >= OBJBUFSIZE)
-    a->error("Value in %s too long", namebuf);
+  if (n < 0) {
+    if (mandatory)
+      a->error("Error reading %s: %s", namebuf, strerror(errno));
+    return 0;
+  }
+  if (n >= OBJBUFSIZE) {
+    if (mandatory)
+      a->error("Value in %s too long", namebuf);
+    return 0;
+  }
   buf[n] = 0;
   return 1;
 }
@@ -274,21 +280,21 @@ sysfs_fill_info(struct pci_dev *d, int flags)
       struct pci_dev *pd;
       sysfs_fill_slots(d->access);
       for (pd = d->access->devices; pd; pd = pd->next)
-	pd->known_fields |= PCI_FILL_PHYS_SLOT;
+        pd->known_fields |= PCI_FILL_PHYS_SLOT;
     }
 
   if ((flags & PCI_FILL_MODULE_ALIAS) && !(d->known_fields & PCI_FILL_MODULE_ALIAS))
     {
       char buf[OBJBUFSIZE];
       if (sysfs_get_string(d, "modalias", buf, 0))
-	d->module_alias = pci_strdup(d->access, buf);
+        d->module_alias = pci_strdup(d->access, buf);
     }
 
   if ((flags & PCI_FILL_LABEL) && !(d->known_fields & PCI_FILL_LABEL))
     {
       char buf[OBJBUFSIZE];
       if (sysfs_get_string(d, "label", buf, 0))
-	d->label = pci_strdup(d->access, buf);
+        d->label = pci_strdup(d->access, buf);
     }
 
   return pci_generic_fill_info(d, flags);
-- 
1.8.3.1

