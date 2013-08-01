Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from up.free-electrons.com ([94.23.35.102]:53558 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750834Ab3HANZf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:25:35 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCHv6 12/13] PCI: mvebu: add support for MSI
Date: Thu,  1 Aug 2013 15:25:15 +0200
Message-Id: <1375363516-2620-13-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds support for Message Signaled Interrupts in the
Marvell PCIe host controller. The work is very simple: it simply gets
a reference to the msi_chip associated to the PCIe controller thanks
to the msi-parent DT property, and stores this reference in the
pci_bus structure. This is enough to let the Linux PCI core use the
functions of msi_chip to setup and teardown MSIs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../devicetree/bindings/pci/mvebu-pci.txt          |  3 +++
 drivers/pci/host/pci-mvebu.c                       | 31 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index f8d4058..77e0ffe 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -12,6 +12,8 @@ Mandatory properties:
 - device_type, set to "pci"
 - ranges: ranges for the PCI memory and I/O regions, as well as the
   MMIO registers to control the PCIe interfaces.
+- msi-parent: Link to the hardware entity that serves as the Message
+  Signaled Interrupt controller for this PCI controller.
 
 In addition, the Device Tree node must have sub-nodes describing each
 PCIe interface, having the following mandatory properties:
@@ -46,6 +48,7 @@ pcie-controller {
 	#size-cells = <2>;
 
 	bus-range = <0x00 0xff>;
+	msi-parent = <&mpic>;
 
 	ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000   /* Port 0.0 registers */
 		  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000   /* Port 2.0 registers */
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13a633b..884cf82 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/mbus.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
@@ -107,6 +108,7 @@ struct mvebu_pcie_port;
 struct mvebu_pcie {
 	struct platform_device *pdev;
 	struct mvebu_pcie_port *ports;
+	struct msi_chip *msi;
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
@@ -695,6 +697,12 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	return bus;
 }
 
+void mvebu_pcie_add_bus(struct pci_bus *bus)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
+	bus->msi = pcie->msi;
+}
+
 resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 					  const struct resource *res,
 					  resource_size_t start,
@@ -731,6 +739,7 @@ static void __init mvebu_pcie_enable(struct mvebu_pcie *pcie)
 	hw.map_irq        = mvebu_pcie_map_irq;
 	hw.ops            = &mvebu_pcie_ops;
 	hw.align_resource = mvebu_pcie_align_resource;
+	hw.add_bus        = mvebu_pcie_add_bus;
 
 	pci_common_init(&hw);
 }
@@ -755,6 +764,26 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
 	return devm_request_and_ioremap(&pdev->dev, &regs);
 }
 
+static void __init mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
+{
+	struct device_node *msi_node;
+	struct irq_domain *msi_domain;
+
+	msi_node = of_parse_phandle(pcie->pdev->dev.of_node,
+				    "msi-parent", 0);
+	if (!msi_node)
+		return;
+
+	msi_domain = irq_find_msi_host(msi_node);
+	if (!msi_domain)
+		return;
+
+	pcie->msi = msi_domain->msi_chip;
+
+	if (pcie->msi)
+		pcie->msi->dev = &pcie->pdev->dev;
+}
+
 static int __init mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie;
@@ -879,6 +908,8 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 		i++;
 	}
 
+	mvebu_pcie_msi_enable(pcie);
+
 	mvebu_pcie_enable(pcie);
 
 	return 0;
-- 
1.8.1.2

