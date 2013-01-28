Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58315 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab3A1S5J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:09 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 18/27] arm: plat-orion: add more flexible PCI configuration space read/write functions
Date: Mon, 28 Jan 2013 19:56:27 +0100
Message-Id: <1359399397-29729-19-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The existing orion_pcie_rd_conf() and orion_pcie_wr_conf() functions
provided by plat-orion/pcie.c are nice to read and write the PCI
configuration space of a device, but they unfortunately assume that
the bus number and slot number at which a device is visible at the
Linux software level is the same as the bus number and slot number at
the hardware level.

However, with the usage of the emulated PCI host bridge and emulated
PCI-to-PCI bridges, this is not the case: bus number 0 is the emulated
bus on which the emulated PCI-to-PCI bridges sit, so from the Linux
point of view, the real busses start at bus 1, but from a hardware
point of view, they start at bus 0.

So, we cannot use the existing orion_pcie_rd_conf() and
orion_pcie_wr_conf() implementations, which take their bus number
directly from a given pci_bus structure. Instead, we add lower-level
variants, orion_pcie_rd_conf_bus() and orion_pcie_wr_conf_bus() that
take a bus number as argument. The existing orion_pcie_rd_conf() and
orion_pcie_wr_conf() functions are implemented on top of the new
*_bus() variants.

Those *_bus() variants will be used by the Marvell Armada 370/XP PCIe
driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/include/plat/pcie.h |    4 ++++
 arch/arm/plat-orion/pcie.c              |   26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-orion/include/plat/pcie.h b/arch/arm/plat-orion/include/plat/pcie.h
index fe5b9e8..46974c1 100644
--- a/arch/arm/plat-orion/include/plat/pcie.h
+++ b/arch/arm/plat-orion/include/plat/pcie.h
@@ -21,12 +21,16 @@ int orion_pcie_get_local_bus_nr(void __iomem *base);
 void orion_pcie_set_local_bus_nr(void __iomem *base, int nr);
 void orion_pcie_reset(void __iomem *base);
 void orion_pcie_setup(void __iomem *base);
+int orion_pcie_rd_conf_bus(void __iomem *base, u32 busn,
+			   u32 devfn, int where, int size, u32 *val);
 int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
 		       u32 devfn, int where, int size, u32 *val);
 int orion_pcie_rd_conf_tlp(void __iomem *base, struct pci_bus *bus,
 			   u32 devfn, int where, int size, u32 *val);
 int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
 			  u32 devfn, int where, int size, u32 *val);
+int orion_pcie_wr_conf_bus(void __iomem *base, u32 busn,
+			   u32 devfn, int where, int size, u32 val);
 int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
 		       u32 devfn, int where, int size, u32 val);
 
diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
index f20a321..0e85bdd 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/plat-orion/pcie.c
@@ -203,10 +203,10 @@ void __init orion_pcie_setup(void __iomem *base)
 	writel(mask, base + PCIE_MASK_OFF);
 }
 
-int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
-		       u32 devfn, int where, int size, u32 *val)
+int orion_pcie_rd_conf_bus(void __iomem *base, u32 busn, u32 devfn,
+			   int where, int size, u32 *val)
 {
-	writel(PCIE_CONF_BUS(bus->number) |
+	writel(PCIE_CONF_BUS(busn) |
 		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
 		PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
 		PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
@@ -222,6 +222,13 @@ int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
+		       u32 devfn, int where, int size, u32 *val)
+{
+	return orion_pcie_rd_conf_bus(base, bus->number, devfn,
+				      where, size, val);
+}
+
 int orion_pcie_rd_conf_tlp(void __iomem *base, struct pci_bus *bus,
 			   u32 devfn, int where, int size, u32 *val)
 {
@@ -261,12 +268,12 @@ int orion_pcie_rd_conf_wa(void __iomem *wa_base, struct pci_bus *bus,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
-		       u32 devfn, int where, int size, u32 val)
+int orion_pcie_wr_conf_bus(void __iomem *base, u32 busn,
+			   u32 devfn, int where, int size, u32 val)
 {
 	int ret = PCIBIOS_SUCCESSFUL;
 
-	writel(PCIE_CONF_BUS(bus->number) |
+	writel(PCIE_CONF_BUS(busn) |
 		PCIE_CONF_DEV(PCI_SLOT(devfn)) |
 		PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
 		PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
@@ -284,3 +291,10 @@ int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
 
 	return ret;
 }
+
+int orion_pcie_wr_conf(void __iomem *base, struct pci_bus *bus,
+		       u32 devfn, int where, int size, u32 val)
+{
+	return orion_pcie_wr_conf_bus(base, bus->number, devfn,
+				      where, size, val);
+}
-- 
1.7.9.5

