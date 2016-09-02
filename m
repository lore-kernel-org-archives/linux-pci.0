Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932327AbcIBPzR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:55:17 -0400
Subject: [PATCH v2 09/15] Move CSR bases into definition.
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
Date: Fri, 02 Sep 2016 10:55:09 -0500
Message-ID: <20160902155509.8650.75307.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of this:

  #define PCIE_RC_CONFIG_LCS		0xd0
  read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);

do this:

  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
  read(rockchip, PCIE_RC_CONFIG_LCS);

Mostly trivial, but rockchip_pcie_prog_ob_atu() and
rockchip_pcie_prog_ib_atu() are a little more complicated.
---
 drivers/pci/host/pcie-rockchip.c |  116 ++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index a2dd196..6edfce5 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -39,8 +39,8 @@
 
 #define PCIE_CLIENT_BASE			0x0
 #define PCIE_RC_CONFIG_BASE			0xa00000
-#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	0x90c
-#define PCIE_RC_CONFIG_LCS			0xd0
+#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	(PCIE_RC_CONFIG_BASE + 0x90c)
+#define PCIE_RC_CONFIG_LCS			(PCIE_RC_CONFIG_BASE + 0x0d0)
 #define  PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
 #define  PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
 #define  PCIE_RC_CONFIG_LCS_LABIE		BIT(11)
@@ -49,9 +49,9 @@
 #define PCIE_CORE_CTRL_MGMT_BASE		0x900000
 #define PCIE_CORE_AXI_CONF_BASE			0xc00000
 #define PCIE_CORE_AXI_INBOUND_BASE		0xc00800
-#define PCIE_CLIENT_BASIC_STATUS1		0x48
-#define PCIE_CLIENT_INT_MASK			0x4c
-#define PCIE_CLIENT_INT_STATUS			0x50
+#define PCIE_CLIENT_BASIC_STATUS1		(PCIE_CLIENT_BASE + 0x48)
+#define PCIE_CLIENT_INT_MASK			(PCIE_CLIENT_BASE + 0x4c)
+#define PCIE_CLIENT_INT_STATUS			(PCIE_CLIENT_BASE + 0x50)
 #define  PCIE_CLIENT_INT_LEGACY_DONE		BIT(15)
 #define  PCIE_CLIENT_INT_MSG			BIT(14)
 #define  PCIE_CLIENT_INT_HOT_RST		BIT(13)
@@ -68,18 +68,18 @@
 #define  PCIE_CLIENT_INT_PHY			BIT(2)
 #define  PCIE_CLIENT_INT_HOT_PLUG		BIT(1)
 #define  PCIE_CLIENT_INT_PWR_STCG		BIT(0)
-#define PCIE_RC_CONFIG_RID_CCR			0x8
-#define PCIE_RC_BAR_CONF			0x300
-#define PCIE_CORE_OB_REGION_ADDR1		0x4
-#define PCIE_CORE_OB_REGION_DESC0		0x8
-#define PCIE_CORE_OB_REGION_DESC1		0xc
+#define PCIE_RC_CONFIG_RID_CCR			(PCIE_RC_CONFIG_BASE + 0x08)
+#define PCIE_RC_BAR_CONF			(PCIE_CORE_CTRL_MGMT_BASE + 0x300)
+#define PCIE_CORE_OB_REGION_ADDR1		(PCIE_CORE_AXI_CONF_BASE + 0x4)
+#define PCIE_CORE_OB_REGION_DESC0		(PCIE_CORE_AXI_CONF_BASE + 0x8)
+#define PCIE_CORE_OB_REGION_DESC1		(PCIE_CORE_AXI_CONF_BASE + 0xc)
 #define PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
 #define PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	0xffffff00
 #define PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
 #define PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	0xffffff00
