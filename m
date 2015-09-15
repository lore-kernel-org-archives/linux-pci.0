Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34265 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbIOT0F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 15:26:05 -0400
Received: by obbda8 with SMTP id da8so143774779obb.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 12:26:03 -0700 (PDT)
Date: Tue, 15 Sep 2015 14:25:59 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ray Jui <rjui@broadcom.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
Message-ID: <20150915192559.GE25767@google.com>
References: <20150907091230.GB29293@red-moon>
 <20150914100929.GB18886@red-moon>
 <CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
 <20150914162834.GA11199@red-moon>
 <CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
 <CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
 <20150915094610.GD11199@red-moon>
 <CAErSpo5KaV7ERYcyZBzfvCEh40zSPJmymwXUCbAZkK=hb4DPSw@mail.gmail.com>
 <20150915163000.GA16240@red-moon>
 <55F84CAA.8060901@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55F84CAA.8060901@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ray]

On Tue, Sep 15, 2015 at 09:51:54AM -0700, Guenter Roeck wrote:
> On 09/15/2015 09:30 AM, Lorenzo Pieralisi wrote:
> >On Tue, Sep 15, 2015 at 04:57:07PM +0100, Bjorn Helgaas wrote:

> >>I'm inclined to revert dff22d2054b5 ("PCI: Call
> >>pci_read_bridge_bases() from core instead of arch code") until we can
> >>figure this out.  I think the idea of moving that work from
> >>arch-specific code to the core is good, but it seems like it leads to
> >>more hacky workarounds than real cleanup right now.  What would break
> >>if we simply reverted it?  Would that reintroduce any problems?
> >
> >None that I am aware of, I know Guenter required it for this series:
> >
> >https://lkml.org/lkml/2015/7/30/861
> >
> >but it was not merged so, as far as I understand, reverting the patch
> >should get things to normal. I think it unearthed a couple of niggles
> 
> It looks like me and Yinghai disagree how the problem I was trying to fix
> should be handled, I don't understand Yinghai's concerns, and unfortunately
> I just don't have the time I would need to get a better understanding.
> It is fine with me to revert your patch and abandon mine.

I don't understand those concerns either (yet).

I put the following on my for-linus branch for v4.3.  I'd appreciate any
corrections to my understanding of the problem.


