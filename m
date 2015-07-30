Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40541 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbG3NNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Jul 2015 09:13:14 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: [PATCH] ARM64: PCI: do not enable resources on PROBE_ONLY systems
Date: Thu, 30 Jul 2015 14:13:59 +0100
Message-Id: <1438262039-32085-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On ARM64 PROBE_ONLY PCI systems resources are not currently claimed,
therefore they can't be enabled since they do not have a valid
parent pointer; this in turn prevents enabling PCI devices on
ARM64 PROBE_ONLY systems, causing PCI devices initialization to
fail.

To solve this issue, resources must be claimed when devices are
added on PROBE_ONLY systems, which ensures that the resource hierarchy
is validated and the resource tree is sane, but this requires changes
in the ARM64 resource management that can affect adversely existing
PCI set-ups (claiming resources on !PROBE_ONLY systems might break
existing ARM64 PCI platform implementations).

As a temporary solution in preparation for a proper resources claiming
implementation in ARM64 core, to enable PCI PROBE_ONLY systems on ARM64,
this patch adds a pcibios_enable_device() arch implementation that
simply prevents enabling resources on PROBE_ONLY systems (mirroring ARM
behaviour).

This is always a safe thing to do because on PROBE_ONLY systems the
configuration space set-up can be considered immutable, and it is in
preparation of proper resource claiming that would finally validate
the PCI resources tree in the ARM64 arch implementation on PROBE_ONLY
systems.

For !PROBE_ONLY systems resources enablement in pcibios_enable_device()
on ARM64 is implemented as in current PCI core, leaving the behaviour
unchanged.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
Bjorn, all,

as I mention in the commit log, this patch is a temporary solution
in preparation for proper resources claiming in ARM64, so that
we can safely enable the PCI generic host controller on ARM64 systems.

It mirrors ARM implementation and I will work on changing both
ARM and ARM64 to convert them to proper resources claiming in
the respective implementations.

Lorenzo

 arch/arm64/kernel/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4095379..b3d098b 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -38,6 +38,19 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return res->start;
 }
 
+/**
+ * pcibios_enable_device - Enable I/O and memory.
+ * @dev: PCI device to be enabled
+ * @mask: bitmask of BARs to enable
+ */
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	if (pci_has_flag(PCI_PROBE_ONLY))
+		return 0;
+
+	return pci_enable_resources(dev, mask);
+}
+
 /*
  * Try to assign the IRQ number from DT when adding a new device
  */
-- 
2.2.1

