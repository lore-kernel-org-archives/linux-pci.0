Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106F3368A9;
	Thu,  7 May 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159411; cv=none; b=a/9MPK43plu9Z6lH2fhHbTp+2EBOci7Rdc68gGoIZ3VMzzsF+KernCsLDzSlOUUIuHti0V2R8vxXh6plvJek/XWLGvlhHCwl61xOuHsmTOav1UB5eDpaOfr8RushfmXpk7sJFj9arRko11UqYhkeXZGk6+6yCtutWn7eMaVZ9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159411; c=relaxed/simple;
	bh=EUSxfqDRLIRqh25Uhr9CTEtsDZMXLOuUf9vz9GTIMIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlNpFrDU98D6I+xP7x4MfGdYtUMHm8xw2nf3WvvYvetf/Bro1paJK2rfnvNei1p8fG5s6gEHNw9gxaXaivAbWYb50e3vdKjyyF3c3p49jb0xSmRsX51jBW+pIjUSpCOPICtDS27iGFTwb7QoViw35Sv+qbczz50Z6A7K4PIQ7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W8MDQEuV; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W8MDQEuV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aSia3iU4Hu+vlUhVlUycg5jBN8bZp6kVAbHOBZUD7bM=;
	b=W8MDQEuVe2kX1qqboRikwtqB88tYknHAWv47kX6z71YUOIBdj82ZEam+47FJ2IjXdeAzoEEEW
	mzQa2BWxXhpzz5DZfmdK9iB7ZejlDBB22hKlTsHBIgXWyLoitqdQA6JnjqplMvJm9tWiGNopg4c
	hbTi3kamxWJnTvA65of7H9w=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gBC8T4z8yz1K970;
	Thu,  7 May 2026 21:02:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id CC9C34055B;
	Thu,  7 May 2026 21:10:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 21:10:05 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v7 6/6] vfio/pci: Add PCIe TPH SET_ST interface
Date: Thu, 7 May 2026 21:09:56 +0800
Message-ID: <20260507130956.34441-7-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260507130956.34441-1-fengchengwen@huawei.com>
References: <20260507130956.34441-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add VFIO_PCI_TPH_SET_ST operation to support batch programming of steering
tag entries. If any entry fails, roll back successfully programmed entries
to 0 to prevent inconsistent device state.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c328515bcaaf..5d10de546d5c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1604,6 +1604,90 @@ static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
 	return err;
 }
 
+static int vfio_pci_tph_set_st(struct vfio_pci_core_device *vdev,
+			       struct vfio_device_pci_tph_op *op,
+			       void __user *uarg)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_tph_entry *ents;
+	struct vfio_pci_tph_st st;
+	enum tph_mem_type mtype;
+	size_t size, ents_off;
+	int i = 0, j, err;
+	u32 tab_loc;
+	u16 st_val;
+
+	tab_loc = pcie_tph_get_st_table_loc(pdev);
+	if (tab_loc != PCI_TPH_LOC_CAP && tab_loc != PCI_TPH_LOC_MSIX)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&st, uarg, sizeof(st)))
+		return -EFAULT;
+
+	if (!st.count || st.count > VFIO_PCI_TPH_MAX_ENTRIES)
+		return -EINVAL;
+
+	/* Check reserved fields are zero */
+	if (memchr_inv(&st.reserved, 0, sizeof(st.reserved)))
+		return -EINVAL;
+
+	size = st.count * sizeof(*ents);
+	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, st) + size)
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
+	for (; i < st.count; i++) {
+		/* Check reserved fields and st are zero */
+		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
+		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1)) ||
+		    ents[i].st != 0) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (ents[i].cpu == U32_MAX) {
+			err = pcie_tph_set_st_entry(pdev, ents[i].index, 0);
+			if (err)
+				goto out;
+			continue;
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
+		err = pcie_tph_get_cpu_st(pdev, mtype, ents[i].cpu, &st_val);
+		if (err)
+			goto out;
+		err = pcie_tph_set_st_entry(pdev, ents[i].index, st_val);
+		if (err)
+			goto out;
+	}
+
+out:
+	if (err) {
+		/* Roll back previously programmed entries to 0 */
+		for (j = 0; j < i; j++)
+			pcie_tph_set_st_entry(pdev, ents[j].index, 0);
+	}
+	kvfree(ents);
+	return err;
+}
+
 static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 			      void __user *uarg)
 {
@@ -1624,6 +1708,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 		return vfio_pci_tph_disable(vdev);
 	case VFIO_PCI_TPH_GET_ST:
 		return vfio_pci_tph_get_st(vdev, &op, uarg + minsz);
+	case VFIO_PCI_TPH_SET_ST:
+		return vfio_pci_tph_set_st(vdev, &op, uarg + minsz);
 	default:
 		/* Other ops are not implemented yet */
 		return -EINVAL;
-- 
2.17.1

