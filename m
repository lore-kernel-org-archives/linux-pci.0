Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbdEST4C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 May 2017 15:56:02 -0400
Subject: [PATCH v1 1/2] MIPS: Loongson: Remove unused PCI_BAR_COUNT
 definition
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-mips@linux-mips.org, Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 19 May 2017 14:55:59 -0500
Message-ID: <20170519195559.25338.30891.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove unused PCI_BAR_COUNT definition.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../asm/mach-loongson64/cs5536/cs5536_pci.h        |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
index 8a7ecb4d5c64..bf9dd9eb4ceb 100644
--- a/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
+++ b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
@@ -80,7 +80,6 @@ extern u32 cs5536_pci_conf_read4(int function, int reg);
 #define PCI_BAR3_REG			0x1c
 #define PCI_BAR4_REG			0x20
 #define PCI_BAR5_REG			0x24
-#define PCI_BAR_COUNT			6
 #define PCI_BAR_RANGE_MASK		0xFFFFFFFF
 
 /* CARDBUS CIS POINTER */
