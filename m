Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124B466B6E;
	Thu, 30 Apr 2026 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566293; cv=none; b=LwsqwVZTyXVvVQ7TyC8HpscUzzZqA6vsVihGph1LRNyEH/iAbOOd+740eK8P0NcH1OcE8h3GVBM+mrIvuS/+0IcaavLVwJ53Wpht+eQk9k0YtQghlUJil04XI7FycDsw6zx3AiHUu10s8zNOpywCLtHDAueVWr0IoL09/4v6Q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566293; c=relaxed/simple;
	bh=HG6wMmNzqQr/vAz/9YVXg/XRCGn+6x3TvxKDdZcRqNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpGi8W7ZfDVtBbzOfh68SndgbwDJjBYlQPbZk1myjDV8Q11WmVXGbpKBEXwnwM7eHCRUalagsqXcBqAneZKC7XLP2F/vh3ndrQ9zFOW2sj9idaf03aeH72vdR2QKd3/hqZlVjiGdSPBGo+Fv7qzVs+8polWf0VGOumYdBMvc4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RxOL757R; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RxOL757R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/i
	SkfsxQrBPqbPvZDhBTwfrh6nYXLR6KjN3mR6Z7XlI=; b=RxOL757R5fu3Ik6Rsh
	Bs8O0SaG65SjQpDqrwSJ2mwsE85szY+MATI8y2QADWCBft0SnNncx02tp7nwD+wL
	UUQkbVQKfThbRSNK1u8Jm1vU1S6SkyCAE09Hypv1riAiNzvacLNUXJE1tlhURiBk
	XBbz0bgaNJy0Zk3TJh341dsAM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHJXM2gvNpY8PXCg--.48992S4;
	Fri, 01 May 2026 00:24:24 +0800 (CST)
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
Subject: [RESEND PATCH 02/16] PCI/PTM: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:06 +0800
Message-Id: <20260430162420.42839-3-18255117159@163.com>
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
X-CM-TRANSID:_____wAHJXM2gvNpY8PXCg--.48992S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw4fAr17Aw4rJr1fWFg_yoW3Krb_WF
	18Zr13Ar1UJrn8Cw45Can7X3s0k3WqgFs7ZFs29F15CFy7Zrn8Wa9Yv34kJr15uF43GryF
	kasFqrykCFySkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_O6pDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xgGqWnzgjhChQAA37

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/ptm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index a41ffd1914de..bd3bd39f6372 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -152,8 +152,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
 
 	ctrl |= PCI_PTM_CTRL_ENABLE;
-	ctrl &= ~PCI_PTM_GRANULARITY_MASK;
-	ctrl |= FIELD_PREP(PCI_PTM_GRANULARITY_MASK, dev->ptm_granularity);
+	FIELD_MODIFY(PCI_PTM_GRANULARITY_MASK, &ctrl, dev->ptm_granularity);
 	if (dev->ptm_root)
 		ctrl |= PCI_PTM_CTRL_ROOT;
 
-- 
2.34.1

