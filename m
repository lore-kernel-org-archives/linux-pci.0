Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11223 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbaDPEm5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 00:42:57 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'linux-pci' <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org,
	'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
In-reply-to: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
Subject: [RFC PATCH 1/2] PCI: designware: Add ARM64 PCI support
Date: Wed, 16 Apr 2014 13:42:56 +0900
Message-id: <000901cf592e$563bc8c0$02b35a40$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add ARM64 PCI support for Synopsys designware PCIe, by using
pcie arm64 arch support and creating generic pcie bridge from
device tree.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-designware.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 6d23d8c..fac0440 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -65,14 +65,27 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
+#ifdef CONFIG_ARM
 static struct hw_pci dw_pci;
+#endif
 
 static unsigned long global_io_offset;
 
+#ifdef CONFIG_ARM
 static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 {
 	return sys->private_data;
 }
+#endif
+
+#ifdef CONFIG_ARM64
+static inline struct pcie_port *sys_to_pcie(struct pcie_port *pp)
+{
+	return pp;
+}
+
+static struct pci_ops dw_pcie_ops;
+#endif
 
 int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
 {
@@ -381,7 +394,9 @@ static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 {
 	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, domain->host_data);
+#ifdef CONFIG_ARM
 	set_irq_flags(irq, IRQF_VALID);
+#endif
 
 	return 0;
 }
@@ -397,6 +412,10 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	struct of_pci_range_parser parser;
 	u32 val;
 	int i;
+#ifdef CONFIG_ARM64
+	struct pci_host_bridge *bridge;
+	resource_size_t lastbus;
+#endif
 
 	if (of_pci_range_parser_init(&parser, np)) {
 		dev_err(pp->dev, "missing ranges property\n");
@@ -489,6 +508,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 
+#ifdef CONFIG_ARM
 	dw_pci.nr_controllers = 1;
 	dw_pci.private_data = (void **)&pp;
 
@@ -497,6 +517,16 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 #ifdef CONFIG_PCI_DOMAINS
 	dw_pci.domain++;
 #endif
+#endif
+
+#ifdef CONFIG_ARM64
+	bridge = of_create_pci_host_bridge(pp->dev, &dw_pcie_ops, pp);
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
+
+	lastbus = pci_rescan_bus(bridge->bus);
+	pci_bus_update_busn_res_end(bridge->bus, lastbus);
+#endif
 
 	return 0;
 }
@@ -695,6 +725,7 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
+#ifdef CONFIG_ARM
 static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct pcie_port *pp;
@@ -758,6 +789,7 @@ static struct hw_pci dw_pci = {
 	.map_irq	= dw_pcie_map_irq,
 	.add_bus	= dw_pcie_add_bus,
 };
+#endif /* CONFIG_ARM */
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
-- 
1.7.10.4


