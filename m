Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:53539 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333AbcFAMcv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 08:32:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 3/3] pci: mvebu: use bridge config operations
Date: Wed,  1 Jun 2016 14:31:24 +0200
Message-Id: <1464784332-3775650-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This converts the pci-mvebu host driver to use the newly added pci_ops
callbacks for handling the host config space.

After support for the emulator root bridge is removed, the normal operations
can use pci_generic_config_read/pci_generic_config_write and we just need
to provide a map_bus callback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-mvebu.c | 158 ++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 116 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6b451df6502c..9dff177e32eb 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -155,6 +155,11 @@ struct mvebu_pcie_port {
 	u32 saved_pcie_stat;
 };
 
+static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
+{
+	return sys->private_data;
+}
+
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
 {
 	writel(val, port->base + reg);
@@ -273,56 +278,6 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	mvebu_writel(port, mask, PCIE_MASK_OFF);
 }
 
-static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
-				 struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 *val)
-{
-	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
-
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-		     PCIE_CONF_ADDR_OFF);
-
-	switch (size) {
-	case 1:
-		*val = readb_relaxed(conf_data + (where & 3));
-		break;
-	case 2:
-		*val = readw_relaxed(conf_data + (where & 2));
-		break;
-	case 4:
-		*val = readl_relaxed(conf_data);
-		break;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
-				 struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 val)
-{
-	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
-
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-		     PCIE_CONF_ADDR_OFF);
-
-	switch (size) {
-	case 1:
-		writeb(val, conf_data + (where & 3));
-		break;
-	case 2:
-		writew(val, conf_data + (where & 2));
-		break;
-	case 4:
-		writel(val, conf_data);
-		break;
-	default:
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
 /*
  * Remove windows, starting from the largest ones to the smallest
  * ones.
@@ -624,6 +579,19 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int mvebu_pcie_rd_bridge_conf(struct pci_bus *bus, u32 devfn, int where,
+				     int size, u32 *val)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct mvebu_pcie_port *port;
+
+	for (port = pcie->ports; port < &pcie->ports[pcie->nports]; port++)
+		if (port->devfn == devfn)
+			return mvebu_sw_pci_bridge_read(port, where, size, val);
+
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
 /* Write to the PCI-to-PCI bridge configuration space */
 static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 				     unsigned int where, int size, u32 value)
@@ -750,90 +718,48 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
-{
-	return sys->private_data;
-}
-
-static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
-						    struct pci_bus *bus,
-						    int devfn)
-{
-	int i;
-
-	for (i = 0; i < pcie->nports; i++) {
-		struct mvebu_pcie_port *port = &pcie->ports[i];
-
-		if (bus->number == 0 && port->devfn == devfn)
-			return port;
-		if (bus->number != 0 &&
-		    bus->number >= port->bridge.secondary_bus &&
-		    bus->number <= port->bridge.subordinate_bus)
-			return port;
-	}
-
-	return NULL;
-}
-
-/* PCI configuration space write function */
-static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
-			      int where, int size, u32 val)
+static int mvebu_pcie_wr_bridge_conf(struct pci_bus *bus, u32 devfn,
+				     int where, int size, u32 val)
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
 	struct mvebu_pcie_port *port;
-	int ret;
-
-	port = mvebu_pcie_find_port(pcie, bus, devfn);
-	if (!port)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return mvebu_sw_pci_bridge_write(port, where, size, val);
-
-	if (!mvebu_pcie_link_up(port))
-		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/* Access the real PCIe interface */
-	ret = mvebu_pcie_hw_wr_conf(port, bus, devfn,
-				    where, size, val);
+	for (port = pcie->ports; port < &pcie->ports[pcie->nports]; port++)
+		if (port->devfn == devfn)
+			return mvebu_sw_pci_bridge_write(port, where, size, val);
 
-	return ret;
+	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
-/* PCI configuration space read function */
-static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
-			      int size, u32 *val)
+/* find normal config registers */
+static void __iomem *mvebu_pcie_map_conf(struct pci_bus *bus, u32 devfn, int where)
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
 	struct mvebu_pcie_port *port;
-	int ret;
+	u32 addr;
 
-	port = mvebu_pcie_find_port(pcie, bus, devfn);
-	if (!port) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
+	for (port = pcie->ports; port < &pcie->ports[pcie->nports]; port++) {
+		if (bus->number >= port->bridge.secondary_bus &&
+		    bus->number <= port->bridge.subordinate_bus) {
+			if (!mvebu_pcie_link_up(port))
+				return NULL;
 
-	/* Access the emulated PCI-to-PCI bridge */
-	if (bus->number == 0)
-		return mvebu_sw_pci_bridge_read(port, where, size, val);
+			addr = PCIE_CONF_ADDR(bus->number, devfn, where);
+			mvebu_writel(port, addr, PCIE_CONF_ADDR_OFF);
 
-	if (!mvebu_pcie_link_up(port)) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
+			return port->base + PCIE_CONF_DATA_OFF + (where & 3);
+		}
 	}
 
-	/* Access the real PCIe interface */
-	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
-				    where, size, val);
-
-	return ret;
+	return NULL;
 }
 
 static struct pci_ops mvebu_pcie_ops = {
-	.read = mvebu_pcie_rd_conf,
-	.write = mvebu_pcie_wr_conf,
+	.read_bridge = mvebu_pcie_rd_bridge_conf,
+	.write_bridge = mvebu_pcie_wr_bridge_conf,
+	.map_bus = mvebu_pcie_map_conf,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
 };
 
 static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
-- 
2.7.0

