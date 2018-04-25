Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16966 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeDYKPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Apr 2018 06:15:13 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] x86/PCI: Make pci=earlydump output neat
Date: Wed, 25 Apr 2018 13:15:07 +0300
Message-Id: <20180425101507.51531-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently the early dump of PCI configuration space looks quite unhelpful, e.g.

[    0.000000]   60:
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]  00
[    0.000000]

which makes really hard to get anything out of this. Convert the function to
use print_hex_dump() to make output neat.

In the result we will have

[    0.000000] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

which is much, much better.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- add Mika's tag
- address style issue
 arch/x86/pci/early.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
index f0114007e915..e5f753cbb1c3 100644
--- a/arch/x86/pci/early.c
+++ b/arch/x86/pci/early.c
@@ -59,24 +59,15 @@ int early_pci_allowed(void)
 
 void early_dump_pci_device(u8 bus, u8 slot, u8 func)
 {
+	u32 value[256 / 4];
 	int i;
-	int j;
-	u32 val;
 
-	printk(KERN_INFO "pci 0000:%02x:%02x.%d config space:",
-	       bus, slot, func);
+	pr_info("pci 0000:%02x:%02x.%d config space:\n", bus, slot, func);
 
-	for (i = 0; i < 256; i += 4) {
-		if (!(i & 0x0f))
-			printk("\n  %02x:",i);
+	for (i = 0; i < 256; i += 4)
+		value[i / 4] = read_pci_config(bus, slot, func, i);
 
-		val = read_pci_config(bus, slot, func, i);
-		for (j = 0; j < 4; j++) {
-			printk(" %02x", val & 0xff);
-			val >>= 8;
-		}
-	}
-	printk("\n");
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value, 256, false);
 }
 
 void early_dump_pci_devices(void)
-- 
2.17.0
