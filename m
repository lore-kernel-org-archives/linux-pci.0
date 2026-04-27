Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31037B010;
	Mon, 27 Apr 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280342; cv=none; b=gJttuwD3MzvRHP6iya86D9GNAwUquNNb8H7nVwverrcdt4mqI0Lq1WjONPZl/2ORO1o/SRsURvZYIvEfPPHfA3UyXj7svxclDS5KjehvTH3GUUnerEFrn9dXTVUUoKzyA/LSFDQjf0q0o2XWYN63Z1MACuDj6GLZZc+9b3l9FrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280342; c=relaxed/simple;
	bh=kgHTJdcgfb9UWz3eJ/t/CSgiojxZA84lVQuyKMkuLzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7/BBPgG1JCllRwXVYB2XDsAm34LE+qZr6NMWj8dVmXDlnDy37WScg0xzKvsBIndNs3kqL715u0cuqR7ubPEEEwfZX2klCE1aIv17An43UlYBtTcS4KM0elZ5dDuTkhQH2qVfQ4ZgzAnQgf4UFDpyPG6XHZnqLxgq+Igmezfd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FkFs2rwZ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FkFs2rwZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jQ3yJVq5/FQBn3/W/nSTwvpau9Q+Bc+rzoj4pREwzXc=;
	b=FkFs2rwZD20QodBYrOhbMbj35K2kJUZ44mW0KU39JHs3dk2onPG88ZNnhVqpj7gFcYcK8hN22
	Ry6VQ/Wju5ApZJ1GjVlHdGYytWNCHS2gMa8v8H/j8LFO3M7bJqHtyt9XsJYcuyrLWxHzJuuT2Cq
	KIFcUEFOzluy4zQKBCLNSvs=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g3y3b1CgfznTWk;
	Mon, 27 Apr 2026 16:51:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 363DC402AB;
	Mon, 27 Apr 2026 16:58:51 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 16:58:50 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 4/6] vfio/pci: Add PCIe TPH enable/disable support
Date: Mon, 27 Apr 2026 16:58:41 +0800
Message-ID: <20260427085843.42460-5-fengchengwen@huawei.com>
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

Add support to enable and disable TPH function with mode selection.

Restrict unsafe device-specific TPH mode to be allowed only when module
parameter enable_unsafe_tph_ds_mode=1 is set.

Sync TPH software state after device reset to avoid state mismatch caused
by FLR hardware reset.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6c498fbef2dc..d1f7f2933e66 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1246,6 +1246,13 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 
 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
+	if (!ret) {
+		/*
+		 * FLR clears TPH hardware state, but pci/tph.c software state
+		 * remains enabled. Explicitly disable to sync state.
+		 */
+		pcie_disable_tph(vdev->pdev);
+	}
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
@@ -1488,6 +1495,42 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
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
@@ -1504,6 +1547,10 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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
-- 
2.17.1

