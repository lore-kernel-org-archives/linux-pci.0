Received: from mail-m12894.netease.com (mail-m12894.netease.com [103.209.128.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F5329C49;
	Mon, 23 Feb 2026 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866691; cv=none; b=KumhN+GCz7sSSRmHkoHBO8uw78VITst1qcEQgjHl13J9PMqAtMt0fJL9iJRB4Bwy+RO29U3z3jlLQ4XmCExZ+PKLutKrfYwnSUG5u6ay9K5m57p4EtfjkK+J/U5dIffi06dD5F/+klhW0bUjyiyiG6c1tjiin0OMiL6T1QhxL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866691; c=relaxed/simple;
	bh=HDbUMH5fLCW3QDujMYPW6hfScbc2Q7nQozPx79oCCAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qnBRIaf3D0Rh1TRsJugTd1n/Ef/Gm9gJSGfxPgJwTDd91015MKb6teA+S/aF62z3uM9MnR+Mg7IbC0D1icl2jDjgSyelPiEpzfJjXGKxnpA6Uczw2N0FkcxXbEElVUnC0IIPHJ51VWstdZLWKtLNmQ12WO6bXGOoM1WMUX0g5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dVSoW8g1; arc=none smtp.client-ip=103.209.128.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dVSoW8g1"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4045df;
	Mon, 23 Feb 2026 23:55:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 25/37] accel/qaic: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:55:43 +0800
Message-Id: <1771862143-89507-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b36cac509cckunm2c284481987e59
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhkdS1YdQ08ZHk1JT04dSkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dVSoW8g1lEI3HkEB6qjaZRW4c9soowDTVMHkEgroBTKM8VWjhfseLOy4FI+2x/5jgz6wXVSuPmsJzTmDFf8t6dvsXUHTIfS3IUSQZb6GGJNczS1QMpXh/6wXvRLfABeIRnWaceT/Xa5Qs0wpg7Yt8zpsK1EnLFn3P3UwG84f614=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=YC4f9L+xeX6KWxsvQnkRnBIDjAYLF8oj1n+EW/lf3qs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/accel/qaic/qaic_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 4c70bd9..2b2e0c5 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -525,9 +525,9 @@ static int init_msi(struct qaic_device *qdev, struct pci_dev *pdev)
 	int i;
 
 	/* Managed release since we use pcim_enable_device */
-	ret = pci_alloc_irq_vectors(pdev, irq_count, irq_count, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pcim_alloc_irq_vectors(pdev, irq_count, irq_count, PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (ret == -ENOSPC) {
-		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+		ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_MSIX);
 		if (ret < 0)
 			return ret;
 
-- 
2.7.4

