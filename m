Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CD3C5DBB;
	Mon, 20 Jul 2026 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560119; cv=none; b=T7VhXIWHEJdi6XhonTRGa24i4C5ZixKMgekc+YIbneug1Mi6g1vSU3DTNSpvyUkqh1C2neLZHrkYEfgHXdzdb18mVIQEejEp5kDVeusrsy8IP28XjcJwJ+7U26FOHjD9b0VMn3EfeCdcgGdZNj+LPhTdsyVyQGIDlGJ3Jw1YkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560119; c=relaxed/simple;
	bh=7kuZgxbRxcfBpcO4AlzJeBjtFJr6PEda/pW7p8B9V/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQKKe+YQSBu5jEq55M+AvUtCMgzetbeydkkouiJprr+ENdLtdMxo2V+ZN5J8mC1lNDBxHeqgIt7eEpix0tMMjNsEHV2pToXKaxXbmZqJDYwazXWZwwoqLWnpYedcGl/imfRYZNgRvAAV+ox7QKtLgRu7NR2vI9vGWh+cneWlT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GF+PwHNR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GF+PwHNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rb
	JVHVOturhJVseaFdgCutzkTWzNq56ytxEmv63ILZM=; b=GF+PwHNR5pTt4PDsWs
	T0s0PiiqjMWesPjJyyiowX5dFZfrnnirwrFYBQhSP0lrzpNSqY6cgjdv2QOJuIqq
	tIl5UUx1O9sm7a+L/BKoT/KuyihjJDqUqhlhhH1t+I8P1+BJiEsvrNc6nopIbVDj
	DvRKjT+EbgW3o8RLRY00CQ7rE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S7;
	Mon, 20 Jul 2026 23:08:00 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 13/16] PCI: dwc: spacemit-k1: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:16 +0800
Message-Id: <20260720150619.24733-14-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1fWF1UGr15JF4rXr1kZrb_yoWkCrgE9F
	y3Jan7JrW5Cr90k3Zayw1aqr9Yy3y7X3W09a1ftF98Z3Z2qw1YgryDZFWkAa1UGrs7Xryf
	Gw1qvF1rC3yUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNVbytUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBC0WGpeOdAGWwAA34

Because .init runs before core caching, we call dw_pcie_get_pcie_cap()
inside k1_pcie_disable_aspm_l1() to get the capability base, then add
PCI_EXP_LNKCAP. Hardware is already enabled at this point.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-spacemit-k1, the call chain is:

  static const struct dw_pcie_host_ops k1_pcie_host_ops = {
    .init = k1_pcie_init,
  };
  k1_pcie_init()
    -> k1_pcie_disable_aspm_l1()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 04241df8fd59..3e741324f44a 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -116,7 +116,7 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	u8 offset;
 	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	offset += PCI_EXP_LNKCAP;
 
 	dw_pcie_dbi_ro_wr_en(pci);
-- 
2.34.1

