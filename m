Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 10/15] Group related CSR definitions together.
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
Date: Fri, 02 Sep 2016 10:55:19 -0500
Message-ID: <20160902155518.8650.89467.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |  148 +++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 6edfce5..fe1b52f 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -37,21 +37,27 @@
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
-#define PCIE_CLIENT_BASE			0x0
-#define PCIE_RC_CONFIG_BASE			0xa00000
-#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	(PCIE_RC_CONFIG_BASE + 0x90c)
-#define PCIE_RC_CONFIG_LCS			(PCIE_RC_CONFIG_BASE + 0x0d0)
-#define  PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
-#define  PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
-#define  PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
-#define  PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
-#define  PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
-#define PCIE_CORE_CTRL_MGMT_BASE		0x900000
-#define PCIE_CORE_AXI_CONF_BASE			0xc00000
-#define PCIE_CORE_AXI_INBOUND_BASE		0xc00800
-#define PCIE_CLIENT_BASIC_STATUS1		(PCIE_CLIENT_BASE + 0x48)
-#define PCIE_CLIENT_INT_MASK			(PCIE_CLIENT_BASE + 0x4c)
-#define PCIE_CLIENT_INT_STATUS			(PCIE_CLIENT_BASE + 0x50)
+/*
+ * The upper 16 bits of PCIE_CLIENT_BASE are a write mask for the lower 16
+ * bits.  This allows atomic updates of the register without locking.
+ */
+#define HIWORD_UPDATE(mask, val)	((mask << 16) | val)
+
+#define ENCODE_LANES(x)			(((x >> 1) & 3) << 4)
+
+#define PCIE_CLIENT_BASE		0x0
+#define  PCIE_CLIENT_CONF_ENABLE	  HIWORD_UPDATE(0x0001, 0x0001)
+#define  PCIE_CLIENT_LINK_TRAIN_ENABLE	  HIWORD_UPDATE(0x0002, 0x0002)
+#define  PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
+#define  PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE(0x0040, 0x0040)
+#define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
+#define  PCIE_CLIENT_LINK_STATUS_UP		0x3
+#define  PCIE_CLIENT_LINK_STATUS_SHIFT		20
+#define  PCIE_CLIENT_LINK_STATUS_MASK		0x3
+#define PCIE_CLIENT_INT_MASK		(PCIE_CLIENT_BASE + 0x4c)
+#define PCIE_CLIENT_INT_STATUS		(PCIE_CLIENT_BASE + 0x50)
+#define  ROCKCHIP_PCIE_RPIFR1_INTR_MASK		GENMASK(8, 5)
+#define  ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT	5
 #define  PCIE_CLIENT_INT_LEGACY_DONE		BIT(15)
 #define  PCIE_CLIENT_INT_MSG			BIT(14)
 #define  PCIE_CLIENT_INT_HOT_RST		BIT(13)
@@ -68,18 +74,25 @@
 #define  PCIE_CLIENT_INT_PHY			BIT(2)
 #define  PCIE_CLIENT_INT_HOT_PLUG		BIT(1)
 #define  PCIE_CLIENT_INT_PWR_STCG		BIT(0)
-#define PCIE_RC_CONFIG_RID_CCR			(PCIE_RC_CONFIG_BASE + 0x08)
-#define PCIE_RC_BAR_CONF			(PCIE_CORE_CTRL_MGMT_BASE + 0x300)
-#define PCIE_CORE_OB_REGION_ADDR1		(PCIE_CORE_AXI_CONF_BASE + 0x4)
-#define PCIE_CORE_OB_REGION_DESC0		(PCIE_CORE_AXI_CONF_BASE + 0x8)
-#define PCIE_CORE_OB_REGION_DESC1		(PCIE_CORE_AXI_CONF_BASE + 0xc)
-#define PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
-#define PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	0xffffff00
-#define PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
-#define PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	0xffffff00
-#define PCIE_RP_IB_ADDR_TRANS			(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
-#define PCIE_CORE_INT_MASK			(PCIE_CORE_CTRL_MGMT_BASE + 0x210)
-#define PCIE_CORE_INT_STATUS			(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
+
+#define PCIE_CLIENT_INT_LEGACY \
+	(PCIE_CLIENT_INT_INTA | PCIE_CLIENT_INT_INTB | \
+	PCIE_CLIENT_INT_INTC | PCIE_CLIENT_INT_INTD)
+
+#define PCIE_CLIENT_INT_CLI \
+	(PCIE_CLIENT_INT_CORR_ERR | PCIE_CLIENT_INT_NFATAL_ERR | \
+	PCIE_CLIENT_INT_FATAL_ERR | PCIE_CLIENT_INT_DPA | \
+	PCIE_CLIENT_INT_HOT_RST | PCIE_CLIENT_INT_MSG | \
+	PCIE_CLIENT_INT_LEGACY_DONE | PCIE_CLIENT_INT_LEGACY | \
+	PCIE_CLIENT_INT_PHY)
+
+#define PCIE_CORE_CTRL_MGMT_BASE	0x900000
+#define  PCIE_CORE_PL_CONF_SPEED_5G		0x1
+#define  PCIE_CORE_PL_CONF_SPEED_SHIFT		3
+#define  PCIE_CORE_PL_CONF_SPEED_MASK		0x3
+#define  PCIE_CORE_PL_CONF_LANE_SHIFT		1
+#define  PCIE_CORE_PL_CONF_LANE_MASK		0x3
+#define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
 #define  PCIE_CORE_INT_PRFPE			BIT(0)
 #define  PCIE_CORE_INT_CRFPE			BIT(1)
 #define  PCIE_CORE_INT_RRPE			BIT(2)
