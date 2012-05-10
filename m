Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34698 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab2EJKfp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2012 06:35:45 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A76243EE0AE
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:35:43 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F47C45DD74
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:35:43 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 75FAE45DE53
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:35:43 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6A2771DB802C
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:35:43 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 272731DB803C
	for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 19:35:43 +0900 (JST)
Message-ID: <4FAB9A9A.2080009@jp.fujitsu.com>
Date: Thu, 10 May 2012 19:38:18 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Subject: Re: [RFC] pciehp: Add archdata setting
References: <4F79584B.2010301@jp.fujitsu.com> <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com> <4F7AA3A2.1080900@jp.fujitsu.com> <4F7C003B.4040208@jp.fujitsu.com> <4F866184.4000403@jp.fujitsu.com> <CAErSpo6Xb6rbZ757VHuQnWWsXbnygTM9JQFzvOnOiM895D+R-g@mail.gmail.com> <4F876C54.5040408@jp.fujitsu.com> <4F8BBCE5.6010108@jp.fujitsu.com> <CAErSpo4yicqFBGEFWYuDfknWaeFcisWzpk4u3DR=7BkVA1XZwA@mail.gmail.com>
In-Reply-To: <CAErSpo4yicqFBGEFWYuDfknWaeFcisWzpk4u3DR=7BkVA1XZwA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050901050206000006070207"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050901050206000006070207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Bjorn


Refer to your review and comment, I updated bus notifier code.
This works good. Thanks for your comments.
And I think this way can be applied to microblaze.
Please review this patch.


* Changes
   1. Moving pcibios_setup_bus_devices code to 
pcibios_device_change_notifier so that boot and hotplug use same code. 
This will change boot message on powerpc platform but there is no 
difference. Please see "Not patched boot message" and "Patched message".
   2. Calling bus_register_notifier in pcibios_init.
   3. Using bus notifier not only on powerpc platform but also on 
microblaze platform because microblaze pcibios_setup_bus_devices is a 
similer way with powerpc.
   4. Removing caller and callee of pcibios_setup_bus_devices because 
bus notifier works instead of pcibios_setup_bus_devices.

* Not patched boot message
PCI: Probing PCI hardware
<snip>
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa01fffff]
pci 0000:00:00.0:   bridge window [mem 0x10000000-0x000fffff pref] 
(disabled)
irq: irq 4 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
<snip>
pci 0000:01:00.0: PCI bridge to [bus 02-ff]
pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:01:00.0:   bridge window [mem 0xa0100000-0xa01fffff]
pci 0000:01:00.0:   bridge window [mem 0x10000000-0x000fffff pref] 
(disabled)
irq: irq 5 on host /soc@ffe00000/pic@40000 mapped to virtual irq 17
irq: irq 7 on host /soc@ffe00000/pic@40000 mapped to virtual irq 18

* Patched boot message
PCI: Probing PCI hardware
<snip>
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa01fffff]
pci 0000:00:00.0:   bridge window [mem 0x10000000-0x000fffff pref] 
(disabled)
<snip>
pci 0000:01:00.0: PCI bridge to [bus 02-ff]
pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:01:00.0:   bridge window [mem 0xa0100000-0xa01fffff]
pci 0000:01:00.0:   bridge window [mem 0x10000000-0x000fffff pref] 
(disabled)
<snip>
irq: irq 4 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
irq: irq 5 on host /soc@ffe00000/pic@40000 mapped to virtual irq 17
irq: irq 7 on host /soc@ffe00000/pic@40000 mapped to virtual irq 18

* Not patched pciehp message on powerpc platform
# echo 1 > /sys/bus/pci/slots/1/power
<snip>
pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
pcieport 0000:02:01.0:   bridge window [io  0xff7ee000-0xff7eefff]
pcieport 0000:02:01.0:   bridge window [mem 0xa0100000-0xa01fffff]
pcieport 0000:02:01.0:   bridge window [mem 0xa0200000-0xa02fffff 64bit 
pref]
pci 0000:03:00.0: no hotplug settings from platform
e1000e 0000:03:00.0: Disabling ASPM  L1
e1000e 0000:03:00.0: enabling device (0000 -> 0002)
e1000e 0000:03:00.0: No usable DMA configuration, aborting
e1000e: probe of 0000:03:00.0 failed with error -5

