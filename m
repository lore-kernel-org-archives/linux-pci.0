Received: from mail-m3290.qiye.163.com (mail-m3290.qiye.163.com [220.197.32.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC206344DA2
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019728; cv=none; b=KDB2HlKsRW/2sUrhy+VSGMmVaI2XLXK3DPy5WbEcZRjT4VQNPV9g5zbh1Krz+IsDbvjSqCJqNokNxlGoANfs0w7MzTggwsNOtLMCNds3a7oLvERcxsNo8/WNi8M+lAxkU6o6gzEjvmqjqH2zDhqFrD1qEMaqhNb05H254wiIuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019728; c=relaxed/simple;
	bh=yjhCYWJW6ULXxHB0lofHnJJCx6lVO0ezPzzYKhL0fr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HHxftbWe8mi6zTox43Dsyd2n+/In57CUqcf/kDOFNU8MboJqKEMrFFqQHaN/eDfKm4yYzEdUvOp/4gjGdyQV/MLnfQBTa2UQcuEqsMckEN7DcZRlCXjGI+Y07Qzq6GlBrU3l+3OuFD6rQfbNPOQfE+QH1vc2Uwc9uDadpv8VOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YmpNSMVx; arc=none smtp.client-ip=220.197.32.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YmpNSMVx"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c02205ba;
	Fri, 24 Apr 2026 15:59:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 7/7] PCI: vmd: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Fri, 24 Apr 2026 15:57:40 +0800
Message-Id: <1777017460-243543-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9dbe8050de09cckunm66d640875ecf8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkkeVk4ZSkpCSUtKSBhJQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YmpNSMVx5YRCkkuSiKt8mny6c95KBtoPCzuBUMah7dMy6pCGDbI+zr8Q2QBe/hVDZfENhTfs3m2+0UP5PEO9bYKjM4CptV9y/0k5JM9LH3q7N0ZD58x5X1faYdEgXruYeV8vVahzXJP9UKaAWZoHMsAxMyeFhyt3O83HB53HUjs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=47IkHF4aJA+TODcabLDZ2iXJs9epIzBWf4fkeb+JCTk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors() to
explicitly request devres-managed interrupt vectors. This makes the
driver's intention clear and avoids the ambiguous implicit management
previously provided by pcim_enable_device().

The change prepares the driver for the eventual removal of the hybrid
IRQ management pattern from pcim_enable_device(), ensuring consistent
resource management through devres.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/controller/vmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250..d8de63a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -684,8 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
-						vmd->msix_count, PCI_IRQ_MSIX);
+	vmd->msix_count = pcim_alloc_irq_vectors(dev, vmd->first_vec + 1,
+						 vmd->msix_count, PCI_IRQ_MSIX);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
-- 
2.7.4

