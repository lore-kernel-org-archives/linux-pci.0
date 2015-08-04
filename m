Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35762 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbHDVyp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 17:54:45 -0400
Received: by iodd187 with SMTP id d187so31171125iod.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 14:54:45 -0700 (PDT)
Subject: [PATCH v5 7/9] PCI: xgene: Set msi_controller->dev to
 platform_device, not pci_bus
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
Date: Tue, 04 Aug 2015 16:54:42 -0500
Message-ID: <20150804215442.9189.83038.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Other users of struct msi_controller set msi->dev to the platform_device of
the PCI host controller, not the device of the pci_bus for the root bus.

Set X-Gene's msi_controller->dev to the PCI host controller platform_device
as other platforms do.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 4c2fb1f..5e0d6de 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -501,7 +501,8 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static int xgene_pcie_msi_enable(struct pci_bus *bus)
+static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
+				 struct pci_bus *bus)
 {
 	struct device_node *msi_node;
 
@@ -515,7 +516,7 @@ static int xgene_pcie_msi_enable(struct pci_bus *bus)
 		return -ENODEV;
 
 	of_node_put(msi_node);
-	bus->msi->dev = &bus->dev;
+	bus->msi->dev = &port->dev;
 	return 0;
 }
 
@@ -560,7 +561,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		if (xgene_pcie_msi_enable(bus))
+		if (xgene_pcie_msi_enable(port, bus))
 			dev_info(port->dev, "failed to enable MSI\n");
 
 	pci_scan_child_bus(bus);