commit d5da9d99d4d79d877815af96fdbfac829c4ce7b2
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Sep 15 13:18:04 2015 -0500

    PCI: Revert "PCI: Call pci_read_bridge_bases() from core instead of arch code"
    
    Revert dff22d2054b5 ("PCI: Call pci_read_bridge_bases() from core instead
    of arch code").
    
    Reading PCI bridge windows is not arch-specific in itself, but there is PCI
    core code that doesn't work correctly if we read them too early.  For
    example, Hannes found this case on an ARM Freescale i.mx6 board:
    
      pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
      pci 0000:00:00.0: PCI bridge to [bus 01-ff]
      pci 0000:00:00.0: BAR 8: no space for [mem size 0x01000000] (mem window)
      pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
      pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
      pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
    
    The 00:00.0 mem window needs to be at least 3MB: the 01:00.0 device needs
    0x204100 of space, and mem windows are megabyte-aligned.
    
    Bus sizing can increase a bridge window size, but never *decrease* it (see
    d65245c3297a ("PCI: don't shrink bridge resources")).  Prior to
    dff22d2054b5, ARM didn't read bridge windows at all, so the "original size"
    was zero, and we assigned a 3MB window.
    
    After dff22d2054b5, we read the bridge windows before sizing the bus.  The
    firmware programmed a 16MB window (size 0x01000000) in 00:00.0, and since
    we never decrease the size, we kept 16MB even though we only needed 3MB.
    But 16MB doesn't fit in the host bridge aperture, so we failed to assign
    space for the window and the downstream devices.
    
    I think this is a defect in the PCI core: we shouldn't rely on the firmware
    to assign sensible windows.
    
    Ray reported a similar problem, also on ARM, with Broadcom iProc.
    
    Issues like this are too hard to fix right now, so revert dff22d2054b5.
    
    Reported-by: Hannes <oe5hpm@gmail.com>
    Reported-by: Ray Jui <rjui@broadcom.com>
    Link: http://lkml.kernel.org/r/CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com
    Link: http://lkml.kernel.org/r/55F75BB8.4070405@broadcom.com
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index cded02c..5f387ee 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -242,7 +242,12 @@ pci_restore_srm_config(void)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev = bus->self;
+
+	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
+	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pci_read_bridge_bases(bus);
+	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_save_srm_config(dev);
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index f9c86c4..f211839 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -294,6 +294,8 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	printk("### PCIBIOS_FIXUP_BUS(%d)\n",bus->number);
 #endif
 
+	pci_read_bridge_bases(bus);
+
 	if (bus->number == 0) {
 		struct pci_dev *dev;
 		list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index d89b601..7cc3be9 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -533,9 +533,10 @@ void pcibios_fixup_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
 
-	if (b->self)
+	if (b->self) {
+		pci_read_bridge_bases(b);
 		pcibios_fixup_bridge_resources(b->self);
-
+	}
 	list_for_each_entry(dev, &b->devices, bus_list)
 		pcibios_fixup_device_resources(dev);
 	platform_pci_fixup_bus(b);
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 6b8b752..ae838ed 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -863,7 +863,14 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* Fixup the bus */
+	/* When called from the generic PCI probe, read PCI<->PCI bridge
+	 * bases. This is -not- called when generating the PCI tree from
+	 * the OF device-tree.
+	 */
+	if (bus->self != NULL)
+		pci_read_bridge_bases(bus);
+
+	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
 
 	/* Now fixup devices on that bus */
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index c6996cf..b8a0bf5 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -311,6 +311,12 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
+	struct pci_dev *dev = bus->self;
+
+	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
+	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pci_read_bridge_bases(bus);
+	}
 }
 
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index deaa893..3dfe2d3 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -324,6 +324,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	if (bus->self) {
+		pci_read_bridge_bases(bus);
 		pcibios_fixup_bridge_resources(bus->self);
 	}
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a1d0632..7587b2a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1032,7 +1032,13 @@ void pcibios_set_master(struct pci_dev *dev)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* Fixup the bus */
+	/* When called from the generic PCI probe, read PCI<->PCI bridge
+	 * bases. This is -not- called when generating the PCI tree from
+	 * the OF device-tree.
+	 */
+	pci_read_bridge_bases(bus);
+
+	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
 
 	/* Now fixup devices on that bus */
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 09d3afc..dc78a4a 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -166,6 +166,7 @@ void pcibios_fixup_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
 
+	pci_read_bridge_bases(b);
 	list_for_each_entry(dev, &b->devices, bus_list)
 		pcibios_fixup_device_resources(dev);
 }
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index d27b4dc..b848cc3 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -210,6 +210,10 @@ subsys_initcall(pcibios_init);
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
+	if (bus->parent) {
+		/* This is a subordinate bridge */
+		pci_read_bridge_bases(bus);
+	}
 }
 
 void pcibios_set_master(struct pci_dev *dev)
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index baec33c..a0580af 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -560,6 +560,9 @@ dino_fixup_bus(struct pci_bus *bus)
 	} else if (bus->parent) {
 		int i;
 
+		pci_read_bridge_bases(bus);
+
+
 		for(i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
 			if((bus->self->resource[i].flags & 
 			    (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 7b9e89b..a32c1f6 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -693,6 +693,7 @@ lba_fixup_bus(struct pci_bus *bus)
 	if (bus->parent) {
 		int i;
 		/* PCI-PCI Bridge */
+		pci_read_bridge_bases(bus);
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++)
 			pci_claim_bridge_resource(bus->self, i);
 	} else {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b2be17..c8cc0e62 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -855,9 +855,6 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			child->bridge_ctl = bctl;
 		}
 
-		/* Read and initialize bridge resources */
-		pci_read_bridge_bases(child);
-
 		cmax = pci_scan_child_bus(child);
 		if (cmax > subordinate)
 			dev_warn(&dev->dev, "bridge has subordinate %02x but max busn %02x\n",
@@ -918,9 +915,6 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 
 		if (!is_cardbus) {
 			child->bridge_ctl = bctl;
-
-			/* Read and initialize bridge resources */
-			pci_read_bridge_bases(child);
 			max = pci_scan_child_bus(child);
 		} else {
 			/*
