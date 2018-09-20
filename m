Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD6AC433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526C921531
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526C921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbeITXJV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732761AbeITXJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54CAA1596;
        Thu, 20 Sep 2018 10:24:50 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90E863F557;
        Thu, 20 Sep 2018 10:24:46 -0700 (PDT)
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
Subject: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
Date:   Thu, 20 Sep 2018 18:00:37 +0100
Message-Id: <20180920170046.20154-2-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Shared Virtual Addressing (SVA) provides a way for device drivers to bind
process address spaces to devices. This requires the IOMMU to support page
table format and features compatible with the CPUs, and usually requires
the system to support I/O Page Faults (IOPF) and Process Address Space ID
(PASID). When all of these are available, DMA can access virtual addresses
of a process. A PASID is allocated for each process, and the device driver
programs it into the device in an implementation-specific way.

Add a new API for sharing process page tables with devices. Introduce two
IOMMU operations, sva_init_device() and sva_shutdown_device(), that
prepare the IOMMU driver for SVA. For example allocate PASID tables and
fault queues. Subsequent patches will implement the bind() and unbind()
operations.

Introduce a new mutex sva_lock on the device's IOMMU param to serialize
init(), shutdown(), bind() and unbind() operations. Using the existing
lock isn't possible because the unbind() and shutdown() operations will
have to wait while holding sva_lock for concurrent fault queue flushes to
terminate. These flushes will take the existing lock.

Support for I/O Page Faults will be added in a later patch using a new
feature bit (IOMMU_SVA_FEAT_IOPF). With the current API users must pin
down all shared mappings.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
v2->v3:
* Add sva_lock to serialize init/bind/unbind/shutdown
* Rename functions for consistency with the rest of the API
---
 drivers/iommu/Kconfig     |   4 ++
 drivers/iommu/Makefile    |   1 +
 drivers/iommu/iommu-sva.c | 107 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c     |   1 +
 include/linux/iommu.h     |  34 ++++++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 drivers/iommu/iommu-sva.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c60395b7470f..884580401919 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -95,6 +95,10 @@ config IOMMU_DMA
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
 
+config IOMMU_SVA
+	bool
+	select IOMMU_API
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ab5eba6edf82..7d6332be5f0e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
new file mode 100644
index 000000000000..85ef98efede8
--- /dev/null
+++ b/drivers/iommu/iommu-sva.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Manage PASIDs and bind process address spaces to devices.
+ *
+ * Copyright (C) 2018 ARM Ltd.
+ */
+
+#include <linux/iommu.h>
+#include <linux/slab.h>
+
+/**
+ * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
+ * @dev: the device
+ * @features: bitmask of features that need to be initialized
+ * @min_pasid: min PASID value supported by the device
+ * @max_pasid: max PASID value supported by the device
+ *
+ * Users of the bind()/unbind() API must call this function to initialize all
+ * features required for SVA.
+ *
+ * The device must support multiple address spaces (e.g. PCI PASID). By default
+ * the PASID allocated during bind() is limited by the IOMMU capacity, and by
+ * the device PASID width defined in the PCI capability or in the firmware
+ * description. Setting @max_pasid to a non-zero value smaller than this limit
+ * overrides it. Similarly, @min_pasid overrides the lower PASID limit supported
+ * by the IOMMU.
+ *
+ * The device should not be performing any DMA while this function is running,
+ * otherwise the behavior is undefined.
+ *
+ * Return 0 if initialization succeeded, or an error.
+ */
+int iommu_sva_init_device(struct device *dev, unsigned long features,
+		       unsigned int min_pasid, unsigned int max_pasid)
+{
+	int ret;
+	struct iommu_sva_param *param;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain || !domain->ops->sva_init_device)
+		return -ENODEV;
+
+	if (features)
+		return -EINVAL;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	param->features		= features;
+	param->min_pasid	= min_pasid;
+	param->max_pasid	= max_pasid;
+
+	mutex_lock(&dev->iommu_param->sva_lock);
+	if (dev->iommu_param->sva_param) {
+		ret = -EEXIST;
+		goto err_unlock;
+	}
+
+	/*
+	 * IOMMU driver updates the limits depending on the IOMMU and device
+	 * capabilities.
+	 */
+	ret = domain->ops->sva_init_device(dev, param);
+	if (ret)
+		goto err_unlock;
+
+	dev->iommu_param->sva_param = param;
+	mutex_unlock(&dev->iommu_param->sva_lock);
+	return 0;
+
+err_unlock:
+	mutex_unlock(&dev->iommu_param->sva_lock);
+	kfree(param);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_init_device);
+
+/**
+ * iommu_sva_shutdown_device() - Shutdown Shared Virtual Addressing for a device
+ * @dev: the device
+ *
+ * Disable SVA. Device driver should ensure that the device isn't performing any
+ * DMA while this function is running.
+ */
+void iommu_sva_shutdown_device(struct device *dev)
+{
+	struct iommu_sva_param *param;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain)
+		return;
+
+	mutex_lock(&dev->iommu_param->sva_lock);
+	param = dev->iommu_param->sva_param;
+	if (!param)
+		goto out_unlock;
+
+	if (domain->ops->sva_shutdown_device)
+		domain->ops->sva_shutdown_device(dev);
+
+	kfree(param);
+	dev->iommu_param->sva_param = NULL;
+out_unlock:
+	mutex_unlock(&dev->iommu_param->sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_shutdown_device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 58f3477f2993..fa0561ed006f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -653,6 +653,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 	mutex_init(&dev->iommu_param->lock);
+	mutex_init(&dev->iommu_param->sva_lock);
 
 	kobject_get(group->devices_kobj);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8177f7736fcd..4c27cb347770 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -197,6 +197,12 @@ struct page_response_msg {
 	u64 private_data;
 };
 
+struct iommu_sva_param {
+	unsigned long features;
+	unsigned int min_pasid;
+	unsigned int max_pasid;
+};
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -204,6 +210,8 @@ struct page_response_msg {
  * @domain_free: free iommu domain
  * @attach_dev: attach device to an iommu domain
  * @detach_dev: detach device from an iommu domain
+ * @sva_init_device: initialize Shared Virtual Addressing for a device
+ * @sva_shutdown_device: shutdown Shared Virtual Addressing for a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
@@ -239,6 +247,8 @@ struct iommu_ops {
 
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*sva_init_device)(struct device *dev, struct iommu_sva_param *param);
+	void (*sva_shutdown_device)(struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
@@ -393,6 +403,9 @@ struct iommu_fault_param {
  * struct iommu_param - collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
+ * @lock: serializes accesses to fault_param
+ * @sva_param: SVA parameters
+ * @sva_lock: serializes accesses to sva_param
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -401,6 +414,8 @@ struct iommu_fault_param {
 struct iommu_param {
 	struct mutex lock;
 	struct iommu_fault_param *fault_param;
+	struct mutex sva_lock;
+	struct iommu_sva_param *sva_param;
 };
 
 int  iommu_device_register(struct iommu_device *iommu);
@@ -904,4 +919,23 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+extern int iommu_sva_init_device(struct device *dev, unsigned long features,
+				 unsigned int min_pasid,
+				 unsigned int max_pasid);
+extern void iommu_sva_shutdown_device(struct device *dev);
+#else /* CONFIG_IOMMU_SVA */
+static inline int iommu_sva_init_device(struct device *dev,
+					unsigned long features,
+					unsigned int min_pasid,
+					unsigned int max_pasid)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_sva_shutdown_device(struct device *dev)
+{
+}
+#endif /* CONFIG_IOMMU_SVA */
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.18.0

