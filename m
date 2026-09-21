Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5F441022;
	Mon, 21 Sep 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022528; cv=none; b=t16SgTAtAcBvnx+6B/D69aDCPcg1fWrHgWU8lFg7Jx1Qklq+PPt1YKWMaJbNgkunEnRdbGGiDfEehgk6wd2BR1Xil+Qvz+YAYgKqd9309JnIFW1foh1m3Pa2BdPUeRVqVl8IvmRmZVp7wGX7nOZTn3QRbQkZ97U5t1hwMLYa++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022528; c=relaxed/simple;
	bh=P8L16suz7VBOVx07R7mi5MQcv06prTYWHXcH3VJ8P2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgeozLY+oBVag4dfr9dbm5Zn5mvrCaHobr5UEXqXNsy2M+EbKt+0WhGS6N1gXGRLG4JMB/oz4yJZPV0qZz+ZoZAzmwciODnlfCLSIIMKFK3fxoZJS09wa/LDP5lz7Kk1kz/OLi6dhsD4Bl7ZQegtA9noe0ROE62AphC7rK4REHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NP8k+XDS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cielqIQ6; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NP8k+XDS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cielqIQ6"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hpZZ407P2z8tcC;
	Mon, 21 Sep 2026 22:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qy7vZHH1+7XkDNOHgWs6VdP38RbGsa3jTFiOU8vhUxw=;
	b=NP8k+XDSjr+C6G8wucJAYa2QlIh1mptudDxcS/P55w9MTM4O7agv6MXbaWn+fzDE/j3/f6
	kmah4lsTgLOVmBM2KMUlEXUlG9jbbrv/XgiovgPDMmqPRH3Ik16dxg2AjeYva3dQ/XlNeX
	xoRw7jju7hPAW8qWcYuYSUnfl1lgVDuh1driJEHgkK+RmogMqU6X2WVyQ0bnOERe9gKjW2
	Cg9xRCPRQXWW5IrbAczqMKp3VHpYyJUgpcxuoULJnu3fzUHevgEV7VfxpHUHLXnBqHzMji
	F+msKS9bDlzGAypgFfVb66HiTOvAEK766CSe/HVCq7VPPbvQo8PpnIAIWOti8g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qy7vZHH1+7XkDNOHgWs6VdP38RbGsa3jTFiOU8vhUxw=;
	b=cielqIQ6FXcX9e9dRkkrPPaKl/J/u95hGT+NokQRj3j5MWy6Vq0ZGMovPiPV36+LzE7SQe
	yvOItBRQVOqM+39WDTaJbQsPrxIBD67cHcbA+WndN+0aYIAIp2MACN0l2EmhR+ATRd9wHa
	y/BFSXsYWHDRYuSpbQFqvx/6pE65w8/xpOd2P0PgMM5A4O2xWZF3QEs7gmKhrQIqCswsyV
	RMVY4r5Vl5cIGfFg0Txj2EQL23vyKbRyLmlUQBqBrdm5INJGhetJC4khFhP9Es+BfAV5HF
	QpMHrmSAr5/XMp/mQQyYRQOAatt5ahyeTDcEsOtanNVX3ByF1HcXFsXWicQLgA==
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
Subject: [PATCH v5 3/6] PCI: dwc: rcar-gen4: Add .deinit callback
Date: Mon, 21 Sep 2026 22:27:45 +0200
Message-ID: <20260921202823.72620-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8660a7c8be3e74b2fdd
X-MBO-RS-META: igkiijsoqt5rroca9haazyzodn1whizz

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
V5: No change
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

