Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36277 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbJWFGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:06 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 24/29] unicore32/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:57 +0100
Message-Id: <1445576642-29624-25-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI IRQs are currently assigned during pci_common_init, this is only run
at boot time so devices hot-plugged after boot will not be allocated an IRQ.
this is fixed here by defering the assignment untill the device enable code,
instead registering the function pointer at boot time.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/unicore32/kernel/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index d45fa5f..42295b2 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -101,7 +101,7 @@ void pci_puv3_preinit(void)
 	writel(readl(PCIBRI_CMD) | PCIBRI_CMD_IO | PCIBRI_CMD_MEM, PCIBRI_CMD);
 }
 
-static int __init pci_puv3_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int pci_puv3_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (dev->bus->number == 0) {
 #ifdef CONFIG_ARCH_FPGA /* 4 pci slots */
@@ -263,8 +263,6 @@ static int __init pci_common_init(void)
 	if (!puv3_bus)
 		panic("PCI: unable to scan bus!");
 
-	pci_fixup_irqs(pci_common_swizzle, pci_puv3_map_irq);
-
 	if (!pci_has_flag(PCI_PROBE_ONLY)) {
 		pci_bus_size_bridges(puv3_bus);
 		pci_bus_assign_resources(puv3_bus);
@@ -274,6 +272,13 @@ static int __init pci_common_init(void)
 }
 subsys_initcall(pci_common_init);
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = pci_puv3_map_irq;
+	return 0;
+}
+
 char * __init pcibios_setup(char *str)
 {
 	if (!strcmp(str, "debug")) {
-- 
2.6.2

