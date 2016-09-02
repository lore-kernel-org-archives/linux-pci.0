Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932655AbcIBPyE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:54:04 -0400
Subject: [PATCH v2 01/15] Remove unused symbols, unnecessary parens,
 other minor comments from
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
Date: Fri, 02 Sep 2016 10:53:58 -0500
Message-ID: <20160902155358.8650.64973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Guenter.
---
 drivers/pci/host/pcie-rockchip.c |   69 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e77aec3..a7006be 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -38,7 +38,6 @@
 #include <linux/regmap.h>
 
 #define PCIE_CLIENT_BASE			0x0
-#define PCIE_RC_CONFIG_NORMAL_BASE		0x800000
 #define PCIE_RC_CONFIG_BASE			0xa00000
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2	0x90c
 #define PCIE_RC_CONFIG_LCSR			0xd0
@@ -126,9 +125,6 @@
 #define RC_REGION_0_ADDR_TRANS_H		0x00000000
 #define RC_REGION_0_ADDR_TRANS_L		0x00000000
 #define RC_REGION_0_PASS_BITS			(25 - 1)
-#define RC_REGION_1_ADDR_TRANS_H		0x00000000
-#define RC_REGION_1_ADDR_TRANS_L		0x00400000
-#define RC_REGION_1_PASS_BITS			(20 - 1)
 #define MAX_AXI_WRAPPER_REGION_NUM		33
 #define PCIE_CORE_LCSR_RETRAIN_LINK		BIT(5)
 #define PCIE_CLIENT_CONF_ENABLE			BIT(0)
@@ -147,15 +143,12 @@
 #define PCIE_CLIENT_MODE_SHIFT			6
 #define PCIE_CLIENT_MODE_MASK			0x1
 #define PCIE_CLIENT_GEN_SEL_2			1
-#define PCIE_CLIENT_GEN_SEL_1			0
 #define PCIE_CLIENT_GEN_SEL_SHIFT		7
 #define PCIE_CLIENT_GEN_SEL_MASK		0x1
 #define PCIE_CLIENT_LINK_STATUS_UP		0x3
 #define PCIE_CLIENT_LINK_STATUS_SHIFT		20
 #define PCIE_CLIENT_LINK_STATUS_MASK		0x3
-#define PCIE_CORE_PL_CONF_SPEED_2_5G		0x0
 #define PCIE_CORE_PL_CONF_SPEED_5G		0x1
-#define PCIE_CORE_PL_CONF_SPEED_8G		0x2
 #define PCIE_CORE_PL_CONF_SPEED_SHIFT		3
 #define PCIE_CORE_PL_CONF_SPEED_MASK		0x3
 #define PCIE_CORE_PL_CONF_LANE_SHIFT		1
@@ -174,11 +167,6 @@
 		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
 		 PCIE_CORE_INT_MMVC)
 
-#define PCIE_CLIENT_INT_SUBSYSTEM \
-	(PCIE_CLIENT_INT_PWR_STCG | PCIE_CLIENT_INT_HOT_PLUG | \
-	PCIE_CLIENT_INT_PHY | PCIE_CLIENT_INT_UDMA | \
-	PCIE_CLIENT_INT_LOCAL)
-
 #define PCIE_CLIENT_INT_LEGACY \
 	(PCIE_CLIENT_INT_INTA | PCIE_CLIENT_INT_INTB | \
 	PCIE_CLIENT_INT_INTC | PCIE_CLIENT_INT_INTD)
