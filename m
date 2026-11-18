Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993192;
	b=ZLphR4xhDZHmiEOaLwj5xxxa8Wj74nqHhd7xKS4uuoKRqxJ7Gk0fMGg8B4r0zAFdmwCy
	 3PO58VIGjFSGBQuYpC4S2zLkSMqA2zBb+dSBVCV4kEZ/XDtmUVqTlySFqFwaV8bP+BQMU
	 4/N01TlbZEElrvCLDRxm3rslRWpg21zGP8Errl8v359+hXyFkesay5KCuAPPj3YGLS5FF
	 P0USBVGNdJ8zCg3Y5Y8l/jDcRmQq5vBYXcRC9cWsbeu+1DE9VmhNIpJil9FiG/l1N+gGO
	 6DehCQiuSywzYIetn+wPuIcYO+WEXoDgrEW9c25Snt+Os3DePVFAJQyJDaFHKN9GCwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993192;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=jHw5firdYjTcSC0PfZ+deeEcVGSbMJ2YshSTEuVDJ/I=;
	b=sno7cJZY+dhCJQYBVegFsnbOmNXjQ9iuLjd9xDgf0TMhhwYMGgwFKw0oVLJSrK4Loa2j
	 F8lDhAWAItUmlFTUir3IWijzxt7W9U3t5nza5CUmMswlRjYD+yxmeb8rnVgFgVRBoTwEV
	 9EowR/oD877Fd2eixAyH/tdzQPEUwyqMrOdwBSiZhEXPbxmc7ihhu0ZAPvQHTV3KZkyA7
	 Q2G+S7rbEGt36akonQgo/Cn144ZAWDZSCvsipT+PAkTj+RLH/gcKwnWQSrx66dc4v79WW
	 n8BKeExlGMayQBUwQF3ZkNe0V5pWDt/J0VO2jOXIQYuK2O49J1s/VlwgXUy9QJ07IsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Q9V6wkIP;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140A606A33A;
	Wed, 18 Nov 2026 09:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1140A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Q9V6wkIP
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jHw5firdYjTcSC0PfZ+deeEcVGSbMJ2YshSTEuVDJ/I=;
	b=Q9V6wkIP0pv9YRdCD5SCR9ZSfyO+UEtcz4LbqHn9S3IUTbvTaiNRhQT6hfYxoRuUFopp/B2Sn
	7TpAXtjgJ5C3Su6JE5OfgMIPeCdo+0B2nBInOfkpdbPCyIdCqY/OJcVJshVKFfqwb4Pnv5/9s6X
	hApXfDWeOU/q3gOojQUqaUY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jTwpZ539Vzcb1Z;
	Wed, 18 Nov 2026 17:12:06 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 44DF2202E6;
	Wed, 18 Nov 2026 17:12:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:58 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 11/13] vfio/pci: Add DS-ST TPH policy and TPH_RESOLVE capability
Date: Wed, 18 Nov 2026 17:12:36 +0800
Message-ID: <20261118091238.45992-12-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261118091238.45992-1-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Extend the VFIO TPH policy model beyond NO-ST and IV-ST, add DS-ST
policy and introduce VFIO_DEVICE_FEATURE_TPH_RESOLVE for steering tag (ST)
lookup.

- Add VFIO_PCI_TPH_POLICY_DS_ST, extend module parameter valid range
  * DS-ST: expose TPH_RESOLVE for CPU source steering tag lookup;
           ST programming supports NONE and CPU sources
  Note: In this 'DS-ST mode', device-specific ST tables are not preserved
        across PCI resets, userspace must re-establish ST state after
        reset. The kernel cannot validate these ST entries, so this mode
        is not recommended for general virtualization usecases
- Relax TPH control register write check to allow NS/IV/DS mode selection
- Implement TPH_RESOLVE:
  * Support CPU volatile / persistent memory source steering tag resolution
  * Return resolved steering tag (ST) when capability is advertised
- Advertise TPH_RESOLVE capability only when hardware reports DS-ST support
- Update module parameter description to document DS-ST caveat

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c        | 11 ++++--
 drivers/vfio/pci/vfio_pci_config.c |  2 +-
 drivers/vfio/pci/vfio_pci_core.c   | 58 ++++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_priv.h   |  1 +
 include/uapi/linux/vfio.h          | 37 +++++++++++++++++++
 5 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 664775bb3526..0369069e7f6a 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -64,7 +64,7 @@ static unsigned int tph_policy;
 static int tph_policy_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
-				     VFIO_PCI_TPH_POLICY_IV_ST);
+				     VFIO_PCI_TPH_POLICY_DS_ST);
 }
 static const struct kernel_param_ops tph_param_ops = {
 	.set = tph_policy_set,
@@ -74,7 +74,14 @@ module_param_cb(tph_policy, &tph_param_ops, &tph_policy, 0644);
 MODULE_PARM_DESC(tph_policy,
 	"Global TPH policy level (0=default No-ST):\n"
 	"0 = No-ST mode: ST programming unavailable\n"
-	"1 = Add IV-ST mode: ST programming supports NONE/CPU sources\n");
+	"1 = Add IV-ST mode: ST programming supports NONE/CPU sources\n"
+	"2 = Add DS-ST mode: RESOLVE returns ST for CPU sources;\n"
+	"                    ST programming supports NONE/CPU sources\n"
+	"    Note: In this 'Add DS-ST mode', device-specific ST tables are\n"
+	"          not preserved across PCI resets, userspace must re-establish\n"
+	"          ST state after reset. The kernel cannot validate these ST\n"
+	"          entries, so this mode is not recommended for general\n"
+	"          virtualization usecases.");
 
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 398f8db8b8ff..8e47f84216b0 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1218,7 +1218,7 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
 	cap = vdev->tph_vcap;
 	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
 	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
