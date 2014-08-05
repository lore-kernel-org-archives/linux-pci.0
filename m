Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35225 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102AbaHEQMK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:10 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so1205734wgh.2
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:09 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 15/22] Added (untested) support to m68k architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:16 +0100
Message-Id: <1407255083-9356-16-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/m68k/platform/coldfire/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/platform/coldfire/pci.c b/arch/m68k/platform/coldfire/pci.c
index df96792..058ca86 100644
--- a/arch/m68k/platform/coldfire/pci.c
+++ b/arch/m68k/platform/coldfire/pci.c
@@ -316,10 +316,16 @@ static int __init mcf_pci_init(void)
 	rootbus->resource[0] = &mcf_pci_io;
 	rootbus->resource[1] = &mcf_pci_mem;
 
-	pci_fixup_irqs(pci_common_swizzle, mcf_pci_map_irq);
 	pci_bus_size_bridges(rootbus);
 	pci_bus_assign_resources(rootbus);
 	return 0;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = mcf_pci_map_irq;
+	return 0;
+}
+
 subsys_initcall(mcf_pci_init);
-- 
2.0.4

