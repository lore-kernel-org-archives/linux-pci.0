Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:50659 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab3H1TOZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 15:14:25 -0400
Received: by mail-yh0-f41.google.com with SMTP id z12so1771923yhz.14
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 12:14:25 -0700 (PDT)
Subject: [PATCH] lspci: Decode PCIe Link registers only for devices with
 links
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ben Hutchings <bhutchings@solarflare.com>,
	linux-pci@vger.kernel.org
Date: Wed, 28 Aug 2013 13:08:34 -0600
Message-ID: <20130828190834.2198.99446.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Root Complex Integrated Endpoints and Root Complex Event Collectors do not
have links and are not permitted to implement Link or Link 2 registers,
per PCIe spec r3.0, sec 1.3.2.3.  Decoding them is useless and misleading.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 752a771..be19d38 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1074,6 +1074,7 @@ cap_express(struct device *d, int where, int cap)
   int type = (cap & PCI_EXP_FLAGS_TYPE) >> 4;
   int size;
   int slot = 0;
+  int link = 1;
 
   printf("Express ");
   if (verbose >= 2)
@@ -1104,9 +1105,11 @@ cap_express(struct device *d, int where, int cap)
       printf("PCI/PCI-X to PCI-Express Bridge");
       break;
     case PCI_EXP_TYPE_ROOT_INT_EP:
+      link = 0;
       printf("Root Complex Integrated Endpoint");
       break;
     case PCI_EXP_TYPE_ROOT_EC:
+      link = 0;
       printf("Root Complex Event Collector");
       break;
     default:
@@ -1125,7 +1128,8 @@ cap_express(struct device *d, int where, int cap)
     return;
 
   cap_express_dev(d, where, type);
-  cap_express_link(d, where, type);
+  if (link)
+    cap_express_link(d, where, type);
   if (slot)
     cap_express_slot(d, where);
   if (type == PCI_EXP_TYPE_ROOT_PORT)
@@ -1141,7 +1145,8 @@ cap_express(struct device *d, int where, int cap)
     return;
 
   cap_express_dev2(d, where, type);
-  cap_express_link2(d, where, type);
+  if (link)
+    cap_express_link2(d, where, type);
   if (slot)
     cap_express_slot2(d, where);
 }

