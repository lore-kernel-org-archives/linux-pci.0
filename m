Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC142372EE2;
	Tue, 14 Jul 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025834; cv=none; b=qsqueadZla5UZI3M50gEkMtSV7I0Z6U+UoK0rppd6MwRisynUM9m7Iz3RsuN60SQ+otozBd7J8hSJrBoqmDFoB8kUEGxrqrRY2WIpODmg9HvEhSiAVRZyeHrGINjhpC/mgS6rOwfbODnZzPQ7TUc+0HyogWesBaeti5gtH5b+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025834; c=relaxed/simple;
	bh=O3rRIsPkRUXriHgoeA3gQwC89oKyFF7Ot6BC9BjNGe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3fIpEHmQZc3eH5gTDx77MquJgMKM8EaQnEYf5EprI0rEiI1uYUZmkxT2KMmXPciksbgsPid5LMKqxO9p8ELwaYzqCK8kFTJTbauKat08F3RWgNXEYQEXC9UgelTMmrCzq64yfUEHjNmR57BxLptamOzi8V3prQRdyD/96lxM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4vD9Hzwe; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4vD9Hzwe; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4vD9Hzwe";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4vD9Hzwe"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O2Npk4XS9LSfrguz/Y550OHHHfH+nINTCshKxqDjcHM=;
	b=4vD9HzweznQmAh/au/S8wsJMe5vJnEhwrnswtvAn5tbzv055g8kuFMwMYopcxolGNUxpmZ3JS
	QbyLTrkxAQ5j6id5s7uf/Lry+aVfQMCU1VDpV0IdkjTDpR2R2eCB2S6oTJ/MubMpozemm6pa1+1
	x2hWL42FFb9HEtXE9dPfYgo=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4gzwrK02nnz126M2S;
	Tue, 14 Jul 2026 18:43:13 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O2Npk4XS9LSfrguz/Y550OHHHfH+nINTCshKxqDjcHM=;
	b=4vD9HzweznQmAh/au/S8wsJMe5vJnEhwrnswtvAn5tbzv055g8kuFMwMYopcxolGNUxpmZ3JS
	QbyLTrkxAQ5j6id5s7uf/Lry+aVfQMCU1VDpV0IdkjTDpR2R2eCB2S6oTJ/MubMpozemm6pa1+1
	x2hWL42FFb9HEtXE9dPfYgo=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf76s3KzcbN8;
	Tue, 14 Jul 2026 18:34:23 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 306064056D;
	Tue, 14 Jul 2026 18:43:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:37 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 13/16] vfio/pci: Add IV-ST TPH policy and VFIO TPH_ST batch programming support
Date: Tue, 14 Jul 2026 18:43:22 +0800
Message-ID: <20260714104325.54444-14-fengchengwen@huawei.com>
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

Extend VFIO TPH implementation to support IV-ST mode based on the existing
NO-ST baseline, and add VFIO_DEVICE_FEATURE_TPH_ST for batch ST table
programming.

- Add VFIO_PCI_TPH_POLICY_IV_ST policy and extend tph_policy module param
  * NO-ST: hide all ST capabilities, ST programming unavailable
  * IV-ST: expose IV mode + ST location/size, hide only DS capability
- Restrict TPH mode selection writes to NS/IV only, disallow DS
- Report precise TPH_ST capabilities via GET: NONE/DMABUF always available,
  CPU source exposed only if root-port TPH DSM is supported
- Add VFIO_DEVICE_FEATURE_TPH_ST (SET-only) to batch program ST table
  entries supporting NONE, DMABUF, and CPU (volatile/persistent) sources
- Keep TPH_RESOLVE behavior unchanged: only DMABUF source, only return PH
  value
- Enforce tph_opt_in guard and policy check for all ST programming
  operations

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c        |   6 +-
 drivers/vfio/pci/vfio_pci_config.c |   8 +-
 drivers/vfio/pci/vfio_pci_core.c   | 151 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |   1 +
 include/uapi/linux/vfio.h          |  46 ++++++++-
 5 files changed, 206 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 1612b109a30a..02c5c8283099 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -64,7 +64,7 @@ static unsigned int tph_policy;
 static int tph_policy_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
