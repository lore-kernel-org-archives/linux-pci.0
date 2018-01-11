Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: torvalds@linux-foundation.org, aaro.koskinen@iki.fi,
        andy.shevchenko@gmail.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, alexander.deucher@amd.com, airlied@linux.ie
Subject: [PATCH 2/2] x86/PCI: limit the size of the 64bit window to 256GB v3
Date: Thu, 11 Jan 2018 14:23:30 +0100
Message-Id: <20180111132330.2682-2-christian.koenig@amd.com>
In-Reply-To: <20180111132330.2682-1-christian.koenig@amd.com>
References: <20180111132330.2682-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Avoid problems with BIOS implementations which don't report all used
resources to the OS by only allocating a 256GB window directly below the
hardware limit.

For the full hardware documentation see:
https://support.amd.com/TechDocs/49125_15h_Models_30h-3Fh_BKDG.pdf

Fixes a silent reboot loop reported by Aaro Koskinen <aaro.koskinen@iki.fi> on
an AMD-based MSI MS-7699/760GA-P43(FX) system.

v2: cleanup code a bit more, update comment and explain the hw limit
v3: improve commit message

Link: https://lkml.kernel.org/r/20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index a91280da2ea1..9c1c98d7e3a7 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -662,10 +662,11 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
  */
 static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 {
-	unsigned i;
 	u32 base, limit, high;
-	struct resource *res, *conflict;
 	struct pci_dev *other;
+	struct resource *res;
+	unsigned i;
+	int r;
 
 	if (!(pci_probe & PCI_BIG_ROOT_WINDOW))
 		return;
@@ -702,19 +703,17 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	if (!res)
 		return;
 
+	/* Allocate a 256GB window directly below the 0xfd00000000 hw limit */
 	res->name = "PCI Bus 0000:00";
 	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
 		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
-	res->start = 0x100000000ull;
+	res->start = 0xbd00000000ull;
 	res->end = 0xfd00000000ull - 1;
 
-	/* Just grab the free area behind system memory for this */
-	while ((conflict = request_resource_conflict(&iomem_resource, res))) {
-		if (conflict->end >= res->end) {
-			kfree(res);
-			return;
-		}
-		res->start = conflict->end + 1;
+	r = request_resource(&iomem_resource, res);
+	if (r) {
+		kfree(res);
+		return;
 	}
 
 	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
-- 
2.11.0
