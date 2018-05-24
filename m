Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965823AbeEXNeT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 09:34:19 -0400
Date: Thu, 24 May 2018 08:34:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v1 0/4] sparc/PCI: VGA resource and other fixes
Message-ID: <20180524133417.GA95348@bhelgaas-glaptop.roam.corp.google.com>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1805241133450.13830@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LRH.2.21.1805241133450.13830@math.ut.ee>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 11:34:26AM +0300, Meelis Roos wrote:
> > [+cc sparclinux, sorry I missed this first time around]
> 
> > >       sparc/PCI: Use dev_printk() when possible
> 
> This patch causes compile errors for me:
> 
>   CC      arch/sparc/kernel/pci.o
> In file included from ./include/linux/pci.h:31:0,
>                  from arch/sparc/kernel/pci.c:18:
> arch/sparc/kernel/pci.c: In function ‘pcibios_enable_device’:
> arch/sparc/kernel/pci.c:754:53: error: ‘old_cmd’ undeclared (first use in this function)
>    pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
>                                                      ^
> ./include/linux/device.h:1384:58: note: in definition of macro ‘dev_info’
>  #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
>                                                           ^
> arch/sparc/kernel/pci.c:754:3: note: in expansion of macro ‘pci_info’
>    pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
>    ^
> arch/sparc/kernel/pci.c:754:53: note: each undeclared identifier is reported only once for each function it appears in
>    pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
>                                                      ^
> ./include/linux/device.h:1384:58: note: in definition of macro ‘dev_info’
>  #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
>                                                           ^
> arch/sparc/kernel/pci.c:754:3: note: in expansion of macro ‘pci_info’
>    pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
>    ^
> scripts/Makefile.build:312: recipe for target 'arch/sparc/kernel/pci.o' failed

Sorry, I had already fixed this in my git branch
(https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/sparc&id=81729bfd0f58),
but I didn't repost the series.

Here's the whole patch of that branch if that's more convenient than git:


commit c2eead0503b1409bc6954b20585f2213b7e0552d
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Apr 10 08:47:34 2018 -0500

    sparc/PCI: Request legacy VGA framebuffer only for VGA devices
    
    Previously we unconditionally requested the legacy VGA framebuffer (bus
    address 0xa0000-0xbffff) before we even know what PCI devices are present,
    in these paths:
    
      pci_fire_pbm_init, schizo_pbm_init, pci_sun4v_pbm_init, psycho_pbm_init_common
        pci_determine_mem_io_space
          pci_register_legacy_regions
            p->start = mem_res->start + 0xa0000
            request_resource(mem_res, p)    # claim VGA framebuffer
        pci_scan_one_pbm
          pci_of_scan_bus                   # scan DT for PCI devices
          pci_claim_bus_resources           # claim PCI device BARs
    
    If we found a PCI device with a BAR or bridge window that overlapped the
    framebuffer area, we complained about not being able to claim the BAR,
    e.g.,
    
      pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
      pci 0000:02:01.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
      pci 0000:03:0f.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
      pci 0000:04:04.0: can't claim BAR 1 [mem 0x1ff02808000-0x1ff02808fff]: no compatible bridge window
    
    This may make the conflicting device unusable because we try not to enable
    devices that have unassigned or conflicting BARs, e.g.,
    
      qla1280 0000:04:04.0: can't ioremap BAR 1: [mem size 0x00001000]
      qla1280: Unable to map I/O memory
    
    If there is no VGA device in the same PCI segment, there's no reason to
    reserve the framebuffer and there's no conflict.  If there *is* a VGA
    device in the same segment, both the VGA device and the device with an
    overlapping BAR may respond to the framebuffer addresses, which may cause
    bus errors.
    
    Request the legacy framebuffer area only when we actually find a VGA
    device.  The fact that VGA devices use the legacy framebuffer even though
    it's not reported in a BAR is not sparc-specific, so the reservation of
    that area could be made more generic in the PCI core eventually.
    
    Note that on some systems, e.g., Blade 100, we still report a conflict
    between an ISA bridge (00:07.0) and a VGA device (00:13.0):
    
      pci_bus 0000:00: root bus resource [mem 0x1ff00000000-0x1ffffffffff] (bus address [0x00000000-0xffffffff])
      pci 0000:00:07.0: reg 0x14: [mem 0x1ff00000000-0x1ff000fffff]
      pci 0000:00:13.0: can't claim VGA legacy [mem 0x1ff000a0000-0x1ff000bffff]: address conflict with 0000:00:07.0 [mem 0x1ff00000000-0x1ff000fffff]
    
    This is probably harmless, but if the VGA device and something behind the
    ISA bridge both responded to reads of the framebuffer, it would cause a bus
    error.
    
    Link: https://lkml.kernel.org/r/alpine.LRH.2.21.1804112323170.25495@math.ut.ee
    Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117191#c35
    Reported-by: Meelis Roos <mroos@linux.ee>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 41b20edb427d..8a04983cf8a1 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -624,6 +624,45 @@ static void pci_bus_register_of_sysfs(struct pci_bus *bus)
 		pci_bus_register_of_sysfs(child_bus);
 }
 
