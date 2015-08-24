Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33001 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbHXXIS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 19:08:18 -0400
Received: by pacti10 with SMTP id ti10so34159612pac.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2015 16:08:18 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
To: mj@ucw.cz
Cc: linux-pci@vger.kernel.org, Ameya Palande <2ameya@gmail.com>
Subject: [PATCH] pciutils: Fix sysfs_get_string to handle invalid read
Date: Mon, 24 Aug 2015 16:08:10 -0700
Message-Id: <1440457690-14955-1-git-send-email-2ameya@gmail.com>
In-Reply-To: <mj+md-20150824.200753.5883.nikam@ucw.cz>
References: <mj+md-20150824.200753.5883.nikam@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Ameya Palande <2ameya@gmail.com>
---
 lib/sysfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 9f348bb..8f0cabe 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -105,9 +105,17 @@ sysfs_get_string(struct pci_dev *d, char *object, char *buf, int mandatory)
   n = read(fd, buf, OBJBUFSIZE);
   close(fd);
   if (n < 0)
-    a->error("Error reading %s: %s", namebuf, strerror(errno));
+    {
+      if (mandatory)
+        a->error("Error reading %s: %s", namebuf, strerror(errno));
+      return 0;
+    }
   if (n >= OBJBUFSIZE)
-    a->error("Value in %s too long", namebuf);
+    {
+      if (mandatory)
+        a->error("Value in %s too long", namebuf);
+      return 0;
+    }
   buf[n] = 0;
   return 1;
 }
-- 
1.8.3.1

