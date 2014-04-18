Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33067 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752188AbaDRMUG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 08:20:06 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 7/7] pci: pci-mvebu: split PCIe BARs into multiple MBus windows when needed
Date: Fri, 18 Apr 2014 14:19:53 +0200
Message-Id: <1397823593-1932-8-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MBus windows are used on Marvell platforms to map certain peripherals
in the physical address space. In the PCIe context, MBus windows are
needed to map PCIe I/O and memory regions in the physical address.

However, those MBus windows can only have power of two sizes, while
PCIe BAR do not necessarily guarantee this. For this reason, the
current pci-mvebu breaks on platforms where PCIe devices have BARs
that don't sum up to a power of two size at the emulated bridge level.

This commit fixes this by allowing the pci-mvebu driver to create
multiple contiguous MBus windows (each having a power of two size) to
cover a given PCIe BAR.

To achieve this, two functions are added: mvebu_pcie_add_windows() and
mvebu_pcie_del_windows() to respectively add and remove all the MBus
windows that are needed to map the provided PCIe region base and
size. The emulated PCI bridge code now calls those functions, instead
of directly calling the mvebu-mbus driver functions.

Fixes: 45361a4fe4464180815157654aabbd2afb4848ad ('pci: PCIe driver for Marvell Armada 370/XP systems')
Cc: <stable@vger.kernel.org> # v3.11+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
 drivers/pci/host/pci-mvebu.c | 88 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 4829921..e384e25 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -293,6 +293,58 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+/*
+ * Remove windows, starting from the largest ones to the smallest
+ * ones.
+ */
+static void mvebu_pcie_del_windows(struct mvebu_pcie_port *port,
+				   phys_addr_t base, size_t size)
+{
+	while (size) {
+		size_t sz = 1 << (fls(size) - 1);
+
+		mvebu_mbus_del_window(base, sz);
+		base += sz;
+		size -= sz;
+	}
+}
+
+/*
+ * MBus windows can only have a power of two size, but PCI BARs do not
+ * have this constraint. Therefore, we have to split the PCI BAR into
+ * areas each having a power of two size. We start from the largest
+ * one (i.e highest order bit set in the size).
+ */
+static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
+				   unsigned int target, unsigned int attribute,
+				   phys_addr_t base, size_t size,
+				   phys_addr_t remap)
+{
+	size_t size_mapped = 0;
+
+	while (size) {
+		size_t sz = 1 << (fls(size) - 1);
+		int ret;
+
+		ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
+							sz, remap);
+		if (ret) {
+			dev_err(&port->pcie->pdev->dev,
+				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
+				base, sz, ret);
+			mvebu_pcie_del_windows(port, base - size_mapped,
+					       size_mapped);
+			return;
+		}
+
+		size -= sz;
+		size_mapped += sz;
+		base += sz;
+		if (remap != MVEBU_MBUS_NO_REMAP)
+			remap += sz;
+	}
+}
+
 static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 {
 	phys_addr_t iobase;
@@ -304,8 +356,8 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 		/* If a window was configured, remove it */
 		if (port->iowin_base) {
-			mvebu_mbus_del_window(port->iowin_base,
-					      port->iowin_size);
+			mvebu_pcie_del_windows(port, port->iowin_base,
+					       port->iowin_size);
 			port->iowin_base = 0;
 			port->iowin_size = 0;
 		}
@@ -333,9 +385,9 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 			    (port->bridge.iolimitupper << 16)) -
 			    iobase) + 1;
 
-	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
-					  port->iowin_base, port->iowin_size,
-					  iobase);
+	mvebu_pcie_add_windows(port, port->io_target, port->io_attr,
+			       port->iowin_base, port->iowin_size,
+			       iobase);
 }
 
 static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
@@ -346,8 +398,8 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 
 		/* If a window was configured, remove it */
 		if (port->memwin_base) {
-			mvebu_mbus_del_window(port->memwin_base,
-					      port->memwin_size);
+			mvebu_pcie_del_windows(port, port->memwin_base,
+					       port->memwin_size);
 			port->memwin_base = 0;
 			port->memwin_size = 0;
 		}
@@ -366,8 +418,9 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
 		port->memwin_base + 1;
 
-	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
-				    port->memwin_base, port->memwin_size);
+	mvebu_pcie_add_windows(port, port->mem_target, port->mem_attr,
+			       port->memwin_base, port->memwin_size,
+			       MVEBU_MBUS_NO_REMAP);
 }
 
 /*
@@ -743,14 +796,21 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 
 	/*
 	 * On the PCI-to-PCI bridge side, the I/O windows must have at
-	 * least a 64 KB size and be aligned on their size, and the
-	 * memory windows must have at least a 1 MB size and be
-	 * aligned on their size
+	 * least a 64 KB size and the memory windows must have at
+	 * least a 1 MB size. Moreover, MBus windows need to have a
+	 * base address aligned on their size, and their size must be
+	 * a power of two. This means that if the BAR doesn't have a
+	 * power of two size, several MBus windows will actually be
+	 * created. We need to ensure that the biggest MBus window
+	 * (which will be the first one) is aligned on its size, which
+	 * explains the rounddown_pow_of_two() being done here.
 	 */
 	if (res->flags & IORESOURCE_IO)
-		return round_up(start, max_t(resource_size_t, SZ_64K, size));
+		return round_up(start, max_t(resource_size_t, SZ_64K,
+					     rounddown_pow_of_two(size)));
 	else if (res->flags & IORESOURCE_MEM)
-		return round_up(start, max_t(resource_size_t, SZ_1M, size));
+		return round_up(start, max_t(resource_size_t, SZ_1M,
+					     rounddown_pow_of_two(size)));
 	else
 		return start;
 }
-- 
1.9.2

