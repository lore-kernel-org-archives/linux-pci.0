Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56324 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbaJBD7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:25 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 15/18] Delayed unicore32 setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 04:50:34 +0100
Message-Id: <1412221837-17452-16-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

PCI IRQs are currently assigned during pci_common_init, this is only run
at boot time so devices hot-plugged after boot will not be allocated an IRQ.
this is fixed here by defering the assignment untill the device enable code,
instead registering the function pointer at boot time.

---
 arch/unicore32/kernel/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index 374a055..6a9da80 100644
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
 		/*
 		 * Size the bridge windows.
@@ -281,6 +279,13 @@ static int __init pci_common_init(void)
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
2.1.0

