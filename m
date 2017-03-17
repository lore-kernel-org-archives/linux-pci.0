Return-Path: <SRS0=B/+H=22=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=B/+H=22=free.fr=slash.tmp@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>
From: Mason <slash.tmp@free.fr>
Subject: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
Message-ID: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
Date: Fri, 17 Mar 2017 17:11:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

This is version 0.001 pre-alpha.

I have several questions embedded as comments in the code.
Bjorn, can you tell me if something looks really wrong,
or if this driver can be accepted in this shape?

Regards.
---
 drivers/pci/host/pcie-tango.c | 125 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 drivers/pci/host/pcie-tango.c

diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
new file mode 100644
index 000000000000..9d7fed75fd1d
--- /dev/null
+++ b/drivers/pci/host/pcie-tango.c
@@ -0,0 +1,125 @@
+#include <linux/pci-ecam.h>
+
+#define VENDOR_SIGMA	0x1105
+
+/*
+ * How do I reach dev->driver_data in the config accessors?
+ */
+static void __iomem *mux;
+
+static int smp8759_config_read(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *val)
+{
+	int ret;
+
+	/*
+	 * QUIRK #1
+	 * Reads in configuration space outside devfn 0 return garbage.
+	 */
+	if (devfn != 0) {
+		*val = 0xffffffff; /* ~0 means "nothing here" right? */
+		return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
+	}
+
+	/*
+	 * QUIRK #2
+	 * The root complex advertizes a fake BAR, which is used to filter
+	 * bus-to-cpu requests. Hide it from Linux.
+	 */
+	if (where == PCI_BASE_ADDRESS_0 && bus->number == 0) {
+		*val = 0; /* 0 or ~0 to hide the BAR from Linux? */
+		return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
+	}
+
+	/*
+	 * QUIRK #3
+	 * Unfortunately, config and mem spaces are muxed.
+	 * Linux does not support such a setting, since drivers are free
+	 * to access mem space directly, at any time.
+	 * Therefore, we can only PRAY that config and mem space accesses
+	 * NEVER occur concurrently.
+	 */
+	writel(1, mux);
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
+	writel(0, mux);
+
+	return ret;
+}
+
+static int smp8759_config_write(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 val)
+{
+	int ret;
+
+	writel(1, mux);
+	ret = pci_generic_config_write(bus, devfn, where, size, val);
+	writel(0, mux);
+
+	return ret;
+}
+
+static struct pci_ecam_ops smp8759_ecam_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= smp8759_config_read,
+		.write		= smp8759_config_write,
+	}
+};
+
+static const struct of_device_id tango_pcie_ids[] = {
+	{ .compatible = "sigma,smp8759-pcie" },
+	{ /* sentinel */ },
+};
+
+static int tango_pcie_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	mux = base + 0x48;
+
+	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
+}
+
+static struct platform_driver tango_pcie_driver = {
+	.probe = tango_pcie_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = tango_pcie_ids,
+	},
+};
+
+/*
+ * This should probably be module_platform_driver ?
+ */
+builtin_platform_driver(tango_pcie_driver);
+
+/*
+ * QUIRK #4
+ * The root complex advertizes the wrong device class.
+ * Header Type 1 are handled by PCI-to-PCI bridges.
+ */
+static void tango_fixup_class(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
+
+/*
+ * QUIRK #5
+ * Only transfers within the BAR are forwarded to the host.
+ * By default, the DMA framework expects that
+ * PCI address 0x8000_0000 -> CPU address 0x8000_0000
+ * which is where DRAM0 is mapped.
+ */
+static void tango_fixup_bar(struct pci_dev *dev)
+{
+        pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
+}
+DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
-- 
2.10.0
