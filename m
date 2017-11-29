Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/PCI: limit the size of the 64bit BAR to 256GB
Date: Wed, 29 Nov 2017 15:12:29 +0100
Message-Id: <20171129141229.6107-4-christian.koenig@amd.com>
In-Reply-To: <20171129141229.6107-1-christian.koenig@amd.com>
References: <20171129141229.6107-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

This avoids problems with Xen which hides some memory resources from the
OS and potentially also allows memory hotplug while this fixup is
enabled.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index c817ab85dc82..149adbc7f2a3 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -701,7 +701,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	res->name = "PCI Bus 0000:00";
 	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
 		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
-	res->start = 0x100000000ull;
+	res->start = 0xbd00000000ull;
 	res->end = 0xfd00000000ull - 1;
 
 	/* Just grab the free area behind system memory for this */
-- 
2.11.0
