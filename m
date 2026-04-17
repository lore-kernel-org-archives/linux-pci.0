Received: from mail-m82231.xmail.ntesmail.com (mail-m82231.xmail.ntesmail.com [156.224.82.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE31714AA
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776392814; cv=none; b=BGnhKRf/w0cGlcnKcjTK4oRIe+PVh/LJpo5B22DeE9e7XMZP9h50DSdGettZivyINAA8/1OJ0UfN8w8HDkI93b8pbgHxhlxmKvIzda4//xKbS8F55byHD3eF1TKXH9/0GFJSUsT8y0Gba+BL0ZDEefRatUmC6OHRL3HcFQ8FLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776392814; c=relaxed/simple;
	bh=6S6Oe/atfYqVm9DLF7txsw/V/XhYsftEzxVfJf+SnHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Woox1kkRwPy4fp6VooDpBgIYda0WwKhbmSLqlXI3NTHEjTHgAhte6ZiSIqy8B5wvvnIIJY/ZNqHQAnYJ1InrcqCVIrvrtOGjhcsPzWt0CPL5u37s8f6clk9CxBgVj4UoTCGWUV9SwP+lwntrSdA2DRkpkgb5FSMn0O6V+oRpXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=baC0Z33/; arc=none smtp.client-ip=156.224.82.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="baC0Z33/"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b1199b42;
	Fri, 17 Apr 2026 10:26:45 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/3] PCI: switchtec: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Fri, 17 Apr 2026 10:26:06 +0800
Message-Id: <1776392767-83668-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d99431af309cckunm63489ccb2f7457
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9KTlYdTh9OQk8aHxkfGUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=baC0Z33/xL09Zdj7E2n6A/TTW6TkGOnJtJ77aTRPEBPrLucczbETSgIGqTp0DEuav5ny4kQ0zvhksNG72kVmg7G7qZLd0jDJvqP/wl+qu5tq+jcZisNED+hG5pBqnQhQnw06GycoxnLMG6jLi5YELwYKrHP24VtSUmY+FHrsKeo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NMGF09aAgpd4DqT/E+zRbGs16YasgNWF9veMal2X+Oc=;
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

 drivers/pci/switch/switchtec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 93ebec9..ed42661 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1493,9 +1493,9 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 	if (nirqs < 4)
 		nirqs = 4;
 
-	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, nirqs,
-				      PCI_IRQ_MSIX | PCI_IRQ_MSI |
-				      PCI_IRQ_VIRTUAL);
+	nvecs = pcim_alloc_irq_vectors(stdev->pdev, 1, nirqs,
+				       PCI_IRQ_MSIX | PCI_IRQ_MSI |
+				       PCI_IRQ_VIRTUAL);
 	if (nvecs < 0)
 		return nvecs;
 
-- 
2.7.4

