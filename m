Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33836 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804AbaHEQME (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:04 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so1205596wgh.2
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:02 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 06/22] Added (untested) support to mips architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:07 +0100
Message-Id: <1407255083-9356-7-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/mips/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 1bf60b1..dc660a0 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -242,13 +242,18 @@ static int __init pcibios_init(void)
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
 
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
-
 	pci_initialized = 1;
 
 	return 0;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+       bridge->swizzle_irq = pci_common_swizzle;
+       bridge->map_irq = pcibios_map_irq;
+       return 0;
+}
+
 subsys_initcall(pcibios_init);
 
 static int pcibios_enable_resources(struct pci_dev *dev, int mask)
-- 
2.0.4

