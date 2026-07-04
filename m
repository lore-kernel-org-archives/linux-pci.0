Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7597378818;
	Sat,  4 Jul 2026 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783196901; cv=none; b=bZ7G4lMgk78lspKTCpA9rb4mApQkbZhG2P0tjdstBNKj9GLPPEGtndQ57m7O1+4ZMihUuGmNxvLybVIOVua1negT8j3IiD5vkYLgPJCoSw6kmebz+VFyiwSW34sOitfsv1iKeGefg1MDhOLb8tUUCWE3+riU3Bdr+TMMwV70TqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783196901; c=relaxed/simple;
	bh=B1xgOYdISzfUXzc3Fw+K5llIZssheJzAQXhl/LSUaMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSsytT12kNrnpWj+TpE3eiIWxSsA8OmUzT8+ZKn6Ph+TMAaucF3bVPJw0rr+IUEL1L9VuOrYPWdim2aS8PdPJbyfiqAaGtz4HB5JsJNUOKgbwEqHMPJcRf20Ek84N34mPCNvc2YzFAGbJcOIzx+tCXT9IiVhpiGvZfnHM1psxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=g6FXhcHY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Wv/I55i0; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g6FXhcHY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Wv/I55i0"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gt2Hv5XRkz9v9T;
	Sat,  4 Jul 2026 22:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783196891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SVmddnWbxJtZMco+iF1e5UcZG9WH0Amx7vIaLnEFVE=;
	b=g6FXhcHYyY1y9zKb14a6nq898TULaox9JBx5xEO3nKSNJuf+HgRw9D6TZB9LYBg+Lnh4n3
	jIe4qWeBg6nkg2njONlMaflFW1teqjz2tFGFMbEfHsdiOQSJgmfnz4uFRulC0+buvV06l5
	ByQX7bpKif7e8FPQy/Vq7hofp+R6XvpErDQ93ACWigeIVBx81Vgh8lvk8S15Ib8KDXH7Eg
	PRSN3mv7xG/fBYw6beLW32w+qCjOzXpJdN1T+2QXQc75Zucrk2OCslkb4Oy+c4t5Boage8
	OJyDW7H5Da/2wdax1NMpr9lmvg9J9v8fxGJXxGmfIeXOcdlRLJM9YKhUBK+HWA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783196890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SVmddnWbxJtZMco+iF1e5UcZG9WH0Amx7vIaLnEFVE=;
	b=Wv/I55i08rnPZzybgwsH+H7zHAs30BhoPRXJFbh7vsjk2j1ocHETWBouA6tjVMGpeHYets
	7drhlo1CWGjzn9aFxd/Yg9jUFqKaZmgL4q1Hs36Gyub925QGebgRY300k5UEk7jIsPDA+p
	ntN8vo6yrVPUSTX+sjaM8evrddLW5IlvSqJxtcUJe8Ojre9ndZEVLo4Skh5ukqW8QVYvmZ
	oWAP9yvRYrFd31lWUjyxpdikjgZrYE6gqXvhYV0jue7VDdVQFlDvprnaWE2WkO3bcuoVC9
	cQUqamtu+hGomfzTSK/dVDi2ukxW72tgU2F0O6YI/eD+nYRr2IhH1mgx7kEE/Q==
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
Subject: [PATCH 4/5] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
Date: Sat,  4 Jul 2026 22:25:03 +0200
Message-ID: <20260704202748.355708-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260704202748.355708-1-marek.vasut+renesas@mailbox.org>
References: <20260704202748.355708-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yht6zk6gsd7yq5ndkg1ftr8s5akemx8c
X-MBO-RS-ID: dd73db15fe41dcc2123

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
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 42 +++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 05c22cc648135..186eedb33c27d 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -98,6 +98,7 @@ struct rcar_gen4_pcie {
 	void __iomem *base;
 	void __iomem *phy_base;
 	struct platform_device *pdev;
+	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
@@ -299,10 +300,27 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
 
 static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 {
+	struct device *dev = rcar->dw.dev;
+	struct reset_control *perst;
+
 	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
 	if (IS_ERR(rcar->phy_base))
 		return PTR_ERR(rcar->phy_base);
 
+	rcar->perst = NULL;
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		perst = of_reset_control_get(of_port, "perst");
+		if (IS_ERR(perst)) {
+			if (PTR_ERR(perst) != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get PERST#\n");
+			return PTR_ERR(perst);
+		}
+
+		/* There is only one root port. */
+		rcar->perst = perst;
+		break;
+	}
+
 	/* Renesas-specific registers */
 	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
 
@@ -425,6 +443,22 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+static void rcar_gen4_pcie_host_perst(struct dw_pcie_rp *pp, int enable)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	gpiod_set_value_cansleep(dw->pe_rst, enable);
+
+	if (!rcar->perst)
+		return;
+
+	if (enable)
+		reset_control_assert(rcar->perst);
+	else
+		reset_control_deassert(rcar->perst);
+}
+
 /* Host mode */
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
@@ -432,7 +466,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst(pp, 1);
 
 	ret = rcar_gen4_pcie_common_init(rcar);
 	if (ret)
@@ -453,7 +487,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 
-	gpiod_set_value_cansleep(dw->pe_rst, 0);
+	rcar_gen4_pcie_host_perst(pp, 0);
 
 	return 0;
 
@@ -467,7 +501,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst(pp, 1);
 	rcar_gen4_pcie_common_deinit(rcar);
 }
 
@@ -671,6 +705,8 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 
 	rcar_gen4_remove_dw_pcie(rcar);
 	rcar_gen4_pcie_unprepare(rcar);
+	if (rcar->perst)
+		reset_control_put(rcar->perst);
 }
 
 static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
-- 
2.53.0

