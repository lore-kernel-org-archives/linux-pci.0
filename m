Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40342 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbcEaV6H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 May 2016 17:58:07 -0400
Subject: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
To: Arnd Bergmann <arnd@arndb.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	linux-kernel@vger.kernel.org
Date: Tue, 31 May 2016 16:58:02 -0500
Message-ID: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This reverts commit 498a92d42596a7a32c042319eb62a4c3d8081cf1.

Krzysztof reported that this change broke Cavium CNS3xxx, ARMv6 (Laguna
GW-2388) because the MRRS setting is never written to the hardware.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Krzysztof Hałasa <khalasa@piap.pl>
---
 arch/arm/mach-cns3xxx/pcie.c |   71 ++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 318394e..c622c30 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -65,9 +65,8 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
 
 	/*
 	 * The CNS PCI bridge doesn't fit into the PCI hierarchy, though
-	 * we still want to access it.
-	 * We place the host bridge on bus 0, and the directly connected
-	 * device on bus 1, slot 0.
+	 * we still want to access it. For this to work, we must place
+	 * the first device on the same bus as the CNS PCI bridge.
 	 */
 	if (busno == 0) { /* internal PCIe bus, host bridge device */
 		if (devfn == 0) /* device# and function# are ignored by hw */
@@ -212,46 +211,58 @@ static void __init cns3xxx_pcie_check_link(struct cns3xxx_pcie *cnspci)
 	}
 }
 
-static void cns3xxx_write_config(struct cns3xxx_pcie *cnspci,
-					 int where, int size, u32 val)
-{
-	void __iomem *base = cnspci->host_regs + (where & 0xffc);
-	u32 v;
-	u32 mask = (0x1ull << (size * 8)) - 1;
-	int shift = (where % 4) * 8;
-
-	v = readl_relaxed(base);
-
-	v &= ~(mask << shift);
-	v |= (val & mask) << shift;
-
-	writel_relaxed(v, base);
-	readl_relaxed(base);
-}
-
 static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 {
+	int port = cnspci->port;
+	struct pci_sys_data sd = {
+		.private_data = cnspci,
+	};
+	struct pci_bus bus = {
+		.number = 0,
+		.ops = &cns3xxx_pcie_ops,
+		.sysdata = &sd,
+	};
 	u16 mem_base  = cnspci->res_mem.start >> 16;
 	u16 mem_limit = cnspci->res_mem.end   >> 16;
 	u16 io_base   = cnspci->res_io.start  >> 16;
 	u16 io_limit  = cnspci->res_io.end    >> 16;
+	u32 devfn = 0;
+	u8 tmp8;
+	u16 pos;
+	u16 dc;
+
+	pci_bus_write_config_byte(&bus, devfn, PCI_PRIMARY_BUS, 0);
+	pci_bus_write_config_byte(&bus, devfn, PCI_SECONDARY_BUS, 1);
+	pci_bus_write_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, 1);
 
-	cns3xxx_write_config(cnspci, PCI_PRIMARY_BUS, 1, 0);
-	cns3xxx_write_config(cnspci, PCI_SECONDARY_BUS, 1, 1);
-	cns3xxx_write_config(cnspci, PCI_SUBORDINATE_BUS, 1, 1);
-	cns3xxx_write_config(cnspci, PCI_MEMORY_BASE, 2, mem_base);
-	cns3xxx_write_config(cnspci, PCI_MEMORY_LIMIT, 2, mem_limit);
-	cns3xxx_write_config(cnspci, PCI_IO_BASE_UPPER16, 2, io_base);
-	cns3xxx_write_config(cnspci, PCI_IO_LIMIT_UPPER16, 2, io_limit);
+	pci_bus_read_config_byte(&bus, devfn, PCI_PRIMARY_BUS, &tmp8);
+	pci_bus_read_config_byte(&bus, devfn, PCI_SECONDARY_BUS, &tmp8);
+	pci_bus_read_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, &tmp8);
+
+	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_BASE, mem_base);
+	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_LIMIT, mem_limit);
+	pci_bus_write_config_word(&bus, devfn, PCI_IO_BASE_UPPER16, io_base);
+	pci_bus_write_config_word(&bus, devfn, PCI_IO_LIMIT_UPPER16, io_limit);
 
 	if (!cnspci->linked)
 		return;
 
 	/* Set Device Max_Read_Request_Size to 128 byte */
-	pcie_bus_config = PCIE_BUS_PEER2PEER;
-
+	bus.number = 1; /* directly connected PCIe device */
+	devfn = PCI_DEVFN(0, 0);
+	pos = pci_bus_find_capability(&bus, devfn, PCI_CAP_ID_EXP);
+	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
+	if (dc & PCI_EXP_DEVCTL_READRQ) {
+		dc &= ~PCI_EXP_DEVCTL_READRQ;
+		pci_bus_write_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, dc);
+		pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
+		if (dc & PCI_EXP_DEVCTL_READRQ)
+			pr_warn("PCIe: Unable to set device Max_Read_Request_Size\n");
+		else
+			pr_info("PCIe: Max_Read_Request_Size set to 128 bytes\n");
+	}
 	/* Disable PCIe0 Interrupt Mask INTA to INTD */
-	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(cnspci->port));
+	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(port));
 }
 
 static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,

