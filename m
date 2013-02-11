Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1360623670.2950.67.camel@lorien2>
Subject: [PATCH 3/4] amd_iommu: Remove local PCI_BUS() define and use
 PCI_BUS() from pci
From: Shuah Khan <shuah.khan@hp.com>
Reply-To: shuah.khan@hp.com
To: bhelgaas@google.com, Joerg Roedel <joro@8bytes.org>
Cc: tglx@linutronix.de, mtk.manpages@gmail.com,
	iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	shemminger@vyatta.com, jiang.liu@huawei.com,
	linasvepstas@gmail.com, paulmck@linux.vnet.ibm.com,
	davej@redhat.com, dhowells@redhat.com, wangyijing@huawei.com,
	shuahkhan@gmail.com
Date: Mon, 11 Feb 2013 16:01:10 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change to remove local PCI_BUS() define and use the new PCI_BUS interface from
pci.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 drivers/iommu/amd_iommu_types.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e38ab43..a07882f 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -315,9 +316,6 @@
 
 #define MAX_DOMAIN_ID 65536
 
-/* FIXME: move this macro to <linux/pci.h> */
-#define PCI_BUS(x) (((x) >> 8) & 0xff)
-
 /* Protection domain flags */
 #define PD_DMA_OPS_MASK		(1UL << 0) /* domain used for dma_ops */
 #define PD_DEFAULT_MASK		(1UL << 1) /* domain is a default dma_ops
-- 
1.7.9.5