* Patched pciehp message on powerpc platform
# echo 1 > /sys/bus/pci/slots/1/power
<snip>
pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
pcieport 0000:02:01.0:   bridge window [io  0xff7ee000-0xff7eefff]
pcieport 0000:02:01.0:   bridge window [mem 0xa0100000-0xa01fffff]
pcieport 0000:02:01.0:   bridge window [mem 0xa0200000-0xa02fffff 64bit 
pref]
pci 0000:03:00.0: no hotplug settings from platform
e1000e 0000:03:00.0: Disabling ASPM  L1
e1000e 0000:03:00.0: enabling device (0000 -> 0002)
irq: irq 6 on host /soc@ffe00000/msi@41600 mapped to virtual irq 27
e1000e 0000:03:00.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:15:17:bf:c0:c9
e1000e 0000:03:00.0: eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:03:00.0: eth0: MAC: 1, PHY: 4, PBA No: D50861-003


Regards.

Hiroo MATSUMOTO


> Instead of making this a rootfs_initcall(), can you call
> bus_register_notifier() explicitly in pcibios_init()?  That way
> pcibios_device_change_notifier() should get called for *all* new PCI
> devices, whether we find them at boot-time or they're hot-added later.
> 
> If you do that, I think you can move all the
> pcibios_setup_bus_devices() code into the
> pcibios_device_change_notifier() path, including the NUMA node and IRQ
> fixups.
> 
> Your patch will also need a changelog.
> 
> Bjorn
> 
> 

--------------050901050206000006070207
Content-Type: text/plain;
 name="add-pcibios_device_change_notifier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-pcibios_device_change_notifier.patch"

Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 0331376..8d11277 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -149,8 +149,8 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
+extern void pcibios_setup_bus_notifier(void);
 
 /* This part of code was originally in xilinx-pci.h */
 #ifdef CONFIG_PCI_XILINX
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 85f2ac1..bb28ede 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1063,31 +1063,6 @@ void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
 		pcibios_fixup_bridge(bus);
 }
 
-void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pr_debug("PCI: Fixup bus devices %d (%s)\n",
-		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/* Setup OF node pointer in archdata */
-		dev->dev.of_node = pci_device_to_OF_node(dev);
-
-		/* Fixup NUMA node as it may not be setup yet by the generic
-		 * code and is needed by the DMA init
-		 */
-		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
-
-		/* Hook up default DMA ops */
-		set_dma_ops(&dev->dev, pci_dma_ops);
-		dev->dev.archdata.dma_data = (void *)PCI_DRAM_OFFSET;
-
-		/* Read default IRQs and fixup if necessary */
-		pci_read_irq_line(dev);
-	}
-}
-
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* When called from the generic PCI probe, read PCI<->PCI bridge
@@ -1099,9 +1074,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 
 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
@@ -1604,6 +1576,43 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	hose->last_busno = bus->subordinate;
 }
 
+static int pcibios_device_change_notifier(struct notifier_block *nb,
+					  unsigned long action, void *data)
+{
+	struct pci_dev *dev = to_pci_dev(data);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/* Setup OF node pointer in archdata */
+		dev->dev.of_node = pci_device_to_OF_node(dev);
+
+		/* Fixup NUMA node as it may not be setup yet by the generic
+		 * code and is needed by the DMA init
+		 */
+		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+		/* Hook up default DMA ops */
+		set_dma_ops(&dev->dev, pci_dma_ops);
+		dev->dev.archdata.dma_data = (void *)PCI_DRAM_OFFSET;
+
+		/* Read default IRQs and fixup if necessary */
+		pci_read_irq_line(dev);
+
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block device_nb = {
+	.notifier_call = pcibios_device_change_notifier,
+};
+
+void __devinit pcibios_setup_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &device_nb);
+}
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
@@ -1611,6 +1620,8 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	pcibios_setup_bus_notifier();
+
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		hose->last_busno = 0xff;
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index f54b3d2..7b4ca5a 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -190,10 +190,10 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
 extern void pcibios_scan_phb(struct pci_controller *hose);
