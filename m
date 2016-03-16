Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:10230 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932347AbcCPLof (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 07:44:35 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2] PCI: designware: move remaining rc setup code to dw_pcie_setup_rc()
Date: Wed, 16 Mar 2016 19:40:33 +0800
Message-ID: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dw_pcie_setup_rc(), as its name indicates, setups the RC. But current
dw_pcie_host_init() also contains some necessary rc setup code.

Another reason: the host may lost power during suspend to ram, the RC
need to be re-setup after resume. The rc can't be correctly resumed
without the rc setup code in dw_pcie_host_init().

So this patch moves the code to dw_pcie_setup_rc() to address the above
two issues. After this patch, each pcie designware driver users could
call dw_pcie_setup_rc() to re-setup rc when resume back.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since v1:
 - fix gcc warning found by lkp, thanks

 drivers/pci/host/pcie-designware.c | 39 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index a4cccd3..261e4a11 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -434,7 +434,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(pp->dev);
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
-	u32 val;
 	int i, ret;
 	LIST_HEAD(res);
 	struct resource_entry *win;
@@ -544,25 +543,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
-	/*
-	 * If the platform provides ->rd_other_conf, it means the platform
-	 * uses its own address translation component rather than ATU, so
-	 * we should not program the ATU here.
-	 */
-	if (!pp->ops->rd_other_conf)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-					  pp->mem_bus_addr, pp->mem_size);
-
-	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
-
-	/* program correct class for RC */
-	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
-
-	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
-
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
@@ -800,6 +780,25 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
+
+	/*
+	 * If the platform provides ->rd_other_conf, it means the platform
+	 * uses its own address translation component rather than ATU, so
+	 * we should not program the ATU here.
+	 */
+	if (!pp->ops->rd_other_conf)
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_MEM, pp->mem_base,
+					  pp->mem_bus_addr, pp->mem_size);
+
+	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
+
+	/* program correct class for RC */
+	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
+
+	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
+	val |= PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 }
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
-- 
2.7.0

