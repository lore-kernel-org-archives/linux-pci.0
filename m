Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A03B960F;
	Mon, 20 Jul 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560120; cv=none; b=ctumqXcRUol9osdZDsVdCFVQ4hUJH6TrUb7B105DNuvnd2ZA10WCnOHXUGt7vkmP0Paa+ivdH0mIH44b47Itx2YT5vizLbLhe8bMkG7g/GZ5GzcSXdeBCZ2y6szoe8303kcpV0uAhOdI4BeSKC4KfqDr2lJhBP1up0F1e0k52lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560120; c=relaxed/simple;
	bh=bMErmdnUMpkcm6PndS0VqL63j5qilTdWF/Efbl+gFsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXSnMa56z2QsPN0rwCu0G1WxykG5o1E+lXt4lqAx0kj6ov+PymElrpBYI4Pe7L1AU51ZKCLjDgkGJYezwAVFw1yTvjgTUMBT1VATXpFzio6cx5Buo+hhXRvzHNFsCsjo2CiOrhJtGtZ1Cx6NSiY/KPpFZUcrMEq+m3gYQ5TRCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X+REq//w; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X+REq//w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Om
	uI2Spp3n9kV5Al6PVnZ7ZuVvU00LmjtW0tSnMTkU8=; b=X+REq//wOe+JPBVZRf
	iKQ/Wg1l8eNIl04rCuJGnuOUVa50cGEdGMeJCu2Yh+d9tcScIZQEApLrC9W3a70f
	gFUMjuZVKj/ff/b7qjLQIxhMNH/WvppMBSfysyFsyVfa/P89hnK1ajV01wTpR5+r
	8+94fpUyPI8nU9fmA6j71Lkxw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S9;
	Mon, 20 Jul 2026 23:08:01 +0800 (CST)
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
Subject: [PATCH v3 15/16] PCI: dwc: tegra194: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:18 +0800
Message-Id: <20260720150619.24733-16-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWfJrW7KFWkXFWkKFy3urg_yoW8KF18pa
	yfXrWFkr1UJr4SqFsrAan8ZF1F93sIyrW7GanagwsIvr17C347WwsYk3y5tF17CFZFyryU
	Cr18tFy7Gr15J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9a9hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxG0WGpeOdEBugAA3Z

In host mode: tegra_pcie_dw_host_init() runs inside .start_link, which is
called after dw_pcie_host_init() has cached the offset. However, the
driver's own initialization already enables hardware, so calling
dw_pcie_get_pcie_cap() is safe and will return the cached value.

In endpoint mode: pex_ep_event_pex_rst_deassert() runs after hardware is
enabled (PERST# deassert). Because the core no longer caches automatically,
we call dw_pcie_get_pcie_cap() here to cache the offset for subsequent
accesses. The helper performs the DBI read only when hardware is ready.

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

