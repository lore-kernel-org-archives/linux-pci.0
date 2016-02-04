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
Subject: [RFC PATCH 1/4] PCI: Designware: Add support for ACPI based controllers
Date: Thu, 4 Feb 2016 19:37:37 +0800
Message-ID: <1454585860-60709-2-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch reworks the current Designware framework to
enable ACPI based controllers.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 39 +++++++++++++++++++++++++++++++++-----
 drivers/pci/host/pcie-designware.h |  1 +
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 02a7452..4ced20d 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -19,6 +20,7 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
@@ -46,7 +48,6 @@
 #define PCIE_MSI_INTR0_ENABLE		0x828
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
-
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
 #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
@@ -69,7 +70,7 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
-static struct pci_ops dw_pcie_ops;
+struct pci_ops dw_pcie_ops;
 
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 {
@@ -657,8 +658,22 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
 static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = bus->sysdata;
 	int ret;
+	struct pcie_port *pp;
+	struct pci_bus *bridge_bus;
+
+	for (bridge_bus = bus; bridge_bus->parent;
+			bridge_bus = bridge_bus->parent)
+		;
+
+	if (has_acpi_companion(bridge_bus->bridge)) {
+#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
+		struct acpi_pci_root *root = bus->sysdata;
+
+		pp = root->sysdata;
+#endif /* CONFIG_ACPI_PCI_HOST_GENERIC */
+	} else
+		pp = bus->sysdata;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
 		*val = 0xffffffff;
@@ -681,8 +696,22 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = bus->sysdata;
 	int ret;
+	struct pcie_port *pp;
+	struct pci_bus *bridge_bus;
+
+	for (bridge_bus = bus; bridge_bus->parent;
+			bridge_bus = bridge_bus->parent)
+		;
+
+	if (has_acpi_companion(bridge_bus->bridge)) {
+#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
+		struct acpi_pci_root *root = bus->sysdata;
+
+		pp = root->sysdata;
+#endif /* CONFIG_ACPI_PCI_HOST_GENERIC */
+	} else
+		pp = bus->sysdata;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -700,7 +729,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	return ret;
 }
 
-static struct pci_ops dw_pcie_ops = {
+struct pci_ops dw_pcie_ops = {
 	.read = dw_pcie_rd_conf,
 	.write = dw_pcie_wr_conf,
 };
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 2356d29..fd27fa4 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -80,4 +80,5 @@ int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 
+extern struct pci_ops dw_pcie_ops;
 #endif /* _PCIE_DESIGNWARE_H */
-- 
1.9.1

