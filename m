Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6537B010;
	Mon, 27 Apr 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280337; cv=none; b=EkWKcQ6xeV0NIBpGdOygNCgd+nCoX3eCAk9AyO3mhTMWI6XBEe/zEm7W8bMV6lox4QoV0DPTDq9ovGILRkbFYRUyMjsVm39Xvp4uxYFLRHHV5l/o2Ki9Kb10U+SV5JEGi3bYMEhyS7JawY68a9wxhcuENlfir3tEPJs9xJ9F1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280337; c=relaxed/simple;
	bh=B4xP1nASZE1lJo4YAG7+9SlC4V8hBfgKLeZI0EBHwBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxMy9hB6l9OixT2tHCP8jxFiNdh0RcyAbV+4Iwm1B1tCJXcb9GlWpUqek8KoLgguWDT6tF0hZgLWgTaHoNr/o2GB8+M8FAtqxK1T7CE99vhIH4OVaNPOagCBpfjXqOElixoPbK3iCI1RURnk/QThmQO2u2wm4olxCxvCh4jYAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pOwat17Z; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pOwat17Z"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3R/BxHHU4J62+36jSepX3Ydb/Fo25muF/n8trGqeomA=;
	b=pOwat17ZMhYtv81VrQtYrg8/ucy0vQgaIZegTOtHNbr228wuapqv5fADq7Zdkw226YohRdgnB
	xzfsOufCD+4Dl/+Yn2/nlmlUp6Yzj8lsrwlXsocUvNBQaizCpXndYBmphpoAi3i9Cf6B/ToKGPT
	yUy/Qy3BZYLVz/RjxMEAC0A=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4g3y4V522rzLlSv;
	Mon, 27 Apr 2026 16:52:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 980C44056E;
	Mon, 27 Apr 2026 16:58:51 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 16:58:51 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 5/6] vfio/pci: Add PCIe TPH GET_ST interface
Date: Mon, 27 Apr 2026 16:58:42 +0800
Message-ID: <20260427085843.42460-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260427085843.42460-1-fengchengwen@huawei.com>
References: <20260427085843.42460-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add support to batch get CPU steering tags for device-specific TPH mode
that does not implement an ST table. This interface requires enabling the
'enable_unsafe_tph_ds_mode' module parameter.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d1f7f2933e66..74596ef278b5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1531,6 +1531,61 @@ static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
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
+	size_t size;
+	int i, err;
+
+	if (!enable_unsafe_tph_ds_mode ||
+		pcie_tph_get_st_table_loc(pdev) != PCI_TPH_LOC_NONE)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&st, uarg, sizeof(st)))
+		return -EFAULT;
+
+	if (!st.count || st.count > VFIO_PCI_TPH_MAX_ENTRIES)
+		return -EINVAL;
+
+	size = st.count * sizeof(*ents);
+	ents = kvmalloc(size, GFP_KERNEL);
+	if (!ents)
+		return -ENOMEM;
+
+	if (copy_from_user(ents, uarg + sizeof(st), size)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	for (i = 0; i < st.count; i++) {
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
+	if (copy_to_user(uarg + sizeof(st), ents, size))
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
@@ -1551,6 +1606,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

