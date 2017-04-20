Return-Path: <SRS0=Uw6M=34=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=Uw6M=34=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Subject: [PATCH v4 2/2] PCI: Add tango PCIe host bridge support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>
CC: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight
	<david.laight@aculab.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, Mason
	<slash.tmp@free.fr>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
Message-ID: <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
Date: Thu, 20 Apr 2017 16:31:25 +0200
MIME-Version: 1.0
In-Reply-To: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

This driver is required to work around several hardware bugs in the
PCIe controller.

NB: Revision 1 does not support legacy interrupts, or IO space.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++++++
 drivers/pci/host/Kconfig                             |   8 ++
 drivers/pci/host/Makefile                            |   1 +
 drivers/pci/host/pcie-tango.c                        | 161 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h                              |   2 +
 5 files changed, 204 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
new file mode 100644
index 000000000000..3353b4e77309
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
@@ -0,0 +1,32 @@
+Sigma Designs Tango PCIe controller
+
+Required properties:
+
+- compatible: "sigma,smp8759-pcie"
+- reg: address/size of PCI configuration space, address/size of register area
+- device_type: "pci"
+- #size-cells: <2>
+- #address-cells: <3>
+- #interrupt-cells: <1>
+- ranges: translation from system to bus addresses
+- interrupts: spec for misc interrupts, spec for MSI
+- msi-controller
+
+http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
+http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
+
+Example:
+
+	pcie@2e000 {
+		compatible = "sigma,smp8759-pcie";
+		reg = <0x50000000 SZ_4M>, <0x2e000 0x100>;
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		#interrupt-cells = <1>;
+		ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 SZ_60M>;
+		msi-controller;
+		interrupts =
+			<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
+			<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
+	};
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a827c3..5183d9095c3a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -285,6 +285,14 @@ config PCIE_ROCKCHIP
 	  There is 1 internal PCIe port available to support GEN2 with
 	  4 slots.
 
+config PCIE_TANGO
+	bool "Tango PCIe controller"
+	depends on ARCH_TANGO && PCI_MSI && OF
+	select PCI_HOST_COMMON
+	help
+	  Say Y here to enable PCIe controller support for Sigma Designs
+	  Tango systems, such as SMP8759 and later chips.
+
 config VMD
 	depends on PCI_MSI && X86_64
 	tristate "Intel Volume Management Device Driver"
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 084cb4983645..fc7ea90196f3 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -32,4 +32,5 @@ obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
+obj-$(CONFIG_PCIE_TANGO) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
index ada8d35066ab..7eb74e82d325 100644
--- a/drivers/pci/host/pcie-tango.c
+++ b/drivers/pci/host/pcie-tango.c
@@ -230,3 +230,164 @@ static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie *pcie
 
 	return 0;
 }
+
+/*** HOST BRIDGE SUPPORT ***/
+
+static int smp8759_config_read(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *val)
+{
+	int ret;
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
+
+	/*
+	 * QUIRK #1
+	 * Reads in configuration space outside devfn 0 return garbage.
+	 */
+	if (devfn != 0)
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+	/*
+	 * QUIRK #2
+	 * Unfortunately, config and mem spaces are muxed.
+	 * Linux does not support such a setting, since drivers are free
+	 * to access mem space directly, at any time.
+	 * Therefore, we can only PRAY that config and mem space accesses
+	 * NEVER occur concurrently.
+	 */
+	writel_relaxed(1, pcie->mux);
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
+	writel_relaxed(0, pcie->mux);
+
+	return ret;
+}
+
+static int smp8759_config_write(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 val)
+{
+	int ret;
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
+
+	writel_relaxed(1, pcie->mux);
+	ret = pci_generic_config_write(bus, devfn, where, size, val);
+	writel_relaxed(0, pcie->mux);
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
+static int tango_check_pcie_link(void __iomem *test_out)
+{
+	int i;
+
+	writel_relaxed(16, test_out);
+	for (i = 0; i < 10; ++i) {
+		u32 ltssm_state = readl_relaxed(test_out) >> 8;
+		if ((ltssm_state & 0x1f) == 0xf) /* L0 */
+			return 0;
+		usleep_range(3000, 4000);
+	}
+
+	return -ENODEV;
+}
+
+static int smp8759_init(struct tango_pcie *pcie, void __iomem *base)
+{
+	pcie->mux		= base + 0x48;
+	pcie->msi_status	= base + 0x80;
+	pcie->msi_enable	= base + 0xa0;
+	pcie->msi_doorbell	= 0xa0000000 + 0x2e07c;
+
+	return tango_check_pcie_link(base + 0x74);
+}
+
+static int tango_pcie_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	void __iomem *base;
+	struct resource *res;
+	struct tango_pcie *pcie;
+	struct device *dev = &pdev->dev;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pcie);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (of_device_is_compatible(dev->of_node, "sigma,smp8759-pcie"))
+		ret = smp8759_init(pcie, base);
+
+	if (ret)
+		return ret;
+
+	ret = tango_msi_probe(pdev, pcie);
+	if (ret)
+		return ret;
+
+	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
+}
+
+static int tango_pcie_remove(struct platform_device *pdev)
+{
+	return tango_msi_remove(pdev);
+}
+
+static struct platform_driver tango_pcie_driver = {
+	.probe	= tango_pcie_probe,
+	.remove	= tango_pcie_remove,
+	.driver	= {
+		.name = KBUILD_MODNAME,
+		.of_match_table = tango_pcie_ids,
+	},
+};
+
+builtin_platform_driver(tango_pcie_driver);
+
+/*
+ * QUIRK #3
+ * The root complex advertizes the wrong device class.
+ * Header Type 1 is for PCI-to-PCI bridges.
+ */
+static void tango_fixup_class(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x24, tango_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x28, tango_fixup_class);
+
+/*
+ * QUIRK #4
+ * The root complex exposes a "fake" BAR, which is used to filter
+ * bus-to-system accesses. Only accesses within the range defined
+ * by this BAR are forwarded to the host, others are ignored.
+ *
+ * By default, the DMA framework expects an identity mapping,
+ * and DRAM0 is mapped at 0x80000000.
+ */
+static void tango_fixup_bar(struct pci_dev *dev)
+{
+	dev->non_compliant_bars = true;
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x24, tango_fixup_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x28, tango_fixup_bar);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f020ab4079d3..b577dbe46f8f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1369,6 +1369,8 @@
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
 #define PCI_DEVICE_ID_TTI_HPT372N	0x0009	/* apparently a 372N variant? */
 
+#define PCI_VENDOR_ID_SIGMA		0x1105
+
 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8763_0	0x0198
 #define PCI_DEVICE_ID_VIA_8380_0	0x0204
-- 
2.11.0
