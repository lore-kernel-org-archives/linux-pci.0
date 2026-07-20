Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57796435EE8;
	Mon, 20 Jul 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560118; cv=none; b=Vsfw+CvTBH2QX6cDstPohuO09/CVVYxpu2LdQXUImcDWCu7tWlAtFmpK6CpO4jXCxIKooGBC9bxppUi2IEWLl66pJm2UuYnA1pJzbrqaW5+PPEZUvO7LWxH6M/I/H6tzs/jmtlpgOueBn+2TzIjc6CCso0pSA6upVDv8C7J1194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560118; c=relaxed/simple;
	bh=+UCv5/M5ymon9oIhPPvm7y92eCqH3y218Q1o/o6jht0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgD4/BEwIo2tO1u5Lzh7uTcSamWyk/tc3ToWLApBc4EcCmcLsXVf9i9JimN2m7CFD3D+aYPPEDMljM9wztratPt7BJUCUuORxdUqwb3lI069Wo+q1XgoRD3YFhPG2EgK4sgkNJv0KVqsn0oxPwWW/ioHKJChvH+OdH6noorH0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aO3MFWV9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aO3MFWV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sq
	5n5May5plZP321RlYIM0qj1KqVpHN9549zyN1aNPQ=; b=aO3MFWV9XIa4ABdZgE
	Hlnwa0G0y0jJsfMsU+rQWsAwNfdEQSRYyiF/0lG020ZdM1GUb2xHquff0SkSItpS
	n87eoGNP4gxWufaDI0dGAfmPZRd3iUPaWS2n7tJhD9P+/pRDRXpNGj7rHOOOhjXO
	Cpk0uPrOoe+twSKXp/RvlYGtk=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S7;
	Mon, 20 Jul 2026 23:07:47 +0800 (CST)
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
Subject: [PATCH v3 05/16] PCI: dwc: meson: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:08 +0800
Message-Id: <20260720150619.24733-6-18255117159@163.com>
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
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy3CFyDGrWDZw47Jw1xGrg_yoW8AFWkpF
	WYgr4jyr18Ar4YgwnrCan8ZFy3Jas8Ar47Ja93Kw1SvFy2kFsrJ34ayFWYka4xWFW293Z8
	CFn8tryUZwn5trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyxR-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxASxVWpeOcQFUAAA34

dw_pcie_host_init() calls pp->ops->init (meson_pcie_host_init) before
caching the offset. Therefore, inside .init we must call
dw_pcie_get_pcie_cap() to obtain the offset (the helper will perform the
DBI read and cache the result). This is safe because the hardware is
already enabled by the driver's own initialization.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pci-meson, the call chain is:

  static const struct dw_pcie_host_ops meson_pcie_host_ops = {
    .init = meson_pcie_host_init,
  };
  meson_pcie_host_init()
    -> meson_set_max_payload()
      -> dw_pcie_find_capability()
    -> meson_set_max_rd_req_size()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pci-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 7a4da9fae1ea..c9d0388d262b 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -277,7 +277,7 @@ static void meson_set_max_payload(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
 	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	int max_payload_size = meson_size_to_payload(mp, size);
 
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
@@ -293,7 +293,7 @@ static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
 	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	int max_rd_req_size = meson_size_to_payload(mp, size);
 
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-- 
2.34.1