+static void pci_claim_legacy_resources(struct pci_dev *dev)
+{
+	struct pci_bus_region region;
+	struct resource *p, *root, *conflict;
+
+	if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return;
+
+	p->name = "Video RAM area";
+	p->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	region.start = 0xa0000UL;
+	region.end = region.start + 0x1ffffUL;
+	pcibios_bus_to_resource(dev->bus, p, &region);
+
+	root = pci_find_parent_resource(dev, p);
+	if (!root) {
+		pci_info(dev, "can't claim VGA legacy %pR: no compatible bridge window\n", p);
+		goto err;
+	}
+
+	conflict = request_resource_conflict(root, p);
+	if (conflict) {
+		pci_info(dev, "can't claim VGA legacy %pR: address conflict with %s %pR\n",
+			 p, conflict->name, conflict);
+		goto err;
+	}
+
+	pci_info(dev, "VGA legacy framebuffer %pR\n", p);
+	return;
+
+err:
+	kfree(p);
+}
+
 static void pci_claim_bus_resources(struct pci_bus *bus)
 {
 	struct pci_bus *child_bus;
@@ -648,6 +687,8 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 
 			pci_claim_resource(dev, i);
 		}
+
+		pci_claim_legacy_resources(dev);
 	}
 
 	list_for_each_entry(child_bus, &bus->children, node)
@@ -687,6 +728,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pci_bus_register_of_sysfs(bus);
 
 	pci_claim_bus_resources(bus);
+
 	pci_bus_add_devices(bus);
 	return bus;
 }
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 38d46bcc8634..9bb6a192ef3f 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -329,23 +329,6 @@ void pci_get_pbm_props(struct pci_pbm_info *pbm)
 	}
 }
 
