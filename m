Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938909AbcJGQ1T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:27:19 -0400
Subject: [PATCH 2/3] PCI: rockchip: Swap order of rockchip_writel() reg/val
 arguments
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:27:14 -0500
Message-ID: <20161007162714.23835.9272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162706.23835.10081.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162706.23835.10081.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of rockchip_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rockchip.c |   95 ++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0ef2f9f..0a89d02 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -209,8 +209,7 @@ static u32 rockchip_readl(struct rockchip_pcie *rockchip, u32 reg)
 	return readl(rockchip->apb_base + reg);
 }
 
-static void rockchip_writel(struct rockchip_pcie *rockchip, u32 val,
-				u32 reg)
+static void rockchip_writel(struct rockchip_pcie *rockchip, u32 reg, u32 val)
 {
 	writel(val, rockchip->apb_base + reg);
 }
@@ -221,7 +220,7 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 
 	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
 	status |= (PCIE_RC_CONFIG_LCS_LBMIE | PCIE_RC_CONFIG_LCS_LABIE);
-	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_writel(rockchip, PCIE_RC_CONFIG_LCS, status);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
@@ -230,7 +229,7 @@ static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 
 	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
 	status |= (PCIE_RC_CONFIG_LCS_LBMS | PCIE_RC_CONFIG_LCS_LAMS);
-	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_writel(rockchip, PCIE_RC_CONFIG_LCS, status);
 }
 
 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -241,7 +240,7 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
 	val = rockchip_readl(rockchip, PCIE_CORE_TXCREDIT_CFG1);
 	val &= ~PCIE_CORE_TXCREDIT_CFG1_MUI_MASK;
 	val |= PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(24000);	/* ns */
-	rockchip_writel(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
+	rockchip_writel(rockchip, PCIE_CORE_TXCREDIT_CFG1, val);
 }
 
 static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
@@ -438,14 +437,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
-	rockchip_writel(rockchip,
+	rockchip_writel(rockchip, PCIE_CLIENT_CONFIG,
 			    PCIE_CLIENT_CONF_ENABLE |
 			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
 			    PCIE_CLIENT_ARI_ENABLE |
 			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
 			    PCIE_CLIENT_MODE_RC |
-			    PCIE_CLIENT_GEN_SEL_2,
-				PCIE_CLIENT_CONFIG);
+			    PCIE_CLIENT_GEN_SEL_2);
 
 	err = phy_power_on(rockchip->phy);
 	if (err) {
@@ -488,17 +486,17 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 * bug we need to work around.
 	 */
 	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
-	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
+	rockchip_writel(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2, status);
 
 	/* Fix the transmitted FTS count desired to exit from L0s. */
 	status = rockchip_readl(rockchip, PCIE_CORE_CTRL_PLC1);
 	status = (status & PCIE_CORE_CTRL_PLC1_FTS_MASK) |
 		 (PCIE_CORE_CTRL_PLC1_FTS_CNT << PCIE_CORE_CTRL_PLC1_FTS_SHIFT);
-	rockchip_writel(rockchip, status, PCIE_CORE_CTRL_PLC1);
+	rockchip_writel(rockchip, PCIE_CORE_CTRL_PLC1, status);
 
 	/* Enable Gen1 training */
-	rockchip_writel(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
-			    PCIE_CLIENT_CONFIG);
+	rockchip_writel(rockchip, PCIE_CLIENT_CONFIG,
+			PCIE_CLIENT_LINK_TRAIN_ENABLE);
 
 	gpiod_set_value(rockchip->ep_gpio, 1);
 
@@ -527,7 +525,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 */
 	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
 	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
-	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_writel(rockchip, PCIE_RC_CONFIG_LCS, status);
 
 	timeout = jiffies + msecs_to_jiffies(500);
 	for (;;) {
@@ -552,20 +550,17 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			  PCIE_CORE_PL_CONF_LANE_MASK);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
-	rockchip_writel(rockchip, ROCKCHIP_VENDOR_ID,
-			    PCIE_RC_CONFIG_VENDOR);
-	rockchip_writel(rockchip,
-			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
-			    PCIE_RC_CONFIG_RID_CCR);
-	rockchip_writel(rockchip, 0x0, PCIE_RC_BAR_CONF);
-
-	rockchip_writel(rockchip,
-			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
-			    PCIE_CORE_OB_REGION_ADDR0);
-	rockchip_writel(rockchip, RC_REGION_0_ADDR_TRANS_H,
-			    PCIE_CORE_OB_REGION_ADDR1);
-	rockchip_writel(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
-	rockchip_writel(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
+	rockchip_writel(rockchip, PCIE_RC_CONFIG_VENDOR, ROCKCHIP_VENDOR_ID);
+	rockchip_writel(rockchip, PCIE_RC_CONFIG_RID_CCR,
+			PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT);
+	rockchip_writel(rockchip, PCIE_RC_BAR_CONF, 0);
+
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_ADDR0,
+			RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS);
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_ADDR1,
+			RC_REGION_0_ADDR_TRANS_H);
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_DESC0, 0x0080000a);
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_DESC1, 0);
 
 	return 0;
 }
