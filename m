Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915617A300;
	Tue, 14 Jul 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025835; cv=none; b=fhwyfBahNBVikZX5R4biqBc/5rAAnfDXom2YQ8NjCGInPdt0MlCtd4BcOX+EyrgIZH4zWRoK7PODZlHdsHt4yABNyRGlP874kUg20bqlqrURyW0+G0XbHMICVASzGj6G9VQqrhUqOBJ3WcIO3jwyukut3hui+0Tb+GZGcy3jo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025835; c=relaxed/simple;
	bh=YhNtrBQoAPd5mvx2ArrXGrv6cQZLzvQjauoQSrAnG6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDI7UmDOfiaQBM38X+GirJFsmFRYJxgDcYvS6dzHlvZGaqlVe00ETlX2IICNw9LaHoRvFmq6XpoCsd8dhF345XLVHH0aLBniAap7M4aSJjHn+eLLXkzU7IUlQkBAQKMtiVVRp201RXSV+FLfJMnoh2+u4ToYKTigGLhoZg86+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t5k1ohu1; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t5k1ohu1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DePpkOs+mVnROQ/Hx1iMrUrod6Oa4k5wroOzkN6Jn20=;
	b=t5k1ohu1adBK26GdkxMJWccDgSkuVoNcRcj6WsXXV3sfYKbClVr4tk0twvw/kBJ5mnTq+pKXp
	ZpY8MGlnqmEOjS9kSJJYSxOslBgn84m2f0K80mNx3f8YGWR+6exzBugsinK3MuOA2aNqgzLVjq8
	H2/gGi4iC2AwSDoikMzj9as=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf50vPVz1K96b;
	Tue, 14 Jul 2026 18:34:21 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id A47884048B;
	Tue, 14 Jul 2026 18:43:37 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:37 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 12/16] vfio/pci: Add basic NO-ST TPH VFIO device feature support
Date: Tue, 14 Jul 2026 18:43:21 +0800
Message-ID: <20260714104325.54444-13-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260714104325.54444-1-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Implement basic PCIe TPH support in NO-ST mode:
- Add tph_policy module parameter, currently locked to NO-ST mode
  * Return DMABUF TPH PH value via VFIO resolve interface only
  * Virtualize TPH capability register to only advertise NO-ST capabilities
  * Allow TPH control register writes to enable NO-ST TPH mode
- Add tph_opt_in guard: all TPH operations require prior opt-in via
  VFIO_DEVICE_FEATURE_TPH SET ioctl
- Add VFIO_DEVICE_FEATURE_TPH (opt-in + capability query)
- Add VFIO_DEVICE_FEATURE_TPH_RESOLVE (DMABUF processing hint resolve only)
- Add TPH extended capability virtual read/write handlers, hide raw ST
  fields, ST table reads return zero by default

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c        |  19 ++++
 drivers/vfio/pci/vfio_pci_config.c | 158 +++++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_core.c   | 126 +++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h   |   4 +
 include/linux/vfio_pci_core.h      |   3 +
 include/uapi/linux/vfio.h          |  54 ++++++++++
 6 files changed, 347 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..1612b109a30a 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,22 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+static unsigned int tph_policy;
+static int tph_policy_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
+				     VFIO_PCI_TPH_POLICY_NO_ST);
+}
+static const struct kernel_param_ops tph_param_ops = {
+	.set = tph_policy_set,
+	.get = param_get_uint,
+};
+module_param_cb(tph_policy, &tph_param_ops, &tph_policy, 0644);
+MODULE_PARM_DESC(tph_policy,
+	"Global TPH policy level (0=default No-ST):\n"
+	"0 = No-ST mode: RESOLVE only returns PH for DMABUF source;\n"
+	"                ST programming unavailable\n");
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -142,6 +158,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
+#ifdef CONFIG_PCIE_TPH
+	vdev->tph_policy = tph_policy;
+#endif
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..8bdac647397c 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -22,6 +22,7 @@
 
 #include <linux/fs.h>
 #include <linux/pci.h>
+#include <linux/pci-tph.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/slab.h>
@@ -1085,6 +1086,140 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
 	return 0;
 }
 
