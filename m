Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <kishon@ti.com>,
        <nsekhar@ti.com>
Subject: [RFC PATCH] pci: controller: designware: Add EP mode support
Date: Tue, 13 Sep 2016 22:40:49 +0530
Message-ID: <1473786653-12759-8-git-send-email-kishon@ti.com>
In-Reply-To: <1473786653-12759-1-git-send-email-kishon@ti.com>
References: <1473786653-12759-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add endpoint mode support to designware driver. This uses the
EP Core layer introduced recently to add endpoint mode support.
*Any* function driver can now use this designware device
to achieve the EP functionality.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 ++-
 drivers/pci/controller/Kconfig                     |    5 +
 drivers/pci/controller/Makefile                    |    1 +
 drivers/pci/controller/pcie-designware-ep.c        |  228 ++++++++++++++++++++
 drivers/pci/controller/pcie-designware.c           |   30 +++
 drivers/pci/controller/pcie-designware.h           |   45 ++++
 6 files changed, 324 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-designware-ep.c

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 6c5322c..bb0b789 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -6,23 +6,27 @@ Required properties:
 - reg-names: Must be "config" for the PCIe configuration space.
     (The old way of getting the configuration address space from "ranges"
     is deprecated and should be avoided.)
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- device_type: set to "pci"
-- ranges: ranges for the PCI memory and I/O regions
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI properties
-	to define the mapping of the PCIe interface to interrupt
+- #address-cells (only for host mode): set to <3>
+- #size-cells (only for host mode): set to <2>
+- device_type (only for host mode): set to "pci"
+- ranges (only for host mode): ranges for the PCI memory and I/O regions
+- num-ib-windows (only for EP mode): number of inbound address translation
+	windows
+- num-ob-windows (only for EP mode): number of outbound address translation
+	windows
+- #interrupt-cells (only for host mode): set to <1>
+- interrupt-map-mask and interrupt-map (only for host mode): standard PCI
+	properties to define the mapping of the PCIe interface to interrupt
 	numbers.
 - num-lanes: number of lanes to use
 
 Optional properties:
 - num-lanes: number of lanes to use (this property should be specified unless
   the link is brought already up in BIOS)
-- reset-gpio: gpio pin number of power good signal
-- bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
-  specify this property, to keep backwards compatibility a range of 0x00-0xff
-  is assumed if not present)
+- reset-gpio (only for host mode): gpio pin number of power good signal
+- bus-range (only for host mode): PCI bus numbers covered (it is recommended
+  for new devicetrees to specify this property, to keep backwards compatibility
+  a range of 0x00-0xff is assumed if not present)
 - clocks: Must contain an entry for each entry in clock-names.
 	See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 249db74..8574828 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -78,6 +78,11 @@ config PCIE_DW_HOST
 	depends on PCI
 	select PCIE_DW
 
