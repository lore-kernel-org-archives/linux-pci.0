Received: from mail-m8132.xmail.ntesmail.com (mail-m8132.xmail.ntesmail.com [156.224.81.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4837F8B0
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.81.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890024; cv=none; b=VVUTV4nRP/pLQG5tMPnd8Y1SM5QkSRjuSc6IziWGXAvp7nCnuHMWPUVpfnkKuBRvHL5NO92FnLw8ChI1GCQQGmkPEV1Kqd3UOfYae9FXcNA1nDw83TbQz2YxNwBS4oz7lt+Z8t1hfQ21Itk35uBwn/d9vY5/Uq9V09nlm63+kwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890024; c=relaxed/simple;
	bh=Tr5rpOmnIkWq/5q13H3fUoNVDX06v0Igl0YeiVZ0CFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P3igRi1ZUbaggTHmqBYwQkpNInz8HoZrwg3sTAhaCXOEOS2bhRieuxI7bZiEx49IoDwSb2DzkxFQmfw+qQvCDPfkszfcyJbGlp840RtWPVXZU5ubVB5iPK0AH4lFMQ2uy19ZIds46fTOiN9AQMJ0Sjrb+Gv+qzNZYrDXkSYfbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aN7THkUm; arc=none smtp.client-ip=156.224.81.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aN7THkUm"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b3c91e3;
	Mon, 23 Feb 2026 23:43:53 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 06/37] PCI: vmd: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:43:45 +0800
Message-Id: <1771861425-85632-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2bdbc509cckunmc13620789870fb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtDSlZMGBhCHUhDGU9MGU9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=aN7THkUmSYfbWJpVLAqYaJdRBrcszZyf5kq3kmYKqQTfxAC91dhGbcDwyEIuG3fGkDuGX6Mgb15O/6IEYDrifC+rEZF9yYBm6Goo3+7Aj4ufvRfYsC2AtL7EMA4wMC4qFJ8I3QIGDIjM2AzBjO9+2kNv2d8Z+fOCJNtxCbxFIDk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=aRLsu5o3PDui1IgL5lIBC4ONbhZYNaxjwLFZYD4r4kk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/vmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index ec6afc3..7c3db78 100644
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

