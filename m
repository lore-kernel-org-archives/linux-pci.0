Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B43C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1A21523
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF1A21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbeITXJd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:33 -0400
Received: from foss.arm.com ([217.140.101.70]:50148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733097AbeITXJd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8250E1596;
        Thu, 20 Sep 2018 10:25:02 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C17833F557;
        Thu, 20 Sep 2018 10:24:58 -0700 (PDT)
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
Subject: [PATCH v3 04/10] iommu/sva: Add a mm_exit callback for device drivers
Date:   Thu, 20 Sep 2018 18:00:40 +0100
Message-Id: <20180920170046.20154-5-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When an mm exits, devices that were bound to it must stop performing DMA
on its PASID. Let device drivers register a callback to be notified on mm
exit. Add the callback to the sva_param structure attached to struct
device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 10 +++++++++-
 include/linux/iommu.h     |  8 ++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index a486bc947335..08da479dad68 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -436,6 +436,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
  * @features: bitmask of features that need to be initialized
  * @min_pasid: min PASID value supported by the device
  * @max_pasid: max PASID value supported by the device
+ * @mm_exit: callback for process address space release
  *
  * Users of the bind()/unbind() API must call this function to initialize all
  * features required for SVA.
@@ -447,13 +448,19 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
  * overrides it. Similarly, @min_pasid overrides the lower PASID limit supported
  * by the IOMMU.
  *
+ * @mm_exit is called when an address space bound to the device is about to be
+ * torn down by exit_mmap. After @mm_exit returns, the device must not issue any
+ * more transaction with the PASID given as argument. The handler gets an opaque
+ * pointer corresponding to the drvdata passed as argument to bind().
+ *
  * The device should not be performing any DMA while this function is running,
  * otherwise the behavior is undefined.
  *
  * Return 0 if initialization succeeded, or an error.
  */
 int iommu_sva_init_device(struct device *dev, unsigned long features,
-		       unsigned int min_pasid, unsigned int max_pasid)
+			  unsigned int min_pasid, unsigned int max_pasid,
+			  iommu_mm_exit_handler_t mm_exit)
 {
 	int ret;
 	struct iommu_sva_param *param;
@@ -472,6 +479,7 @@ int iommu_sva_init_device(struct device *dev, unsigned long features,
 	param->features		= features;
 	param->min_pasid	= min_pasid;
 	param->max_pasid	= max_pasid;
+	param->mm_exit		= mm_exit;
 	INIT_LIST_HEAD(&param->mm_list);
 
 	mutex_lock(&dev->iommu_param->sva_lock);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6a3ced6a5aa1..c95ff714ea66 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -60,6 +60,7 @@ struct iommu_fault_event;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
+typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -216,6 +217,7 @@ struct iommu_sva_param {
 	unsigned int min_pasid;
 	unsigned int max_pasid;
 	struct list_head mm_list;
+	iommu_mm_exit_handler_t mm_exit;
 };
 
 /**
@@ -967,7 +969,8 @@ static inline void iommu_debugfs_setup(void) {}
 #ifdef CONFIG_IOMMU_SVA
 extern int iommu_sva_init_device(struct device *dev, unsigned long features,
 				 unsigned int min_pasid,
-				 unsigned int max_pasid);
+				 unsigned int max_pasid,
+				 iommu_mm_exit_handler_t mm_exit);
 extern void iommu_sva_shutdown_device(struct device *dev);
 extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
 				   int *pasid, unsigned long flags,
@@ -978,7 +981,8 @@ extern void iommu_sva_unbind_device_all(struct device *dev);
 static inline int iommu_sva_init_device(struct device *dev,
 					unsigned long features,
 					unsigned int min_pasid,
-					unsigned int max_pasid)
+					unsigned int max_pasid,
+					iommu_mm_exit_handler_t mm_exit)
 {
 	return -ENODEV;
 }
-- 
2.18.0

