Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387932E68D;
	Sat, 30 May 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155645; cv=none; b=J6LsjsnidK5ZxGhG5gH0pxWGJmS4WwzBCUwFq+KG1KvSjzIxpzIE8j2LeY08hHwCmwp/4h2rquZG3SmbJ+ihYa5RPgqfcpAf/DDRQvLi6fVpuw4TMlpmYgPdRVN+LmY5LBWgOM1HeuTUNEN8h4NzYQ1skLCAXFHYF+qz6dvCaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155645; c=relaxed/simple;
	bh=grGdtXOwD1+VjoAQoMk0QP1EWIxmg313YgHNMTrVNy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOS4pHIbfte+0Iyl+A+6oKD9Lte95c2tV5UzV/0DN7KNbxa8z90/FXQMFM1849XjKuC5ZZ73i5YtXlfXZNRLv/wE/vZyUeZu2o2TyhEexF57+n7auZvam+OFZi35NZyO5Am7oAL+LJG4DK+u3cYXXIXHKJltTRT0sh0Lh2AUy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f300qt3g; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f300qt3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YQ
	KiS1Zc2ks7okKcTAWY33gQ3mSdya0KjH2tZs/3Xws=; b=f300qt3gZrvnVaMrfM
	GuMeGnCoMPu/G3pu97r3Sg6knoV5ITeGpMhUrMIkFIhK/4QPP79lSRJ1A1eeSE7n
	g8NUPqI4NqYhwOqYd7ZFc92qUhrEjgQW2EFMQqJovZAHPOTQLRWSzB/XNjjWnECO
	b3FihsjO1Gks4K1qoH4fnMyFc=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S4;
	Sat, 30 May 2026 23:31:18 +0800 (CST)
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
Subject: [PATCH v2 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:55 +0800
Message-Id: <20260530153101.695580-11-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy7Cr4rAryUWry5WFWDXFb_yoW5Jr1kpa
	s0qrsIyr18Jr48XrsFkan8XrnrWrn8Ary7Ja97KF1SvFy2v3y7Ja1jyryftFn7GF47Kry5
	Cr1ktrWfu3W3tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR8nY7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AYTtmobAsY6mAAA3Y

dw_pcie_ep_init() calls ep->ops->pre_init() (enables hardware) and then
dw_pcie_get_pcie_cap() to cache the offset. Therefore, the IRQ handlers
run after the cache is populated, so they can safely use pci->pcie_cap
directly.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-qcom-ep, dw_pcie_find_capability() appears in:

  qcom_pcie_ep_probe()
    -> dw_pcie_ep_init()
    -> qcom_pcie_ep_enable_irq_resources()
      -> qcom_pcie_ep_global_irq_thread()
	-> qcom_pcie_ep_icc_update()
	  -> dw_pcie_find_capability()
	-> qcom_pcie_ep_perst_irq_thread()
	  -> qcom_pcie_perst_deassert()
	    -> offset = dw_pcie_find_capability()  (called twice)
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 56184e6ca6e6..0471f96d3c78 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -307,15 +307,13 @@ static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
-	u32 offset, status;
-	int speed, width;
-	int ret;
+	int speed, width, ret;
+	u32 status;
 
 	if (!pcie_ep->icc_mem)
 		return;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	status = readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
@@ -492,13 +490,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_en(pci);
 
 	/* Set the L0s Exit Latency to 2us-4us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = pci->pcie_cap;
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L0SEL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
 
 	/* Set the L1 Exit Latency to be 32us-64 us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L1EL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
-- 
2.34.1

