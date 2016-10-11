Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:45952 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcJKEUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 00:20:40 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 3/3] PCI: rockchip: Specify the link capability
Date: Tue, 11 Oct 2016 12:26:27 +0800
Message-Id: <1476159987-31372-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1476159987-31372-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476159987-31372-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Brian Norris <briannorris@chromium.org>

rk3399 supports PCIe 2.x link speeds marginally at best, and on some
boards, the link won't train at 5 GT/s at all. Rather than sacrifice
500ms waiting for training that will never happen, let's use the helper
function, of_get_pci_max_link_speed, to get the max link speed from DT
and specify link capability.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6:
- user helper function of_get_pci_max_link_speed and use gen2 by default
  if finding any errors from of_get_pci_max_link_speed. It could be
  backward compatibe to the old dtb. (Suggested by Rob)

Changes in v5:
- rebase the code since it isn't cleanly applied after Bjorn's cleanup

Changes in v4:
- define link_gen as u32
- elaborate more for rockchip,max-link-speed on doc

Changes in v3:
- Cast a warning for invalid max link speed and use gen1 for it.
  That looks better than v2. (Suggested by Brian)

Changes in v2:
- rename the property to rockchip,max-link-speed according to
  Bjorn's recommendation and take some bits from imx6q-pcie to
  make this requirement more consisent.

 drivers/pci/host/pcie-rockchip.c | 58 +++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index b3548d0..7125e35 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -53,6 +53,7 @@
 #define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
 #define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
 #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
+#define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
 #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
 #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
 #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
@@ -200,6 +201,7 @@ struct rockchip_pcie {
 	struct	gpio_desc *ep_gpio;
 	u32	lanes;
 	u8	root_bus_nr;
+	int	link_gen;
 	struct	device *dev;
 	struct	irq_domain *irq_domain;
 };
@@ -437,13 +439,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
+	if (rockchip->link_gen == 2)
+		rockchip_writel(rockchip, PCIE_CLIENT_CONFIG,
+				PCIE_CLIENT_GEN_SEL_2);
+	else
+		rockchip_writel(rockchip, PCIE_CLIENT_CONFIG,
+				PCIE_CLIENT_GEN_SEL_1);
+
 	rockchip_writel(rockchip, PCIE_CLIENT_CONFIG,
 			    PCIE_CLIENT_CONF_ENABLE |
 			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
 			    PCIE_CLIENT_ARI_ENABLE |
 			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
-			    PCIE_CLIENT_MODE_RC |
-			    PCIE_CLIENT_GEN_SEL_2);
+			    PCIE_CLIENT_MODE_RC);
 
 	err = phy_power_on(rockchip->phy);
 	if (err) {
@@ -519,29 +527,31 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		msleep(20);
 	}
 
-	/*
-	 * Enable retrain for gen2. This should be configured only after
-	 * gen1 finished.
-	 */
-	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
-	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
-	rockchip_writel(rockchip, PCIE_RC_CONFIG_LCS, status);
+	if (rockchip->link_gen == 2) {
+		/*
+		 * Enable retrain for gen2. This should be configured
+		 * only after gen1 finished.
+		 */
+		status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
+		status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
+		rockchip_writel(rockchip, PCIE_RC_CONFIG_LCS, status);
+
+		timeout = jiffies + msecs_to_jiffies(500);
+		for (;;) {
+			status = rockchip_readl(rockchip, PCIE_CORE_CTRL);
+			if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
+			    PCIE_CORE_PL_CONF_SPEED_5G) {
+				dev_dbg(dev, "PCIe link training gen2 pass!\n");
+				break;
+			}
 
-	timeout = jiffies + msecs_to_jiffies(500);
-	for (;;) {
-		status = rockchip_readl(rockchip, PCIE_CORE_CTRL);
-		if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
-		    PCIE_CORE_PL_CONF_SPEED_5G) {
-			dev_dbg(dev, "PCIe link training gen2 pass!\n");
-			break;
-		}
+			if (time_after(jiffies, timeout)) {
+				dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
+				break;
+			}
 
-		if (time_after(jiffies, timeout)) {
-			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
-			break;
+			msleep(20);
 		}
-
-		msleep(20);
 	}
 
 	/* Check the final link width from negotiated lane counter from MGMT */
@@ -747,6 +757,10 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		rockchip->lanes = 1;
 	}
 
+	rockchip->link_gen = of_get_pci_max_link_speed(node);
+	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
+		rockchip->link_gen = 2;
+
 	rockchip->core_rst = devm_reset_control_get(dev, "core");
 	if (IS_ERR(rockchip->core_rst)) {
 		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
-- 
2.3.7


