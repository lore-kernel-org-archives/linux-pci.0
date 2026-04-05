Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C3BA45;
	Sun,  5 Apr 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775403777; cv=pass; b=FZRsisC5VTSxdZg3ilh8ulTh8R+Yq7vSG/TqYKShS7SegJscffEs5btb8Cs/VqSHTeedzB1uqAoJAlMGglx52DuTIFPXXJYioeoJ8JpjmYeXIOq2uFxnooLdOjhbhsZlIJn7HBaXV+k3z0x3xnwtrCIVEdcvsirn8Kj4aM8lZlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775403777; c=relaxed/simple;
	bh=T5t03JUTD+sSAWMS1ppybbZ5NPZumXEBce6jvW7kyrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLFTv7b/oLORzJlFrefS5b5cgsP/+iIo1ya6X5o1R8R51SRbzrXbWFXwjo+jO7oyxUqltg7ghHyd7+ZyIIHyaqFqjWc0ASKRDrN7F0MDlRTeQfjEsaImEVaAf4h1NYsECvkV/JIC6izTch0vqJn4M1E8LENgMcGRcajGokrmd4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=pip/tquT; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="pip/tquT"
ARC-Seal: i=1; a=rsa-sha256; t=1775403748; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aJGUMrErOtTBhzCGYn0CET/85nx36qSely5KgAlTmSXi6YHh0MxeqkCa93gZyrCnzi9GRgfYu+udtKJW7erz7Xi8azscUiUsyWraxVnlKXKwHYbBTg0lfYWCjrP7PKfn4HZCXXyOWqhvGM4aMRFwXy5b51vk0XN4STSWNn4OxDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775403748; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=04BMJdL2dI79QKtXQzctXE5shAcrq8uO/xheWpEk3q0=; 
	b=CiANCmjdH9k1wYHxxUKloC7hp/1ThzvWsdShaGTLubqnCGWnXSOrTaahm4o1OAE7nOcEg5NnvyGTV2msVLva/YaLxyfSN5mgebVhjqcZRvLCvVThRVkOR2wbU22s2ai2sLXEPtx0SzSzUlREXwwgAjeyRpt7yLWeK/czT9yJDm8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775403747;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=04BMJdL2dI79QKtXQzctXE5shAcrq8uO/xheWpEk3q0=;
	b=pip/tquT1K6NZ4z681YAkIDO30fEWrGoU+4bDImKUG9YcikRB87mzcF4K9OPEzMj
	AMAy5PjxJMbm5D3vCkzuBV1i0OD/SXed6xGeppsW2tx7Ghbfg74tQpLpc3IfTnJeeRT
	GPF9E7dT+g1AMwMcQG5FE2GGW+OxlR2F9IWcUy70=
Received: by mx.zohomail.com with SMTPS id 1775403745637235.9922651261561;
	Sun, 5 Apr 2026 08:42:25 -0700 (PDT)
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
	Yao Zi <me@ziyao.cc>,
	Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH v3 1/2] PCI: cadence: Add flags for disabling ASPM support advertisement
Date: Sun,  5 Apr 2026 15:41:53 +0000
Message-ID: <20260405154154.46829-2-me@ziyao.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405154154.46829-1-me@ziyao.cc>
References: <20260405154154.46829-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add flags for disabling advertisement of ASPM L0s/L1 states by clearing
corresponding bits in Link Capabilities Register through the local
management bus, allowing ASPM to be disabled on platforms which don't
support it.

Signed-off-by: Yao Zi <me@ziyao.cc>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../controller/cadence/pcie-cadence-host.c    |  7 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index db3154c1eccb..0bc9e6e90e0e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -147,6 +147,13 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
+	value = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP);
+	if (rc->quirk_broken_aspm_l0s)
+		value &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+	if (rc->quirk_broken_aspm_l1)
+		value &= ~PCI_EXP_LNKCAP_ASPM_L1;
+	cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP, value);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 443033c607d7..32a5666204f5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -115,6 +115,8 @@ struct cdns_pcie {
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  * @ecam_supported: Whether the ECAM is supported
  * @no_inbound_map: Whether inbound mapping is supported
+ * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk.
+ * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk.
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -127,6 +129,8 @@ struct cdns_pcie_rc {
 	unsigned int		quirk_detect_quiet_flag:1;
 	unsigned int            ecam_supported:1;
 	unsigned int            no_inbound_map:1;
+	unsigned int            quirk_broken_aspm_l0s:1;
+	unsigned int            quirk_broken_aspm_l1:1;
 };
 
 /**
@@ -344,6 +348,21 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
 	return cdns_pcie_read_sz(addr, 0x2);
 }
 
+static inline void cdns_pcie_rp_writel(struct cdns_pcie *pcie,
+				       u32 reg, u32 value)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x4, value);
+}
+
+static inline u32 cdns_pcie_rp_readl(struct cdns_pcie *pcie, u32 reg)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	return cdns_pcie_read_sz(addr, 0x4);
+}
+
 static inline void cdns_pcie_hpa_rp_writeb(struct cdns_pcie *pcie,
 					   u32 reg, u8 value)
 {
-- 
2.53.0

