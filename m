Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E6376465;
	Fri, 27 Feb 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216415; cv=pass; b=XoEv6XQ/wHoyHumxa3X4oDYC2FaM4OSctBc1EabASJanS5sNegLt5n8lj+39EZw06MT3tgvqOzfasx4ektAwpPV4MVh+Clm7krLE/fKffLQD4K08Fk6nWlhNHopem85bhP/GV3jEDDOdVnueN8mKT1lTfdYVgD+yStX+DdR/cNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216415; c=relaxed/simple;
	bh=lPzpRtXS5rEhRsmHKgVCZYJ6wcJ4j9kkv3uRYd1KmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T09B51BiCMn9CBX0I9evNCjkebX0yxhytlse0GhGNnibuUTMO02SFVnOscOwKGEuqWzR6ZASKrk0Zj/iZp8aUG1kaQzxC3f+3G2p6XmgAlqLjirq2trzjkxGsEOQ7OpTkd8f7GQKhgoIJzNzuLroXFCyfyh3StTsImtTCQqHwt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=WeNXpIi/; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="WeNXpIi/"
ARC-Seal: i=1; a=rsa-sha256; t=1772216393; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ANOCv8qsPuekEEvp+TSLMnV8rR3ulZMpJHWfx1bAOO3hGrBNgFuoy4ZlZw5LZpf/UoB9CfGtsh2h6HDgW+Gpepjo2hnBVVuxc75Qd01hHAo545zxnvVMkNOtgXm0nWRgXyZiCtzzhD6dTzOYKjTqIOr6j3DZsoY2ecpHF6G9Od4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772216393; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BEthChFhgIE1VilDIvMEf8Myao+DFv023tzV7SOhHMc=; 
	b=CAgX2LUu7lCpdjZdpKyWChcpd4pWORQvLEKTmRvYDTXnVjJwFnKnjIAPiTe89uPGj6c8GS9rVxnDHTBPUzTsv74coYVxt8Y8yQAW/teVQsa3Wc5CE1ghq0/t5cB75+Y6u30xRonOh2MWT4oozviYhFRUmutmdoA95so5+AB8lL8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772216393;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BEthChFhgIE1VilDIvMEf8Myao+DFv023tzV7SOhHMc=;
	b=WeNXpIi/OJ63UoelhazwqEriAuFcocVF2dPxLfbyzNw1ZDt3FGHsTp9yacgosgJ4
	WeUbqx/geUswe+gCLFGpbJ2k18dUX5NtcER5rJY5aH+b9FdwRHTOKHrnTR+oOmOCjck
	0D1ARz8PXODO/bp9cq4qC6SSGMbxPQfsfoxWr8m4=
Received: by mx.zohomail.com with SMTPS id 1772216391898458.9773985440512;
	Fri, 27 Feb 2026 10:19:51 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
Date: Fri, 27 Feb 2026 18:19:25 +0000
Message-ID: <20260227181925.52475-3-me@ziyao.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227181925.52475-1-me@ziyao.cc>
References: <20260227181925.52475-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enable ASPM on all device tree
platform, the SG2042 root port breaks as it advertises L0s and L1
capabilities without supporting it.

Provide a platform-specific initialization hook to override the L0s and
L1 support advertised in LNKCAP register of SG2042 Root Ports, so it
doesn't try to enable those states.

Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 drivers/pci/controller/cadence/pcie-sg2042.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
index 0c50c74d03ee..3142f82bd393 100644
--- a/drivers/pci/controller/cadence/pcie-sg2042.c
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -32,6 +32,25 @@ static struct pci_ops sg2042_pcie_child_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static int sg2042_pcie_disable_l0s_l1(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 pcie_lnkcap_off;
+	u32 lnkcap;
+
+	pcie_lnkcap_off = CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP;
+
+	lnkcap = cdns_pcie_rp_readw(pcie, pcie_lnkcap_off);
+	lnkcap &= ~PCI_EXP_LNKCAP_ASPMS;
+	cdns_pcie_rp_writew(pcie, pcie_lnkcap_off, lnkcap);
+
+	return 0;
+}
+
+static const struct cdns_pcie_rc_ops sg2042_pcie_rc_ops = {
+	.init	= sg2042_pcie_disable_l0s_l1,
+};
+
 static int sg2042_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -48,6 +67,7 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
 	bridge->child_ops = &sg2042_pcie_child_ops;
 
 	rc = pci_host_bridge_priv(bridge);
+	rc->ops = &sg2042_pcie_rc_ops;
 	pcie = &rc->pcie;
 	pcie->dev = dev;
 
-- 
2.53.0

