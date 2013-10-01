Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:49477 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab3JAR6O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Oct 2013 13:58:14 -0400
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug
Date: Tue,  1 Oct 2013 11:58:00 -0600
Message-Id: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Otherwise hotplugging the PEX doesn't work at all since the driver
detects the link state at probe time. Simply replacing the two tests
of haslink with a register read is enough to fix it.

Tested on kirkwood with repeated plug/unplug of the link partner.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/pci/host/pci-mvebu.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 729d5a1..f2d61f5 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -115,7 +115,6 @@ struct mvebu_pcie_port {
 	char *name;
 	void __iomem *base;
 	spinlock_t conf_lock;
-	int haslink;
 	u32 port;
 	u32 lane;
 	int devfn;
@@ -552,7 +551,7 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (bus->number == 0)
 		return mvebu_sw_pci_bridge_write(port, where, size, val);
 
-	if (!port->haslink)
+	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
@@ -594,7 +593,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	if (bus->number == 0)
 		return mvebu_sw_pci_bridge_read(port, where, size, val);
 
-	if (!port->haslink) {
+	if (!mvebu_pcie_link_up(port)) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -883,22 +882,11 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 
 		mvebu_pcie_set_local_dev_nr(port, 1);
 
-		if (mvebu_pcie_link_up(port)) {
-			port->haslink = 1;
-			dev_info(&pdev->dev, "PCIe%d.%d: link up\n",
-				 port->port, port->lane);
-		} else {
-			port->haslink = 0;
-			dev_info(&pdev->dev, "PCIe%d.%d: link down\n",
-				 port->port, port->lane);
-		}
-
 		port->clk = of_clk_get_by_name(child, NULL);
 		if (IS_ERR(port->clk)) {
 			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
 			       port->port, port->lane);
 			iounmap(port->base);
-			port->haslink = 0;
 			continue;
 		}
 
-- 
1.8.1.2

