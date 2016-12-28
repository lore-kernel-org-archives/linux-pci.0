Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbcL1QZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2016 11:25:05 -0500
To: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] pci: fix msi.c kernel-doc warnings
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <35dfbd78-99a3-39b8-3d67-6f0916d6504e@infradead.org>
Date: Wed, 28 Dec 2016 08:25:04 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in pci/msi.c:

..//drivers/pci/msi.c:623: warning: No description found for parameter 'affd'
..//drivers/pci/msi.c:623: warning: Excess function parameter 'affinity' description in 'msi_capability_init'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/pci/msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-410-rc1.orig/drivers/pci/msi.c
+++ lnx-410-rc1/drivers/pci/msi.c
@@ -610,7 +610,7 @@ static int msi_verify_entries(struct pci
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  * @nvec: number of interrupts to allocate
- * @affinity: flag to indicate cpu irq affinity mask should be set
+ * @affd: description of automatic irq affinity assignments (may be %NULL)
  *
  * Setup the MSI capability structure of the device with the requested
  * number of interrupts.  A return value of zero indicates the successful
