Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0E326D51;
	Thu,  7 May 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159410; cv=none; b=TLsHCQASITP/DRGb+k7+jRFEDMWD5RJ+eg5QWCMdPHcKxK5hqz+2htDhyfx61m82335G/+OU7Zm1uJhBIulwO1V8ga6WlunVWAkLpTxsW6DPmaJiObn7L7QgqsqndjPRVrM7zx6qty5LhPgLTT/+V4d3T+uTv38wABAJlgaFQbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159410; c=relaxed/simple;
	bh=eoQuYHkE2OXQuu+99uZaeoMZjEL53EEZKY0CAW3wF4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kk4P2MfSqxN6Ll6Ztw4gyXJbbADkhKe5zfPwvOAj3j+MmqATsOBShD6QWG379Ihn8K9tqrmqp4YA1OGx/IuELtBbA+RtJHKCu2sXq35oX2xKUXaJB8yL2Ru8o3m+S92KRaKuep6dTAlFcvGd5H3RRKWOcqYqme/LG+s7oGTTm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3/G0IB2U; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3/G0IB2U"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AxeMGtWG/Mi+0kyN1ZQqlFpbqYbsXmTyyvPav5gafVk=;
	b=3/G0IB2UG6D7abX1hrMovK3mnZapK1anCfRs3KmMXCur43jz38Fsbb+HyrW3WlSxJoBL0W3Vb
	TVB90I/etLdEKecAsg06DmT1IvxAgInESqb9r1ojV7AJbbH2Uw1jvXU3S8RPoNkZ+m8+pt3RKEk
	WGmaJYMkMAtBK4z7Shpl+KI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gBC8S26KNz1T4Fx;
	Thu,  7 May 2026 21:02:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EBBF40576;
	Thu,  7 May 2026 21:10:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 21:10:04 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v7 5/6] vfio/pci: Add PCIe TPH GET_ST interface
Date: Thu, 7 May 2026 21:09:55 +0800
Message-ID: <20260507130956.34441-6-fengchengwen@huawei.com>
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

Add support to batch get CPU steering tags for device-specific TPH mode
that does not implement an ST table. This interface requires enabling the
'enable_unsafe_tph_ds_mode' module parameter.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7a5dc2bfe2e9..c328515bcaaf 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1533,6 +1533,77 @@ static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
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
+	for (i = 0; i < st.count; i++) {
+		/* Check reserved fields and index are zero */
+		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
+		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1)) ||
+		    ents[i].index != 0) {
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
@@ -1551,6 +1622,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

