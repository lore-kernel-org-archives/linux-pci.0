Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68883CF69F;
	Tue, 23 Jun 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204676; cv=none; b=ZAbJx+3W+e2qlTrGU1GMM4XQDkCtJhS6V+KmkMuBr/Ldnf8AHU0RJIs+bW19591BiiNSMgrnOet6n4bnXZbMR5YhCZdtMIMksaCUBZ52Avokz50UjoIc0PA+hGUxUdDW0bC8fsdY0tyUWxjpOBwlcCr0fug1ZvYeDeMzf/XTmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204676; c=relaxed/simple;
	bh=B5NL+PyZBotWZumUEsc4VQJagtxBialkq7FUBK3S8uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvxkGeG7dRQX/4+51fCGj8EpPgRvUfcPHlMNqRg1Dz2CWeSEb2Z9VQSaXdv1y+QPuDWivlIxh96LaB4Dhf/1tVUHUpIw1PO2+tdxUDBq85FOt8r3qfShP8t7o344TuHuwNIKkkFFOhoHPODBeBLdceNADrS4ea+Ss53g0LQdHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3eTE6Ioc; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3eTE6Ioc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PTMU1tNT/bUOiVydppLLvV8cJNYjnYZeiwnvs+QhL/Y=;
	b=3eTE6Iocaq41On+SPvkD7TIgzC9+vJlyAgPxUUtUtE4l77N3FbQhZnHDX3wNn38qHrdSscmGI
	qiJlpW5Apzv/egA3iBDHIWMiny4Hbm+4Xd98Ya1z64aKqEwFtveHMhg7r3P5kzqUiBuN/3Rxg8s
	aYN6MZG/onwCrK7On6AuPjQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gkz850dSWz1K9CG;
	Tue, 23 Jun 2026 16:41:57 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD7940562;
	Tue, 23 Jun 2026 16:51:00 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 16:50:59 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RESEND v18 11/12] vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration
Date: Tue, 23 Jun 2026 16:50:47 +0800
Message-ID: <20260623085048.51139-12-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260623085048.51139-1-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

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

Design note for Sashiko reset shadow table warning:
Do not clear tph_st_shadow on FLR/device reset. Userspace VFIO application
can detect hardware reset events and re-initialize full ST table
configuration to sync shadow cache with hardware state afterward. Retain
cached ST entries to support offline error diagnosis and post-reset
recovery.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c |   1 -
 drivers/vfio/pci/vfio_pci_core.c   | 128 +++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h      |   2 +
 include/uapi/linux/vfio.h          |  22 +++++
 4 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 251d3ec7fdd4..5c6ab172df6c 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1783,7 +1783,6 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
 		goto out;
 
 	vdev->bardirty = true;
-	vdev->tph_permit = false;
 
 	/*
 	 * XXX can we just pci_load_saved_state/pci_restore_state?
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b0193afca875..c327eff8e9cc 100644
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
@@ -532,6 +533,52 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
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
+	vdev->tph_permit = false;
+
+	if (!enable_unsafe_tph)
+		return 0;
+
+	vdev->tph_st_entries = vfio_pci_tph_st_shadow_size(vdev);
+	if (vdev->tph_st_entries) {
+		vdev->tph_st_shadow = kcalloc(vdev->tph_st_entries, sizeof(u16),
+					      GFP_KERNEL_ACCOUNT);
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
+	vdev->tph_permit = false;
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -558,6 +605,11 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
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
@@ -615,6 +667,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 out_free_state:
 	kfree(vdev->pci_saved_state);
 	vdev->pci_saved_state = NULL;
+	vfio_pci_tph_deinit(vdev);
 out_disable_device:
 	pci_disable_device(pdev);
 out_power:
@@ -683,6 +736,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	kfree(vdev->region);
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
+	vfio_pci_tph_deinit(vdev);
 	vfio_config_free(vdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
@@ -1573,6 +1627,77 @@ static int vfio_pci_core_feature_tph_enable(struct vfio_pci_core_device *vdev,
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
+	if (!enable_unsafe_tph)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(config));
+	if (ret <= 0)
+		return ret;
+
+	if (!vdev->tph_permit || !vdev->tph_st_shadow)
+		return -EINVAL;
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
+	goto out_unlock_memory;
+
+rollback:
+	while (i-- > 0) {
+		idx = config.index + i;
+		pcie_tph_set_st_entry(pdev, idx, vdev->tph_st_shadow[idx]);
+	}
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
@@ -1593,6 +1718,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_TPH_ENABLE:
 		return vfio_pci_core_feature_tph_enable(vdev, flags, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_ST_CONFIG:
+		return vfio_pci_core_feature_tph_st_config(vdev, flags,
+							   arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index d551e530dd86..527c84f042aa 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -144,6 +144,8 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	u16			*tph_st_shadow;
+	u16			tph_st_entries;
 };
 
 enum vfio_pci_io_width {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e5a4d1d7091b..61079594a91f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1541,6 +1541,28 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_TPH_ENABLE	13
 
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
+#define VFIO_DEVICE_FEATURE_TPH_ST_CONFIG	14
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

