Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED089D531;
	Thu, 23 Apr 2026 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906547; cv=none; b=YSvmNpz/CKbj1HaFChumdvC4MHKACvNyEjg9evuSNFi3TMsCzqwx2kp5S6lCuCz3rJX6VjFdgddjYNc/ccVTZ97OVnwhikChDpOfFjZcr8lJ2HWs5Xjas2Djcyz1J7GydhxCrplfKr8Vj9jQNkxggB7LBmWXI6Cksw2fFmJfIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906547; c=relaxed/simple;
	bh=ibTGHKqsz2LbP26gzKnf1jJJ/o15rA/nAX3myTkqoyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfYr+9cjg5XNO4gwFnR37tjrzFCzl0bV6hqGo45+3SvSdCFp8D6HCbunWgfLIRF/Y091Sbybnigw9KeRFQ5PM+yyqg1l9ulOhj7TMtqW8j0uw3tbxKByM5R3pwBK9Gx6G5i7Chn0TLK9JcMPGelvh0ngiZ/pHstdGAdoXU7fPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DhLo129R; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DhLo129R"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nLx3IN8zUEosJiJA2y7JQds54zYB8+xPxvyoBtbvJkM=;
	b=DhLo129RZbYapxdx90jrVBDCJCJkV0Q8X46MFPHb0qlbamiCuUJsQW/YYyW5sS0UrTlW9NwVc
	teFwbIQ7kcHAliFuzP55woA36XgUfH7WXb4tWa3uQu+O1R/6mGqaD9GehS029quEXI5Lvniv1EY
	HUAni69jPdVR17I6Dd6HC58=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g1HrQ679Vz1T4HF;
	Thu, 23 Apr 2026 09:02:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 472ED4056D;
	Thu, 23 Apr 2026 09:08:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Apr 2026 09:08:57 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v3 3/5] vfio/pci: Add PCIe TPH enable/disable support
Date: Thu, 23 Apr 2026 09:08:49 +0800
Message-ID: <20260423010851.46737-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260423010851.46737-1-fengchengwen@huawei.com>
References: <20260423010851.46737-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add support to enable and disable TPH function with mode selection.

Restrict unsafe device specific mode without ST table to be allowed only
when the module parameter enable_unsafe_tph_ds=1 is set.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9f1f07f3255e..0c53c2a92c1e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1488,6 +1488,44 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
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
+	if (ctrl.mode == VFIO_PCI_TPH_MODE_DS &&
+		pcie_tph_get_st_table_loc(pdev) == PCI_TPH_LOC_NONE &&
+		!enable_unsafe_tph_ds)
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
@@ -1504,6 +1542,10 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
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

