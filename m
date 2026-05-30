Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510914ABE;
	Sat, 30 May 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155207; cv=none; b=tIIQrqVo90anSOodnS1A0/5yYD4/MH3gdyvmxCpMrAdXYx9sl0xmlwN6YxoqWBS77ZtpGhCn0LzZlrLLeJHrBh2/+/bKn5BoKuaq+bvPnNCIgkM4XCeuFjB8A6e2wAPIKDAeUkQrV5DM/k4R+F1H523u6g4t7hYYetPIRAmMKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155207; c=relaxed/simple;
	bh=6FHXvjev7Gd8QIJ6TC6cZHqJAh/folx2I9bLZ1sWT1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2SBNRUX/5X7wL0KpvpnWJC/BYEvD7TDxM8V+H0C62uZpgRyHbZe5Q0SrYplHRsZGb5faCS3vCZu3tuZpOw9vlJlXkD4g3fkScPAcjyD8kCMVIjO545j5KCqIZUEXPKBPPSrglrPO2aBTkAZoN0AJNEOBReaIjwG61NvwcpO6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QdlMK/5N; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QdlMK/5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7N
	jckmR/hN8kDZXFriSmoFWbpgDw7fbuJlZj3KiCUGU=; b=QdlMK/5NSu3mn4Jv6w
	JWNSFhSJn9cGKxRHg/27nZEP0PsgFq79AE74CQXdl9a0FEpjl9xqMlnTNe6JHoGO
	uZpXo8I5Gqldw+1wFruDrxCiglpftX3v/2mbOC25DUUW28cbGPPb5nznJI17XFz1
	U9VGL24dPJqJhUnPInB72+ZsU=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S9;
	Sat, 30 May 2026 23:31:21 +0800 (CST)
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
Subject: [PATCH v2 15/16] PCI: dwc: tegra194: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:31:00 +0800
Message-Id: <20260530153101.695580-16-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWfJrW7Kw1xGw1fZw4kXrb_yoW8tFy5pa
	yrXrWFkr1UJr4aqFsrAan8ZF15t3sIyrW7Gwsagw4aqr17C347WwsYk3y5tF17CFZFyryU
	Cr1UtFy7Gr15JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRmhFxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAkUt2obAsl7YQAA3O

In host mode: tegra_pcie_dw_host_init() runs inside .start_link, which is
called after dw_pcie_host_init() has cached the offset. However, the
driver's own initialization already enables hardware, so calling
dw_pcie_get_pcie_cap() is safe and will return the cached value.

In endpoint mode: pex_ep_event_pex_rst_deassert() runs before
dw_pcie_ep_init(), but the driver has already enabled hardware.
dw_pcie_get_pcie_cap() will perform the DBI read and cache the offset.

Thus, the private pcie_cap_base is always valid and can still be used for
register accesses.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-tegra194, dw_pcie_find_capability() appears in:

  static const struct dw_pcie_ops tegra_dw_pcie_ops = {
    .start_link = tegra_pcie_dw_start_link,
  };
  tegra_pcie_dw_start_link()
    -> tegra_pcie_dw_host_init()
      -> dw_pcie_find_capability()

  tegra_pcie_dw_probe()
    case DW_PCIE_EP_TYPE:
      tegra_pcie_config_ep()
        -> pex_ep_event_pex_rst_deassert()
	  -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 795cef5a915d..bf482bc66a92 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -905,8 +905,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	pp->bridge->ops = &tegra_pci_ops;
 
 	if (!pcie->pcie_cap_base)
-		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-							      PCI_CAP_ID_EXP);
+		pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
@@ -1889,8 +1888,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 	}
 
-	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-						      PCI_CAP_ID_EXP);
+	pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
-- 
2.34.1

