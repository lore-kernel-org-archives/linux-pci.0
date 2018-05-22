Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbeEVAav (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 May 2018 20:30:51 -0400
Subject: [PATCH v1 3/4] sparc32/PCI/PCIC: Converge device enable path
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Meelis Roos <mroos@linux.ee>
Date: Mon, 21 May 2018 19:30:49 -0500
Message-ID: <152694904912.59585.12841331398269981947.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Most architectures turn on PCI_COMMAND_IO and PCI_COMMAND_MEMORY in
pci_enable_device() when a driver claims the device.  Sparc PCIC did it in
pcibios_fixup_bus(), which is called during enumeration, before any drivers
are attached.

Implement pcibios_enable_device() for PCIC so it will do the same as other
architectures.  This implementation is copied verbatim from sparc64.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pcic.c |   63 ++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 22f8774977d5..5b9244f328aa 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -624,39 +624,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-
-		/*
-		 * Comment from i386 branch:
-		 *     There are buggy BIOSes that forget to enable I/O and memory
-		 *     access to PCI devices. We try to fix this, but we need to
-		 *     be sure that the BIOS didn't forget to assign an address
-		 *     to the device. [mj]
-		 * OBP is a case of such BIOS :-)
-		 */
-		has_io = has_mem = 0;
-		for(i=0; i<6; i++) {
-			unsigned long f = dev->resource[i].flags;
-			if (f & IORESOURCE_IO) {
-				has_io = 1;
-			} else if (f & IORESOURCE_MEM)
-				has_mem = 1;
-		}
-		pcic_read_config(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
-		if (has_io && !(cmd & PCI_COMMAND_IO)) {
-			printk("PCIC: Enabling I/O for device %02x:%02x\n",
-				dev->bus->number, dev->devfn);
-			cmd |= PCI_COMMAND_IO;
-			pcic_write_config(dev->bus, dev->devfn,
-			    PCI_COMMAND, 2, cmd);
-		}
-		if (has_mem && !(cmd & PCI_COMMAND_MEMORY)) {
-			printk("PCIC: Enabling memory for device %02x:%02x\n",
-				dev->bus->number, dev->devfn);
-			cmd |= PCI_COMMAND_MEMORY;
-			pcic_write_config(dev->bus, dev->devfn,
-			    PCI_COMMAND, 2, cmd);
-		}
-
 		node = pdev_to_pnode(&pcic->pbm, dev);
 		if(node == 0)
 			node = -1;
@@ -675,6 +642,36 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	u16 cmd, oldcmd;
+	int i;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	oldcmd = cmd;
+
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *res = &dev->resource[i];
+
+		/* Only set up the requested stuff */
+		if (!(mask & (1<<i)))
+			continue;
+
+		if (res->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (res->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+
+	if (cmd != oldcmd) {
+		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
+		       pci_name(dev), cmd);
+                /* Enable the appropriate bits in the PCI command register.  */
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
 /* Makes compiler happy */
 static volatile int pcic_timer_dummy;
 
