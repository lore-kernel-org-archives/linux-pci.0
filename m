Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:36751 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbdGNDxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2017 23:53:10 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 4/6] PCI: rockchip: idle the inactive PHY(s)
Date: Fri, 14 Jul 2017 11:52:44 +0800
Message-Id: <1500004366-241633-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Check the status of all lanes and idle the inactive one(s).

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index a3dc7bd..d678a93 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -15,6 +15,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -112,6 +113,9 @@
 #define   PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT	16
 #define   PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(x) \
 		(((x) >> 3) << PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT)
+#define PCIE_CORE_LANE_MAP             (PCIE_CORE_CTRL_MGMT_BASE + 0x200)
+#define   PCIE_CORE_LANE_MAP_MASK              0x0000000f
+#define   PCIE_CORE_LANE_MAP_REVERSE           BIT(16)
 #define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
 #define   PCIE_CORE_INT_PRFPE			BIT(0)
 #define   PCIE_CORE_INT_CRFPE			BIT(1)
@@ -311,6 +315,18 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 	return 1;
 }
 
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
@@ -618,7 +634,8 @@ static int rockchip_pcie_manipulate_phys(struct rockchip_pcie *rockchip,
 static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
-	int err;
+	int err, i;
+	u8 lane_map;
 	u32 status;
 
 	gpiod_set_value(rockchip->ep_gpio, 0);
@@ -791,6 +808,18 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			  PCIE_CORE_PL_CONF_LANE_SHIFT);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
+	if (!rockchip->legacy_phy) {
+		/*  power off unused lane(s) */
+		lane_map = rockchip_pcie_lane_map(rockchip);
+		for (i = 0; i < MAX_LANE_NUM; i++) {
+			if (lane_map & BIT(i))
+				continue;
+
+			dev_err(dev, "idling lane %d\n", i);
+			phy_power_off(rockchip->phys[i]);
+		}
+	}
+
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
 			    PCIE_CORE_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
-- 
1.9.1
