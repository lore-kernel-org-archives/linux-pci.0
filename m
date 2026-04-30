Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317E472798;
	Thu, 30 Apr 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566302; cv=none; b=gyIx3V9m7oKN+GToXqfAcqvAp9RxPKMyeCtUQ7bOwLar38/nLIoe082KraVyeFVpxZjM3k4OZ8cbZ5upDcdbH3+saO8x87o2fGXZOF8iC0mGbiN3GcsRdT6u5cY34H4A0XBEkL1OeKA3dKXJ2Vag9QlfQ1d5cZseCoaEb4WZFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566302; c=relaxed/simple;
	bh=mKRbDHHs0pBDmNClLmPUI/k8yIq84PMezI+ZfgY5vhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8ScfpRklY42RmYksgmIGbm9LwICbbud6Y6AfF5pya/hWB0IvNCxrPx9OrmJ0YNBDnBIO+xr8j3YwAeaxwgSsadf8vTULaI9gZf18cnOy1r+7aKqSnXVwsEPylGKo9oawbrzvzp5aJ5yb8c1FpN577BweqxCGj5gPYMYlPLbEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kV1/8b8Y; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kV1/8b8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MK
	0nueE9kuPh+C6bezt4QBz2BNnFpiu2HHOSbx6DsC8=; b=kV1/8b8Y1kpvxqjJMC
	auDa+Mx1Q7oM2Vcau9f2AIxoFMicnagkwljriWG3tVNyjcAj75yyB+2cnmVHldP9
	VEultCh1EDze/ZbJNpy4fDOtbUrBxqcP8LdJoncP4fLmI8Gb1Hi1pURHyT94KL8S
	TJxhFqutoVKwEDLZuZXPl9qHw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHJXM2gvNpY8PXCg--.48992S7;
	Fri, 01 May 2026 00:24:26 +0800 (CST)
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
Subject: [RESEND PATCH 05/16] PCI/TPH: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:09 +0800
Message-Id: <20260430162420.42839-6-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430162420.42839-1-18255117159@163.com>
References: <20260430162420.42839-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHJXM2gvNpY8PXCg--.48992S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF4xGF1fZr48AF1xuFg_yoW8Xr1Upa
	yrJa4fKF9rtr1jyF4DXa1DXrn0gF9aqF97A34Ut39FgF47AF4xXasYyrnxtr18ZFWvvFWf
	ua9xtryjgFyUA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRPUUUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BoGqWnzgjpM7QAA3a

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

