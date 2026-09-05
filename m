Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2739A7E7;
	Sat,  5 Sep 2026 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643643; cv=none; b=LnkaXIoQLO8A75eshdbfXA+sP+T5ZQp1O94IPEIg1GsqcHuCI+Wd8+VlnjCxCQ263a6g09jNdJjcDnyxoeTn9c+NP/BftCFykVlC3Q4/RfRhZlnpcoVJmeHMCNHK4m9LkCsYi2gktKBaYLP5xKbLOoY+iab8QEctyIwCtCkCDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643643; c=relaxed/simple;
	bh=wK9N1qzJcIcgFOlgC6jck0HaJ4Xa9IUYcs7bcwkEFYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwVpcLUDb28AbgDQOGoI+lAFkN7pDcFNveIG1eav8aRdXzWrAEeCAHYZgfudT+TiUjDVCh7/oCAwQcw3pTraBvowypmRViUFMW+l+c4hF1PDHJD35Sb1CN53NF38X/uRpvu2K/k+wVlmoNBe1rBYm+C3QqMd7SZIOBDadgqTp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VVfUEKW2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dG1zhXkG; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VVfUEKW2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dG1zhXkG"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hcmcv4kMRzMlGN;
	Sat, 05 Sep 2026 23:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxx//r+qXHCSbp41qag/smW8DUpTuk5+voGpx4l+T5c=;
	b=VVfUEKW2HObDOsNNAXj7zX69hCp85ulJP9JWweteLprikzf2hR/dykf2EnN4dfksBOA1P4
	PDAG3TDqGc/YjAUy6cS27lroPD/X8qQwTuCa2jmKXal4PocnfybTlpuGKIEbEneiLFHhHf
	bhqPOWcdODa/jdt7RnsZ0flsWSk+HEh8oxxngwqUlJ4pPzd5C931Z2POA2A/mPUComeeub
	01lAo/Pc6LeoTCP5KAxkz3frSWxewJ0+bB4p8NBLEqI7TC0SNv9dQ0yPK0aSFytB6M85br
	TPBFnRoqD7f/cFcyhutEviRwCr8Ty5KNyzJ4RrykWnmmufTUw6aIsEfVAdl4qA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dG1zhXkG;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxx//r+qXHCSbp41qag/smW8DUpTuk5+voGpx4l+T5c=;
	b=dG1zhXkGVvcUBeUS/zuicDwZy5r9Amrg2dhrlGVFt39booiNKYzHJAGqalack2fN05PssV
	f9Rufdgg0K5xtzWJErz6v8B8EMbacphm5DmrWIniygbiLpbHSBnq9vIgpO9sbWJUonDROL
	91U6s5TIv15ykOWIihNb0f3nF/+pMz10lr+ZhDTL5B3WZ/D3VQn42fViqqA5CBk+okmmf9
	9Up0p8DiVCWTLSXXRubvy91Rq1ZEKqguuyjFZBddsvy5XoOXDlifteaHH1j5Je1Hiimfns
	r//G19cPSl2oP+vhyEEsxO7dlDiGnz3Gx5D8uO4yNTpujXd0NaboP/opzMDbhw==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 3/6] PCI: dwc: rcar-gen4: Add .deinit callback
Date: Sat,  5 Sep 2026 23:26:24 +0200
Message-ID: <20260905212649.360498-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wfuuptgeofnddrdz3sb7a7nkmh9fnxga
X-MBO-RS-ID: 4e9a5b1c4fa1f803f4c
X-Rspamd-Queue-Id: 4hcmcv4kMRzMlGN

Add .deinit callback in preparation for R-Car Gen5 support. The
.deinit callback will be used to tear down the PHY on R-Car Gen5.
Thus far, it does what rcar_gen4_pcie_common_deinit() used to do
directly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V3: New patch
V4: Rebase on next-20260904
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index a19ebbab2f8c3..04871ac11c348 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -88,6 +88,7 @@ MODULE_FIRMWARE(RCAR_GEN4_PCIE_FIRMWARE_NAME);
 struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
 	int (*init)(struct rcar_gen4_pcie *rcar);
+	void (*deinit)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	enum dw_pcie_device_mode mode;
 };
@@ -520,7 +521,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err:
-	rcar_gen4_pcie_common_deinit(rcar);
+	rcar->drvdata->deinit(rcar);
 	return ret;
 }
 
@@ -530,7 +531,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
-	rcar_gen4_pcie_common_deinit(rcar);
+	rcar->drvdata->deinit(rcar);
 }
 
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
@@ -580,7 +581,7 @@ static void rcar_gen4_pcie_ep_post_deinit(struct dw_pcie_ep *ep)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
 	writel(0, rcar->base + PCIEDMAINTSTSEN);
-	rcar_gen4_pcie_common_deinit(rcar);
+	rcar->drvdata->deinit(rcar);
 }
 
 static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -913,24 +914,28 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.init = rcar_gen4_pcie_common_init,
+	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 	.init = rcar_gen4_pcie_common_init,
+	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
+	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
+	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
-- 
2.53.0

