Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D772603;
	Sat, 30 May 2026 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155389; cv=none; b=Ixf+tINAVWmUq4ToEUMHqIqFuFNReIDafaeSUAA3KvKlt2lthARL/oAwVT+l9EC3rxJPiYUjzBcvGqmrWo7Eon5e540v5h6FT9dDFKNFQWwkf7K/y963GbBNTVKnH/vq66uPr9S0ESagUOjr8ET3hO8BdJi1ssUFLK/CehAG14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155389; c=relaxed/simple;
	bh=KFNywJY77A37y9C7nyuYTxEOSJ8mD3bMQuXrniAKLF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBeDGKhpnPH6qR64Ubc3S3KidnMmxxs/l5nKILVw+/CljsDBsm9/aJ61fJto4WeQPLfTbN+k3udXz5UiZoz1kxCGH370sOzWJyuEcnzdTJe7FLowlTft8ETU9/a/9+cp5718zwMASGmVrNHvo/14m1/BQCkqf6WJeTUbyRDpkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m/NAqZd2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m/NAqZd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ff
	B7GrmVp8WAki9+UnmVSGGvKtwSZ9GLa+Vb7MYQ6is=; b=m/NAqZd21P60aUUhbU
	Pu5nR8SfSePKBWaGuAsf2PghhTDjRFvXtkX+E+YUktmaNorVAt6w0R0QfMUHy67k
	x2QY94Cav3EjXHTc5zTiJMk+JTK2iayw+yYnufWEA2M/IWbPutByMtw7xMbZX+xa
	aNsJiizteQSMnBMHDhr86QnYE=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S2;
	Sat, 30 May 2026 23:31:16 +0800 (CST)
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
Subject: [PATCH v2 08/16] PCI: dwc: fu740: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:53 +0800
Message-Id: <20260530153101.695580-9-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1UXr4rWw1rCr47Xr13urg_yoWDArbE9a
	4UGFs7ArWUKryFy3W2k3yfJF97Za47WF1UKa1rtFW3ZF97Xw18Wr9FqFyDJF48W34DXF1x
	JF4qvF40ka9rAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUec_7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AQTtmobAsQ6cwAA3z

This callback is invoked after dw_pcie_host_init() has cached the offset,
so we can use pci->pcie_cap directly.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-fu740, the call chain is:

  static const struct dw_pcie_ops dw_pcie_ops = {
    .start_link = fu740_pcie_start_link,
  };
  fu740_pcie_start_link()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index d0a34f680397..72c0a6316fff 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -178,7 +178,7 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
-	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 cap_exp = pci->pcie_cap;
 	int ret;
 	u32 orig, tmp;
 
-- 
2.34.1

