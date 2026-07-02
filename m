Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0ED48035F;
	Thu,  2 Jul 2026 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996173; cv=none; b=iTHz0APt/n25oCHm+NyrHwDs9WdqboQZkHm7cZmsWcPJBmu8z6/AIHyWYLVBO7FZ765Ot5omezhZFJgAALyS304gMnC5rrnVmyrZzGwiLFT9hZxN2yvhxcT9Gw92iE7dOlyCYUS/7sL+n+iE1nA7otLRHowPIBvfOlHfoHujgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996173; c=relaxed/simple;
	bh=sl3Cw/vU68yPBApoOz/bO2mn4QkBcHlU44c7dq96esQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QabKczxJ7F+BkGw9P02TVMD5OV+As3rX0Hh3KE7MjBVm8dnaIWth9kHaxN+R7zjsyL/o4DSw6c+bNE/Lx6bd768Ef1R22DaAFbxzYV5VdIDQgyCAbpQ0u8CZbYdg7No3iDntJal3BHbaZxicuLzp+ZdeiQJ8nWUZotAkIL7kwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nfsGgb5Y; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nfsGgb5Y"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q/Ue3U2nrHycgLGbXVQQQV72WDENPys+ESkwIGLTA+I=;
	b=nfsGgb5YbqTpizP/s759SLWNdJ5xJF2rislLIztRGtcOXZcffY/LIYM9zumK3AI/hjvw7ACIe
	MNjF71B+dy1lA4S4go/bUbDlfc8X/2EO+kO0pKU7xipefqUBQL8Vd3LUKOFRk0W8jl5jegipLZi
	NcHc6pfDpF05HD90zvb46go=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4grbsR2yC6z1T4FV;
	Thu,  2 Jul 2026 20:33:47 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C1DF440579;
	Thu,  2 Jul 2026 20:42:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:39 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 17/18] vfio/pci: Reset hardware TPH state on device enable/disable
Date: Thu, 2 Jul 2026 20:42:23 +0800
Message-ID: <20260702124224.57168-18-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

VFIO allows user space to enable and modify PCI TPH state, but device
reset only clears hardware TPH registers, while the software TPH state
maintained in pci/tph.c remains stale.

Fix the stale state leakage by explicitly disabling TPH in core enable
and disable paths:
- In vfio_pci_core_enable(), clear leftover TPH state from previous
  user sessions before device initialization.
- In vfio_pci_core_disable(), revert any user-modified TPH state
  when releasing the device.

This ensures consistent TPH hardware and software state for each
user session and avoids residual state contamination.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7251e251824a..5a14439d1ccb 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -612,6 +612,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	vdev->reset_works = !ret;
 	vdev->tph_permit = false;
+	/* Reset TPH status on new user session */
+	pcie_disable_tph(vdev->pdev);
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -759,6 +761,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_zdev_close_device(vdev);
 
+	/* Reset TPH status on exit user session */
+	pcie_disable_tph(vdev->pdev);
+
 	/*
 	 * If we have saved state, restore it.  If we can reset the device,
 	 * even better.  Resetting with current state seems better than
-- 
2.17.1

