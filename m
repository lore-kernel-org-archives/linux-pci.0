Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479A3F0750;
	Thu, 28 May 2026 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972424; cv=none; b=bKUVNgQ0gWrb/2A6paWVLX5MGBH+oGArPTUA/oZ0BWUUPlurZpdCSfRRpsycjauGOygDKWfgORmCvnrCDNNxJbA50VY88JXsRMw8f9l4XVo41+Ac8IVeufqrGhQkwbuN7jsw7JpKxwRumBVCTL58hXqr4F/JJPGeXkazal25srY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972424; c=relaxed/simple;
	bh=5zhRStugmFNVoJuor94meogTDR9DGsd22jYjFUxK3f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMdKN7g0HP0zvgofb7m43D0CYZ8SO1I2S63IxUMoFlvKwTZG9Uk/S5m7aL8r2/49uhwNW7UB9X9eeTHhsTsLzcOk70Spk05vg14wA3D7XEuWHkNqlrB3JFMnBu0KbwhzL8hnS42jsCrs9UejePM1VO3gHIbazrkAqvxPEmkX9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r1Xtv7Cf; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r1Xtv7Cf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=R9xRsQ4iF92MRcMPSTOC6McHLsOqyTCxq1ssaOr3D6E=;
	b=r1Xtv7CfxBKnrWp4bdkgP+b4w/L1EEiV9MmI1IVHr3XLo/FDLpvZAi/JdO+hvF0PQ97GCowwu
	eSNtvn1uHPBM9iLiXaOX/4LdtRN65N5j87txfSc79P2Naz3kAi53lfwCcvFdHimp+QwmS0TMLIf
	nRg2cxJIO39Vw8aSVR0w/WI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gR5ds0MK7z1cyVB;
	Thu, 28 May 2026 20:39:13 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 31ACE4055B;
	Thu, 28 May 2026 20:46:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 20:46:57 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v14 7/8] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_CPU_ST to query TPH steering tag
Date: Thu, 28 May 2026 20:46:48 +0800
Message-ID: <20260528124649.14732-8-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260528124649.14732-1-fengchengwen@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add read-only VFIO device feature TPH_CPU_ST for userspace to resolve
PCIe TPH Steering Tag by given CPU ID, memory type (VM/PM), and
TPH requester type (standard/extended).

Define compact flag bits to select memory type and requester type.
Implement batch query logic: input buffer carries CPU ID array, output
returns corresponding resolved ST tags.

Add strict sanity checks for flags, count and reserved fields.
The feature is gated by enable_unsafe_tph module parameter.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 64 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 29 +++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c9035c0acaf0..851e4d0828f2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1673,6 +1673,67 @@ static int vfio_pci_core_feature_tph_st_config(
 	return ret;
 }
 
+static int vfio_pci_core_feature_tph_cpu_st(struct vfio_pci_core_device *vdev,
+			u32 flags,
+			struct vfio_device_feature_tph_cpu_st __user *arg,
+			size_t argsz)
+{
+	struct vfio_device_feature_tph_cpu_st cpu_st;
+	struct pci_dev *pdev = vdev->pdev;
+	enum tph_req_policy policy;
+	enum tph_mem_type mtype;
+	void __user *uptr;
+	int i, ret;
+	u32 *cpus;
+	u16 *sts;
+	u16 st;
+
+	if (!enable_unsafe_tph)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz,
+				 VFIO_DEVICE_FEATURE_GET |
+				 VFIO_DEVICE_FEATURE_PROBE,
+				 sizeof(cpu_st));
+	if (ret <= 0)
+		return ret;
+
+	if (copy_from_user(&cpu_st, arg, sizeof(cpu_st)))
+		return -EFAULT;
+
+	if (cpu_st.flags & ~(VFIO_TPH_CPU_ST_MEM_TYPE_MASK |
+			     VFIO_TPH_CPU_ST_REQ_TYPE_MASK) ||
+		cpu_st.count == 0 || cpu_st.count > nr_cpu_ids ||
+		cpu_st.reserved != 0)
+		return -EINVAL;
+
+	uptr = u64_to_user_ptr(cpu_st.data_uptr);
+	cpus = memdup_array_user(uptr, cpu_st.count, sizeof(u32));
+	if (IS_ERR(cpus))
+		return PTR_ERR(cpus);
+
+	mtype = (cpu_st.flags & VFIO_TPH_CPU_ST_MEM_TYPE_MASK) ==
+		VFIO_TPH_CPU_ST_MEM_TYPE_VM ? TPH_MEM_TYPE_VM : TPH_MEM_TYPE_PM;
+	policy = (cpu_st.flags & VFIO_TPH_CPU_ST_REQ_TYPE_MASK) ==
+		VFIO_TPH_CPU_ST_REQ_STANDARD ?
+		TPH_REQ_STANDARD : TPH_REQ_EXTENDED;
+	sts = (u16 *)cpus;
+	for (i = 0; i < cpu_st.count; i++) {
+		ret = pcie_tph_get_cpu_st(pdev, mtype, policy, cpus[i], &st);
+		if (ret)
+			goto out;
+		sts[i] = st;
+	}
+
+	ret = copy_to_user(uptr, sts, cpu_st.count * sizeof(u16));
+	if (ret)
+		ret = -EFAULT;
+
+out:
+	kfree(cpus);
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1694,6 +1755,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	case VFIO_DEVICE_FEATURE_TPH_ST_CONFIG:
 		return vfio_pci_core_feature_tph_st_config(vdev, flags,
 							   arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_CPU_ST:
+		return vfio_pci_core_feature_tph_cpu_st(vdev, flags,
+							arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 07d8cce6ef32..027b2d553ddb 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1554,6 +1554,35 @@ struct vfio_device_feature_tph_st_config {
 	__aligned_u64 data_uptr;
 };
 
+/**
+ * VFIO_DEVICE_FEATURE_TPH_CPU_ST - Query TPH ST by CPU, mem and requester type
+ *
+ * Read-only interface to resolve Steering Tag using:
+ *  - CPU ID
+ *  - Memory type (volatile / persistent)
+ *  - TPH requested type (standard 8-bit / extended 16-bit)
+ *
+ * @flags: bit0 - memory type, bit1 - TPH requester type
+ * @count: Number of CPU IDs to query consecutively
+ * @data_uptr: Userspace buffer: [in] u32 cpu_id array, [out] u16 st_tag array
+ *
+ * This feature is gated by enable_unsafe_tph module parameter.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_CPU_ST		14
+
+struct vfio_device_feature_tph_cpu_st {
+	__u32 flags;
+#define VFIO_TPH_CPU_ST_MEM_TYPE_MASK	1u
+#define VFIO_TPH_CPU_ST_MEM_TYPE_VM	(0u << 0)
+#define VFIO_TPH_CPU_ST_MEM_TYPE_PM	(1u << 0)
+#define VFIO_TPH_CPU_ST_REQ_TYPE_MASK	(1u << 1)
+#define VFIO_TPH_CPU_ST_REQ_STANDARD	(0u << 1)
+#define VFIO_TPH_CPU_ST_REQ_EXTENDED	(1u << 1)
+	__u16 count;
+	__u16 reserved; /* Reserved for future use, must be zero */
+	__aligned_u64 data_uptr;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

