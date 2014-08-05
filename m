Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33309 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbaHEQMM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:12 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so1661423wib.4
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:11 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 18/22] Added (untested) support to unicore32 architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:19 +0100
Message-Id: <1407255083-9356-19-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

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
2.0.4

