Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD62E92B3;
	Tue, 28 Jul 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202415; cv=none; b=D2zVJQw744wXUHVhVcwhcZpgNxyxEjpkzetpBxgZg5fsuIcknytLSmmsTgU89amevriXGyp3rM8tuR1nyv/e6aS9tnZu89mKSTm5k6wkcavzPKejRSU6V3jOHH5kTx0RQr2JVq9pxsIwWexSCrgiV9mnl75XCNlpGmiPJfoKJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202415; c=relaxed/simple;
	bh=nlx60ZTrHllqMCkJzR6KatjiNZH2bi+5XN5XDVcIOhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljc6TX4IzTYmQs/tkkb9TVN5jYcP6iVkDVtfBWk/8G+xqd7eYbta5Yd9qoohIhV3WOlcwM5i9TdfhlSussXYJJrT+ptBWK0/+OPbDMbJ3ZRBoxUblZ0g8xNm+4L1sKKKNwKj8gNG+AcNu3OfAgWx7+dsSeY3YeZgaMNchhPZee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IfZQSY9q; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D9ALeeQa; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IfZQSY9q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D9ALeeQa"
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8Hzc013hzMlGQ;
	Tue, 28 Jul 2026 03:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrLM0zuS1No4orfUDQs5Gjd+YRl0vO08q84IthwyxD4=;
	b=IfZQSY9qh3wAanVtGKGiS4Alxk3bzeNaZ6hJiCj+v/nLvt6fQ4tZPD6TxLn0nQq5uLBkiT
	Jt074rCte41IcXF29H7pvtdZxjC/5rk8UitqM9zsZM5som1bRBxNtucI+KNTruoYg+1AUZ
	34S+oMWx+ahQJnH/v9sasIE8Wi4LLfc+QNnzHC+bYuBBtAalioeJ1C6oZfup4M7rAX/jJF
	IUbGHiXx8a5qXG/XEtCPYCTxhwlhBX3owp7+x/td0r4xbQFbZit3NyA+D/u5RW4pLUp90A
	UnQKiwMDyIAaWm81qKEa8NjWsgJZ3Vw8zxdGdrKIGx6ld5FNNGVTAmB/23SnIw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrLM0zuS1No4orfUDQs5Gjd+YRl0vO08q84IthwyxD4=;
	b=D9ALeeQai56g4sJF1u65o/cQsRLMfteZCyaSac57c3T+vHW+wVmVbdeBwg+jknQpqx5m9N
	Ha7ZVveegwNNNETUZMQ32/wTOXmyxSzMxCCqi6NoNJP+PS061QwtjKnrT9wBXo34wbi3NP
	4Q6sd6mKbHLM9Q44zgDDf2Yina1+LewVhsUkGkI26qBnHXpZzlC2eAGCxe1z6OvN5nUHoU
	beltyaLYE2K3JNAAyV+7vPU6RftyHyE1K/N5dM4cy0fB+oUeBRqQRnpUMZVg3kDPpG7gg2
	vNjl0Bri4hheD242n6Vr0gadD7lcE3aMxYUsj78YJLHDPZYDMPJLT8k77WZZVw==
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
Subject: [PATCH v3 3/6] PCI: dwc: rcar-gen4: Add .deinit callback
Date: Tue, 28 Jul 2026 03:32:36 +0200
Message-ID: <20260728013311.466242-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260728013311.466242-1-marek.vasut+renesas@mailbox.org>
References: <20260728013311.466242-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eabe30b47d2dcb28517
X-MBO-RS-META: rbwco1dgfzdijeusdxpxs7hicg7egfan

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 278abdc7ba2d2..b39f9bc447afe 100644
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
@@ -466,7 +467,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err:
-	rcar_gen4_pcie_common_deinit(rcar);
+	rcar->drvdata->deinit(rcar);
 	return ret;
 }
 
@@ -476,7 +477,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
-	rcar_gen4_pcie_common_deinit(rcar);
+	rcar->drvdata->deinit(rcar);
 }
 
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
@@ -521,7 +522,7 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 static void rcar_gen4_pcie_ep_deinit(struct rcar_gen4_pcie *rcar)
 {
 	writel(0, rcar->base + PCIEDMAINTSTSEN);
-	rcar_gen4_pcie_common_deinit(rcar);
+	rcar->drvdata->deinit(rcar);
 }
 
 static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -857,24 +858,28 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 
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

