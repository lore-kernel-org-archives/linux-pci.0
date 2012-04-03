Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <len.brown@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [RFC PATCH 07/14] IOMMU: Don't clean handler data before free_irq()
Date: Mon,  2 Apr 2012 19:19:34 -0700
Message-Id: <1333419581-7836-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1333419581-7836-1-git-send-email-yinghai@kernel.org>
References: <1333419581-7836-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

need that in __free_irq.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/iommu/intel-iommu.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b7e5a7e..4116944 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1308,7 +1308,6 @@ void free_dmar_iommu(struct intel_iommu *iommu)
 		iommu_disable_translation(iommu);
 
 	if (iommu->irq) {
-		irq_set_handler_data(iommu->irq, NULL);
 		/* This will mask the irq */
 		free_irq(iommu->irq, iommu);
 		destroy_irq(iommu->irq);
-- 
1.7.7

