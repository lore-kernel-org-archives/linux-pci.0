Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934707AbcIAQoZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Sep 2016 12:44:25 -0400
Subject: [PATCH 3/9] Always use "rockchip" as the pointer to per-device
 struct.
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
Date: Thu, 01 Sep 2016 11:44:16 -0500
Message-ID: <20160901164416.14195.88763.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160901163758.14195.15725.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |  488 +++++++++++++++++++-------------------
 1 file changed, 244 insertions(+), 244 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c9d0799..3cfb47a 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -200,56 +200,55 @@ struct rockchip_pcie_port {
 	struct	irq_domain *irq_domain;
 };
 
-static u32 rockchip_pcie_read(struct rockchip_pcie_port *port, u32 reg)
+static u32 rockchip_pcie_read(struct rockchip_pcie_port *rockchip, u32 reg)
 {
-	return readl(port->apb_base + reg);
+	return readl(rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_write(struct rockchip_pcie_port *port, u32 val, u32 reg)
+static void rockchip_pcie_write(struct rockchip_pcie_port *rockchip, u32 val, u32 reg)
 {
-	writel(val, port->apb_base + reg);
+	writel(val, rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_enable_bw_int(struct rockchip_pcie_port *port)
+static void rockchip_pcie_enable_bw_int(struct rockchip_pcie_port *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(port, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
 	status |= (PCIE_RC_CONFIG_LCSR_LBMIE | PCIE_RC_CONFIG_LCSR_LABIE);
-	rockchip_pcie_write(port, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
 }
 
-static void rockchip_pcie_clr_bw_int(struct rockchip_pcie_port *port)
+static void rockchip_pcie_clr_bw_int(struct rockchip_pcie_port *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(port, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
 	status |= (PCIE_RC_CONFIG_LCSR_LBMS | PCIE_RC_CONFIG_LCSR_LAMS);
-	rockchip_pcie_write(port, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
 }
 
-static int rockchip_pcie_valid_device(struct rockchip_pcie_port *pp,
+static int rockchip_pcie_valid_device(struct rockchip_pcie_port *rockchip,
 				      struct pci_bus *bus, int dev)
 {
 	/* access only one slot on each root port */
-	if (bus->number == pp->root_bus_nr && dev > 0)
+	if (bus->number == rockchip->root_bus_nr && dev > 0)
 		return 0;
 
 	/*
 	 * do not read more than one device on the bus directly attached
 	 * to RC's downstream side.
 	 */
-	if (bus->primary == pp->root_bus_nr && dev > 0)
+	if (bus->primary == rockchip->root_bus_nr && dev > 0)
 		return 0;
 
 	return 1;
 }
 
-static int rockchip_pcie_rd_own_conf(struct rockchip_pcie_port *pp,
-				     int where, int size,
-				     u32 *val)
+static int rockchip_pcie_rd_own_conf(struct rockchip_pcie_port *rockchip,
+				     int where, int size, u32 *val)
 {
-	void __iomem *addr = pp->apb_base + PCIE_RC_CONFIG_BASE + where;
+	void __iomem *addr = rockchip->apb_base + PCIE_RC_CONFIG_BASE + where;
 
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
 		*val = 0;
@@ -269,7 +268,7 @@ static int rockchip_pcie_rd_own_conf(struct rockchip_pcie_port *pp,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *pp,
+static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *rockchip,
 				     int where, int size, u32 val)
 {
 	u32 mask, tmp, offset;
@@ -277,20 +276,20 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *pp,
 	offset = where & ~0x3;
 
 	if (size == 4) {
-		writel(val, pp->apb_base + PCIE_RC_CONFIG_BASE + offset);
+		writel(val, rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset);
 		return PCIBIOS_SUCCESSFUL;
 	}
 
 	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
 
-	tmp = readl(pp->apb_base + PCIE_RC_CONFIG_BASE + offset) & mask;
+	tmp = readl(rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset) & mask;
 	tmp |= val << ((where & 0x3) * 8);
-	writel(tmp, pp->apb_base + PCIE_RC_CONFIG_BASE + offset);
+	writel(tmp, rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
+static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 *val)
 {
@@ -305,11 +304,11 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
 	}
 
 	if (size == 4) {
-		*val = readl(pp->reg_base + busdev);
+		*val = readl(rockchip->reg_base + busdev);
 	} else if (size == 2) {
-		*val = readw(pp->reg_base + busdev);
+		*val = readw(rockchip->reg_base + busdev);
 	} else if (size == 1) {
-		*val = readb(pp->reg_base + busdev);
+		*val = readb(rockchip->reg_base + busdev);
 	} else {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
@@ -317,7 +316,7 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int rockchip_pcie_wr_other_conf(struct rockchip_pcie_port *pp,
+static int rockchip_pcie_wr_other_conf(struct rockchip_pcie_port *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 val)
 {
@@ -329,11 +328,11 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie_port *pp,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (size == 4)
-		writel(val, pp->reg_base + busdev);
+		writel(val, rockchip->reg_base + busdev);
 	else if (size == 2)
-		writew(val, pp->reg_base + busdev);
+		writew(val, rockchip->reg_base + busdev);
 	else if (size == 1)
-		writeb(val, pp->reg_base + busdev);
+		writeb(val, rockchip->reg_base + busdev);
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -343,31 +342,31 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie_port *pp,
 static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 				 int size, u32 *val)
 {
-	struct rockchip_pcie_port *pp = bus->sysdata;
+	struct rockchip_pcie_port *rockchip = bus->sysdata;
 
-	if (!rockchip_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
+	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn))) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	if (bus->number == pp->root_bus_nr)
-		return rockchip_pcie_rd_own_conf(pp, where, size, val);
+	if (bus->number == rockchip->root_bus_nr)
+		return rockchip_pcie_rd_own_conf(rockchip, where, size, val);
 
-	return rockchip_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
+	return rockchip_pcie_rd_other_conf(rockchip, bus, devfn, where, size, val);
 }
 
 static int rockchip_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 				 int where, int size, u32 val)
 {
-	struct rockchip_pcie_port *pp = bus->sysdata;
+	struct rockchip_pcie_port *rockchip = bus->sysdata;
 
-	if (!rockchip_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
+	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (bus->number == pp->root_bus_nr)
-		return rockchip_pcie_wr_own_conf(pp, where, size, val);
+	if (bus->number == rockchip->root_bus_nr)
+		return rockchip_pcie_wr_own_conf(rockchip, where, size, val);
 
-	return rockchip_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
+	return rockchip_pcie_wr_other_conf(rockchip, bus, devfn, where, size, val);
 }
 
 static struct pci_ops rockchip_pcie_ops = {
@@ -377,51 +376,51 @@ static struct pci_ops rockchip_pcie_ops = {
 
 /**
  * rockchip_pcie_init_port - Initialize hardware
- * @port: PCIe port information
+ * @rockchip: PCIe port information
  */
-static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
+static int rockchip_pcie_init_port(struct rockchip_pcie_port *rockchip)
 {
 	int err;
 	u32 status;
 	unsigned long timeout;
 
-	gpiod_set_value(port->ep_gpio, 0);
+	gpiod_set_value(rockchip->ep_gpio, 0);
 
-	err = phy_init(port->phy);
+	err = phy_init(rockchip->phy);
 	if (err < 0) {
-		dev_err(port->dev, "fail to init phy, err %d\n", err);
+		dev_err(rockchip->dev, "fail to init phy, err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_assert(port->core_rst);
+	err = reset_control_assert(rockchip->core_rst);
 	if (err) {
-		dev_err(port->dev, "assert core_rst err %d\n", err);
+		dev_err(rockchip->dev, "assert core_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_assert(port->mgmt_rst);
+	err = reset_control_assert(rockchip->mgmt_rst);
 	if (err) {
-		dev_err(port->dev, "assert mgmt_rst err %d\n", err);
+		dev_err(rockchip->dev, "assert mgmt_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_assert(port->mgmt_sticky_rst);
+	err = reset_control_assert(rockchip->mgmt_sticky_rst);
 	if (err) {
-		dev_err(port->dev, "assert mgmt_sticky_rst err %d\n", err);
+		dev_err(rockchip->dev, "assert mgmt_sticky_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_assert(port->pipe_rst);
+	err = reset_control_assert(rockchip->pipe_rst);
 	if (err) {
-		dev_err(port->dev, "assert pipe_rst err %d\n", err);
+		dev_err(rockchip->dev, "assert pipe_rst err %d\n", err);
 		return err;
 	}
 
-	rockchip_pcie_write(port,
+	rockchip_pcie_write(rockchip,
 		   HIWORD_UPDATE(PCIE_CLIENT_CONF_ENABLE,
 				 PCIE_CLIENT_CONF_ENABLE_MASK,
 				 PCIE_CLIENT_CONF_ENABLE_SHIFT) |
-		   HIWORD_UPDATE(PCIE_CLIENT_CONF_LANE_NUM(port->lanes),
+		   HIWORD_UPDATE(PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes),
 				 PCIE_CLIENT_CONF_LANE_NUM_MASK,
 				 PCIE_CLIENT_CONF_LANE_NUM_SHIFT) |
 		   HIWORD_UPDATE(PCIE_CLIENT_MODE_RC,
@@ -435,33 +434,33 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 				 PCIE_CLIENT_GEN_SEL_SHIFT),
 		   PCIE_CLIENT_BASE);
 
-	err = phy_power_on(port->phy);
+	err = phy_power_on(rockchip->phy);
 	if (err) {
-		dev_err(port->dev, "fail to power on phy, err %d\n", err);
+		dev_err(rockchip->dev, "fail to power on phy, err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_deassert(port->core_rst);
+	err = reset_control_deassert(rockchip->core_rst);
 	if (err) {
-		dev_err(port->dev, "deassert core_rst err %d\n", err);
+		dev_err(rockchip->dev, "deassert core_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_deassert(port->mgmt_rst);
+	err = reset_control_deassert(rockchip->mgmt_rst);
 	if (err) {
-		dev_err(port->dev, "deassert mgmt_rst err %d\n", err);
+		dev_err(rockchip->dev, "deassert mgmt_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_deassert(port->mgmt_sticky_rst);
+	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
 	if (err) {
-		dev_err(port->dev, "deassert mgmt_sticky_rst err %d\n", err);
+		dev_err(rockchip->dev, "deassert mgmt_sticky_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_deassert(port->pipe_rst);
+	err = reset_control_deassert(rockchip->pipe_rst);
 	if (err) {
-		dev_err(port->dev, "deassert pipe_rst err %d\n", err);
+		dev_err(rockchip->dev, "deassert pipe_rst err %d\n", err);
 		return err;
 	}
 
@@ -471,29 +470,29 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 	 * reliable and enabling ASPM doesn't work.  This is a controller
 	 * bug we need to work around.
 	 */
-	status = rockchip_pcie_read(port, PCIE_RC_CONFIG_BASE +
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_BASE +
 				 PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
-	rockchip_pcie_write(port, status, PCIE_RC_CONFIG_BASE +
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE +
 				 PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
 
 	/* Enable Gen1 training */
-	rockchip_pcie_write(port,
+	rockchip_pcie_write(rockchip,
 		   HIWORD_UPDATE(PCIE_CLIENT_LINK_TRAIN_ENABLE,
 				 PCIE_CLIENT_LINK_TRAIN_MASK,
 				 PCIE_CLIENT_LINK_TRAIN_SHIFT),
 		   PCIE_CLIENT_BASE);
 
-	gpiod_set_value(port->ep_gpio, 1);
+	gpiod_set_value(rockchip->ep_gpio, 1);
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	timeout = jiffies + msecs_to_jiffies(500);
 
 	for (;;) {
-		status = rockchip_pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
+		status = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1);
 		if (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
 		      PCIE_CLIENT_LINK_STATUS_MASK) ==
 		      PCIE_CLIENT_LINK_STATUS_UP) {
-			dev_dbg(port->dev, "PCIe link training gen1 pass!\n");
+			dev_dbg(rockchip->dev, "PCIe link training gen1 pass!\n");
 			break;
 		}
 
@@ -507,12 +506,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 
 	/* Double check gen1 training */
 	if (err) {
-		status = rockchip_pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
+		status = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1);
 		err = (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
 			PCIE_CLIENT_LINK_STATUS_MASK) ==
 			PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
 		if (err) {
-			dev_err(port->dev, "PCIe link training gen1 timeout!\n");
+			dev_err(rockchip->dev, "PCIe link training gen1 timeout!\n");
 			return err;
 		}
 	}
@@ -521,19 +520,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 	 * Enable retrain for gen2. This should be configured only after
 	 * gen1 finished.
 	 */
-	status = rockchip_pcie_read(port,
+	status = rockchip_pcie_read(rockchip,
 			   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
 	status |= PCIE_CORE_LCSR_RETRAIN_LINK;
-	rockchip_pcie_write(port, status,
+	rockchip_pcie_write(rockchip, status,
 		   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
 
 	timeout = jiffies + msecs_to_jiffies(500);
 	for (;;) {
-		status = rockchip_pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
+		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_MGMT_BASE);
 		if (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
 		     PCIE_CORE_PL_CONF_SPEED_MASK) ==
 		     PCIE_CORE_PL_CONF_SPEED_5G) {
-			dev_dbg(port->dev, "PCIe link training gen2 pass!\n");
+			dev_dbg(rockchip->dev, "PCIe link training gen2 pass!\n");
 			break;
 		}
 
@@ -547,32 +546,32 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 
 	/* Double check gen2 training */
 	if (err) {
-		status = rockchip_pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
+		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_MGMT_BASE);
 		err = (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
 			PCIE_CORE_PL_CONF_SPEED_MASK) ==
 			PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
 		if (err)
-			dev_dbg(port->dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
+			dev_dbg(rockchip->dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
 	}
 
 	/* Check the final link width from negotiated lane counter from MGMT */
-	status = rockchip_pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
+	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_MGMT_BASE);
 	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
 			   PCIE_CORE_PL_CONF_LANE_MASK);
-	dev_dbg(port->dev, "current link width is x%d\n", status);
+	dev_dbg(rockchip->dev, "current link width is x%d\n", status);
 
-	rockchip_pcie_write(port, ROCKCHIP_VENDOR_ID, PCIE_RC_CONFIG_BASE);
-	rockchip_pcie_write(port, PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
+	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID, PCIE_RC_CONFIG_BASE);
+	rockchip_pcie_write(rockchip, PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
 		   PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_RID_CCR);
-	rockchip_pcie_write(port, 0x0, PCIE_CORE_CTRL_MGMT_BASE + PCIE_RC_BAR_CONF);
+	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_CTRL_MGMT_BASE + PCIE_RC_BAR_CONF);
 
-	rockchip_pcie_write(port, (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
+	rockchip_pcie_write(rockchip, (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
 		   PCIE_CORE_AXI_CONF_BASE);
-	rockchip_pcie_write(port, RC_REGION_0_ADDR_TRANS_H,
+	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
 		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_ADDR1);
-	rockchip_pcie_write(port, 0x0080000a,
+	rockchip_pcie_write(rockchip, 0x0080000a,
 		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC0);
-	rockchip_pcie_write(port, 0x0,
+	rockchip_pcie_write(rockchip, 0x0,
 		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC1);
 
 	return 0;
@@ -580,98 +579,98 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 {
-	struct rockchip_pcie_port *pp = arg;
+	struct rockchip_pcie_port *rockchip = arg;
 	u32 reg;
 	u32 sub_reg;
 
-	reg = rockchip_pcie_read(pp, PCIE_CLIENT_INT_STATUS);
+	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
 	if (reg & PCIE_CLIENT_INT_LOCAL) {
-		dev_dbg(pp->dev, "local interrupt received\n");
-		sub_reg = rockchip_pcie_read(pp, PCIE_CORE_INT_STATUS);
+		dev_dbg(rockchip->dev, "local interrupt received\n");
+		sub_reg = rockchip_pcie_read(rockchip, PCIE_CORE_INT_STATUS);
 		if (sub_reg & PCIE_CORE_INT_PRFPE)
-			dev_dbg(pp->dev, "parity error detected while reading from the PNP receive FIFO RAM\n");
+			dev_dbg(rockchip->dev, "parity error detected while reading from the PNP receive FIFO RAM\n");
 
 		if (sub_reg & PCIE_CORE_INT_CRFPE)
-			dev_dbg(pp->dev, "parity error detected while reading from the Completion Receive FIFO RAM\n");
+			dev_dbg(rockchip->dev, "parity error detected while reading from the Completion Receive FIFO RAM\n");
 
 		if (sub_reg & PCIE_CORE_INT_RRPE)
-			dev_dbg(pp->dev, "parity error detected while reading from replay buffer RAM\n");
+			dev_dbg(rockchip->dev, "parity error detected while reading from replay buffer RAM\n");
 
 		if (sub_reg & PCIE_CORE_INT_PRFO)
-			dev_dbg(pp->dev, "overflow occurred in the PNP receive FIFO\n");
+			dev_dbg(rockchip->dev, "overflow occurred in the PNP receive FIFO\n");
 
 		if (sub_reg & PCIE_CORE_INT_CRFO)
-			dev_dbg(pp->dev, "overflow occurred in the completion receive FIFO\n");
+			dev_dbg(rockchip->dev, "overflow occurred in the completion receive FIFO\n");
 
 		if (sub_reg & PCIE_CORE_INT_RT)
-			dev_dbg(pp->dev, "replay timer timed out\n");
+			dev_dbg(rockchip->dev, "replay timer timed out\n");
 
 		if (sub_reg & PCIE_CORE_INT_RTR)
-			dev_dbg(pp->dev, "replay timer rolled over after 4 transmissions of the same TLP\n");
+			dev_dbg(rockchip->dev, "replay timer rolled over after 4 transmissions of the same TLP\n");
 
 		if (sub_reg & PCIE_CORE_INT_PE)
-			dev_dbg(pp->dev, "phy error detected on receive side\n");
+			dev_dbg(rockchip->dev, "phy error detected on receive side\n");
 
 		if (sub_reg & PCIE_CORE_INT_MTR)
-			dev_dbg(pp->dev, "malformed TLP received from the link\n");
+			dev_dbg(rockchip->dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_UCR)
-			dev_dbg(pp->dev, "malformed TLP received from the link\n");
+			dev_dbg(rockchip->dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_FCE)
-			dev_dbg(pp->dev, "an error was observed in the flow control advertisements from the other side\n");
+			dev_dbg(rockchip->dev, "an error was observed in the flow control advertisements from the other side\n");
 
 		if (sub_reg & PCIE_CORE_INT_CT)
-			dev_dbg(pp->dev, "a request timed out waiting for completion\n");
+			dev_dbg(rockchip->dev, "a request timed out waiting for completion\n");
 
 		if (sub_reg & PCIE_CORE_INT_UTC)
-			dev_dbg(pp->dev, "unmapped TC error\n");
+			dev_dbg(rockchip->dev, "unmapped TC error\n");
 
 		if (sub_reg & PCIE_CORE_INT_MMVC)
-			dev_dbg(pp->dev, "MSI mask register changes\n");
+			dev_dbg(rockchip->dev, "MSI mask register changes\n");
 
-		rockchip_pcie_write(pp, sub_reg, PCIE_CORE_INT_STATUS);
+		rockchip_pcie_write(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
 	} else if (reg & PCIE_CLIENT_INT_PHY) {
-		dev_dbg(pp->dev, "phy link changes\n");
-		rockchip_pcie_clr_bw_int(pp);
+		dev_dbg(rockchip->dev, "phy link changes\n");
+		rockchip_pcie_clr_bw_int(rockchip);
 	}
 
-	rockchip_pcie_write(pp, reg & PCIE_CLIENT_INT_LOCAL, PCIE_CLIENT_INT_STATUS);
+	rockchip_pcie_write(rockchip, reg & PCIE_CLIENT_INT_LOCAL, PCIE_CLIENT_INT_STATUS);
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 {
-	struct rockchip_pcie_port *pp = arg;
+	struct rockchip_pcie_port *rockchip = arg;
 	u32 reg;
 
-	reg = rockchip_pcie_read(pp, PCIE_CLIENT_INT_STATUS);
+	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
 	if (reg & PCIE_CLIENT_INT_LEGACY_DONE)
-		dev_dbg(pp->dev, "legacy done interrupt received\n");
+		dev_dbg(rockchip->dev, "legacy done interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_MSG)
-		dev_dbg(pp->dev, "message done interrupt received\n");
+		dev_dbg(rockchip->dev, "message done interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_HOT_RST)
-		dev_dbg(pp->dev, "hot reset interrupt received\n");
+		dev_dbg(rockchip->dev, "hot reset interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_DPA)
-		dev_dbg(pp->dev, "dpa interrupt received\n");
+		dev_dbg(rockchip->dev, "dpa interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_FATAL_ERR)
-		dev_dbg(pp->dev, "fatal error interrupt received\n");
+		dev_dbg(rockchip->dev, "fatal error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_NFATAL_ERR)
-		dev_dbg(pp->dev, "no fatal error interrupt received\n");
+		dev_dbg(rockchip->dev, "no fatal error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_CORR_ERR)
-		dev_dbg(pp->dev, "correctable error interrupt received\n");
+		dev_dbg(rockchip->dev, "correctable error interrupt received\n");
 
 	if (reg & PCIE_CLIENT_INT_PHY)
-		dev_dbg(pp->dev, "phy interrupt received\n");
+		dev_dbg(rockchip->dev, "phy interrupt received\n");
 
-	rockchip_pcie_write(pp, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
+	rockchip_pcie_write(rockchip, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
 			      PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
 			      PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
 			      PCIE_CLIENT_INT_NFATAL_ERR |
@@ -685,15 +684,15 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct rockchip_pcie_port *port;
+	struct rockchip_pcie_port *rockchip;
 	u32 reg;
 	u32 hwirq;
 	u32 virq;
 
 	chained_irq_enter(chip, desc);
-	port = irq_desc_get_handler_data(desc);
+	rockchip = irq_desc_get_handler_data(desc);
 
-	reg = rockchip_pcie_read(port, PCIE_CLIENT_INT_STATUS);
+	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
 	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
 	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
 
@@ -701,11 +700,11 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 		hwirq = ffs(reg) - 1;
 		reg &= ~BIT(hwirq);
 
-		virq = irq_find_mapping(port->irq_domain, hwirq);
+		virq = irq_find_mapping(rockchip->irq_domain, hwirq);
 		if (virq)
 			generic_handle_irq(virq);
 		else
-			dev_err(port->dev, "unexpected IRQ, INT%d\n", hwirq);
+			dev_err(rockchip->dev, "unexpected IRQ, INT%d\n", hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -714,13 +713,13 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 
 /**
  * rockchip_pcie_parse_dt - Parse Device Tree
- * @port: PCIe port information
+ * @rockchip: PCIe port information
  *
  * Return: '0' on success and error value on failure
  */
-static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
+static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *rockchip)
 {
-	struct device *dev = port->dev;
+	struct device *dev = rockchip->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *node = dev->of_node;
 	struct resource *regs;
@@ -730,89 +729,89 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 	regs = platform_get_resource_byname(pdev,
 					    IORESOURCE_MEM,
 					    "axi-base");
-	port->reg_base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(port->reg_base))
-		return PTR_ERR(port->reg_base);
+	rockchip->reg_base = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(rockchip->reg_base))
+		return PTR_ERR(rockchip->reg_base);
 
 	regs = platform_get_resource_byname(pdev,
 					    IORESOURCE_MEM,
 					    "apb-base");
-	port->apb_base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(port->apb_base))
-		return PTR_ERR(port->apb_base);
+	rockchip->apb_base = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(rockchip->apb_base))
+		return PTR_ERR(rockchip->apb_base);
 
-	port->phy = devm_phy_get(dev, "pcie-phy");
-	if (IS_ERR(port->phy)) {
-		if (PTR_ERR(port->phy) != -EPROBE_DEFER)
+	rockchip->phy = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(rockchip->phy)) {
+		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
 			dev_err(dev, "missing phy\n");
-		return PTR_ERR(port->phy);
+		return PTR_ERR(rockchip->phy);
 	}
 
-	port->lanes = 1;
-	err = of_property_read_u32(node, "num-lanes", &port->lanes);
-	if (!err && (port->lanes == 0 ||
-		     port->lanes == 3 ||
-		     port->lanes > 4)) {
+	rockchip->lanes = 1;
+	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
+	if (!err && (rockchip->lanes == 0 ||
+		     rockchip->lanes == 3 ||
+		     rockchip->lanes > 4)) {
 		dev_warn(dev, "invalid num-lanes, default to use one lane\n");
-		port->lanes = 1;
+		rockchip->lanes = 1;
 	}
 
-	port->core_rst = devm_reset_control_get(dev, "core");
-	if (IS_ERR(port->core_rst)) {
-		if (PTR_ERR(port->core_rst) != -EPROBE_DEFER)
+	rockchip->core_rst = devm_reset_control_get(dev, "core");
+	if (IS_ERR(rockchip->core_rst)) {
+		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing core reset property in node\n");
-		return PTR_ERR(port->core_rst);
+		return PTR_ERR(rockchip->core_rst);
 	}
 
-	port->mgmt_rst = devm_reset_control_get(dev, "mgmt");
-	if (IS_ERR(port->mgmt_rst)) {
-		if (PTR_ERR(port->mgmt_rst) != -EPROBE_DEFER)
+	rockchip->mgmt_rst = devm_reset_control_get(dev, "mgmt");
+	if (IS_ERR(rockchip->mgmt_rst)) {
+		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing mgmt reset property in node\n");
-		return PTR_ERR(port->mgmt_rst);
+		return PTR_ERR(rockchip->mgmt_rst);
 	}
 
-	port->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
-	if (IS_ERR(port->mgmt_sticky_rst)) {
-		if (PTR_ERR(port->mgmt_sticky_rst) != -EPROBE_DEFER)
+	rockchip->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
+	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
+		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing mgmt-sticky reset property in node\n");
-		return PTR_ERR(port->mgmt_sticky_rst);
+		return PTR_ERR(rockchip->mgmt_sticky_rst);
 	}
 
-	port->pipe_rst = devm_reset_control_get(dev, "pipe");
-	if (IS_ERR(port->pipe_rst)) {
-		if (PTR_ERR(port->pipe_rst) != -EPROBE_DEFER)
+	rockchip->pipe_rst = devm_reset_control_get(dev, "pipe");
+	if (IS_ERR(rockchip->pipe_rst)) {
+		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing pipe reset property in node\n");
-		return PTR_ERR(port->pipe_rst);
+		return PTR_ERR(rockchip->pipe_rst);
 	}
 
-	port->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
-	if (IS_ERR(port->ep_gpio)) {
+	rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
+	if (IS_ERR(rockchip->ep_gpio)) {
 		dev_err(dev, "missing ep-gpios property in node\n");
-		return PTR_ERR(port->ep_gpio);
+		return PTR_ERR(rockchip->ep_gpio);
 	}
 
-	port->aclk_pcie = devm_clk_get(dev, "aclk");
-	if (IS_ERR(port->aclk_pcie)) {
+	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
+	if (IS_ERR(rockchip->aclk_pcie)) {
 		dev_err(dev, "aclk clock not found\n");
-		return PTR_ERR(port->aclk_pcie);
+		return PTR_ERR(rockchip->aclk_pcie);
 	}
 
-	port->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
-	if (IS_ERR(port->aclk_perf_pcie)) {
+	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
+	if (IS_ERR(rockchip->aclk_perf_pcie)) {
 		dev_err(dev, "aclk_perf clock not found\n");
-		return PTR_ERR(port->aclk_perf_pcie);
+		return PTR_ERR(rockchip->aclk_perf_pcie);
 	}
 
-	port->hclk_pcie = devm_clk_get(dev, "hclk");
-	if (IS_ERR(port->hclk_pcie)) {
+	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
+	if (IS_ERR(rockchip->hclk_pcie)) {
 		dev_err(dev, "hclk clock not found\n");
-		return PTR_ERR(port->hclk_pcie);
+		return PTR_ERR(rockchip->hclk_pcie);
 	}
 
-	port->clk_pcie_pm = devm_clk_get(dev, "pm");
-	if (IS_ERR(port->clk_pcie_pm)) {
+	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
+	if (IS_ERR(rockchip->clk_pcie_pm)) {
 		dev_err(dev, "pm clock not found\n");
-		return PTR_ERR(port->clk_pcie_pm);
+		return PTR_ERR(rockchip->clk_pcie_pm);
 	}
 
 	irq = platform_get_irq_byname(pdev, "sys");
@@ -822,7 +821,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
-			       IRQF_SHARED, "pcie-sys", port);
+			       IRQF_SHARED, "pcie-sys", rockchip);
 	if (err) {
 		dev_err(dev, "failed to request PCIe subsystem IRQ\n");
 		return err;
@@ -836,7 +835,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 
 	irq_set_chained_handler_and_data(irq,
 					 rockchip_pcie_legacy_int_handler,
-					 port);
+					 rockchip);
 
 	irq = platform_get_irq_byname(pdev, "client");
 	if (irq < 0) {
@@ -845,29 +844,29 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
-			       IRQF_SHARED, "pcie-client", port);
+			       IRQF_SHARED, "pcie-client", rockchip);
 	if (err) {
 		dev_err(dev, "failed to request PCIe client IRQ\n");
 		return err;
 	}
 
-	port->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
-	if (IS_ERR(port->vpcie3v3)) {
-		if (PTR_ERR(port->vpcie3v3) == -EPROBE_DEFER)
+	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
+	if (IS_ERR(rockchip->vpcie3v3)) {
+		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_info(dev, "no vpcie3v3 regulator found\n");
 	}
 
-	port->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
-	if (IS_ERR(port->vpcie1v8)) {
-		if (PTR_ERR(port->vpcie1v8) == -EPROBE_DEFER)
+	rockchip->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
+	if (IS_ERR(rockchip->vpcie1v8)) {
+		if (PTR_ERR(rockchip->vpcie1v8) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_info(dev, "no vpcie1v8 regulator found\n");
 	}
 
-	port->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
-	if (IS_ERR(port->vpcie0v9)) {
-		if (PTR_ERR(port->vpcie0v9) == -EPROBE_DEFER)
+	rockchip->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
+	if (IS_ERR(rockchip->vpcie0v9)) {
+		if (PTR_ERR(rockchip->vpcie0v9) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_info(dev, "no vpcie0v9 regulator found\n");
 	}
@@ -875,30 +874,30 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 	return 0;
 }
 
-static int rockchip_pcie_set_vpcie(struct rockchip_pcie_port *port)
+static int rockchip_pcie_set_vpcie(struct rockchip_pcie_port *rockchip)
 {
 	int err;
 
-	if (!IS_ERR(port->vpcie3v3)) {
-		err = regulator_enable(port->vpcie3v3);
+	if (!IS_ERR(rockchip->vpcie3v3)) {
+		err = regulator_enable(rockchip->vpcie3v3);
 		if (err) {
-			dev_err(port->dev, "fail to enable vpcie3v3 regulator\n");
+			dev_err(rockchip->dev, "fail to enable vpcie3v3 regulator\n");
 			goto err_out;
 		}
 	}
 
-	if (!IS_ERR(port->vpcie1v8)) {
-		err = regulator_enable(port->vpcie1v8);
+	if (!IS_ERR(rockchip->vpcie1v8)) {
+		err = regulator_enable(rockchip->vpcie1v8);
 		if (err) {
-			dev_err(port->dev, "fail to enable vpcie1v8 regulator\n");
+			dev_err(rockchip->dev, "fail to enable vpcie1v8 regulator\n");
 			goto err_disable_3v3;
 		}
 	}
 
-	if (!IS_ERR(port->vpcie0v9)) {
-		err = regulator_enable(port->vpcie0v9);
+	if (!IS_ERR(rockchip->vpcie0v9)) {
+		err = regulator_enable(rockchip->vpcie0v9);
 		if (err) {
-			dev_err(port->dev, "fail to enable vpcie0v9 regulator\n");
+			dev_err(rockchip->dev, "fail to enable vpcie0v9 regulator\n");
 			goto err_disable_1v8;
 		}
 	}
@@ -906,22 +905,22 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie_port *port)
 	return 0;
 
 err_disable_1v8:
-	if (!IS_ERR(port->vpcie1v8))
-		regulator_disable(port->vpcie1v8);
+	if (!IS_ERR(rockchip->vpcie1v8))
+		regulator_disable(rockchip->vpcie1v8);
 err_disable_3v3:
-	if (!IS_ERR(port->vpcie3v3))
-		regulator_disable(port->vpcie3v3);
+	if (!IS_ERR(rockchip->vpcie3v3))
+		regulator_disable(rockchip->vpcie3v3);
 err_out:
 	return err;
 }
 
-static void rockchip_pcie_enable_interrupts(struct rockchip_pcie_port *port)
+static void rockchip_pcie_enable_interrupts(struct rockchip_pcie_port *rockchip)
 {
-	rockchip_pcie_write(port, (PCIE_CLIENT_INT_CLI << 16) &
+	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
 		   (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
-	rockchip_pcie_write(port, (u32)(~PCIE_CORE_INT), PCIE_CORE_INT_MASK);
+	rockchip_pcie_write(rockchip, (u32)(~PCIE_CORE_INT), PCIE_CORE_INT_MASK);
 
-	rockchip_pcie_enable_bw_int(port);
+	rockchip_pcie_enable_bw_int(rockchip);
 }
 
 static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -937,9 +936,9 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.map = rockchip_pcie_intx_map,
 };
 
-static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
+static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *rockchip)
 {
-	struct device *dev = pp->dev;
+	struct device *dev = rockchip->dev;
 	struct device_node *intc = of_get_next_child(dev->of_node, NULL);
 
 	if (!intc) {
@@ -947,8 +946,9 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
 		return -EINVAL;
 	}
 
-	pp->irq_domain = irq_domain_add_linear(intc, 4, &intx_domain_ops, pp);
-	if (!pp->irq_domain) {
+	rockchip->irq_domain = irq_domain_add_linear(intc, 4,
+						    &intx_domain_ops, rockchip);
+	if (!rockchip->irq_domain) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
 		return -EINVAL;
 	}
@@ -956,7 +956,7 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
 	return 0;
 }
 
-static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *pp,
+static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *rockchip,
 				     int region_no, int type, u8 num_pass_bits,
 				     u32 lower_addr, u32 upper_addr)
 {
@@ -980,7 +980,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *pp,
 			return -EINVAL;
 	}
 
-	aw_base = pp->apb_base + PCIE_CORE_AXI_CONF_BASE;
+	aw_base = rockchip->apb_base + PCIE_CORE_AXI_CONF_BASE;
 	aw_base += (region_no << OB_REG_SIZE_SHIFT);
 
 	ob_addr_0 = num_pass_bits & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS;
@@ -996,7 +996,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *pp,
 	return 0;
 }
 
-static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *pp,
+static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *rockchip,
 				     int region_no, u8 num_pass_bits,
 				     u32 lower_addr, u32 upper_addr)
 {
@@ -1011,7 +1011,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *pp,
 	if (num_pass_bits > 63)
 		return -EINVAL;
 
-	aw_base = pp->apb_base + PCIE_CORE_AXI_INBOUND_BASE;
+	aw_base = rockchip->apb_base + PCIE_CORE_AXI_INBOUND_BASE;
 	aw_base += (region_no << IB_ROOT_PORT_REG_SIZE_SHIFT);
 
 	ib_addr_0 = num_pass_bits & PCIE_CORE_IB_REGION_ADDR0_NUM_BITS;
@@ -1026,7 +1026,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *pp,
 
 static int rockchip_pcie_probe(struct platform_device *pdev)
 {
-	struct rockchip_pcie_port *port;
+	struct rockchip_pcie_port *rockchip;
 	struct device *dev = &pdev->dev;
 	struct pci_bus *bus, *child;
 	struct resource_entry *win;
@@ -1046,55 +1046,55 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return -ENODEV;
 
-	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
+	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
+	if (!rockchip)
 		return -ENOMEM;
 
-	port->dev = dev;
+	rockchip->dev = dev;
 
-	err = rockchip_pcie_parse_dt(port);
+	err = rockchip_pcie_parse_dt(rockchip);
 	if (err)
 		return err;
 
-	err = clk_prepare_enable(port->aclk_pcie);
+	err = clk_prepare_enable(rockchip->aclk_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable aclk_pcie clock\n");
 		goto err_aclk_pcie;
 	}
 
-	err = clk_prepare_enable(port->aclk_perf_pcie);
+	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
 		goto err_aclk_perf_pcie;
 	}
 
-	err = clk_prepare_enable(port->hclk_pcie);
+	err = clk_prepare_enable(rockchip->hclk_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable hclk_pcie clock\n");
 		goto err_hclk_pcie;
 	}
 
-	err = clk_prepare_enable(port->clk_pcie_pm);
+	err = clk_prepare_enable(rockchip->clk_pcie_pm);
 	if (err) {
 		dev_err(dev, "unable to enable hclk_pcie clock\n");
 		goto err_pcie_pm;
 	}
 
-	err = rockchip_pcie_set_vpcie(port);
+	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
-		dev_err(port->dev, "failed to set vpcie regulator\n");
+		dev_err(rockchip->dev, "failed to set vpcie regulator\n");
 		goto err_set_vpcie;
 	}
 
-	err = rockchip_pcie_init_port(port);
+	err = rockchip_pcie_init_port(rockchip);
 	if (err)
 		goto err_vpcie;
 
-	platform_set_drvdata(pdev, port);
+	platform_set_drvdata(pdev, rockchip);
 
-	rockchip_pcie_enable_interrupts(port);
+	rockchip_pcie_enable_interrupts(rockchip);
 
-	err = rockchip_pcie_init_irq_domain(port);
+	err = rockchip_pcie_init_irq_domain(rockchip);
 	if (err < 0)
 		goto err_vpcie;
 
@@ -1117,7 +1117,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 			io_bus_addr = io->start - win->offset;
 			err = pci_remap_iospace(io, io_base);
 			if (err) {
-				dev_warn(port->dev, "error %d: failed to map resource %pR\n",
+				dev_warn(rockchip->dev, "error %d: failed to map resource %pR\n",
 					 err, io);
 				continue;
 			}
@@ -1129,7 +1129,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 			mem_bus_addr = mem->start - win->offset;
 			break;
 		case IORESOURCE_BUS:
-			port->root_bus_nr = win->res->start;
+			rockchip->root_bus_nr = win->res->start;
 			break;
 		default:
 			continue;
@@ -1138,7 +1138,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	if (mem_size) {
 		for (reg_no = 0; reg_no < (mem_size >> 20); reg_no++) {
-			err = rockchip_pcie_prog_ob_atu(port, reg_no + 1,
+			err = rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1,
 							AXI_WRAPPER_MEM_WRITE,
 							20 - 1,
 							mem_bus_addr +
@@ -1151,7 +1151,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = rockchip_pcie_prog_ib_atu(port, 2, 32 - 1, 0x0, 0);
+	err = rockchip_pcie_prog_ib_atu(rockchip, 2, 32 - 1, 0x0, 0);
 	if (err) {
 		dev_err(dev, "program RC mem inbound ATU failed\n");
 		goto err_vpcie;
@@ -1161,7 +1161,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	if (io_size) {
 		for (reg_no = 0; reg_no < (io_size >> 20); reg_no++) {
-			err = rockchip_pcie_prog_ob_atu(port,
+			err = rockchip_pcie_prog_ob_atu(rockchip,
 							reg_no + 1 + offset,
 							AXI_WRAPPER_IO_WRITE,
 							20 - 1,
@@ -1175,7 +1175,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bus = pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, port, &res);
+	bus = pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, rockchip, &res);
 	if (!bus) {
 		err = -ENOMEM;
 		goto err_vpcie;
@@ -1193,20 +1193,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return err;
 
 err_vpcie:
-	if (!IS_ERR(port->vpcie3v3))
-		regulator_disable(port->vpcie3v3);
-	if (!IS_ERR(port->vpcie1v8))
-		regulator_disable(port->vpcie1v8);
-	if (!IS_ERR(port->vpcie0v9))
-		regulator_disable(port->vpcie0v9);
+	if (!IS_ERR(rockchip->vpcie3v3))
+		regulator_disable(rockchip->vpcie3v3);
+	if (!IS_ERR(rockchip->vpcie1v8))
+		regulator_disable(rockchip->vpcie1v8);
+	if (!IS_ERR(rockchip->vpcie0v9))
+		regulator_disable(rockchip->vpcie0v9);
 err_set_vpcie:
-	clk_disable_unprepare(port->clk_pcie_pm);
+	clk_disable_unprepare(rockchip->clk_pcie_pm);
 err_pcie_pm:
-	clk_disable_unprepare(port->hclk_pcie);
+	clk_disable_unprepare(rockchip->hclk_pcie);
 err_hclk_pcie:
-	clk_disable_unprepare(port->aclk_perf_pcie);
+	clk_disable_unprepare(rockchip->aclk_perf_pcie);
 err_aclk_perf_pcie:
-	clk_disable_unprepare(port->aclk_pcie);
+	clk_disable_unprepare(rockchip->aclk_pcie);
 err_aclk_pcie:
 	return err;
 }

