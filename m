Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36224 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:52 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 10/29] ARM/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:43 +0100
Message-Id: <1445576642-29624-11-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently PCI device IRQs under arm are initialised during the
pci_common_init_dev code path, this results in an extra sweep of the
PCI bus as well as causing PCI devices hot-plugged after boot to not
receive an IRQ.

This patch set defers this assignment untill the device enable phase
which prevents both these issues.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/arm/kernel/bios32.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 874e182..4137784 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -410,6 +410,13 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pcibios_swizzle;
+	bridge->map_irq = pcibios_map_irq;
+	return 0;
+}
+
 static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
 {
 	int ret;
@@ -506,8 +513,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	if (hw->postinit)
 		hw->postinit();
 
-	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
-
 	list_for_each_entry(sys, &head, node) {
 		struct pci_bus *bus = sys->bus;
 
-- 
2.6.2

