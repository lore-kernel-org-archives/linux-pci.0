Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D2306B05;
	Mon, 23 Feb 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862561; cv=none; b=uBMEtiAHqTtybTfoe1LXDu0irYfkPseC54Ui0imCQZiCSga3vl7UVpH18dPPP6WJWrx1IW/rIgg9ud8S9krZ6EBaq4iw06sRx5Kq1UND74aDXbpZx9GvBmjiWQ2MCQ2d6H92EAhgHChJKuvU/uArUe5k3fJp6jFkdfS5IHFP6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862561; c=relaxed/simple;
	bh=682MTqbEMvXyYM8rVufWLn9LX94E6OivoY+dugwggw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d3+EgapGplWuJ1eGegEZhadNoXSncpy4ScFrGNHddiy+N3vqL8wk3cjJzR3JZ/YhnpG5ZiIetGehvkELYE8sC1Eyjd9P8S/R9tOdwn8iJ6qRIGeep0hCRtffDuZoZtCfe/1XRyL9wFpl99mlbau4TgHu5pJYXDbQRA2ynJardYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GcDrkksw; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GcDrkksw"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404621;
	Mon, 23 Feb 2026 23:57:26 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 28/37] net: thunder_bgx: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:57:21 +0800
Message-Id: <1771862241-90270-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b3842f109cckunm83f447bb988016
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNMTVZOTB9DGE5OTE4aSR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GcDrkkswovvkjwS9d4vtsWkbyxYI/fEdWz9IVsMcIjSjsv3+6r72jYtLe5DnRbAFojaz/zHy8dD0zd9z6fmOgZIBCjck5VgOXMp8sNyUqZIHXnDMuDqw/o/wXicff6IxeGjwUyKc3a8KxbZ0DvaoRvvnUuiCrqKrgbexGT8tDPU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=er8+quJvxlvVPi2NkqCpT1pGMtgkRw5DcqI1FsqomB4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Sunil Goutham <sgoutham@marvell.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 9efb608..8857ac70 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1575,8 +1575,8 @@ static void bgx_register_intr(struct pci_dev *pdev)
 	struct bgx *bgx = pci_get_drvdata(pdev);
 	int ret;
 
-	ret = pci_alloc_irq_vectors(pdev, BGX_LMAC_VEC_OFFSET,
-				    BGX_LMAC_VEC_OFFSET, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pdev, BGX_LMAC_VEC_OFFSET,
+				     BGX_LMAC_VEC_OFFSET, PCI_IRQ_ALL_TYPES);
 	if (ret < 0) {
 		pci_err(pdev, "Req for #%d msix vectors failed\n",
 			BGX_LMAC_VEC_OFFSET);
-- 
2.7.4

