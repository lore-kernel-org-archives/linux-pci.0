Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH V2 2/3] PCI: hisi: Add ECAM support for devices that are not RC
Date: Wed, 31 Aug 2016 19:48:13 +0800
Message-ID: <1472644094-82731-3-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
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
 drivers/pci/host/pcie-designware.c                 |  3 +-
 drivers/pci/host/pcie-designware.h                 |  2 +
 drivers/pci/host/pcie-hisi.c                       | 43 ++++++++++++++++++++++
 4 files changed, 56 insertions(+), 7 deletions(-)

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
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..9f5514c 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -75,7 +75,6 @@
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
 
-static struct pci_ops dw_pcie_ops;
 
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 {
@@ -710,7 +709,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
 }
 
-static struct pci_ops dw_pcie_ops = {
+struct pci_ops dw_pcie_ops = {
 	.read = dw_pcie_rd_conf,
 	.write = dw_pcie_wr_conf,
 };
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f437f9b..234f360 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -86,4 +86,6 @@ int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 
+extern struct pci_ops dw_pcie_ops;
+
 #endif /* _PCIE_DESIGNWARE_H */
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 23d74e9..81eeaed 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -43,6 +43,18 @@ struct pcie_soc_ops {
 	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
 };
 
+static inline int hisi_rd_ecam_conf(struct pcie_port *pp, struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *value)
+{
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static inline int hisi_wr_ecam_conf(struct pcie_port *pp, struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 value)
+{
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
 static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int where,
 		int size, u32 *val)
 {
@@ -72,6 +84,20 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
 	.link_up = hisi_pcie_link_up,
 };
 
+static void __iomem *hisi_pci_map_cfg_bus_cam(struct pci_bus *bus,
+					      unsigned int devfn,
+					      int where)
+{
+	void __iomem *addr;
+	struct pcie_port *pp = bus->sysdata;
+
+	addr = pp->va_cfg1_base - (pp->busn->start << 20) +
+			((bus->number << 20) | (devfn << 12)) +
+			where;
+
+	return addr;
+}
+
 static int hisi_add_pcie_port(struct pcie_port *pp,
 				     struct platform_device *pdev)
 {
@@ -136,6 +162,23 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
 	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
 
+	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam-cfg");
+	if (reg) {
+		/* ECAM driver version */
+		hisi_pcie->pp.va_cfg0_base =
+				devm_ioremap_resource(&pdev->dev, reg);
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
 	ret = hisi_add_pcie_port(pp, pdev);
 	if (ret)
 		return ret;
-- 
1.9.1

