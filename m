Received: from mail-m21472.qiye.163.com (mail-m21472.qiye.163.com [117.135.214.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A2239E6C
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902917; cv=none; b=iJq8083EQNuYiFch2XYiXgU2Jj4PpPzEnGNa56DZYBsLR1F3mRXvigZuDVnZgO1/g7YdqSbIHpNcQU9rfCxETvc082A+F1NW7LPvP6Fl433CTGzGp7eeyM4p7lf/Eje6K/RDLj6I/KQOaRYFbCLuEaBY7aiy84kek3E1PINEiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902917; c=relaxed/simple;
	bh=s1uPYCQtp7hd1myuatMzZdcai12pSwBfyDs/AQuUgaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CFOdx37hDYLppUGkKlwr+/cCL7/9k0AwGABt45QGVlU0WEHohyxskGhwdihADzBDN+0pPwPAacZGacwznmPu1E+DO4306MYlYcZvupTyauH9fHAyZIYOrLIxyKqu4m1EvSBH/i38oukjw7rhA0qjRLTYhApMYLaxnvTuevfiMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NHkbLUaH; arc=none smtp.client-ip=117.135.214.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NHkbLUaH"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404644;
	Mon, 23 Feb 2026 23:58:21 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lee Jones <lee@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 30/37] mfd: intel-lpss: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:58:16 +0800
Message-Id: <1771862296-90650-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b3919ad09cckunma547f1c7988100
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0gdGFZLSkxISUIZSEpJS0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NHkbLUaHuXxv00OGw8ul1nWMwy1SbxWcpzgX1mp0/AmP3qkJnIHUeVONnY4fFSpv6Ryp7XPaeS4mIdm0QieFgy+OllW59RoQNO1v29VrJv9qujSUAd/RsxYAZdsTW/8nGltIIfmEj/US//8Hv/Xo/NuTs8vnZQRmyklHEdaPsVQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=2pQqI5BaMmisdMSlvbJl+OJfW1aiCsKLUAbswFTAIxw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Lee Jones <lee@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mfd/intel-lpss-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 713a5bf..e2bc016 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -54,7 +54,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

