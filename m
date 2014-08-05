Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:56222 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbaHEQMJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:09 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so1253819wes.32
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:06 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 12/22] Added (untested) workaround to parisc architecture to accomodate new irq init code. Unfortunately adding runtime irq assignment will not work but avoided breaking the existing code.
Date: Tue,  5 Aug 2014 17:11:13 +0100
Message-Id: <1407255083-9356-13-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/parisc/kernel/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 64f2764..9654c69 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -105,7 +105,13 @@ PCI_PORT_OUT(b,  8)
 PCI_PORT_OUT(w, 16)
 PCI_PORT_OUT(l, 32)
 
-
+/* We do not support hot-add irq assignment */
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = NULL;
+	return 0;
+}
 
 /*
  * BIOS32 replacement.
-- 
2.0.4

