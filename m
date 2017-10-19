Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdJSXBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Oct 2017 19:01:23 -0400
Subject: [PATCH v5 3/3] PCI/portdrv: Compute MSI/MSI-X IRQ vectors after
 final allocation
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Charles Chenxin <charles.chenxin@huawei.com>, linuxarm@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-pci@vger.kernel.org
Date: Thu, 19 Oct 2017 18:01:21 -0500
Message-ID: <20171019230121.17806.11826.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

When setting up portdrv MSI/MSI-X interrupts, we previously allocated the
maximum possible number of vectors, read the Interrupt Message Numbers for
each service, saved the IRQ for each, freed the vectors, and finally used
the largest Message Number to reallocate only as many vectors as we need.

The problem is that freeing the vectors invalidates their IRQs, so the
saved IRQ numbers may now be invalid, which can result in errors like
this:

  pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
  pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
  aer: probe of 0000:00:00.0:pcie002 failed with error -22
  dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22

Change the setup so we save the Interrupt Message Numbers (not the IRQs)
before we free the original setup, then use the Message Numbers to compute
the IRQs (via pci_irq_vector()) *after* we reallocate the vectors.

This should always be safe for MSI-X because the Message Numbers are fixed.
For MSI, the hardware is allowed to change Message Numbers when we update
the MSI Multiple Message Enable field when reallocating the vectors, but
since we allocate enough vectors to accommodate the largest Message Number
we found, that's unlikely.  See PCIe r3.1, sec 7.8.2, 7.10.10, 7.31.2.

Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()")
Based-on-patch-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_core.c |  112 ++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7cd2eafda652..da03dc230f37 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -43,6 +43,46 @@ static void release_pcie_device(struct device *dev)
 	kfree(to_pcie_device(dev));
 }
 
+/*
+ * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
+ * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
+ * required to accommodate the largest Message Number.
+ */
+static int pcie_message_numbers(struct pci_dev *dev, int mask,
+				u32 *pme, u32 *aer, u32 *dpc)
+{
+	u32 nvec = 0, pos, reg32;
+	u16 reg16;
+
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
+		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
+		nvec = *pme + 1;
+	}
+
+	if (mask & PCIE_PORT_SERVICE_AER) {
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+		if (pos) {
+			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
+					      &reg32);
+			*aer = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
+			nvec = max(nvec, *aer + 1);
+		}
+	}
+
+	if (mask & PCIE_PORT_SERVICE_DPC) {
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
+		if (pos) {
+			pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP,
+					     &reg16);
+			*dpc = reg16 & PCI_EXP_DPC_IRQ;
+			nvec = max(nvec, *dpc + 1);
+		}
+	}
+
+	return nvec;
+}
+
 /**
  * pcie_port_enable_irq_vec - try to set up MSI-X or MSI as interrupt mode
  * for given port
@@ -54,7 +94,8 @@ static void release_pcie_device(struct device *dev)
  */
 static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
-	int nr_entries, entry, nvec = 0;
+	int nr_entries, nvec;
+	u32 pme = 0, aer = 0, dpc = 0;
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
@@ -62,49 +103,22 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (nr_entries < 0)
 		return nr_entries;
 
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		u16 reg16;
-
-		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
-		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
-		if (entry >= nr_entries)
-			goto out_free_irqs;
+	/* See how many and which Interrupt Message Numbers we actually use */
+	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
+	if (nvec > nr_entries)
+		goto out_free_irqs;
 
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
-
-		nvec = max(nvec, entry + 1);
-	}
-
-	if (mask & PCIE_PORT_SERVICE_AER) {
-		u32 reg32, pos;
-
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-		entry = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
-		if (entry >= nr_entries)
-			goto out_free_irqs;
-
-		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
-
-		nvec = max(nvec, entry + 1);
-	}
-
-	if (mask & PCIE_PORT_SERVICE_DPC) {
-		u16 reg16, pos;
-
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
-		pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
-		entry = reg16 & PCI_EXP_DPC_IRQ;
-		if (entry >= nr_entries)
-			goto out_free_irqs;
-
-		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
-
-		nvec = max(nvec, entry + 1);
-	}
-
-	/* If we allocated more than we need, free them and allocate fewer */
+	/*
+	 * If we allocated more than we need, free them and reallocate fewer.
+	 *
+	 * Note that reallocating may change the specific vectors we get,
+	 * so pci_irq_vector() must be done *after* the reallocation.
+	 *
+	 * If we're using MSI, hardware is *allowed* to change the Interrupt
+	 * Message Numbers when we free and reallocate the vectors, but we
+	 * assume it won't because we allocate enough vectors for the
+	 * biggest Message Number we found.
+	 */
 	if (nvec != nr_entries) {
 		pci_free_irq_vectors(dev);
 
@@ -114,6 +128,18 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 			return nr_entries;
 	}
 
+	/* PME and hotplug share an MSI/MSI-X vector (PCIe r3.1, sec 6.1.6) */
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
+		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
+	}
+
+	if (mask & PCIE_PORT_SERVICE_AER)
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer);
+
+	if (mask & PCIE_PORT_SERVICE_DPC)
+		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
+
 	return 0;
 
 out_free_irqs:
