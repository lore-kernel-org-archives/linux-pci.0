Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97835C193;
	Fri,  8 May 2026 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222481; cv=none; b=FR877RHW6aAVksjFLlJlX+oRErPsYD3N1HQvN+wvpQew7jCqvoiH06bnFjDOCW3mUyIIXmR3tWc0FEQUSjaLDGE8dUA4u2LqGODjB8TDNwGwaCawZkEfs7F6VefCP7p6ttmACT3gpRBbNl3sYXY1CAwsAB2NAs3KWRYLvzjjzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222481; c=relaxed/simple;
	bh=j4cHPBKtXYs54un//PYC2+Gxn+fyCLRJFo230/dYNLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMQWXYe8lj31xutaWo7KFkha0TGiA7zizu1Ts/c8yDe6aiMwxbcxUaAgIaHO6buV3uSnkOu/G/C12YjHEgeATH/3yAmImN8kMplfzBr9SgzBuO9f/zrHodRLunswvvlgHlBFr3w2ubcYTCkrX/K+tSJ+vxDNFxPHAcMPYHJkFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GBoMvK3a; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GBoMvK3a"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IIuHlm7qBrJL/uqB9uceN+lcTcvXUlghQgn++6PXji0=;
	b=GBoMvK3ab6tcwwx/EtXEfkzlVLQVvAdi4pHDHvvLu+ydK0XN0iQuu78fEn+AdAU4BjTBOZqIv
	C9bSdhItejnSt1huSNNYPngtoHugOdyPSR3/dIBjkAufLXaCdcAhtg1Rr8KjadfYcgZSStIUVtS
	aCEdn2MeO+W85Mq5QBjpNaw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gBfT64PLRz1cyPS;
	Fri,  8 May 2026 14:33:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 42EBC40539;
	Fri,  8 May 2026 14:41:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 14:41:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v8 6/7] vfio/pci: Add PCIe TPH GET_ST interface
Date: Fri, 8 May 2026 14:40:52 +0800
Message-ID: <20260508064053.37529-7-fengchengwen@huawei.com>
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

Add support to batch get CPU steering tags for device-specific TPH mode.
This interface requires enabling the 'enable_unsafe_tph_ds_mode' module
parameter.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index bfc7e87d190f..7ec2dd32f106 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1532,6 +1532,80 @@ static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
 	return 0;
 }
 
+static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
+			       struct vfio_device_pci_tph_op *op,
+			       void __user *uarg)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u8 mode = pcie_tph_get_st_modes(pdev);
+	struct vfio_pci_tph_entry *ents;
+	struct vfio_pci_tph_st st;
+	enum tph_mem_type mtype;
+	size_t size, ents_off;
+	int i, err;
+
+	if (!enable_unsafe_tph_ds_mode || !(mode & PCI_TPH_CAP_ST_DS))
+		return -EOPNOTSUPP;
+
+	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, st))
+		return -EINVAL;
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
@@ -1550,6 +1624,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

