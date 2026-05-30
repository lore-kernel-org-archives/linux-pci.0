Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F032A3C8;
	Sat, 30 May 2026 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155287; cv=none; b=JMlcI0/ov+idIG9Ks0f72dteWzJOME4wdQ5Q0ltticGGxJ4hogHSTaRwHaKndnxlxLJO9i9YQb19ahhEHmkweMtcqR2yKKo4iqeTlKGdERGvYuyDISNv1lUEN5V0gaueXguwVdDx6aYtozY+ZvPgauZzMDdC7cYUeqUusAxTGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155287; c=relaxed/simple;
	bh=N1TShthPn9rUPSZ+2yN+sDQYtHm+uGmpLssiL43nVLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3OqQt0b/XAD0Q2tV9zyuCiCdjUGRuJ+YIF0WjUynkakn4gY+vRg9tVpWJwEZPLk7clHS3t0AMlTt59cCdn0AuQYd4FIpyi/l69bnEWGwKhb1a8IgIOfbrfj10MBM/5XnQmh31Q6Ne8M0vXB2O9T+6B2+NjYFVAnzeZX9q5CCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kuH9ZCz9; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kuH9ZCz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qd
	ed8qtg8gBqgYZffeHxwLl0uI091V0a/2m+Nc0wNUE=; b=kuH9ZCz9Rf5Irhorur
	wiQ6HP4y1d51CEg0fPq54NdtEzREb/50fJ1L3SLOkkEEhjELCqJpSKzLiW9iux49
	EV3OEfl+XmKhY/LywBvlgdT8LI7rHPxpqysOjhI6x7xXKx3+bzTZ/IgnKqH7UFXg
	Q6g/xbum73FbVlIoR+fgiFxqE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S5;
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
Subject: [PATCH v2 03/16] PCI: dwc: imx6: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:48 +0800
Message-Id: <20260530153101.695580-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF18ZFW7uF45Zr4ktry7ZFb_yoW8uF43pa
	y3u3yFyr4rJF42qFsFy3Z8ur13tasIkw47Jw47Kw1Sq347JryDWFy0yry3ta1akrWkKFy7
	AF1xtFyfJryFyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKsjUbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BwRtGobArw5dgAA3V

Thus, the cached offset is available when these functions are called, and
DBI access occurs only after hardware is enabled.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pci-imx6, dw_pcie_find_capability() is called in the following
call chain:

  static const struct dw_pcie_ops dw_pcie_ops = {
    .start_link = imx_pcie_start_link,
  };
  imx_pcie_start_link()
    -> dw_pcie_find_capability()
    -> imx_pcie_ltssm_enable()
      -> dw_pcie_find_capability()

Replace these calls with the cached pci->pcie_cap. The call chain after
modification becomes:

  dw_pcie_host_init()
    -> pp->ops->init() [imx6_pcie_host_init]
    -> dw_pcie_get_pcie_cap()  (caches offset)
    -> pci->ops->start_link = imx_pcie_start_link
      -> uses pci->pcie_cap
      -> imx_pcie_ltssm_enable()
        -> uses pci->pcie_cap
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 773ab65b2afa..de06ff429eff 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -933,10 +933,10 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
-	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 tmp;
 
-	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
+	tmp = dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
 	phy_set_speed(imx_pcie->phy, FIELD_GET(PCI_EXP_LNKCAP_SLS, tmp));
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
@@ -962,7 +962,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	u32 tmp;
 	int ret;
 
-- 
2.34.1

