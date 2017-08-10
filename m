Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbdHJRws (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Aug 2017 13:52:48 -0400
Date: Thu, 10 Aug 2017 12:52:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@imgtec.com>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthew Minter <matt@masarand.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: [PATCH] PCI: Inline and remove pcibios_update_irq()
Message-ID: <20170810175246.GB18397@bhelgaas-glaptop.roam.corp.google.com>
References: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 05:37:48PM +0100, Lorenzo Pieralisi wrote:
> The pci_fixup_irqs() function allocates IRQs for all PCI devices present
> in a system; those PCI devices possibly belong to different PCI bus trees
> (and possibly rooted at different host bridges) and may well be enabled
> (ie probed and bound to a driver) by the time pci_fixup_irqs() is called
> when probing a given host bridge driver.
> 
> Furthermore, current kernel code relying on pci_fixup_irqs() to
> assign legacy PCI IRQs to devices does not work at all for
> hotplugged devices in that the code carrying out the IRQ fixup
> is called at host bridge driver probe time, which just cannot take
> into account devices hotplugged after system has booted.
> 
> The introduction of map/swizzle functions hook in struct pci_host_bridge
> allows to define per-bridge map/swizzle functions, that can be used at
> device probe time in PCI core code to allocate IRQs for a given device
> (through pci_assign_irq()).
> 
> This series converts all arches still relying on pci_fixup_irqs() to
> the new pci_scan_root_bus_bridge() API and consequently remove
> pci_fixup_irqs() from the kernel in that it is not used anymore.

I tentatively applied the following patch on top of this series on
pci/irq-fixups for v4.14.  Any comments welcome.

commit 606799cc5049ae4ccb51ba3242365ca2d411da13
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Aug 10 12:49:57 2017 -0500

    PCI: Inline and remove pcibios_update_irq()
    
    pcibios_update_irq() was a weak function with only one trivial
    implementation.  Inline it and remove the weak function.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 69e3b56c32a4..86106c44ce94 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -17,12 +17,6 @@
 #include <linux/cache.h>
 #include "pci.h"
 
-void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
-{
-	dev_dbg(&dev->dev, "assigning IRQ %02d\n", irq);
-	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
-}
-
 void pci_assign_irq(struct pci_dev *dev)
 {
 	u8 pin;
@@ -65,5 +59,5 @@ void pci_assign_irq(struct pci_dev *dev)
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
-	pcibios_update_irq(dev, irq);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 69034ab8a68e..a9e8d2f3bd91 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -844,7 +844,6 @@ char *pcibios_setup(char *str);
 resource_size_t pcibios_align_resource(void *, const struct resource *,
 				resource_size_t,
 				resource_size_t);
-void pcibios_update_irq(struct pci_dev *, int irq);
 
 /* Weak but can be overriden by arch */
 void pci_fixup_cardbus(struct pci_bus *);
