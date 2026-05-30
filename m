Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDE32470A;
	Sat, 30 May 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155101; cv=none; b=o/f4BvwzdCas37pspU5myuppiRpaUMNbybbnqZw50kqHHqbbC72Sr5td0cYqNScye2VyYPnCal/GxHtSkjv+MQcY+k4xr/RsljSkD8gTqRBg9A1LSUe4AdNAJr+GNxzO1bd3C52pi0JbD62CtU1ixT3G9FyWi8kEd+jhR3k6hRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155101; c=relaxed/simple;
	bh=mIytoK3lew0cX17GUo/AcvnZGAx0EilUFv+nt/as9Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rz8J1uzRjNyOOfIS4Iu11a8xEf6F0Ph0XooBy0lg4Zfl1XDvkljVzXC2YTU50L785G/l2lun0BIvJ4e3vK1yUpsjlphX+wKQh6hz1vKKReU0nsEfG3ZFoyNHqoVHrB/MB86AxMtpXD6ODNB0LN0flJDTeeNITzSsEqMwmoy3Qdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IP8e1nK+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IP8e1nK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4y
	5vcEN60ecF7HKIQYbaUtTi06S+eWZoH1exAeXgq1g=; b=IP8e1nK+YQJKgRSENz
	A4hPpTSnQju/btwFm6lTAJyGXOT08Y4XTZNx75sth5nXlKu2wLCOrdtz/XCBNYA7
	Ur/dESOOCWkHAwiDvG8KF4l/wZyWWvl8nwDcIkG+uUXBB9Q7j+OG+k4/rhdqtsA7
	03GKZR23MrpJMZ2tfzLfJw3Hg=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S8;
	Sat, 30 May 2026 23:31:09 +0800 (CST)
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
Subject: [PATCH v2 06/16] PCI: dwc: rockchip: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:51 +0800
Message-Id: <20260530153101.695580-7-18255117159@163.com>
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
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy3CF1kCF43ZrW7AF15XFb_yoW8JF4Dpa
	yYyryjyryrGr4Sg3Z2v3Z8ur1SqF9xArW7Ja97Gw1SvFy2k34UG3yYkr98tFn7GF4jyFyY
	kw1Ut34rGrsxAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x0RtGobAr0v7QAA3f

dw_pcie_host_init() calls .init before caching the offset. So inside
.init we call dw_pcie_get_pcie_cap() to trigger caching. The helper will
perform the DBI read (hardware is already enabled) and cache the result.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-dw-rockchip, the call chain is:

  static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
    .init = rockchip_pcie_host_init,
  };
  rockchip_pcie_host_init()
    -> rockchip_pcie_enable_l0s()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 731d93663cca..be8b6187913d 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -369,7 +369,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 	u32 cap, lnkcap;
 
 	/* Enable L0S capability for all SoCs */
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap = dw_pcie_get_pcie_cap(pci);
 	if (cap) {
 		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
-- 
2.34.1

