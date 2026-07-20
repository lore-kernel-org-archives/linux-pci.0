Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC7277CA5;
	Mon, 20 Jul 2026 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513136; cv=none; b=uP7vOtGfIKHzRAsgPfmWHGWWcMA2GP1D9HbrVcjlIoNbcB3d6N3FZA3RNdsk2KS1CFD+c7CmE3z8KUZ1l0zXrFZfhGJbjvXUhD5FwVEkQk/YyuqBkUBIMvY4ut8TiacetDNKlExJpKl7KllhbnJhhCjfyopIJYkIir79Es0W5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513136; c=relaxed/simple;
	bh=G/s1XEH6aiApcg/htBtyINDpmeNdLjzSWR2ozuyHQvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxValDADgH3+gBiFR9JJbhkKURxZb98JUyGuASD1BS4ZJoa9BzqxsQOjx/BA/+E0UX4J4u5ex5AhcoxErXR9xzjceLcBP1xLxOfRULj5/QvKp68G/TgaZabAgGF+0MV5b4wg+HR+ZUaTQ+t0H72XLZtmf5PpkVlk4E+yNgCMr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tGM26k23; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=X931V/0X; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tGM26k23";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X931V/0X"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h3P482hbdz8skS;
	Mon, 20 Jul 2026 04:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njm3xdISsTV/ECNAw54Ext3jP7saCAxJKQEqqzCdqig=;
	b=tGM26k23FIqKhc5NLL2aMeWWWMcvwKIvpUaBygXtUsocQFri7UUD5Lim1/qO17nFrwx7by
	6BXpwVH7www/905aMCAcDHbKQ+yli2p/q41C5BPohY9S1uVFYUx4tX3luOwjORywNmDirF
	WSPhLxWd1+kIUJbEQmuIXjUu2xrgRbykKGRHCXNSfgFcEQ5gx3f53Y+GDsrMW3w6cx7qI5
	hlrTiTuaoDockqwYsS+zvs8SYFr6PX8SQEnFj9vdsUWMblVgdQSehQRsUlcCpn2w4rO6Dj
	p9yk2L7RbzqvU0JdMLECGmIQUS5hFLlxjVAldCzcravHq+2QYqVJt5d6QYXSVg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njm3xdISsTV/ECNAw54Ext3jP7saCAxJKQEqqzCdqig=;
	b=X931V/0Xlm7lMbvGqhjy8+lTu8orP4SVQl3JpWzeZt9VhvFKDheJ6DjS/9gCvOKHVbW6c0
	VhbeT+rByrxlSSGJO+mYY+rdhD40n4e2T2wdUdxL0fbCp5NLBKjZ0+avZ3cARqY6A9ePhQ
	GfeeegUjkEQRD9migZGAWFSH5iOtAeETz6WNvo9ui/28MftvE9bInjXaqaNTRkaAcATl69
	JKIpW9pwE03KKW6zmPNrzj+Db3rkll0gwNaUhcXreq0CuTBVeLWS25JmeSB6Z70xH6XQbf
	dTi6UrwVib2LsEx5EgXsK40zPNX0VVe3nuCCC1b/QAyyTbKMcZxXZufYuDBZ5g==
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
Subject: [PATCH v2 4/5] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
Date: Mon, 20 Jul 2026 04:02:32 +0200
Message-ID: <20260720020505.315335-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
References: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7b06da2ebe055c30912
X-MBO-RS-META: 6d5m96uxoqj7efk5iiyp41dqd3ehhcs9

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 39 ++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 73b01e74b42cb..2ee8b344ec541 100644
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
@@ -316,12 +317,23 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
 
 static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 {
+	struct device *dev = rcar->dw.dev;
+	struct device_node *root_port;
+
 	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
 	if (IS_ERR(rcar->phy_base))
 		return PTR_ERR(rcar->phy_base);
 
+	root_port = of_get_next_available_child(dev->of_node, NULL);
+	rcar->perst = of_reset_control_get_optional_exclusive(root_port, "perst");
+	of_node_put(root_port);
+	if (IS_ERR(rcar->perst))
+		return dev_err_probe(dev, PTR_ERR(rcar->perst), "Failed to get PERST#\n");
+
 	/* Renesas-specific registers */
 	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
+	if (IS_ERR(rcar->base))
+		reset_control_put(rcar->perst);
 
 	return PTR_ERR_OR_ZERO(rcar->base);
 }
@@ -442,6 +454,22 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
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
@@ -449,7 +477,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 
 	ret = rcar->drvdata->init(rcar);
 	if (ret)
@@ -470,7 +498,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 
-	gpiod_set_value_cansleep(dw->pe_rst, 0);
+	rcar_gen4_pcie_host_perst_assert(pp, false);
 
 	return 0;
 
@@ -484,7 +512,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar_gen4_pcie_common_deinit(rcar);
 }
 
@@ -654,7 +682,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_gen4_pcie_prepare(rcar);
 	if (err)
-		return err;
+		goto err_prepare;
 
 	err = rcar_gen4_add_dw_pcie(rcar);
 	if (err)
@@ -662,6 +690,8 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_prepare:
+	reset_control_put(rcar->perst);
 err_unprepare:
 	rcar_gen4_pcie_unprepare(rcar);
 
@@ -688,6 +718,7 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 
 	rcar_gen4_remove_dw_pcie(rcar);
 	rcar_gen4_pcie_unprepare(rcar);
+	reset_control_put(rcar->perst);
 }
 
 static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
-- 
2.53.0

