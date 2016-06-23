Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52770 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbcFWKfq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jun 2016 06:35:46 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3][UPDATE] ARM/PCI: claim bus resources on PCI_PROBE_ONLY set-ups
Date: Thu, 23 Jun 2016 11:36:22 +0100
Message-Id: <1466678182-27672-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI bios API does not reassign bus resources on systems
that require the BARs set-up to be immutable (ie PCI_PROBE_ONLY) since
that would trigger system failures. Nonetheless, PCI bus resources
allocated to PCI bridge and devices must be claimed in order to be
validated and inserted in the kernel resource tree, but the current
code omits the resources claiming and relies on arch specific kludges
to prevent probing failure (ie preventing resources enablement on
PCI_PROBE_ONLY systems).

Add code to the ARM PCI bios kernel layer that correctly claims bus
resources upon probe on systems that are required to prevent
reassignment after bus enumeration, so that the allocated resources
can be enabled successfully upon PCI device drivers probing, without
resorting to arch back-ends workarounds.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
---
Hi Bjorn,

I put together this patch as requested, I could not test this
specific path but I do not really see how this patch would
affect any existing set-up.

It completes (and should be inserted as patch 2 or 3 for
bisection reasons) this series:

https://patchwork.ozlabs.org/patch/632161/

Please let me know if that's ok.

Thanks!
Lorenzo

 arch/arm/kernel/bios32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 488545f..1e05d04 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -515,7 +515,9 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	list_for_each_entry(sys, &head, node) {
 		struct pci_bus *bus = sys->bus;
 
-		if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		if (pci_has_flag(PCI_PROBE_ONLY)) {
+			pci_bus_claim_resources(bus);
+		} else {
 			struct pci_bus *child;
 
 			/*
-- 
2.6.4