@@ -191,8 +179,8 @@
 	PCIE_CLIENT_INT_PHY)
 
 struct rockchip_pcie_port {
-	void	__iomem *reg_base;
-	void	__iomem *apb_base;
+	void	__iomem *reg_base;		/* DT axi-base */
+	void	__iomem *apb_base;		/* DT apb-base */
 	struct	phy *phy;
 	struct	reset_control *core_rst;
 	struct	reset_control *mgmt_rst;
@@ -240,7 +228,7 @@ static void rockchip_pcie_clr_bw_int(struct rockchip_pcie_port *port)
 	pcie_write(port, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
 }
 
-static int rockchip_pcie_valid_config(struct rockchip_pcie_port *pp,
+static int rockchip_pcie_valid_device(struct rockchip_pcie_port *pp,
 				      struct pci_bus *bus, int dev)
 {
 	/* access only one slot on each root port */
@@ -286,7 +274,7 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *pp,
 {
 	u32 mask, tmp, offset;
 
-	offset = (where & (~0x3));
+	offset = where & ~0x3;
 
 	if (size == 4) {
 		writel(val, pp->apb_base + PCIE_RC_CONFIG_BASE + offset);
@@ -357,7 +345,7 @@ static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 {
 	struct rockchip_pcie_port *pp = bus->sysdata;
 
-	if (!rockchip_pcie_valid_config(pp, bus, PCI_SLOT(devfn))) {
+	if (!rockchip_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -366,7 +354,6 @@ static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		return rockchip_pcie_rd_own_conf(pp, where, size, val);
 
 	return rockchip_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
-
 }
 
 static int rockchip_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
@@ -374,7 +361,7 @@ static int rockchip_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 {
 	struct rockchip_pcie_port *pp = bus->sysdata;
 
-	if (!rockchip_pcie_valid_config(pp, bus, PCI_SLOT(devfn)))
+	if (!rockchip_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (bus->number == pp->root_bus_nr)
@@ -516,7 +503,6 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
 			err = -ETIMEDOUT;
 			break;
 		}
-
 	}
 
 	/* Double check gen1 training */
@@ -744,11 +730,6 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 	regs = platform_get_resource_byname(pdev,
 					    IORESOURCE_MEM,
 					    "axi-base");
-	if (!regs) {
-		dev_err(dev, "missing axi-base property\n");
-		return -ENODEV;
-	}
-
 	port->reg_base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(port->reg_base))
 		return PTR_ERR(port->reg_base);
@@ -756,11 +737,6 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 	regs = platform_get_resource_byname(pdev,
 					    IORESOURCE_MEM,
 					    "apb-base");
-	if (!regs) {
-		dev_err(dev, "missing apb-base property\n");
-		return -ENODEV;
-	}
-
 	port->apb_base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(port->apb_base))
 		return PTR_ERR(port->apb_base);
@@ -774,38 +750,38 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
 
 	port->lanes = 1;
 	err = of_property_read_u32(node, "num-lanes", &port->lanes);
-	if (!err && ((port->lanes == 0) ||
-		     (port->lanes == 3) ||
-		     (port->lanes > 4))) {
-		dev_warn(dev, "invalid num-lanes, default use one lane\n");
+	if (!err && (port->lanes == 0 ||
+		     port->lanes == 3 ||
+		     port->lanes > 4)) {
+		dev_warn(dev, "invalid num-lanes, default to use one lane\n");
 		port->lanes = 1;
 	}
 
 	port->core_rst = devm_reset_control_get(dev, "core");
 	if (IS_ERR(port->core_rst)) {
 		if (PTR_ERR(port->core_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing core rst property in node\n");
+			dev_err(dev, "missing core reset property in node\n");
 		return PTR_ERR(port->core_rst);
 	}
 
 	port->mgmt_rst = devm_reset_control_get(dev, "mgmt");
 	if (IS_ERR(port->mgmt_rst)) {
 		if (PTR_ERR(port->mgmt_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt rst property in node\n");
+			dev_err(dev, "missing mgmt reset property in node\n");
 		return PTR_ERR(port->mgmt_rst);
 	}
 
 	port->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
 	if (IS_ERR(port->mgmt_sticky_rst)) {
 		if (PTR_ERR(port->mgmt_sticky_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt-sticky rst property in node\n");
+			dev_err(dev, "missing mgmt-sticky reset property in node\n");
 		return PTR_ERR(port->mgmt_sticky_rst);
 	}
 
 	port->pipe_rst = devm_reset_control_get(dev, "pipe");
 	if (IS_ERR(port->pipe_rst)) {
 		if (PTR_ERR(port->pipe_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pipe rst property in node\n");
+			dev_err(dev, "missing pipe reset property in node\n");
 		return PTR_ERR(port->pipe_rst);
 	}
 
@@ -991,7 +967,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *pp,
 
 	if (region_no >= MAX_AXI_WRAPPER_REGION_NUM)
 		return -EINVAL;
-	if ((num_pass_bits + 1) < 8)
+	if (num_pass_bits + 1 < 8)
 		return -EINVAL;
 	if (num_pass_bits > 63)
 		return -EINVAL;
@@ -1030,7 +1006,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *pp,
 
 	if (region_no > MAX_AXI_IB_ROOTPORT_REGION_NUM)
 		return -EINVAL;
-	if ((num_pass_bits + 1) < MIN_AXI_ADDR_BITS_PASSED)
+	if (num_pass_bits + 1 < MIN_AXI_ADDR_BITS_PASSED)
 		return -EINVAL;
 	if (num_pass_bits > 63)
 		return -EINVAL;
@@ -1055,7 +1031,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *bus, *child;
 	struct resource_entry *win;
 	resource_size_t io_base;
-	struct resource	*busn = NULL;
 	struct resource	*mem;
 	struct resource	*io;
 	phys_addr_t io_bus_addr = 0;
@@ -1154,14 +1129,14 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 			mem_bus_addr = mem->start - win->offset;
 			break;
 		case IORESOURCE_BUS:
-			busn = win->res;
+			port->root_bus_nr = win->res->start;
 			break;
 		default:
 			continue;
 		}
 	}
 
-	if (mem_size)
+	if (mem_size) {
 		for (reg_no = 0; reg_no < (mem_size >> 20); reg_no++) {
 			err = rockchip_pcie_prog_ob_atu(port, reg_no + 1,
 							AXI_WRAPPER_MEM_WRITE,
@@ -1174,6 +1149,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 				goto err_vpcie;
 			}
 		}
+	}
 
 	err = rockchip_pcie_prog_ib_atu(port, 2, 32 - 1, 0x0, 0);
 	if (err) {
@@ -1183,7 +1159,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	offset = mem_size >> 20;
 
-	if (io_size)
+	if (io_size) {
 		for (reg_no = 0; reg_no < (io_size >> 20); reg_no++) {
 			err = rockchip_pcie_prog_ob_atu(port,
 							reg_no + 1 + offset,
@@ -1197,12 +1173,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 				goto err_vpcie;
 			}
 		}
-
-	if (busn)
-		port->root_bus_nr = busn->start;
+	}
 
 	bus = pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, port, &res);
-
 	if (!bus) {
 		err = -ENOMEM;
 		goto err_vpcie;

