Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com [220.197.32.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AC308F0A
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862921; cv=none; b=pB4ACPJZmAz0OeFqHoFqeKxjkzOloHq3GqVz3LjV3hmZfnqbqK7+WUwbwm/uJcAxVp9+7viS1fnqvVpnwatnatsqZnU6f0pxnvdyGVwsJLMwxuS7X2gAzP2uB75I2ICN71LKlN3s/0FN1cOts3XoJVUMGbyiB349uo2BmghXz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862921; c=relaxed/simple;
	bh=ozyme8fTFq3xVeCK93g1byGZtVb3Rat7LyQrdJfoV8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kDDH4g+SDyGYDIMmm4mpkdPm38tMhV7Jza0aOG1OEtQl2CdYpeGE358XRgTxA+PFHAMANaKo0gSG6zkQ9TgVmtRSTKr5YAGxJPtwnF3ZTxmViSoO+G45g1WDl32vfldfnDNqno8niN0GdtO7cJlPK43uWw7igthqSI8MI0/QB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T9SW05z2; arc=none smtp.client-ip=220.197.32.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T9SW05z2"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4045a2;
	Mon, 23 Feb 2026 23:53:19 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Xinliang Liu <xinliang.liu@linaro.org>,
	Tian Tao <tiantao6@hisilicon.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 20/37] drm/hisilicon/hibmc: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:53:11 +0800
Message-Id: <1771861991-88810-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b347eb909cckunmd409f160987bce
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xJGlYYSB5CH04ZTx1CGElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=T9SW05z2nHrSbEZfkim29R3agkoLILzyspBYujkjmBi7VbiKrsiUFnH8tH55h+lqsC2vghHhAAHG4DdFw3Sm4c5yzO6fX+TLOPnVVyvu0gKZGJa9UMpnLCaf8Ib0vpzozIGtWcWfuPJxElXh4jh9PNHJrSbmPqpx5MddJWI9fYo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=wDBDGnBvZL/o5ghiSDCKV2tr6rYx7VKuXnAS7/Is1gY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Xinliang Liu <xinliang.liu@linaro.org>
To: Tian Tao <tiantao6@hisilicon.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 2893045..7705c78 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -289,8 +289,8 @@ static int hibmc_msi_init(struct drm_device *dev)
 	int irq;
 	int ret;
 
-	ret = pci_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS,
-				    HIBMC_MAX_VECTORS, PCI_IRQ_MSI);
+	ret = pcim_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS,
+				     HIBMC_MAX_VECTORS, PCI_IRQ_MSI);
 	if (ret < 0) {
 		drm_err(dev, "enabling MSI failed: %d\n", ret);
 		return ret;
-- 
2.7.4

