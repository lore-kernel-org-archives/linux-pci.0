Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34120 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdEUJEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 May 2017 05:04:55 -0400
From: Vincent Legoll <vincent.legoll@gmail.com>
To: hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Vincent Legoll <vincent.legoll@gmail.com>
Subject: [PATCH] PCI: fix whitespace in printk() to align log entries
Date: Sun, 21 May 2017 11:04:41 +0200
Message-Id: <1495357481-15750-1-git-send-email-vincent.legoll@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the space character between "PCI" and the colon.

This was printed before the patch:

PCI : PCI BIOS area is rw and x. Use pci=nobios if you want it NX.

Whereas other PCI printks are like that:

$ dmesg | grep 'PCI:'
[    0.649178] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.649180] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.649186] PCI: Using configuration type 1 for base access
[    0.676407] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.784009] PCI: Using ACPI for IRQ routing
[    0.795599] PCI: pci_cache_line_size set to 64 bytes
[    0.811154] PCI: CLS 0 bytes, default 64

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 arch/x86/pci/pcbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index c1bdb9e..7659540 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -46,7 +46,7 @@ static inline void set_bios_x(void)
 	pcibios_enabled = 1;
 	set_memory_x(PAGE_OFFSET + BIOS_BEGIN, (BIOS_END - BIOS_BEGIN) >> PAGE_SHIFT);
 	if (__supported_pte_mask & _PAGE_NX)
-		printk(KERN_INFO "PCI : PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
+		printk(KERN_INFO "PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
 }
 
 /*
-- 
2.7.4
