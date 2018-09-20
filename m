Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E25DECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CE121523
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CE121523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeITXJl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:41 -0400
Received: from foss.arm.com ([217.140.101.70]:50214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeITXJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FE1B15AD;
        Thu, 20 Sep 2018 10:25:10 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B66D13F557;
        Thu, 20 Sep 2018 10:25:06 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, linux-pci@vger.kernel.org, jcrouse@codeaurora.org,
        alex.williamson@redhat.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        eric.auger@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        andrew.murray@arm.com, will.deacon@arm.com, robin.murphy@arm.com,
        ashok.raj@intel.com, baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
Subject: [PATCH v3 06/10] iommu/sva: Search mm by PASID
Date:   Thu, 20 Sep 2018 18:00:42 +0100
Message-Id: <20180920170046.20154-7-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The fault handler will need to find an mm given its PASID. This is the
reason we have an IDR for storing address spaces, so hook it up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 26 ++++++++++++++++++++++++++
 include/linux/iommu.h     |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 5ff8967cb213..ee86f00ee1b9 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -636,6 +636,32 @@ void iommu_sva_unbind_device_all(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
 
+/**
+ * iommu_sva_find() - Find mm associated to the given PASID
+ * @pasid: Process Address Space ID assigned to the mm
+ *
+ * Returns the mm corresponding to this PASID, or NULL if not found. A reference
+ * to the mm is taken, and must be released with mmput().
+ */
+struct mm_struct *iommu_sva_find(int pasid)
+{
+	struct io_mm *io_mm;
+	struct mm_struct *mm = NULL;
+
+	spin_lock(&iommu_sva_lock);
+	io_mm = idr_find(&iommu_pasid_idr, pasid);
+	if (io_mm && io_mm_get_locked(io_mm)) {
+		if (mmget_not_zero(io_mm->mm))
+			mm = io_mm->mm;
+
+		io_mm_put_locked(io_mm);
+	}
+	spin_unlock(&iommu_sva_lock);
+
+	return mm;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_find);
+
 /**
  * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
  * @dev: the device
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 429f3dc37a35..a457650b80de 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -987,6 +987,8 @@ extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
 				   void *drvdata);
 extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
 extern void iommu_sva_unbind_device_all(struct device *dev);
+extern struct mm_struct *iommu_sva_find(int pasid);
+
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_init_device(struct device *dev,
 					unsigned long features,
@@ -1016,6 +1018,11 @@ static inline int __iommu_sva_unbind_device(struct device *dev, int pasid)
 static inline void iommu_sva_unbind_device_all(struct device *dev)
 {
 }
+
+static inline struct mm_struct *iommu_sva_find(int pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.18.0

