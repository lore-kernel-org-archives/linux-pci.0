Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v6 3/3] pci:add support aer/pme interrupts with none
 MSI/MSI-X/INTx mode
Date: Fri, 30 Sep 2016 17:11:37 +0800
Message-ID: <1475226697-7709-3-git-send-email-po.liu@nxp.com>
In-Reply-To: <1475226697-7709-1-git-send-email-po.liu@nxp.com>
References: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
 <1475226697-7709-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, Po Liu <po.liu@nxp.com>,
 Stuart Yoder <stuart.yoder@nxp.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 Minghuan Lian <minghuan.lian@nxp.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>,
 Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
When chip support the aer/pme interrupts with none MSI/MSI-X/INTx mode,
maybe there is interrupt line for aer pme etc. Search the interrupt
number in the fdt file. Then fixup the dev->irq with it.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for v6:
	- modify bindings for "aer""pme";
	- changing to the hood method to implement the aer pme interrupt;
	- add pme interrupt in the same way;

 .../devicetree/bindings/pci/layerscape-pci.txt     | 13 +++++--
 arch/arm/kernel/bios32.c                           | 43 ++++++++++++++++++++++
 arch/arm64/kernel/pci.c                            | 43 ++++++++++++++++++++++
 drivers/pci/pcie/portdrv_core.c                    | 31 +++++++++++++++-
 include/linux/pci.h                                |  1 +
 5 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 41e9f55..51ed49e 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -18,8 +18,12 @@ Required properties:
 - reg: base addresses and lengths of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
+- interrupt-names: It could include the following entries:
+  "aer": Asserted for aer interrupt when chip support the aer interrupt with
+		 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
+  "pme": Asserted for pme interrupt when chip support the pme interrupt with
+		 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
+  ......
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
   The second entry must be '0' or '1' based on physical PCIe controller index.
@@ -35,8 +39,9 @@ Example:
 		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 		reg-names = "regs", "config";
-		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "intr";
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, /* aer interrupt */
+			<GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* pme interrupt */
+		interrupt-names = "aer", "pme";
 		fsl,pcie-scfg = <&scfg 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2f0e077..d2f4869 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -11,6 +11,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
+#include <linux/pcieport_if.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -64,6 +66,47 @@ void pcibios_report_status(u_int status_mask, int warn)
 }
 
 /*
+ * Check device tree if the service interrupts are there
+ */
+int pcibios_check_service_irqs(struct pci_dev *dev, int *irqs, int mask)
+{
+	int ret, count = 0;
+	struct device_node *np = NULL;
+
+	if (dev->bus->dev.of_node)
+		np = dev->bus->dev.of_node;
+
+	if (np == NULL)
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_OF_IRQ))
+		return 0;
+
+	/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
+	 * request irq for aer
+	 */
+	if (mask & PCIE_PORT_SERVICE_AER) {
+		ret = of_irq_get_byname(np, "aer");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
+			count++;
+		}
+	}
+
+	if (mask & PCIE_PORT_SERVICE_PME) {
+		ret = of_irq_get_byname(np, "pme");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_PME_SHIFT] = ret;
+			count++;
+		}
+	}
+
+	/* TODO: add more service interrupts if there it is in the device tree*/
+
+	return count;
+}
+
+/*
  * We don't use this to fix the device, but initialisation of it.
  * It's not the correct use for this, but it works.
  * Note that the arbiter/ISA bridge appears to be buggy, specifically in
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index acf3872..4a3c61a 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -17,6 +17,8 @@
 #include <linux/mm.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/pcieport_if.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
@@ -55,6 +57,47 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 }
 
 /*
+ * Check device tree if the service interrupts are there
+ */
+int pcibios_check_service_irqs(struct pci_dev *dev, int *irqs, int mask)
+{
+	int ret, count = 0;
+	struct device_node *np = NULL;
+
+	if (dev->bus->dev.of_node)
+		np = dev->bus->dev.of_node;
+
+	if (np == NULL)
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_OF_IRQ))
+		return 0;
+
+	/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
+	 * request irq for aer
+	 */
+	if (mask & PCIE_PORT_SERVICE_AER) {
+		ret = of_irq_get_byname(np, "aer");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
+			count++;
+		}
+	}
+
+	if (mask & PCIE_PORT_SERVICE_PME) {
+		ret = of_irq_get_byname(np, "pme");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_PME_SHIFT] = ret;
+			count++;
+		}
+	}
+
+	/* TODO: add more service interrupts if there it is in the device tree*/
+
+	return count;
+}
+
+/*
  * raw_pci_read/write - Platform-specific PCI config space access.
  */
 int raw_pci_read(unsigned int domain, unsigned int bus,
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e9270b4..34b6dae 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -44,6 +44,19 @@ static void release_pcie_device(struct device *dev)
 }
 
 /**
+ * pcibios_check_service_irqs - check irqs in the device tree
+ * @dev: PCI Express port to handle
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of port capabilities returned by get_port_device_capability()
+ *
+ * Return value: 0 means no service irqs in the device tree
+ *
+ */
+int __weak pcibios_check_service_irqs(struct pci_dev *dev, int *irqs, int mask)
+{
+	return 0;
+}
+/**
  * pcie_port_msix_add_entry - add entry to given array of MSI-X entries
  * @entries: Array of MSI-X entries
  * @new_entry: Index of the entry to add to the array
@@ -200,6 +213,21 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
 	int i, irq = -1;
+	int ret;
+
+	/* Check if some platforms owns independent irq pins for AER/PME etc.
+	 * Some platforms may own independent AER/PME interrupts and set
+	 * them in the device tree file.
+	 */
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+			irqs[i] = -1;
+
+	ret = pcibios_check_service_irqs(dev, irqs, mask);
+	if (ret) {
+		if (dev->irq)
+			irq = dev->irq;
+		goto no_msi;
+	}
 
 	/*
 	 * If MSI cannot be used for PCIe PME or hotplug, we have to use
@@ -226,7 +254,8 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 
  no_msi:
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = irq;
+		if (irqs[i] == -1)
+			irqs[i] = irq;
 	irqs[PCIE_PORT_SERVICE_VC_SHIFT] = -1;
 
 	if (irq < 0)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2599a98..c80f2d0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1793,6 +1793,7 @@ void pcibios_release_device(struct pci_dev *dev);
 void pcibios_penalize_isa_irq(int irq, int active);
 int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
+int pcibios_check_service_irqs(struct pci_dev *dev, int *irqs, int mask);
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 extern struct dev_pm_ops pcibios_pm_ops;
-- 
2.1.0.27.g96db324


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
