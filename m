Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42410 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab3FSQ4l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 12:56:41 -0400
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
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCHv3 09/11] pci: mvebu: add support for MSI
Date: Wed, 19 Jun 2013 18:56:17 +0200
Message-Id: <1371660979-21588-10-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds support for Message Signaled Interrupts in the
Marvell PCIe host controller. The work is very simple: it simply gets
a reference to the msi_chip associated to the PCIe controller thanks
to the msi-parent DT property, and stores this reference in the
pci_bus structure. This is enough to let the Linux PCI core use the
functions of msi_chip to setup and teardown MSIs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13a633b..89638d1 100644
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
@@ -755,6 +764,21 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
 	return devm_request_and_ioremap(&pdev->dev, &regs);
 }
 
+static void __init mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
+{
+	struct device_node *msi_node;
+
+	msi_node = of_parse_phandle(pcie->pdev->dev.of_node,
+				    "msi-parent", 0);
+	if (!msi_node)
+		return;
+
+	pcie->msi = of_msi_chip_find_by_node(msi_node);
+
+	if (pcie->msi)
+		pcie->msi->dev = &pcie->pdev->dev;
+}
+
 static int __init mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie;
@@ -879,6 +903,8 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 		i++;
 	}
 
+	mvebu_pcie_msi_enable(pcie);
+
 	mvebu_pcie_enable(pcie);
 
 	return 0;
-- 
1.8.1.2