-	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) ||
+	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) ||
 		req == 0x2 /* reserved */ ||
 		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
 		goto out; /* Drop invalid or unsupported write value. */
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 23ed8ea39657..049392831b35 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1710,12 +1710,17 @@ static void vfio_pci_tph_dev_deinit(struct vfio_pci_core_device *vdev)
 static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
 {
 	bool has_arch_st;
+	u32 cap = 0;
 
 	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
-	if (!has_arch_st)
-		return 0;
+	if (has_arch_st)
+		cap |= VFIO_DEVICE_TPH_CAP_PROG_ST_NONE |
+		       VFIO_DEVICE_TPH_CAP_PROG_ST_CPU;
 
-	return VFIO_DEVICE_TPH_CAP_PROG_ST_NONE | VFIO_DEVICE_TPH_CAP_PROG_ST_CPU;
+	if (vdev->tph_vcap & PCI_TPH_CAP_ST_DS)
+		cap |= VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST;
+
+	return cap;
 }
 
 static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
@@ -1901,6 +1906,50 @@ static int vfio_pci_core_feature_tph_program(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
+			u32 flags,
+			struct vfio_device_feature_tph_resolve __user *arg,
+			size_t argsz)
+{
+	struct vfio_device_feature_tph_resolve resolve;
+	u32 user_flags, src_mask;
+	bool extended;
+	u16 tag = 0;
+	int ret;
+
+	if (!vdev->tph_opt_in || !(vdev->tph_vcap & PCI_TPH_CAP_ST_DS))
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
+	src_mask = vfio_pci_tph_get_src_mask(vdev) & ~VFIO_DEVICE_TPH_SRC_NONE;
+	if (user_flags & ~src_mask || !is_power_of_2(user_flags))
+		return -EINVAL;
+
+	ret = vfio_pci_tph_resolve_st_tag(vdev->pdev, user_flags, resolve.src,
+					  extended, &tag);
+	if (ret != 0)
+		return ret;
+
+	resolve.valid = VFIO_DEVICE_TPH_VALID_ST;
+	resolve.rsv   = 0;
+	resolve.st    = tag;
+
+	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1926,6 +1975,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	case VFIO_DEVICE_FEATURE_TPH_PROGRAM:
 		return vfio_pci_core_feature_tph_program(vdev, flags,
 							 arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
+		return vfio_pci_core_feature_tph_resolve(vdev, flags,
+							 arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index e8c66f3d1743..967f706f509e 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -14,6 +14,7 @@
 enum vfio_pci_tph_policy {
 	VFIO_PCI_TPH_POLICY_NO_ST = 0,
 	VFIO_PCI_TPH_POLICY_IV_ST,
+	VFIO_PCI_TPH_POLICY_DS_ST,
 };
 
 struct vfio_pci_ioeventfd {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 237af73909bf..1820bb20a460 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1573,6 +1573,9 @@ struct vfio_device_feature_zpci_err {
  *    device TPH hardware.
  * 5. Program steering tag (ST) table entries by VFIO_DEVICE_FEATURE_TPH_PROGRAM
  *    if the device has an architected ST table.
+ * 6. Query the ST value for a given CPU ID via VFIO_DEVICE_FEATURE_TPH_RESOLVE
+ *    for DS-ST capable devices, userspace may then configure the ST through
+ *    device MMIO or firmware interfaces.
  */
 #define VFIO_DEVICE_FEATURE_TPH			14
 
@@ -1594,6 +1597,10 @@ struct vfio_device_feature_tph {
  * for either volatile or persistent memory type.
  */
 #define VFIO_DEVICE_TPH_CAP_PROG_ST_CPU		(1u << 1)
+/*
+ * Supports resolving a steering tag (ST) from a CPU source handle.
+ */
+#define VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST	(1u << 2)
 
 /*
  * VFIO_DEVICE_FEATURE_TPH_PROGRAM - Batch program architected steering tag
@@ -1647,6 +1654,36 @@ struct vfio_device_feature_tph_program {
 /* Source holds a persistent memory CPU ID */
 #define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT	(1u << 4)
 
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
+ *         Note: only one source type is permitted (except SRC_NONE);
+ *               combining source type bits is rejected.
+ * @src:   IN - source identifier, e.g. CPU ID when SRC_CPU_VOLATILE is set
+ *         in flags
+ * @valid: OUT - bitmap indicating valid output fields, see
+ *         VFIO_DEVICE_TPH_VALID_*
+ * @rsv:   OUT - Reserved for future extension, kernel returns zero
+ * @st:    OUT - TPH steering tag (valid when VALID_ST is set in valid)
+ */
+#define VFIO_DEVICE_FEATURE_TPH_RESOLVE		16
+
+struct vfio_device_feature_tph_resolve {
+	__u32 flags;
+	__u32 src;
+	__u8  valid;
+#define VFIO_DEVICE_TPH_VALID_ST (1u << 0) /* st holds valid steering tag */
+	__u8  rsv;
+	__u16 st;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

