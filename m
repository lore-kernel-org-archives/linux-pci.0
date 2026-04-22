Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com [220.197.31.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94B79DA
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826505; cv=none; b=Z+jl4ZwKxGyMB1KWu2yGfVJgJrcR/DNRhREHfqo53igYmwXn+xsVVg8pm3lh9zwoCyJtRy9bvUYSYdpC2w1xIn+6M8C7P3Aiw2qT/PgjHJYrJtEx2eL5fhfKyklv2B8Ex4WxKn5H30XIklZMsRwuQGjp6CZTKQdaWdGqCBZwIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826505; c=relaxed/simple;
	bh=OK3YYnLcx2i4ehxjcAAsRgSdgy4kpF9rBu4QmTsDpYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X3H2AgeZQ45kUMs/8btXdup5SExxR1w8C9haRUb6JMjq8FNmyg0PwgEs6WinILduzMrQTH1mnn3JyUH3SvE6f/M+HHs6IYoNi+LG3twezwqEcuxL459Xq5WUhYWD0DHE1WhHACrF2MK9bFOEzPZcyY4HKvgr+m7R5Aq1TleP0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LaEGISmx; arc=none smtp.client-ip=220.197.31.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LaEGISmx"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba417ac4;
	Wed, 22 Apr 2026 10:39:03 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH v3 3/3] PCI: vmd: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Wed, 22 Apr 2026 10:38:42 +0800
Message-Id: <1776825522-6390-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9db30e2b7a09cckunm3ea616f516ded0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUkZVk5CGk1DT0MaHRgfTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LaEGISmxYMEfAMFwWfmqya2PAKRHtQzdvM/gFsjvGU/s0C+VdmmNOS5RFrj80qj04U7niCI1Ldqrftl9r90sllWoG8UvRayFRtbqI6fvyBlDwwta9ycy1Fbhsi8dsTBAgwL+kDwEcmTInzOuC3GLGp+CvDpFtTZhGKpijBU/YgE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=tEXBenlFprHa6FEEe0Ln4EQ4v0tcPoFiis15E3/s5B0=;
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