+static int vfio_find_cap_start(struct vfio_pci_core_device *vdev, int pos)
+{
+	u8 cap;
+	int base = (pos >= PCI_CFG_SPACE_SIZE) ? PCI_CFG_SPACE_SIZE :
+						 PCI_STD_HEADER_SIZEOF;
+	cap = vdev->pci_config_map[pos];
+
+	if (cap == PCI_CAP_ID_BASIC)
+		return 0;
+
+	/* XXX Can we have to abutting capabilities of the same type? */
+	while (pos - 1 >= base && vdev->pci_config_map[pos - 1] == cap)
+		pos--;
+
+	return pos;
+}
+
+static void vfio_update_tph_vconfig_bytes(struct vfio_pci_core_device *vdev,
+					  int pos)
+{
+	__le32 *vptr = (__le32 *)&vdev->vconfig[pos + PCI_TPH_CAP];
+	struct pci_dev *pdev = vdev->pdev;
+	u32 val = le32_to_cpu(*vptr);
+
+	if (!pcie_ext_tph_supported(pdev)) {
+		/* Remove extended TPH if root-port doesn't support */
+		val &= ~PCI_TPH_CAP_EXT_TPH;
+	}
+
+	if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST) {
+		/* Report only No-ST mode supported */
+		val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
+			 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
+	}
+
+	*vptr = cpu_to_le32(val);
+
+	/* Backup updated capability register value */
+	vdev->tph_cap_virt = val;
+}
+
+/* Permissions for TPH extended capability */
+static int __init init_pci_ext_cap_tph_perm(struct perm_bits *perm)
+{
+	/*
+	 * We only virtualize the TPH header (excluding the ST table).
+	 * For the ST table (if any), the read operation returns 0 by
+	 * default, and the write operation is discarded by default.
+	 */
+	if (alloc_perm_bits(perm, PCI_TPH_BASE_SIZEOF))
+		return -ENOMEM;
+
+	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
+	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);
+
+	p_setd(perm, PCI_TPH_CTRL, ALL_VIRT,
+	       PCI_TPH_CTRL_MODE_SEL_MASK | PCI_TPH_CTRL_REQ_EN_MASK);
+
+	return 0;
+}
+
+static int vfio_tph_config_read(struct vfio_pci_core_device *vdev, int pos,
+				int count, struct perm_bits *perm,
+				int offset, __le32 *val)
+{
+	if (offset >= PCI_TPH_BASE_SIZEOF) {
+		*val = cpu_to_le32(0);
+		return count;
+	}
+
+	if (offset >= PCI_TPH_CAP && !vdev->tph_opt_in) {
+		*val = cpu_to_le32(0);
+		return count;
+	}
+
+	return vfio_default_config_read(vdev, pos, count, perm, offset, val);
+}
+
+static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
+				 int count, struct perm_bits *perm,
+				 int offset, __le32 val)
+{
+	u16 start = vfio_find_cap_start(vdev, pos);
+	struct pci_dev *pdev = vdev->pdev;
+	u32 org_ctrl, new_ctrl, cap;
+	u8 mode, req, org_req;
+	__le32 org_val = 0;
+	u16 cmd;
+	int ret;
+
+	if (!vdev->tph_opt_in || offset >= PCI_TPH_BASE_SIZEOF)
+		return count;
+
+	cmd = vfio_pci_memory_lock_and_enable(vdev);
+
+	org_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
+	vfio_default_config_read(vdev, pos, count, perm, offset, &org_val);
+
+	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (ret != count)
+		goto out;
+
+	new_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
+	if (new_ctrl == org_ctrl)
+		goto out; /* Only care about changes in TPH_CTRL. */
+
+	cap = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CAP]);
+	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
+	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
+	if (mode != PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) || req == 0x2 ||
+		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
+		goto restore; /* Drop invalid or unsupported write value */
+
+	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
+	if (req == org_req)
+		goto restore; /* Only care about requester enable */
+
+	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
+		ret = pcie_enable_tph_ext(pdev, mode, req);
+		if (ret)
+			goto restore;
+	} else if (req == PCI_TPH_REQ_DISABLE) {
+		pcie_disable_tph(vdev->pdev);
+	}
+
+	goto out;
+
+restore:
+	vfio_default_config_write(vdev, pos, count, perm, offset, org_val);
+out:
+	vfio_pci_memory_unlock_and_restore(vdev, cmd);
+	return count;
+}
+
 /*
  * Initialize the shared permission tables
  */
