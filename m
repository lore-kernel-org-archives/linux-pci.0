Received: from mail-proxy25256.mail.163.com (mail-proxy25256.mail.163.com [103.129.252.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA830674D;
	Sat, 30 May 2026 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.252.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156405; cv=none; b=Teb/UtfutI8yI180gSh7Utnx+OLofgct2wtemKEX+bggu6i2dRPu3CpKv43Ppdod9iJiEjsYWPP3E/VQjFRJNTlAf6hqbFeIn3sGG5V6NDKzZqdsYK0JIKpqimhQW0hKx3Ez+ztL/S1oHOadyooOi1i0dA73LyNe8p0v3q+H9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156405; c=relaxed/simple;
	bh=lUMJBA5oUnnTXQALxg7z88nPxjG8v70kIBk50sr5d1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N30dsHM2kVPvil7g1rlym0ac4uB+KtkvQnlHvMTB4D/HP27aJXR5HT55CeHH1joRto24KlVoPtgSjjTVJ+TRViO6GUsmV9eO/CcgBFymOSP8s6wvOXZBEKHuTV+0J86OqnhojFu/vy1adNrvUdfkfhn0hK3Psn/LpSrbiqY8h1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ie2fyZmw; arc=none smtp.client-ip=103.129.252.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ie2fyZmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/i
	OTdtu/aTwGdJUNHIqJwX0fu5L6Cd4Ns7bFgW3B/CE=; b=Ie2fyZmwHRchW0mM3Z
	c5uqFeKgNeypIeGngV++7kvMTqHvybFfpsyeJI29xvf7VdPuO1MXVsdkU8g+EgMH
	I0IlKzP8MljJLZUAgjAn+g99A51EtLdyR/JaL3PYUoikFSQCmfiOJ79FHkIDggc7
	7so96tXQBZmKSKnNOzpNaaxD4=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S8;
	Sat, 30 May 2026 23:31:20 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s-vadapalli@ti.com,
	a-garg7@ti.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:59 +0800
Message-Id: <20260530153101.695580-15-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260530153101.695580-1-18255117159@163.com>
References: <20260530153101.695580-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1DKr1kCFyruF4ftrW8Zwb_yoW8JF1rpa
	9xXry2yF1rJr4aqr42v3Z8Xr15t3s8urWqq39akw1SvF17CryUtrW5t34YyF13WFWqyry3
	Kr1Uta4xWF98Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRmhFxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AgUt2obAsg7AgAA3F

Inside .init we must call dw_pcie_get_pcie_cap() to obtain the offset,
because the core has not yet cached it. The hardware is already enabled
by the driver's own initialization before this point.
Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-spear13xx, the call chain is:

  static const struct dw_pcie_host_ops spear13xx_pcie_host_ops = {
    .init = spear13xx_pcie_host_init,
  };
  spear13xx_pcie_host_init()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 01794a9d3ad2..6e4c11b497d4 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -122,7 +122,7 @@ static int spear13xx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
-	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 exp_cap_off = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
-- 
2.34.1

