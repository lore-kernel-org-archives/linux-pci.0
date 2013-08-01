Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from up.free-electrons.com ([94.23.35.102]:53540 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750834Ab3HANZc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:25:32 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCHv6 10/13] ARM: pci: add ->add_bus() and ->remove_bus() hooks to hw_pci
Date: Thu,  1 Aug 2013 15:25:13 +0200
Message-Id: <1375363516-2620-11-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some PCI drivers may need to adjust the pci_bus structure after it has
been allocated by the Linux PCI core. The PCI core allows
architectures to implement the pcibios_add_bus() and
pcibios_remove_bus() for this purpose. This commit therefore extends
the hw_pci and pci_sys_data structures of the ARM PCI core to allow
PCI drivers to register ->add_bus() and ->remove_bus() in hw_pci,
which will get called when a bus is added or removed from the system.

This will be used for example by the Marvell PCIe driver to connect a
particular PCI bus with its corresponding MSI chip to handle Message
Signaled Interrupts.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/pci.h |  4 ++++
 arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index a1c90d7..487155c 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -36,6 +36,8 @@ struct hw_pci {
 					  resource_size_t start,
 					  resource_size_t size,
 					  resource_size_t align);
+	void            (*add_bus)(struct pci_bus *bus);
+	void            (*remove_bus)(struct pci_bus *bus);
 };
 
 /*
@@ -63,6 +65,8 @@ struct pci_sys_data {
 					  resource_size_t start,
 					  resource_size_t size,
 					  resource_size_t align);
+	void            (*add_bus)(struct pci_bus *bus);
+	void            (*remove_bus)(struct pci_bus *bus);
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 261fcc8..530e59d 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -363,6 +363,20 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	if (sys->add_bus)
+		sys->add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	if (sys->remove_bus)
+		sys->remove_bus(bus);
+}
+
 /*
  * Swizzle the device pin each time we cross a bridge.  If a platform does
  * not provide a swizzle function, we perform the standard PCI swizzling.
@@ -464,6 +478,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
 		sys->align_resource = hw->align_resource;
+		sys->add_bus        = hw->add_bus;
+		sys->remove_bus     = hw->remove_bus;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
-- 
1.8.1.2

