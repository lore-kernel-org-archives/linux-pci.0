Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66816435EDA;
	Mon, 20 Jul 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560120; cv=none; b=e6l7XVZcfr2du/BjjDnYeCSXuud6JRwg+JeI3NU/cPoCkNYTuub2/cIMNH3qHtFWiSUPBqrRq8zGLiNLSWj4avk2BrBqBlZtokBqmERsvrqdr4NkQXBp4ZxDTxoRQc5yxDtmPcFGe9U+pi7xU0WulhkqKPbjAjfLm89Iq7WVkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560120; c=relaxed/simple;
	bh=BePf2KXw3Xz0TGMtMlkVqDuyGHpfO2RjsdeP0lX1uXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHkoGFKclZaCf9MWqWCXrYBBzSQ2LfsWuTg85EIfao/p65v3z8sTD8A+tjl9qRPmhBa93WQELj+AHwXCVe0HGwK3ouwyZy3aJGGNO9r7EnE8JPk0g6zpvSgBa0ueim3yPqUsaosItgRamglklFIM0vrVD7xlAgURoHLo+PUFH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mjcdWVKA; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mjcdWVKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VU
	TpNwnx9GB412jRFvqDOQChNSZ1zG4+eKVBbgWXW+o=; b=mjcdWVKAVye0opVEIp
	B7cvAgIgtvrGvWmFeBHOAgQT2pfdzVZgQej9yN+2nEzaPS9/hfGcCmjy81iVQECm
	DhY9+X7ka1kcVkXXeWa+7upsUKJbcV64VG37ZB8MCW4Lb7Ptx2of6aUryfNniK21
	dwjxOH5X7HLBV+J+Z3gz4wujA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S5;
	Mon, 20 Jul 2026 23:07:46 +0800 (CST)
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
Subject: [PATCH v3 03/16] PCI: dwc: imx6: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:06 +0800
Message-Id: <20260720150619.24733-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF18ZFW7uF45Zr4ktry7ZFb_yoW8uF43pa
	y3u3yFyr4rJF42qFsFy3Z8Zr13tas0kw47Jw47Kw1Sqry7JryDWFy0yryfta1akr4kKFy7
	AF1xtFyfJ34FyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zipBTrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAKwVGpeOcIFMgAA3a

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
index 98e1db751132..74b28b4df484 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -966,10 +966,10 @@ static void imx_pcie_ltssm_enable(struct device *dev)
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
@@ -995,7 +995,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	u32 tmp;
 	int ret;
 
-- 
2.34.1