-				     VFIO_PCI_TPH_POLICY_NO_ST);
+				     VFIO_PCI_TPH_POLICY_IV_ST);
 }
 static const struct kernel_param_ops tph_param_ops = {
 	.set = tph_policy_set,
@@ -74,7 +74,9 @@ module_param_cb(tph_policy, &tph_param_ops, &tph_policy, 0644);
 MODULE_PARM_DESC(tph_policy,
 	"Global TPH policy level (0=default No-ST):\n"
 	"0 = No-ST mode: RESOLVE only returns PH for DMABUF source;\n"
-	"                ST programming unavailable\n");
+	"                ST programming unavailable\n"
+	"1 = Add IV mode: RESOLVE only returns PH for DMABUF source;\n"
+	"                 ST program supports NONE/DMABUF/CPU sources\n");
 
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 8bdac647397c..8c68504839b9 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1119,6 +1119,12 @@ static void vfio_update_tph_vconfig_bytes(struct vfio_pci_core_device *vdev,
 		/* Report only No-ST mode supported */
 		val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
 			 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
+	} else if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_IV_ST) {
+		/* Report only No-ST and IV modes supported */
+		val &= ~PCI_TPH_CAP_ST_DS;
+		/* Remove ST location and size if dev doesn't support IV mode */
+		if (!(val & PCI_TPH_CAP_ST_IV))
+			val &= ~(PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
 	}
 
 	*vptr = cpu_to_le32(val);
@@ -1195,7 +1201,7 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
 	cap = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CAP]);
 	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
 	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
-	if (mode != PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) || req == 0x2 ||
+	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) || req == 0x2 ||
 		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
 		goto restore; /* Drop invalid or unsupported write value */
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 82582c8ef69d..df31f4e8766f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1613,7 +1613,17 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 
 static u32 vfio_pci_get_tph_capability(struct vfio_pci_core_device *vdev)
 {
-	return VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH;
+	u32 flags = VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH;
+
+	if (vdev->tph_policy >= VFIO_PCI_TPH_POLICY_IV_ST &&
+		(vdev->tph_cap_virt & PCI_TPH_CAP_ST_IV)) {
+		flags |= VFIO_DEVICE_TPH_CAP_ST_NONE;
+		flags |= VFIO_DEVICE_TPH_CAP_ST_DMABUF;
+		if (pcie_tph_dsm_supported(vdev->pdev))
+			flags |= VFIO_DEVICE_TPH_CAP_ST_CPU;
+	}
+
+	return flags;
 }
 
 static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
@@ -1680,6 +1690,32 @@ static int vfio_pci_get_dmabuf_tph(int fd, bool extended, u16 *st, u8 *ph)
 	return ret;
 }
 
+static int vfio_pci_get_tph_st_tag(struct pci_dev *pdev, u32 src_bits,
+				   u32 src_hndl, bool extended, u16 *st)
+{
+	u8 req_type = extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
+	int ret = 0;
+	u8 ph;
+
+	if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF)
+		ret = vfio_pci_get_dmabuf_tph(src_hndl, extended, st, &ph);
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
+		ret = pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_VM,
+					      req_type, src_hndl, st);
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
+		ret = pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_PM,
+					      req_type, src_hndl, st);
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
+		*st = 0;
+	else
+		ret = -EINVAL;
+
+	if (ret != 0)
+		*st = 0;
+
+	return ret;
+}
+
 static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
 			u32 flags,
 			struct vfio_device_feature_tph_resolve __user *arg,
@@ -1728,6 +1764,117 @@ static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
 	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
 }
 
