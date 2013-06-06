Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:44317 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab3FFQlo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 12:41:44 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: [PATCH v2 6/8] pci: mvebu: add support for MSI
Date: Thu,  6 Jun 2013 18:41:26 +0200
Message-Id: <1370536888-8871-7-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
 drivers/pci/host/pci-mvebu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13a633b..0dc30bd 100644
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
@@ -690,6 +692,8 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	if (!bus)
 		return NULL;
 
+	bus->msi = pcie->msi;
+
 	pci_scan_child_bus(bus);
 
 	return bus;
@@ -755,6 +759,21 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
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
+	pcie->msi = msi_chip_find_by_of_node(msi_node);
+
+	if (pcie->msi)
+		pcie->msi->dev = &pcie->pdev->dev;
+}
+
 static int __init mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie;
@@ -879,6 +898,8 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 		i++;
 	}
 
+	mvebu_pcie_msi_enable(pcie);
+
 	mvebu_pcie_enable(pcie);
 
 	return 0;
-- 
1.8.1.2