+config PCIE_DW_EP
+	bool
+	depends on PCI_ENDPOINT
+	select PCIE_DW
+
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
 	depends on SOC_EXYNOS5440
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index ee6bb85..11ef1e6 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
+obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/controller/pcie-designware-ep.c b/drivers/pci/controller/pcie-designware-ep.c
new file mode 100644
index 0000000..f683be9
--- /dev/null
+++ b/drivers/pci/controller/pcie-designware-ep.c
@@ -0,0 +1,228 @@
+/**
+ * pci-designware-ep.c - Synopsys Designware PCIe Endpoint controller driver
+ *
+ * Copyright (C) 2016 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "pcie-designware.h"
+
+static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
+{
+	u32 reg;
+
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, 0x0);
+	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, 0x0);
+}
+
+static int dw_pcie_ep_write_header(struct pci_epc *epc,
+				   struct pci_epf_header *hdr)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	void __iomem *base = pci->dbi_base;
+
+	dw_pcie_write_dbi(pci, base, PCI_VENDOR_ID, 0x2, hdr->vendorid);
+	dw_pcie_write_dbi(pci, base, PCI_DEVICE_ID, 0x2, hdr->deviceid);
+	dw_pcie_write_dbi(pci, base, PCI_REVISION_ID, 0x1, hdr->revid);
+	dw_pcie_write_dbi(pci, base, PCI_CLASS_PROG, 0x1, hdr->progif_code);
+	dw_pcie_write_dbi(pci, base, PCI_CLASS_DEVICE, 0x2,
+			  hdr->subclass_code | hdr->baseclass_code << 8);
+	dw_pcie_write_dbi(pci, base, PCI_CACHE_LINE_SIZE, 0x1,
+			  hdr->cache_line_size);
+	dw_pcie_write_dbi(pci, base, PCI_SUBSYSTEM_VENDOR_ID, 0x2,
+			  hdr->subsys_vendor_id);
+	dw_pcie_write_dbi(pci, base, PCI_SUBSYSTEM_ID, 0x2, hdr->subsys_id);
+	dw_pcie_write_dbi(pci, base, PCI_INTERRUPT_PIN, 0x1,
+			  hdr->interrupt_pin);
+
+	return 0;
+}
+
+static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
+				  dma_addr_t cpu_addr,
+				  enum dw_pcie_as_type as_type)
+{
+	int ret;
+	u32 free_win;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	free_win = find_first_zero_bit(&ep->ib_window_map,
+				       sizeof(ep->ib_window_map));
+	if (free_win >= ep->num_ib_windows) {
+		dev_err(pci->dev, "no free inbound window\n");
+		return -EINVAL;
+	}
+
+	ret = dw_pcie_prog_inbound_atu(pci, free_win, bar, cpu_addr,
+				       as_type);
+	if (ret < 0) {
+		dev_err(pci->dev, "Failed to program IB window\n");
+		return ret;
+	}
+
+	ep->bar_to_atu[bar] = free_win;
+	set_bit(free_win, &ep->ib_window_map);
+
+	return 0;
+}
+
+static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
+			      dma_addr_t bar_phys, size_t size, int flags)
+{
+	int ret;
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum dw_pcie_as_type as_type;
+	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+
+	if (!(flags & PCI_BASE_ADDRESS_SPACE))
+		as_type = DW_PCIE_AS_MEM;
+	else
+		as_type = DW_PCIE_AS_IO;
+
+	ret = dw_pcie_ep_inbound_atu(ep, bar, bar_phys, as_type);
+	if (ret)
+		return ret;
+
+	dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, size - 1);
+	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, flags);
+
+	return 0;
+}
+
+static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	void __iomem *base = pci->dbi_base;
+
+	dw_pcie_ep_reset_bar(pci, bar);
+
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
+			  PCIE_ATU_REGION_INBOUND | ep->bar_to_atu[bar]);
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4, ~PCIE_ATU_ENABLE);
+}
+
+static void *dw_pcie_ep_alloc_addr(struct pci_epc *epc, size_t size)
+{
+	/* TODO */
+	return NULL;
+}
+
+static void dw_pcie_ep_free_addr(struct pci_epc *epc)
+{
+	/* TODO */
+}
+
+static int dw_pcie_ep_raise_irq(struct pci_epc *epc,
+				enum pci_epc_irq_type type)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->raise_irq)
+		return -EINVAL;
+
+	return ep->ops->raise_irq(ep, type);
+}
+
+static int dw_pcie_ep_start(struct pci_epc *epc)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	if (!pci->ops->start_link)
+		return -EINVAL;
+
+	return pci->ops->start_link(pci);
+}
+
+static void dw_pcie_ep_stop(struct pci_epc *epc)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	if (!pci->ops->stop_link)
+		return;
+
+	pci->ops->stop_link(pci);
+}
+
+void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+	struct pci_epf *epf = epc->epf;
+
+	pci_epf_linkup(epf);
+}
+
+const struct pci_epc_ops epc_ops = {
+	.write_header		= dw_pcie_ep_write_header,
+	.set_bar		= dw_pcie_ep_set_bar,
+	.clear_bar		= dw_pcie_ep_clear_bar,
+	.alloc_addr_space	= dw_pcie_ep_alloc_addr,
+	.free_addr_space	= dw_pcie_ep_free_addr,
+	.raise_irq		= dw_pcie_ep_raise_irq,
+	.start			= dw_pcie_ep_start,
+	.stop			= dw_pcie_ep_stop,
+};
+
+int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	int ret;
+	enum pci_barno bar;
+	struct pci_epc *epc;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+
+	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
+	if (ret < 0) {
+		dev_err(dev, "unable to read *num-ib-windows* property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows);
+	if (ret < 0) {
+		dev_err(dev, "unable to read *num-ob-windows* property\n");
+		return ret;
+	}
+
+	for (bar = BAR_0; bar <= BAR_5; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+
+	if (ep->ops->ep_init)
+		ep->ops->ep_init(ep);
+
+	epc = devm_pci_epc_create(dev, &epc_ops);
+	if (IS_ERR(epc)) {
+		dev_err(dev, "failed to create epc device\n");
+		return PTR_ERR(epc);
+	}
+
+	ep->epc = epc;
+	epc_set_drvdata(epc, ep);
+	dw_pcie_setup(pci);
+
+	return 0;
+}
+
+MODULE_DESCRIPTION("Designware PCIe endpoint controller driver");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-designware.c b/drivers/pci/controller/pcie-designware.c
index e52a020..4c091ff 100644
--- a/drivers/pci/controller/pcie-designware.c
+++ b/drivers/pci/controller/pcie-designware.c
@@ -115,6 +115,36 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 	dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4, &val);
 }
 