-static void pci_register_legacy_regions(struct resource *io_res,
-					struct resource *mem_res)
-{
-	struct resource *p;
-
-	/* VGA Video RAM. */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	p->name = "Video RAM area";
-	p->start = mem_res->start + 0xa0000UL;
-	p->end = p->start + 0x1ffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
-}
-
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)
 {
 	const u32 *vdma = of_get_property(pbm->op->dev.of_node, "virtual-dma",
@@ -487,8 +470,6 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	if (pbm->mem64_space.flags)
 		request_resource(&iomem_resource, &pbm->mem64_space);
 
-	pci_register_legacy_regions(&pbm->io_space,
-				    &pbm->mem_space);
 	pci_register_iommu_region(pbm);
 }
 

commit 4a33b3ca53c1b566e5cc5f52e6c8413fa32fc0c0
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon May 21 18:23:22 2018 -0500

    sparc32/PCI/LEON: Converge device enable path
    
    Most architectures turn on PCI_COMMAND_IO and PCI_COMMAND_MEMORY in
    pci_enable_device() when a driver claims the device.  Sparc LEON did it in
    pcibios_fixup_bus(), which is called during enumeration, before any drivers
    are attached.
    
    Implement pcibios_enable_device() for LEON so it will do the same as other
    architectures.  This implementation is copied verbatim from sparc64.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

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

commit b30f46518a6c2695d389065994792efaa9c7bc75
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon May 21 18:35:49 2018 -0500

    sparc32/PCI/PCIC: Converge device enable path
    
    Most architectures turn on PCI_COMMAND_IO and PCI_COMMAND_MEMORY in
    pci_enable_device() when a driver claims the device.  Sparc PCIC did it in
    pcibios_fixup_bus(), which is called during enumeration, before any drivers
    are attached.
    
    Implement pcibios_enable_device() for PCIC so it will do the same as other
    architectures.  This implementation is copied verbatim from sparc64.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 22f8774977d5..7b137e07e0a4 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -602,8 +602,6 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	int i, has_io, has_mem;
-	unsigned int cmd = 0;
 	struct linux_pcic *pcic;
 	/* struct linux_pbm_info* pbm = &pcic->pbm; */
 	int node;
@@ -624,39 +622,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
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
@@ -675,6 +640,36 @@ void pcibios_fixup_bus(struct pci_bus *bus)
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
 
@@ -747,17 +742,11 @@ static void watchdog_reset() {
 }
 #endif
 
-int pcibios_enable_device(struct pci_dev *pdev, int mask)
-{
-	return 0;
-}
-
 /*
  * NMI
  */
 void pcic_nmi(unsigned int pend, struct pt_regs *regs)
 {
-
 	pend = swab32(pend);
 
 	if (!pcic_speculative || (pend & PCI_SYS_INT_PENDING_PIO) == 0) {

commit 81729bfd0f58568d6ebb162b2a004f8e9291a004
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat Apr 21 14:35:42 2018 -0500

    sparc/PCI: Use dev_printk() when possible
    
    Use the pci_info() and pci_err() wrappers for dev_printk() when possible.
    
    Log PCI device vendor and device IDs and BAR information in the same format
    used by other architectures.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index c2a5033b07c3..e5e5ff6b9a5c 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -82,9 +82,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
+		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 8a04983cf8a1..17ea16a1337c 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -214,8 +214,8 @@ static void pci_parse_of_addrs(struct platform_device *op,
 	if (!addrs)
 		return;
 	if (ofpci_verbose)
-		printk("    parse addresses (%d bytes) @ %p\n",
-		       proplen, addrs);
+		pci_info(dev, "    parse addresses (%d bytes) @ %p\n",
+			 proplen, addrs);
 	op_res = &op->resource[0];
 	for (; proplen >= 20; proplen -= 20, addrs += 5, op_res++) {
 		struct resource *res;
@@ -227,8 +227,8 @@ static void pci_parse_of_addrs(struct platform_device *op,
 			continue;
 		i = addrs[0] & 0xff;
 		if (ofpci_verbose)
-			printk("  start: %llx, end: %llx, i: %x\n",
-			       op_res->start, op_res->end, i);
+			pci_info(dev, "  start: %llx, end: %llx, i: %x\n",
+				 op_res->start, op_res->end, i);
 
 		if (PCI_BASE_ADDRESS_0 <= i && i <= PCI_BASE_ADDRESS_5) {
 			res = &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
@@ -236,13 +236,15 @@ static void pci_parse_of_addrs(struct platform_device *op,
 			res = &dev->resource[PCI_ROM_RESOURCE];
 			flags |= IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
 		} else {
-			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
+			pci_err(dev, "bad cfg reg num 0x%x\n", i);
 			continue;
 		}
 		res->start = op_res->start;
 		res->end = op_res->end;
 		res->flags = flags;
 		res->name = pci_name(dev);
+
+		pci_info(dev, "reg 0x%x: %pR\n", i, res);
 	}
 }
 
@@ -289,8 +291,8 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 		type = "";
 
 	if (ofpci_verbose)
-		printk("    create device, devfn: %x, type: %s\n",
-		       devfn, type);
+		pci_info(bus,"    create device, devfn: %x, type: %s\n",
+			 devfn, type);
 
 	dev->sysdata = node;
 	dev->dev.parent = bus->bridge;
@@ -323,10 +325,6 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(bus),
 		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
-	if (ofpci_verbose)
-		printk("    class: 0x%x device name: %s\n",
-		       dev->class, pci_name(dev));
-
 	/* I have seen IDE devices which will not respond to
 	 * the bmdma simplex check reads if bus mastering is
 	 * disabled.
@@ -353,10 +351,13 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 			dev->irq = PCI_IRQ_NONE;
 	}
 
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
+		 dev->vendor, dev->device, dev->hdr_type, dev->class);
+
 	pci_parse_of_addrs(sd->op, node, dev);
 
 	if (ofpci_verbose)
-		printk("    adding to system ...\n");
+		pci_info(dev, "    adding to system ...\n");
 
 	pci_device_add(dev, bus);
 
@@ -430,19 +431,19 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	u64 size;
 
 	if (ofpci_verbose)
-		printk("of_scan_pci_bridge(%s)\n", node->full_name);
+		pci_info(dev, "of_scan_pci_bridge(%s)\n", node->full_name);
 
 	/* parse bus-range property */
 	busrange = of_get_property(node, "bus-range", &len);
 	if (busrange == NULL || len != 8) {
-		printk(KERN_DEBUG "Can't get bus-range for PCI-PCI bridge %s\n",
+		pci_info(dev, "Can't get bus-range for PCI-PCI bridge %s\n",
 		       node->full_name);
 		return;
 	}
 
 	if (ofpci_verbose)
-		printk("    Bridge bus range [%u --> %u]\n",
-		       busrange[0], busrange[1]);
+		pci_info(dev, "    Bridge bus range [%u --> %u]\n",
+			 busrange[0], busrange[1]);
 
 	ranges = of_get_property(node, "ranges", &len);
 	simba = 0;
@@ -454,8 +455,8 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 
 	bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
 	if (!bus) {
-		printk(KERN_ERR "Failed to create pci bus for %s\n",
-		       node->full_name);
+		pci_err(dev, "Failed to create pci bus for %s\n",
+			node->full_name);
 		return;
 	}
 
@@ -464,8 +465,8 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	bus->bridge_ctl = 0;
 
 	if (ofpci_verbose)
-		printk("    Bridge ranges[%p] simba[%d]\n",
-		       ranges, simba);
+		pci_info(dev, "    Bridge ranges[%p] simba[%d]\n",
+			 ranges, simba);
 
 	/* parse ranges property, or cook one up by hand for Simba */
 	/* PCI #address-cells == 3 and #size-cells == 2 always */
@@ -487,10 +488,10 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		u64 start;
 
 		if (ofpci_verbose)
-			printk("    RAW Range[%08x:%08x:%08x:%08x:%08x:%08x:"
-			       "%08x:%08x]\n",
-			       ranges[0], ranges[1], ranges[2], ranges[3],
-			       ranges[4], ranges[5], ranges[6], ranges[7]);
+			pci_info(dev, "    RAW Range[%08x:%08x:%08x:%08x:%08x:%08x:"
+				 "%08x:%08x]\n",
+				 ranges[0], ranges[1], ranges[2], ranges[3],
+				 ranges[4], ranges[5], ranges[6], ranges[7]);
 
 		flags = pci_parse_of_flags(ranges[0]);
 		size = GET_64BIT(ranges, 6);
@@ -510,14 +511,14 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		if (flags & IORESOURCE_IO) {
 			res = bus->resource[0];
 			if (res->flags) {
-				printk(KERN_ERR "PCI: ignoring extra I/O range"
-				       " for bridge %s\n", node->full_name);
+				pci_err(dev, "ignoring extra I/O range"
+					" for bridge %s\n", node->full_name);
 				continue;
 			}
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
-				printk(KERN_ERR "PCI: too many memory ranges"
-				       " for bridge %s\n", node->full_name);
+				pci_err(dev, "too many memory ranges"
+					" for bridge %s\n", node->full_name);
 				continue;
 			}
 			res = bus->resource[i];
@@ -529,8 +530,8 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		region.end = region.start + size - 1;
 
 		if (ofpci_verbose)
-			printk("      Using flags[%08x] start[%016llx] size[%016llx]\n",
-			       flags, start, size);
+			pci_info(dev, "      Using flags[%08x] start[%016llx] size[%016llx]\n",
+				 flags, start, size);
 
 		pcibios_bus_to_resource(dev->bus, res, &region);
 	}
@@ -538,7 +539,7 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);
 	if (ofpci_verbose)
-		printk("    bus name: %s\n", bus->name);
+		pci_info(dev, "    bus name: %s\n", bus->name);
 
 	pci_of_scan_bus(pbm, node, bus);
 }
@@ -553,14 +554,14 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 	struct pci_dev *dev;
 
 	if (ofpci_verbose)
-		printk("PCI: scan_bus[%s] bus no %d\n",
-		       node->full_name, bus->number);
+		pci_info(bus, "scan_bus[%s] bus no %d\n",
+			 node->full_name, bus->number);
 
 	child = NULL;
 	prev_devfn = -1;
 	while ((child = of_get_next_child(node, child)) != NULL) {
 		if (ofpci_verbose)
-			printk("  * %s\n", child->full_name);
+			pci_info(bus, "  * %s\n", child->full_name);
 		reg = of_get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;
@@ -581,8 +582,7 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 		if (!dev)
 			continue;
 		if (ofpci_verbose)
-			printk("PCI: dev header type: %x\n",
-			       dev->hdr_type);
+			pci_info(dev, "dev header type: %x\n", dev->hdr_type);
 
 		if (pci_is_bridge(dev))
 			of_scan_pci_bridge(pbm, child, dev);
@@ -678,12 +678,8 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 				continue;
 
 			if (ofpci_verbose)
-				printk("PCI: Claiming %s: "
-				       "Resource %d: %016llx..%016llx [%x]\n",
-				       pci_name(dev), i,
-				       (unsigned long long)r->start,
-				       (unsigned long long)r->end,
-				       (unsigned int)r->flags);
+				pci_info(dev, "Claiming Resource %d: %pR\n",
+					 i, r);
 
 			pci_claim_resource(dev, i);
 		}
@@ -755,9 +751,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
+		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
@@ -1117,8 +1111,8 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 	sp = prop->names;
 
 	if (ofpci_verbose)
-		printk("PCI: Making slots for [%s] mask[0x%02x]\n",
-		       node->full_name, mask);
+		pci_info(bus, "Making slots for [%s] mask[0x%02x]\n",
+			 node->full_name, mask);
 
 	i = 0;
 	while (mask) {
@@ -1131,12 +1125,12 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 		}
 
 		if (ofpci_verbose)
-			printk("PCI: Making slot [%s]\n", sp);
+			pci_info(bus, "Making slot [%s]\n", sp);
 
 		pci_slot = pci_create_slot(bus, i, sp, NULL);
 		if (IS_ERR(pci_slot))
-			printk(KERN_ERR "PCI: pci_create_slot returned %ld\n",
-			       PTR_ERR(pci_slot));
+			pci_err(bus, "pci_create_slot returned %ld\n",
+				PTR_ERR(pci_slot));
 
 		sp += strlen(sp) + 1;
 		mask &= ~this_bit;
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 9bb6a192ef3f..ca5fa4cc6dda 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -489,8 +489,8 @@ void pci_scan_for_target_abort(struct pci_pbm_info *pbm,
 				   PCI_STATUS_REC_TARGET_ABORT));
 		if (error_bits) {
 			pci_write_config_word(pdev, PCI_STATUS, error_bits);
-			printk("%s: Device %s saw Target Abort [%016x]\n",
-			       pbm->name, pci_name(pdev), status);
+			pci_info(pdev, "%s: Device saw Target Abort [%016x]\n",
+				 pbm->name, status);
 		}
 	}
 
@@ -512,8 +512,8 @@ void pci_scan_for_master_abort(struct pci_pbm_info *pbm,
 			(status & (PCI_STATUS_REC_MASTER_ABORT));
 		if (error_bits) {
 			pci_write_config_word(pdev, PCI_STATUS, error_bits);
-			printk("%s: Device %s received Master Abort [%016x]\n",
-			       pbm->name, pci_name(pdev), status);
+			pci_info(pdev, "%s: Device received Master Abort "
+				 "[%016x]\n", pbm->name, status);
 		}
 	}
 
@@ -536,8 +536,8 @@ void pci_scan_for_parity_error(struct pci_pbm_info *pbm,
 				   PCI_STATUS_DETECTED_PARITY));
 		if (error_bits) {
 			pci_write_config_word(pdev, PCI_STATUS, error_bits);
-			printk("%s: Device %s saw Parity Error [%016x]\n",
-			       pbm->name, pci_name(pdev), status);
+			pci_info(dev, "%s: Device saw Parity Error [%016x]\n",
+				 pbm->name, status);
 		}
 	}
 
diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index 1994d7638406..0820ad0dba13 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -191,8 +191,8 @@ static void sparc64_teardown_msi_irq(unsigned int irq,
 			break;
 	}
 	if (i >= pbm->msi_num) {
-		printk(KERN_ERR "%s: teardown: No MSI for irq %u\n",
-		       pbm->name, irq);
+		pci_err(pdev, "%s: teardown: No MSI for irq %u\n", pbm->name,
+			irq);
 		return;
 	}
 
@@ -201,9 +201,9 @@ static void sparc64_teardown_msi_irq(unsigned int irq,
 
 	err = ops->msi_teardown(pbm, msi_num);
 	if (err) {
-		printk(KERN_ERR "%s: teardown: ops->teardown() on MSI %u, "
-		       "irq %u, gives error %d\n",
-		       pbm->name, msi_num, irq, err);
+		pci_err(pdev "%s: teardown: ops->teardown() on MSI %u, "
+			"irq %u, gives error %d\n", pbm->name, msi_num, irq,
+			err);
 		return;
 	}
 
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 7b137e07e0a4..ee4c9a9a171c 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -518,10 +518,10 @@ static void pcic_map_pci_device(struct linux_pcic *pcic,
 				 * board in a PCI slot. We must remap it
 				 * under 64K but it is not done yet. XXX
 				 */
-				printk("PCIC: Skipping I/O space at 0x%lx, "
-				    "this will Oops if a driver attaches "
-				    "device '%s' at %02x:%02x)\n", address,
-				    namebuf, dev->bus->number, dev->devfn);
+				pci_info(dev, "PCIC: Skipping I/O space at "
+					 "0x%lx, this will Oops if a driver "
+					 "attaches device '%s'\n", address,
+					 namebuf);
 			}
 		}
 	}
