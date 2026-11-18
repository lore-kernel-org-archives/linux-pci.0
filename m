Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993181;
	b=EjXp9PA/PkesBiE3ihUF2pbVHBVbALBXxZwMpKzh7Fk+buHcwkBxhDkqBH+SUoix10T6
	 zPnUQdjPdrZfvJ7SJMK6wq7pif6XyveOAuN1QESXLKJ6iqVAA+yJX4V2lqHiNuurzc+e4
	 RWftInWH6AK5dOKooRzSHlXf2tZEGKu6cg/lN0vMHKrObmCkEmNrpiwzgKTnTonaJ1x5y
	 JSWgJQzIQ6BcoaMeDFWgDU3zxJ82U4SgByOjreoB4w7/L1YOgnOFy+A504Xgbe761kH0G
	 +ZBji5dDRwLtFYplNrXFjq8t/Aqlri5VtiUwOuX08/gSO7d7si01iUPX+NN6BR/J+sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993181;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=GMOmY6NvjtX+zZt0a868EfQOB/CnqpA48LQHkAH34YQ=;
	b=Eu1Xx1TGIknQSmcSrsC2BHwykBXlm1dvlJ+bXs7ZOQe5ca0m3ZYA/ZV3vaKf/MiOmBm6
	 x801HHxCGxkot4PkZlnIMT2wKaChsSdag0JSTzyLmjqryHuF64+XKRdRAnWL64hxIbr2e
	 oFlqGsHg3YnMgh49bgAjY84EOQmNkYVyaISLhu43ykBxDTP1ZTsm0Xm3cgFJS/tinJAHK
	 fjxbOLwVzUFo2v1cxOfHu0B9arsGHssdm4xxNI7Q+HU/w3IoJP4CXDVoc85rMMuxjZsL0
	 1gz3szrNIECcvRseLniFsY/gTSF3iY8Dbt/GFSHchMyEMyvVTZAbV0JK5qADXZjODMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=A6WjT6L5;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAC606A32A;
	Wed, 18 Nov 2026 09:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60DAC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=A6WjT6L5
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GMOmY6NvjtX+zZt0a868EfQOB/CnqpA48LQHkAH34YQ=;
	b=A6WjT6L5EjRM3xbhsaZWm1dlASFUxkzFCtp+9dQDjDRJ8Nyq2pLb1oiXKSRwK0Hr8XPGS3XmY
	4R1T+6IgHtuMFlF/XaN+iDxTZWhm8+Y12qkpYEKvQUngkcdnYCXWAv1O7GczpfnQaNBOjLuyIKu
	IKtljJcwjQ8ymsrXfjeBFGU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jTwpq6dGgz1T4G5;
	Wed, 18 Nov 2026 17:12:19 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D67A40684;
	Wed, 18 Nov 2026 17:12:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:59 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 12/13] vfio/pci: Reset PCIe TPH state on device open and close
Date: Wed, 18 Nov 2026 17:12:37 +0800
Message-ID: <20261118091238.45992-13-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261118091238.45992-1-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hardware resets clear PCI TPH registers, but PCI core software TPH state
may remain stale across VFIO device open/close cycles.

Invoke pcie_disable_tph() at enable and disable boundaries:
- In vfio_pci_core_enable(): reset TPH state before saving PCI state
  for a fresh user session
- In vfio_pci_core_disable(): reset TPH state when releasing the device,
  to clear stale software TPH tracking state

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 049392831b35..8d3d532cd51a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -606,6 +606,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_disable_device;
 
 	vdev->reset_works = !ret;
+	/* Reset TPH state for new user session */
+	pcie_disable_tph(vdev->pdev);
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -762,6 +764,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_zdev_close_device(vdev);
 
+	/* Reset TPH state on user session exit */
+	pcie_disable_tph(vdev->pdev);
+
 	/*
 	 * If we have saved state, restore it.  If we can reset the device,
 	 * even better.  Resetting with current state seems better than
-- 
2.17.1

