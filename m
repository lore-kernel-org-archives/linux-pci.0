Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156862;
	b=fjJkuCGuDBegKe7Ikczm0RMXq1tiyu/ilmtUybNWH7pt1UxYhNZl/UDmSeS7HiPJFpaA
	 gVp7AcSlumyNpd2YrN5vkZC5AFmOGDBJQ0MeHy5Er453QGiuMf/l+tNeq5hPaeFuQVZh0
	 L72ux4xPNjNzZaYPZZO2y5d4rHn7UuD5mlUNbiU+hefymzAAGUCOiee7aTNyRrjAQqkii
	 4k0xWEqINHcHNwdVgQGbOPacX1w33yq2V7/liqD+HYF04ds8gPstp2TiuclQcpOB3ya0K
	 AGavef3uHtUvemrE5ikmPTFLLsGSWEYFwXP+imrajJMglrpQBMzqk2aaQjYAL3BCPfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156862;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nEXGdJC+nnnfnf7AnSlpph3oGrheAJvtJd7pKFwHRr0=;
	b=QXCppg03D8tlu4Kx9euI766yx/RNPPe/hvO02/H488Ve5xCBTSJV/pxOtT+RrtmWbgvi
	 sleVtTNkRrgABrf4/z0Omho2fddpviLzl96pqJg6QGzikyijz/y2LEmdYF48zMWQDLKIU
	 TwOqGZJ92PTlRXTq5UOvUtpVRKiHTKe1t9gOKvb++0ujPx+GZveV0xi9iZ7NK0dvA55mK
	 xkp+DsmRRSBlMTdr77PJBZij9FCo2f3vez/gokDU6lqTTQDBVacsmbPiTW/w/Ph6mTUwP
	 A+Lt7QAUjt3Gp/5H61D298CRmVf+gqCthRKIYMPdzWBZdHHNCMIbq7LL3Fpi5PpIKjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pXPt6h9D;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7D60A2636;
	Wed, 28 Oct 2026 03:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B7D60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pXPt6h9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nE
	XGdJC+nnnfnf7AnSlpph3oGrheAJvtJd7pKFwHRr0=; b=pXPt6h9DTD65L8XFFv
	FHenj4yvv6zfOMSt0UAcropNQ2Vuy6ey5TGKfLnddVDEfQx1a2o8l+45u14kGY0f
	x6O2f+rzOETBMN16euOQU38LiEPYwMZXq2TffgpJOjBEE5LsIxdq6zk0DvgmRtBb
	4JqYUoxNF+BKnyy7mTu4KjLOc=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S4;
	Wed, 28 Oct 2026 11:07:11 +0800 (CST)
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
Subject: [PATCH v5 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:46 +0800
Message-ID: <20261028030652.2917756-11-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryxZrWxGrWfGFWrKw1ftFb_yoW5XFy3pa
	90qFWYyF18Jr48Xrs2ya1DXF13W3ZxAry7Ja97K34avF9F9w17Ka1jkryftrn7GFZ7KryU
	Grs5t34xu3WayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEveH-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B-jh2rhZt-R5QAA3R

Replace the three dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
the qcom-ep driver with dw_pcie_get_pcie_cap().

qcom_pcie_perst_deassert() is the point where the controller resources
have just been enabled and DBI becomes accessible, so the offset is
looked up and cached there. Both the L0s and the L1 exit latency are
then programmed using that same cached offset instead of walking the
capability list again.

qcom_pcie_ep_icc_update() may run from the global IRQ handler, which is
requested before the PERST# IRQ. The helper performs its lookup at that
point of use, i.e. exactly where the open coded search happened before,
so this change neither adds nor moves a DBI access and does not
introduce a new race with the PERST# handler.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e6afdc6198acc..3e2068f3fa117 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -308,14 +308,15 @@ static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
-	u32 offset, status;
+	u8 offset;
+	u32 status;
 	int speed, width;
 	int ret;
 
 	if (!pcie_ep->icc_mem)
 		return;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
@@ -398,7 +399,8 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
 	struct device *dev = pci->dev;
-	u32 val, offset;
+	u32 val;
+	u8 offset;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -493,13 +495,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_en(pci);
 
 	/* Set the L0s Exit Latency to 2us-4us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L0SEL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
 
 	/* Set the L1 Exit Latency to be 32us-64 us = 0x6 */
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_L1EL, &val, 0x6);
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
-- 
2.43.0

