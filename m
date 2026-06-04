Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046F47F2EB;
	Thu,  4 Jun 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579699; cv=none; b=tpLORejii0klN83/wSVeNd01AHVoVmDM2C5zApRUm51MyyiSrl1SQ4HFnj6PhgZy3t6kfMGDPtL8wOiaMkIcTL9cgsoarFj5+rHYKfrinw56xGR823mZfBF7Gl6Am6Tz76kFMNYkdD2JLSiPpVYPYJ71hi3578M09rcCq8EJh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579699; c=relaxed/simple;
	bh=+lT2PLheMz0vA3Q43IQJQh0Dfgv++nFvwC5X13KZgD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qukq1Lh2Texp+pFRmHTYNzOT4wzGE7/0BrtOcqL1/0vdt+VLLe0OaRq/YZpCDpt1J5v2n/UExG4IrLDd8IdT1nijrqRlbE9X5L4UrqezKhkf1kbZZbT/dlG0zyhShtUlBcHZoliCbJQ7SSIe9MVpRHnENM8p6qBl7rTcqGZCkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zm95gPlr; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zm95gPlr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ixSP1lnXVVLECCGBLS/UAeH8g22V0UZfjH234Po6tYg=;
	b=zm95gPlr1VJ035GgIH9t7cinOZwGtzjsHW45zKg/WPBjKTp2NO1zPh+Lo9Q6PITTlm33U3Jc6
	5euijuk1KBDH51jdgJ8eMKhQAz/lT4kYGXReYiExKBr6O2x3imqjgyEXWkh0hIfZEnlKyUpNc/5
	6MdO91/ywpdxouJ+rsMKGbM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWQD61qwCznTWY;
	Thu,  4 Jun 2026 21:20:22 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id AC890402AB;
	Thu,  4 Jun 2026 21:28:14 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 21:28:14 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v16 10/12] vfio/pci: Add TPH_CPU_ST to query CPU's TPH steering tag
Date: Thu, 4 Jun 2026 21:28:02 +0800
Message-ID: <20260604132804.28678-11-fengchengwen@huawei.com>
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

Add read-only VFIO device feature TPH_CPU_ST for userspace to resolve
PCIe TPH Steering Tag by given CPU ID, memory type (VM/PM), and
TPH requester type (standard/extended).

Define compact flag bits to select memory type and requester type.
Implement batch query logic: input buffer carries CPU ID array, output
returns corresponding resolved ST tags.

Add strict sanity checks for flags, count and reserved fields.
The feature is double gated:
1. Global enable_unsafe_tph module parameter must be enabled;
2. Userspace needs to firstly SET VFIO_DEVICE_FEATURE_TPH_ENABLE
   to set per-device tph_permit flag before using TPH_CPU_ST.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 70 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 31 ++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d5e534dd5829..91c0737727f2 100644
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
@@ -1570,6 +1571,72 @@ static int vfio_pci_core_feature_tph_enable(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_core_feature_tph_cpu_st(struct vfio_pci_core_device *vdev,
+			u32 flags,
+			struct vfio_device_feature_tph_cpu_st __user *arg,
+			size_t argsz)
+{
+	struct vfio_device_feature_tph_cpu_st cpu_st;
+	struct pci_dev *pdev = vdev->pdev;
+	enum tph_mem_type mtype;
+	void __user *uptr;
+	bool extended;
+	int i, ret;
+	u32 *cpus;
+	u16 *sts;
+	u16 st;
+
+	if (!vdev->tph_permit)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
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
+	sts = kcalloc(cpu_st.count, sizeof(u16), GFP_KERNEL);
+	if (!sts) {
+		ret = -ENOMEM;
+		goto out_free_cpus;
+	}
+
+	mtype = (cpu_st.flags & VFIO_TPH_CPU_ST_MEM_TYPE_MASK) ==
+		VFIO_TPH_CPU_ST_MEM_TYPE_VM ? TPH_MEM_TYPE_VM : TPH_MEM_TYPE_PM;
+	extended = !!(cpu_st.flags & VFIO_TPH_CPU_ST_REQ_TYPE_MASK);
+
+	for (i = 0; i < cpu_st.count; i++) {
+		ret = pcie_tph_get_cpu_st_explicit(pdev, mtype, extended,
+						   cpus[i], &st);
+		if (ret)
+			goto out_free_sts;
+		sts[i] = st;
+	}
+
+	ret = copy_to_user(uptr, sts, cpu_st.count * sizeof(u16));
+	if (ret)
+		ret = -EFAULT;
+
+out_free_sts:
+	kfree(sts);
+out_free_cpus:
+	kfree(cpus);
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1590,6 +1657,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_TPH_ENABLE:
 		return vfio_pci_core_feature_tph_enable(vdev, flags, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_CPU_ST:
+		return vfio_pci_core_feature_tph_cpu_st(vdev, flags,
+							arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e5a4d1d7091b..19b5fb7eeae6 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1541,6 +1541,37 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_TPH_ENABLE	13
 
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
+ * This feature requires two preconditions:
+ * 1. Global enable_unsafe_tph module parameter is enabled;
+ * 2. VFIO_DEVICE_FEATURE_TPH_ENABLE has been SET on the device beforehand.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_CPU_ST	14
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

