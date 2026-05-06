Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7873EDAB5;
	Wed,  6 May 2026 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060802; cv=none; b=SQoIdRoLs8Ag/kBSSmmS/X4oPpBRnKsjjCadjtIHciKqrs8V9WfDuGtLvaVbcUh3fwyeBJKNXaBUntONEiL/0Oiq5fwWig1B+/iuCppYmdO4U18yS4J2oYjy9AiTvgjX5e3EcD29L+i7EPBaiMtZ2RNfoznqzt4v136nnEM9dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060802; c=relaxed/simple;
	bh=pygMa5I//KSnoK80Y+0TjGAx2wt0LgrAhzd2gwuSrIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQ+YWekC1tV0sFZjcOFxX2S+nSlTYSIUsukHMSv23IW2w1twc1+5PLPIayPfM3OISbcNkImteG7hblAAcu5i2uxzX31S3+6LrQkBIf5dWEeElcpS3AhewCgKbk7xuY/RCHRuUUBNRpcSGziGdhxhDQkn8CWsLp8jnzH7Amuk+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y2r81NhL; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y2r81NhL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3oyR+IlAxrYWgN6pagdRZkSeokVs2EmzHjMocpvrH54=;
	b=y2r81NhLofOoljX5Zuq99KzEFlKp0j8+L+CLmL+9BXGuRh1Go/UU7g+GqlXE9X0gVYtgo9uwE
	XNnOflbSAPuLlXCU4jEe1A/T2DQDRmFvfpW0OHAklY2uuxs2KGKdu93lJsqBnApmqnMK0+t6dM0
	1lOeea0xO+0xIrSnfYH1c5s=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4g9Vh41cPLzLlTq;
	Wed,  6 May 2026 17:39:00 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 930344048B;
	Wed,  6 May 2026 17:46:32 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 17:46:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v6 5/6] vfio/pci: Add PCIe TPH GET_ST interface
Date: Wed, 6 May 2026 17:46:22 +0800
Message-ID: <20260506094623.29327-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506094623.29327-1-fengchengwen@huawei.com>
References: <20260506094623.29327-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add support to batch get CPU steering tags for device-specific TPH mode
that does not implement an ST table. This interface requires enabling the
'enable_unsafe_tph_ds_mode' module parameter.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 69f666d20c4a..45e641ab2a88 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1529,6 +1529,77 @@ static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
 	return 0;
 }
 
+static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
+			       struct vfio_device_pci_tph_op *op,
+			       void __user *uarg)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_tph_entry *ents;
+	struct vfio_pci_tph_st st;
+	enum tph_mem_type mtype;
+	size_t size, ents_off;
+	int i, err;
+
+	if (!enable_unsafe_tph_ds_mode ||
+		pcie_tph_get_st_table_loc(pdev) != PCI_TPH_LOC_NONE)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&st, uarg, sizeof(st)))
+		return -EFAULT;
+
+	/* Check reserved fields are zero */
+	if (memchr_inv(&st.reserved, 0, sizeof(st.reserved)))
+		return -EINVAL;
+
+	if (!st.count || st.count > VFIO_PCI_TPH_MAX_ENTRIES)
+		return -EINVAL;
+
+	size = st.count * sizeof(*ents);
+	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, st) +
+			sizeof(struct vfio_pci_tph_st) + size)
+		return -EINVAL;
+
+	ents = kvmalloc(size, GFP_KERNEL);
+	if (!ents)
+		return -ENOMEM;
+
+	ents_off = offsetof(struct vfio_pci_tph_st, ents);
+	if (copy_from_user(ents, uarg + ents_off, size)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	for (i = 0; i < st.count; i++) {
+		/* Check reserved fields are zero */
+		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
+		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1))) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_VM) {
+			mtype = TPH_MEM_TYPE_VM;
+		} else if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_PM) {
+			mtype = TPH_MEM_TYPE_PM;
+		} else {
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = pcie_tph_get_cpu_st(pdev, mtype, ents[i].cpu,
+					  &ents[i].st);
+		if (err)
+			goto out;
+	}
+
+	if (copy_to_user(uarg + ents_off, ents, size))
+		err = -EFAULT;
+
+out:
+	kvfree(ents);
+	return err;
+}
+
 static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 			      void __user *uarg)
 {
@@ -1545,6 +1616,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
 	case VFIO_PCI_TPH_DISABLE:
 		return vfio_pci_tph_disable(vdev);
+	case VFIO_PCI_TPH_GET_ST:
+		return vfio_pci_tph_get_st(vdev, &op, uarg + minsz);
 	default:
 		/* Other ops are not implemented yet */
 		return -EINVAL;
-- 
2.17.1

