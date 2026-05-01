Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE313DEFFF;
	Fri,  1 May 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651868; cv=none; b=NR9ICU9+WUh7xDjsjgZah8XLItMSYr0voxX/X61lEGBYzebr6VCcpPcD1FvBrwWsIFS0w0t7ObUCj/Xw957THzG5BsBgfTAuRcRgzQPxWUg4XyBQbQqPuowvKObVrFnW5YSkKwPcbygkSlQD5NzsKDYu5ObUvEwIDD7RVunNGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651868; c=relaxed/simple;
	bh=qCZ7+FTUS/Hn//6ThtgbDIk0bVz7oxOVsARIacdR1e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjsMyQS4DoLVvtJVRPrb+MhXHf109U4Qq6+VQa43bQTzcCBQXxtVLY5ONviRSTFr/5ap3R+NvLr3L7P7Wok/KanVBap+QRhZkKZ9OSV5aCx1wty5HJ4AXv8MnE2R8+kh+P67UuehsgsmmR647pwmJUAcVmuVmPFBIV6yvYiwNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VH3tuX9G; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VH3tuX9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dg
	kPg52SHjT92fZN3GmRatnnw8IkUdithEYIjhUqkSk=; b=VH3tuX9GiChBrryzX+
	Ogmg3ll6UEhLuWyz9H+7fca2L+Cwgpjs11ynbugXlN7Q2idJcD2T6iEiWyy0ESA0
	iHlqbUOAmYnEBLhz108QFxVgJtQISIMhtk+YTXNtCAWHoHUkNPikPtJVHt3MreNU
	9GzYbW4NbrUwhchj5FGtzH4l4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnj5Fk0PRprTQgCw--.53438S4;
	Sat, 02 May 2026 00:10:15 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org,
	vigneshr@ti.com
Cc: xrobh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/4] PCI: artpec6: Use common mode field in struct dw_pcie
Date: Sat,  2 May 2026 00:10:08 +0800
Message-Id: <20260501161010.71688-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501161010.71688-1-18255117159@163.com>
References: <20260501161010.71688-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj5Fk0PRprTQgCw--.53438S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UZFy5Xr1fGw43tw4ktFb_yoW8uryxpa
	95JayFkr18JF43ua1fAFn8ur1ayrnIvry8J39xW34SgFy5urWDGr1UKFWxtFyS9FWktF1j
	y3WIyFyfAa13ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMksqUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwfkiGn00GeC8AAA3w

Remove the redundant mode field from struct artpec6_pcie and use the
existing mode field in struct dw_pcie instead.

This avoids duplication and prevents potential inconsistencies between
the two mode fields.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 55cb957ae1f3..5cd227dda9a1 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -34,7 +34,6 @@ struct artpec6_pcie {
 	struct regmap		*regmap;	/* DT axis,syscon-pcie */
 	void __iomem		*phy_base;	/* DT phy */
 	enum artpec_pcie_variants variant;
-	enum dw_pcie_device_mode mode;
 };
 
 struct artpec_pcie_of_data {
@@ -100,7 +99,7 @@ static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct dw_pcie_ep *ep = &pci->ep;
 
-	switch (artpec6_pcie->mode) {
+	switch (artpec6_pcie->pci->mode) {
 	case DW_PCIE_RC_TYPE:
 		return cpu_addr - pp->cfg0_base;
 	case DW_PCIE_EP_TYPE:
@@ -413,7 +412,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 	artpec6_pcie->pci = pci;
 	artpec6_pcie->variant = variant;
-	artpec6_pcie->mode = mode;
+	artpec6_pcie->pci->mode = mode;
 
 	artpec6_pcie->phy_base =
 		devm_platform_ioremap_resource_byname(pdev, "phy");
@@ -428,7 +427,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, artpec6_pcie);
 
-	switch (artpec6_pcie->mode) {
+	switch (artpec6_pcie->pci->mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))
 			return -ENODEV;
@@ -464,7 +463,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 		break;
 	default:
-		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
+		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->pci->mode);
 	}
 
 	return 0;
-- 
2.34.1

