Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93676399351;
	Thu, 16 Apr 2026 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331286; cv=none; b=aF11GgEgyzhKZpI69bf+hrfG4GWW75bi5zf9LX/MJGh2iVHagK4Ce0mNWIELh53x3bEqe8bpqnsHYg504IGN5F1kRZehZxZYPfzYzQ5k5xQ/i7PCW7MeCc3c9Is6zpMoideka/BgJKetqgfYYKc7Syd/enVXxTRZ31yXWA5Hip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331286; c=relaxed/simple;
	bh=0ZzbJT9E7RzYbJf0gsVuCsMfn7oF4dp4mRbLQzvfCLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJdcZtM/Anag93885NaO2ba+HuyQ5DVWPtCILUk7/yWTtclHKKuKNDe4wqybMe1PSy3Nn5x0bqr4gkz7lGs4BT2R3w3/STM/HOa/jnkwgVkrrwhZnww5gJ1GXaMpZ/G8mr97kOCpGDheUWL31kCp72x898KqXFgCtXiRjJCq/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N3ntHYJQ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N3ntHYJQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JONQT9FvTITi5XQlpu8B8lVau6UcBkWaHsfbZNCrC0A=;
	b=N3ntHYJQ7RsL7c+9G8we7kox2G8l1nJSubkqcVGq80uFh6bbZ6khFE4GgehAWqWlVvKxP42Jl
	mmBrgRya5JJjA1ENiwK1+Edbi5XOx0OjuYMgSfDA0dg4AWPqCCQcisau95QPxIeapl9fm+9992O
	03QI7YpEhlrhXQO7ITm+mGQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fxC5q34Bkz1T4G8;
	Thu, 16 Apr 2026 17:15:11 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7897D40537;
	Thu, 16 Apr 2026 17:21:13 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:21:12 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 5/5] vfio/pci: Add PCIe TPH SET_ST interface
Date: Thu, 16 Apr 2026 17:21:05 +0800
Message-ID: <20260416092105.41439-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260416092105.41439-1-fengchengwen@huawei.com>
References: <20260416092105.41439-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add VFIO_PCI_TPH_SET_ST operation to support batch programming
of steering tag entries. If any entry fails, all previously
programmed entries are rolled back to 0 to avoid partial
device state.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a036e7d795be..35b8849ecf39 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1573,6 +1573,75 @@ static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
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
+	int i = 0, j, err, size;
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
+	for (; i < st.count; i++) {
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
+		for (j = 0; j < i; j++) {
+			if (ents[j].cpu != U32_MAX)
+				pcie_tph_set_st_entry(pdev, ents[j].index, 0);
+		}
+	}
+	kvfree(ents);
+	return err;
+}
+
 static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 			      void __user *uarg)
 {
@@ -1595,6 +1664,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