@@ -551,8 +551,8 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 		p++;
 	}
 	if (i >= pcic->pcic_imdim) {
-		printk("PCIC: device %s devfn %02x:%02x not found in %d\n",
-		    namebuf, dev->bus->number, dev->devfn, pcic->pcic_imdim);
+		pci_info(dev, "PCIC: device %s not found in %d\n", namebuf,
+			 pcic->pcic_imdim);
 		dev->irq = 0;
 		return;
 	}
@@ -565,7 +565,7 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 		ivec = readw(pcic->pcic_regs+PCI_INT_SELECT_HI);
 		real_irq = ivec >> ((i-4) << 2) & 0xF;
 	} else {					/* Corrupted map */
-		printk("PCIC: BAD PIN %d\n", i); for (;;) {}
+		pci_info(dev, "PCIC: BAD PIN %d\n", i); for (;;) {}
 	}
 /* P3 */ /* printk("PCIC: device %s pin %d ivec 0x%x irq %x\n", namebuf, i, ivec, dev->irq); */
 
@@ -574,10 +574,10 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 	 */
 	if (real_irq == 0 || p->force) {
 		if (p->irq == 0 || p->irq >= 15) {	/* Corrupted map */
-			printk("PCIC: BAD IRQ %d\n", p->irq); for (;;) {}
+			pci_info(dev, "PCIC: BAD IRQ %d\n", p->irq); for (;;) {}
 		}
-		printk("PCIC: setting irq %d at pin %d for device %02x:%02x\n",
-		    p->irq, p->pin, dev->bus->number, dev->devfn);
+		pci_info(dev, "PCIC: setting irq %d at pin %d\n", p->irq,
+			 p->pin);
 		real_irq = p->irq;
 
 		i = p->pin;
@@ -608,7 +608,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	struct pcidev_cookie *pcp;
 
 	if (!pcic0_up) {
-		printk("pcibios_fixup_bus: no PCIC\n");
+		pci_info(bus, "pcibios_fixup_bus: no PCIC\n");
 		return;
 	}
 	pcic = &pcic0;
@@ -617,7 +617,8 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	 * Next crud is an equivalent of pbm = pcic_bus_to_pbm(bus);
 	 */
 	if (bus->number != 0) {
-		printk("pcibios_fixup_bus: nonzero bus 0x%x\n", bus->number);
+		pci_info(bus, "pcibios_fixup_bus: nonzero bus 0x%x\n",
+			 bus->number);
 		return;
 	}
 
@@ -662,9 +663,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
+		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
