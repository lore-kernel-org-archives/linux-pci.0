Received: from mail-m3278.qiye.163.com (mail-m3278.qiye.163.com [220.197.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3722258C
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862137; cv=none; b=tNdK5JdDcDT+XGP1aqzACjU0JhVJ0D4E4xxFEGrFxunFA8s/we0vIkXDIwjBxXNb0Zl+aza/hmZ2kit9WmqNCy+kdv9bVs2c47x6cL1cFlK1n3lWIFmVYLKL/VGItL/ZlSGLwfWYgJwX2GJ2DjYRecMME2dm+0jnAYkndHrmhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862137; c=relaxed/simple;
	bh=0AvRdh2w2GND20z+0IWE/+xW6JwXcCCCTZSrU9HjDfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ElnzqhHq/HTfV1fr4c3PmxpDOfsRKcdm0YpCs00chdb/gyODpbmGC0ggkf7wtdurZNXlbLO0qC8gyBvpVvmptYJVhkwOksGbufuInit9ran8Ckdq2EN3rGavSkcHtCvtHF3GFJRStvcD3NoG37krHoTT97yavLhUFH0J4h7L1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LpPRn1v9; arc=none smtp.client-ip=220.197.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LpPRn1v9"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4045d6;
	Mon, 23 Feb 2026 23:55:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 24/37] accel/ivpu: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:55:23 +0800
Message-Id: <1771862123-89453-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b367caa09cckunmc558006f987e10
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NOTFYfTB1KHkNCThgZSUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LpPRn1v9IV4j20fkIVG+c+9f45bijC8ATOzAkiHwpdlxFzStcwcrIjM9qsFYd2Xv0ck/kuyty353dy51YxFDqdc/nX6z3KB63THtnVGPVMMW28couWMBT9cofDDoWWdHLpN6hXCKUjo4eDk1yFCuLylghTP5+GSs56kadgZGb/g=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=rPhMlI89kGsU2DF8fsSo9VCSAn93/8TECsZqJMqdbdA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Maciej Falkowski <maciej.falkowski@linux.intel.com>
To: Karol Wachowski <karol.wachowski@linux.intel.com>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/accel/ivpu/ivpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 8ffda57..5673a07 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -487,7 +487,7 @@ static int ivpu_irq_init(struct ivpu_device *vdev)
 	struct pci_dev *pdev = to_pci_dev(vdev->drm.dev);
 	int ret;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (ret < 0) {
 		ivpu_err(vdev, "Failed to allocate a MSI IRQ: %d\n", ret);
 		return ret;
-- 
2.7.4