+int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
+			     u64 cpu_addr, enum dw_pcie_as_type as_type)
+{
+	int type;
+	void __iomem *base = pci->dbi_base;
+
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
+			  PCIE_ATU_REGION_INBOUND | index);
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
+			  lower_32_bits(cpu_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
+			   upper_32_bits(cpu_addr));
+
+	switch (as_type) {
+	case DW_PCIE_AS_MEM:
+		type = PCIE_ATU_TYPE_MEM;
+		break;
+	case DW_PCIE_AS_IO:
+		type = PCIE_ATU_TYPE_IO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4, PCIE_ATU_ENABLE |
+			  PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
+	return 0;
+}
+
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
 	int retries;
diff --git a/drivers/pci/controller/pcie-designware.h b/drivers/pci/controller/pcie-designware.h
index 53eaa50..773bd35 100644
--- a/drivers/pci/controller/pcie-designware.h
+++ b/drivers/pci/controller/pcie-designware.h
@@ -18,6 +18,9 @@
 #include <linux/msi.h>
 #include <linux/pci.h>
 
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+
 /* Synopsis specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
@@ -82,6 +85,7 @@
 
 struct dw_pcie;
 struct pcie_port;
+struct dw_pcie_ep;
 
 enum dw_pcie_device_mode {
 	DW_PCIE_UNKNOWN_TYPE,
@@ -132,6 +136,27 @@ struct pcie_port {
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
+enum dw_pcie_as_type {
+	DW_PCIE_AS_UNKNOWN,
+	DW_PCIE_AS_MEM,
+	DW_PCIE_AS_IO,
+};
+
+struct dw_pcie_ep_ops {
+	void	(*ep_init)(struct dw_pcie_ep *ep);
+	int	(*raise_irq)(struct dw_pcie_ep *ep, enum pci_epc_irq_type type);
+};
+
+struct dw_pcie_ep {
+	struct pci_epc		*epc;
+	struct dw_pcie_ep_ops	*ops;
+	u8			bar_to_atu[6];
+	unsigned long		ib_window_map;
+	unsigned long		ob_window_map;
+	u32			num_ib_windows;
+	u32			num_ob_windows;
+};
+
 struct dw_pcie_ops {
 	void	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, int size,
 			    u32 *val);
@@ -149,15 +174,21 @@ struct dw_pcie {
 	u32			lanes;
 	const struct dw_pcie_ops *ops;
 	struct pcie_port	pp;
+	struct dw_pcie_ep	ep;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
 
+#define to_dw_pcie_from_ep(endpoint)   \
+		container_of((endpoint), struct dw_pcie, ep)
+
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
 			       u32 size);
+int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
+			     u64 cpu_addr, enum dw_pcie_as_type as_type);
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 void dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -166,6 +197,20 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, void *base, u32 reg,
 		       int size, u32 val);
 void dw_pcie_setup(struct dw_pcie *pci);
 
+#ifdef CONFIG_PCIE_DW_EP
+void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
+int dw_pcie_ep_init(struct dw_pcie_ep *ep);
+#else
+static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
+{
+}
+
+static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
-- 
1.7.9.5
