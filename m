Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdBANlx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2017 08:41:53 -0500
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/portdrv: use pci_irq_alloc_vectors
Date: Wed,  1 Feb 2017 14:41:43 +0100
Message-Id: <1485956503-8194-3-git-send-email-hch@lst.de>
In-Reply-To: <1485956503-8194-1-git-send-email-hch@lst.de>
References: <1485956503-8194-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

And greatly simplify the code by managing the vector number for the
subservices directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pcie/portdrv_core.c | 161 ++++++++++++----------------------------
 1 file changed, 48 insertions(+), 113 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 9698289..cea504f 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -44,52 +44,16 @@ static void release_pcie_device(struct device *dev)
 }
 
 /**
- * pcie_port_msix_add_entry - add entry to given array of MSI-X entries
- * @entries: Array of MSI-X entries
- * @new_entry: Index of the entry to add to the array
- * @nr_entries: Number of entries already in the array
- *
- * Return value: Position of the added entry in the array
- */
-static int pcie_port_msix_add_entry(
-	struct msix_entry *entries, int new_entry, int nr_entries)
-{
-	int j;
-
-	for (j = 0; j < nr_entries; j++)
-		if (entries[j].entry == new_entry)
-			return j;
-
-	entries[j].entry = new_entry;
-	return j;
-}
-
-/**
  * pcie_port_enable_msix - try to set up MSI-X as interrupt mode for given port
  * @dev: PCI Express port to handle
- * @vectors: Array of interrupt vectors to populate
+ * @irqs: Array of interrupt vectors to populate
  * @mask: Bitmask of port capabilities returned by get_port_device_capability()
  *
  * Return value: 0 on success, error code on failure
  */
-static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
+static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 {
-	struct msix_entry *msix_entries;
-	int idx[PCIE_PORT_DEVICE_MAXSERVICES];
-	int nr_entries, status, pos, i, nvec;
-	u16 reg16;
-	u32 reg32;
-
-	nr_entries = pci_msix_vec_count(dev);
-	if (nr_entries < 0)
-		return nr_entries;
-	BUG_ON(!nr_entries);
-	if (nr_entries > PCIE_PORT_MAX_MSIX_ENTRIES)
-		nr_entries = PCIE_PORT_MAX_MSIX_ENTRIES;
-
-	msix_entries = kzalloc(sizeof(*msix_entries) * nr_entries, GFP_KERNEL);
-	if (!msix_entries)
-		return -ENOMEM;
+	int nr_entries, entry, nvec = 0;
 
 	/*
 	 * Allocate as many entries as the port wants, so that we can check
@@ -97,20 +61,13 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 	 * equal to the number of entries this port actually uses, we'll happily
 	 * go through without any tricks.
 	 */
-	for (i = 0; i < nr_entries; i++)
-		msix_entries[i].entry = i;
-
-	status = pci_enable_msix_exact(dev, msix_entries, nr_entries);
-	if (status)
-		goto Exit;
-
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		idx[i] = -1;
-	status = -EIO;
-	nvec = 0;
+	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSIX_ENTRIES,
+			PCI_IRQ_MSIX);
+	if (nr_entries < 0)
+		return nr_entries;
 
 	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		int entry;
+		u16 reg16;
 
 		/*
 		 * The code below follows the PCI Express Base Specification 2.0
@@ -125,18 +82,16 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
 		if (entry >= nr_entries)
-			goto Error;
+			goto out_free_irqs;
 
-		i = pcie_port_msix_add_entry(msix_entries, entry, nvec);
-		if (i == nvec)
-			nvec++;
+		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
+		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
 
-		idx[PCIE_PORT_SERVICE_PME_SHIFT] = i;
-		idx[PCIE_PORT_SERVICE_HP_SHIFT] = i;
+		nvec = max(nvec, entry + 1);
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER) {
-		int entry;
+		u32 reg32, pos;
 
 		/*
 		 * The code below follows Section 7.10.10 of the PCI Express
@@ -151,13 +106,11 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
 		entry = reg32 >> 27;
 		if (entry >= nr_entries)
-			goto Error;
+			goto out_free_irqs;
 
-		i = pcie_port_msix_add_entry(msix_entries, entry, nvec);
-		if (i == nvec)
-			nvec++;
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
 
-		idx[PCIE_PORT_SERVICE_AER_SHIFT] = i;
+		nvec = max(nvec, entry + 1);
 	}
 
 	/*
@@ -165,41 +118,39 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 	 * what we have.  Otherwise, the port has some extra entries not for the
 	 * services we know and we need to work around that.
 	 */
