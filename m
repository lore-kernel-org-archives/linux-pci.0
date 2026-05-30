Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692532BF51;
	Sat, 30 May 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155240; cv=none; b=cPmKKErZiES4VKgOWKh+2aYxCEPVLhjD/DhAWJeluiFRK8F87W6/frUcZVTqFC+WmYUqHZoRfli7/iW+iVxydm0Wsqhb2YhCTv4Sh+h090lKPKVEHzEsj2vRqptNaLmch1XNyxinC78hDOknjVkdBbAWVtEsFs39feEsD0hDYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155240; c=relaxed/simple;
	bh=7u0KqMhAmfZ5YzxjvWVxWLyTqnuiOJ8Zwl6g1JFDc0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLc+VyYCVoz3SZe97LqWIRbRlcDdxrYIjGrV5sm3HYR7bBkGwUWO/WqhGA8PSpVk+g3NGx9dMch98ijqOtD4g75XY42OLmAHPDiBOQ39ceSG25QFc7156njxbJJK+46f4hyp33xcjrOGfTOF5nUZl/DQy6nDOldH2qx9Lm8VclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BCYxZx27; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BCYxZx27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ne
	ek+llzPudCPeZmIqDmflPD95hch6yR65a+6hnW9n0=; b=BCYxZx275ZAh7SiUm0
	J5ZfDuMzpXn77fu1RBjV8/JBS17LByeLr1IwPDLoi3V04JlbK7ikrLhfGYLpLWUq
	vVRdjf5nLrjq1gnTKkD11U1PmxPPlAqSFqZzTNADGaFrs2fgMtQ5xxjAvlhh9zFs
	93QTC3g/CjtUw28FuxjUMu78g=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S7;
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
Subject: [PATCH v2 05/16] PCI: dwc: meson: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:50 +0800
Message-Id: <20260530153101.695580-6-18255117159@163.com>
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
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy3CFyDGrWDZw47Jw1xGrg_yoW8AFWkpF
	WYgr4jyr18Ar4YgwnrCan5ZFy3J3Z8Ar47Ja93Kw1SvFy7KFsrJ34akFWYka4xWF4293W5
	CF98tryUZwn5trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwx0RtGobAr11ygAA3K

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
index 0694084f612b..81767d010c84 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -276,7 +276,7 @@ static void meson_set_max_payload(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
 	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	int max_payload_size = meson_size_to_payload(mp, size);
 
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
@@ -292,7 +292,7 @@ static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
 	u32 val;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	int max_rd_req_size = meson_size_to_payload(mp, size);
 
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-- 
2.34.1

