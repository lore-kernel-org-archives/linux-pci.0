Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:38792 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab3EVNMo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 09:12:44 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] pci: mvebu: no longer fake the slot location of downstream devices
Date: Wed, 22 May 2013 15:12:35 +0200
Message-Id: <1369228358-32580-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

By default, the Marvell hardware, for each PCIe interface, exhibits
the following devices:

 * On slot 0, a "Marvell Memory controller", identical on all PCIe
   interfaces, and which isn't useful when the Marvell SoC is the PCIe
   root complex (i.e, the normal case when we run Linux on the Marvell
   SoC).

 * On slot 1, the real PCIe card connected into the PCIe slot of the
   board.

So, what the Marvell PCIe driver was doing in its PCI-to-PCI bridge
emulation is that when the Linux PCI core was trying to access the
device in slot 0, we were in fact forwarding the configuration
transaction to the device in slot 1. For all other slots, we were
telling the Linux PCI core that there was no device connected.

However, new versions of bootloaders from Marvell change the default
PCIe configuration, and make the real device appear in slot 0, and the
"Marvell Memory controller" in slot 1.

Therefore, this commit modifies the Marvell PCIe driver to adjust the
PCIe hardware configuration to make sure that this behavior (real
device in slot 0, "Marvell Memory controller" in slot 1) is the one
we'll see regardless of what the bootloader has done. It allows to
remove the little hack that was forwarding configuration transactions
on slot 0 to slot 1, which is nice.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index ad1c46b..0bc21b0 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -51,6 +51,7 @@
 #define  PCIE_CTRL_X1_MODE		0x0001
 #define PCIE_STAT_OFF		0x1a04
 #define  PCIE_STAT_BUS                  0xff00
+#define  PCIE_STAT_DEV                  0x1f0000
 #define  PCIE_STAT_LINK_DOWN		BIT(0)
 #define PCIE_DEBUG_CTRL         0x1a60
 #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
@@ -148,6 +149,16 @@ static void mvebu_pcie_set_local_bus_nr(struct mvebu_pcie_port *port, int nr)
 	writel(stat, port->base + PCIE_STAT_OFF);
 }
 
+static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
+{
+	u32 stat;
+
+	stat = readl(port->base + PCIE_STAT_OFF);
+	stat &= ~PCIE_STAT_DEV;
+	stat |= nr << 16;
+	writel(stat, port->base + PCIE_STAT_OFF);
+}
+
 /*
  * Setup PCIE BARs and Address Decode Wins:
  * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
@@ -572,8 +583,7 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 
 	/* Access the real PCIe interface */
 	spin_lock_irqsave(&port->conf_lock, flags);
-	ret = mvebu_pcie_hw_wr_conf(port, bus,
-				    PCI_DEVFN(1, PCI_FUNC(devfn)),
+	ret = mvebu_pcie_hw_wr_conf(port, bus, devfn,
 				    where, size, val);
 	spin_unlock_irqrestore(&port->conf_lock, flags);
 
@@ -606,8 +616,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 
 	/* Access the real PCIe interface */
 	spin_lock_irqsave(&port->conf_lock, flags);
-	ret = mvebu_pcie_hw_rd_conf(port, bus,
-				    PCI_DEVFN(1, PCI_FUNC(devfn)),
+	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
 				    where, size, val);
 	spin_unlock_irqrestore(&port->conf_lock, flags);
 
@@ -817,6 +826,8 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		mvebu_pcie_set_local_dev_nr(port, 1);
+
 		if (mvebu_pcie_link_up(port)) {
 			port->haslink = 1;
 			dev_info(&pdev->dev, "PCIe%d.%d: link up\n",
-- 
1.7.9.5

