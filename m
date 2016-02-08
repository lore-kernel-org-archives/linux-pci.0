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
Subject: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host controller ECAM compliant
Date: Mon, 8 Feb 2016 12:41:03 +0000
Message-ID: <1454935264-6076-3-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
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
 drivers/pci/host/pcie-designware.c |  4 +---
 drivers/pci/host/pcie-designware.h |  2 ++
 drivers/pci/host/pcie-hisi.c       | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2171682..5f19ea4 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -69,8 +69,6 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
-static struct pci_ops dw_pcie_ops;
-
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 {
 	if ((uintptr_t)addr & (size - 1)) {
@@ -690,7 +688,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
 }
 
-static struct pci_ops dw_pcie_ops = {
+struct pci_ops dw_pcie_ops = {
 	.read = dw_pcie_rd_conf,
 	.write = dw_pcie_wr_conf,
 };
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 2356d29..3f42655 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -80,4 +80,6 @@ int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 
+extern struct pci_ops dw_pcie_ops;
+
 #endif /* _PCIE_DESIGNWARE_H */
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 458d0f8..eb3201a 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -43,6 +43,18 @@ struct pcie_soc_ops {
 	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
 };
 
+static inline int hisi_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *value)
+{
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static inline int hisi_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 value)
+{
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
 static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int where,
 		int size, u32 *val)
 {
@@ -67,11 +79,24 @@ static int hisi_pcie_link_up(struct pcie_port *pp)
 }
 
 struct pcie_host_ops hisi_pcie_host_ops = {
+		.rd_other_conf = hisi_rd_other_conf,
+		.wr_other_conf = hisi_wr_other_conf,
 		.rd_own_conf = hisi_pcie_cfg_read,
 		.wr_own_conf = hisi_pcie_cfg_write,
 		.link_up = hisi_pcie_link_up,
 };
 
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
 
 static int hisi_add_pcie_port(struct pcie_port *pp,
 				     struct platform_device *pdev)
@@ -92,6 +117,8 @@ static int hisi_add_pcie_port(struct pcie_port *pp,
 
 	pp->ops = &hisi_pcie_host_ops;
 
+	dw_pcie_ops.map_bus = hisi_pci_map_cfg_bus_cam;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize host\n");
@@ -137,6 +164,14 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
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


