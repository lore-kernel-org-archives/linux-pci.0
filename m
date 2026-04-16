Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B42C11FA;
	Thu, 16 Apr 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331852; cv=none; b=OKCgSe6QlQ1Dh/7AKoPYlFU1VHih5/aVPn5ejyE0YHLSrBb0fAMbYpofZB1jsgpyzNcT1r/i9l19UCHHoDaK9k5C0DvkUf/VQFE7fsBZ6Nbb6xMlFHk45veCIuDe31fUzOFIZ/l2w6y07KznrtJvyMl2fCPUS6h3ciO5U2MjKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331852; c=relaxed/simple;
	bh=RNwAGTBMpzwEr+myWRaeoZSPWXsAexs+BUjnA0eZ03I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQT/021N0Tsomy96kAZWW/4obBygDpWbPf2fHsDplzjzxqDtYcN+ozNQAV2l3ZnW/eOPpq67Pbar/cUPT8vQvmGkzL5eNMCf6pQNoLu7mc6MkSVpPodY2LTO5IfVrq0GJ0Jg4nj/buwQ6ntSomxKwxf08jeYYUZkgZurV7AdTkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qYhdb+kc; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qYhdb+kc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Vm6GVTHIjg7srtzmpwKRJWxW+mbYdqCyts7eyl/ruek=;
	b=qYhdb+kcJczbWaGsLeFOtykT+gMGaRbGygNdtXDrnboXqihEtNDfSzV43nDgpp2Nsoe4WuF6W
	vK2rP4HwYDZphx1Gc3yrMEw7dVSj2bnwpqO9yFwn7X3e7sEHp3LV2h0S2VTCoN1OqQBhAwqTi5x
	D9pEt/VLPJYO7mpGysztt0I=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fxCJt0LRKz1T4Jf;
	Thu, 16 Apr 2026 17:24:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1977D40571;
	Thu, 16 Apr 2026 17:30:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:30:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 RESEND 3/5] vfio/pci: Add PCIe TPH enable/disable support
Date: Thu, 16 Apr 2026 17:30:39 +0800
Message-ID: <20260416093041.42070-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260416093041.42070-1-fengchengwen@huawei.com>
References: <20260416093041.42070-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add support to enable and disable TPH function with
mode selection.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fc82ab845737..22c16662f533 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1487,6 +1487,38 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
 	return 0;
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
+	if (ctrl.mode != VFIO_PCI_TPH_MODE_IV &&
+	    ctrl.mode != VFIO_PCI_TPH_MODE_DS)
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
@@ -1503,6 +1535,10 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

