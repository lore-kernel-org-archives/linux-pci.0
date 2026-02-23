Received: from mail-m1973188.qiye.163.com (mail-m1973188.qiye.163.com [220.197.31.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD441EFFA1;
	Mon, 23 Feb 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862671; cv=none; b=ufrDkiDtkocNbW6SA3dmnrMkzSklmojV5/PfSz1CSJuxRhxljd07Wns2ivwOCCVby8pcDEPt1irEXcjlXeHnzzbcn15rDtytSaZcrRJNk7JPAs1YF4Z7uh/j8nKCS4EzWcNyFvu0Iv9s1ogmD5+ZPTMFQw7kxfS6lXWOnnSRY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862671; c=relaxed/simple;
	bh=htURhgNjJEiyd4hyYMIdJ5hp2g47s5ciZ8cPcg3ZCrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YoZj9CGJ38fKPN973UbXI7qWsQQy6iecPc1/DAXetoeLOK4GU3fvnylDVoQeKAYXChOyvo8Q0tjU1J+6OM/9cnCm+ite/IsfwSo/Jv89KNwvsv89vQC2mJ/HOIGQSKaYTEB1YSkShRJJApEts9/PSnZarIIvXhiE9mlGsi20pwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GdrkVAYC; arc=none smtp.client-ip=220.197.31.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GdrkVAYC"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404664;
	Mon, 23 Feb 2026 23:59:16 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 34/37] HID: intel-ish-ipc: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:59:12 +0800
Message-Id: <1771862352-91079-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b39f24c09cckunmf2f6ca529881fa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhKTlYZGB5PGE1IHx9MTUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GdrkVAYClHkRd99fQHsXXcMDqkOIOJL7EzjxVcPU3/bePXeg1jgBYXGKFyNL0fWql1aTHpjdTYb8PRqeKY27sstkPKXiFpR8mSCWVoysu114pkUxAosewcdxcYVbi7j20SbJt/hXd/sOG2p0Otlspsi+ucGR2sxt1n6GAJVdTbw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=boePAoE0cLPm1w5Ue2MJa1zgsePCHQR+ObVAZF7tmtk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 1612e8c..6933986 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -209,7 +209,7 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ishtp->pdev = pdev;
 
 	/* request and enable interrupt */
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0) {
 		dev_err(dev, "ISH: Failed to allocate IRQ vectors\n");
 		return ret;
-- 
2.7.4

