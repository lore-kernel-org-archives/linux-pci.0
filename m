Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39480 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbbENOmY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 May 2015 10:42:24 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
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
	Liviu Dudau <liviu.dudau@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFC/RFT PATCH 1/2] ARM: kernel: bios32: implement PCI device resources claiming
Date: Thu, 14 May 2015 15:42:15 +0100
Message-Id: <1431614537-16136-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current ARM pcibios layer prevents PCI devices resources enablement
if the PCI_PROBE_ONLY global flag is set, since on systems that require
immutable PCI BARs set-up (ie probe only) the arm PCI bios layer does
not assign resources, hence resources are not really checked (ie claimed)
and they do not get assigned a parent, which causes pci_enable_resources
to fail in turn.

If the kernel tries to enable the resources for a PCI device through
pci_enable_resources, it would fail on PCI_PROBE_ONLY systems since the
device resources are not claimed (ie they are not assigned) on those
systems and the resource parent is left uninitialized (ie they have a
dangling parent pointer).

This behaviour does not conform with the expected kernel behaviour.

When a PCI device and its resources are scanned, the detected PCI
resources should be claimed in order to validate their values read
from the BARs set-up and should be assigned a parent resource so that the
resource hierarchy is initialized.

Resource claiming must be carried out on PCI_PROBE_ONLY systems
too, since it is a method for validating resources and it has nothing
to do with PCI_PROBE_ONLY flag.

This patch removes the pcibios_enable_device call from the arm bios32
implementation (which means that arm falls back to the generic weak
version for its implementation, that correctly enables a device resources)
and replaces it with an arm pcibios_add_device implementation, that claims
resources for a device, so that the behaviour becomes compliant with the
expected PCI device kernel initialization flow.

This way, resources are claimed and enabled on PCI_PROBE_ONLY systems
too improving the BAR set-up validation and making the arm kernel PCI
behaviour closer to other architectures.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/kernel/bios32.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..aace9ca 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -604,15 +604,25 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 }
 
 /**
- * pcibios_enable_device - Enable I/O and memory.
- * @dev: PCI device to be enabled
+ * pcibios_add_device - Initialize device before adding it to PCI bus
+ * @dev: PCI device to be added
  */
-int pcibios_enable_device(struct pci_dev *dev, int mask)
+int pcibios_add_device(struct pci_dev *dev)
 {
-	if (pci_has_flag(PCI_PROBE_ONLY))
-		return 0;
+	struct resource *res;
+	int i;
+	/*
+	 * Device resources are claimed to validate
+	 * them and initialize their hierarchy structure
+	 */
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		res = &dev->resource[i];
+		if (res->parent || !res->flags)
+			continue;
+		pci_claim_resource(dev, i);
+	}
 
-	return pci_enable_resources(dev, mask);
+	return 0;
 }
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-- 
2.2.1

