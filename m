Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com [101.71.155.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44281E0B9C
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821477; cv=none; b=NybDkXLV98XJNTJNjRrnLBjkg8mvJMrktm+a4823W2PjtQN0iNKac13gVt/9fD/v3QWRyKJhUYy/9pOAcXPqbXM1Wj0ZR9KCcbRFMoEydZSVQVn4C6JJmWAEKDLWpSWZJGUe4BOgDsBH38jgr2QtbcbnsmmQ2zwymXZSEw5XPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821477; c=relaxed/simple;
	bh=6UxQKb63xa+tNFEJ/U2PDhdXIGYIRm5f3RDSvcjjP+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=METKglP44X6Zniujv8D/KdtozsjARejk1Hkb7oYpzWGwiIoQA3s3McjVEwHW9+7LkqUR0w6AttIHJvFR5bfvJwpM5JwtHOYRo5H5zFGRHCyaixn+qUOfhw+s/rW5A/leIdIgNBATQPFMAE0MpvGfwXV+sJjDTPMaslL3pQLd/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=G+ooHSr9; arc=none smtp.client-ip=101.71.155.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="G+ooHSr9"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba07bb42;
	Wed, 22 Apr 2026 09:25:51 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/3] PCI: switchtec: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Wed, 22 Apr 2026 09:25:26 +0800
Message-Id: <1776821127-234830-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9db2cb26a609cckunm4d4f8bca15df18
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkpNVhpJTB9OTU1DHhgdTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=G+ooHSr9lR3fLa6nAWMb43jvK89WKmaqeUx/jgpbECRFca/fR9GG8hRV8Dz9GN6jrNMXb6/LjNa7nxaJhKojV2QHcO0OdVVZKQ/3zLdREyAagJXy89zy1SCIZ7FP6CGfcejbelXPAjqoZOGhPb0Zf+FCjsWhEBGyguFj/qgb0uI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
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

