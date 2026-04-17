Received: from mail-m49204.qiye.163.com (mail-m49204.qiye.163.com [45.254.49.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1511B983F
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393740; cv=none; b=cP9T3VLlsd9h9zoSdqfYZ5A6+B2miFctiMPs5y1/6mKBxYhlUzRld8annDzfQ7kv1IzV2mMytMp/Xc4yH6IVCfo9N8ILQ171GYJ2x69buUKKPwo2Z64q+D14YX46s/2jrkQ4+BpaRUUpsgHZPMvWGrahQJ4+ekLOovYNSddL27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393740; c=relaxed/simple;
	bh=8fI2vV9yzZf+lWrwp2+VdU9eq8j81wLH6Wi9aWh2cBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QTIHuPD3f8zjk6KG11Sd4EUuXUcOejIwZqrjgmjTaMOsR2Hov3LVIyQRpwzFrdJK63f0k6rfxiw8yR+gUgJ6AOyGNwWgQXEB7VRxb9YUyVOMsN1ypn/p5tfilA5L7LX0LeHEeow+4kILQynuz4JBKbzeIkFY1SaLJqQP2VDyBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KOhMMgkg; arc=none smtp.client-ip=45.254.49.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KOhMMgkg"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b1199b58;
	Fri, 17 Apr 2026 10:26:47 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 3/3] PCI: vmd: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Fri, 17 Apr 2026 10:26:07 +0800
Message-Id: <1776392767-83668-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d9943260109cckunm63489ccb2f7487
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0waHlYdHkoeQ0pMTktMQh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KOhMMgkgKhFgaSDb1v+r44BUBEKy38Mi+deVzy4HVSTRjC1QnhPKNqLKaspgN6hiVRRewGXYao8tIqerBotInDl1obdX8nHg8BzcDv0dqeu9aVezpDdt4KaayMLKDH/bg4Cwp8B+G4vYRauMJc7A9bhkOsYZrmkM23cbKuoEpJc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jt3FY6M0j0PfOe4pfwyi+gf0X3EbfNf6lI3RgAfXY74=;
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

