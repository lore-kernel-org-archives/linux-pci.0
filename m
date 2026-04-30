Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357B47277B;
	Thu, 30 Apr 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566302; cv=none; b=BBuglmvj6yH15b8xQj/6kYz19F04ZkefBDUOALa5bPrSX+AXnb8Bj5CxhJOfIF5PzQJuyYSeujVoEj4aDCzv/NyKIFXZ/ENJDuICoeDs83zqAFOj6sMzQqoqtmdc5Go11NNp3AChp/ReWPcoFGrbkOH8U+SWsG1/6x8mBNOdDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566302; c=relaxed/simple;
	bh=48RwPttdxZUFq0ycWhKKebZCeIv1wICIT4uEJXvm8oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bpaXsFYXGrSMeu5JvvZO6LRXJT4X9b4cJ7omRvIYGMlHgksTxSbe1yGndZ3LicJUJwWlJ0LqOcSlJg9KTttBs4PyUxX5f4fzWn0h0FQIqMgHHhhrL5rD4diW+eZ7lYf3Ss+8J7GrnPywY3SmqPP7kHaWsfej2/iOYdR/meonqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oahKvQ3L; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oahKvQ3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jA
	Vlhbb5fwv85oSekzGzmWm4cvS4iOhwz8Eg65D2AxY=; b=oahKvQ3L+z1nKceMKJ
	AGN8o3pErn/dgD+z3BOml8Up4rTGe9lru7MZr94W+tscNgnVhl5HTwiiLOneMJX4
	mRmcrxR3gu+Z2Z12nk7gbzxSNEksFtl513Z+uNp4mWbmPUan6HuUiZJVMv7KgXrH
	sWODiucDY0LU5M07bIjZQHwTw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Df0_gvNpcypXCg--.51103S5;
	Fri, 01 May 2026 00:24:33 +0800 (CST)
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
Subject: [RESEND PATCH 11/16] PCI: s32g: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:15 +0800
Message-Id: <20260430162420.42839-12-18255117159@163.com>
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
X-CM-TRANSID:_____wA3Df0_gvNpcypXCg--.51103S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr1UAw15uF18CFWxZwb_yoWfZFXE9F
	1DCan7Cr1qkr9rCasYkw1fXrZIya1xXr18Kas5tFsIvF4xGw15ZFZ2va98JF15CF15Ar9a
	krnFvF1xCFyayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRgmReUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AEIq2nzgkFOJQAA38

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-nxp-s32g.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
index b3ec38099fa3..31e1169b8ab6 100644
--- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -139,8 +139,7 @@ static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
 
 	/* Set RP mode */
 	val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
-	val &= ~DEVICE_TYPE_MASK;
-	val |= FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
+	FIELD_MODIFY(DEVICE_TYPE_MASK, &val, PCI_EXP_TYPE_ROOT_PORT);
 
 	/* Use default CRNS */
 	val &= ~SRIS_MODE;
-- 
2.34.1

