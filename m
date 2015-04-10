Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>, Liviu Dudau <liviu.dudau@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: [PATCH 4/5] pci: designware: remove pci_common_init_dev()
Date: Fri, 10 Apr 2015 09:38:26 +0200
Message-Id: <1428651507-32554-5-git-send-email-gabriel.fernandez@linaro.org>
In-Reply-To: <1428651507-32554-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1428651507-32554-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Call directly pci_*() instead of using pci_common_init_dev().
Enforce error handling in probe.
It also allows st pcie driver not to declare IO space:
pci_common_init_dev() is assigning one by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pci/host/pcie-designware.c | 62 ++++++++++++++++++++------------------
 drivers/pci/host/pcie-designware.h |  2 ++
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1f4ea6f..d4b1bf7 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -67,8 +67,6 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
-static struct hw_pci dw_pci;
-
 static unsigned long global_io_offset;
 
 static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
@@ -342,6 +340,9 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = dw_pcie_msi_map,
 };
 
+static int dw_pcie_setup(struct pci_sys_data *sys);
+static struct pci_bus *dw_pcie_scan_bus(struct pci_sys_data *sys);
+
 int __init dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
@@ -352,6 +353,9 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	u32 val, na, ns;
 	const __be32 *addrp;
 	int i, index, ret;
+	struct list_head *resources = &pp->sysdata.resources;
+
+	INIT_LIST_HEAD(resources);
 
 	/* Find the address cell size and the number of cells in order to get
 	 * the untranslated address.
@@ -504,13 +508,17 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 #ifdef CONFIG_PCI_MSI
 	dw_pcie_msi_chip.dev = pp->dev;
-	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
+	pp->sysdata.msi_ctrl = &dw_pcie_msi_chip;
 #endif
 
-	dw_pci.nr_controllers = 1;
-	dw_pci.private_data = (void **)&pp;
+	pp->sysdata.private_data = pp;
 
-	pci_common_init_dev(pp->dev, &dw_pci);
+	ret = dw_pcie_setup(&pp->sysdata);
+	if (ret)
+		return ret;
+
+	if (!dw_pcie_scan_bus(&pp->sysdata))
+		return -ENXIO;
 
 	return 0;
 }
@@ -701,15 +709,19 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
-static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
+static int dw_pcie_setup(struct pci_sys_data *sys)
 {
 	struct pcie_port *pp;
+	int err;
 
 	pp = sys_to_pcie(sys);
 
 	if (global_io_offset < SZ_1M && pp->io_size > 0) {
 		sys->io_offset = global_io_offset - pp->io_bus_addr;
-		pci_ioremap_io(global_io_offset, pp->io_base);
+		err = pci_ioremap_io(global_io_offset, pp->io_base);
+		if (err)
+			return err;
+
 		global_io_offset += SZ_64K;
 		pci_add_resource_offset(&sys->resources, &pp->io,
 					sys->io_offset);
@@ -719,10 +731,10 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
 	pci_add_resource(&sys->resources, &pp->busn);
 
-	return 1;
+	return 0;
 }
 
-static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+static struct pci_bus *dw_pcie_scan_bus(struct pci_sys_data *sys)
 {
 	struct pci_bus *bus;
 	struct pcie_port *pp = sys_to_pcie(sys);
@@ -738,27 +750,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	if (bus && pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
-	return bus;
-}
-
-static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
-	int irq;
-
-	irq = of_irq_parse_and_map_pci(dev, slot, pin);
-	if (!irq)
-		irq = pp->irq;
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
 
-	return irq;
+	return bus;
 }
 
-static struct hw_pci dw_pci = {
-	.setup		= dw_pcie_setup,
-	.scan		= dw_pcie_scan_bus,
-	.map_irq	= dw_pcie_map_irq,
-};
-
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
@@ -822,8 +820,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	/* setup command register */
 	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
 	val &= 0xffff0000;
-	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
+
+	if (!pp->io_size)
+		val |= PCI_COMMAND_IO;
+
+	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
+
 	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
 }
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..c647092 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -46,12 +46,14 @@ struct pcie_port {
 	struct resource		io;
 	struct resource		mem;
 	struct resource		busn;
+	struct pci_sys_data	sysdata;
 	int			irq;
 	u32			lanes;
 	struct pcie_host_ops	*ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
+	bool			disable_io_support;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-- 
1.9.1

