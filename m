Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com [220.197.32.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EBE3033CB;
	Mon, 23 Feb 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861975; cv=none; b=pRVsI5MA5PJDedo3HnlyfQalyOBb2JLSLgdutHkUcWER+E6rhMOBmjGYj3JRIHFcI3JJKbCCWKufiqt1tlrRxO2bbjhu2Gw+eg+i4ECNGcGPHXuTcU2nu3tqr/W8j568N5bLcfWY+j4C6QqCC8xbUzknwhINqw2NfYBMAM59Drk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861975; c=relaxed/simple;
	bh=zhdoAFOwimAbX/YDgF3oAlOrDxI7cLwVlouzR5vH8QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KSCDBJesSUbMR7Gb/OwwIC6z8QE73c8yeq2GggAxYZhuSglI0z1QJigEZJBtSi9zkNeNFWihP5TjvYVqIFUdqOuH1S/WQiSwM+ddZ4s+jUD5j9dARujoM4Z5Mdpu/UTbH9Hrzbm0RaYyVvIMUwSfP/16x+oUaQgi0327+W8wS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GmaWRTB/; arc=none smtp.client-ip=220.197.32.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GmaWRTB/"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b3c934d;
	Mon, 23 Feb 2026 23:47:39 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 09/37] i2c: amd-mp2: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:47:28 +0800
Message-Id: <1771861648-86761-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b2f4c2509cckunm5abdea00987594
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJOHlZOThpISh1OTElKGUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GmaWRTB/SHIIc4hvqGZOWN4Vf7odJ9R5+tzNHyA9WWqCjV4P7DkeWLunBBPr6vA5nfQDecXqlPGWrsruYQW+Rv62AZBxNnsdEs9NWpTBT+taSe253X42fMDYeh+K7YFyxsqTd40gJ+jkLNhlOVWE5xsEZjG1QY9npj8CiyxKYPY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=YOk7ERkJ/dDc4K7Ffee84i+So2ncgnAnKDHdOYkFePI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Elie Morisse <syniurge@gmail.com>
To: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/i2c/busses/i2c-amd-mp2-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index 5b41d18..3f42899 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -313,7 +313,7 @@ static int amd_mp2_pci_init(struct amd_mp2_dev *privdata,
 
 	/* request and enable interrupt */
 	writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
-	rc = pci_alloc_irq_vectors(pci_dev, 1, 1, PCI_IRQ_ALL_TYPES);
+	rc = pcim_alloc_irq_vectors(pci_dev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (rc < 0) {
 		dev_err(&pci_dev->dev, "Failed to allocate single IRQ err=%d\n", rc);
 		goto err_dma_mask;
-- 
2.7.4

