Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60367 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751161AbdH1PZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 11:25:34 -0400
From: Jan Luebbe <jlu@pengutronix.de>
To: Gregory Clement <gregory.clement@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH 2/2] PCI: mvebu: Check DRAM window size
Date: Mon, 28 Aug 2017 17:25:17 +0200
Message-Id: <20170828152517.24506-3-jlu@pengutronix.de>
In-Reply-To: <20170828152517.24506-1-jlu@pengutronix.de>
References: <20170828152517.24506-1-jlu@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The sum of the DRAM windows may exceed 4GB (at least on Armada XP).
Return an error in that case.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/pci/host/pci-mvebu.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index f353a6eb2f01..5d74af81d104 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -206,10 +206,10 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
  * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
  * WIN[0-3] -> DRAM bank[0-3]
  */
-static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
+static int mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 {
 	const struct mbus_dram_target_info *dram;
-	u32 size;
+	u64 size;
 	int i;
 
 	dram = mv_mbus_dram_info();
@@ -252,19 +252,32 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 	if ((size & (size - 1)) != 0)
 		size = 1 << fls(size);
 
+	if (size > 0x100000000) {
+		dev_err(&port->pcie->pdev->dev,
+			"Could not configure DRAM window (too large): 0x%llx\n",
+			size);
+
+		return -EINVAL;
+	}
+
 	/* Setup BAR[1] to all DRAM banks. */
 	mvebu_writel(port, dram->cs[0].base, PCIE_BAR_LO_OFF(1));
 	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
 	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
 		     PCIE_BAR_CTRL_OFF(1));
+
+	return 0;
 }
 
-static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
+static int mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
 	u32 cmd, mask;
+	int ret;
 
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
-	mvebu_pcie_setup_wins(port);
+	ret = mvebu_pcie_setup_wins(port);
+	if (ret)
+		return ret;
 
 	/* Master + slave enable. */
 	cmd = mvebu_readl(port, PCIE_CMD_OFF);
@@ -277,6 +290,8 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	mask = mvebu_readl(port, PCIE_MASK_OFF);
 	mask |= PCIE_MASK_ENABLE_INTS;
 	mvebu_writel(port, mask, PCIE_MASK_OFF);
+
+	return 0;
 }
 
 static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
@@ -882,7 +897,9 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 
 		if (!port->base)
 			continue;
-		mvebu_pcie_setup_hw(port);
+		err = mvebu_pcie_setup_hw(port);
+		if (err)
+			return 0;
 	}
 
 	return 1;
-- 
2.11.0
