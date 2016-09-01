Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 7/9] Simplify the confusing HIWORD_UPDATE scheme.
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
Date: Thu, 01 Sep 2016 11:44:51 -0500
Message-ID: <20160901164451.14195.61057.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |   69 +++++++++++++-------------------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 33bf2e1..7f6fe7d 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -115,36 +115,25 @@
 	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
 	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
 
-/*
-  * The higher 16-bit of this register is used for write protection
-  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
-  */
-#define HIWORD_UPDATE(val, mask, shift) \
-	((val) << (shift) | (mask) << ((shift) + 16))
-
 #define RC_REGION_0_ADDR_TRANS_H		0x00000000
 #define RC_REGION_0_ADDR_TRANS_L		0x00000000
 #define RC_REGION_0_PASS_BITS			(25 - 1)
 #define MAX_AXI_WRAPPER_REGION_NUM		33
 #define PCIE_CORE_LCSR_RETRAIN_LINK		BIT(5)
-#define PCIE_CLIENT_CONF_ENABLE			BIT(0)
-#define PCIE_CLIENT_CONF_ENABLE_SHIFT		0
-#define PCIE_CLIENT_CONF_ENABLE_MASK		0x1
-#define PCIE_CLIENT_LINK_TRAIN_ENABLE		1
-#define PCIE_CLIENT_LINK_TRAIN_SHIFT		1
-#define PCIE_CLIENT_LINK_TRAIN_MASK		0x1
-#define PCIE_CLIENT_ARI_ENABLE			BIT(0)
-#define PCIE_CLIENT_ARI_ENABLE_SHIFT		3
-#define PCIE_CLIENT_ARI_ENABLE_MASK		0x1
-#define PCIE_CLIENT_CONF_LANE_NUM(x)		(x / 2)
-#define PCIE_CLIENT_CONF_LANE_NUM_SHIFT		4
-#define PCIE_CLIENT_CONF_LANE_NUM_MASK		0x3
-#define PCIE_CLIENT_MODE_RC			BIT(0)
-#define PCIE_CLIENT_MODE_SHIFT			6
-#define PCIE_CLIENT_MODE_MASK			0x1
-#define PCIE_CLIENT_GEN_SEL_2			1
-#define PCIE_CLIENT_GEN_SEL_SHIFT		7
-#define PCIE_CLIENT_GEN_SEL_MASK		0x1
+
+/*
+ * The higher 16-bit of this register is used for write protection
+ * only if BIT(x + 16) set to 1 the BIT(x) can be written.
+ */
+#define PCIE_CLIENT_CONF_ENABLE		(0x00010000 | 0x0001)
+#define PCIE_CLIENT_LINK_TRAIN_ENABLE	(0x00020000 | 0x0002)
+#define PCIE_CLIENT_ARI_ENABLE		(0x00080000 | 0x0008)
+#define PCIE_CLIENT_CONF_LANE_NUM(x)	(0x00300000 | (((x >> 1) & 3) << 4)
+#define PCIE_CLIENT_MODE_RC		(0x00400000 | 0x0040)
+#define PCIE_CLIENT_GEN_SEL(x)		(0x00800000 | ((x & 1) << 7)
+#define  PCIE_CLIENT_GEN_SEL_0			0
+#define  PCIE_CLIENT_GEN_SEL_2			1
+
 #define PCIE_CLIENT_LINK_STATUS_UP		0x3
 #define PCIE_CLIENT_LINK_STATUS_SHIFT		20
 #define PCIE_CLIENT_LINK_STATUS_MASK		0x3
@@ -423,22 +412,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip_pcie_write(rockchip,
-		   HIWORD_UPDATE(PCIE_CLIENT_CONF_ENABLE,
-				 PCIE_CLIENT_CONF_ENABLE_MASK,
-				 PCIE_CLIENT_CONF_ENABLE_SHIFT) |
-		   HIWORD_UPDATE(PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes),
-				 PCIE_CLIENT_CONF_LANE_NUM_MASK,
-				 PCIE_CLIENT_CONF_LANE_NUM_SHIFT) |
-		   HIWORD_UPDATE(PCIE_CLIENT_MODE_RC,
-				 PCIE_CLIENT_MODE_MASK,
-				 PCIE_CLIENT_MODE_SHIFT) |
-		   HIWORD_UPDATE(PCIE_CLIENT_ARI_ENABLE,
-				 PCIE_CLIENT_ARI_ENABLE_MASK,
-				 PCIE_CLIENT_ARI_ENABLE_SHIFT) |
-		   HIWORD_UPDATE(PCIE_CLIENT_GEN_SEL_2,
-				 PCIE_CLIENT_GEN_SEL_MASK,
-				 PCIE_CLIENT_GEN_SEL_SHIFT),
-		   PCIE_CLIENT_BASE);
+			    PCIE_CLIENT_CONF_ENABLE |
+			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
+			    PCIE_CLIENT_ARI_ENABLE |
+			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
+			    PCIE_CLIENT_MODE_RC |
+			    PCIE_CLIENT_GEN_SEL(PCIE_CLIENT_GEN_SEL_2),
+			    PCIE_CLIENT_BASE);
 
 	err = phy_power_on(rockchip->phy);
 	if (err) {
@@ -482,11 +462,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 				 PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
 
 	/* Enable Gen1 training */
-	rockchip_pcie_write(rockchip,
-		   HIWORD_UPDATE(PCIE_CLIENT_LINK_TRAIN_ENABLE,
-				 PCIE_CLIENT_LINK_TRAIN_MASK,
-				 PCIE_CLIENT_LINK_TRAIN_SHIFT),
-		   PCIE_CLIENT_BASE);
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
+			    PCIE_CLIENT_BASE);
 
 	gpiod_set_value(rockchip->ep_gpio, 1);
 
