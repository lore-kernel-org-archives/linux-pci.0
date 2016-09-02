Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932644AbcIBPyc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:54:32 -0400
Subject: [PATCH v2 04/15] Rename struct rockchip_pcie_port to struct
 rockchip_pcie.
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
Date: Fri, 02 Sep 2016 10:54:27 -0500
Message-ID: <20160902155426.8650.40395.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


---
 drivers/pci/host/pcie-rockchip.c |   46 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 3cfb47a..63fb0ebc 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -178,7 +178,7 @@
 	PCIE_CLIENT_INT_LEGACY_DONE | PCIE_CLIENT_INT_LEGACY | \
 	PCIE_CLIENT_INT_PHY)
 
-struct rockchip_pcie_port {
+struct rockchip_pcie {
 	void	__iomem *reg_base;		/* DT axi-base */
 	void	__iomem *apb_base;		/* DT apb-base */
 	struct	phy *phy;
@@ -200,17 +200,17 @@ struct rockchip_pcie_port {
 	struct	irq_domain *irq_domain;
 };
 
-static u32 rockchip_pcie_read(struct rockchip_pcie_port *rockchip, u32 reg)
+static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
 {
 	return readl(rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_write(struct rockchip_pcie_port *rockchip, u32 val, u32 reg)
+static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val, u32 reg)
 {
 	writel(val, rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_enable_bw_int(struct rockchip_pcie_port *rockchip)
+static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
@@ -219,7 +219,7 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie_port *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
 }
 
-static void rockchip_pcie_clr_bw_int(struct rockchip_pcie_port *rockchip)
+static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
@@ -228,7 +228,7 @@ static void rockchip_pcie_clr_bw_int(struct rockchip_pcie_port *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_LCSR);
 }
 
-static int rockchip_pcie_valid_device(struct rockchip_pcie_port *rockchip,
+static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 				      struct pci_bus *bus, int dev)
 {
 	/* access only one slot on each root port */
@@ -245,7 +245,7 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie_port *rockchip,
 	return 1;
 }
 
-static int rockchip_pcie_rd_own_conf(struct rockchip_pcie_port *rockchip,
+static int rockchip_pcie_rd_own_conf(struct rockchip_pcie *rockchip,
 				     int where, int size, u32 *val)
 {
 	void __iomem *addr = rockchip->apb_base + PCIE_RC_CONFIG_BASE + where;
@@ -268,7 +268,7 @@ static int rockchip_pcie_rd_own_conf(struct rockchip_pcie_port *rockchip,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *rockchip,
+static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 				     int where, int size, u32 val)
 {
 	u32 mask, tmp, offset;
@@ -289,7 +289,7 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *rockchip,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *rockchip,
+static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 *val)
 {
@@ -316,7 +316,7 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *rockchip,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int rockchip_pcie_wr_other_conf(struct rockchip_pcie_port *rockchip,
+static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 val)
 {
@@ -342,7 +342,7 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie_port *rockchip,
 static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 				 int size, u32 *val)
 {
-	struct rockchip_pcie_port *rockchip = bus->sysdata;
+	struct rockchip_pcie *rockchip = bus->sysdata;
 
 	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn))) {
 		*val = 0xffffffff;
@@ -358,7 +358,7 @@ static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int rockchip_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 				 int where, int size, u32 val)
 {
-	struct rockchip_pcie_port *rockchip = bus->sysdata;
+	struct rockchip_pcie *rockchip = bus->sysdata;
 
 	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -378,7 +378,7 @@ static struct pci_ops rockchip_pcie_ops = {
  * rockchip_pcie_init_port - Initialize hardware
  * @rockchip: PCIe port information
  */
-static int rockchip_pcie_init_port(struct rockchip_pcie_port *rockchip)
+static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	int err;
 	u32 status;
@@ -579,7 +579,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie_port *rockchip)
 
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 {
-	struct rockchip_pcie_port *rockchip = arg;
+	struct rockchip_pcie *rockchip = arg;
 	u32 reg;
 	u32 sub_reg;
 
@@ -642,7 +642,7 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 
 static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 {
-	struct rockchip_pcie_port *rockchip = arg;
+	struct rockchip_pcie *rockchip = arg;
 	u32 reg;
 
 	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
@@ -684,7 +684,7 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct rockchip_pcie_port *rockchip;
+	struct rockchip_pcie *rockchip;
 	u32 reg;
 	u32 hwirq;
 	u32 virq;
@@ -717,7 +717,7 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
  *
  * Return: '0' on success and error value on failure
  */
-static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *rockchip)
+static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -874,7 +874,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *rockchip)
 	return 0;
 }
 
-static int rockchip_pcie_set_vpcie(struct rockchip_pcie_port *rockchip)
+static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 {
 	int err;
 
@@ -914,7 +914,7 @@ err_out:
 	return err;
 }
 
-static void rockchip_pcie_enable_interrupts(struct rockchip_pcie_port *rockchip)
+static void rockchip_pcie_enable_interrupts(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
 		   (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
@@ -936,7 +936,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.map = rockchip_pcie_intx_map,
 };
 
-static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *rockchip)
+static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
 	struct device_node *intc = of_get_next_child(dev->of_node, NULL);
@@ -956,7 +956,7 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *rockchip)
 	return 0;
 }
 
-static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *rockchip,
+static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
 				     int region_no, int type, u8 num_pass_bits,
 				     u32 lower_addr, u32 upper_addr)
 {
@@ -996,7 +996,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *rockchip,
 	return 0;
 }
 
-static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *rockchip,
+static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 				     int region_no, u8 num_pass_bits,
 				     u32 lower_addr, u32 upper_addr)
 {
@@ -1026,7 +1026,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *rockchip,
 
 static int rockchip_pcie_probe(struct platform_device *pdev)
 {
-	struct rockchip_pcie_port *rockchip;
+	struct rockchip_pcie *rockchip;
 	struct device *dev = &pdev->dev;
 	struct pci_bus *bus, *child;
 	struct resource_entry *win;

