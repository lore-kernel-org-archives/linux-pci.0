Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <mika.westerberg@linux.intel.com>,
        <hch@infradead.org>, <liudongdong3@huawei.com>
Subject: [PATCH v3 1/2] PCI/portdrv: add support for different MSI interrupts for PCIe port services
Date: Thu, 18 May 2017 11:35:47 +0100
Message-ID: <1495103748-7876-2-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1495103748-7876-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1495103748-7876-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently PCIe port services are assigned with different interrutps
only if MSI-x are supported by calling pcie_port_enable_msix().
If a root port supports MSI instead of MSI-x currently we fall back
to use a single shared interrupt for all the services.
This patch renames and extends pcie_port_enable_msix() to use MSI in
case MSI-x allocation fails.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pcie/portdrv.h      |  8 +++++---
 drivers/pci/pcie/portdrv_core.c | 43 ++++++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 587aef3..1993e2c 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -13,10 +13,12 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 /*
- * According to the PCI Express Base Specification 2.0, the indices of
- * the MSI-X table entries used by port services must not exceed 31
+ * According to the PCI Express Base Specification REV. 3.1 and according
+ * to the PCI Local Bus Specification REV. 3.0 respectively, the indices of
+ * the MSI-X table entries or the max number of MSI vectors used by port
+ * services must not exceed 31
  */
-#define PCIE_PORT_MAX_MSIX_ENTRIES	32
+#define PCIE_PORT_MAX_MSI_ENTRIES	32
 
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index cea504f..4d16cf2 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -44,14 +44,15 @@ static void release_pcie_device(struct device *dev)
 }
 
 /**
- * pcie_port_enable_msix - try to set up MSI-X as interrupt mode for given port
+ * pcie_port_enable_irq_vec - try to set up MSI-X or MSI as interrupt mode
+ * for given port
  * @dev: PCI Express port to handle
  * @irqs: Array of interrupt vectors to populate
  * @mask: Bitmask of port capabilities returned by get_port_device_capability()
  *
  * Return value: 0 on success, error code on failure
  */
-static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
+static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, entry, nvec = 0;
 
@@ -61,8 +62,8 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 	 * equal to the number of entries this port actually uses, we'll happily
 	 * go through without any tricks.
 	 */
-	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSIX_ENTRIES,
-			PCI_IRQ_MSIX);
+	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
+			PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nr_entries < 0)
 		return nr_entries;
 
@@ -77,7 +78,13 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 		 * Number field in the PCI Express Capabilities register", where
 		 * according to Section 7.8.2 of the specification "For MSI-X,
 		 * the value in this field indicates which MSI-X Table entry is
-		 * used to generate the interrupt message."
+		 * used to generate the interrupt message." and "For MSI, the
+		 * value in this field indicates the offset between the base
+		 * Message Data and the interrupt message that is generated."
+		 *
+		 * pci_irq_vector() below is able to handle entry differently
+		 * depending on MSI vs MSI-x case
+		 *
 		 */
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
@@ -100,7 +107,10 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 		 * MSI/MSI-X vectors assigned to the port is going to be used
 		 * for AER, where "For MSI-X, the value in this register
 		 * indicates which MSI-X Table entry is used to generate the
-		 * interrupt message."
+		 * interrupt message."  and "For MSI, the value
+		 * in this field indicates the offset between the base Message
+		 * Data and the interrupt message that is generated."
+		 *
 		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
@@ -124,7 +134,7 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 
 		/* Now allocate the MSI-X vectors for real */
 		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
-				PCI_IRQ_MSIX);
+				PCI_IRQ_MSIX | PCI_IRQ_MSI);
 		if (nr_entries < 0)
 			return nr_entries;
 	}
@@ -146,26 +156,23 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
  */
 static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
-	unsigned flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
 	int ret, i;
 
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
 		irqs[i] = -1;
 
 	/*
-	 * If MSI cannot be used for PCIe PME or hotplug, we have to use
-	 * INTx or other interrupts, e.g. system shared interrupt.
+	 * Make sure MSI can be used for PCIe PME or hotplug. otherwise we have
+	 * to use INTx or other interrupts, e.g. system shared interrupt.
 	 */
-	if (((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) ||
-	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
-		flags &= ~PCI_IRQ_MSI;
-	} else {
-		/* Try to use MSI-X if supported */
-		if (!pcie_port_enable_msix(dev, irqs, mask))
+	if (!((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) &&
+	    !((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi()))
+		/* Try to use MSI-X or MSI if supported */
+		if (!pcie_port_enable_irq_vec(dev, irqs, mask))
 			return 0;
-	}
 
-	ret = pci_alloc_irq_vectors(dev, 1, 1, flags);
+	/* fall back to legacy IRQ */
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
 	if (ret < 0)
 		return -ENODEV;
 
-- 
2.7.4