@@ -1100,6 +1235,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -1120,6 +1256,9 @@ int __init vfio_pci_init_perm_bits(void)
 	/* Extended capabilities */
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	ret |= init_pci_ext_cap_tph_perm(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
+	ecap_perms[PCI_EXT_CAP_ID_TPH].readfn = vfio_tph_config_read;
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
@@ -1129,23 +1268,6 @@ int __init vfio_pci_init_perm_bits(void)
 	return ret;
 }
 
-static int vfio_find_cap_start(struct vfio_pci_core_device *vdev, int pos)
-{
-	u8 cap;
-	int base = (pos >= PCI_CFG_SPACE_SIZE) ? PCI_CFG_SPACE_SIZE :
-						 PCI_STD_HEADER_SIZEOF;
-	cap = vdev->pci_config_map[pos];
-
-	if (cap == PCI_CAP_ID_BASIC)
-		return 0;
-
-	/* XXX Can we have to abutting capabilities of the same type? */
-	while (pos - 1 >= base && vdev->pci_config_map[pos - 1] == cap)
-		pos--;
-
-	return pos;
-}
-
 static int vfio_msi_config_read(struct vfio_pci_core_device *vdev, int pos,
 				int count, struct perm_bits *perm,
 				int offset, __le32 *val)
@@ -1701,6 +1823,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
 		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
 		if (ret)
 			return ret;
