Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60362 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeA3KeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 05:34:18 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] Fix Vector table and PBA addresses print output
Date: Tue, 30 Jan 2018 10:34:08 +0000
Message-Id: <998ca55d1a2b9a7f6912dcff69bc57d31b690fb0.1517308416.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lack of 3-bit rotation to the right was leading to erroneous display of the
vector table and PBA.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 ls-caps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 507771a..cd13a37 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1104,10 +1104,10 @@ cap_msix(struct device *d, int where, int cap)
 
   off = get_conf_long(d, where + PCI_MSIX_TABLE);
   printf("\t\tVector table: BAR=%d offset=%08x\n",
-	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
+	 off & PCI_MSIX_BIR, (off & ~PCI_MSIX_BIR) >> 3);
   off = get_conf_long(d, where + PCI_MSIX_PBA);
   printf("\t\tPBA: BAR=%d offset=%08x\n",
-	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
+	 off & PCI_MSIX_BIR, (off & ~PCI_MSIX_BIR) >> 3);
 }
 
 static void
-- 
2.7.4
