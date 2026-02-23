Received: from mail-m81198.xmail.ntesmail.com (mail-m81198.xmail.ntesmail.com [156.224.81.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E799229B12;
	Tue, 24 Feb 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.81.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771894282; cv=none; b=nQIk2abzBCB7rmn37A8Zl1O6JDZLOI1qlP93na0E/u38APy9C0cvWoZkW2JoDDinIJa3ASwyPIOYdYHQb2sY9BEiEiScvY+nH6DyupBeXY/HwoEIPu1uv+6q5DalfrJnyJKJGQj18Stzhs9/y3A+z319iB9ztaAPsJTcqnAaVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771894282; c=relaxed/simple;
	bh=TwWMhyphNBHwLivZZvKboQvoiYlTgSSGxnzNNchSVvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MYneCR+/88QKD9csFWLzzcKpPsI0X7m6Nyi5109YUeQMBACxRG+F773vAYK3dRqJNCEdg6kIwMGIQfF9KH0qKI7L0q0USeT92+cw00DTy4vXITisaqmWYoeOfTd1g0Aj0Ih7roaTrxlbZYc/dDooXsDPAA0rLZSVTqXIk/lPcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gDgzjXqB; arc=none smtp.client-ip=156.224.81.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gDgzjXqB"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b3c935b;
	Mon, 23 Feb 2026 23:47:58 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 10/37] i2c: mchp-pci1xxxx: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:47:49 +0800
Message-Id: <1771861669-86815-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2f97c409cckunm7038bc349875d3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IYGVYYHx8ZHx1ITElNHUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gDgzjXqBPC2RKkgukbcBRJRrqFdx+nALycNrdpPCSNbjcUGxsCD5Bm2JOcF4luvZ6COd85Kk7m95VesG29y1f1oJD7jYwN/9LkrW+DZcRlgRGMXphwt/66yXM+0+vDVfDmzjts+I5THmxKGj4IXOIiJ4unyWA9Y3TBAIKcQ09Ew=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=zFZi+w3pZLml+OurmnmrnaoC6c/ngs1JO93AfoSyNsc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/i2c/busses/i2c-mchp-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
index bc0f1a0..0475e20 100644
--- a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
+++ b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
@@ -1162,7 +1162,7 @@ static int pci1xxxx_i2c_probe_pci(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

