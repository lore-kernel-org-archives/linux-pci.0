Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51576 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbcCAOmB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Mar 2016 09:42:01 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: [PATCH v2 2/3] drivers: pci: host-generic: claim bus resources on PCI_PROBE_ONLY set-ups
Date: Tue,  1 Mar 2016 14:44:08 +0000
Message-Id: <1456843449-19393-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI host generic driver does not reassign bus resources on systems
that require the BARs set-up to be immutable (ie PCI_PROBE_ONLY) since
that would trigger system failures. Nonetheless, PCI bus resources
allocated to PCI bridge and devices must be claimed in order to be
validated and inserted in the kernel resource tree, but the current
driver omits the resources claiming and relies on arch specific kludges
to prevent probing failure (ie preventing resources enablement on
PCI_PROBE_ONLY systems).

This patch adds code to the PCI host generic driver that correctly
claims bus resources upon probe on systems that are required to
prevent reassignment after bus enumeration, so that the allocated
resources can be enabled successfully upon PCI device drivers probing,
without resorting to arch back-ends workarounds.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <david.daney@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-host-generic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 1652bc7..e529825 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -252,7 +252,10 @@ static int gen_pci_probe(struct platform_device *pdev)
 
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(bus);
+	} else {
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
 
-- 
2.5.1

