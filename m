Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45780 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326Ab3BLQ3Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:25 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH 06/32] arm: pci: add a align_resource hook
Date: Tue, 12 Feb 2013 17:28:40 +0100
Message-Id: <1360686546-24277-7-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI specifications says that an I/O region must be aligned on a 4
KB boundary, and a memory region aligned on a 1 MB boundary.

However, the Marvell PCIe interfaces rely on address decoding windows
(which allow to associate a range of physical addresses with a given
device), and those have special requirements compared to the standard
PCI-to-PCI bridge specifications.

PCIe memory windows must have a power of two size (which matches the
PCI spec), be at least of 1 MB (which matches the PCI spec), and be
aligned on their size (which does not match the PCI spec, that
requires only a 1 MB alignment).

PCIe I/O windows must have a power of two size (matches the PCI spec),
be at least of 64 KB (doesn't match the PCI spec, which requires only
a size of 4 KB), and be aligned on their size (doesn't match the PCI
spec).

The PCI core already calls pcibios_align_resource() in the ARM PCI
core, specifically for such purposes. So this patch extends the ARM
PCI core so that it calls a ->align_resource() hook registered by the
PCI driver, exactly like the existing ->map_irq() and ->swizzle()
hooks.

A particular PCI driver can register a align_resource() hook, and do
its own specific alignement, depending on the specific constraints of
the underlying hardware.

Following the earlier reviews of this patch, a few comments:

 * Using numerical values is not possible since the alignment value is
   not absolute, but depends on the size of the memory window or I/O
   window. We therefore really need a function hook.

 * Using window_alignment() doesn't work, because it doesn't allow to
   adjust the starting address of the memory or I/O window, and we
   don't have access to the size. The comment was that
   ->resource_align() would apply to all resources on all busses, but
   in the new implementation of the Marvell-specific
   ->resource_align() hook we are careful to only apply the alignment
   constraints on the specific bus that hosts the emulated PCI-to-PCI
   bridges needed to operate the Marvell PCIe interfaces.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/pci.h |   11 +++++++++++
 arch/arm/kernel/bios32.c        |    6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 5cf2e97..7d2c3c8 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -30,6 +30,11 @@ struct hw_pci {
 	void		(*postinit)(void);
 	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
 	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+	resource_size_t (*align_resource)(struct pci_dev *dev,
+					  const struct resource *res,
+					  resource_size_t start,
+					  resource_size_t size,
+					  resource_size_t align);
 };
 
 /*
@@ -51,6 +56,12 @@ struct pci_sys_data {
 	u8		(*swizzle)(struct pci_dev *, u8 *);
 					/* IRQ mapping				*/
 	int		(*map_irq)(const struct pci_dev *, u8, u8);
+					/* Resource alignement requirements	*/
+	resource_size_t (*align_resource)(struct pci_dev *dev,
+					  const struct resource *res,
+					  resource_size_t start,
+					  resource_size_t size,
+					  resource_size_t align);
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 5401645..be2e6c9 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -462,6 +462,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
+		sys->align_resource = hw->align_resource;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
@@ -574,6 +575,8 @@ char * __init pcibios_setup(char *str)
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
 {
+	struct pci_dev *dev = data;
+	struct pci_sys_data *sys = dev->sysdata;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
@@ -581,6 +584,9 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
+	if (sys->align_resource)
+		return sys->align_resource(dev, res, start, size, align);
+
 	return start;
 }
 
-- 
1.7.9.5

