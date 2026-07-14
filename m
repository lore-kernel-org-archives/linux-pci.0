Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF921382299;
	Tue, 14 Jul 2026 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025833; cv=none; b=ftIt0aYMBOVYKMKXrdoxsM4esVdhZxjWdG5m7eHypxPm+KERNJYzczozb8cM6gHKJRs2IcpeThcz2vGx7QejGjPLijKjoqF912k5AVnUNePYc50LSkUqATftH7+E8q3XVpZxgEH7n5mY19bkbG7fvJ53h+jGzndQNXMxxLyxv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025833; c=relaxed/simple;
	bh=K7mY5Ktsj4HXnYB4VA0P41QVTWhs346jXP3Jy3pkI9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWpcmAcJfUqeU4lo44MnJVNRWU7NW+/Ep9h90LQl3jKMMeQz8Iqcmg5gkB90Kud6AveGlvd2bdKKxofUnq246j/ThDAJCQdWimzDMvPedaMAM95jVX/z66AgKGvStI7/aNsDCooBmyR+04I+2eeQ/8uHwRcq5+e6/iNi2SyLZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SPd5FD4D; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SPd5FD4D"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e6TZ/S1+Ew8fh6vqosYxFzW0Bt3UABN+j5FympqmeG4=;
	b=SPd5FD4DqXCNu3g1fUl14GTkPDCTLTeqU/MGB0EqlTcB32DVySSJB4Ge+/mNkZRKiTnVfQaSL
	lBqoNR0iuxUWkNgLW+GKzbCkcmBr25Eu2XvlNk1QMpnoN3xRxbLZIP5yEPmJpoTwvLecM3TuQFm
	5xSAip3hImD5vOTx3jdi44Q=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gzwfF5cBkz1T4Kv;
	Tue, 14 Jul 2026 18:34:29 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 15BD6203B8;
	Tue, 14 Jul 2026 18:43:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 15/16] vfio/pci: Sync core PCI TPH software state across device lifecycle and resets
Date: Tue, 14 Jul 2026 18:43:24 +0800
Message-ID: <20260714104325.54444-16-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260714104325.54444-1-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hardware resets clear PCI TPH registers, but core PCI driver software TPH
state can become stale across device open/close and reset paths.

- Call pcie_disable_tph() in vfio_pci_core_enable() to reset TPH state
  for new user sessions
- Call pcie_disable_tph() in vfio_pci_core_disable() to revert TPH state
  when releasing the device
- Call pcie_disable_tph() after successful VFIO_DEVICE_RESET and
  VFIO_DEVICE_PCI_HOT_RESET ioctls to sync software state with reset
  hardware

Ensure core PCI TPH software state always matches actual hardware state,
prevent residual TPH state leakage between user sessions and after resets.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ae2e0e2252a1..c509adb76955 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -614,6 +614,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	vdev->reset_works = !ret;
 	vdev->tph_opt_in = false;
+	/* Reset TPH status on new user session */
+	pcie_disable_tph(vdev->pdev);
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -761,6 +763,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_zdev_close_device(vdev);
 
+	/* Reset TPH status on exit user session */
+	pcie_disable_tph(vdev->pdev);
+
 	/*
 	 * If we have saved state, restore it.  If we can reset the device,
 	 * even better.  Resetting with current state seems better than
@@ -1562,6 +1567,7 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 	void __user *uarg = (void __user *)arg;
+	int ret;
 
 	switch (cmd) {
 	case VFIO_DEVICE_GET_INFO:
@@ -1573,9 +1579,15 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 	case VFIO_DEVICE_IOEVENTFD:
 		return vfio_pci_ioctl_ioeventfd(vdev, uarg);
 	case VFIO_DEVICE_PCI_HOT_RESET:
-		return vfio_pci_ioctl_pci_hot_reset(vdev, uarg);
+		ret = vfio_pci_ioctl_pci_hot_reset(vdev, uarg);
+		if (!ret)
+			pcie_disable_tph(vdev->pdev);
+		return ret;
 	case VFIO_DEVICE_RESET:
-		return vfio_pci_ioctl_reset(vdev, uarg);
+		ret = vfio_pci_ioctl_reset(vdev, uarg);
+		if (!ret)
+			pcie_disable_tph(vdev->pdev);
+		return ret;
 	case VFIO_DEVICE_SET_IRQS:
 		return vfio_pci_ioctl_set_irqs(vdev, uarg);
 	default:
-- 
2.17.1

