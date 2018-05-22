Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 2/4] sparc32/PCI/LEON: Converge device enable path
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Meelis Roos <mroos@linux.ee>
Date: Mon, 21 May 2018 19:30:42 -0500
Message-ID: <152694904250.59585.8988716469460021131.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Most architectures turn on PCI_COMMAND_IO and PCI_COMMAND_MEMORY in
pci_enable_device() when a driver claims the device.  Sparc LEON did it in
pcibios_fixup_bus(), which is called during enumeration, before any drivers
are attached.

Implement pcibios_enable_device() for LEON so it will do the same as other
architectures.  This implementation is copied verbatim from sparc64.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/leon_pci.c |   64 +++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 15b59169c535..c2a5033b07c3 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -60,50 +60,32 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 	pci_bus_add_devices(root_bus);
 }
 
-void pcibios_fixup_bus(struct pci_bus *pbus)
+int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	struct pci_dev *dev;
-	int i, has_io, has_mem;
-	u16 cmd;
+	u16 cmd, oldcmd;
+	int i;
 
-	list_for_each_entry(dev, &pbus->devices, bus_list) {
-		/*
-		 * We can not rely on that the bootloader has enabled I/O
-		 * or memory access to PCI devices. Instead we enable it here
-		 * if the device has BARs of respective type.
-		 */
-		has_io = has_mem = 0;
-		for (i = 0; i < PCI_ROM_RESOURCE; i++) {
-			unsigned long f = dev->resource[i].flags;
-			if (f & IORESOURCE_IO)
-				has_io = 1;
-			else if (f & IORESOURCE_MEM)
-				has_mem = 1;
-		}
-		/* ROM BARs are mapped into 32-bit memory space */
-		if (dev->resource[PCI_ROM_RESOURCE].end != 0) {
-			dev->resource[PCI_ROM_RESOURCE].flags |=
-							IORESOURCE_ROM_ENABLE;
-			has_mem = 1;
-		}
-		pci_bus_read_config_word(pbus, dev->devfn, PCI_COMMAND, &cmd);
-		if (has_io && !(cmd & PCI_COMMAND_IO)) {
-#ifdef CONFIG_PCI_DEBUG
-			printk(KERN_INFO "LEONPCI: Enabling I/O for dev %s\n",
-					 pci_name(dev));
-#endif
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
 			cmd |= PCI_COMMAND_IO;
-			pci_bus_write_config_word(pbus, dev->devfn, PCI_COMMAND,
-									cmd);
-		}
-		if (has_mem && !(cmd & PCI_COMMAND_MEMORY)) {
-#ifdef CONFIG_PCI_DEBUG
-			printk(KERN_INFO "LEONPCI: Enabling MEMORY for dev"
-					 "%s\n", pci_name(dev));
-#endif
+		if (res->flags & IORESOURCE_MEM)
 			cmd |= PCI_COMMAND_MEMORY;
-			pci_bus_write_config_word(pbus, dev->devfn, PCI_COMMAND,
-									cmd);
-		}
 	}
+
+	if (cmd != oldcmd) {
+		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
+		       pci_name(dev), cmd);
+                /* Enable the appropriate bits in the PCI command register.  */
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
 }
