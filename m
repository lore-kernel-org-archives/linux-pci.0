Return-Path: <SRS0=mO1w=ZR=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=mO1w=ZR=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V2] PCI:hisi: Add DT almost ECAM support for HiSilicon Hip06/Hip07 host controllers
Date: Sat, 4 Feb 2017 16:07:46 +0800
Message-ID: <1486195666-104942-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

The PCIe controller in Hip06/Hip07 SoCs is not completely
ECAM-compliant. It is non-ECAM only for the RC bus config space; for
any other bus underneath the root bus it does support ECAM access.
This is to add the almost ECAM support in DT way.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
v1->v2: Use a separate probe function() with a separate struct
	platform_driver. 
	Drop PATCH 3/3, wait for Lorenzo review. Then will
	send it as a separate patch if needed.
	Rebased on pci/host-hisi.
---
 .../devicetree/bindings/pci/hisilicon-pcie.txt     | 37 +++++++++++++
 drivers/pci/host/pcie-hisi.c                       | 64 +++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index 59c2f47..38e6dc3 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -42,3 +42,40 @@ Hip05 Example (note that Hip06 is the same except compatible):
 				 0x0 0 0 4 &mbigen_pcie 4 13>;
 		status = "ok";
 	};
+
+HiSilicon Hip06/Hip07 PCIe host bridge DT (almost ecam) description
+The properties and their meanings are identical to those described in
+host-generic-pci.txt except as listed below.
+
+Properties of the host controller node that differ from
+host-generic-pci.txt:
+
+- compatible     : Must be "hisilicon,pcie-almost-ecam"
+
+- reg            : Two entries: First the ECAM configuration space for any
+		   other bus underneath the root bus. Second, the base
+		   and size of the HiSilicon host bridge registers inculde
+		   the RC itself config space.
+
+Example:
+	pcie0: pcie@a0090000 {
+		compatible = "hisilicon,pcie-almost-ecam";
+		reg = <0 0xb0000000 0 0x2000000>,  /*  ECAM configuration space */
+		      <0 0xa0090000 0 0x10000>; /* host bridge registers */
+		bus-range = <0  31>;
+		msi-map = <0x0000 &its_dsa 0x0000 0x2000>;
+		msi-map-mask = <0xffff>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		dma-coherent;
+		ranges = <0x02000000 0 0xb2000000 0x0 0xb2000000 0 0x5ff0000
+			  0x01000000 0 0 0 0xb7ff0000 0 0x10000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0 0 0 1 &mbigen_pcie0 650 4
+				 0x0 0 0 2 &mbigen_pcie0 650 4
+				 0x0 0 0 3 &mbigen_pcie0 650 4
+				 0x0 0 0 4 &mbigen_pcie0 650 4>;
+		status = "ok";
+	};
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 33c201a..a71925d 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -24,7 +24,7 @@
 #include <linux/regmap.h>
 #include "../pci.h"
 
-#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
+#if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 
 static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 				  int size, u32 *val)
@@ -74,6 +74,8 @@ static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 		return pci_ecam_map_bus(bus, devfn, where);
 }
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
+
 static int hisi_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -321,4 +323,64 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 };
 builtin_platform_driver(hisi_pcie_driver);
 
+static int hisi_pcie_almost_ecam_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_ecam_ops *ops = of_device_get_match_data(dev);
+
+	return pci_host_common_probe(pdev, ops);
+}
+
+static int hisi_pcie_platform_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	void __iomem *reg_base;
+
+	if (!dev->of_node)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(dev, "missing \"reg[1]\"property\n");
+		return -EINVAL;
+	}
+
+	reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!reg_base)
+		return -ENOMEM;
+
+	cfg->priv = reg_base;
+	return 0;
+}
+
+struct pci_ecam_ops hisi_pcie_platform_ops = {
+	.bus_shift    = 20,
+	.init         =  hisi_pcie_platform_init,
+	.pci_ops      = {
+		.map_bus    = hisi_pcie_map_bus,
+		.read       = hisi_pcie_acpi_rd_conf,
+		.write      = hisi_pcie_acpi_wr_conf,
+	}
+};
+
+static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
+	{
+		.compatible = "hisilicon,pcie-almost-ecam",
+		.data	    = (void *) &hisi_pcie_platform_ops,
+	},
+	{},
+};
+
+static struct platform_driver hisi_pcie_almost_ecam_driver = {
+	.probe  = hisi_pcie_almost_ecam_probe,
+	.driver = {
+		   .name = "hisi-pcie",
+		   .of_match_table = hisi_pcie_almost_ecam_of_match,
+	},
+};
+builtin_platform_driver(hisi_pcie_almost_ecam_driver);
+
+#endif
 #endif
-- 
1.9.1