+static u32 vfio_pci_get_tph_st_allow_src(struct vfio_pci_core_device *vdev)
+{
+	u32 flags = vfio_pci_get_tph_capability(vdev);
+	u32 allow_src = 0;
+
+	if (flags & VFIO_DEVICE_TPH_CAP_ST_DMABUF)
+		allow_src |= VFIO_DEVICE_TPH_SRC_DMABUF;
+	if (flags & VFIO_DEVICE_TPH_CAP_ST_CPU)
+		allow_src |= VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
+			     VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;
+	if (flags & VFIO_DEVICE_TPH_CAP_ST_NONE)
+		allow_src |= VFIO_DEVICE_TPH_SRC_NONE;
+
+	return allow_src;
+}
+
+static u32 vfio_pci_get_tph_st_size(struct vfio_pci_core_device *vdev)
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
+static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
+				u32 flags,
+				struct vfio_device_feature_tph_st __user *arg,
+				size_t argsz)
+{
+	struct vfio_device_feature_tph_st tph_st;
+	u32 user_flags, allow_src, st_size;
+	struct pci_dev *pdev = vdev->pdev;
+	bool extended, stop_on_zero;
+	u32 *src_hndl = NULL;
+	u16 *tags = NULL;
+	int ret, i;
+	u16 cmd;
+
+	if (!vdev->tph_opt_in || vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(tph_st));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
+		return -EFAULT;
+
+	user_flags = tph_st.flags;
+	extended = !!(user_flags & VFIO_DEVICE_TPH_EXTENDED);
+	if (extended && !pcie_ext_tph_supported(vdev->pdev))
+		return -EOPNOTSUPP;
+	user_flags &= ~VFIO_DEVICE_TPH_EXTENDED;
+
+	stop_on_zero = !!(user_flags & VFIO_DEVICE_TPH_REQUIRE_ST);
+	if (stop_on_zero && (user_flags & VFIO_DEVICE_TPH_SRC_NONE))
+		return -EINVAL;
+	user_flags &= ~VFIO_DEVICE_TPH_REQUIRE_ST;
+
+	allow_src = vfio_pci_get_tph_st_allow_src(vdev);
+	if (user_flags & ~allow_src || !is_power_of_2(user_flags))
+		return -EINVAL;
+
+	st_size = vfio_pci_get_tph_st_size(vdev);
+	if (tph_st.start >= st_size || tph_st.count > st_size - tph_st.start ||
+		tph_st.count == 0)
+		return -EINVAL;
+
+	if (!(user_flags & VFIO_DEVICE_TPH_SRC_NONE)) {
+		src_hndl = memdup_array_user(u64_to_user_ptr(tph_st.dests),
+					     tph_st.count, sizeof(u32));
+		if (IS_ERR(src_hndl))
+			return PTR_ERR(src_hndl);
+	}
+	tags = kcalloc(tph_st.count, sizeof(u16), GFP_KERNEL_ACCOUNT);
+	if (!tags) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < tph_st.count; i++) {
+		ret = vfio_pci_get_tph_st_tag(pdev, user_flags,
+					      src_hndl ? src_hndl[i] : 0,
+					      extended, &tags[i]);
+		if (ret || (stop_on_zero && tags[i] == 0))
+			break;
+	}
+
+	if (i > 0) {
+		cmd = vfio_pci_memory_lock_and_enable(vdev);
+		ret = pcie_tph_set_st_entries(pdev, tph_st.start, i, tags);
+		vfio_pci_memory_unlock_and_restore(vdev, cmd);
+	}
+
+out:
+	kfree(tags);
+	kfree(src_hndl);
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1754,6 +1901,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
 		return vfio_pci_core_feature_tph_resolve(vdev, flags,
 							 arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_ST:
+		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 7fbf938f69e1..7b89aab7c4c1 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -13,6 +13,7 @@
 
 enum vfio_pci_tph_policy {
 	VFIO_PCI_TPH_POLICY_NO_ST = 0,
+	VFIO_PCI_TPH_POLICY_IV_ST = 1,
 };
 
 struct vfio_pci_ioeventfd {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ae7a2f083cd5..4b2132c2794e 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1580,6 +1580,7 @@ struct vfio_device_feature_dma_buf_tph {
 /* PCIe TPH device feature definitions for VFIO_DEVICE_FEATURE ioctl */
 #define VFIO_DEVICE_FEATURE_TPH		14
 #define VFIO_DEVICE_FEATURE_TPH_RESOLVE	15
+#define VFIO_DEVICE_FEATURE_TPH_ST	16
 
 /*
  * VFIO_DEVICE_FEATURE_TPH - Control and query PCI TPH capabilities
@@ -1590,8 +1591,8 @@ struct vfio_device_feature_dma_buf_tph {
  *
  * Userspace must first invoke SET on this feature to enable TPH support,
  * receive valid capability bits via GET, gain permission for using
- * VFIO_DEVICE_FEATURE_TPH_RESOLVE, and access the virtualized TPH
- * capability registers via VFIO config space accesses.
+ * VFIO_DEVICE_FEATURE_TPH_RESOLVE / VFIO_DEVICE_FEATURE_TPH_ST, and access
+ * the virtualized TPH capability registers via VFIO config space accesses.
  */
 struct vfio_device_feature_tph {
 	__u32 flags;
@@ -1599,6 +1600,12 @@ struct vfio_device_feature_tph {
 
 /* DMABUF source resolve processing hint supported */
 #define VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH	(1u << 0)
+/* DMABUF source TPH_ST batch programming supported */
+#define VFIO_DEVICE_TPH_CAP_ST_DMABUF		(1u << 1)
+/* CPU source TPH_ST batch programming supported */
+#define VFIO_DEVICE_TPH_CAP_ST_CPU		(1u << 2)
+/* NONE source (means steering tag is zero) TPH_ST batch programming supported */
+#define VFIO_DEVICE_TPH_CAP_ST_NONE		(1u << 3)
 
 /*
  * VFIO_DEVICE_FEATURE_TPH_RESOLVE - Resolve TPH attributes from given source
@@ -1626,10 +1633,45 @@ struct vfio_device_feature_tph_resolve {
 	__u16 rsv;
 };
 
+/*
+ * VFIO_DEVICE_FEATURE_TPH_ST - Batch program architected steering tag
+ * table entries
+ * Return value: >=0 = number of successfully written entries;
+ *               <0  = negative errno
+ *
+ * SET only
+ *
+ * Additional constraint: Userspace must complete two prerequisite steps
+ * before invoking this feature:
+ * 1. Call VFIO_DEVICE_FEATURE_TPH with SET to enable vfio TPH permission;
+ * 2. Write the TPH control register to activate device hardware TPH logic.
+ *
+ * @flags: IN - source type selector (see VFIO_DEVICE_TPH_SRC_*) and
+ *         steering tag namespace selector (see VFIO_DEVICE_TPH_EXTENDED) and
+ *         failure policy (see VFIO_DEVICE_TPH_REQUIRE_ST)
+ * @start: IN - first steering tag table index / MSI-X vector
+ * @count: IN - number of contiguous entries to program
+ * @dests: IN - user pointer to array of source u32 values
+ */
+struct vfio_device_feature_tph_st {
+	__u32 flags;
+	__u16 start;
+	__u16 count;
+	__aligned_u64 dests;
+};
+
 /* Source holds dma-buf fd */
 #define VFIO_DEVICE_TPH_SRC_DMABUF      (1u << 0)
 /* Use extended 16-bit steering tag namespace */
 #define VFIO_DEVICE_TPH_EXTENDED	(1u << 1)
+/* Source holds volatile memory CPU ID */
+#define VFIO_DEVICE_TPH_SRC_CPU_VOLATILE	(1u << 2)
+/* Source holds persistent memory CPU ID */
+#define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT	(1u << 3)
+/* TPH_ST only: set steering tag to zero */
+#define VFIO_DEVICE_TPH_SRC_NONE	(1u << 4)
+/* TPH_ST only: fail if resolved steering tag is zero */
+#define VFIO_DEVICE_TPH_REQUIRE_ST	(1u << 5)
 
 /* -------- API for Type1 VFIO IOMMU -------- */
 
-- 
2.17.1

