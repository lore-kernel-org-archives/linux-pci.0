Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/PCI: fix infinity loop in search for 64bit BAR placement
Date: Wed, 29 Nov 2017 15:12:27 +0100
Message-Id: <20171129141229.6107-2-christian.koenig@amd.com>
In-Reply-To: <20171129141229.6107-1-christian.koenig@amd.com>
References: <20171129141229.6107-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Break the loop if we can't find some address space for a 64bit BAR.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e59378bf37d9..e857b3ac5755 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -695,8 +695,13 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	res->end = 0xfd00000000ull - 1;
 
 	/* Just grab the free area behind system memory for this */
-	while ((conflict = request_resource_conflict(&iomem_resource, res)))
+	while ((conflict = request_resource_conflict(&iomem_resource, res))) {
+		if (conflict->end >= res->end) {
+			kfree(res);
+			return;
+		}
 		res->start = conflict->end + 1;
+	}
 
 	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
 
-- 
2.11.0
