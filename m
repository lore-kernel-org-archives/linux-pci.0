Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104157;
	b=E36lJe7ENDIAZkPiLHOtOnbzHjrQvpoWcZfe9M9PNSsM72mLnE172P5wFwe9xHDyKTTA
	 +LXfsPz1NTpROxJjYGCrHjFZ22aM/8gBsZJvJbJ9ioFis7zlwyzXSwhZd+8A3R+s+YDoP
	 LKSmnjQyk3gBQ+HIna9dEurpeS9oHS9BJPBXzwQrBQDRmcOURKe31WMiAjRqCaC/tglHm
	 mgDOeLhfXmtZM72dSrf03BzRP5hDtH/jcqCY3W7vOQqlUsdaanrcrLj7hH+3IHM8GJDcy
	 s+Hp2r/Khp5r4po5NEs3hCCNcu4qdwbIiMx/y2itBr9Mv3HfFUfmpsq/RVHRpEU9SdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104157;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=2H/SRmEgHxYy6/YE6vU5/0Lc8z8GPUZ967ycTx0UluA=;
	b=bb0NBg3YLCqotV9KulQC9C15mZmFhM0Fa71hiPxBhJFA3v2xRApjvxiqKNpeT9v9nO0J
	 Vc8XsL5L8hcWEOGrFMOed89FbdbRvTphgkj4m68vQB93mM7tKarRtkR6z30szCbB4+McY
	 VMe0ARpNqmTe2cLCNwzPkTR4Mgv/P2hAMJHmzNw9WK9Eu3zcqxqjP1s/7nlz1YLNYutVM
	 i3rT3+m3mEZJAEUdCqIPCNgfhwdnDh6hytxbd4ZHbVucTrhtsU38PU7bVrbJeIMtqlql0
	 9EtsZbbau0Bva9T/UCyphQ5V4/ZpWyMLkDswKzxab0r9sIK5N4KlA8Z9R6K+bCrHN0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Cvymowhn;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25082606A326;
	Tue, 27 Oct 2026 12:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25082606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Cvymowhn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2H
	/SRmEgHxYy6/YE6vU5/0Lc8z8GPUZ967ycTx0UluA=; b=CvymowhntoNLnPhJgZ
	ZvElGLlDVe3+Qb9PTpqMuZEA+/NIEC3mThxJpWdxud/4U/zpqWL3pKa85fzhclOe
	G0Ue+EI+tb0bsU8t3UvHFNwksFGw5m+t88SqVK1ielvLr/4P62bD7fw6GmZJYpcr
	R9mJclmAjWNdSK0Uu50km8XHY=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S5;
	Tue, 27 Oct 2026 20:28:34 +0800 (CST)
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
Subject: [PATCH v4 03/16] PCI: dwc: imx6: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:14 +0800
Message-ID: <20261027122827.2725643-4-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyruw4UKr1UtFWxKw1xKrg_yoW8Ww4Upa
	9xurWFyF4rJF4SvFs2ya15uF13tas0kr4UJan3Kw1avFy7t34UWFy0kryftF43Kr4vgry2
	yF17t3WxG39ayF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBT5dUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xI12GrgmPIXkwAA3w

Replace the two dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
imx_pcie_ltssm_enable() and imx_pcie_start_link() with
dw_pcie_get_pcie_cap().

Both functions run with the controller powered and clocked: they are
reached either from the host .start_link callback or, in Endpoint mode,
after the PERST# deassert path has enabled the resources. The helper
therefore performs the DBI read at the same point as the replaced call
and caches the result for later invocations, which is useful for
suspend/resume where the link is started again.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b98d..7fe9c1fa2686 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -970,7 +970,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
-	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(imx_pcie->pci);
 	u32 tmp;
 
 	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
@@ -999,7 +999,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 tmp;
 	int ret;
 
-- 
2.43.0

