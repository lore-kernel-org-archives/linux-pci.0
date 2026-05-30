Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28514ABE;
	Sat, 30 May 2026 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155101; cv=none; b=XMAGscBt6TOCw35sZpsDpKNlMt9FQT2SGIN8GK59jKD2QUav39/xGNw9Si3VWgF1eVGoo7fuD6DUfJPeLerOcJMgv/6HWouL7sn8shqAX1iSkIzA/8n6iYApq8hESGWUysTyHfcQ+vcAvtg012//baDs2sFPsR5RQxWwxlcO8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155101; c=relaxed/simple;
	bh=CwQvJhYMmSpEtBnu8YgoO14KM8+fei2hTUBjvIMzffE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnOxItW8QkPBX+rFQe2X7L9wgt7vduwMIcoJOW0vG5mlLfmMS9th3tgR9N/Dsz1ihib++rh63/6XIgQWPvb8hq5gnzFlbrK0AdJO1zCygOJjSJ9yT8E6jkxHMBqCCyL4peYEPShT97/QGotgfUQThUpe1t627tk26u0oBFSnmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eT8GqHUC; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eT8GqHUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sC
	5IK7rcAYFVlcW/qRjCYlhzV8RYd8qBA49KkuguIVM=; b=eT8GqHUCGLC9IgExlr
	m7fELH0xN24rgY9XrNisOTFUZ76V/XRZclI+SkVjn9KyidK8trIHHYR82M7n1MN5
	YnvNpOPCp5wD52jDlJPooF6O9bQOElbUxlpAcNBVLka493ELYFo2q8UgPHlfmi1k
	4gEPT7bMi00N8RSm0gI5jJjHM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S6;
	Sat, 30 May 2026 23:31:08 +0800 (CST)
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
Subject: [PATCH v2 04/16] PCI: dwc: layerscape-ep: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:49 +0800
Message-Id: <20260530153101.695580-5-18255117159@163.com>
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
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF15KF4kXF1ktr18Gry8Xwb_yoW5GF1kpF
	WUXF4YkF18Jr4SgFsrZan8Wr13GF9akFy7J397Kr1aqry2vryUGa90yry5tFn7GFWqkFyj
	934rtFy7u345JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRByIUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxwRtGobArx1sAAA3w

Replace these with dw_pcie_get_pcie_cap(). The hardware is already enabled
by the driver before ls_pcie_ep_probe() and before the interrupt handler
runs. dw_pcie_get_pcie_cap() will cache the offset on first call, and
subsequent calls (including inside dw_pcie_ep_init) will use the cached
value without re-searching.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pci-layerscape-ep, dw_pcie_find_capability() is called in:

  ls_pcie_ep_probe()
    -> offset = dw_pcie_find_capability()
    -> pcie->lnkcap = dw_pcie_readl_dbi(offset + PCI_EXP_LNKCAP)
    -> dw_pcie_ep_init()
    -> ls_pcie_ep_interrupt_init()
        -> devm_request_irq(..., ls_pcie_ep_event_handler)
          -> ls_pcie_ep_event_handler()
            -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 8936975ff104..b2d0b51df3c5 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -74,7 +74,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 	struct ls_pcie_ep *pcie = dev_id;
 	struct dw_pcie *pci = pcie->pci;
 	u32 val, cfg;
-	u8 offset;
 
 	val = ls_pcie_pf_lut_readl(pcie, PEX_PF0_PME_MES_DR);
 	ls_pcie_pf_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
@@ -83,9 +82,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
-
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-
 		/*
 		 * The values of the Maximum Link Width and Supported Link
 		 * Speed from the Link Capabilities Register will be lost
@@ -93,7 +89,8 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 		 * that configured by the Reset Configuration Word (RCW).
 		 */
 		dw_pcie_dbi_ro_wr_en(pci);
-		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
+		dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP,
+				   pcie->lnkcap);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
 		cfg = ls_pcie_pf_lut_readl(pcie, PEX_PF0_CONFIG);
@@ -266,7 +263,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
 	ret = dw_pcie_ep_init(&pci->ep);
-- 
2.34.1

