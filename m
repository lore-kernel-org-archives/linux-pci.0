Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932557AbcIBP4S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:56:18 -0400
Subject: [PATCH v2 13/15] The register at PCIE_CLIENT_BASE presumably has a
 name of its own. Add a
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Sep 2016 10:55:43 -0500
Message-ID: <20160902155543.8650.2357.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

name for it and similar registers in other blocks.
---
 drivers/pci/host/pcie-rockchip.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 2a41439..a2610dd 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -38,7 +38,7 @@
 #include <linux/regmap.h>
 
 /*
- * The upper 16 bits of PCIE_CLIENT_BASE are a write mask for the lower 16
+ * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
  * bits.  This allows atomic updates of the register without locking.
  */
 #define HIWORD_UPDATE(mask, val)	((mask << 16) | val)
@@ -46,6 +46,7 @@
 #define ENCODE_LANES(x)			(((x >> 1) & 3) << 4)
 
 #define PCIE_CLIENT_BASE		0x0
+#define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
 #define  PCIE_CLIENT_CONF_ENABLE	  HIWORD_UPDATE(0x0001, 0x0001)
 #define  PCIE_CLIENT_LINK_TRAIN_ENABLE	  HIWORD_UPDATE(0x0002, 0x0002)
 #define  PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
@@ -87,6 +88,7 @@
 	PCIE_CLIENT_INT_PHY)
 
 #define PCIE_CORE_CTRL_MGMT_BASE	0x900000
+#define PCIE_CORE_CTRL			(PCIE_CORE_CTRL_MGMT_BASE + 0x000)
 #define  PCIE_CORE_PL_CONF_SPEED_5G		0x1
 #define  PCIE_CORE_PL_CONF_SPEED_SHIFT		3
 #define  PCIE_CORE_PL_CONF_SPEED_MASK		0x3
@@ -120,6 +122,7 @@
 		 PCIE_CORE_INT_MMVC)
 
 #define PCIE_RC_CONFIG_BASE		0xa00000
+#define PCIE_RC_CONFIG_VENDOR		(PCIE_RC_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define  PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
@@ -131,6 +134,7 @@
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
+#define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define PCIE_CORE_OB_REGION_ADDR1	(PCIE_CORE_AXI_CONF_BASE + 0x4)
 #define PCIE_CORE_OB_REGION_DESC0	(PCIE_CORE_AXI_CONF_BASE + 0x8)
 #define PCIE_CORE_OB_REGION_DESC1	(PCIE_CORE_AXI_CONF_BASE + 0xc)
@@ -140,7 +144,8 @@
 #define PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	0xffffff00
 
 #define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
-#define PCIE_RP_IB_ADDR_TRANS		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
+#define PCIE_RP_IB_ADDR0		(PCIE_CORE_AXI_INBOUND_BASE + 0x0)
+#define PCIE_RP_IB_ADDR1		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
 
 /* Size of one AXI Region (not Region 0) */
 #define AXI_REGION_SIZE				BIT(20)
@@ -419,7 +424,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
 			    PCIE_CLIENT_MODE_RC |
 			    PCIE_CLIENT_GEN_SEL_2,
-				PCIE_CLIENT_BASE);
+				PCIE_CLIENT_CONFIG);
 
 	err = phy_power_on(rockchip->phy);
 	if (err) {
@@ -462,7 +467,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
-			    PCIE_CLIENT_BASE);
+			    PCIE_CLIENT_CONFIG);
 
 	gpiod_set_value(rockchip->ep_gpio, 1);
 
@@ -510,7 +515,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	timeout = jiffies + msecs_to_jiffies(500);
 	for (;;) {
-		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_MGMT_BASE);
+		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
 		if (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
 		     PCIE_CORE_PL_CONF_SPEED_MASK) ==
 		     PCIE_CORE_PL_CONF_SPEED_5G) {
@@ -528,7 +533,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	/* Double check gen2 training */
 	if (err) {
-		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_MGMT_BASE);
+		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
 		err = (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
 			PCIE_CORE_PL_CONF_SPEED_MASK) ==
 			PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
@@ -537,13 +542,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	}
 
 	/* Check the final link width from negotiated lane counter from MGMT */
-	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_MGMT_BASE);
+	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
 	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
 			   PCIE_CORE_PL_CONF_LANE_MASK);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
-			    PCIE_RC_CONFIG_BASE);
+			    PCIE_RC_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
 			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
 			    PCIE_RC_CONFIG_RID_CCR);
@@ -551,7 +556,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	rockchip_pcie_write(rockchip,
 			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
-			    PCIE_CORE_AXI_CONF_BASE);
+			    PCIE_CORE_OB_REGION_ADDR0);
 	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
 			    PCIE_CORE_OB_REGION_ADDR1);
 	rockchip_pcie_write(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
@@ -975,7 +980,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
 	ob_desc_0 = (1 << 23 | type);
 
 	rockchip_pcie_writel(rockchip, ob_addr_0,
-			     PCIE_CORE_AXI_CONF_BASE + aw_offset);
+			     PCIE_CORE_OB_REGION_ADDR0 + aw_offset);
 	rockchip_pcie_writel(rockchip, ob_addr_1,
 			     PCIE_CORE_OB_REGION_ADDR1 + aw_offset);
 	rockchip_pcie_writel(rockchip, ob_desc_0,
@@ -1007,10 +1012,8 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 	ib_addr_0 |= (lower_addr << 8) & PCIE_CORE_IB_REGION_ADDR0_LO_ADDR;
 	ib_addr_1 = upper_addr;
 
-	rockchip_pcie_writel(rockchip, ib_addr_0,
-			     PCIE_CORE_AXI_INBOUND_BASE + aw_offset);
-	rockchip_pcie_writel(rockchip, ib_addr_1,
-			     PCIE_RP_IB_ADDR_TRANS + aw_offset);
+	rockchip_pcie_writel(rockchip, ib_addr_0, PCIE_RP_IB_ADDR0 + aw_offset);
+	rockchip_pcie_writel(rockchip, ib_addr_1, PCIE_RP_IB_ADDR1 + aw_offset);
 
 	return 0;
 }

