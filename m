Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:41733 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbbLGNp3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Dec 2015 08:45:29 -0500
From: Geliang Tang <geliangtang@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Geliang Tang <geliangtang@163.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: simplify pci_bios_{read,write}
Date: Mon,  7 Dec 2015 21:42:36 +0800
Message-Id: <0ed29e57b699af22a8759f1b1c0d59d79664dee5.1449495573.git.geliangtang@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are some repetitive code in the switch/case statement in
pci_bios_read() and pci_bios_write(). I drop it to simplify the
code.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 arch/x86/pci/pcbios.c | 108 ++++++++++++++++++--------------------------------
 1 file changed, 38 insertions(+), 70 deletions(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 9b83b90..9770e55 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -180,6 +180,7 @@ static int pci_bios_read(unsigned int seg, unsigned int bus,
 	unsigned long result = 0;
 	unsigned long flags;
 	unsigned long bx = (bus << 8) | devfn;
+	u16 number = 0, mask = 0;
 
 	WARN_ON(seg);
 	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
@@ -189,53 +190,35 @@ static int pci_bios_read(unsigned int seg, unsigned int bus,
 
 	switch (len) {
 	case 1:
-		__asm__("lcall *(%%esi); cld\n\t"
-			"jc 1f\n\t"
-			"xor %%ah, %%ah\n"
-			"1:"
-			: "=c" (*value),
-			  "=a" (result)
-			: "1" (PCIBIOS_READ_CONFIG_BYTE),
-			  "b" (bx),
-			  "D" ((long)reg),
-			  "S" (&pci_indirect));
-		/*
-		 * Zero-extend the result beyond 8 bits, do not trust the
-		 * BIOS having done it:
-		 */
-		*value &= 0xff;
+		number = PCIBIOS_READ_CONFIG_BYTE;
+		mask = 0xff;
 		break;
 	case 2:
-		__asm__("lcall *(%%esi); cld\n\t"
-			"jc 1f\n\t"
-			"xor %%ah, %%ah\n"
-			"1:"
-			: "=c" (*value),
-			  "=a" (result)
-			: "1" (PCIBIOS_READ_CONFIG_WORD),
-			  "b" (bx),
-			  "D" ((long)reg),
-			  "S" (&pci_indirect));
-		/*
-		 * Zero-extend the result beyond 16 bits, do not trust the
-		 * BIOS having done it:
-		 */
-		*value &= 0xffff;
+		number = PCIBIOS_READ_CONFIG_WORD;
+		mask = 0xffff;
 		break;
 	case 4:
-		__asm__("lcall *(%%esi); cld\n\t"
-			"jc 1f\n\t"
-			"xor %%ah, %%ah\n"
-			"1:"
-			: "=c" (*value),
-			  "=a" (result)
-			: "1" (PCIBIOS_READ_CONFIG_DWORD),
-			  "b" (bx),
-			  "D" ((long)reg),
-			  "S" (&pci_indirect));
+		number = PCIBIOS_READ_CONFIG_DWORD;
 		break;
 	}
 
+	__asm__("lcall *(%%esi); cld\n\t"
+		"jc 1f\n\t"
+		"xor %%ah, %%ah\n"
+		"1:"
+		: "=c" (*value),
+		  "=a" (result)
+		: "1" (number),
+		  "b" (bx),
+		  "D" ((long)reg),
+		  "S" (&pci_indirect));
+	/*
+	 * Zero-extend the result beyond 8 or 16 bits, do not trust the
+	 * BIOS having done it:
+	 */
+	if (mask)
+		*value &= mask;
+
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 
 	return (int)((result & 0xff00) >> 8);
@@ -247,6 +230,7 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
 	unsigned long result = 0;
 	unsigned long flags;
 	unsigned long bx = (bus << 8) | devfn;
+	u16 number = 0;
 
 	WARN_ON(seg);
 	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
@@ -256,43 +240,27 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
 
 	switch (len) {
 	case 1:
-		__asm__("lcall *(%%esi); cld\n\t"
-			"jc 1f\n\t"
-			"xor %%ah, %%ah\n"
-			"1:"
-			: "=a" (result)
-			: "0" (PCIBIOS_WRITE_CONFIG_BYTE),
-			  "c" (value),
-			  "b" (bx),
-			  "D" ((long)reg),
-			  "S" (&pci_indirect));
+		number = PCIBIOS_WRITE_CONFIG_BYTE;
 		break;
 	case 2:
-		__asm__("lcall *(%%esi); cld\n\t"
-			"jc 1f\n\t"
-			"xor %%ah, %%ah\n"
-			"1:"
-			: "=a" (result)
-			: "0" (PCIBIOS_WRITE_CONFIG_WORD),
-			  "c" (value),
-			  "b" (bx),
-			  "D" ((long)reg),
-			  "S" (&pci_indirect));
+		number = PCIBIOS_WRITE_CONFIG_WORD;
 		break;
 	case 4:
-		__asm__("lcall *(%%esi); cld\n\t"
-			"jc 1f\n\t"
-			"xor %%ah, %%ah\n"
-			"1:"
-			: "=a" (result)
-			: "0" (PCIBIOS_WRITE_CONFIG_DWORD),
-			  "c" (value),
-			  "b" (bx),
-			  "D" ((long)reg),
-			  "S" (&pci_indirect));
+		number = PCIBIOS_WRITE_CONFIG_DWORD;
 		break;
 	}
 
+	__asm__("lcall *(%%esi); cld\n\t"
+		"jc 1f\n\t"
+		"xor %%ah, %%ah\n"
+		"1:"
+		: "=a" (result)
+		: "0" (number),
+		  "c" (value),
+		  "b" (bx),
+		  "D" ((long)reg),
+		  "S" (&pci_indirect));
+
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 
 	return (int)((result & 0xff00) >> 8);
-- 
2.5.0


