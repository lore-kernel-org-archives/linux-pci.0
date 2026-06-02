Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40333C192;
	Tue,  2 Jun 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411256; cv=none; b=fuWMYzHLDG+MsrwSkV+HbtozQz0yxiXfjYsk+Jg6CcgWTuDlT558P+FCo44K3uYFhUj1JaaoPyAIP1dlSBT8ce0gJajKZOw0aWcVzjqwp3is8nffS/rBAiKXibkLf62bv8i6gkwPIf8sr/FIL9avahoYCRs2pEh04aUPIC2CEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411256; c=relaxed/simple;
	bh=QM1/OgUKTbjz+lnY8a6ld5RqNlulog9kabS75oz92dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KY+BQQxP/f/rZjAYPyGGfaY4VVGdZXzBrVCLf8Q03V1aYKWSa6KvpDNzQor8Obn1ml5rgOlh63OUv7gnlcmbNMyO6889lnXdSnKi6vgoU2MjuaPy9FyQupULdDHMxL5u07pRoCGQNQ0d5+UteRTCyYOVrL8lmrUnmj2p+8qYhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HU9qHANU; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HU9qHANU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HWpTKWqfkkzTOE2CPG9lvIyqG6PNlGOunhBdTzt1r8s=;
	b=HU9qHANUsFtLyf1tkI+QEDxoQwnxnTBHVxvHtVip8yJgiy88n4iy442xAS/KHxdrXTfc4xiiX
	k+anDpDFT+HUC/R8jJ9qI4BFbd2iu6cddYxLxpZnGYme6TjyvlZSYxIFY8aow1EJUG9vuv7eYb9
	sLpRnFjk0/U6HMq0nwkdDZw=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gVCwq6prZz1prQJ;
	Tue,  2 Jun 2026 22:32:59 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E74E4201E9;
	Tue,  2 Jun 2026 22:40:51 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 22:40:51 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v15 08/10] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG for PCIe TPH ST configuration
Date: Tue, 2 Jun 2026 22:40:21 +0800
Message-ID: <20260602144023.25254-9-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260602144023.25254-1-fengchengwen@huawei.com>
References: <20260602144023.25254-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add a new VFIO device feature VFIO_DEVICE_FEATURE_TPH_ST_CONFIG to allow
userspace to configure PCIe TPH Steering Tag table entries. This interface
supports only configuration writes, read operations are not permitted.

Implement shadow ST table to cache entries, paired with per-device mutex
for concurrent access protection. Batch write failure triggers entry
rollback to guarantee hardware and shadow table consistency.

Introduce enable_unsafe_tph module parameter to gate this non-isolated TPH
feature.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c      |  13 ++-
 drivers/vfio/pci/vfio_pci_core.c | 131 ++++++++++++++++++++++++++++++-
 include/linux/vfio_pci_core.h    |   6 +-
 include/uapi/linux/vfio.h        |  20 +++++
 4 files changed, 167 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..6d73668459cf 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,12 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#ifdef CONFIG_PCIE_TPH
+static bool enable_unsafe_tph;
+module_param(enable_unsafe_tph, bool, 0444);
+MODULE_PARM_DESC(enable_unsafe_tph, "Enable PCIe TPH (Transaction Processing Hints) support. It may break platform isolation. If you do not know what this is for, step away. (default: false)");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -257,12 +263,17 @@ static int __init vfio_pci_init(void)
 {
 	int ret;
 	bool is_disable_vga = true;
+	bool is_enable_unsafe_tph = false;
 
 #ifdef CONFIG_VFIO_PCI_VGA
 	is_disable_vga = disable_vga;
 #endif
+#ifdef CONFIG_PCIE_TPH
+	is_enable_unsafe_tph = enable_unsafe_tph;
+#endif
 
-	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
+	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3,
+				 is_enable_unsafe_tph);
 
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 050e7542952e..a5c6bb92f224 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -29,6 +29,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommufd.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #if IS_ENABLED(CONFIG_EEH)
 #include <asm/eeh.h>
 #endif
@@ -41,6 +42,7 @@
 static bool nointxmask;
 static bool disable_vga;
 static bool disable_idle_d3;
+static bool enable_unsafe_tph;
 
 static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
 {
@@ -528,6 +530,46 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 			   NULL)
 };
 
