Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42391 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934462Ab3FSQ4i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 12:56:38 -0400
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
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCHv3 07/11] arm: pci: add ->add_bus() and ->remove_bus() hooks to hw_pci
Date: Wed, 19 Jun 2013 18:56:15 +0200
Message-Id: <1371660979-21588-8-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
---
 arch/arm/include/asm/mach/pci.h |  4 ++++
 arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 7d2c3c8..b71cc9d 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -35,6 +35,8 @@ struct hw_pci {
 					  resource_size_t start,
 					  resource_size_t size,
 					  resource_size_t align);
+	void            (*add_bus)(struct pci_bus *bus);
+	void            (*remove_bus)(struct pci_bus *bus);
 };
 
 /*
@@ -62,6 +64,8 @@ struct pci_sys_data {
 					  resource_size_t start,
 					  resource_size_t size,
 					  resource_size_t align);
+	void            (*add_bus)(struct pci_bus *bus);
+	void            (*remove_bus)(struct pci_bus *bus);
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index b2ed73c..0a441f8 100644
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
@@ -463,6 +477,8 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
 		sys->align_resource = hw->align_resource;
+		sys->add_bus        = hw->add_bus;
+		sys->remove_bus     = hw->remove_bus;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
-- 
1.8.1.2

