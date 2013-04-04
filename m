Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:48207 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759342Ab3DDLjn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Apr 2013 07:39:43 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 07:39:42 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A1EA838C801A
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 07:39:40 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34Bde5I297894
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 07:39:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34BdcG6008578
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 07:39:40 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 1/5] PCI: Cache MSI/MSI-X cap in PCI device
Date: Thu,  4 Apr 2013 19:39:28 +0800
Message-Id: <1365075572-20763-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch caches the MSI and MSI-X capability offset in PCI device
(struct pci_dev) so that we needn't poll it from the config space
upon enabling or disabling MSI or MSI-X interrupts.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c   |   36 +++++++++++++++++++-----------------
 include/linux/pci.h |    2 ++
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 00cc78c..3459bdf 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -111,31 +111,31 @@ void default_restore_msi_irqs(struct pci_dev *dev, int irq)
 }
 #endif
 
-static void msi_set_enable(struct pci_dev *dev, int pos, int enable)
+static void msi_set_enable(struct pci_dev *dev, int enable)
 {
 	u16 control;
 
-	BUG_ON(!pos);
+	BUG_ON(!dev->msi_cap);
 
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
+	if (dev->msix_cap) {
+		pci_read_config_word(dev,
+			dev->msix_cap + PCI_MSIX_FLAGS, &control);
 		control &= ~PCI_MSIX_FLAGS_ENABLE;
 		if (enable)
 			control |= PCI_MSIX_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
+		pci_write_config_word(dev,
+			dev->msix_cap + PCI_MSIX_FLAGS, control);
 	}
 }
 
@@ -402,7 +402,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	pos = entry->msi_attrib.pos;
 
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, pos, 0);
+	msi_set_enable(dev, 0);
 	arch_restore_msi_irqs(dev, dev->irq);
 
 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
@@ -557,7 +557,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	unsigned mask;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	msi_set_enable(dev, pos, 0);	/* Disable MSI during set up */
+	msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	/* MSI Entry Initialization */
@@ -598,7 +598,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	/* Set MSI enabled bits	 */
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, pos, 1);
+	msi_set_enable(dev, 1);
 	dev->msi_enabled = 1;
 
 	dev->irq = entry->irq;
@@ -885,7 +885,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	desc = list_first_entry(&dev->msi_list, struct msi_desc, list);
 	pos = desc->msi_attrib.pos;
 
-	msi_set_enable(dev, pos, 0);
+	msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msi_enabled = 0;
 
@@ -1048,15 +1048,17 @@ EXPORT_SYMBOL(pci_msi_enabled);
 
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
+	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (dev->msi_cap)
+		msi_set_enable(dev, 0);
+
+	/* We needn't check if we have valid MSI-X capability here */
+	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	msix_set_enable(dev, 0);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..f8314c7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -249,6 +249,8 @@ struct pci_dev {
 	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
+	int		msi_cap;	/* MSI capability offset */
+	int		msix_cap;	/* MSI-X capability offset */
 	int		pm_cap;		/* PM capability offset in the
 					   configuration space */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
-- 
1.7.5.4

