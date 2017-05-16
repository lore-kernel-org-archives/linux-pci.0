Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] PCI/portdrv: add support for different MSI interrupts for PCIe port services
Date: Tue, 16 May 2017 11:25:41 +0100
Message-ID: <1494930342-7132-2-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Currently PCIe port services are assigned with different interrutps
only if MSI-x are supported by calling pcie_port_enable_msix().
If a root port supports MSI instead of MSI-x currently we fall back
to use a single shared interrupt for all the services.
This patch renames and extends pcie_port_enable_msix() to use MSI in
case MSI-x allocation fails.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/pcie/portdrv.h      |  5 +++++
 drivers/pci/pcie/portdrv_core.c | 33 +++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 587aef3..729ee90 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -18,6 +18,11 @@
  */
 #define PCIE_PORT_MAX_MSIX_ENTRIES	32
 
+/* According to the PCI Local Bus Specification REV. 3.0 the max number
+ * of MSI vectors per function is 32
+ */
+#define PCIE_PORT_MAX_MSI_ENTRIES	32
+
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
 extern struct bus_type pcie_port_bus_type;
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index cea504f..e2c7bfd 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -44,14 +44,16 @@ static void release_pcie_device(struct device *dev)
 }
 
 /**
- * pcie_port_enable_msix - try to set up MSI-X as interrupt mode for given port
+ * pcie_port_enable_msix_or_msi - try to set up MSI-X or MSI as interrupt mode
+ * for given port
  * @dev: PCI Express port to handle
  * @irqs: Array of interrupt vectors to populate
  * @mask: Bitmask of port capabilities returned by get_port_device_capability()
  *
  * Return value: 0 on success, error code on failure
  */
-static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
+static
+int pcie_port_enable_msix_or_msi(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, entry, nvec = 0;
 
@@ -63,6 +65,10 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 	 */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSIX_ENTRIES,
 			PCI_IRQ_MSIX);
+	if (nr_entries < 0) /* MSI-x failed let's try with MSI */
+		nr_entries = pci_alloc_irq_vectors(dev, 1,
+				PCIE_PORT_MAX_MSI_ENTRIES,
+				PCI_IRQ_MSI);
 	if (nr_entries < 0)
 		return nr_entries;
 
@@ -77,7 +83,13 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
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
@@ -100,7 +112,13 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 		 * MSI/MSI-X vectors assigned to the port is going to be used
 		 * for AER, where "For MSI-X, the value in this register
 		 * indicates which MSI-X Table entry is used to generate the
-		 * interrupt message."
+		 * interrupt message."  and "For MSI, the value
+		 * in this field indicates the offset between the base Message
+		 * Data and the interrupt message that is generated."
+		 *
+		 * pci_irq_vector() below is able to handle entry differently
+		 * depending on MSI vs MSI-x case
+		 *
 		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
@@ -125,6 +143,9 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 		/* Now allocate the MSI-X vectors for real */
 		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
 				PCI_IRQ_MSIX);
+		if (nr_entries < 0) /* MSI-x failed, let's try MSI*/
+			nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
+					PCI_IRQ_MSI);
 		if (nr_entries < 0)
 			return nr_entries;
 	}
@@ -160,8 +181,8 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
 		flags &= ~PCI_IRQ_MSI;
 	} else {
-		/* Try to use MSI-X if supported */
-		if (!pcie_port_enable_msix(dev, irqs, mask))
+		/* Try to use MSI-X or MSI if supported */
+		if (!pcie_port_enable_msix_or_msi(dev, irqs, mask))
 			return 0;
 	}
 
-- 
2.7.4
