Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52039 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbbJGUF7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 16:05:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] ARM: cns3xxx: pci: avoid potential stack overflow
Date: Wed, 07 Oct 2015 22:05:49 +0200
Message-ID: <12713701.B4epxIQJNF@wuerfel>
In-Reply-To: <201510072201.51697.arnd@arndb.de>
References: <2273145.0Ls8cProhs@wuerfel> <m3fv6i8qnh.fsf@t19.piap.pl> <201510072201.51697.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The cns3xxx_pcie_hw_init function uses excessive kernel
stack space because of a hack that puts a fake struct
pci_sys_data and struct pci_bus on the stack in order to
call the generic pci_bus_read_config accessors, which causes
a warning in ARM allmodconfig builds:

arch/arm/mach-cns3xxx/pcie.c:266:1: warning: the frame size of 1080 bytes is larger than 1024 bytes

I've spent a few hours trying to find out what exactly this
code is wants to achieve here. The obvious part is setting
up the host_regs using config space accessors, and this can
simply be changed to use direct MMIO accesses, as I do
in this patch.

The second part is how the driver sets up the Max_Read_Request_Size
value for the first device/function on bus 1, i.e. the device
plugged directly into the PCIe root port.
For all I can tell, this is in fact incomplete, as it does not
perform the same setting on devices attached to a PCIe switch,
or multi-function devices.
The solution for this part fortunately is even easier: if we
just set the global pcie_bus_config variable to PCIE_BUS_PEER2PEER,
all PCIe devices in the system are limited to 128 byte MPS, which
in turn limits the MRRS to 128 bytes for all devices, and we
no longer even need to touch any devices.

With those two changes in place, we no longer need the fake
pci_sys_data/pci_bus structures for faking config space writes,
and the stack usage goes down as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
New approach based on Krzysztof's feedback about the previous version,
should be cleaner now, but still needs critical review

 arch/arm/mach-cns3xxx/pcie.c | 71 +++++++++++++++++++++++++++++----------------------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index c622c306c390..47905a50e075 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -65,8 +65,9 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
 
 	/*
 	 * The CNS PCI bridge doesn't fit into the PCI hierarchy, though
-	 * we still want to access it. For this to work, we must place
-	 * the first device on the same bus as the CNS PCI bridge.
+	 * we still want to access it.
+	 * We place the host bridge on bus 0, and the directly connected
+	 * device on bus 1, slot 0.
 	 */
 	if (busno == 0) { /* internal PCIe bus, host bridge device */
 		if (devfn == 0) /* device# and function# are ignored by hw */
@@ -211,58 +212,46 @@ static void __init cns3xxx_pcie_check_link(struct cns3xxx_pcie *cnspci)
 	}
 }
 
+static void cns3xxx_write_config(struct cns3xxx_pcie *cnspci,
+					 int where, int size, u32 val)
+{
+	void __iomem *base = cnspci->host_regs + (where & 0xffc);
+	u32 v;
+	u32 mask = (0x1ull << (size * 8)) - 1;
+	int shift = (where % 4) * 8;
+
+	v = readl_relaxed(base + (where & 0xffc));
+
+	v &= ~(mask << shift);
+	v |= (val & mask) << shift;
+
+	writel_relaxed(v, base + (where & 0xffc));
+	readl_relaxed(base + (where & 0xffc));
+}
+
 static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 {
-	int port = cnspci->port;
-	struct pci_sys_data sd = {
-		.private_data = cnspci,
-	};
-	struct pci_bus bus = {
-		.number = 0,
-		.ops = &cns3xxx_pcie_ops,
-		.sysdata = &sd,
-	};
 	u16 mem_base  = cnspci->res_mem.start >> 16;
 	u16 mem_limit = cnspci->res_mem.end   >> 16;
 	u16 io_base   = cnspci->res_io.start  >> 16;
 	u16 io_limit  = cnspci->res_io.end    >> 16;
-	u32 devfn = 0;
-	u8 tmp8;
-	u16 pos;
-	u16 dc;
-
-	pci_bus_write_config_byte(&bus, devfn, PCI_PRIMARY_BUS, 0);
-	pci_bus_write_config_byte(&bus, devfn, PCI_SECONDARY_BUS, 1);
-	pci_bus_write_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, 1);
 
-	pci_bus_read_config_byte(&bus, devfn, PCI_PRIMARY_BUS, &tmp8);
-	pci_bus_read_config_byte(&bus, devfn, PCI_SECONDARY_BUS, &tmp8);
-	pci_bus_read_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, &tmp8);
-
-	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_BASE, mem_base);
-	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_LIMIT, mem_limit);
-	pci_bus_write_config_word(&bus, devfn, PCI_IO_BASE_UPPER16, io_base);
-	pci_bus_write_config_word(&bus, devfn, PCI_IO_LIMIT_UPPER16, io_limit);
+	cns3xxx_write_config(cnspci, PCI_PRIMARY_BUS, 1, 0);
+	cns3xxx_write_config(cnspci, PCI_SECONDARY_BUS, 1, 1);
+	cns3xxx_write_config(cnspci, PCI_SUBORDINATE_BUS, 1, 1);
+	cns3xxx_write_config(cnspci, PCI_MEMORY_BASE, 2, mem_base);
+	cns3xxx_write_config(cnspci, PCI_MEMORY_LIMIT, 2, mem_limit);
+	cns3xxx_write_config(cnspci, PCI_IO_BASE_UPPER16, 2, io_base);
+	cns3xxx_write_config(cnspci, PCI_IO_LIMIT_UPPER16, 2, io_limit);
 
 	if (!cnspci->linked)
 		return;
 
 	/* Set Device Max_Read_Request_Size to 128 byte */
-	bus.number = 1; /* directly connected PCIe device */
-	devfn = PCI_DEVFN(0, 0);
-	pos = pci_bus_find_capability(&bus, devfn, PCI_CAP_ID_EXP);
-	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
-	if (dc & PCI_EXP_DEVCTL_READRQ) {
-		dc &= ~PCI_EXP_DEVCTL_READRQ;
-		pci_bus_write_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, dc);
-		pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
-		if (dc & PCI_EXP_DEVCTL_READRQ)
-			pr_warn("PCIe: Unable to set device Max_Read_Request_Size\n");
-		else
-			pr_info("PCIe: Max_Read_Request_Size set to 128 bytes\n");
-	}
+	pcie_bus_config = PCIE_BUS_PEER2PEER;
+
 	/* Disable PCIe0 Interrupt Mask INTA to INTD */
-	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(port));
+	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(cnspci->port));
 }
 
 static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,