+static int vfio_pci_tph_st_shadow_size(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 loc = pcie_tph_get_st_table_loc(pdev);
+	int ret;
+
+	if (loc == PCI_TPH_LOC_CAP) {
+		return pcie_tph_get_st_table_size(pdev);
+	} else if (loc == PCI_TPH_LOC_MSIX) {
+		ret = pci_msix_vec_count(pdev);
+		if (ret < 0)
+			return 0;
+		return ret;
+	} else {
+		return 0;
+	}
+}
+
+static int vfio_pci_tph_init(struct vfio_pci_core_device *vdev)
+{
+	vdev->tph_st_entries = vfio_pci_tph_st_shadow_size(vdev);
+	vdev->tph_st_shadow = NULL;
+
+	if (enable_unsafe_tph && vdev->tph_st_entries) {
+		vdev->tph_st_shadow = kcalloc(vdev->tph_st_entries, sizeof(u16),
+					      GFP_KERNEL);
+		if (!vdev->tph_st_shadow)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void vfio_pci_tph_deinit(struct vfio_pci_core_device *vdev)
+{
+	kfree(vdev->tph_st_shadow);
+	vdev->tph_st_shadow = NULL;
+	vdev->tph_st_entries = 0;
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -582,6 +624,10 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_free_zdev;
 
+	ret = vfio_pci_tph_init(vdev);
+	if (ret)
+		goto out_free_config;
+
 	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
 		u16 flags;
@@ -606,6 +652,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	return 0;
 
+out_free_config:
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -679,6 +727,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	kfree(vdev->region);
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
+	vfio_pci_tph_deinit(vdev);
 	vfio_config_free(vdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
@@ -1551,6 +1600,79 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_core_feature_tph_st_config(
+			struct vfio_pci_core_device *vdev,
+			u32 flags,
+			struct vfio_device_feature_tph_st_config __user *arg,
+			size_t argsz)
+{
+	struct vfio_device_feature_tph_st_config config;
+	struct pci_dev *pdev = vdev->pdev;
+	void __user *uptr;
+	int i, idx, ret;
+	size_t sz;
+	u16 *sts;
+
+	if (!enable_unsafe_tph || !vdev->tph_st_shadow)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(config));
+	if (ret <= 0)
+		return ret;
+
+	if (copy_from_user(&config, arg, sizeof(config)))
+		return -EFAULT;
+
+	if (config.count == 0 || config.reserved != 0 ||
+		config.index >= vdev->tph_st_entries ||
+		config.count > vdev->tph_st_entries - config.index)
+		return -EINVAL;
+
+	uptr = u64_to_user_ptr(config.data_uptr);
+	sts = memdup_array_user(uptr, config.count, sizeof(u16));
+	sz = config.count * sizeof(u16);
+	if (IS_ERR(sts))
+		return PTR_ERR(sts);
+
+	down_write(&vdev->memory_lock);
+	ret = vfio_pci_set_power_state(vdev, PCI_D0);
+	if (ret)
+		goto out_unlock_memory;
+
+	mutex_lock(&vdev->tph_lock);
+
+	if (pcie_tph_enabled_req_type(pdev) == PCI_TPH_REQ_DISABLE)
+		goto update_shadow;
+
+	for (i = 0; i < config.count; i++) {
+		idx = config.index + i;
+		ret = pcie_tph_set_st_entry(pdev, idx, sts[i]);
+		if (ret)
+			goto rollback;
+	}
+
+update_shadow:
+	memcpy(&vdev->tph_st_shadow[config.index], sts, sz);
+	ret = 0;
+	goto out_unlock_tph;
+
+rollback:
+	while (i-- > 0) {
+		idx = config.index + i;
+		pcie_tph_set_st_entry(pdev, idx, vdev->tph_st_shadow[idx]);
+	}
+
+out_unlock_tph:
+	mutex_unlock(&vdev->tph_lock);
+
+out_unlock_memory:
+	up_write(&vdev->memory_lock);
+
+	kfree(sts);
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1569,6 +1691,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_ST_CONFIG:
+		return vfio_pci_core_feature_tph_st_config(vdev, flags,
+							   arg, argsz);
 	default:
 		return -ENOTTY;
 	}
@@ -2132,6 +2257,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	mutex_init(&vdev->igate);
 	spin_lock_init(&vdev->irqlock);
 	mutex_init(&vdev->ioeventfds_lock);
+	mutex_init(&vdev->tph_lock);
 	INIT_LIST_HEAD(&vdev->dummy_resources_list);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
 	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
@@ -2153,6 +2279,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
+	mutex_destroy(&vdev->tph_lock);
 	kfree(vdev->region);
 	kfree(vdev->pm_save);
 }
@@ -2605,11 +2732,13 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 }
 
 void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3)
+			      bool is_disable_idle_d3,
+			      bool is_enable_unsafe_tph)
 {
 	nointxmask = is_nointxmask;
 	disable_vga = is_disable_vga;
 	disable_idle_d3 = is_disable_idle_d3;
+	enable_unsafe_tph = is_enable_unsafe_tph;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 89165b769e5c..ae8e7011ab8e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -142,6 +142,9 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct mutex		tph_lock;
+	u16			*tph_st_shadow;
+	u16			tph_st_entries;
 };
 
 enum vfio_pci_io_width {
@@ -157,7 +160,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
 void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3);
+			      bool is_disable_idle_d3,
+			      bool is_enable_unsafe_tph);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..07d8cce6ef32 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_TPH_ST_CONFIG - Configure PCIe TPH Steering Tag entries
+ *
+ * Provides userspace interface to configure PCIe TPH ST table entries.
+ *
+ * @index: Start entry offset within ST table
+ * @count: Number of consecutive entries to configure
+ * @data_uptr: Userspace data buffer for 16-bit raw ST values
+ *
+ * This feature is gated by enable_unsafe_tph module parameter.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_ST_CONFIG	13
+
+struct vfio_device_feature_tph_st_config {
+	__u16 index;
+	__u16 count;
+	__u32 reserved; /* Reserved for future use, must be zero */
+	__aligned_u64 data_uptr;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

