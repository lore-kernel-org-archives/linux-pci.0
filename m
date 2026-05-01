Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D63F076C;
	Fri,  1 May 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651863; cv=none; b=h2TPwMNc6gFwa8UL3G6tv67f2224ahydwDLrUP/wHPkJy2zX6/08mQecZsXzROgBfpIQ8llQLJsDS+t2MK90WeeErNlA5XdkQn30MebPrCLM46hwXM7B4Q64WglBRUNwAhJktWmx2ENbVTITj9FXpita1WOM8aEiVDg7W8dfNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651863; c=relaxed/simple;
	bh=8k+27dFEfk9gvTOLyx3sRRHfGTcjySdSAWkUG6LSWcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fj26HAYurbyk5UFlwqdYl3QM9QpXyuOlC6N6caJDXpFyax2buootoWZhtIqiyc1s7xHTgpMhgin+rGV1re+gATQhknev9L7Wto8QqiM5ENm2isF7Kn2FYCAiiHjOjvES9BPJVHC5gOaRbHlrrASK3S9G17F1sT/rUGZJQ45fuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UHqoEiuE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UHqoEiuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iO
	UEMne7+s7Kfd5u4r0P7fMHEsYx2/gNI7ikiiDLoOg=; b=UHqoEiuEwLA5zVenqU
	pz+9iRF3g6EDDW+L0LS4e74nIEvuG0zhYDjn24w1m//6Ej8sz5B0xWH3XcR+nG0z
	ztv+nIhTsZ2ADyk3x3nIcqtEOxaT785ZNtHgayyRpO1+37Xtrjh/XU4Drj5iXJQg
	+QJ1pQHbGcha23ULZrxQbv6pM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnj5Fk0PRprTQgCw--.53438S3;
	Sat, 02 May 2026 00:10:14 +0800 (CST)
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
Subject: [PATCH 1/4] PCI: dra7xx: Use common mode field in struct dw_pcie
Date: Sat,  2 May 2026 00:10:07 +0800
Message-Id: <20260501161010.71688-2-18255117159@163.com>
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
X-CM-TRANSID:_____wDnj5Fk0PRprTQgCw--.53438S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur15Ar15AF15XFW7Cw1xZrb_yoW8tr1Dpw
	43AFWayF4rX3W5uF1fAF1qg3WSqF9ava48JrsrCw4xtasxCrn8JF4rA34j93yfKFW8uryU
	t3Wrtr4xX3WaqFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_Ma0DUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AfkiGn00GeBEQAA39

Remove the redundant mode field from struct dra7xx_pcie and use the
existing mode field in struct dw_pcie instead.

This avoids duplication and prevents potential inconsistencies between
the two mode fields.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index cd904659c321..88b4c486ea66 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -92,7 +92,6 @@ struct dra7xx_pcie {
 	struct phy		**phy;
 	struct irq_domain	*irq_domain;
 	struct clk              *clk;
-	enum dw_pcie_device_mode mode;
 };
 
 struct dra7xx_pcie_of_data {
@@ -328,7 +327,7 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 		dev_dbg(dev, "Link Request Reset\n");
 
 	if (reg & LINK_UP_EVT) {
-		if (dra7xx->mode == DW_PCIE_EP_TYPE)
+		if (dra7xx->pci->mode == DW_PCIE_EP_TYPE)
 			dw_pcie_ep_linkup(ep);
 		dev_dbg(dev, "Link-up state change\n");
 	}
@@ -828,7 +827,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	default:
 		dev_err(dev, "INVALID device type %d\n", mode);
 	}
-	dra7xx->mode = mode;
+	dra7xx->pci->mode = mode;
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
 					IRQF_SHARED | IRQF_ONESHOT,
@@ -841,7 +840,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_deinit:
-	if (dra7xx->mode == DW_PCIE_RC_TYPE)
+	if (dra7xx->pci->mode == DW_PCIE_RC_TYPE)
 		dw_pcie_host_deinit(&dra7xx->pci->pp);
 	else
 		dw_pcie_ep_deinit(&dra7xx->pci->ep);
@@ -865,7 +864,7 @@ static int dra7xx_pcie_suspend(struct device *dev)
 	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
-	if (dra7xx->mode != DW_PCIE_RC_TYPE)
+	if (pci->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* clear MSE */
@@ -882,7 +881,7 @@ static int dra7xx_pcie_resume(struct device *dev)
 	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
-	if (dra7xx->mode != DW_PCIE_RC_TYPE)
+	if (pci->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* set MSE */
-- 
2.34.1

