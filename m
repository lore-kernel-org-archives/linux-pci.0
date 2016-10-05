Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:38638 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcJEDCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2016 23:02:08 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: rockchip: Support property to specify the link capability
Date: Wed,  5 Oct 2016 11:06:16 +0800
Message-Id: <1475636776-11386-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Brian Norris <briannorris@chromium.org>

rk3399 supports PCIe 2.x link speeds marginally at best, and on some
boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
ms waiting for training that will never happen, let's add a property
from devicetree to specify link capability.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rename the property to rockchip,max-link-speed according to
  Bjorn's recommendation and take some bits from imx6q-pcie to
  make this requirement more consisent.

 .../devicetree/bindings/pci/rockchip-pcie.txt      |  2 +
 drivers/pci/host/pcie-rockchip.c                   | 61 ++++++++++++++--------
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
index ba67b39..8335f03 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
@@ -42,6 +42,8 @@ Required properties:
 Optional Property:
 - ep-gpios: contain the entry for pre-reset gpio
 - num-lanes: number of lanes to use
+- rockchip,max-link-speed: Specify PCI gen for link capability. Must
+	be '2' for gen2, otherwise will default to gen1.
 - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
 - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
 - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 35591b1..ca3db51 100644
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
@@ -205,6 +206,7 @@ struct rockchip_pcie {
 	struct	gpio_desc *ep_gpio;
 	u32	lanes;
 	u8	root_bus_nr;
+	int	link_gen;
 	struct	device *dev;
 	struct	irq_domain *irq_domain;
 };
@@ -443,13 +445,21 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
+	if (rockchip->link_gen == 2) {
+		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
+				    PCIE_CLIENT_CONFIG);
+	} else {
+		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
+				    PCIE_CLIENT_CONFIG);
+		dev_info(dev, "max link speed is gen 1\n");
+	}
+
 	rockchip_pcie_write(rockchip,
 			    PCIE_CLIENT_CONF_ENABLE |
 			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
 			    PCIE_CLIENT_ARI_ENABLE |
 			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
-			    PCIE_CLIENT_MODE_RC |
-			    PCIE_CLIENT_GEN_SEL_2,
+			    PCIE_CLIENT_MODE_RC,
 				PCIE_CLIENT_CONFIG);
 
 	err = phy_power_on(rockchip->phy);
@@ -550,29 +560,31 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		msleep(20);
 	}
 
-	/*
-	 * Enable retrain for gen2. This should be configured only after
-	 * gen1 finished.
-	 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
-	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	if (rockchip->link_gen == 2) {
+		/*
+		 * Enable retrain for gen2. This should be configured only after
+		 * gen1 finished.
+		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+		status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+
+		timeout = jiffies + msecs_to_jiffies(500);
+		for (;;) {
+			status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
+			if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
+					PCIE_CORE_PL_CONF_SPEED_5G) {
+				dev_dbg(dev, "PCIe link training gen2 pass!\n");
+				break;
+			}
 
-	timeout = jiffies + msecs_to_jiffies(500);
-	for (;;) {
-		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
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
@@ -781,6 +793,11 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		rockchip->lanes = 1;
 	}
 
+	err = of_property_read_u32(node, "rockchip,max-link-speed",
+				   &rockchip->link_gen);
+	if (err)
+		rockchip->link_gen = 1;
+
 	rockchip->core_rst = devm_reset_control_get(dev, "core");
 	if (IS_ERR(rockchip->core_rst)) {
 		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
-- 
2.3.7


