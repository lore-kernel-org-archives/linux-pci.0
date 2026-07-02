Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735448BD44;
	Thu,  2 Jul 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996164; cv=none; b=j56ohl6kPqqUSJQh2IWHIMOMjmEDjDJu0VDKjkL1JOdTd03BqW2CpoPnG6K3Q9JIQp0RHm0omBzs9jFN0DdO6WrkKaVo2Xe3ijF/6xkZxQ8eXt0v1wF8oXSl6bABllUJJW7I3Ve0Je9FjcLxk+TZpXdsKimqFze30gbLZGRCZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996164; c=relaxed/simple;
	bh=EQx6GxDLltGplUH6deLZLiY1SWYkmzr0hw3zui7b1mQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0G4MKkWPqHAacUAzWpa9zPm41epj03P5My7KdLxvhd8pRV07A89Qq2YLsdVbysrXPcLTC+i9uMsZB3/cVqoY0h6FtUP1kiNa+DUdzdpfEXlWkVIc1H4L+bUqG+8zww7/6LpDQMJEu8QrpCCLlIEMhFMl3DuzsfLVH2DLEjqPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lLvWmOcB; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lLvWmOcB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ctatKSAAUJhzk8hrtfFFzluIZUC3dmFPQ8VtupcVKhE=;
	b=lLvWmOcBpl4sf4eCpmIioswiFIaYYsXCim4vUrTTUbzVdvnCjWCKCLObETCQbjcsS1i3+1cUx
	IBRCvZjgOpqeBD7riBZMjzHA3Rr3yBiPabBOkERZaRvRlUlg7vyp5dVCPRw0G7DowkAJRQK6RKd
	tcwQKGlzhoEwlrmtwEp98hE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4grbsc4syvz12LDQ;
	Thu,  2 Jul 2026 20:33:56 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 37C832012A;
	Thu,  2 Jul 2026 20:42:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 16/18] vfio/pci: Implement TPH_ST feature for batch ST table programming
Date: Thu, 2 Jul 2026 20:42:22 +0800
Message-ID: <20260702124224.57168-17-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Add vfio_pci_core_feature_tph_st() to implement the SET-only
VFIO_DEVICE_FEATURE_TPH_ST uAPI for batch TPH ST table programming.

Implement helper routines to calculate ST table size and resolve ST tags
from multiple sources: NONE, DMABUF, CPU volatile/persistent, and LITERAL.

Batch program contiguous ST table entries according to user inputs, support
stop-on-zero-ST semantics, and return the number of successfully written
entries. Hold memory_lock and ensure device is in D0 state during hardware
operations.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 119 +++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ed6bbffa8b26..7251e251824a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1713,6 +1713,123 @@ static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
 	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
 }
 
+static u32 tph_calc_st_size(struct vfio_pci_core_device *vdev)
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
+static int tph_get_st_tag(struct pci_dev *pdev, u32 src_bits, u32 src_hndl,
+			  bool extended, u16 *tag)
+{
+	int ret = 0;
+	u8 ph;
+
+	if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
+		*tag = 0;
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF)
+		ret = vfio_pci_dma_buf_get_tph_by_fd(src_hndl, extended,
+						     tag, &ph);
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
+		ret = pcie_tph_get_cpu_st_explicit(pdev, TPH_MEM_TYPE_VM,
+					extended, src_hndl, tag);
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
+		ret = pcie_tph_get_cpu_st_explicit(pdev, TPH_MEM_TYPE_PM,
+					extended, src_hndl, tag);
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_LITERAL)
+		*tag = src_hndl;
+
+	if (ret != 0)
+		*tag = 0;
+
+	return ret;
+}
+
+static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
+				u32 flags,
+				struct vfio_device_feature_tph_st __user *arg,
+				size_t argsz)
+{
+	u32 permit_flags = VFIO_DEVICE_TPH_SRC_MASK | VFIO_DEVICE_TPH_EXTENDED;
+	struct vfio_device_feature_tph_st tph_st = {0};
+	struct pci_dev *pdev = vdev->pdev;
+	u32 src_bits, st_size;
+	bool stop_on_zero_st;
+	u32 *src_hndl = NULL;
+	void __user *uptr;
+	bool extended;
+	int ret, i;
+	u16 tag;
+
+	if (!vdev->tph_permit || vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST)
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(tph_st));
+	if (ret <= 0)
+		return ret;
+
+	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
+		return -EFAULT;
+
+	src_bits = tph_st.flags & VFIO_DEVICE_TPH_SRC_MASK;
+	if (vdev->tph_policy != VFIO_PCI_TPH_POLICY_LITERAL)
+		permit_flags &= ~VFIO_DEVICE_TPH_SRC_LITERAL;
+	if (!(tph_st.flags & permit_flags) || !is_power_of_2(src_bits))
+		return -EINVAL;
+	extended = !!(tph_st.flags & VFIO_DEVICE_TPH_EXTENDED);
+	if (extended && !pcie_tph_supported(vdev->pdev, true))
+		return -EINVAL;
+
+	st_size = tph_calc_st_size(vdev);
+	if (tph_st.start >= st_size || tph_st.count > st_size - tph_st.start ||
+		tph_st.count == 0)
+		return -EINVAL;
+
+	uptr = u64_to_user_ptr(tph_st.dests);
+	if (!(src_bits & VFIO_DEVICE_TPH_SRC_NONE)) {
+		src_hndl = memdup_array_user(uptr, tph_st.count, sizeof(u32));
+		if (IS_ERR(src_hndl))
+			return PTR_ERR(src_hndl);
+	}
+
+	down_write(&vdev->memory_lock);
+	ret = vfio_pci_set_power_state(vdev, PCI_D0);
+	if (ret)
+		goto out;
+
+	stop_on_zero_st = !!(tph_st.flags & VFIO_DEVICE_TPH_REQUIRE_ST);
+	if (tph_st.flags & VFIO_DEVICE_TPH_SRC_NONE)
+		stop_on_zero_st = false;
+	for (i = 0; i < tph_st.count; i++) {
+		ret = tph_get_st_tag(pdev, src_bits, src_hndl ? src_hndl[i] : 0,
+				     extended, &tag);
+		if (ret || (stop_on_zero_st && tag == 0))
+			break;
+		ret = pcie_tph_set_st_entry(pdev, tph_st.start + i, tag);
+		if (ret)
+			break;
+	}
+	ret = i;
+
+out:
+	up_write(&vdev->memory_lock);
+	kfree(src_hndl);
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1736,6 +1853,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
 		return vfio_pci_core_feature_tph_resolve(vdev, flags,
 							 arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_ST:
+		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
-- 
2.17.1

