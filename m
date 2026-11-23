Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401408;
	b=onfc1HmYYGDrOxy3nI52Imsmsfg+87koqqPVGt6yA2Jxpv/oQQNPMWKw2/m042npOa6s
	 2hX7Lwa9Bw3dbB+4SqZPET0X3sU28IAny94iYkHbpu3aF8ZVJpVvBMZIAfVzjIo6A3OgX
	 S6Khx/S2EVnhpVO0Qhnd3y7+69/b0c2NJSFWCcKADO3zU/Lw+ZL9sSfpe4fdGnZRCMZYO
	 KQZ+AdJMcniqqsqB5TAdpXivxm4tNnnKf8apLUgAuuPEn3sDyLrWI1gwMwTzWsIwUrfvo
	 JlbL3pGqZ6qC+wpgQRpu0IHMgw2UcjQRv+KWU30wcI4INnzG3EFA35+6Jb/MkNXca0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401408;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=Xe2GJKkXEPcKPo06neKHbPShglsAtaUFSTKdIvGHUJg=;
	b=xZBTfKhncQCJwvma1eOqygAFWfEu2qfdqHEVd9x9YGuu4T8KR9gFU+mYZVuC0IKh9RSI
	 k8THc9MHPy8dn5kLCBC+KRH8lxOIev+04OkANHQpr3DjjmXTYK/29JdVIKeiSU2l3nMzh
	 P26QN0RVPnu2qhb42GSNI2kgzdxMRXasVChAM0c5VTr31cGscasgpGaewa0Gsc5zUryLs
	 p1/u8m6Xe+EtmLFCsl6VGHprhNedPqssY8n7TehKQgNZ9koCYZYDiNbLad7XksOpySReF
	 5ZhwpeuIkllS5174vEqI85nSs0i7NZUJpCu3zQ56o4bm/MoYifDggTgZZoqzicyeqsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TqMnOkZ3;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F93606A6B3;
	Mon, 23 Nov 2026 02:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F93606A6B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TqMnOkZ3
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Xe2GJKkXEPcKPo06neKHbPShglsAtaUFSTKdIvGHUJg=;
	b=TqMnOkZ3Zi5o1/yxmVXA+sztyEoPnCraf73RUTIB7veqyzTK4tD6s2835Qc41jzWPTQeeW9of
	1pvo6YiJTsAI6K8V9ueLeUmKd6Mt7S4eGABuLaE3apeWG+7nLebYOHDtRtLOrQraqUN2Lm4GCP9
	jKFMNgbtk/MJPmbbQRXcQMY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jXqn46Zmcz1T4GF;
	Mon, 23 Nov 2026 10:35:52 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6103B4056E;
	Mon, 23 Nov 2026 10:36:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 10/13] vfio/pci: Add basic NO-ST TPH VFIO device feature support
Date: Mon, 23 Nov 2026 10:36:25 +0800
Message-ID: <20261123023628.7728-11-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261123023628.7728-1-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Implement basic PCIe TPH support restricted to NO-ST mode:

- Add a tph_policy module parameter, currently locked to NO-ST.
  The parameter range is reserved for future TPH policies.
- Virtualize the TPH extended capability register: mask IV/DS
  modes, ST location and ST size fields, only NO-ST capability
  is visible to userspace.
- Gate all TPH control register writes behind tph_opt_in.
  Opt-in is one-shot (0 -> 1 only), no reset path.
- Validate TPH control register writes: only NO-ST mode and
  supported requester enable values are accepted; invalid writes
  are dropped. CTRL reads always fetch hardware state directly.
- Add VFIO_DEVICE_FEATURE_TPH ioctl for opt-in (SET) and VFIO
  usable capability query (GET). GET fails with -EINVAL if the
  device has not been opted in.
- ST table accesses beyond the base TPH capability return zero
  on read and writes are discarded.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c        |  16 +++
 drivers/vfio/pci/vfio_pci_config.c | 170 ++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_core.c   |  45 ++++++++
 drivers/vfio/pci/vfio_pci_priv.h   |   4 +
 include/linux/vfio_pci_core.h      |   3 +
 include/uapi/linux/vfio.h          |  22 ++++
 6 files changed, 243 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e7c012febe91..77764eabb71a 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,21 @@ static bool disable_denylist;
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
+	"0 = No-ST mode: ST programming unavailable\n");
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -142,6 +157,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
+	vdev->tph_policy = tph_policy;
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..38f747de82d8 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -20,8 +20,10 @@
  * must be negotiated with the underlying OS.
  */
 
+#include <linux/bitfield.h>
 #include <linux/fs.h>
 #include <linux/pci.h>