@@ -623,15 +618,15 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 		if (sub_reg & PCIE_CORE_INT_MMVC)
 			dev_dbg(dev, "MSI mask register changes\n");
 
-		rockchip_writel(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
+		rockchip_writel(rockchip, PCIE_CORE_INT_STATUS, sub_reg);
 	} else if (reg & PCIE_CLIENT_INT_PHY) {
 		dev_dbg(dev, "phy link changes\n");
 		rockchip_pcie_update_txcredit_mui(rockchip);
 		rockchip_pcie_clr_bw_int(rockchip);
 	}
 
-	rockchip_writel(rockchip, reg & PCIE_CLIENT_INT_LOCAL,
-			PCIE_CLIENT_INT_STATUS);
+	rockchip_writel(rockchip, PCIE_CLIENT_INT_STATUS,
+			reg & PCIE_CLIENT_INT_LOCAL);
 
 	return IRQ_HANDLED;
 }
@@ -667,13 +662,13 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 	if (reg & PCIE_CLIENT_INT_PHY)
 		dev_dbg(dev, "phy interrupt received\n");
 
-	rockchip_writel(rockchip, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
-			      PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
-			      PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
-			      PCIE_CLIENT_INT_NFATAL_ERR |
-			      PCIE_CLIENT_INT_CORR_ERR |
-			      PCIE_CLIENT_INT_PHY),
-		   PCIE_CLIENT_INT_STATUS);
+	rockchip_writel(rockchip, PCIE_CLIENT_INT_STATUS,
+			reg & (PCIE_CLIENT_INT_LEGACY_DONE |
+			       PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
+			       PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
+			       PCIE_CLIENT_INT_NFATAL_ERR |
+			       PCIE_CLIENT_INT_CORR_ERR |
+			       PCIE_CLIENT_INT_PHY));
 
 	return IRQ_HANDLED;
 }
@@ -913,10 +908,9 @@ err_out:
 
 static void rockchip_pcie_enable_interrupts(struct rockchip_pcie *rockchip)
 {
-	rockchip_writel(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
-			    (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
-	rockchip_writel(rockchip, (u32)(~PCIE_CORE_INT),
-			    PCIE_CORE_INT_MASK);
+	rockchip_writel(rockchip, PCIE_CLIENT_INT_MASK,
+			(PCIE_CLIENT_INT_CLI << 16) & (~PCIE_CLIENT_INT_CLI));
+	rockchip_writel(rockchip, PCIE_CORE_INT_MASK, (u32)(~PCIE_CORE_INT));
 
 	rockchip_pcie_enable_bw_int(rockchip);
 }
@@ -985,14 +979,13 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
 	ob_addr_1 = upper_addr;
 	ob_desc_0 = (1 << 23 | type);
 
-	rockchip_writel(rockchip, ob_addr_0,
-			    PCIE_CORE_OB_REGION_ADDR0 + aw_offset);
-	rockchip_writel(rockchip, ob_addr_1,
-			    PCIE_CORE_OB_REGION_ADDR1 + aw_offset);
-	rockchip_writel(rockchip, ob_desc_0,
-			    PCIE_CORE_OB_REGION_DESC0 + aw_offset);
-	rockchip_writel(rockchip, 0,
-			    PCIE_CORE_OB_REGION_DESC1 + aw_offset);
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_ADDR0 + aw_offset,
+			ob_addr_0);
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_ADDR1 + aw_offset,
+			ob_addr_1);
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_DESC0 + aw_offset,
+			ob_desc_0);
+	rockchip_writel(rockchip, PCIE_CORE_OB_REGION_DESC1 + aw_offset, 0);
 
 	return 0;
 }
@@ -1018,8 +1011,8 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 	ib_addr_0 |= (lower_addr << 8) & PCIE_CORE_IB_REGION_ADDR0_LO_ADDR;
 	ib_addr_1 = upper_addr;
 
-	rockchip_writel(rockchip, ib_addr_0, PCIE_RP_IB_ADDR0 + aw_offset);
-	rockchip_writel(rockchip, ib_addr_1, PCIE_RP_IB_ADDR1 + aw_offset);
+	rockchip_writel(rockchip, PCIE_RP_IB_ADDR0 + aw_offset, ib_addr_0);
+	rockchip_writel(rockchip, PCIE_RP_IB_ADDR1 + aw_offset, ib_addr_1);
 
 	return 0;
 }

