Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50338 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbbFIJBm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Jun 2015 05:01:42 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFC/RFT PATCH v2] PCI: move pci_read_bridge_bases to the generic PCI layer
Date: Tue,  9 Jun 2015 10:01:45 +0100
Message-Id: <1433840506-20083-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a PCI bus is scanned, upon PCI bridge detection the kernel
has to read the bridge registers to set-up its resources so that
the PCI resource hierarchy can be validated properly.

Most if not all architectures read PCI bridge registers in the
pcibios_fixup_bus hook, that is called by the PCI generic layer
whenever a PCI bus is scanned.

Since pci_read_bridge_bases is an arch agnostic operation (and it
is carried out on all architectures) it can be moved to the generic
PCI layer in order to consolidate code and remove the respective
calls from the architectures back-ends.

The PCI_PROBE_ONLY flag is not checked before calling
pci_read_bridge_buses in the generic layer since reading the bridge
bases is not related to resources assignment; this implies that it
can be carried out safely on PCI_PROBE_ONLY systems too and should
not affect architectures (alpha, mips) that check the PCI_PROBE_ONLY
flag before reading the bridge bases.

In order to validate the resource hierarchy as soon as the resources
themselves are probed (ie read from the bridge), this patch also adds
code to pci_read_bridge_bases that claims the bridge resources, so that
they are validated and inserted in the resource hierarchy as soon as
the bridge bases are probed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Luck <tony.luck@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Chris Zankel <chris@zankel.net>
---
v1->v2:

- Moved pci_read_bridge_bases call to pci_scan_bridge to read bases before
  scanning devices
- Added bridge resources claiming

v1: https://lkml.org/lkml/2015/5/21/359

 arch/alpha/kernel/pci.c          |  7 +------
 arch/frv/mb93090-mb00/pci-vdk.c  |  2 --
 arch/ia64/pci/pci.c              |  1 -
 arch/microblaze/pci/pci-common.c |  9 +--------
 arch/mips/pci/pci.c              |  6 ------
 arch/mn10300/unit-asb2305/pci.c  |  1 -
 arch/powerpc/kernel/pci-common.c |  8 +-------
 arch/x86/pci/common.c            |  1 -
 arch/xtensa/kernel/pci.c         |  4 ----
 drivers/parisc/dino.c            |  3 ---
 drivers/parisc/lba_pci.c         |  1 -
 drivers/pci/probe.c              | 26 ++++++++++++++++++++++++++
 12 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 82f738e..cded02c 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -242,12 +242,7 @@ pci_restore_srm_config(void)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_dev *dev = bus->self;
-
-	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
- 		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
- 		pci_read_bridge_bases(bus);
-	} 
+	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_save_srm_config(dev);
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index f211839..f9c86c4 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -294,8 +294,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	printk("### PCIBIOS_FIXUP_BUS(%d)\n",bus->number);
 #endif
 
-	pci_read_bridge_bases(bus);
-
 	if (bus->number == 0) {
 		struct pci_dev *dev;
 		list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 7cc3be9..563228b 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -534,7 +534,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
 	struct pci_dev *dev;
 
 	if (b->self) {
-		pci_read_bridge_bases(b);
 		pcibios_fixup_bridge_resources(b->self);
 	}
 	list_for_each_entry(dev, &b->devices, bus_list)
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index ae838ed..6b8b752 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -863,14 +863,7 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* When called from the generic PCI probe, read PCI<->PCI bridge
-	 * bases. This is -not- called when generating the PCI tree from
-	 * the OF device-tree.
-	 */
-	if (bus->self != NULL)
-		pci_read_bridge_bases(bus);
-
-	/* Now fixup the bus bus */
+	/* Fixup the bus */
 	pcibios_setup_bus_self(bus);
 
 	/* Now fixup devices on that bus */
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index b8a0bf5..c6996cf 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -311,12 +311,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_dev *dev = bus->self;
-
-	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
-	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
-		pci_read_bridge_bases(bus);
-	}
 }
 
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index 3dfe2d3..deaa893 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -324,7 +324,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	if (bus->self) {
-		pci_read_bridge_bases(bus);
 		pcibios_fixup_bridge_resources(bus->self);
 	}
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0d05406..722dd5f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1043,13 +1043,7 @@ void pcibios_set_master(struct pci_dev *dev)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* When called from the generic PCI probe, read PCI<->PCI bridge
-	 * bases. This is -not- called when generating the PCI tree from
-	 * the OF device-tree.
-	 */
-	pci_read_bridge_bases(bus);
-
-	/* Now fixup the bus bus */
+	/* Fixup the bus */
 	pcibios_setup_bus_self(bus);
 
 	/* Now fixup devices on that bus */
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 8fd6f44..3bff244 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -166,7 +166,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
 
-	pci_read_bridge_bases(b);
 	list_for_each_entry(dev, &b->devices, bus_list)
 		pcibios_fixup_device_resources(dev);
 }
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index b848cc3..d27b4dc 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -210,10 +210,6 @@ subsys_initcall(pcibios_init);
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	if (bus->parent) {
-		/* This is a subordinate bridge */
-		pci_read_bridge_bases(bus);
-	}
 }
 
 void pcibios_set_master(struct pci_dev *dev)
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index a0580af..baec33c 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -560,9 +560,6 @@ dino_fixup_bus(struct pci_bus *bus)
 	} else if (bus->parent) {
 		int i;
 
-		pci_read_bridge_bases(bus);
-
-
 		for(i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
 			if((bus->self->resource[i].flags & 
 			    (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index dceb9dd..901e1a3 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -693,7 +693,6 @@ lba_fixup_bus(struct pci_bus *bus)
 	if (bus->parent) {
 		int i;
 		/* PCI-PCI Bridge */
-		pci_read_bridge_bases(bus);
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++)
 			pci_claim_bridge_resource(bus->self, i);
 	} else {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6675a7a..1913e1b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -332,6 +332,21 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
+static void pci_claim_bridge_resources(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+	int idx;
+
+	for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
+		struct resource *r = &dev->resource[idx];
+
+		if (!r->flags || r->parent)
+			continue;
+
+		pci_claim_bridge_resource(dev, idx);
+	}
+}
+
 static void pci_read_bridge_io(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
@@ -479,6 +494,8 @@ void pci_read_bridge_bases(struct pci_bus *child)
 			}
 		}
 	}
+
+	pci_claim_bridge_resources(child);
 }
 
 static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
@@ -826,6 +843,11 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			child->bridge_ctl = bctl;
 		}
 
+		/*
+		 * Read and initialize bridge resources.
+		 */
+		pci_read_bridge_bases(child);
+
 		cmax = pci_scan_child_bus(child);
 		if (cmax > subordinate)
 			dev_warn(&dev->dev, "bridge has subordinate %02x but max busn %02x\n",
@@ -886,6 +908,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 
 		if (!is_cardbus) {
 			child->bridge_ctl = bctl;
+			/*
+			 * Read and initialize bridge resources.
+			 */
+			pci_read_bridge_bases(child);
 			max = pci_scan_child_bus(child);
 		} else {
 			/*
-- 
2.2.1

