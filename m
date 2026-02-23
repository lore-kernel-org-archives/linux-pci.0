Received: from mail-m49234.qiye.163.com (mail-m49234.qiye.163.com [45.254.49.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966B2F1FEF;
	Mon, 23 Feb 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862032; cv=none; b=o2CsDOfdx1RBJM+xomRHhp5jPBqfeJIe1SZCPZsF0K6Wk3dhI9Puna2yR0bRnruE1Fo+1zO7b/ywiUAw8pr3jDCfkOAOC6i2XZMJS54F3IrqMBCHa1q7wWMsKsJ0uA+7666FtJNFK7bVrcCmVyLk+ovALr70sy6vgOK5IHNDuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862032; c=relaxed/simple;
	bh=LWFzHAm/XgQJFkqPf0QGRAUzEjh4aUxUaADFqsDz57k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vhrdt7TTofWulfZOuQWOxxoWucAt42WE0Ft0MLdH3Ck/dZ7PunYw4y1T0kwpnbGdTAuPTw+a+/+FlYr4m890VAJLFgVEyQZhwpyqeLeakq0RbK0abWyPi8NFHzwAp2y/CHB5oxlXiu33aW/7dmPdizx42plUi9FkkRCMhobBoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gYHByro9; arc=none smtp.client-ip=45.254.49.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gYHByro9"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4044fd;
	Mon, 23 Feb 2026 23:48:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 12/37] i2c: designware: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:48:30 +0800
Message-Id: <1771861710-87137-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b30319109cckunm245aeeb89876ef
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJPSFYaSxpPHhpJS0lPQ0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gYHByro9U1Q8U7FOcJHzi7p/kieAkx97GU2ojM9qGKAf/BhWFsTiVTQDodgJknFBJIDvs3QVp8QsEEwNJZI+tPUJGxve6ye8MCENd+wXsddntFV1RuHS4KOHL0HIDMvGloEE8l6aTotbOawbl+Nhh1zGIeYiky8BGPZXKVgxINE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=YcfPJNOjjb4D1v/BfxLmW6kLgn0HRm4STrLEd5QMqbo=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jan Dabros <jsd@semihalf.com>
Cc: linux-i2c@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/i2c/busses/i2c-designware-pcidrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f21f987..5bf944a 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -234,7 +234,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	if (!dev)
 		return -ENOMEM;
 
-	r = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	r = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (r < 0)
 		return r;
 
-- 
2.7.4

