Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
From: Duc Dang <dhdang@apm.com>
To: helgaas@kernel.org,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jcm@redhat.com,
	tn@semihalf.com,
	patches@apm.com,
	Duc Dang <dhdang@apm.com>
Subject: [RFC PATCH] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
Date: Sat, 17 Sep 2016 07:24:38 -0700
Message-Id: <1474122278-32525-1-git-send-email-dhdang@apm.com>
List-ID: <linux-pci.vger.kernel.org>

PCIe controller in X-Gene SoCs is not ECAM compliant: software
needs to configure additional concontroller register to address
device at bus:dev:function.

This patch depends on "ECAM quirks handling for ARM64 platforms"
series (http://www.spinics.net/lists/arm-kernel/msg530692.html)
to address the limitation above for X-Gene PCIe controller.

The quirk will only be applied for X-Gene PCIe MCFG table with
OEM revison 1, 2, 3 or 4 (PCIe controller v1 and v2 on X-Gene SoCs).

Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/acpi/pci_mcfg.c           |  32 +++++
 drivers/pci/host/Makefile         |   2 +-
 drivers/pci/host/pci-xgene-ecam.c | 280 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ecam.h          |   5 +
 4 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pci-xgene-ecam.c

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index ddf338b..adce35f 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -123,6 +123,38 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	{ "CAVIUM", "THUNDERX", 2, 13, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
 	  MCFG_RES_EMPTY},
 #endif
+#ifdef CONFIG_PCI_XGENE
+	{"APM   ", "XGENE   ", 1, 0, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 1, 1, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 1, 2, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 1, 3, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 1, 4, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 2, 0, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 2, 1, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 2, 2, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 2, 3, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 2, 4, MCFG_BUS_ANY,
+		&xgene_v1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 3, 0, MCFG_BUS_ANY,
+		&xgene_v2_1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 3, 1, MCFG_BUS_ANY,
+		&xgene_v2_1_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 4, 0, MCFG_BUS_ANY,
+		&xgene_v2_2_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 4, 1, MCFG_BUS_ANY,
+		&xgene_v2_2_pcie_ecam_ops, MCFG_RES_EMPTY},
+	{"APM   ", "XGENE   ", 4, 2, MCFG_BUS_ANY,
+		&xgene_v2_2_pcie_ecam_ops, MCFG_RES_EMPTY},
+#endif
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 8843410..af4f505 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
-obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
+obj-$(CONFIG_PCI_XGENE) += pci-xgene.o pci-xgene-ecam.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
diff --git a/drivers/pci/host/pci-xgene-ecam.c b/drivers/pci/host/pci-xgene-ecam.c
new file mode 100644
index 0000000..b66a04f
--- /dev/null
+++ b/drivers/pci/host/pci-xgene-ecam.c
@@ -0,0 +1,280 @@
+/*
+ * APM X-Gene PCIe ECAM fixup driver
+ *
+ * Copyright (c) 2016, Applied Micro Circuits Corporation
+ * Author:
+ *	Duc Dang <dhdang@apm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/platform_device.h>
+#include <linux/pci-ecam.h>
+
+#ifdef CONFIG_ACPI
+#define RTDID			0x160
+#define ROOT_CAP_AND_CTRL	0x5C
+
+/* PCIe IP version */
+#define XGENE_PCIE_IP_VER_UNKN	0
+#define XGENE_PCIE_IP_VER_1	1
+#define XGENE_PCIE_IP_VER_2	2
+
+#define XGENE_CSR_LENGTH	0x10000
+
+struct xgene_pcie_acpi_root {
+	void __iomem *csr_base;
+	u32 version;
+};
+
+static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
+{
+	struct xgene_pcie_acpi_root *xgene_root;
+	struct device *dev = cfg->parent;
+	u32 csr_base;
+
+	xgene_root = devm_kzalloc(dev, sizeof(*xgene_root), GFP_KERNEL);
+	if (!xgene_root)
+		return -ENOMEM;
+
+	switch (cfg->res.start) {
+	case 0xE0D0000000ULL:
+		csr_base = 0x1F2B0000;
+		break;
+	case 0xD0D0000000ULL:
+		csr_base = 0x1F2C0000;
+		break;
+	case 0x90D0000000ULL:
+		csr_base = 0x1F2D0000;
+		break;
+	case 0xA0D0000000ULL:
+		csr_base = 0x1F500000;
+		break;
+	case 0xC0D0000000ULL:
+		csr_base = 0x1F510000;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	xgene_root->csr_base = ioremap(csr_base, XGENE_CSR_LENGTH);
+	if (!xgene_root->csr_base) {
+		kfree(xgene_root);
+		return -ENODEV;
+	}
+
+	xgene_root->version = XGENE_PCIE_IP_VER_1;
+
+	cfg->priv = xgene_root;
+
+	return 0;
+}
+
+static int xgene_v2_1_pcie_ecam_init(struct pci_config_window *cfg)
+{
+	struct xgene_pcie_acpi_root *xgene_root;
+	struct device *dev = cfg->parent;
+	resource_size_t csr_base;
+
+	xgene_root = devm_kzalloc(dev, sizeof(*xgene_root), GFP_KERNEL);
+	if (!xgene_root)
+		return -ENOMEM;
+
+	switch (cfg->res.start) {
+	case 0xC0D0000000ULL:
+		csr_base = 0x1F2B0000;
+		break;
+	case 0xA0D0000000ULL:
+		csr_base = 0x1F2C0000;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	xgene_root->csr_base = ioremap(csr_base, XGENE_CSR_LENGTH);
+	if (!xgene_root->csr_base) {
+		kfree(xgene_root);
+		return -ENODEV;
+	}
+
+	xgene_root->version = XGENE_PCIE_IP_VER_2;
+
+	cfg->priv = xgene_root;
+
+	return 0;
+}
+
+static int xgene_v2_2_pcie_ecam_init(struct pci_config_window *cfg)
+{
+	struct xgene_pcie_acpi_root *xgene_root;
+	struct device *dev = cfg->parent;
+	resource_size_t csr_base;
+
+	xgene_root = devm_kzalloc(dev, sizeof(*xgene_root), GFP_KERNEL);
+	if (!xgene_root)
+		return -ENOMEM;
+
+	switch (cfg->res.start) {
+	case 0xE0D0000000ULL:
+		csr_base = 0x1F2B0000;
+		break;
+	case 0xA0D0000000ULL:
+		csr_base = 0x1F500000;
+		break;
+	case 0x90D0000000ULL:
+		csr_base = 0x1F2D0000;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	xgene_root->csr_base = ioremap(csr_base, XGENE_CSR_LENGTH);
+	if (!xgene_root->csr_base) {
+		kfree(xgene_root);
+		return -ENODEV;
+	}
+
+	xgene_root->version = XGENE_PCIE_IP_VER_2;
+
+	cfg->priv = xgene_root;
+
+	return 0;
+}
+/*
+ * For Configuration request, RTDID register is used as Bus Number,
+ * Device Number and Function number of the header fields.
+ */
+static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct xgene_pcie_acpi_root *port = cfg->priv;
+	unsigned int b, d, f;
+	u32 rtdid_val = 0;
+
+	b = bus->number;
+	d = PCI_SLOT(devfn);
+	f = PCI_FUNC(devfn);
+
+	if (!pci_is_root_bus(bus))
+		rtdid_val = (b << 8) | (d << 3) | f;
+
+	writel(rtdid_val, port->csr_base + RTDID);
+	/* read the register back to ensure flush */
+	readl(port->csr_base + RTDID);
+}
+
+/*
+ * X-Gene PCIe port uses BAR0-BAR1 of RC's configuration space as
+ * the translation from PCI bus to native BUS.  Entire DDR region
+ * is mapped into PCIe space using these registers, so it can be
+ * reached by DMA from EP devices.  The BAR0/1 of bridge should be
+ * hidden during enumeration to avoid the sizing and resource allocation
+ * by PCIe core.
+ */
+static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
+{
+	if (pci_is_root_bus(bus) && ((offset == PCI_BASE_ADDRESS_0) ||
+				     (offset == PCI_BASE_ADDRESS_1)))
+		return true;
+
+	return false;
+}
+
+void __iomem *xgene_pcie_ecam_map_bus(struct pci_bus *bus,
+				      unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	unsigned int busn = bus->number;
+	void __iomem *base;
+
+	if (busn < cfg->busr.start || busn > cfg->busr.end)
+		return NULL;
+
+	if ((pci_is_root_bus(bus) && devfn != 0) ||
+	    xgene_pcie_hide_rc_bars(bus, where))
+		return NULL;
+
+	xgene_pcie_set_rtdid_reg(bus, devfn);
+
+	if (busn > cfg->busr.start)
+		base = cfg->win + (1 << cfg->ops->bus_shift);
+	else
+		base = cfg->win;
+
+	return base + where;
+}
+
+static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct xgene_pcie_acpi_root *port = cfg->priv;
+
+	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
+	    PCIBIOS_SUCCESSFUL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/*
+	* The v1 controller has a bug in its Configuration Request
+	* Retry Status (CRS) logic: when CRS is enabled and we read the
+	* Vendor and Device ID of a non-existent device, the controller
+	* fabricates return data of 0xFFFF0001 ("device exists but is not
+	* ready") instead of 0xFFFFFFFF ("device does not exist").  This
+	* causes the PCI core to retry the read until it times out.
+	* Avoid this by not claiming to support CRS.
+	*/
+	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
+	    ((where & ~0x3) == ROOT_CAP_AND_CTRL))
+		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
+
+	if (size <= 2)
+		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
+	.bus_shift	= 16,
+	.init		= xgene_v1_pcie_ecam_init,
+	.pci_ops	= {
+		.map_bus	= xgene_pcie_ecam_map_bus,
+		.read		= xgene_pcie_config_read32,
+		.write		= pci_generic_config_write,
+	}
+};
+
+struct pci_ecam_ops xgene_v2_1_pcie_ecam_ops = {
+	.bus_shift	= 16,
+	.init		= xgene_v2_1_pcie_ecam_init,
+	.pci_ops	= {
+		.map_bus	= xgene_pcie_ecam_map_bus,
+		.read		= xgene_pcie_config_read32,
+		.write		= pci_generic_config_write,
+	}
+};
+
+struct pci_ecam_ops xgene_v2_2_pcie_ecam_ops = {
+	.bus_shift	= 16,
+	.init		= xgene_v2_2_pcie_ecam_init,
+	.pci_ops	= {
+		.map_bus	= xgene_pcie_ecam_map_bus,
+		.read		= xgene_pcie_config_read32,
+		.write		= pci_generic_config_write,
+	}
+};
+#endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 35f0e81..40da3e7 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -65,6 +65,11 @@ extern struct pci_ecam_ops pci_thunder_pem_ops;
 #ifdef CONFIG_PCI_HOST_THUNDER_ECAM
 extern struct pci_ecam_ops pci_thunder_ecam_ops;
 #endif
+#ifdef CONFIG_PCI_XGENE
+extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops;
+extern struct pci_ecam_ops xgene_v2_1_pcie_ecam_ops;
+extern struct pci_ecam_ops xgene_v2_2_pcie_ecam_ops;
+#endif
 
 #ifdef CONFIG_PCI_HOST_GENERIC
 /* for DT-based PCI controllers that support ECAM */
-- 
1.9.1