+		if (ecap == PCI_EXT_CAP_ID_TPH)
+			vfio_update_tph_vconfig_bytes(vdev, epos);
 
 		/*
 		 * If we're just using this capability to anchor the list,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4e5e34a77b76..82582c8ef69d 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -13,6 +13,8 @@
 #include <linux/aperture.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/eventfd.h>
 #include <linux/file.h>
 #include <linux/interrupt.h>
@@ -30,6 +32,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommufd.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #include <linux/seq_file.h>
 #if IS_ENABLED(CONFIG_EEH)
 #include <asm/eeh.h>
@@ -610,6 +613,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_disable_device;
 
 	vdev->reset_works = !ret;
+	vdev->tph_opt_in = false;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -1607,6 +1611,123 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static u32 vfio_pci_get_tph_capability(struct vfio_pci_core_device *vdev)
+{
+	return VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH;
+}
+
+static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
+				     u32 flags,
+				     struct vfio_device_feature_tph __user *arg,
+				     size_t argsz)
+{
+	struct vfio_device_feature_tph tph;
+	int ret;
+
+	if (!pcie_std_tph_supported(vdev->pdev))
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz,
+			VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET,
+			sizeof(tph));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&tph, arg, sizeof(tph)))
+		return -EFAULT;
+
+	if (flags & VFIO_DEVICE_FEATURE_SET) {
+		if (tph.flags != 0)
+			return -EINVAL;
+		vdev->tph_opt_in = 1;
+		return 0;
+	}
+
+	if (!vdev->tph_opt_in)
+		return -EINVAL;
+
+	tph.flags = vfio_pci_get_tph_capability(vdev);
+
+	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
+}
+
+static u32 vfio_pci_get_tph_resolve_allow_src(struct vfio_pci_core_device *vdev)
+{
+	u32 flags = vfio_pci_get_tph_capability(vdev);
+	u32 allow_src = 0;
+
+	if (flags & VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH)
+		allow_src |= VFIO_DEVICE_TPH_SRC_DMABUF;
+
+	return allow_src;
+}
+
+static int vfio_pci_get_dmabuf_tph(int fd, bool extended, u16 *st, u8 *ph)
+{
+	struct dma_buf *dmabuf;
+	int ret;
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
+	if (ret == 0)
+		ret = dma_buf_get_pci_tph(dmabuf, extended, st, ph);
+	dma_resv_unlock(dmabuf->resv);
+
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
+static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
+			u32 flags,
+			struct vfio_device_feature_tph_resolve __user *arg,
+			size_t argsz)
+{
+	struct vfio_device_feature_tph_resolve resolve;
+	u32 user_flags, allow_src;
+	bool extended;
+	u16 tag = 0;
+	u8 ph = 0;
+	int ret;
+
+	if (!vdev->tph_opt_in)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
+				 sizeof(resolve));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&resolve, arg, sizeof(resolve)))
+		return -EFAULT;
+
+	user_flags = resolve.flags;
+	extended = !!(user_flags & VFIO_DEVICE_TPH_EXTENDED);
+	if (extended && !pcie_ext_tph_supported(vdev->pdev))
+		return -EOPNOTSUPP;
+	user_flags &= ~VFIO_DEVICE_TPH_EXTENDED;
+
+	allow_src = vfio_pci_get_tph_resolve_allow_src(vdev);
+	if (user_flags & ~allow_src || !is_power_of_2(user_flags))
+		return -EINVAL;
+
+	resolve.valid = 0;
+	resolve.ph = 0;
+
+	if (user_flags & VFIO_DEVICE_TPH_SRC_DMABUF) {
+		ret = vfio_pci_get_dmabuf_tph(resolve.src, extended,
+					      &tag, &ph);
+		if (ret)
+			return ret;
+		resolve.ph = ph;
+		resolve.valid = VFIO_DEVICE_TPH_VALID_PH;
+	}
+
+	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1628,6 +1749,11 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
 		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
 							 argsz);
+	case VFIO_DEVICE_FEATURE_TPH:
+		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
+		return vfio_pci_core_feature_tph_resolve(vdev, flags,
+							 arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index c58f369be4b3..7fbf938f69e1 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,10 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+enum vfio_pci_tph_policy {
+	VFIO_PCI_TPH_POLICY_NO_ST = 0,
+};
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..d6064fa9e80a 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -149,6 +149,9 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	u8			tph_opt_in;
+	u8			tph_policy;
+	u32			tph_cap_virt;
 };
 
 enum vfio_pci_io_width {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 4c1c70aac150..ae7a2f083cd5 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1577,6 +1577,60 @@ struct vfio_device_feature_dma_buf_tph {
 	__u8	ph;
 };
 
+/* PCIe TPH device feature definitions for VFIO_DEVICE_FEATURE ioctl */
+#define VFIO_DEVICE_FEATURE_TPH		14
+#define VFIO_DEVICE_FEATURE_TPH_RESOLVE	15
+
+/*
+ * VFIO_DEVICE_FEATURE_TPH - Control and query PCI TPH capabilities
+ *
+ * SET: Opt-in to TPH feature for the device; flags must be zero.
+ * GET: Return supported TPH capability bits (see VFIO_DEVICE_TPH_CAP_*)
+ *      in flags. Returns error if SET has not been invoked first.
+ *
+ * Userspace must first invoke SET on this feature to enable TPH support,
+ * receive valid capability bits via GET, gain permission for using
+ * VFIO_DEVICE_FEATURE_TPH_RESOLVE, and access the virtualized TPH
+ * capability registers via VFIO config space accesses.
+ */
+struct vfio_device_feature_tph {
+	__u32 flags;
+};
+
+/* DMABUF source resolve processing hint supported */
+#define VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH	(1u << 0)
+
+/*
+ * VFIO_DEVICE_FEATURE_TPH_RESOLVE - Resolve TPH attributes from given source
+ *
+ * GET only
+ *
+ * Requires prior successful SET on VFIO_DEVICE_FEATURE_TPH, otherwise
+ * this feature will return error.
+ *
+ * @flags: IN - source type selector (see VFIO_DEVICE_TPH_SRC_*)
+ *         and steering tag namespace selector (see VFIO_DEVICE_TPH_EXTENDED)
+ * @src:   IN - source identifier, e.g. dmabuf fd when SRC_DMABUF is set in
+ *         flags
+ * @valid: OUT - bitmap indicating valid output fields, see
+ *         VFIO_DEVICE_TPH_VALID_*
+ * @ph:    OUT - TPH processing hint (valid when VALID_PH is set in valid)
+ * @rsv:   Must be zero, reserved for future extensions
+ */
+struct vfio_device_feature_tph_resolve {
+	__u32 flags;
+	__u32 src;
+	__u8  valid;
+#define VFIO_DEVICE_TPH_VALID_PH (1u << 0) /* ph holds valid processing hint */
+	__u8  ph;
+	__u16 rsv;
+};
+
+/* Source holds dma-buf fd */
+#define VFIO_DEVICE_TPH_SRC_DMABUF      (1u << 0)
+/* Use extended 16-bit steering tag namespace */
+#define VFIO_DEVICE_TPH_EXTENDED	(1u << 1)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

