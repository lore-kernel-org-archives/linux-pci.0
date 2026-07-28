Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E25303A04;
	Tue, 28 Jul 2026 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202422; cv=none; b=NOxwR9Fn4T4b9jLck+1co6tTBdGwnxE2IE6ZJ1B7rZP4LNi+p3WMKs1ica/SRZPnJE+sWZa4J1q8RiISjyLapgE8Ezq0n0N6p0CsSrBXjrRpQCc/4jMKrYBKXgd8URfkiVFQGLrtLL2hJ1qm9Ii0ElTZsbY23pZ4SfflJeNhnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202422; c=relaxed/simple;
	bh=5Pb7DZddzy3vL0/UAkECXKtx+LVFOSQ+E2cJCNC02Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTRqF6SPYhmhTuYddillTXccynrEYjqbYhVcldnpYtUnvmN2AC1EEfLAvt2kvY+8cX++gcYMvTwZ10RfqifBjH/A5H3CT27LqQgj4ze30icA+8H2fLD/r8992ZbZZ0pAigw1K2PyHrXjnlENp8904xv3K9j+jwV/Wi7tDfFoXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=h7Xvl3Zl; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qrovHSv9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h7Xvl3Zl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qrovHSv9"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h8Hzk3FjXzKvv2;
	Tue, 28 Jul 2026 03:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJf7i2jWC3M4zLhI+O6H+F+JkzGe1lLLCidA9Yh7i3Q=;
	b=h7Xvl3ZlyRS1EKB8Fa/ewEteiVYzHDoPP4MV4HeIwVXnClKA2fX8xmd0VftqBTT0wq0TGd
	hj1wtgse8WLxqdbLRvhVYY/XFUey/YHlAmEjqE/qv2Hg1wZDb0yt/V0PYvaIGmUJhaw82p
	IyIgrGU/qOsSXK1xlWVNQnsdQNpwtK0DroAmu9Ae2uDmrWTlWMturzSMSpSRbYgB+6gDDU
	NfBwMadf7SnMwQRTjOZkkzsQnZ2NhLN5+RQkr9F8f09psjO4ytZqty41bxIIxDFB68wFRx
	OLk0IRX90/0EGY6ZAiXHKA3wy1Bn9EH1Paab7LtIp0hqdbqubbzVFxa0XliIew==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qrovHSv9;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJf7i2jWC3M4zLhI+O6H+F+JkzGe1lLLCidA9Yh7i3Q=;
	b=qrovHSv9GJD+YJ4dYSo1El6T1y3iN7hMV5PiGrjJVj4sjIBWjTOqAitzkF1sV64VckCXbj
	+H9kmXTQLaucnkBUNhYTdkRMoCfPhHXbM+YxZAyWokNNXjtianRyMnVT2JS4KXFaWmqrRI
	6oEIyQt9v+8fQCO1WS8+SNsobubJqxSp9LmpVOjU3INWU0G3aCy2EHLabsZSA6E60yrjQ3
	MXpOFKutWz745vQcjhWS6EN460wgJQsT4r1xhjGB4n9IyLuBKQVXAuMeuyyLVfUJUxSV05
	0fILfXZa2U1KiAndbppXAmBoskaX9qFKepDOVzpXXNvdWwyNoGgOsKS7S2AbnA==
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
Subject: [PATCH v3 5/6] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
Date: Tue, 28 Jul 2026 03:32:38 +0200
Message-ID: <20260728013311.466242-6-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: y549zfeay7yo3xocqrma3xwy55jukcam
X-MBO-RS-ID: b1ed774719390798631
X-Rspamd-Queue-Id: 4h8Hzk3FjXzKvv2

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 44 +++++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index ff1969338a276..30b024a620410 100644
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
@@ -317,12 +318,27 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
 
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
+	} else {
+		rcar->perst = NULL;
+	}
+
 	/* Renesas-specific registers */
 	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
+	if (IS_ERR(rcar->base))
+		reset_control_put(rcar->perst);
 
 	return PTR_ERR_OR_ZERO(rcar->base);
 }
@@ -443,6 +459,22 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	gpiod_set_value_cansleep(dw->pe_rst, assert);
+
+	if (!rcar->perst)
+		return;
+
+	if (assert)
+		reset_control_assert(rcar->perst);
+	else
+		reset_control_deassert(rcar->perst);
+}
+
 /* Host mode */
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
@@ -450,7 +482,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 
 	ret = rcar->drvdata->init(rcar);
 	if (ret)
@@ -471,7 +503,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 
-	gpiod_set_value_cansleep(dw->pe_rst, 0);
+	rcar_gen4_pcie_host_perst_assert(pp, false);
 
 	return 0;
 
@@ -485,7 +517,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
 
@@ -657,7 +689,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_gen4_pcie_prepare(rcar);
 	if (err)
-		return err;
+		goto err_prepare;
 
 	err = rcar_gen4_add_dw_pcie(rcar);
 	if (err)
@@ -668,6 +700,9 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 err_unprepare:
 	rcar_gen4_pcie_unprepare(rcar);
 
+err_prepare:
+	reset_control_put(rcar->perst);
+
 	return err;
 }
 
@@ -691,6 +726,7 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 
 	rcar_gen4_remove_dw_pcie(rcar);
 	rcar_gen4_pcie_unprepare(rcar);
+	reset_control_put(rcar->perst);
 }
 
 static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
-- 
2.53.0

