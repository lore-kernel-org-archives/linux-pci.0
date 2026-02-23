Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED9208D0;
	Mon, 23 Feb 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862386; cv=none; b=qS/q13NF6f6ijPvO0zo4PSevd40Lrz90fkFOQm/uw/u5ucDORg12/IHidSbAMkg7n8EY/GxmptH238qHjTN8IZSSZfeRsb/8Rl4yYmTZ/LlA9c98009e325UZHZ1rRPREkzDBF24LUD5KMY2C0RaBTHJXaplgj8VuZI3La5AplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862386; c=relaxed/simple;
	bh=Aqlv822LWY6fqNHstwfAntZtXixRmCSUC8Z5bGJ5Rb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ft9WdXPiZaB39f/Aoatrsm/MwSVIgLSiEetiKKjHAmnUBpA4+yLM+ZHt0bZK/5TKje2ON/ir5XKyRWh20bcGztr8zADBIgDak7NmN0qKwRjQYrL03o6trVq2c2ZwO0l+82EXhavL6DA3UyXvC3Vra+0SzU/EOvHqYUP1BWG8pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fUb44OLv; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fUb44OLv"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b3c921d;
	Mon, 23 Feb 2026 23:44:24 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 08/37] spi: pxa2xx: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:44:20 +0800
Message-Id: <1771861460-85953-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2c544e09cckunm395df14a9871a9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkofH1ZMS0kYSEMfSxlLSEhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fUb44OLvoK37K0C2XeRl53VTv7Uzw71SJe8zzsyhGmkvwaWQJcHLCCqaZDlmqRVHMIWdxmff07fQSJclAZMEpwOAaiaZq57x4Zo9eVGWbrAq2jBB4+VkRKxRffOhaftwUVNoxYlqAg1BrXS0WqwPbV8Sjrl/jC8/lBjUoXXdBoE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9nsMX5dFvhUj/8iAiKw7vGR/DLP2u1uPwaVo+Vk8InU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-spi@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/spi/spi-pxa2xx-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac..551e8e7 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -291,7 +291,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 
 	pci_set_master(dev);
 
-	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 	ssp->irq = pci_irq_vector(dev, 0);
-- 
2.7.4