-	if (nvec == nr_entries) {
-		status = 0;
-	} else {
+	if (nvec != nr_entries) {
 		/* Drop the temporary MSI-X setup */
-		pci_disable_msix(dev);
+		pci_free_irq_vectors(dev);
 
 		/* Now allocate the MSI-X vectors for real */
-		status = pci_enable_msix_exact(dev, msix_entries, nvec);
-		if (status)
-			goto Exit;
+		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
+				PCI_IRQ_MSIX);
+		if (nr_entries < 0)
+			return nr_entries;
 	}
 
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		vectors[i] = idx[i] >= 0 ? msix_entries[idx[i]].vector : -1;
-
- Exit:
-	kfree(msix_entries);
-	return status;
+	return 0;
 
- Error:
-	pci_disable_msix(dev);
-	goto Exit;
+out_free_irqs:
+	pci_free_irq_vectors(dev);
+	return -EIO;
 }
 
 /**
- * init_service_irqs - initialize irqs for PCI Express port services
+ * pcie_init_service_irqs - initialize irqs for PCI Express port services
  * @dev: PCI Express port to handle
  * @irqs: Array of irqs to populate
  * @mask: Bitmask of port capabilities returned by get_port_device_capability()
  *
  * Return value: Interrupt mode associated with the port
  */
-static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
+static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
-	int i, irq = -1;
+	unsigned flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
+	int ret, i;
+
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = -1;
 
 	/*
 	 * If MSI cannot be used for PCIe PME or hotplug, we have to use
@@ -207,41 +158,25 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	 */
 	if (((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) ||
 	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
-		if (dev->irq)
-			irq = dev->irq;
-		goto no_msi;
+		flags &= ~PCI_IRQ_MSI;
+	} else {
+		/* Try to use MSI-X if supported */
+		if (!pcie_port_enable_msix(dev, irqs, mask))
+			return 0;
 	}
 
-	/* Try to use MSI-X if supported */
-	if (!pcie_port_enable_msix(dev, irqs, mask))
-		return 0;
-
-	/*
-	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
-	 * If neither MSI/MSI-X nor INTx available, try other interrupt.  On
-	 * some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
-	 */
-	if (!pci_enable_msi(dev) || dev->irq)
-		irq = dev->irq;
+	ret = pci_alloc_irq_vectors(dev, 1, 1, flags);
+	if (ret < 0)
+		return -ENODEV;
 
- no_msi:
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = irq;
-	irqs[PCIE_PORT_SERVICE_VC_SHIFT] = -1;
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		if (i != PCIE_PORT_SERVICE_VC_SHIFT)
+			irqs[i] = pci_irq_vector(dev, 0);
+	}
 
-	if (irq < 0)
-		return -ENODEV;
 	return 0;
 }
 
-static void cleanup_service_irqs(struct pci_dev *dev)
-{
-	if (dev->msix_enabled)
-		pci_disable_msix(dev);
-	else if (dev->msi_enabled)
-		pci_disable_msi(dev);
-}
-
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
@@ -378,7 +313,7 @@ int pcie_port_device_register(struct pci_dev *dev)
 	 * that can be used in the absence of irqs.  Allow them to determine
 	 * if that is to be used.
 	 */
-	status = init_service_irqs(dev, irqs, capabilities);
+	status = pcie_init_service_irqs(dev, irqs, capabilities);
 	if (status) {
 		capabilities &= PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
@@ -401,7 +336,7 @@ int pcie_port_device_register(struct pci_dev *dev)
 	return 0;
 
 error_cleanup_irqs:
-	cleanup_service_irqs(dev);
+	pci_free_irq_vectors(dev);
 error_disable:
 	pci_disable_device(dev);
 	return status;
@@ -469,7 +404,7 @@ static int remove_iter(struct device *dev, void *data)
 void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
-	cleanup_service_irqs(dev);
+	pci_free_irq_vectors(dev);
 	pci_disable_device(dev);
 }
 
-- 
2.1.4
