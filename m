Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AF346FD2;
	Fri,  8 May 2026 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222472; cv=none; b=QuRk9pLlJjcdsRP2x7F49IE3LxdVEHSXttzTz2a5C0qKu5HWoh/X7LsKItSwIzASGO5Znl0Tp4mMYSUwL90QK8OnQG+8AjkQ+gCg26ZZ8nFtKykmKZ6anrdbQxI8yHXXEybfE1XbQ1DpJ/fTwSMIvLw7YaDVcTVorggXsf5TqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222472; c=relaxed/simple;
	bh=eRTzNOuDc7dat6s4hNmwZXsKyWASDNuahad7V9t5tdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEnTAIQ+zLFJo/o5Lq7OXJMZrGJ7rJjfdiF0rJiEsXMIHUl1R2BlKnERvTtpx0phWnOa1Q8z93RS/5Hb6haJziF8PTbNraAVomRJI3cdeAbBRt8YXQ8Hj3aD95PPJxy7fQ3XGuTLTt9QGHF9SaBleUmCc7HSuypWWdS+C5oVC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TRrGX/GE; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TRrGX/GE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fd2VDTjAdMqXsNa5cZTMm3EpBDW41poENzxMNDtCrgQ=;
	b=TRrGX/GE+CsDsW4tZKC1DrB2+RkHLxowLixpUOYPilkwQtsvKS2J1ZkKsyqdh44dkMBFYX7n3
	9684qmag0vOtlT9vSk6Jc73q1OsVEEr1QAtLFSVdITiP1EqdzP1vHHy8UySrPFcCKCIxsB0TGSQ
	MYwunOyy0IWtBQuwaVaUzDo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gBfT60xDJzLlX9;
	Fri,  8 May 2026 14:33:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BC6C40539;
	Fri,  8 May 2026 14:41:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 14:41:03 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v8 7/7] vfio/pci: Add PCIe TPH SET_ST interface
Date: Fri, 8 May 2026 14:40:53 +0800
Message-ID: <20260508064053.37529-8-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508064053.37529-1-fengchengwen@huawei.com>
References: <20260508064053.37529-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add VFIO_PCI_TPH_SET_ST operation to support batch programming of steering
tag entries. If any entry fails, roll back successfully programmed entries
to 0 to prevent inconsistent device state.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 90 ++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7ec2dd32f106..9e399696ce6e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1606,6 +1606,94 @@ static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
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
+	u32 tab_sz;
+	u16 st_val;
+
+	tab_sz = pcie_tph_get_st_table_size(pdev);
+	if (tab_sz == 0)
+		return -EOPNOTSUPP;
+
+	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, st))
+		return -EINVAL;
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
+		err = -EINVAL;
+
+		/* Check reserved fields and st are zero */
+		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
+		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1)) ||
+		    ents[i].st != 0)
+			goto out;
+
+		if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_VM)
+			mtype = TPH_MEM_TYPE_VM;
+		else if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_PM)
+			mtype = TPH_MEM_TYPE_PM;
+		else
+			goto out;
+
+		if (ents[i].index >= tab_sz)
+			goto out;
+
+		if (ents[i].cpu == U32_MAX) {
+			err = pcie_tph_set_st_entry(pdev, ents[i].index, 0);
+			if (err)
+				goto out;
+			continue;
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
@@ -1626,6 +1714,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

