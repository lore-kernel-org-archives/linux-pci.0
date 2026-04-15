Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC930C615;
	Wed, 15 Apr 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244225; cv=none; b=img27AeBJFn0YtNH/FYarWdWbJtiyuDp08uQIkLNaXmBuU89UqiUNz+i3r91WZPQTg0D8wVS4Rhl1jT6u85zlt+n2mMLWTUHQbAZYHDWA3TE47TMlrzwEVZUJi9BgGnxKra2M9YTamxlyGr1N3HfCESNzJ5Kc253Xc1D8VQrXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244225; c=relaxed/simple;
	bh=fV1ZmD95JTGcCfKEf9m8BLbEgnie3F5EQZijz/A9ZTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VngEHFDZ5iitKZxdZZ+UyEvTeoJrJD9hMmaXauDRp5jO1KZITkI3pr1fhTAGRoldL2eP+lRbHtCMmElFmR1O/6eCTQvTnCZvu6LFMz6vw5qMRwx0CBERDDcNRVCkh0dwX04NUH+YjNfM62X/2UNSa3St5VntB/Qv6VeA6yzIOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZIfTXnMv; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZIfTXnMv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rJcrzVYEdZvWn4l1GSbvteU9PPixNTbKyDINkLeZZdY=;
	b=ZIfTXnMvHhfuKh+8Gdqo/fQ9UzKPQ9fn7qvDu092XdRzxNmpdc6gNyaTMb3NMMdDww/fqel5f
	/wum9wMxB7/aCXPUNqixN6Q1YQlysIVtW97JBVYw+bnJejR4yipdg084Rss8D2PgzYcLwVwREUN
	AFW/8kHjYdyzV5bTIBEnM+s=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fwZvP490pz12LJx;
	Wed, 15 Apr 2026 17:04:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 8966C40576;
	Wed, 15 Apr 2026 17:10:19 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 17:10:19 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 2/4] vfio/pci: Add PCIe TPH enable/disable support
Date: Wed, 15 Apr 2026 17:09:57 +0800
Message-ID: <20260415090959.53672-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260415090959.53672-1-fengchengwen@huawei.com>
References: <20260415090959.53672-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add support to enable and disable TPH function with
mode selection.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 35df624439a3..0f96b41779cd 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1493,6 +1493,37 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
 #endif
 }
 
+static int vfio_pci_tph_enable(struct vfio_pci_core_device *vdev,
+			      struct vfio_device_pci_tph_op *op,
+			      void __user *uarg)
+{
+	struct vfio_pci_tph_ctrl ctrl;
+	int mode;
+
+	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, ctrl))
+		return -EINVAL;
+
+	if (copy_from_user(&ctrl, uarg, sizeof(ctrl)))
+		return -EFAULT;
+
+	if (ctrl.mode != VFIO_PCI_TPH_MODE_IV && ctrl.mode != VFIO_PCI_TPH_MODE_DS)
+		return -EINVAL;
+
+	/* Reserved must be zero */
+	if (memchr_inv(ctrl.reserved, 0, sizeof(ctrl.reserved)))
+		return -EINVAL;
+
+	mode = (ctrl.mode == VFIO_PCI_TPH_MODE_IV) ? PCI_TPH_ST_IV_MODE :
+						     PCI_TPH_ST_DS_MODE;
+	return pcie_enable_tph(vdev->pdev, mode);
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
@@ -1509,6 +1540,10 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

