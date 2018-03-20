Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-he1eur01on0115.outbound.protection.outlook.com ([104.47.0.115]:8356
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751186AbeCTTVR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 15:21:17 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz, dmonakhov@openvz.org,
        Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Subject: [PATCH v1] lspci: fix printing DeviceName
Date: Tue, 20 Mar 2018 22:20:34 +0300
Message-Id: <1521573634-5635-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit ef6c9ec3a45992d9e7ef4716d444252baf2013e1 pci_fill_info() calls were moved
and the label field is filled after its output.
Before this patch lspci never prints 'DeviceName'.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 lspci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lspci.c b/lspci.c
index b50c76a..748452c 100644
--- a/lspci.c
+++ b/lspci.c
@@ -315,6 +315,8 @@ show_terse(struct device *d)
       word subsys_v, subsys_d;
       char ssnamebuf[256];
 
+      pci_fill_info(p, PCI_FILL_LABEL);
+
       if (p->label)
         printf("\tDeviceName: %s", p->label);
       get_subid(d, &subsys_v, &subsys_d);
@@ -683,7 +685,7 @@ show_verbose(struct device *d)
   show_terse(d);
 
   pci_fill_info(p, PCI_FILL_IRQ | PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES |
-    PCI_FILL_PHYS_SLOT | PCI_FILL_LABEL | PCI_FILL_NUMA_NODE);
+    PCI_FILL_PHYS_SLOT | PCI_FILL_NUMA_NODE);
   irq = p->irq;
 
   switch (htype)
-- 
2.7.4
