Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D3472793;
	Thu, 30 Apr 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566299; cv=none; b=Iv0lGOod5UySRsEm7NT8c2ZwU166Mzq6Y/y7Wkv/lZk6XU9xC3LUOZ7opup/XY1tU6F9vyZL95HJY2MaSzaYSEjWpL2mqnT8yCe2sZeF7XH3u5y7GLX6/y9o1WTqoXBfMLWwPFOmOmIHilGeq6SvfA3bk9mmRNW6hZ5w4rAJL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566299; c=relaxed/simple;
	bh=Dn8fTsOZ9GOWIt3xVVd8EqvKuV6qq4me2FvrTvXlIio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2btZRr+dCQcFK4+nnhkF9Mzp7xxebhJ22oOD8UYq7Eajl/Onk26BrYl08jcxrAsr11HZ496axvcP0heCZnUJ1lq+L/U0+MLBUxxvFF++E9xWHMsubLOQycUu1BR2Z6zGgo3lulY4OH7fCg1wo9auXlZsvgeFmC1boctZWDTy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QgNIAESw; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QgNIAESw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TA
	2PDtzRtI+kBQoqeedPsIvWorvQfdP/9rl8VrEEZwY=; b=QgNIAESwSwnr0w4I7l
	Ba5zKXw8xpWzZbCYOOr/0c5vk+GNNptFlBGaL3b4CHWpD0xIAeymuf4cYduZ0XKu
	cLxr/DS0V+I5lvmFmQkUNOfsvrWNXYVhA0KXolWM3T+qiLgUo0Ir6gADPCYK/gQs
	1mW7XmE5SQMbcxmCKZuCDEjM4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Df0_gvNpcypXCg--.51103S9;
	Fri, 01 May 2026 00:24:36 +0800 (CST)
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
Subject: [RESEND PATCH 15/16] PCI: mvebu: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:19 +0800
Message-Id: <20260430162420.42839-16-18255117159@163.com>
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
X-CM-TRANSID:_____wA3Df0_gvNpcypXCg--.51103S9
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr1UAw15uFyDuw1DAwb_yoWDCrX_ua
	4rJanFkrWqgryIkas2ya18AF90ya47Zw4j93WFqF1fZFy8Ar1Fqrn7X398tryDCF43XrnI
	yr1DCrWFk3sFyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiD73PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AQJrGnzgkROhwAA3Y

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pci-mvebu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a72aa57591c0..d6eb65b8cd7f 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -263,8 +263,7 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * not set correctly then link with endpoint card is not established.
 	 */
 	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
-	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
-	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, port->is_x4 ? 4 : 1);
+	FIELD_MODIFY(PCI_EXP_LNKCAP_MLW, &lnkcap, port->is_x4 ? 4 : 1);
 	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
-- 
2.34.1

