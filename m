Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64321 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333AbcFAMdD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 08:33:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Jisheng Zhang <jszhang@marvell.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 2/3] pci: dw: use new config space accessors
Date: Wed,  1 Jun 2016 14:31:23 +0200
Message-Id: <1464784332-3775650-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI core can now use separate callbacks for type 1 config
space accesses, so we can simplify the dw_pcie_wr_conf/dw_pcie_rd_conf
logic that multiplexes between the two kinds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pcie-designware.c | 73 +++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index aafd766546f3..37e16c159719 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -573,13 +573,24 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+static int dw_pcie_rd_other_conf(struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 *val)
 {
 	int ret, type;
 	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
+	struct pcie_port *pp = bus->sysdata;
+
+	/*
+	 * If there is no link, then there is no device.
+	 *
+	 * do not read more than one device on the bus directly attached
+	 * to RC's (Virtual Bridge's) DS side.
+	 */
+	if (!dw_pcie_link_up(pp) ||
+	    (bus->primary == pp->root_bus_nr && PCI_SLOT(devfn) > 0))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (pp->ops->rd_other_conf)
 		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
@@ -610,13 +621,18 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return ret;
 }
 
-static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+static int dw_pcie_wr_other_conf(struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 val)
 {
 	int ret, type;
 	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
+	struct pcie_port *pp = bus->sysdata;
+
+	if (!dw_pcie_link_up(pp) ||
+	    (bus->primary == pp->root_bus_nr && PCI_SLOT(devfn) > 0))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (pp->ops->wr_other_conf)
 		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
@@ -647,62 +663,29 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return ret;
 }
 
-static int dw_pcie_valid_config(struct pcie_port *pp,
-				struct pci_bus *bus, int dev)
-{
-	/* If there is no link, then there is no device */
-	if (bus->number != pp->root_bus_nr) {
-		if (!dw_pcie_link_up(pp))
-			return 0;
-	}
-
-	/* access only one slot on each root port */
-	if (bus->number == pp->root_bus_nr && dev > 0)
-		return 0;
-
-	/*
-	 * do not read more than one device on the bus directly attached
-	 * to RC's (Virtual Bridge's) DS side.
-	 */
-	if (bus->primary == pp->root_bus_nr && dev > 0)
-		return 0;
-
-	return 1;
-}
-
-static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+static int dw_pcie_rd_bridge_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = bus->sysdata;
-
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
-		*val = 0xffffffff;
+	if (PCI_SLOT(devfn) > 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	if (bus->number == pp->root_bus_nr)
-		return dw_pcie_rd_own_conf(pp, where, size, val);
 
-	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
+	return dw_pcie_rd_own_conf(bus->sysdata, where, size, val);
 }
 
-static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
+static int dw_pcie_wr_bridge_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = bus->sysdata;
-
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
+	if (PCI_SLOT(devfn) > 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (bus->number == pp->root_bus_nr)
-		return dw_pcie_wr_own_conf(pp, where, size, val);
-
-	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
+	return dw_pcie_wr_own_conf(bus->sysdata, where, size, val);
 }
 
 static struct pci_ops dw_pcie_ops = {
-	.read = dw_pcie_rd_conf,
-	.write = dw_pcie_wr_conf,
+	.read_bridge = dw_pcie_rd_bridge_conf,
+	.write_bridge = dw_pcie_wr_bridge_conf,
+	.read = dw_pcie_rd_other_conf,
+	.write = dw_pcie_wr_other_conf,
 };
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
-- 
2.7.0

