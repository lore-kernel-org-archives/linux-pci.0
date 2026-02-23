Received: from mail-m3294.qiye.163.com (mail-m3294.qiye.163.com [220.197.32.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0D303A26
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862347; cv=none; b=lUZmV/QFefH1GhalfcSdlK+8gHU650AQVV6F+oL9czDDmkC73w1Kbb26eYHYzG4S0sW/94MNhz0DZy26tIZ2r64DfzHx7ceDdzPPDlNH8tk9jB8N4qleQl4HIMfz3QxATIA4l/Qgx4KWh8c2vsltoxXRRnL2lY3HpXZJBXyEAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862347; c=relaxed/simple;
	bh=FvsuT97iDUezd+6wk+6zbuTx9wKn3tMyNCAq0lMJIpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PN1XUDDH0JwqRHc3a3/QLtAjbsJTDywtwYm0P/t44zhG0CH76bNiw2ybcmDiJvFGtdsItjW0hzLiGuFODuNKb1jCjV43YUNOlwbik/++I/Cfq0KB95lDFJvZMu+stUzNh8dpnNy4ZAwFec164VigVfb4PstC+IaMHBYzddoFQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YNO9v1Z6; arc=none smtp.client-ip=220.197.32.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YNO9v1Z6"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404656;
	Mon, 23 Feb 2026 23:59:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 33/37] i3c: mipi-i3c-hci-pci: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:58:58 +0800
Message-Id: <1771862338-90817-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b39b9e109cckunmf5f76d2a9881ba
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1LH1ZMGkhMGUxLSE8eTEJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YNO9v1Z6NhYs4X2lshtGqHdv5eLghlB+AZQv1cm2dgedCNUITfes+pb4VAx9JxTmAzQDkc2MzG7GjaJEQCnRGBQM+Xhc+J3oZLqtjOEgIvVs7A6SZe388WvfWlN+1yL7+n465iQHhtaenfpTgjGZ7s4ySk6CKgnGmk6PXdR0WB0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=WjRyROOuQkm98HjtuYvshmAzggKr91+4U1QFqEn0zbw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
index 0f05a15..4753008 100644
--- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -282,7 +282,7 @@ static int mipi_i3c_hci_pci_probe(struct pci_dev *pci,
 	if (IS_ERR(hci->base))
 		return PTR_ERR(hci->base);
 
-	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

