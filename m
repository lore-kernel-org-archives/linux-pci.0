Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5B428846;
	Thu, 30 Apr 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565633; cv=none; b=Rbw4/A0h53zsII8gr3nJUc1eCiEqNvr0UVLRBjIhLBl//SmIMKZI2DenN9OVuOoQoAEBLEowF5SE7Gfpn4EIH1W+QvYf3ApiYuBpHC/30mvcuJv+X3RZy8rSojqtb1tC1EJm9pseUo4UmJh9UjF2Ou8ge5T2kPvs1tAZZasvAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565633; c=relaxed/simple;
	bh=mKRbDHHs0pBDmNClLmPUI/k8yIq84PMezI+ZfgY5vhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5H1mIpIB0QMk8hmrCk/yXWkUnyHwlY5IHXj+AEHQPSomQ07PgWf6o7o4sFvWfk6IT37aoIJ7ZhHst5Z4+lm+foH8mWXh7yGAqj9EVVA4p/e7pYi7Yq0K5AH0HcdcLO3kezcWVg2S2tqQZ41xade3NnLSkduIiTrV2FesiTvD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aZ6rsasI; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aZ6rsasI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MK
	0nueE9kuPh+C6bezt4QBz2BNnFpiu2HHOSbx6DsC8=; b=aZ6rsasI7ujYDvUTIu
	sPRpVd/Pl10MsbVr073EEOEFPrBLeiQsLQbMwSSr1SkD+Uwb87e4AzGq7ckQfBx0
	kZvUskUdcVh22ugrgGoP2dUQILBn2pWrEhjoW8MP1boQm//MoTsyhRw3pwz5MKFt
	EtrGt2hjGrPqikjrAMuCeSy1w=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S7;
	Fri, 01 May 2026 00:13:28 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	s32@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 05/16] PCI/TPH: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:43 +0800
Message-Id: <20260430161254.40278-6-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430161254.40278-1-18255117159@163.com>
References: <20260430161254.40278-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF4xGF1fZr48AF1xuFg_yoW8Xr1Upa
	yrJa4fKF9rtr1jyF4DXa1DXrn0gF9aqF97A34Ut39FgF47AF4xXasYyrnxtr18ZFWvvFWf
	ua9xtryjgFyUA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkOzsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwhhBWnzf6j1+wAA3s

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/tph.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..655ffd60e62f 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -139,8 +139,7 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
 
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
 
-	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
-	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
+	FIELD_MODIFY(PCI_TPH_CTRL_REQ_EN_MASK, &reg, req_type);
 
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
 }
@@ -427,11 +426,8 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
 
-	reg &= ~PCI_TPH_CTRL_MODE_SEL_MASK;
-	reg |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
-
-	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
-	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
+	FIELD_MODIFY(PCI_TPH_CTRL_MODE_SEL_MASK, &reg, pdev->tph_mode);
+	FIELD_MODIFY(PCI_TPH_CTRL_REQ_EN_MASK, &reg, pdev->tph_req_type);
 
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
 
-- 
2.34.1

