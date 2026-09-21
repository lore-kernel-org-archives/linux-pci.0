Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9D43E083;
	Mon, 21 Sep 2026 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022534; cv=none; b=Ztphhepm/DmY2cOHDV3XIsPJms72kQtmzoJvWHLnVhoaD8MAmTATjbWhmjcjP0lkXVOb1hyU35Mz9KPAHRMNAifj3K15e/3nwGHcZ7fzOTcgo+nOvhVxrmP5oRGvYDq7xUcNtXWcL+6XQBQoB8BTXyscUbra4O79XQz/Bqtp4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022534; c=relaxed/simple;
	bh=RROyr+q+vcNMhmcq1Ppv8VsjDF2GNYVwD6tluCmF8Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTf7qAiL7RFs0/YUDzqQH3eUlxlJS7v2OZZiBdU3eML+pwOuZ/mXCGdDNNdNrHS/cfuwrZjwTHptoP6xYXMEmofHv+Pnu3EKe4779aVCk/KoZv8WjknQsQAA+8ZjwYwlIueZsi75uKUQVRONy7r/BmmZqJfBU5zRQWxOCa5bUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PmiYuj/x; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PiJaeL9+; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PmiYuj/x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PiJaeL9+"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hpZZB3lW8z8tcC;
	Mon, 21 Sep 2026 22:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCIoV+l8fVes1StVlHgG4fkzZJaOdXgHJKBGURO67jE=;
	b=PmiYuj/x9BAWGfArpXQ3qe38IatStrIQxsybf+FePe7fDx9uJbaOwZmsETY8Is4gLIFUMR
	vt/QWfwVT/XNbhhW3RjXrtA4/IQJd9Jd5joEX+RCqr7OS/y6P9XO5GDFFWORTaxLWB4sVg
	P7gegxhHu5LDvMy0AaIu1im9esNojT4Des4hxd6AMM9tA52UXK/74x9P5rozivebNmIFiD
	eYDFoRtPAIWyHCJckiX0GomrzkbuJ0uQzufAoDPz5jJVUEoe8vzy3qDSGYn0ViKI71GDrJ
	uWa2NK3EP5eLscuH+g9DDfid27eSsHe2pMKI50Gu8l08kHUdLFJiRUs5bgFNOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCIoV+l8fVes1StVlHgG4fkzZJaOdXgHJKBGURO67jE=;
	b=PiJaeL9+2l1mTfF0M+dJiacAGkRv7jnHoGiwfWSnL9uQui/bGVVtwlKBmtgMqArCMv0OGl
	Atbt++4M85Hx4H5BATkOcboiywee13ZKsB+6dJhZjhnU7ra3ekS71+mhar0OXne584A1ob
	Qs5JNmKJpuHH8CcElIyCT7H5RaHoEsIAoaXcKtHG5Z8jTQ51KFIECUyrGt5B/6XGURiPju
	y0JfQNKct8+WGjKtC1eHXqnTewnb2rrgp5qIjKU2yZg0/Py7UXOzcr+EZgUZRjHUoB2eh3
	E/llmHPyW6yktKlTc/GRg9aO2cxYSN0GBRpMvWKRDVPeMSFe1HgtqOgqtZtxWQ==
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
Subject: [PATCH v5 5/6] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
Date: Mon, 21 Sep 2026 22:27:47 +0200
Message-ID: <20260921202823.72620-6-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: pa3p4r5xuo49khe3dkchriqt5gzfs3dp
X-MBO-RS-ID: 617eae1b13ac2019f2a

Handle PERST via both GPIO and reset subsystem. On R-Car Gen4, the
PERST signal is operated as a GPIO, on R-Car Gen5 it might only be
accessible via SCMI reset via reset subsystem. Support both options.
This is a preparatory patch for R-Car Gen5 support.

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
V2: - Use dev_err_probe() for perst in rcar_gen4_pcie_get_resources()
    - Use of_get_next_available_child() to obtain root port OF node
    - Switch to of_reset_control_get_optional_exclusive() to deal with
      R-Car Gen4, where the PERST is handled as GPIO instead of reset
    - Rename rcar_gen4_pcie_host_perst() to rcar_gen4_pcie_host_perst_assert()
      and use bool type for assert and deassert selection
    - Add missing reset_control_put() into rcar_gen4_pcie_probe() fail path
V3: - Handle controllers without root port DT node
    - Swap fail path order
V4: Rebase on next-20260904
V5: Use either GPIO or reset perst
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 41 +++++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index c768a9c7b3b76..cf1f5de451820 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -99,6 +99,7 @@ struct rcar_gen4_pcie {
 	void __iomem *base;
 	void __iomem *phy_base;
 	struct platform_device *pdev;
+	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
@@ -317,12 +318,25 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
 
 static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 {
+	struct device *dev = rcar->dw.dev;
+	struct device_node *root_port;
+
 	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
 	if (IS_ERR(rcar->phy_base))
 		return PTR_ERR(rcar->phy_base);
 
+	root_port = of_get_next_available_child(dev->of_node, NULL);
+	if (root_port) {
+		rcar->perst = of_reset_control_get_optional_exclusive(root_port, "perst");
+		of_node_put(root_port);
+		if (IS_ERR(rcar->perst))
+			return dev_err_probe(dev, PTR_ERR(rcar->perst), "Failed to get PERST#\n");
+	}
+
 	/* Renesas-specific registers */
 	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
+	if (IS_ERR(rcar->base))
+		reset_control_put(rcar->perst);
 
 	return PTR_ERR_OR_ZERO(rcar->base);
 }
@@ -494,6 +508,21 @@ static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 	return 0;
 }
 
+static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	if (dw->pe_rst) {
+		gpiod_set_value_cansleep(dw->pe_rst, assert);
+	} else {
+		if (assert)
+			reset_control_assert(rcar->perst);
+		else
+			reset_control_deassert(rcar->perst);
+	}
+}
+
 /* Host mode */
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
@@ -504,7 +533,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->bridge)
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 
 	ret = rcar->drvdata->init(rcar);
 	if (ret)
@@ -525,7 +554,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 
-	gpiod_set_value_cansleep(dw->pe_rst, 0);
+	rcar_gen4_pcie_host_perst_assert(pp, false);
 
 	return 0;
 
@@ -539,7 +568,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
 
@@ -713,7 +742,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_gen4_pcie_prepare(rcar);
 	if (err)
-		return err;
+		goto err_prepare;
 
 	err = rcar_gen4_add_dw_pcie(rcar);
 	if (err)
@@ -724,6 +753,9 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 err_unprepare:
 	rcar_gen4_pcie_unprepare(rcar);
 
+err_prepare:
+	reset_control_put(rcar->perst);
+
 	return err;
 }
 
@@ -747,6 +779,7 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 
 	rcar_gen4_remove_dw_pcie(rcar);
 	rcar_gen4_pcie_unprepare(rcar);
+	reset_control_put(rcar->perst);
 }
 
 static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
-- 
2.53.0