-#define PCIE_RP_IB_ADDR_TRANS			0x4
-#define PCIE_CORE_INT_MASK			0x900210
-#define PCIE_CORE_INT_STATUS			0x90020c
+#define PCIE_RP_IB_ADDR_TRANS			(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
+#define PCIE_CORE_INT_MASK			(PCIE_CORE_CTRL_MGMT_BASE + 0x210)
+#define PCIE_CORE_INT_STATUS			(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
 #define  PCIE_CORE_INT_PRFPE			BIT(0)
 #define  PCIE_CORE_INT_CRFPE			BIT(1)
 #define  PCIE_CORE_INT_RRPE			BIT(2)
@@ -194,7 +194,8 @@ static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
 	return readl(rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val, u32 reg)
+static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val,
+				u32 reg)
 {
 	writel(val, rockchip->apb_base + reg);
 }
@@ -203,18 +204,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
 	status |= (PCIE_RC_CONFIG_LCS_LBMIE | PCIE_RC_CONFIG_LCS_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
 	status |= (PCIE_RC_CONFIG_LCS_LBMS | PCIE_RC_CONFIG_LCS_LAMS);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
 }
 
 static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
@@ -456,10 +457,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 * reliable and enabling ASPM doesn't work.  This is a controller
 	 * bug we need to work around.
 	 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE +
-				 PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE +
-				 PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
@@ -471,7 +470,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	timeout = jiffies + msecs_to_jiffies(500);
 
 	for (;;) {
-		status = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1);
+		status = rockchip_pcie_read(rockchip,
+					    PCIE_CLIENT_BASIC_STATUS1);
 		if (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
 		      PCIE_CLIENT_LINK_STATUS_MASK) ==
 		      PCIE_CLIENT_LINK_STATUS_UP) {
@@ -489,7 +489,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	/* Double check gen1 training */
 	if (err) {
-		status = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1);
+		status = rockchip_pcie_read(rockchip,
+					    PCIE_CLIENT_BASIC_STATUS1);
 		err = (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
 			PCIE_CLIENT_LINK_STATUS_MASK) ==
 			PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
@@ -503,11 +504,9 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 * Enable retrain for gen2. This should be configured only after
 	 * gen1 finished.
 	 */
-	status = rockchip_pcie_read(rockchip,
-			   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
-	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
-	rockchip_pcie_write(rockchip, status,
-		   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status |= PCIE_CORE_LCS_RETRAIN_LINK;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
 
 	timeout = jiffies + msecs_to_jiffies(500);
 	for (;;) {
@@ -543,19 +542,20 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			   PCIE_CORE_PL_CONF_LANE_MASK);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
-	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID, PCIE_RC_CONFIG_BASE);
-	rockchip_pcie_write(rockchip, PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
-		   PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_RID_CCR);
-	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_CTRL_MGMT_BASE + PCIE_RC_BAR_CONF);
+	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
+			    PCIE_RC_CONFIG_BASE);
+	rockchip_pcie_write(rockchip,
+			    PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
+			    PCIE_RC_CONFIG_RID_CCR);
+	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
 
-	rockchip_pcie_write(rockchip, (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
-		   PCIE_CORE_AXI_CONF_BASE);
+	rockchip_pcie_write(rockchip,
+			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
+			    PCIE_CORE_AXI_CONF_BASE);
 	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
-		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_ADDR1);
-	rockchip_pcie_write(rockchip, 0x0080000a,
-		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC0);
-	rockchip_pcie_write(rockchip, 0x0,
-		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC1);
+			    PCIE_CORE_OB_REGION_ADDR1);
+	rockchip_pcie_write(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
+	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
 
 	return 0;
 }
@@ -619,7 +619,8 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 		rockchip_pcie_clr_bw_int(rockchip);
 	}
 
-	rockchip_pcie_write(rockchip, reg & PCIE_CLIENT_INT_LOCAL, PCIE_CLIENT_INT_STATUS);
+	rockchip_pcie_write(rockchip, reg & PCIE_CLIENT_INT_LOCAL,
+			    PCIE_CLIENT_INT_STATUS);
 
 	return IRQ_HANDLED;
 }
