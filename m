Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58161 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbbKQRDC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Nov 2015 12:03:02 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] drivers: pci: host-generic: claim bus resources on PROBE_ONLY set-ups
Date: Tue, 17 Nov 2015 17:03:57 +0000
Message-Id: <1447779838-15585-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1447779838-15585-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1447779838-15585-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI host generic driver does not reassign bus resources on systems
that require the BARs set-up to be immutable (ie PROBE_ONLY) since
that would trigger system failures. Nonetheless, PCI bus resources
allocated to PCI bridge and devices must be claimed in order to be
validated and inserted in the kernel resource tree, but the current
driver omits the resources claiming and relies on arch specific kludges
to prevent probing failure (ie preventing resources enablement on
PROBE_ONLY systems).

This patch adds code to the PCI host generic driver that correctly
claims bus resources upon probe on systems that are required to
prevent reassignment after bus enumeration, so that the allocated
resources can be enabled successfully upon PCI device drivers probing,
without resorting to arch back-ends workarounds.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <david.daney@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-host-generic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 5434c90..c62d13f 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -261,7 +261,10 @@ static int gen_pci_probe(struct platform_device *pdev)
 
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

