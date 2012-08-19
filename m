Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy12-pub.bluehost.com ([50.87.16.10]:46039 "HELO
	oproxy12-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750759Ab2HSAhz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 18 Aug 2012 20:37:55 -0400
Message-ID: <50303561.4020707@xenotime.net>
Date: Sat, 18 Aug 2012 17:37:53 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: [PATCH] pci: fix drivers/pci/pci.c kernel-doc warnings
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warnings in drivers/pci/pci.c:

Warning(drivers/pci/pci.c:1550): No description found for parameter 'pci_dev'
Warning(drivers/pci/pci.c:1550): Excess function parameter 'dev' description in 'pci_wakeup'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Bjorn Helgaas <bhelgaas@google.com>
Cc:	linux-pci@vger.kernel.org
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-36-rc2.orig/drivers/pci/pci.c
+++ lnx-36-rc2/drivers/pci/pci.c
@@ -1543,7 +1543,7 @@ void pci_pme_wakeup_bus(struct pci_bus *
 
 /**
  * pci_wakeup - Wake up a PCI device
- * @dev: Device to handle.
+ * @pci_dev: Device to handle.
  * @ign: ignored parameter
  */
 static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
