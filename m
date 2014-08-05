Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:34568 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbaHEQMD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:03 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so1287043wes.20
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:01 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 04/22] Added support to ARM architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:05 +0100
Message-Id: <1407255083-9356-5-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

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
2.0.4

