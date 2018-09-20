Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B91ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4634F21523
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4634F21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeITXJZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50094 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732761AbeITXJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A03A7A9;
        Thu, 20 Sep 2018 10:24:54 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 961C63F557;
        Thu, 20 Sep 2018 10:24:50 -0700 (PDT)
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
Subject: [PATCH v3 02/10] iommu/sva: Bind process address spaces to devices
Date:   Thu, 20 Sep 2018 18:00:38 +0100
Message-Id: <20180920170046.20154-3-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add bind() and unbind() operations to the IOMMU API. Bind() returns a
PASID that drivers can program in hardware, to let their devices access an
mm. This patch only adds skeletons for the device driver API, most of the
implementation is still missing.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 34 +++++++++++++++
 drivers/iommu/iommu.c     | 90 +++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h     | 37 ++++++++++++++++
 3 files changed, 161 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 85ef98efede8..d60d4f0bb89e 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -8,6 +8,38 @@
 #include <linux/iommu.h>
 #include <linux/slab.h>
 
+int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
+			    unsigned long flags, void *drvdata)
+{
+	return -ENOSYS; /* TODO */
+}
+EXPORT_SYMBOL_GPL(__iommu_sva_bind_device);
+
+int __iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	return -ENOSYS; /* TODO */
+}
+EXPORT_SYMBOL_GPL(__iommu_sva_unbind_device);
+
+static void __iommu_sva_unbind_device_all(struct device *dev)
+{
+	/* TODO */
+}
+
+/**
+ * iommu_sva_unbind_device_all() - Detach all address spaces from this device
+ * @dev: the device
+ *
+ * When detaching @dev from a domain, IOMMU drivers should use this helper.
+ */
+void iommu_sva_unbind_device_all(struct device *dev)
+{
+	mutex_lock(&dev->iommu_param->sva_lock);
+	__iommu_sva_unbind_device_all(dev);
+	mutex_unlock(&dev->iommu_param->sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
+
 /**
  * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
  * @dev: the device
@@ -96,6 +128,8 @@ void iommu_sva_shutdown_device(struct device *dev)
 	if (!param)
 		goto out_unlock;
 
+	__iommu_sva_unbind_device_all(dev);
+
 	if (domain->ops->sva_shutdown_device)
 		domain->ops->sva_shutdown_device(dev);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fa0561ed006f..aba3bf15d46c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2325,3 +2325,93 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to it
+ * @pasid: valid address where the PASID will be stored
+ * @flags: bond properties
+ * @drvdata: private data passed to the mm exit handler
+ *
+ * Create a bond between device and task, allowing the device to access the mm
+ * using the returned PASID. If unbind() isn't called first, a subsequent bind()
+ * for the same device and mm fails with -EEXIST.
+ *
+ * iommu_sva_init_device() must be called first, to initialize the required SVA
+ * features. @flags must be a subset of these features.
+ *
+ * The caller must pin down using get_user_pages*() all mappings shared with the
+ * device. mlock() isn't sufficient, as it doesn't prevent minor page faults
+ * (e.g. copy-on-write).
+ *
+ * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
+ * is returned.
+ */
+int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
+			  unsigned long flags, void *drvdata)
+{
+	int ret = -EINVAL;
+	struct iommu_group *group;
+
+	if (!pasid)
+		return -EINVAL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	/* Ensure device count and domain don't change while we're binding */
+	mutex_lock(&group->mutex);
+
+	/*
+	 * To keep things simple, SVA currently doesn't support IOMMU groups
+	 * with more than one device. Existing SVA-capable systems are not
+	 * affected by the problems that required IOMMU groups (lack of ACS
+	 * isolation, device ID aliasing and other hardware issues).
+	 */
+	if (iommu_group_device_count(group) != 1)
+		goto out_unlock;
+
+	ret = __iommu_sva_bind_device(dev, mm, pasid, flags, drvdata);
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
+
+/**
+ * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
+ * @dev: the device
+ * @pasid: the pasid returned by bind()
+ *
+ * Remove bond between device and address space identified by @pasid. Users
+ * should not call unbind() if the corresponding mm exited (as the PASID might
+ * have been reallocated for another process).
+ *
+ * The device must not be issuing any more transaction for this PASID. All
+ * outstanding page requests for this PASID must have been flushed to the IOMMU.
+ *
+ * Returns 0 on success, or an error value
+ */
+int iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	int ret = -EINVAL;
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_sva_unbind_device(dev, pasid);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4c27cb347770..9c49877e37a5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -586,6 +586,10 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+extern int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
+				int *pasid, unsigned long flags, void *drvdata);
+extern int iommu_sva_unbind_device(struct device *dev, int pasid);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -910,6 +914,18 @@ static inline int iommu_sva_invalidate(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline int iommu_sva_bind_device(struct device *dev,
+					struct mm_struct *mm, int *pasid,
+					unsigned long flags, void *drvdata)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
@@ -924,6 +940,11 @@ extern int iommu_sva_init_device(struct device *dev, unsigned long features,
 				 unsigned int min_pasid,
 				 unsigned int max_pasid);
 extern void iommu_sva_shutdown_device(struct device *dev);
+extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
+				   int *pasid, unsigned long flags,
+				   void *drvdata);
+extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
+extern void iommu_sva_unbind_device_all(struct device *dev);
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_init_device(struct device *dev,
 					unsigned long features,
@@ -936,6 +957,22 @@ static inline int iommu_sva_init_device(struct device *dev,
 static inline void iommu_sva_shutdown_device(struct device *dev)
 {
 }
+
+static inline int __iommu_sva_bind_device(struct device *dev,
+					  struct mm_struct *mm, int *pasid,
+					  unsigned long flags, void *drvdata)
+{
+	return -ENODEV;
+}
+
+static inline int __iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_sva_unbind_device_all(struct device *dev)
+{
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.18.0

