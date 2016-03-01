Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51584 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbcCAOmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Mar 2016 09:42:03 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	David Daney <david.daney@cavium.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 3/3] arm/arm64: pci: remove arch specific pcibios_enable_device()
Date: Tue,  1 Mar 2016 14:44:09 +0000
Message-Id: <1456843449-19393-4-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The arm/arm64 pcibios_enable_device() implementations exist solely
to prevent enabling PCI resources on PROBE_ONLY systems, since
on those systems the PCI resources are currently not claimed (ie
validated and inserted in the PCI resource tree) therefore they can
not be enabled since this would trigger PCI set-ups failures.

By introducing resources claiming in the PCI host controllers set-ups
that have PROBE_ONLY as a probe option, there is no need for arch specific
pcibios_enable_device() implementations anymore in that the kernel can
rely on the generic pcibios_enable_device() implementation without
resorting to arch specific code to work around the missing resources
claiming enumeration step.

This patch removes the pcibios_enable_device() implementations from
the arm/arm64 arches back-end.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/kernel/bios32.c | 12 ------------
 arch/arm64/kernel/pci.c  | 13 -------------
 2 files changed, 25 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 05e61a2..488545f 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -590,18 +590,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
-/**
- * pcibios_enable_device - Enable I/O and memory.
- * @dev: PCI device to be enabled
- */
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	if (pci_has_flag(PCI_PROBE_ONLY))
-		return 0;
-
-	return pci_enable_resources(dev, mask);
-}
-
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index b3d098b..4095379 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -38,19 +38,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return res->start;
 }
 
-/**
- * pcibios_enable_device - Enable I/O and memory.
- * @dev: PCI device to be enabled
- * @mask: bitmask of BARs to enable
- */
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	if (pci_has_flag(PCI_PROBE_ONLY))
-		return 0;
-
-	return pci_enable_resources(dev, mask);
-}
-
 /*
  * Try to assign the IRQ number from DT when adding a new device
  */
-- 
2.5.1

