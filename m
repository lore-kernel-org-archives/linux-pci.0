Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAED472764;
	Thu, 30 Apr 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565635; cv=none; b=Cb7Hps++RSNy9ptNTfS0CjBwEnuOokjvx2rE1D8NIlMHJRe3mFoUZ/aVOXb2LSkSTNRo2MeRz+1i4cBHKePxWtPfYWQI6/3hMZE+rzUmyt6oDe1RE16obOCTUp6eNGEadsySbAk76eUMsQdnq6LmIr7GI89oQOSHKaC9oKhJjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565635; c=relaxed/simple;
	bh=HG6wMmNzqQr/vAz/9YVXg/XRCGn+6x3TvxKDdZcRqNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNHfgGKQOu11KrqcGlehk/oTAFWK4rOR4YXL2+d1vMFhxyCGa3lWpnvyd02GzloYYhDcjH52GvnuC9rRha3SeW1DEOPdktQkRdG/cG/AIPxrKUS3Plc5LkH4GfxOOMxfj5MhJYjgyubt1cl7faY0fGsJjlKim9C/ZN7PrHUsuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EKMKGnT9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EKMKGnT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/i
	SkfsxQrBPqbPvZDhBTwfrh6nYXLR6KjN3mR6Z7XlI=; b=EKMKGnT9bPw3JYVSS3
	5ax9NVAtVeM0B6aYcQIOp/4/emZvGl3qcARzH/N9GI+7R/aWbFCdEZcte4e70C59
	zB7lPehIvs00xBQxhpY6mtjStxDf5F+C4ydV80Z4icGoTg2loL656ZsOit4zToyV
	UDHNhADGw/g3Tk0gRQxxN6M1A=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S4;
	Fri, 01 May 2026 00:13:26 +0800 (CST)
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
Subject: [PATCH 02/16] PCI/PTM: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:40 +0800
Message-Id: <20260430161254.40278-3-18255117159@163.com>
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
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw4fAr17Aw4rJr1fWFg_yoW3Krb_WF
	18Zr13Ar1UJrn8Cw45Can7X3s0k3WqgFs7ZFs29F15CFy7Zrn8Wa9Yv34kJr15uF43GryF
	kasFqrykCFySkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMWrWDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwZgBGnzf6b1twAA3g

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

