Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45172 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753682AbeBLSbQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 13:31:16 -0500
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 04/37] iommu/sva: Add a mm_exit callback for device drivers
Date: Mon, 12 Feb 2018 18:33:19 +0000
Message-Id: <20180212183352.22730-5-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When an mm exits, devices that were bound to it must stop performing DMA
on its PASID. Let device drivers register a callback to be notified on mm
exit. Add the callback to the iommu_param structure attached to struct
device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h     | 18 ++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index f9af9d66b3ed..90b524c99d3d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -569,3 +569,57 @@ void __iommu_sva_unbind_dev_all(struct device *dev)
 	spin_unlock(&iommu_sva_lock);
 }
 EXPORT_SYMBOL_GPL(__iommu_sva_unbind_dev_all);
+
+/**
+ * iommu_register_mm_exit_handler() - Set a callback for mm exit
+ * @dev: the device
+ * @handler: exit handler
+ *
+ * Users of the bind/unbind API should call this function to set a
+ * device-specific callback telling them when a mm is exiting.
+ *
+ * After the callback returns, the device must not issue any more transaction
+ * with the PASID given as argument to the handler. In addition the handler gets
+ * an opaque pointer corresponding to the drvdata passed as argument of bind().
+ *
+ * The handler itself should return 0 on success, and an appropriate error code
+ * otherwise.
+ */
+int iommu_register_mm_exit_handler(struct device *dev,
+				   iommu_mm_exit_handler_t handler)
+{
+	struct iommu_param *dev_param = dev->iommu_param;
+
+	if (!dev_param)
+		return -EINVAL;
+
+	/*
+	 * FIXME: racy. Same as iommu_sva_device_init, but here we'll need a
+	 * spinlock to call the mm_exit param from atomic context.
+	 */
+	if (dev_param->mm_exit)
+		return -EBUSY;
+
+	get_device(dev);
+	dev_param->mm_exit = handler;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_register_mm_exit_handler);
+
+/**
+ * iommu_unregister_mm_exit_handler() - Remove mm exit callback
+ */
+int iommu_unregister_mm_exit_handler(struct device *dev)
+{
+	struct iommu_param *dev_param = dev->iommu_param;
+
+	if (!dev_param || !dev_param->mm_exit)
+		return -EINVAL;
+
+	dev_param->mm_exit = NULL;
+	put_device(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_unregister_mm_exit_handler);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 09d85f44142a..1b1a16892ac1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -65,6 +65,8 @@ typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
 /* Request I/O page fault support */
 #define IOMMU_SVA_FEAT_IOPF		(1 << 1)
 
+typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
@@ -424,6 +426,7 @@ struct iommu_param {
 	unsigned int min_pasid;
 	unsigned int max_pasid;
 	struct list_head mm_list;
+	iommu_mm_exit_handler_t mm_exit;
 };
 
 int  iommu_device_register(struct iommu_device *iommu);
@@ -941,6 +944,10 @@ extern int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
 				int *pasid, unsigned long flags, void *drvdata);
 extern int iommu_sva_unbind_device(struct device *dev, int pasid);
 extern void __iommu_sva_unbind_dev_all(struct device *dev);
+extern int iommu_register_mm_exit_handler(struct device *dev,
+					  iommu_mm_exit_handler_t handler);
+extern int iommu_unregister_mm_exit_handler(struct device *dev);
+
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_device_init(struct device *dev,
 					unsigned long features,
@@ -969,6 +976,17 @@ static inline int iommu_sva_unbind_device(struct device *dev, int pasid)
 static inline void __iommu_sva_unbind_dev_all(struct device *dev)
 {
 }
+
+static inline int iommu_register_mm_exit_handler(struct device *dev,
+						 iommu_mm_exit_handler_t handler)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_unregister_mm_exit_handler(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.15.1
