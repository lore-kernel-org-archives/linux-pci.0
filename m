Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:21798 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab2DCCVG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2012 22:21:06 -0400
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
Subject: [RFC PATCH 10/14] IOMMU: Separate free_dmar_iommu from free_iommu
Date: Mon,  2 Apr 2012 19:19:37 -0700
Message-Id: <1333419581-7836-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1333419581-7836-1-git-send-email-yinghai@kernel.org>
References: <1333419581-7836-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We will need separate two calling later for iommu_remove.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/iommu/dmar.c        |    2 --
 drivers/iommu/intel-iommu.c |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 043192e..ea9d210 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -810,8 +810,6 @@ void free_iommu(struct intel_iommu *iommu)
 	if (!iommu)
 		return;
 
-	free_dmar_iommu(iommu);
-
 	if (iommu->reg)
 		iounmap(iommu->reg);
 	__clear_bit(iommu->seq_id, iommu_allocated);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4116944..662932f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2613,6 +2613,7 @@ error:
 		if (drhd->ignored)
 			continue;
 		iommu = drhd->iommu;
+		free_dmar_iommu(iommu);
 		free_iommu(iommu);
 	}
 	kfree(g_iommus);
-- 
1.7.7

