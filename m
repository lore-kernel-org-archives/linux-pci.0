Received: from mail-m93231.xmail.ntesmail.com (mail-m93231.xmail.ntesmail.com [103.126.93.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4E377548;
	Mon, 23 Feb 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878263; cv=none; b=PK/47aOEZRxo167T/wHUeZfhQd699Ls5v7R6XXP36x+6oZBZileYzEuXLaF/e3iLED/1ADoSdIuuy/ODWveICpxY4vzpk7vjsHRWzxhLhe2Nu6PqAffuYI1lZCJ5Ky6KbC2ulhJqyjZzojkL06AicQmF+H9VN7J4neIOiA6GpsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878263; c=relaxed/simple;
	bh=qorg6TmtZ22TlloKeRF+oP40teEITKL0Bs3LFtaIC6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=N/toT6nWERGiYeLeYQKjtHQ+buz9NWHSAmIJLMbYCL+GBEj7H9H39fze9QR9itD1m8iIoIKNImfxfzw9LDM48IhRVspdBKTChCHHkCyRkQ2n6ptamclx4doVQLqwB6Hk+siCH4Npfor53zPDO6AshBUMftzjEb6H+rg9+3DyhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Gg+jsbSA; arc=none smtp.client-ip=103.126.93.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gg+jsbSA"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4044c9;
	Mon, 23 Feb 2026 23:48:16 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 11/37] i2c: thunderx: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:48:08 +0800
Message-Id: <1771861688-87083-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2fde4309cckunm510d336798763d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNKSlZJQ09ITB1KS0xDSBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Gg+jsbSArrnIeyfNwaJx+/VqSnRe36F6GbWY37en5PInBf0b/xaXSYrLxqA0ax80CjamCMWH0KeivVIqpt/1GtWPxjH5mTKs6bOVlse4FKWWcgNNNCwsYM5a/DMrmy+qG4K+MLKKjEh+2BggfHxJj0MrCfVyNVo7nVUHZWW2aPU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=EDQEAOeRTB4T28nPwNfIInakvVxbnFihUpDI4ZRKYOc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Robert Richter <rric@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index 3959f23f..74e7d05 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -198,7 +198,7 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 	i2c->hlc_int_enable = thunder_i2c_hlc_int_enable;
 	i2c->hlc_int_disable = thunder_i2c_hlc_int_disable;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 	if (ret < 0)
 		goto error;
 
-- 
2.7.4