@@ -94,6 +107,40 @@
 #define  PCIE_CORE_INT_CT			BIT(11)
 #define  PCIE_CORE_INT_UTC			BIT(18)
 #define  PCIE_CORE_INT_MMVC			BIT(19)
+#define PCIE_CORE_INT_MASK		(PCIE_CORE_CTRL_MGMT_BASE + 0x210)
+#define PCIE_RC_BAR_CONF		(PCIE_CORE_CTRL_MGMT_BASE + 0x300)
+
+#define PCIE_CORE_INT \
+		(PCIE_CORE_INT_PRFPE | PCIE_CORE_INT_CRFPE | \
+		 PCIE_CORE_INT_RRPE | PCIE_CORE_INT_CRFO | \
+		 PCIE_CORE_INT_RT | PCIE_CORE_INT_RTR | \
+		 PCIE_CORE_INT_PE | PCIE_CORE_INT_MTR | \
+		 PCIE_CORE_INT_UCR | PCIE_CORE_INT_FCE | \
+		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
+		 PCIE_CORE_INT_MMVC)
+
+#define PCIE_RC_CONFIG_BASE		0xa00000
+#define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
+#define  PCIE_CORE_RC_CONF_SCC_SHIFT		16
+#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define  PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
+#define  PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
+#define  PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
+#define  PCIE_RC_CONFIG_LCS_LBMS		BIT(30)
+#define  PCIE_RC_CONFIG_LCS_LAMS		BIT(31)
+#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
+
+#define PCIE_CORE_AXI_CONF_BASE		0xc00000
+#define PCIE_CORE_OB_REGION_ADDR1	(PCIE_CORE_AXI_CONF_BASE + 0x4)
+#define PCIE_CORE_OB_REGION_DESC0	(PCIE_CORE_AXI_CONF_BASE + 0x8)
+#define PCIE_CORE_OB_REGION_DESC1	(PCIE_CORE_AXI_CONF_BASE + 0xc)
+#define PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
+#define PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	0xffffff00
+#define PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
+#define PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	0xffffff00
+
+#define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
+#define PCIE_RP_IB_ADDR_TRANS		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
 
 /* Size of one AXI Region (not Region 0) */
 #define AXI_REGION_SIZE				BIT(20)
@@ -120,53 +167,6 @@
 #define RC_REGION_0_PASS_BITS			(25 - 1)
 #define MAX_AXI_WRAPPER_REGION_NUM		33
 
-/*
- * The upper 16 bits of the PCIE_CLIENT registers are a write mask for the
- * lower 16 bits.  This allows atomic updates of the register without
- * locking.
- */
-#define HIWORD_UPDATE(mask, val)	((mask << 16) | val)
-
-#define ENCODE_LANES(x)			(((x >> 1) & 3) << 4)
-
-#define PCIE_CLIENT_CONF_ENABLE		HIWORD_UPDATE(0x0001, 0x0001)
-#define PCIE_CLIENT_LINK_TRAIN_ENABLE	HIWORD_UPDATE(0x0002, 0x0002)
-#define PCIE_CLIENT_CONF_LANE_NUM(x)	HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
-#define PCIE_CLIENT_GEN_SEL_2		HIWORD_UPDATE(0x0040, 0x0040)
-
-#define PCIE_CLIENT_LINK_STATUS_UP		0x3
-#define PCIE_CLIENT_LINK_STATUS_SHIFT		20
-#define PCIE_CLIENT_LINK_STATUS_MASK		0x3
-#define PCIE_CORE_PL_CONF_SPEED_5G		0x1
-#define PCIE_CORE_PL_CONF_SPEED_SHIFT		3
-#define PCIE_CORE_PL_CONF_SPEED_MASK		0x3
-#define PCIE_CORE_PL_CONF_LANE_SHIFT		1
-#define PCIE_CORE_PL_CONF_LANE_MASK		0x3
-#define PCIE_CORE_RC_CONF_SCC_SHIFT		16
-
-#define ROCKCHIP_PCIE_RPIFR1_INTR_MASK		GENMASK(8, 5)
-#define ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT		5
-
-#define PCIE_CORE_INT \
-		(PCIE_CORE_INT_PRFPE | PCIE_CORE_INT_CRFPE | \
-		 PCIE_CORE_INT_RRPE | PCIE_CORE_INT_CRFO | \
-		 PCIE_CORE_INT_RT | PCIE_CORE_INT_RTR | \
-		 PCIE_CORE_INT_PE | PCIE_CORE_INT_MTR | \
-		 PCIE_CORE_INT_UCR | PCIE_CORE_INT_FCE | \
-		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
-		 PCIE_CORE_INT_MMVC)
-
-#define PCIE_CLIENT_INT_LEGACY \
-	(PCIE_CLIENT_INT_INTA | PCIE_CLIENT_INT_INTB | \
-	PCIE_CLIENT_INT_INTC | PCIE_CLIENT_INT_INTD)
-
-#define PCIE_CLIENT_INT_CLI \
-	(PCIE_CLIENT_INT_CORR_ERR | PCIE_CLIENT_INT_NFATAL_ERR | \
-	PCIE_CLIENT_INT_FATAL_ERR | PCIE_CLIENT_INT_DPA | \
-	PCIE_CLIENT_INT_HOT_RST | PCIE_CLIENT_INT_MSG | \
-	PCIE_CLIENT_INT_LEGACY_DONE | PCIE_CLIENT_INT_LEGACY | \
-	PCIE_CLIENT_INT_PHY)
-
 struct rockchip_pcie {
 	void	__iomem *reg_base;		/* DT axi-base */
 	void	__iomem *apb_base;		/* DT apb-base */
