Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 1/2] PCI: hisi: Add ECAM support for devices that are not RC
Date: Thu, 20 Oct 2016 11:10:33 +0800
Message-ID: <1476933034-46044-2-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1476933034-46044-1-git-send-email-liudongdong3@huawei.com>
References: <1476933034-46044-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

This patch modifies the current Hip05/Hip06 PCIe host
controller driver to add support for 'almost ECAM'
compliant platforms. Some controllers are ECAM compliant
for all the devices of the hierarchy except the root
complex; this patch adds support for such controllers.

This is needed in preparation for the ACPI based driver
to allow both DT and ACPI drivers to use the same BIOS
(that configure the Designware iATUs).
This commit doesn't break backward compatibility with
previous non-ECAM platforms.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 .../devicetree/bindings/pci/hisilicon-pcie.txt     | 15 +++++---
 drivers/pci/host/Kconfig                           |  4 +-
 drivers/pci/host/pcie-designware.c                 |  4 +-
 drivers/pci/host/pcie-designware.h                 |  2 +
 drivers/pci/host/pcie-hisi.c                       | 45 ++++++++++++++++++++++
 5 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index 59c2f47..87a597a 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -9,10 +9,13 @@ Additional properties are described here:
 
 Required properties
 - compatible: Should contain "hisilicon,hip05-pcie" or "hisilicon,hip06-pcie".
-- reg: Should contain rc_dbi, config registers location and length.
-- reg-names: Must include the following entries:
+- reg: Should contain rc_dbi and  either config or ecam-cfg registers
+       location and length (it depends on the platform BIOS).
+- reg-names: Must include
   "rc_dbi": controller configuration registers;
-  "config": PCIe configuration space registers.
+  and one of the following entries:
+    "config": PCIe configuration space registers for non-ECAM platforms.
+    "ecam-cfg": PCIe configuration space registers for ECAM platforms
 - msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
 - port-id: Should be 0, 1, 2 or 3.
 
@@ -23,8 +26,10 @@ Optional properties:
 Hip05 Example (note that Hip06 is the same except compatible):
 	pcie@0xb0080000 {
 		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
-		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
-		reg-names = "rc_dbi", "config";
+		reg = <0 0xb0080000 0 0x10000>,
+		      <0x220 0x00000000 0 0x2000>
+		/* or <0x220 0x00100000 0 0x0f00000> for ecam-cfg*/;
+		reg-names = "rc_dbi", "config" /* or "ecam-cfg" */;
 		bus-range = <0  15>;
 		msi-parent = <&its_pcie>;
 		#address-cells = <3>;
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a..ae98644 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -219,13 +219,13 @@ config PCIE_ALTERA_MSI
 
 config PCI_HISI
 	depends on OF && ARM64
-	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+	bool "HiSilicon Hip05 and Hip06 and Hip07 SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon
-	  Hip05 and Hip06 SoCs
+	  Hip05 and Hip06 and Hip07 SoCs
 
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 035f50c..da11644 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -101,8 +101,6 @@
 #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
 #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
 
-static struct pci_ops dw_pcie_ops;
-
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 {
 	if ((uintptr_t)addr & (size - 1)) {
@@ -800,7 +798,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
 }
 
-static struct pci_ops dw_pcie_ops = {
+struct pci_ops dw_pcie_ops = {
 	.read = dw_pcie_rd_conf,
 	.write = dw_pcie_wr_conf,
 };
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index a567ea2..30d228a 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -83,4 +83,6 @@ struct pcie_host_ops {
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 
+extern struct pci_ops dw_pcie_ops;
+
 #endif /* _PCIE_DESIGNWARE_H */
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 56154c2..555c964 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -43,6 +43,34 @@ struct hisi_pcie {
 	struct pcie_soc_ops *soc_ops;
 };
 
+static inline int hisi_rd_ecam_conf(struct pcie_port *pp, struct pci_bus *bus,
+				    unsigned int devfn, int where, int size,
+				    u32 *value)
+{
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static inline int hisi_wr_ecam_conf(struct pcie_port *pp, struct pci_bus *bus,
+				    unsigned int devfn, int where, int size,
+				    u32 value)
+{
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static void __iomem *hisi_pci_map_cfg_bus_cam(struct pci_bus *bus,
+					      unsigned int devfn,
+					      int where)
+{
+	void __iomem *addr;
+	struct pcie_port *pp = bus->sysdata;
+
+	addr = pp->va_cfg1_base - (pp->busn->start << 20) +
+		((bus->number << 20) | (devfn << 12)) +
+		where;
+
+	return addr;
+}
+
 /* HipXX PCIe host only supports 32-bit config access */
 static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 			      u32 *val)
@@ -190,6 +218,23 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 	}
 
+	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam-cfg");
+	if (reg) {
+		/* ECAM driver version */
+		hisi_pcie->pp.va_cfg0_base =
+		devm_ioremap_resource(&pdev->dev, reg);
+		if (IS_ERR(hisi_pcie->pp.va_cfg0_base)) {
+			dev_err(pp->dev, "cannot get ecam-cfg\n");
+			return PTR_ERR(hisi_pcie->pp.va_cfg0_base);
+		}
+		hisi_pcie->pp.va_cfg1_base = hisi_pcie->pp.va_cfg0_base;
+
+		dw_pcie_ops.map_bus = hisi_pci_map_cfg_bus_cam;
+
+		hisi_pcie_host_ops.rd_other_conf = hisi_rd_ecam_conf;
+		hisi_pcie_host_ops.wr_other_conf = hisi_wr_ecam_conf;
+	}
+
 	ret = hisi_add_pcie_port(hisi_pcie, pdev);
 	if (ret)
 		return ret;
-- 
1.9.1
