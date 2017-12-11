Return-Path: <SRS0=Up20=DH=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=Up20=DH=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: limit the size of the 64bit BAR to 256GB
Date: Mon, 11 Dec 2017 16:04:52 +0100
Message-Id: <20171211150452.23518-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Xen hides a bit of system memory from the OS for its own purpose by
intercepting e820. This memory is unfortunately not reported as
reserved, but rather completely invisible.

Avoid this address space collision and possible similar problems by
limiting the size of the newly allocated root hub window to 256GB which
should be sufficient for the short term.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 8f86060f5cf6..ed8bc6ab0573 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -702,7 +702,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	res->name = "PCI Bus 0000:00";
 	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
 		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
-	res->start = 0x100000000ull;
+	res->start = 0xbd00000000ull;
 	res->end = 0xfd00000000ull - 1;
 
 	/* Just grab the free area behind system memory for this */
-- 
2.11.0
