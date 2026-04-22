Received: from mail-m15580.qiye.163.com (mail-m15580.qiye.163.com [101.71.155.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA438C2C6
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825873; cv=none; b=tDZTZKsW/m2kycHs0t5WW8iYILEHdwC/NKP0jlBGdOiqvFR8CARyQhvdtgity09YTR0/got8I/TXTZZftIYQGwGflDiBr8vT8GI03RHDaE+wJzC2CZZJLubqMp5Bgx8iuuOc5zIolvRgq98pqK8RY89AFeVR1rNndLcdEXNE02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825873; c=relaxed/simple;
	bh=6UxQKb63xa+tNFEJ/U2PDhdXIGYIRm5f3RDSvcjjP+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M3XySbuaqonpfWgc0PmjiLOnRiUBDGA4AMimjIn/U0miE4/aiS+YX+hWC67n1PfII21kUDEifmCjozDH2V58/ILuMJKqqlQwTPQsNapO1NyuRXn5Taylzuy9SC80VYh/aHmNsmj2aTVr2bQebefBai9keye/WBqgnrzpENGjyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Nb4A+84a; arc=none smtp.client-ip=101.71.155.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Nb4A+84a"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba417aa9;
	Wed, 22 Apr 2026 10:39:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH v3 2/3] PCI: switchtec: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Wed, 22 Apr 2026 10:38:41 +0800
Message-Id: <1776825522-6390-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9db30e205809cckunm3ea616f516de92
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx9DVh0eHxhKQkpJTBkaTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Nb4A+84aVMf0wgHA+koYhh4gp6c8gxrGMkOCPx7Mr2CgNE3LwOi5tfuVxN44ILrNublqGob8AqbrPa3MKf087iia8wxGLHqQSgVBvSgTh+959ztv9PfwpOkll7/tGHhJTNBCKThYCTkcn7UUgYHxWFlradDvLanMsHchMmSTHl8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=O1SBrbHx2w7G6fEZw1xVAbYuyWLP0AGnjiAaELjLf8A=;
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---

Changes in v3: None
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

