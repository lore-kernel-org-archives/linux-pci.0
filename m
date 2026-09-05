Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34B1EFF93;
	Sat,  5 Sep 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643641; cv=none; b=WWs0OAXnwGbi7qtzK+1zVvO8duWrecLfSttjMGNY3S4rjLQfHNgY29f/+Py2k8ZkJ9wWQgI9OsiZx/p6zTs/TrHAwTTp4dK5GFwasO8uHkGrRKmp4sriFPcNLRE2Sfg3an4CljppPt1aF54yMnAUe8jr/NnG2Pu7D5LH/39Ryzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643641; c=relaxed/simple;
	bh=1DMon/MfrMkEZVEXikRac48hhBF3qimnmv7saKK9/Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G84Yt9pxvUXh1t/uM37Os/fZ0qUcIO20sfnPgdUBSI36aDcc43u7b4MhCS/2hUTkWIsWjAnIQ4A9+9YgSR62Z9cZEA7UJM0YmQ0A+AjZ0If9b3UoCIS02WoCSukptWxYsnu2lZxvScOAYRWOidLRGRvO7zyKK6NlkPRh4vgeUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cT0UMBh5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=M7ZcDZxG; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cT0UMBh5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M7ZcDZxG"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hcmd16lbHzMlKk;
	Sat, 05 Sep 2026 23:27:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPBg7uvQ9ZFY1YMPRuvWFBHgwtOg8wlJc5aCR+EfuKo=;
	b=cT0UMBh5K2/GyP3YWkifphEltLmxIs/GUPoOTsXPMVj0z8bkjzOerixLz+i9XWP1q9zA+X
	Nm/IbOnnu1RxVkaTUUqXET5YWtFcbsK5e5kxGeFhF/QH/y3XGZCpP6CLTIODCQS4xM03xA
	vtnrfGlFtxG+UprbnwDhRh0B4wk/9wwkkbl1PYnceAI23+C7jJXoLkUXJYnp875tY26BjY
	o3K/e9vIenj4tASp6nVlyKDkj41Bpmhxlw0x3to9NlFQVMuaGxC97XSJw4YLvcUvuJcVCv
	iIRUnjTEUxwoRf3qTBhLO1QiytdbdJArxSiWfwnudPpLmo2jvy+EKzoWsA6l9w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=M7ZcDZxG;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPBg7uvQ9ZFY1YMPRuvWFBHgwtOg8wlJc5aCR+EfuKo=;
	b=M7ZcDZxGQvQMO9asB2s6qgl2g64GvV7+nwgovaamqYz1fq8ZA++0mgf2SRQIsvXQqjZjCu
	po7ipYIFa4YmwnyBonY1MxHCOExr05vGDFlFpYVHaDF4ZEMbs+uDtQu5rRUSWGmxn7WnK2
	t1/AXH/Nogv/5vzFhN4vJyYSH29FX+LOKGfqbcDzw1WgQaRBiTqyyvgnlxzCVswc+9tODj
	K1tTHiOzk5TJMqkk02cg63mWVN+1C5/1gDtJ/qdCYHe1uKEIwlYrbMnIq0TPSsOJ59UdW7
	AuF+imOs6ipVJKlsdmkgzVNQm6G1ffE49c29FRKm7bknCa1E0c/D/csq9gqvuQ==
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
Subject: [PATCH v4 5/6] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
Date: Sat,  5 Sep 2026 23:26:26 +0200
Message-ID: <20260905212649.360498-6-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: b8gkpzb65ai3kow5pj6swpuhyxzm6fpx
X-MBO-RS-ID: edbf8358d2231558545
X-Rspamd-Queue-Id: 4hcmd16lbHzMlKk

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 44 +++++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index c768a9c7b3b76..89472a4becc46 100644
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
@@ -494,6 +510,22 @@ static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 	return 0;
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
@@ -504,7 +536,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->bridge)
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 
 	ret = rcar->drvdata->init(rcar);
 	if (ret)
@@ -525,7 +557,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 
-	gpiod_set_value_cansleep(dw->pe_rst, 0);
+	rcar_gen4_pcie_host_perst_assert(pp, false);
 
 	return 0;
 
@@ -539,7 +571,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
 
@@ -713,7 +745,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_gen4_pcie_prepare(rcar);
 	if (err)
-		return err;
+		goto err_prepare;
 
 	err = rcar_gen4_add_dw_pcie(rcar);
 	if (err)
@@ -724,6 +756,9 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 err_unprepare:
 	rcar_gen4_pcie_unprepare(rcar);
 
+err_prepare:
+	reset_control_put(rcar->perst);
+
 	return err;
 }
 
@@ -747,6 +782,7 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 
 	rcar_gen4_remove_dw_pcie(rcar);
 	rcar_gen4_pcie_unprepare(rcar);
+	reset_control_put(rcar->perst);
 }
 
 static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
-- 
2.53.0

