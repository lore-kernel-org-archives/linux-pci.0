Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:28750 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3D3HpB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2013 03:45:01 -0400
Date: Tue, 30 Apr 2013 10:44:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] PCI: set ->mask_pos correctly
Message-ID: <20130430074454.GF7237@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The "+" operation has higher precedence than "?:" and ->msi_cap is
always non-zero here so the original statement is equivalent to:

	entry->mask_pos = PCI_MSI_MASK_64;

Which wasn't the intent.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d40bed7..2c10752 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -563,8 +563,10 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.pos		= dev->msi_cap;
 
-	entry->mask_pos = dev->msi_cap + (control & PCI_MSI_FLAGS_64BIT) ?
-		PCI_MSI_MASK_64 : PCI_MSI_MASK_32;
+	if (control & PCI_MSI_FLAGS_64BIT)
+		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
+	else
+		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
 	/* All MSIs are unmasked by default, Mask them all */
 	if (entry->msi_attrib.maskbit)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
