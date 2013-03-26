Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54267 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3CZQwn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:52:43 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFCv1 09/11] pci: mvebu: add MSI support
Date: Tue, 26 Mar 2013 17:52:24 +0100
Message-Id: <1364316746-8702-10-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds the MSI support for the Marvell EBU PCIe driver. The
driver now looks at the 'msi-parent' property of the PCIe controller
DT node, and if it exists, it gets the associated IRQ domain, which
should be the MSI interrupt controller registered by the IRQ
controller driver.

Using this, the PCIe driver registers the ->setup_irq() and
->teardown_irq() callbacks using the newly introduced msi_chip
infrastructure, which allows the kernel PCI core to use the MSI
functionality.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pci/mvebu-pci.txt          |    5 +
 drivers/pci/host/pci-mvebu.c                       |  128 ++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 192bdfb..53cc437 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -14,6 +14,10 @@ Mandatory properties:
   corresponding registers
 - ranges: ranges for the PCI memory and I/O regions
 
+Optional properties:
+- msi-parent: a phandle pointing to the interrupt controller that
+  handles the MSI interrupts.
+
 In addition, the Device Tree node must have sub-nodes describing each
 PCIe interface, having the following mandatory properties:
 - reg: used only for interrupt mapping, so only the first four bytes
@@ -43,6 +47,7 @@ pcie-controller {
 	#address-cells = <3>;
 	#size-cells = <2>;
 
+	msi-parent = <&msi>;
 	bus-range = <0x00 0xff>;
 
 	reg = <0xd0040000 0x2000>, <0xd0042000 0x2000>,
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 9e6b137..b46fab8 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -7,17 +7,23 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/mbus.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
+#define INT_PCI_MSI_NR (16)
+
 /*
  * PCIe unit register offsets.
  */
@@ -101,10 +107,19 @@ struct mvebu_sw_pci_bridge {
 
 struct mvebu_pcie_port;
 
+struct mvebu_pcie_msi {
+	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
+	struct irq_domain *domain;
+	struct mutex lock;
+	struct msi_chip chip;
+	phys_addr_t doorbell;
+};
+
 /* Structure representing all PCIe interfaces */
 struct mvebu_pcie {
 	struct platform_device *pdev;
 	struct mvebu_pcie_port *ports;
+	struct mvebu_pcie_msi msi;
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
@@ -546,6 +561,11 @@ static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
 	return sys->private_data;
 }
 
+static inline struct mvebu_pcie_msi *to_mvebu_msi(struct msi_chip *chip)
+{
+	return container_of(chip, struct mvebu_pcie_msi, chip);
+}
+
 /* Find the PCIe interface that corresponds to the given bus */
 static struct mvebu_pcie_port *mvebu_find_port_from_bus(struct mvebu_pcie *pcie,
 							int bus)
@@ -710,6 +730,8 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	if (!bus)
 		return NULL;
 
+	bus->msi = &pcie->msi.chip;
+
 	pci_scan_child_bus(bus);
 
 	return bus;
@@ -786,6 +808,105 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 	return devm_request_and_ioremap(&pdev->dev, &regs);
 }
 
+#if defined(CONFIG_PCI_MSI)
+static int mvebu_pcie_msi_alloc(struct mvebu_pcie_msi *chip)
+{
+	int msi;
+
+	mutex_lock(&chip->lock);
+
+	msi = find_first_zero_bit(chip->used, INT_PCI_MSI_NR);
+
+	if (msi < INT_PCI_MSI_NR)
+		set_bit(msi, chip->used);
+	else
+		msi = -ENOSPC;
+
+	mutex_unlock(&chip->lock);
+
+	return msi;
+}
+
+static void mvebu_pcie_msi_free(struct mvebu_pcie_msi *chip, unsigned long irq)
+{
+	struct device *dev = chip->chip.dev;
+
+	mutex_lock(&chip->lock);
+
+	if (!test_bit(irq, chip->used))
+		dev_err(dev, "trying to free unused MSI#%lu\n", irq);
+	else
+		clear_bit(irq, chip->used);
+
+	mutex_unlock(&chip->lock);
+}
+
+static int mvebu_pcie_setup_msi_irq(struct msi_chip *chip,
+				    struct pci_dev *pdev,
+				    struct msi_desc *desc)
+{
+	struct mvebu_pcie_msi *msi = to_mvebu_msi(chip);
+	struct msi_msg msg;
+	unsigned int irq;
+	int hwirq;
+
+	hwirq = mvebu_pcie_msi_alloc(msi);
+	if (hwirq < 0)
+		return hwirq;
+
+	irq = irq_create_mapping(msi->domain, hwirq);
+	if (!irq)
+		return -EINVAL;
+
+	irq_set_msi_desc(irq, desc);
+
+	msg.address_lo = msi->doorbell;
+	msg.address_hi = 0;
+	msg.data = 0xf00 | (hwirq + 16);
+
+	write_msi_msg(irq, &msg);
+
+	return 0;
+}
+
+static void mvebu_pcie_teardown_msi_irq(struct msi_chip *chip,
+					unsigned int irq)
+{
+	struct mvebu_pcie_msi *msi = to_mvebu_msi(chip);
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	mvebu_pcie_msi_free(msi, d->hwirq);
+}
+
+static int mvebu_pcie_enable_msi(struct mvebu_pcie *pcie)
+{
+	struct device_node *msi_node;
+	struct mvebu_pcie_msi *msi;
+
+	msi = &pcie->msi;
+
+	mutex_init(&msi->lock);
+
+	msi_node = of_parse_phandle(pcie->pdev->dev.of_node,
+				    "msi-parent", 0);
+	if (!msi_node)
+		return -EINVAL;
+
+	msi->domain = irq_find_host(msi_node);
+	if (!msi->domain)
+		return -EINVAL;
+
+	if (of_property_read_u32(msi_node, "marvell,doorbell", &msi->doorbell))
+		return -EINVAL;
+
+	msi->chip.dev = &pcie->pdev->dev;
+	msi->chip.setup_irq = mvebu_pcie_setup_msi_irq;
+	msi->chip.teardown_irq = mvebu_pcie_teardown_msi_irq;
+
+	return 0;
+}
+#endif /* CONFIG_PCI_MSI */
+
 static int __init mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie;
@@ -903,6 +1024,13 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 
 	mvebu_pcie_enable(pcie);
 
+#ifdef CONFIG_PCI_MSI
+	ret = mvebu_pcie_enable_msi(pcie);
+	if (ret)
+		dev_warn(&pdev->dev, "could not enable MSI support: %d\n",
+			 ret);
+#endif
+
 	return 0;
 }
 
-- 
1.7.9.5

