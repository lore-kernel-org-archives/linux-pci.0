Return-Path: <SRS0=nDxn=5Z=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=nDxn=5Z=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Mason <slash.tmp@free.fr>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
Message-ID: <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
Date: Tue, 20 Jun 2017 10:17:40 +0200
MIME-Version: 1.0
In-Reply-To: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

This driver is required to work around several hardware bugs
in the PCIe controller.

NB: Revision 1 does not support legacy interrupts, or IO space.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/pci/host/Kconfig      |   8 +++
 drivers/pci/host/Makefile     |   1 +
 drivers/pci/host/pcie-tango.c | 164 ++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/pci_ids.h       |   2 +
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/pci/host/pcie-tango.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a827c3..5183d9095c3a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -285,6 +285,14 @@ config PCIE_ROCKCHIP
 =09  There is 1 internal PCIe port available to support GEN2 with
 =09  4 slots.
=20
+config PCIE_TANGO
+=09bool "Tango PCIe controller"
+=09depends on ARCH_TANGO && PCI_MSI && OF
+=09select PCI_HOST_COMMON
+=09help
+=09  Say Y here to enable PCIe controller support for Sigma Designs
+=09  Tango systems, such as SMP8759 and later chips.
+
 config VMD
 =09depends on PCI_MSI && X86_64
 =09tristate "Intel Volume Management Device Driver"
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 084cb4983645..fc7ea90196f3 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -32,4 +32,5 @@ obj-$(CONFIG_PCI_HOST_THUNDER_PEM) +=3D pci-thunder-pem.o
 obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP) +=3D pcie-rockchip.o
+obj-$(CONFIG_PCIE_TANGO) +=3D pcie-tango.o
 obj-$(CONFIG_VMD) +=3D vmd.o
diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
new file mode 100644
index 000000000000..67aaadcc1c5e
--- /dev/null
+++ b/drivers/pci/host/pcie-tango.c
@@ -0,0 +1,164 @@
+#include <linux/pci-ecam.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
+#define MSI_MAX 256
+
+#define SMP8759_MUX=09=090x48
+#define SMP8759_TEST_OUT=090x74
+
+struct tango_pcie {
+=09void __iomem *mux;
+};
+
+/*** HOST BRIDGE SUPPORT ***/
+
+static int smp8759_config_read(struct pci_bus *bus,
+=09=09unsigned int devfn, int where, int size, u32 *val)
+{
+=09int ret;
+=09struct pci_config_window *cfg =3D bus->sysdata;
+=09struct tango_pcie *pcie =3D dev_get_drvdata(cfg->parent);
+
+=09/*
+=09 * QUIRK #1
+=09 * Reads in configuration space outside devfn 0 return garbage.
+=09 */
+=09if (devfn !=3D 0)
+=09=09return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+=09/*
+=09 * QUIRK #2
+=09 * Unfortunately, config and mem spaces are muxed.
+=09 * Linux does not support such a setting, since drivers are free
+=09 * to access mem space directly, at any time.
+=09 * Therefore, we can only PRAY that config and mem space accesses
+=09 * NEVER occur concurrently.
+=09 */
+=09writel_relaxed(1, pcie->mux);
+=09ret =3D pci_generic_config_read(bus, devfn, where, size, val);
+=09writel_relaxed(0, pcie->mux);
+
+=09return ret;
+}
+
+static int smp8759_config_write(struct pci_bus *bus,
+=09=09unsigned int devfn, int where, int size, u32 val)
+{
+=09int ret;
+=09struct pci_config_window *cfg =3D bus->sysdata;
+=09struct tango_pcie *pcie =3D dev_get_drvdata(cfg->parent);
+
+=09writel_relaxed(1, pcie->mux);
+=09ret =3D pci_generic_config_write(bus, devfn, where, size, val);
+=09writel_relaxed(0, pcie->mux);
+
+=09return ret;
+}
+
+static struct pci_ecam_ops smp8759_ecam_ops =3D {
+=09.bus_shift=09=3D 20,
+=09.pci_ops=09=3D {
+=09=09.map_bus=09=3D pci_ecam_map_bus,
+=09=09.read=09=09=3D smp8759_config_read,
+=09=09.write=09=09=3D smp8759_config_write,
+=09}
+};
+
+static const struct of_device_id tango_pcie_ids[] =3D {
+=09{ .compatible =3D "sigma,smp8759-pcie" },
+=09{ /* sentinel */ },
+};
+
+static int tango_check_pcie_link(void __iomem *test_out)
+{
+=09int i;
+
+=09writel_relaxed(16, test_out);
+=09for (i =3D 0; i < 10; ++i) {
+=09=09u32 ltssm_state =3D readl_relaxed(test_out) >> 8;
+=09=09if ((ltssm_state & 0x1f) =3D=3D 0xf) /* L0 */
+=09=09=09return 0;
+=09=09usleep_range(3000, 4000);
+=09}
+
+=09return -ENODEV;
+}
+
+static int smp8759_init(struct tango_pcie *pcie, void __iomem *base)
+{
+=09pcie->mux=09=09=3D base + SMP8759_MUX;
+
+=09return tango_check_pcie_link(base + SMP8759_TEST_OUT);
+}
+
+static int tango_pcie_probe(struct platform_device *pdev)
+{
+=09int ret =3D -EINVAL;
+=09void __iomem *base;
+=09struct resource *res;
+=09struct tango_pcie *pcie;
+=09struct device *dev =3D &pdev->dev;
+
+=09pr_err("MAJOR ISSUE: PCIe config and mem spaces are muxed\n");
+=09pr_err("Tainting kernel... Use driver at your own risk\n");
+=09add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+
+=09pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+=09if (!pcie)
+=09=09return -ENOMEM;
+
+=09platform_set_drvdata(pdev, pcie);
+
+=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+=09base =3D devm_ioremap_resource(&pdev->dev, res);
+=09if (IS_ERR(base))
+=09=09return PTR_ERR(base);
+
+=09if (of_device_is_compatible(dev->of_node, "sigma,smp8759-pcie"))
+=09=09ret =3D smp8759_init(pcie, base);
+
+=09if (ret)
+=09=09return ret;
+
+=09return pci_host_common_probe(pdev, &smp8759_ecam_ops);
+}
+
+static struct platform_driver tango_pcie_driver =3D {
+=09.probe=09=3D tango_pcie_probe,
+=09.driver=09=3D {
+=09=09.name =3D KBUILD_MODNAME,
+=09=09.of_match_table =3D tango_pcie_ids,
+=09},
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
+=09dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
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
+=09dev->non_compliant_bars =3D true;
+=09pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x24, tango_fixup_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x28, tango_fixup_bar);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f020ab4079d3..b577dbe46f8f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1369,6 +1369,8 @@
 #define PCI_DEVICE_ID_TTI_HPT374=090x0008
 #define PCI_DEVICE_ID_TTI_HPT372N=090x0009=09/* apparently a 372N variant?=
 */
=20
+#define PCI_VENDOR_ID_SIGMA=09=090x1105
+
 #define PCI_VENDOR_ID_VIA=09=090x1106
 #define PCI_DEVICE_ID_VIA_8763_0=090x0198
 #define PCI_DEVICE_ID_VIA_8380_0=090x0204
--=20
2.11.0
