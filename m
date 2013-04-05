Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:50393 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161463Ab3DECyq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Apr 2013 22:54:46 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 22:54:45 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1677E38C801A
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 22:54:38 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r352sbej347492
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 22:54:38 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r352sbfM009593
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 20:54:37 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 1/4] PCI: Cache MSI/MSI-X cap in PCI device
Date: Fri,  5 Apr 2013 10:54:30 +0800
Message-Id: <1365130473-7413-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch caches the MSI and MSI-X capability offset in PCI device
(struct pci_dev) so that we needn't poll it from the config space
upon enabling or disabling MSI or MSI-X interrupts. Besides, the
data type of cached PM capability (pm_cap), which is PCI stuff
intead of PCIe stuff, in pci_dev has been changed to "u8" according
to Bjorn's suggestion.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c   |   43 ++++++++++++++++++++-----------------------
 include/linux/pci.h |    4 +++-
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 00cc78c..5fdc5d9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -111,32 +111,26 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq)
 }
 #endif
 
-static void msi_set_enable(struct pci_dev *dev, int pos, int enable)
+static void msi_set_enable(struct pci_dev *dev, int enable)
 {
 	u16 control;
 
-	BUG_ON(!pos);
-
-	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	control &= ~PCI_MSI_FLAGS_ENABLE;
 	if (enable)
 		control |= PCI_MSI_FLAGS_ENABLE;
-	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
 static void msix_set_enable(struct pci_dev *dev, int enable)
 {
-	int pos;
 	u16 control;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos) {
-		pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
-		control &= ~PCI_MSIX_FLAGS_ENABLE;
-		if (enable)
-			control |= PCI_MSIX_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
-	}
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
+	control &= ~PCI_MSIX_FLAGS_ENABLE;
+	if (enable)
+		control |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 }
 
 static inline __attribute_const__ u32 msi_mask(unsigned x)
@@ -402,7 +396,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	pos = entry->msi_attrib.pos;
 
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, pos, 0);
+	msi_set_enable(dev, 0);
 	arch_restore_msi_irqs(dev, dev->irq);
 
 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
@@ -557,7 +551,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	unsigned mask;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	msi_set_enable(dev, pos, 0);	/* Disable MSI during set up */
+	msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	/* MSI Entry Initialization */
@@ -598,7 +592,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	/* Set MSI enabled bits	 */
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, pos, 1);
+	msi_set_enable(dev, 1);
 	dev->msi_enabled = 1;
 
 	dev->irq = entry->irq;
@@ -885,7 +879,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	desc = list_first_entry(&dev->msi_list, struct msi_desc, list);
 	pos = desc->msi_attrib.pos;
 
-	msi_set_enable(dev, pos, 0);
+	msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msi_enabled = 0;
 
@@ -1048,15 +1042,18 @@ EXPORT_SYMBOL(pci_msi_enabled);
 
 void pci_msi_init_pci_dev(struct pci_dev *dev)
 {
-	int pos;
 	INIT_LIST_HEAD(&dev->msi_list);
 
 	/* Disable the msi hardware to avoid screaming interrupts
 	 * during boot.  This is the power on reset default so
 	 * usually this should be a noop.
 	 */
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (pos)
-		msi_set_enable(dev, pos, 0);
-	msix_set_enable(dev, 0);
+	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (dev->msi_cap)
+		msi_set_enable(dev, 0);
+
+	/* We needn't check if we have valid MSI-X capability here */
+	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (dev->msix_cap)
+		msix_set_enable(dev, 0);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..3e23895 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -249,7 +249,9 @@ struct pci_dev {
 	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
-	int		pm_cap;		/* PM capability offset in the
+	u8		msi_cap;	/* MSI capability offset */
+	u8		msix_cap;	/* MSI-X capability offset */
+	u8		pm_cap;		/* PM capability offset in the
 					   configuration space */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-- 
1.7.5.4

