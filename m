Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36813 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbHDVzA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 17:55:00 -0400
Received: by igbij6 with SMTP id ij6so83611256igb.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 14:54:59 -0700 (PDT)
Subject: [PATCH v5 9/9] PCI: xgene: Use pci_scan_root_bus_msi()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <james.morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>
Date: Tue, 04 Aug 2015 16:54:57 -0500
Message-ID: <20150804215457.9189.27595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously there was no way to specify the MSI controller when creating a
new PCI root bus, so we had to create the bus, set its MSI controller, then
scan the bus.  With the new pci_scan_root_bus_msi() interface, we can
specify the MSI controller up front and get rid of that intermediate step.

Look up the MSI controller first, then use pci_scan_root_bus_msi() to
create and scan the root PCI bus.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 3cb58a3..514f41b 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -68,6 +68,7 @@
 struct xgene_pcie_port {
 	struct device_node	*node;
 	struct device		*dev;
+	struct msi_controller	*msi;
 	struct clk		*clk;
 	void __iomem		*csr_base;
 	void __iomem		*cfg_base;
@@ -501,8 +502,7 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
-				 struct pci_bus *bus)
+static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
 {
 	struct device_node *msi_node;
 
@@ -510,12 +510,12 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
 	if (!msi_node)
 		return -ENODEV;
 
-	bus->msi = of_pci_find_msi_chip_by_node(msi_node);
-	if (!bus->msi)
+	port->msi = of_pci_find_msi_chip_by_node(msi_node);
+	if (!port->msi)
 		return -ENODEV;
 
 	of_node_put(msi_node);
-	bus->msi->dev = &port->dev;
+	port->msi->dev = &port->dev;
 	return 0;
 }
 
@@ -554,16 +554,15 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bus = pci_create_root_bus(&pdev->dev, 0,
-					&xgene_pcie_ops, port, &res);
-	if (!bus)
-		return -ENOMEM;
-
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		if (xgene_pcie_msi_enable(port, bus))
+		if (xgene_pcie_msi_enable(port))
 			dev_info(port->dev, "failed to enable MSI\n");
 
-	pci_scan_child_bus(bus);
+	bus = pci_scan_root_bus_msi(&pdev->dev, 0, &xgene_pcie_ops, port,
+				    &res, port->msi);
+	if (!bus)
+		return -ENOMEM;
+
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 

