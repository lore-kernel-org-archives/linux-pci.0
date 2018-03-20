Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0119.outbound.protection.outlook.com ([104.47.2.119]:54250
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeCTLuU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 07:50:20 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz, dmonakhov@openvz.org,
        Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Subject: [PATCH] lspci: fix printing label in terse+kernel mode
Date: Tue, 20 Mar 2018 14:49:04 +0300
Message-Id: <1521546544-25027-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit ef6c9ec3a45992d9e7ef4716d444252baf2013e1 pci_fill_info() calls were moved,
but printing label in terse mode with opt_kernel was skipped.
Before this patch lspci -k never prints 'DeviceName'.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 lspci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lspci.c b/lspci.c
index 6b93d9c..1f1e20c 100644
--- a/lspci.c
+++ b/lspci.c
@@ -322,6 +322,9 @@ show_terse(struct device *d)
     }
   putchar('\n');
 
+  if (opt_kernel)
+    pci_fill_info(p, PCI_FILL_LABEL);
+
   if (verbose || opt_kernel)
     {
       word subsys_v, subsys_d;
-- 
2.7.4
