Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:43386 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaHEQMO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:14 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so1302945wev.12
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:13 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 21/22] Fixes so non PCI x86 systems should work
Date: Tue,  5 Aug 2014 17:11:22 +0100
Message-Id: <1407255083-9356-22-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/x86/include/asm/pci_x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 436b9e5..16fd8e9 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -205,5 +205,5 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 #else
 # define x86_default_pci_init		NULL
 # define x86_default_pci_init_irq	NULL
-# define x86_default_pci_fixup_irqs	NULL
+# define x86_default_pci_fixup_irq	NULL
 #endif
-- 
2.0.4