+extern void pcibios_setup_bus_notifier(void);
 
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index cce98d7..78ac583 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1097,40 +1097,6 @@ void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pci_dma_bus_setup(bus);
 }
 
-void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pr_debug("PCI: Fixup bus devices %d (%s)\n",
-		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/* Cardbus can call us to add new devices to a bus, so ignore
-		 * those who are already fully discovered
-		 */
-		if (dev->is_added)
-			continue;
-
-		/* Fixup NUMA node as it may not be setup yet by the generic
-		 * code and is needed by the DMA init
-		 */
-		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
-
-		/* Hook up default DMA ops */
-		set_dma_ops(&dev->dev, pci_dma_ops);
-		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
-
-		/* Additional platform DMA/iommu setup */
-		if (ppc_md.pci_dma_dev_setup)
-			ppc_md.pci_dma_dev_setup(dev);
-
-		/* Read default IRQs and fixup if necessary */
-		pci_read_irq_line(dev);
-		if (ppc_md.pci_irq_fixup)
-			ppc_md.pci_irq_fixup(dev);
-	}
-}
-
 void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
@@ -1147,16 +1113,11 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 
 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
 void __devinit pci_fixup_cardbus(struct pci_bus *bus)
 {
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 
 
@@ -1763,6 +1724,55 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	}
 }
 
+static int pcibios_device_change_notifier(struct notifier_block *nb,
+					  unsigned long action, void *data)
+{
+	struct pci_dev *dev = to_pci_dev(data);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/* Cardbus can call us to add new devices to a bus, so ignore
+		 * those who are already fully discovered
+		 */
+		if (dev->is_added)
+			break;
+
+		/* Setup OF node pointer in the device */
+		dev->dev.of_node = pci_device_to_OF_node(dev);
+
+		/* Fixup NUMA node as it may not be setup yet by the generic
+		 * code and is needed by the DMA init
+		 */
+		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+		/* Hook up default DMA ops */
+		set_dma_ops(&dev->dev, pci_dma_ops);
+		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
+
+		/* Additional platform DMA/iommu setup */
+		if (ppc_md.pci_dma_dev_setup)
+			ppc_md.pci_dma_dev_setup(dev);
+
+		/* Read default IRQs and fixup if necessary */
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
+
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block device_nb = {
+	.notifier_call = pcibios_device_change_notifier,
+};
+
+void __devinit pcibios_setup_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &device_nb);
+}
+
 static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
 	int i, class = dev->class >> 8;
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index fdd1a3d..5a30cec 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -231,6 +231,8 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	pcibios_setup_bus_notifier();
+
 	if (pci_has_flag(PCI_REASSIGN_ALL_BUS))
 		pci_assign_all_buses = 1;
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 3318d39..d66c9dc 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -50,6 +50,8 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
+	pcibios_setup_bus_notifier();
+
 	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index b37d0b5..1e29642 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -329,7 +329,6 @@ static void __devinit __of_scan_bus(struct device_node *node,
 	 */
 	if (!rescan_existing)
 		pcibios_setup_bus_self(bus);
-	pcibios_setup_bus_devices(bus);
 
 	/* Now scan child busses */
 	list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 55d4ec1..fdb8b64 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -120,7 +120,6 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
 		if (!num)
 			return;
-		pcibios_setup_bus_devices(bus);
 		max = bus->secondary;
 		for (pass=0; pass < 2; pass++)
 			list_for_each_entry(dev, &bus->devices, bus_list) {

--------------050901050206000006070207--

