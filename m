Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41449 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898AbcAMTvC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 14:51:02 -0500
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: sean.stalley@intel.com, bhelgaas@google.com, david.daney@cavium.com
Subject: [PATCH 1/1] Support region sizes that are not power-of-2 in lspci
Date: Wed, 13 Jan 2016 11:47:13 -0800
Message-Id: <1452714433-8144-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enhanced Allocation allows PCI devices to reserve regions with DWORD
granularity. Make sure lspci doesn't tuncate least significant bits
of the region size.

ex: a 2000 byte region should display [size=2000] instead of [size=1K]
Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 lspci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lspci.c b/lspci.c
index fe7b7fe..d483f3a 100644
--- a/lspci.c
+++ b/lspci.c
@@ -336,7 +336,7 @@ show_size(pciaddr_t x)
   if (!x)
     return;
   for (i = 0; i < (sizeof(suffix) / sizeof(*suffix) - 1); i++) {
-    if (x < 1024)
+    if (x % 1024)
       break;
     x /= 1024;
   }
@@ -366,7 +366,7 @@ show_bases(struct device *d, int cnt)
 	putchar('\t');
       if (pos && !flg)			/* Reported by the OS, but not by the device */
 	{
-	  printf("[virtual] ");
+	  printf("[virtual] ");		/* could also be enhanced */
 	  flg = pos;
 	  virtual = 1;
 	}
-- 
1.9.1

