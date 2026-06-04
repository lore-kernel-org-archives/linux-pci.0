Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B255481ABD;
	Thu,  4 Jun 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579705; cv=none; b=I+mWaviHlpk20rpSDvTzwk7iXQeLTl6jsXZ8adwfhqBUFfsPjY0aYmfkeA9LJKQ4zZrGdjP9Nglr8WSYTpimTS26Ry/R4vTEQbeHwzdd0EWwOgbl/x7Cat6O151hDYXNi5jvdFtss2x6CGu1p9zmFflObalu89R78VlnJjFvf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579705; c=relaxed/simple;
	bh=7VMLP7Ky8coJWuNa0XloE9CsY16ZowmSKPxur3uUTNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex/eLgCS0a7qlk4XMlbKblTBNU2zzZ141IXlqBo0vTm9JuEp+Q6qAqi0+nI0Lo7t8uzkqZwn+1qVohhqazVY507W3I5cMWgkNjeL7Xn5ridB/JjgLt4wO8CYWdZA4bx2DKmWTxenVEu5kBsqLCs/2Q+7LNh59oHhsb+o7t4SvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=phhezJJm; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="phhezJJm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QHNkxzJriMX4tQmawtKpjg+Ru8IHnjtpeoe8FCw9TBE=;
	b=phhezJJmMkPq2ZMsH/fb3R2SShD7yG18ROs1ssesPhYWaFe+egu7X5prRbonQaMWlsa6UCjb3
	Gr2OtNac6DTHUL4Gt2ev9EGJhf/iXantoMR22PRnHe2YEB1OdZ+DX/LyxYWveZ1aF9rmwNByznL
	zH0UJyAoal9rFQf0rXGxuI0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gWQD95ZSZz1K96h;
	Thu,  4 Jun 2026 21:20:25 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 249A140565;
	Thu,  4 Jun 2026 21:28:15 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 21:28:14 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v16 11/12] vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration
Date: Thu, 4 Jun 2026 21:28:03 +0800
Message-ID: <20260604132804.28678-12-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260604132804.28678-1-fengchengwen@huawei.com>
References: <20260604132804.28678-1-fengchengwen@huawei.com>
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

The feature is double gated:
1. Global enable_unsafe_tph module parameter must be enabled;
2. Userspace needs to firstly SET VFIO_DEVICE_FEATURE_TPH_ENABLE
   to set per-device tph_permit flag before using TPH_CPU_CONFIG.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 129 +++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |   3 +
 include/uapi/linux/vfio.h        |  22 ++++++
 3 files changed, 154 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 91c0737727f2..0851fdf0daac 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -530,6 +530,50 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
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
+	vdev->tph_st_entries = 0;
+	vdev->tph_st_shadow = NULL;
+
+	if (!enable_unsafe_tph)
+		return 0;
+
+	vdev->tph_st_entries = vfio_pci_tph_st_shadow_size(vdev);
+	if (vdev->tph_st_entries) {
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
@@ -556,6 +600,11 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_disable_device;
 
 	vdev->reset_works = !ret;
+
+	ret = vfio_pci_tph_init(vdev);
+	if (ret)
+		goto out_disable_device;
+
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -613,6 +662,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 out_free_state:
 	kfree(vdev->pci_saved_state);
 	vdev->pci_saved_state = NULL;
+	vfio_pci_tph_deinit(vdev);
 out_disable_device:
 	pci_disable_device(pdev);
 out_power:
@@ -681,6 +731,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	kfree(vdev->region);
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
+	vfio_pci_tph_deinit(vdev);
 	vfio_config_free(vdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
@@ -1637,6 +1688,79 @@ static int vfio_pci_core_feature_tph_cpu_st(struct vfio_pci_core_device *vdev,
 	return ret;
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
+	if (!vdev->tph_permit || !vdev->tph_st_shadow)
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
@@ -1660,6 +1784,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	case VFIO_DEVICE_FEATURE_TPH_CPU_ST:
 		return vfio_pci_core_feature_tph_cpu_st(vdev, flags,
 							arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_ST_CONFIG:
+		return vfio_pci_core_feature_tph_st_config(vdev, flags,
+							   arg, argsz);
 	default:
 		return -ENOTTY;
 	}
@@ -2223,6 +2350,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	mutex_init(&vdev->igate);
 	spin_lock_init(&vdev->irqlock);
 	mutex_init(&vdev->ioeventfds_lock);
+	mutex_init(&vdev->tph_lock);
 	INIT_LIST_HEAD(&vdev->dummy_resources_list);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
 	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
@@ -2244,6 +2372,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
+	mutex_destroy(&vdev->tph_lock);
 	kfree(vdev->region);
 	kfree(vdev->pm_save);
 }
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 662a04943511..652e278974b7 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -143,6 +143,9 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct mutex		tph_lock;
+	u16			*tph_st_shadow;
+	u16			tph_st_entries;
 };
 
 enum vfio_pci_io_width {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 19b5fb7eeae6..3df52b4dcf46 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1572,6 +1572,28 @@ struct vfio_device_feature_tph_cpu_st {
 	__aligned_u64 data_uptr;
 };
 
+/**
+ * VFIO_DEVICE_FEATURE_TPH_ST_CONFIG - Configure PCIe TPH Steering Tag entries
+ *
+ * Provides userspace interface to configure PCIe TPH ST table entries.
+ *
+ * @index: Start entry offset within ST table
+ * @count: Number of consecutive entries to configure
+ * @data_uptr: Userspace data buffer for 16-bit raw ST values
+ *
+ * This feature requires two preconditions:
+ * 1. Global enable_unsafe_tph module parameter is enabled;
+ * 2. VFIO_DEVICE_FEATURE_TPH_ENABLE has been SET on the device beforehand.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_ST_CONFIG	15
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