@@ -903,8 +904,9 @@ err_out:
 static void rockchip_pcie_enable_interrupts(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
-		   (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
-	rockchip_pcie_write(rockchip, (u32)(~PCIE_CORE_INT), PCIE_CORE_INT_MASK);
+			    (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
+	rockchip_pcie_write(rockchip, (u32)(~PCIE_CORE_INT),
+			    PCIE_CORE_INT_MASK);
 
 	rockchip_pcie_enable_bw_int(rockchip);
 }
@@ -949,7 +951,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
 	u32 ob_addr_0;
 	u32 ob_addr_1;
 	u32 ob_desc_0;
-	void __iomem *aw_base;
+	void __iomem *aw_offset;
 
 	if (region_no >= MAX_AXI_WRAPPER_REGION_NUM)
 		return -EINVAL;
@@ -966,18 +968,21 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
 			return -EINVAL;
 	}
 
-	aw_base = rockchip->apb_base + PCIE_CORE_AXI_CONF_BASE;
-	aw_base += (region_no << OB_REG_SIZE_SHIFT);
+	aw_offset = (region_no << OB_REG_SIZE_SHIFT);
 
 	ob_addr_0 = num_pass_bits & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS;
 	ob_addr_0 |= lower_addr & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR;
 	ob_addr_1 = upper_addr;
 	ob_desc_0 = (1 << 23 | type);
 
-	writel(ob_addr_0, aw_base);
-	writel(ob_addr_1, aw_base + PCIE_CORE_OB_REGION_ADDR1);
-	writel(ob_desc_0, aw_base + PCIE_CORE_OB_REGION_DESC0);
-	writel(0, aw_base + PCIE_CORE_OB_REGION_DESC1);
+	rockchip_pcie_writel(rockchip, ob_addr_0,
+			     PCIE_CORE_AXI_CONF_BASE + aw_offset);
+	rockchip_pcie_writel(rockchip, ob_addr_1,
+			     PCIE_CORE_OB_REGION_ADDR1 + aw_offset);
+	rockchip_pcie_writel(rockchip, ob_desc_0,
+			     PCIE_CORE_OB_REGION_DESC0 + aw_offset);
+	rockchip_pcie_writel(rockchip, 0,
+			     PCIE_CORE_OB_REGION_DESC1 + aw_offset);
 
 	return 0;
 }
@@ -988,7 +993,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 {
 	u32 ib_addr_0;
 	u32 ib_addr_1;
-	void __iomem *aw_base;
+	void __iomem *aw_offset;
 
 	if (region_no > MAX_AXI_IB_ROOTPORT_REGION_NUM)
 		return -EINVAL;
@@ -997,15 +1002,16 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 	if (num_pass_bits > 63)
 		return -EINVAL;
 
-	aw_base = rockchip->apb_base + PCIE_CORE_AXI_INBOUND_BASE;
-	aw_base += (region_no << IB_ROOT_PORT_REG_SIZE_SHIFT);
+	aw_offset = (region_no << IB_ROOT_PORT_REG_SIZE_SHIFT);
 
 	ib_addr_0 = num_pass_bits & PCIE_CORE_IB_REGION_ADDR0_NUM_BITS;
 	ib_addr_0 |= (lower_addr << 8) & PCIE_CORE_IB_REGION_ADDR0_LO_ADDR;
 	ib_addr_1 = upper_addr;
 
-	writel(ib_addr_0, aw_base);
-	writel(ib_addr_1, aw_base + PCIE_RP_IB_ADDR_TRANS);
+	rockchip_pcie_writel(rockchip, ib_addr_0,
+			     PCIE_CORE_AXI_INBOUND_BASE + aw_offset);
+	rockchip_pcie_writel(rockchip, ib_addr_1,
+			     PCIE_RP_IB_ADDR_TRANS + aw_offset);
 
 	return 0;
 }

