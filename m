Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E733DEE5;
	Fri,  8 May 2026 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222478; cv=none; b=LyQeFngG35DPwgZjN0CaE8WQsRPmB/P/Yzj9IKC9IjgCEXNWIX+4IRM5HqShHWJRlGTY6Tt1eLffzZBZ0smtRU51PZ/ZDQZJsq/gW1VEexuqf1KoJ1my5vsOaebJTdGTLWS4swk6QTUSG0JMuHhrU8bmyAhoYP1B27+JSJHjJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222478; c=relaxed/simple;
	bh=uVw636mppGZ4F05anmOhNJmOsJa3nbK9IzgbiUdRdqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VikHI+CIdbZbXKyYeGtiLBVafm7523Epg7/Ve8IOlKE2TCR2REjPYlWF3pYW2PP7NiIdELKVF/nZTtDDLIO6CafcAzH3ygwUNta+izMG74L5wBovOgXmVwhLErXI8VQiRHYxThRMZ4tAVR7eZe2R7lwpOqMGCLismC8ifv9+EC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aQY/pdM1; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aQY/pdM1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x3tRc/K4B2B0pBiXXNxY6toT0CHoMGbJC5eMm/M1zsM=;
	b=aQY/pdM1ntJNXPooXHAnmRhg6vwwV52y6UrMxI7mz6R2mgfGqGU2RlHeRlFot4pfk/9yZ9l5d
	Y5uBAlg3ZoSh3+RhR6oR10fiXvXGTodfUrIZC6cOnfnxhhmmfBUXHVc33dWVKen8M2QrS8yEcgG
	ja9jEq2Tvv9ovShe55B5MCU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gBfTZ5XrQz12LFS;
	Fri,  8 May 2026 14:33:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E5C1C40538;
	Fri,  8 May 2026 14:41:02 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 14:41:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v8 5/7] vfio/pci: Add PCIe TPH enable/disable support
Date: Fri, 8 May 2026 14:40:51 +0800
Message-ID: <20260508064053.37529-6-fengchengwen@huawei.com>
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
index 0e97b128fd63..bfc7e87d190f 100644
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
@@ -1493,18 +1496,60 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
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
@@ -2257,6 +2302,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
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

