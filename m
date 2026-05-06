Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FE3EC2E0;
	Wed,  6 May 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060796; cv=none; b=LXPYoNaafcWsn2Nrri7gtaSgfWi45CxL+3dNRem41A9PTG9oOp7M9GBR1s9v3Efl3pqIh2CHRCVFaJ3Qo2IkQJ2Bd99ZTP6LyLa6zHr2B4JS1l0eNUjSZb8gNxuYCud1x9Aa8hcWxaEBmmZSbM9cTlGy3VgxCkalDgXMJKz+ugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060796; c=relaxed/simple;
	bh=WsOIECMjZHArg93ZhDA7Q1Pqj/DC1q0aPGMD5VerzOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EI7Y27eDj8JjDxDM9UI1OV5kKtZjnHhJJYSOqssURsX583NDc+FOntm+zvN/5lXoDw4FeLmsmsQ2BINIfVLt61UT1asGDZtAZXoX0F8x4N4xeHPb5H8zgAOoleU944HKmSbjnT+Rnpv14Hce0FDLMQAoanABqyQNgU4ErSqNSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=M65/ug89; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="M65/ug89"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x8UZ9NZJFRwtYskhmwUWiRqPY8vaq2K0ttl4pxpMomU=;
	b=M65/ug89S/D/Z3Dw+aPjBWtaEWfYojqgSYpvzEQFu9CNXjEusPAQvdHHcKTCWXl6fsSrrjjDl
	2AHTZUkhoSpVFrxfGDbanvVI9aAyUCaLV4MvSv0BbKu9TZdSdGHrswYb+05J0x+r81Hha3bNkOW
	+wqoNAs/Z/068nJ1I7Cgo7I=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g9VhZ1X16znTV8;
	Wed,  6 May 2026 17:39:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 05220402AB;
	Wed,  6 May 2026 17:46:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 17:46:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v6 6/6] vfio/pci: Add PCIe TPH SET_ST interface
Date: Wed, 6 May 2026 17:46:23 +0800
Message-ID: <20260506094623.29327-7-fengchengwen@huawei.com>
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

Add VFIO_PCI_TPH_SET_ST operation to support batch programming of steering
tag entries. If any entry fails, roll back successfully programmed entries
to 0 to prevent inconsistent device state.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 45e641ab2a88..867d8694b56b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1600,6 +1600,90 @@ static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
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
+	for (; i < st.count; i++) {
+		/* Check reserved fields are zero */
+		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
+		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1))) {
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
@@ -1618,6 +1702,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

