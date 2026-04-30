Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411945BD57;
	Thu, 30 Apr 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566306; cv=none; b=oQTL+2pmJ0veDRi7Sgp7sbkz87HM2ZLjkIOspm9SsWU74jvupgNsy7hN5lfaqdhztOkP9W3EskeR5eD0HctUpmycpE85eqy305XpVgMFVgMaU0lPQ7ElET0NRTOy8BJK3vV6cX7ZxR/W0yxYnfPMGbIoqeJXir5drvMdh7g9TcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566306; c=relaxed/simple;
	bh=zGya12c0o5aRiDVzH50QTYenNbVMFV+ylKxK3Bd8OSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9JeCFy+NMsFhiV7Ime8OC4wI1LwzDZvPB43lBVySTmV4Wn1CjLYYLfqudgLDyBil8j8IaRWShusTzPQ3SElusZH1RmoqE9nZDf6KKjUD6wZwWjJ5nn4qo6przXDOYM2r6dzi7+19epkL5pRrQ8ABAxtVY3ANGRjnwyqYPIn3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fpuQhOZp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fpuQhOZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SK
	nNKCXhsL/SUQcuaVtsiDGDwFzkCFIi96zkjl1hpAY=; b=fpuQhOZpaGB6/bScYo
	eQZsM/1Lqg0tg6XacRT3Xt5i9rQMIk0fpwYK+pPVCTkb1keV/2VyK+WZlL2MHsUa
	d17UeYsn9BjkfDpjwcilaJA8fBMeuZ9u6RVeJ9djsRFDss5hGZujoFsy0RGOzwFG
	+BDAQlrTAnOO4Ig+Iuo8Y1x0k=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnTp9HgvNpIh98Cg--.30330S2;
	Fri, 01 May 2026 00:24:40 +0800 (CST)
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
Subject: [RESEND PATCH 16/16] PCI: mediatek-gen3: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:20 +0800
Message-Id: <20260430162420.42839-17-18255117159@163.com>
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
X-CM-TRANSID:_____wBnTp9HgvNpIh98Cg--.30330S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr18WF4xtFyrXw1xuFg_yoWDKrXE93
	9rJF4fC34DKryfG39YkryrAr9Yka4xWw10y3WrtF1SyayxuF1Fqr9avrWDX3Z8CFsxJF43
	t3WDCF18AFyxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUb_-PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AgKrWnzgkhPPgAA3i

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b0accd828589..f36a616a8b52 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -494,8 +494,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
 	if (pcie->max_link_speed) {
 		val = readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_STS);
-		val &= ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;
-		val |= FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie->max_link_speed);
+		FIELD_MODIFY(PCIE_CONF_LINK2_LCR2_LINK_SPEED, &val, pcie->max_link_speed);
 		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
 	}
 
-- 
2.34.1

