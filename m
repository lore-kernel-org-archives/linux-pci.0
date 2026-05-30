Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CC29ACC5;
	Sat, 30 May 2026 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155249; cv=none; b=RBAUqR5EqJjs2B1SOeTSXMyFUJRhbFNHVLsEkBUu3G+0C16ZaINiZznl1ifjISoifmDhKRLkMgfk8PMianVyuVA2l/XfKPnylGIn3ci+KjIKGSLF/EigY8Gm+uFh2pQp285VlfH2RX6/OB83b/a1mV/9MXUV9pWZjXFLhPetZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155249; c=relaxed/simple;
	bh=EMeMc0iFRqLpL/KQvt8hykCRj2VOWWvM4KBs+phGhsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MD5vDZ+G4IfPeyMiCkHFxbT+H3AU8MNQkylcJhsylwppJUZjAX7jfYw71YUPyws0V5Fsmt8SnCKZ9zryaLSL0vj3+NSCXJZc/8mLeNRA2lqLV2yvD5jg5Pnu/a5BEtpK7XLMS/b2o655cWkl7M2fkSe7CN3RaINr48bJyoDRyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RurMCD4Z; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RurMCD4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=17
	vIuTQTz9uvJnUYcBHWYZyruRUvjU3S7yCS0jwplyM=; b=RurMCD4ZVZVttgWP95
	9yKIEkUa+rWBfDnyUJQ05VFTBeEeDFpuJOZc7ewnOSqheotV12FfAqIhJrnQhKjM
	U9ePatb44xOkmE0lm40QnMl+v7kZPsmkq1TimEFm9D2B9uCIZdyL8aeVjHd0h07X
	XXaJ4VdF+LaX6FEgmoOvwe1pk=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S7;
	Sat, 30 May 2026 23:31:19 +0800 (CST)
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
Subject: [PATCH v2 13/16] PCI: dwc: spacemit-k1: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:58 +0800
Message-Id: <20260530153101.695580-14-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1fWF1UGr15JF4rXr1kZrb_yoWkCrgE9F
	y3Jan7JrW5CF93C3Zayw1aqF9Yy347X3Wj9a1fKF9xZ3Z2q345XrWDZFWkAa18GrWkXr93
	Gw1qvF1rAayUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRivtC7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AgUt2obAsg65wAA3h

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
index be20a520255b..65114060311e 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -117,7 +117,7 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	u8 offset;
 	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	offset += PCI_EXP_LNKCAP;
 
 	dw_pcie_dbi_ro_wr_en(pci);
-- 
2.34.1

