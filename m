Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:62534 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053AbaHEQMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:13 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so1661473wib.4
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:12 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 20/22] Added (untested) support to alpha nautilus boards to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:21 +0100
Message-Id: <1407255083-9356-21-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/alpha/kernel/sys_nautilus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 837c0fa..7fb4d51 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -252,7 +252,6 @@ nautilus_init_pci(void)
 	/* pci_common_swizzle() relies on bus->self being NULL
 	   for the root bus, so just clear it. */
 	bus->self = NULL;
-	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 }
 
 /*
-- 
2.0.4