+#include <linux/pci-tph.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/slab.h>
@@ -1085,6 +1087,151 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
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
+static void vfio_tph_vcap_rewrite(struct vfio_pci_core_device *vdev, int pos)
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
+		/*
+		 * NO-ST policy: mask IV/DS mode, ST location and ST size fields.
+		 * Userspace only sees NO-ST capability.
+		 */
+		val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
+			 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
+	}
+
+	*vptr = cpu_to_le32(val);
+
+	/* Cache the final virtualized TPH capability value */
+	vdev->tph_vcap = val;
+}
+
+static int vfio_tph_config_read(struct vfio_pci_core_device *vdev, int pos,
+				int count, struct perm_bits *perm,
+				int offset, __le32 *val)
+{
+	int ret;
+
+	if (offset >= PCI_TPH_BASE_SIZEOF) {
+		*val = cpu_to_le32(0);
+		return count;
+	}
+
+	if (offset < PCI_TPH_CTRL)
+		return vfio_default_config_read(vdev, pos, count, perm,
+						offset, val);
+
+	/* Read the actual device value for CTRL register. */
+	ret = vfio_user_config_read(vdev->pdev, pos, val, count);
+	return ret != 0 ? ret : count;
+}
+
+static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
+				 int count, struct perm_bits *perm,
+				 int offset, __le32 val)
+{
+	u16 start = vfio_find_cap_start(vdev, pos);
+	struct pci_dev *pdev = vdev->pdev;
+	u8 mode, org_mode, req, org_req;
+	u32 org_ctrl, new_ctrl, cap;
+	__le32 ctrl_val = 0;
+	u16 cmd;
+	int ret;
+
+	if (!vdev->tph_opt_in || offset >= PCI_TPH_BASE_SIZEOF ||
+		offset < PCI_TPH_CTRL)
+		return count;
+
+	cmd = vfio_pci_memory_lock_and_enable(vdev);
+
+	/*
+	 * Synchronize the CTRL value of the hardware to the virt. Otherwise,
+	 * the value will be inconsistent when the device is reset.
+	 */
+	vfio_user_config_read(pdev, start + PCI_TPH_CTRL, &ctrl_val, 4);
+	vfio_default_config_write(vdev, start + PCI_TPH_CTRL, 4, perm,
+				  PCI_TPH_CTRL, ctrl_val);
+	org_ctrl = le32_to_cpu(ctrl_val);
+
+	/* Do write operation to virt. */
+	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (ret != count)
+		goto out;
+
+	/* Reads the TPH_CTRL value after the write operation. */
+	new_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
+	if (new_ctrl == org_ctrl)
+		goto out; /* Exit because there is no change. */
+
+	cap = vdev->tph_vcap;
+	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
+	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
+	if (mode != PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) ||
+		req == 0x2 /* reserved */ ||
+		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
+		goto out; /* Drop invalid or unsupported write value. */
+
+	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
+	org_mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, org_ctrl);
+	if (req == org_req && mode == org_mode)
+		goto out; /* No change to requester type or ST mode. */
+
+	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
+		pcie_disable_tph(pdev);
+		pcie_enable_tph_ext(pdev, mode, req);
+	} else if (req == PCI_TPH_REQ_DISABLE) {
+		pcie_disable_tph(pdev);
+	}
+
+out:
+	vfio_pci_memory_unlock_and_restore(vdev, cmd);
+	return count;
+}
+
 /*
  * Initialize the shared permission tables
  */
@@ -1100,6 +1247,7 @@ void vfio_pci_uninit_perm_bits(void)
 
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
 }
 
 int __init vfio_pci_init_perm_bits(void)
@@ -1120,6 +1268,9 @@ int __init vfio_pci_init_perm_bits(void)
 	/* Extended capabilities */
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
+	ret |= init_pci_ext_cap_tph_perm(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
+	ecap_perms[PCI_EXT_CAP_ID_TPH].readfn = vfio_tph_config_read;
+	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_tph_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
 	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
 
@@ -1129,23 +1280,6 @@ int __init vfio_pci_init_perm_bits(void)
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
@@ -1702,6 +1836,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
 		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
 		if (ret)
 			return ret;
+		if (ecap == PCI_EXT_CAP_ID_TPH)
+			vfio_tph_vcap_rewrite(vdev, epos);
 
 		/*
 		 * If we're just using this capability to anchor the list,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 8d2aa5585c1b..be7d1921f5f3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -633,6 +633,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_free_zdev;
 
+	vdev->tph_opt_in = 0;
+
 	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
 		u16 flags;
@@ -1601,6 +1603,47 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
+{
+	/* NO-ST only, no capability bits exposed now */
+	return 0;
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
+	tph.flags = vfio_pci_tph_get_capability(vdev);
+
+	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1625,6 +1668,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_zdev_feature_fmb_enable(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_ZPCI_FMB_READ:
 		return vfio_pci_zdev_feature_fmb_read(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH:
+		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index e04d7e9d0c30..eef76a401edb 100644
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
index 2f3fa2787737..17c4ad490dc2 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -151,6 +151,9 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	u8			tph_policy;
+	u8			tph_opt_in;
+	u32			tph_vcap;
 };
 
 enum vfio_pci_io_width {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 7e9adb61c5e1..52d324139644 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1585,6 +1585,28 @@ struct vfio_device_feature_zpci_fmb_read {
 	__aligned_u64 data;
 };
 
+/*
+ * VFIO_DEVICE_FEATURE_TPH - Control and query VFIO TPH feature capabilities
+ *
+ * SET: Opt-in to enable the VFIO TPH feature for the device; flags must be
+ *      zero.
+ * GET: Return VFIO-usable TPH capability bits in flags (currently zero).
+ *      Returns an error if SET opt-in has not been performed.
+ *
+ * Typical userspace sequence:
+ * 1. Read virtualized PCI TPH capability via VFIO config space access to
+ *    discover underlying hardware PCI TPH support.
+ * 2. Invoke SET to opt-in for VFIO TPH feature permission.
+ * 3. Invoke GET to retrieve the set of TPH capabilities accessible via VFIO.
+ * 4. Write the TPH control register through VFIO config space to activate
+ *    device TPH hardware.
+ */
+#define VFIO_DEVICE_FEATURE_TPH			16
+
+struct vfio_device_feature_tph {
+	__u32 flags;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

