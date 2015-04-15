Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:28614 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933204AbbDOGEK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 02:04:10 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<yuanzhichang@hisilicon.com>, <zhudacai@hisilicon.com>,
	<zhangjukuo@huawei.com>, <xiehaitao@huawei.com>,
	<liguozhu@hisilicon.com>, <wangzhou.bry@gmail.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [RFC PATCH 1/3] PCI: host: designware: support ARM64
Date: Wed, 15 Apr 2015 14:04:01 +0800
Message-ID: <1429077843-184462-2-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com>
References: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/host/pcie-designware.c | 44 +++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 17ca986..e88a7d9 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -22,6 +22,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <asm/hardirq.h>
 
 #include "pcie-designware.h"
 
@@ -31,6 +32,7 @@
 #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
 #define PORT_LINK_MODE_2_LANES		(0x3 << 16)
 #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
+#define PORT_LINK_MODE_8_LANES		(0xf << 16)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
@@ -38,6 +40,7 @@
 #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
 #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
 #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
+#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
 
 #define PCIE_MSI_ADDR_LO		0x820
 #define PCIE_MSI_ADDR_HI		0x824
@@ -68,14 +71,19 @@
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
 static struct hw_pci dw_pci;
+static struct pci_ops dw_pcie_ops;
 
 static unsigned long global_io_offset;
 
-static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
+static inline struct pcie_port *sys_to_pcie(void *sys)
 {
-	BUG_ON(!sys->private_data);
+#ifdef CONFIG_ARM
+	pci_sys_data *sys_data = (struct pci_sys_data *)sys;
 
-	return sys->private_data;
+	BUG_ON(!sys->private_data);
+	return sys_data->private_data;
+#endif
+	return (struct pcie_port *)sys;
 }
 
 int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
@@ -502,6 +510,27 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 
+#ifdef CONFIG_ARM64
+	struct pci_bus *bus;
+	LIST_HEAD(res);
+
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
+	if (ret)
+		return ret;
+
+	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
+				  pp, &res);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
+
+	pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
+#endif
+
+#ifdef CONFIG_ARM
 #ifdef CONFIG_PCI_MSI
 	dw_pcie_msi_chip.dev = pp->dev;
 	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
@@ -514,6 +543,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 #ifdef CONFIG_PCI_DOMAINS
 	dw_pci.domain++;
 #endif
+#endif
 
 	return 0;
 }
@@ -704,6 +734,7 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
+#ifdef CONFIG_ARM
 static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct pcie_port *pp;
@@ -761,6 +792,7 @@ static struct hw_pci dw_pci = {
 	.scan		= dw_pcie_scan_bus,
 	.map_irq	= dw_pcie_map_irq,
 };
+#endif
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
@@ -781,6 +813,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	case 4:
 		val |= PORT_LINK_MODE_4_LANES;
 		break;
+	case 8:
+		val |= PORT_LINK_MODE_8_LANES;
+		break;
 	}
 	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
 
@@ -797,6 +832,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	case 4:
 		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
 		break;
+	case 8:
+		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
+		break;
 	}
 	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
-- 
1.9.1

