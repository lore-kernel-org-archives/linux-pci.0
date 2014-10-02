Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56320 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbaJBD7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:23 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Vality <matt@masarand.com>
Subject: [PATCH 03/18] Delayed arm setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 04:50:22 +0100
Message-Id: <1412221837-17452-4-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vality <matt@masarand.com>

Currently PCI device IRQs under arm are initialised during the
pci_common_init_dev code path, this results in an extra sweep of the
PCI bus as well as causing PCI devices hot-plugged after boot to not
receive an IRQ.

This patch set defers this assignment untill the device enable phase
which prevents both these issues.

---
 arch/arm/kernel/bios32.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..4dcf3f7 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -389,7 +389,7 @@ void pcibios_remove_bus(struct pci_bus *bus)
  * PCI standard swizzle is implemented on plug-in cards and Cardbus based
  * PCI extenders, so it can not be ignored.
  */
-static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
+u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
 {
 	struct pci_sys_data *sys = dev->sysdata;
 	int slot, oldpin = *pin;
@@ -409,7 +409,7 @@ static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
 /*
  * Map a slot/pin to an IRQ.
  */
-static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_sys_data *sys = dev->sysdata;
 	int irq = -1;
@@ -424,6 +424,13 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
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
@@ -523,8 +530,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	if (hw->postinit)
 		hw->postinit();
 
-	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
-
 	list_for_each_entry(sys, &head, node) {
 		struct pci_bus *bus = sys->bus;
 
-- 
2.1.0

