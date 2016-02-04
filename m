Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <guohanjun@huawei.com>, <wangzhou1@hisilicon.com>,
	<liudongdong3@huawei.com>, <linuxarm@huawei.com>,
	<qiujiang@huawei.com>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>
CC: <gabriele.paoloni@huawei.com>, <zhangjukuo@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jcm@redhat.com>
Subject: [RFC PATCH 3/4] PCI: hisi: Make the HiSilicon PCIe host controller ECAM compliant
Date: Thu, 4 Feb 2016 19:37:39 +0800
Message-ID: <1454585860-60709-4-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch modifies the current Hip05/Hip06 PCIe host controller
driver to make it ECAM compliant. This is needed in preparation
for the ACPI based driver to allow both DT and ACPI drivers to
use the same BIOS (that configure the Designware iATUs).

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  4 ++--
 drivers/pci/host/pcie-hisi-common.c                | 15 +++++++++++++++
 drivers/pci/host/pcie-hisi.c                       | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index b721bea..5c1bad0 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -23,8 +23,8 @@ Optional properties:
 Hip05 Example (note that Hip06 is the same except compatible):
 	pcie@0xb0080000 {
 		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
-		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
-		reg-names = "rc_dbi", "config";
+		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00100000 0 0x0f00000>;
+		reg-names = "rc_dbi", "ecam-cfg";
 		bus-range = <0  15>;
 		msi-parent = <&its_pcie>;
 		#address-cells = <3>;
diff --git a/drivers/pci/host/pcie-hisi-common.c b/drivers/pci/host/pcie-hisi-common.c
index ff93293..cbfb6c4 100644
--- a/drivers/pci/host/pcie-hisi-common.c
+++ b/drivers/pci/host/pcie-hisi-common.c
@@ -23,6 +23,19 @@
 #include "pcie-hisi.h"
 
 /* HipXX PCIe host only supports 32-bit config access */
+static int hisi_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *value)
+{
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int hisi_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 value)
+{
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+/* HipXX PCIe host only supports 32-bit config access */
 static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 			      u32 *val)
 {
@@ -82,6 +95,8 @@ static int hisi_pcie_link_up(struct pcie_port *pp)
 }
 
 struct pcie_host_ops hisi_pcie_host_ops = {
+	.rd_other_conf = hisi_rd_other_conf,
+	.wr_other_conf = hisi_wr_other_conf,
 	.rd_own_conf = hisi_pcie_cfg_read,
 	.wr_own_conf = hisi_pcie_cfg_write,
 	.link_up = hisi_pcie_link_up,
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 552ebfc..1e45869 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -29,6 +29,18 @@
 #define PCIE_HIP06_CTRL_OFF					0x1000
 #define PCIE_SYS_STATE4						0x31c
 
+static void __iomem *hisi_pci_map_cfg_bus_cam(struct pci_bus *bus,
+					     unsigned int devfn,
+					     int where)
+{
+	void __iomem *addr;
+	struct pcie_port *pp = bus->sysdata;
+
+	addr = pp->va_cfg1_base + where;
+
+	return addr;
+}
+
 static int hisi_add_pcie_port(struct pcie_port *pp,
 				     struct platform_device *pdev)
 {
@@ -48,6 +60,8 @@ static int hisi_add_pcie_port(struct pcie_port *pp,
 
 	pp->ops = &hisi_pcie_host_ops;
 
+	dw_pcie_ops.map_bus = hisi_pci_map_cfg_bus_cam;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize host\n");
@@ -93,6 +107,14 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
 	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
 
+	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam-cfg");
+	hisi_pcie->pp.va_cfg0_base = devm_ioremap_resource(&pdev->dev, reg);
+	if (IS_ERR(hisi_pcie->pp.va_cfg0_base)) {
+		dev_err(pp->dev, "cannot get ecam-cfg\n");
+		return PTR_ERR(hisi_pcie->pp.va_cfg0_base);
+	}
+	hisi_pcie->pp.va_cfg1_base = hisi_pcie->pp.va_cfg0_base;
+
 	ret = hisi_add_pcie_port(pp, pdev);
 	if (ret)
 		return ret;
-- 
1.9.1

