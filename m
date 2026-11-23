Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401407;
	b=x/MIzMx+TMNLNJH06rCa8PpFQFFmfw0YyU97GeGbRRa11k79Ja82elt7xykMO3Xeg9B6
	 WJW8CiEd++ENvu8AvjblyIYrtUnW5PQ1mCg0mE7Prwe72ZUuUS9KZArBJPa0LS2F3f7MR
	 tAnhOuRNSMm07OIMzT2S2asakq+XNN2Rh3/SE/FsfMGbJ+QrpWvbIvQ2FXWFQOKwBxEOj
	 zI+0m2MBhMXDe5HAbfxQ63uREhvsxjBbVewQjwocQmXIh3f8FYiSx8Co8qG7rDlb3EmMa
	 4SSsTkU2vtspxSZhxbq7Nz+GQ8r6LIp2YvIqvTaYTdxvQ0Mpcs3qvhMulGJHnuypz/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401407;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=xnCXXwSIAX/X8CVni1zZUNVyZWJnGmUqMTBhe1IOg80=;
	b=M3fUXjc1v76sYv8jD7k/agG8WflEtvE7Bj77xUMJJ/Zy4Qbmt57cnWgEqIpZKcT1JA5o
	 7lbACFizOrsdcewOgbHfC1le+PYuHQxhk//JKwaUezAHrKDFHmL4hCawxcn/GPdpEeXXQ
	 fp7fLAonmCgT0mqXVJrHom/HbjuxqEktEmGsGPXYnmJvqoGRnP/PdO4AerE8ERXJCYQin
	 QtsywT1FcfECLx2fU+Q2nWE3dfwIBnGL0Qd24gttI7gxUXUKxXkmSd4ZhxzXivxNs8yxR
	 ffgtsPEcjtwfK/VnG3nJtbR9M+5IJpGvzPTpCuJaaJYUISDUkcb6vhIgorTvAYD9mVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PM+0h7Hm;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E347606A6A8;
	Mon, 23 Nov 2026 02:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E347606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PM+0h7Hm
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xnCXXwSIAX/X8CVni1zZUNVyZWJnGmUqMTBhe1IOg80=;
	b=PM+0h7HmuCT+vDOZd1ifW22ZZTmvzSkFmvCbdajkpvBaMovF/3L8iVbV2u8dVstqxI/AwiH1l
	iD7EkOEfq/N/jns3r/UcO3MrJv7Mg2FwzbOnZ085t4GLywoVeeKkAyr9ktwNFzTBDNFID1ZtOBv
	lGhdxB0DS1wMdLfURQyC4Y4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jXqn133wbz12LCd;
	Mon, 23 Nov 2026 10:35:49 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E3CEE40591;
	Mon, 23 Nov 2026 10:36:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 09/13] vfio/pci: Reset PCIe TPH state on device open and close
Date: Mon, 23 Nov 2026 10:36:24 +0800
Message-ID: <20261123023628.7728-10-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261123023628.7728-1-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hardware resets clear PCI TPH registers, but PCI core software TPH state
may remain stale across VFIO device open/close cycles.

Invoke pcie_disable_tph() at enable and disable boundaries:
- In vfio_pci_core_enable(): pcie_disable_tph() runs before device reset,
  to prevent stale TPH state from being saved/restored by PCI core reset
  logic
- In vfio_pci_core_disable(): pcie_disable_tph() is placed before
  vfio_pci_set_irqs_ioctl(), disabling TPH ahead of MSI-X state teardown.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f2d5b6857925..8d2aa5585c1b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -22,6 +22,7 @@
 #include <linux/notifier.h>
 #include <linux/pagemap.h>
 #include <linux/pci.h>
+#include <linux/pci-tph.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -595,6 +596,9 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
+	/* Reset TPH state for new user session */
+	pcie_disable_tph(vdev->pdev);
+
 	/* If reset fails because of the device lock, fail this path entirely */
 	ret = pci_try_reset_function(pdev);
 	if (ret == -EAGAIN)
@@ -704,6 +708,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	/* Stop the device from further DMA */
 	pci_clear_master(pdev);
 
+	/* Reset TPH state on user session exit */
+	pcie_disable_tph(vdev->pdev);
+
 	vfio_pci_set_irqs_ioctl(vdev, VFIO_IRQ_SET_DATA_NONE |
 				VFIO_IRQ_SET_ACTION_TRIGGER,
 				vdev->irq_type, 0, 0, NULL);
-- 
2.17.1

