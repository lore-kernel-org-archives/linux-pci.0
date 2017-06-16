Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:55613 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbdFPIUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2017 04:20:25 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] PCI: rockchip: do some post-cleanup work for phy
Date: Fri, 16 Jun 2017 16:17:48 +0800
Message-Id: <1497601068-181656-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1497601068-181656-1-git-send-email-shawn.lin@rock-chips.com>
References: <1497601068-181656-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch invents rockchip_pcie_lane_map for looking
up all lanes and find active one(s). Then we pass
on the active lane map for phy_set_mode so that the
we could do some basic cleanup work for power-saving by
idle the failed lane(s).

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0e020b6..c1916fd 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -15,6 +15,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -111,6 +112,9 @@
 #define   PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT	16
 #define   PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(x) \
 		(((x) >> 3) << PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT)
+#define PCIE_CORE_LANE_MAP		(PCIE_CORE_CTRL_MGMT_BASE + 0x200)
+#define   PCIE_CORE_LANE_MAP_MASK		0x0000000f
+#define   PCIE_CORE_LANE_MAP_REVERSE		BIT(16)
 #define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
 #define   PCIE_CORE_INT_PRFPE			BIT(0)
 #define   PCIE_CORE_INT_CRFPE			BIT(1)
@@ -292,6 +296,19 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 	return 1;
 }
 
+
+static u8 rockchip_pcie_lane_map(struct rockchip_pcie *rockchip)
+{
+	u32 val = rockchip_pcie_read(rockchip, PCIE_CORE_LANE_MAP);
+	u8 map = val & PCIE_CORE_LANE_MAP_MASK;
+
+	/* The link may be using a reverse-indexed mapping. */
+	if (val & PCIE_CORE_LANE_MAP_REVERSE)
+		map = bitrev8(map) >> 4;
+
+	return map;
+}
+
 static int rockchip_pcie_rd_own_conf(struct rockchip_pcie *rockchip,
 				     int where, int size, u32 *val)
 {
@@ -646,6 +663,9 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			  PCIE_CORE_PL_CONF_LANE_SHIFT);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
+	/* Pass on the lane map for phy to do some power-saving work */
+	phy_set_mode(rockchip->phy, rockchip_pcie_lane_map(rockchip));
+
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
 			    PCIE_CORE_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
-- 
1.9.1
