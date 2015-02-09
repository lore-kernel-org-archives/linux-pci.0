Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com ([157.56.110.135]:42644
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760974AbbBIPX0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Feb 2015 10:23:26 -0500
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"Will Deacon" <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>
CC: Marc Zyngier <marc.zyngier@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 2/2] PCI: Do not call pci_enable_resource when specifying PCI_PROBE_ONLY
Date: Mon, 9 Feb 2015 23:22:30 +0800
Message-ID: <1423495350-12295-3-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1423495350-12295-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1423495350-12295-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When using PCI_PROBE_ONLY, Linux does not assign resource to PCI devices.
This causes error when calling the pci_enable_resources function, and not
allowing driver to set the PCI_COMMAND_IO and PCI_COMMAND_MEMORY flag in
the config space of endpoint device since it checks if the resource parent
is set.

This patch adds the check in driver/pci/pci.c to avoid redundant
arch-specific code. For example, it was in arch/arm/kernel/bios32.c and
also needed in the arch/arm64/kernel/pci.c.

This should not affect other architecture since most of them either
override the weak version of pcibios_enable_device()
or does not set PCI_PROBE_ONLY.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

---
NOTE:
Alpha seems to be the only arch that dooes not define pcibios_enable_device()
and also set PCI_PROBE_ONLY flag. I am not sure if this would cause any issues.
I might need help testing on Alpha.

 arch/arm/kernel/bios32.c | 12 ------------
 drivers/pci/pci.c        |  3 +++
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index a4effd6..091f508 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -607,18 +607,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9d4fd8..1748f95 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1187,6 +1187,9 @@ EXPORT_SYMBOL_GPL(pci_load_and_free_saved_state);
 
 int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
 {
+	if (pci_has_flag(PCI_PROBE_ONLY))
+		return 0;
+
 	return pci_enable_resources(dev, bars);
 }
 
-- 
2.1.0

