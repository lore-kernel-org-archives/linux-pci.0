Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F518238C3B;
	Sat, 25 Apr 2026 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777106788; cv=none; b=amnU8hC+cttJzN3kQ2OPfE8QhmRqwCC0RTHI3yBY9oEBvLFZusR/eeGsXIvAsc28xCk5PWlPZzcnTi2dtPlLSxswE8TMUmg+t9mllwERmb1umr0b9ez6tKWfbwAd4sz1iZ8nCr5JNCQFXCgQNuFgnIQIvPKvad1I/6kK1btRtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777106788; c=relaxed/simple;
	bh=dTn9CjFFUR8w6JoZehso5z1bMx2GEwVOEal0p41iHeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klOpC3t0hTBfvxa43CZzCieGdVFjQf8bfDEaB3wmy62w8Xr0XoUZ1tV+ZdkQLOzffXswEgVQORvIZ5PwpRV9QjE7jqvEE5C5YMq21nSxAjlVmJHTynJeqY/0GJLZIJjLyQhQ43FP5X3UrI1NGluxqdHF7SwFHv76NpbCwxMJz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ebUMR7Ha; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ebUMR7Ha"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6vlctb6Dqhexe1axdZtLQPCz99Brv/f8X/i4TJ92LHg=;
	b=ebUMR7HazhGRkQpF1i9xst4roxcpenjDZ+UNAsufUQ+OJPiBNUjCE+pi91Vttv+N6sDHaG5or
	SflxekL1JmjH0H4Dre++9aYjkKkjg1V2e13cCIQlskH/MtcUTNtv83li5BIpWJ6p7QxVMqvVb2a
	dU9AKWJLbpjcIm++vLNk8Vg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4g2jtV4q4Qzcb1P;
	Sat, 25 Apr 2026 16:39:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id EBC4C4056A;
	Sat, 25 Apr 2026 16:46:18 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Apr 2026 16:46:18 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v4 5/5] vfio/pci: Add PCIe TPH SET_ST interface
Date: Sat, 25 Apr 2026 16:46:07 +0800
Message-ID: <20260425084607.53825-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260425084607.53825-1-fengchengwen@huawei.com>
References: <20260425084607.53825-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add VFIO_PCI_TPH_SET_ST operation to support batch programming of steering
tag entries. If any entry fails, roll back successfully programmed entries
to 0 to prevent inconsistent device state.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 69 ++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 8f7a97dd922c..62ac27112145 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1579,6 +1579,73 @@ static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
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
@@ -1601,6 +1668,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

