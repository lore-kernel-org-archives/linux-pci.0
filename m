Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E23EDAAD;
	Wed,  6 May 2026 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060802; cv=none; b=MuqZ7/TNoSOIn9UHCHlD+Dm76jHeAmtnTmpV4wBpNc0//6cUz8Sg/UoqAmdtTgwPqY7eFkab9M6zRZ3wkWchBfAsWq4zPasOuGGDwyxJFFUfraFelDUD/gixlx7SKwEIbEgwil9Iz8kDAW2J6z8fkMTZrLX0KcvBosdXX7HXlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060802; c=relaxed/simple;
	bh=b61pAujBEiUFl5eW3Xa4ZVgA1fQZkBx8J9nkc3wAdfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRmmqcmbdUE6PRJB2/PgAq3TcKcLp1BdDbIPy5+4CIuzVK4QNDunowMEZbAs8jpWCeSqUkOpKVIdJ2dozssE+omXgXC8tuSjrgghOZFtU01/OL3vMtbFJi+gnedhYBs3wqJ4ya5CbFFRcAYiOjpzE49TcmQweQZ6b4ZM4GqWmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NXYuwQil; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NXYuwQil"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gBd1wkQ1bQoJA2asUa02So9PiX22RFubcswMLKQRrwY=;
	b=NXYuwQilBMZEn8XrkfjgotaLUQ7qCnMilp5GqSP0WlW2MWoGrl9Tby3m6U3m0oCktEjzIHJlx
	AE6aSrcYxsh3w3r3u0Ms43ruPAzy1SfxgCxIASYs1j4+kKoHe1jR7hpRtNrkTL5Q4HletxvoTsh
	+cWO8a+e+fzUv2h14RU46To=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g9Vhv0KmtzpT0L;
	Wed,  6 May 2026 17:39:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B7DF20226;
	Wed,  6 May 2026 17:46:32 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 17:46:31 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v6 4/6] vfio/pci: Add PCIe TPH enable/disable support
Date: Wed, 6 May 2026 17:46:21 +0800
Message-ID: <20260506094623.29327-5-fengchengwen@huawei.com>
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

Add support to enable and disable TPH function with mode selection.

Restrict unsafe device-specific TPH mode to be allowed only when module
parameter enable_unsafe_tph_ds_mode=1 is set.

Disable TPH when taking over ownership of the device.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d98d04bad4a3..69f666d20c4a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1492,6 +1492,43 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
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
+	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, ctrl) +
+			sizeof(struct vfio_pci_tph_ctrl))
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
@@ -1504,6 +1541,10 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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
@@ -2259,6 +2300,8 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	ret = vfio_register_group_dev(&vdev->vdev);
 	if (ret)
 		goto out_power;
+	/* Disable TPH when taking over ownership of the device */
+	pcie_disable_tph(pdev);
 	return 0;
 
 out_power:
-- 
2.17.1

