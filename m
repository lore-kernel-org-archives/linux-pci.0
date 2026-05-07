Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591037A48A;
	Thu,  7 May 2026 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159410; cv=none; b=OkmQed5tlMSoja9dkfyLBKs/zkt6Bu9FjuWeZbKzaYt67QUpzcKodQUHSna4dL0gQxrp+/IeGkJBL3oQAXs8StuxxJJkWc6dzkNieT+JrviQ1CaknunUFK7H5lNVHcIzsRT5QRN6qrMwRJN2MMiBxIojDsHD61Vc1Ss0INbpwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159410; c=relaxed/simple;
	bh=Cv5nFjbtkeP5CeN1TX4MleK1XFdVFr+sAHq6x3SRxEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEI7ptMage1VpN6XuDGT4eBt66gNZA4ulf304cpYZGU/wzIbCRGjwlye3GD3FURsTTI+JQUYSB3ZMeVQQAY8eYqwjFuTDfiV25fUCjwdCBC9sHFMf0hGw4fTosUiOqG5SzIIF9lhiuOHN+DYicyQ1zxMKwNRBuKAQ4oYXkTsOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AJ1oFdwg; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AJ1oFdwg"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rQzFEUzK/F45g8ypvRts5u/QoBqNHb9cv6brj/ARPgc=;
	b=AJ1oFdwgIiiA5x/DHbAFAVWSVdcaHJl9FlNiEKenw7ZosM1mBZT0r02PInpCfNODCEaAnXt4V
	vELodCHPDpBmZZ60gN3UrSmjZrWWxY9GgUXySZ/b6XUxd/iu7nGk9/PY50yUKMMKhkug+WPT4JA
	++owb8bvlAnDojYWCV6Di5Y=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gBC8t2H0gzcZyt;
	Thu,  7 May 2026 21:02:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E27774056D;
	Thu,  7 May 2026 21:10:04 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 21:10:04 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v7 4/6] vfio/pci: Add PCIe TPH enable/disable support
Date: Thu, 7 May 2026 21:09:54 +0800
Message-ID: <20260507130956.34441-5-fengchengwen@huawei.com>
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

Add support to enable and disable TPH function with mode selection.

Restrict unsafe device-specific TPH mode to be allowed only when module
parameter enable_unsafe_tph_ds_mode=1 is set.

Disable TPH when:
1) Taking over ownership of the device (before user visibility),
2) Userspace closes the device FD to clean up state.

Serialize all TPH operations under vdev->igate mutex using scope-based
automatic locking to prevent hardware control and bitfield races.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index e7efa8f230be..7a5dc2bfe2e9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -738,6 +738,9 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #endif
 	vfio_pci_dma_buf_cleanup(vdev);
 
+	/* Disable TPH when userspace closes the device FD */
+	pcie_disable_tph(vdev->pdev);
+
 	vfio_pci_core_disable(vdev);
 
 	mutex_lock(&vdev->igate);
@@ -1494,18 +1497,60 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_tph_enable(struct vfio_pci_core_device *vdev,
+			      struct vfio_device_pci_tph_op *op,
+			      void __user *uarg)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_tph_ctrl ctrl;
+	int mode;
+
+	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, ctrl))
+		return -EINVAL;
+
+	if (copy_from_user(&ctrl, uarg, sizeof(ctrl)))
+		return -EFAULT;
+
+	if (ctrl.mode != VFIO_PCI_TPH_MODE_IV &&
+	    ctrl.mode != VFIO_PCI_TPH_MODE_DS)
+		return -EINVAL;
+
+	if (ctrl.mode == VFIO_PCI_TPH_MODE_DS && !enable_unsafe_tph_ds_mode)
+		return -EOPNOTSUPP;
+
+	/* Reserved must be zero */
+	if (memchr_inv(ctrl.reserved, 0, sizeof(ctrl.reserved)))
+		return -EINVAL;
+
+	mode = (ctrl.mode == VFIO_PCI_TPH_MODE_IV) ? PCI_TPH_ST_IV_MODE :
+						     PCI_TPH_ST_DS_MODE;
+	return pcie_enable_tph(pdev, mode);
+}
+
+static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
+{
+	pcie_disable_tph(vdev->pdev);
+	return 0;
+}
+
 static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 			      void __user *uarg)
 {
 	struct vfio_device_pci_tph_op op = {0};
 	size_t minsz = sizeof(op.argsz) + sizeof(op.op);
 
+	guard(mutex)(&vdev->igate);
+
 	if (copy_from_user(&op, uarg, minsz))
 		return -EFAULT;
 
 	switch (op.op) {
 	case VFIO_PCI_TPH_GET_CAP:
 		return vfio_pci_tph_get_cap(vdev, &op, uarg + minsz);
+	case VFIO_PCI_TPH_ENABLE:
+		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
+	case VFIO_PCI_TPH_DISABLE:
+		return vfio_pci_tph_disable(vdev);
 	default:
 		/* Other ops are not implemented yet */
 		return -EINVAL;
@@ -2258,6 +2303,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (!disable_idle_d3)
 		pm_runtime_put(dev);
 
+	/* Disable TPH when taking over ownership of the device */
+	pcie_disable_tph(pdev);
+
 	ret = vfio_register_group_dev(&vdev->vdev);
 	if (ret)
 		goto out_power;
-- 
2.17.1

