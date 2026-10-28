Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208107;
	b=d4U0imr/MWQnaR7A4R8rCAibe3jNvdF80vV9tYi/uwwWkbMoiKYQz5TxySShHC4zur5a
	 M3+2G8quUwTBsx1ixiobM89BTcdbWF96oO1OmFb1iQOxSInLKnBZmQ7gBt5qCMg7TlPRZ
	 X1IXEm5aNgtnPiYyQrhw5GGcgN+y6zpcSu0UEcFN9F/ilkML3yGqkliVY+fFLEFunCoZn
	 DI+YZTRYRgs9a9HE8gHTsdsGBCRG6jeXl9DPy0VF7nZdtHqNJxe2tUA8o+CuUeoaghU42
	 PG0qjsPTJM3VouRFG4oSOh8wBkDnXOw4WIw5V/VbWkIsRb+O44FR30Ts5tNIu6BPdaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208107;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=6tw1/IKvQRm7RH6uU3JHi893MfeaI2rkP9wXHgR/3Zg=;
	b=3YnnYNBv1UHwjBT2eNfzQupNQ2AXqKuZ8Jne8Mz4ix0kABI/S3HaIq0/qGika/qUGSdS
	 lCwYjt3fQGjKXnJN4A+jB7GluehG/ioM91V07qV3V4h6kkDjeIdAlD4pEf2Cnow07+zBm
	 vS9zFjpFlx/V4SJntU7Ykjj9R3IfSQTXeF+Wooie+SDW54N9d17CIJEX7dtHGaTXkKtzX
	 h2Dth3jR9Nnv7M5Own2Iw8LApZ15qeNUDrl3yUSJxIpJhIY0kRbqGq7N1GmN7iQ/TOvLr
	 bJsJ0eiTU6bsT8XRCLnlsRHNYrahrMs6xJVN1rSBn0JF2NcYeIQwkaOfhQTdz5g1SxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qMfKC5XB;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F208606A31A;
	Wed, 28 Oct 2026 17:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F208606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qMfKC5XB
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jFDgB5DFjzMlCD;
	Wed, 28 Oct 2026 18:21:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793208102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6tw1/IKvQRm7RH6uU3JHi893MfeaI2rkP9wXHgR/3Zg=;
	b=qMfKC5XBxBrGNvDI8EHB/8VZ1xeKXDCNpLZ2olAVS0ACrohTp90eSyDMXXm883fO2SdIzJ
	1znkCrET61MFuWhuiQkNtXv1Enarvbi5COCBWqR41arnl2BzENfH4eFmumbuTsb9kvhpe1
	hO+Kig/j52an61Rj6JH0abqGAAZ/5CDRChPyCIC04NqDUyf6sVeLTRSxh6Ty39144ly+TA
	3K/eZ0e6EAd49P0c0V0TtRAxkS+iyDZs0zw/9WUrfrE0V0zdfmvFT9WFIYr1l4a3ZI16q1
	9YxG6ciwiTRXYATqb5EbfayLke4JqWxU1DXV5E6hkaJMobhP0FNykERKK1PKug==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Alex Elder <elder@riscstar.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jingoo Han <jingoohan1@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Rob Herring <robh@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] PCI: dwc: rcar-gen4: Replace pe_rst GPIO PERST with GPIO reset aux driver
Date: Wed, 28 Oct 2026 18:21:08 +0100
Message-ID: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: odfpnsetw339jyxm6kjtatmjh8o3gowi
X-MBO-RS-ID: 6b39a3b04a49b99ec66

There is currently one user of core DWC PCIe struct gpio_desc *pe_rst
field, which is R-Car Gen4 driver. This driver already does convoluted
handling of both GPIO controlled PERST# and reset controller controlled
PERST#. Simplify the situation using reset GPIO aux driver.

First, eliminate the pe_rst GPIO from DWC core, so it is not in the
way, this is the easy top half of this patch.

Second, deal with the resets using reset GPIO aux driver in the R-Car
Gen4 PCIe driver. The R-Car Gen4 PCIe driver currently handles two
variants of DT description which can be passed to it:

1) Combined mandatory PCIe core resets and optional GPIO PERST#:
   pciec@nnn {
       compatible = "renesas,r8a779g0-pcie", "renesas,rcar-gen4-pcie";
       ...
       resets = <&reset 624>, <&reset 1121>;
       reset-names = "pwr", "core";
       reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>; // This is GPIO PERST#
       ...
   };
   The PCIe core resets are requested already in pcie-designware.c
   dw_pcie_get_resets(), but the reset-gpios GPIO PERST# has to be
   handled later, in R-Car Gen4 PCIe driver host .init callback,
   to avoid interference with the core dw_pcie_get_resets(). The
   GPIO PERST# has to be requested by index since there is no
   reset-names entry for it, using the first unused reset index.

2) Separate mandatory PCIe core resets and optional reset controller PERST#:
   pciec@nnn {
       compatible = "renesas,r8a78000-pcie4", "renesas,rcar-gen5-pcie4";
       ...
       resets = <&reset 345>;
       reset-names = "pwr";
       ...
       pciec40_rp: pci@0,0 {
           compatible = "pciclass,0604";
           ...
           resets = <&reset 815>; // This is reset controller PERST#
           reset-names = "perst";
       };
   };
   The PCIe core resets are requested already in pcie-designware.c
   dw_pcie_get_resets(), and root port reset controller PERST# used
   to be handled in rcar_gen4_pcie_get_resources(), but now the root
   port reset controller PERST# has to be handled later, in R-Car Gen4
   PCIe driver host .init callback, to avoid interference with the core
   dw_pcie_get_resets().

Ultimately, this simplifies both the core and the R-Car Gen4 PCIe driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Alex Elder <elder@riscstar.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Randolph Lin <randolph@andestech.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Sherry Sun <sherry.sun@nxp.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
NOTE: Thanks Bartosz for helping me figure the GPIO reset aux driver out
---
 drivers/pci/controller/dwc/Kconfig           |   1 +
 drivers/pci/controller/dwc/pcie-designware.c |   4 -
 drivers/pci/controller/dwc/pcie-designware.h |   1 -
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  | 107 ++++++++++++++-----
 4 files changed, 83 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0a0d56fcf0ac9..d65cf1e9d842b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -350,6 +350,7 @@ config PCIE_RCAR_GEN4_HOST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_RCAR_GEN4
+	select RESET_GPIO
 	help
 	  Say Y here if you want PCIe controller (host mode) on R-Car Gen4 SoCs.
 	  To compile this driver as a module, choose M here: the module will be
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 12f102f48d5d5..b09c01853d807 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -104,10 +104,6 @@ static int dw_pcie_get_resets(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	pci->pe_rst = devm_gpiod_get_optional(pci->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(pci->pe_rst))
-		return PTR_ERR(pci->pe_rst);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6d788aa000117..9dc86b66e415d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -575,7 +575,6 @@ struct dw_pcie {
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
 	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
-	struct gpio_desc		*pe_rst;
 	bool			suspended;
 	struct debugfs_info	*debugfs;
 	enum			dw_pcie_device_mode mode;
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fceecbd16355c..d3bf01485e11d 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -401,7 +401,6 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
 static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 {
 	struct device *dev = rcar->dw.dev;
-	struct device_node *root_port;
 
 	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
 	if (IS_ERR(rcar->phy_base)) {
@@ -411,18 +410,8 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 			return PTR_ERR(rcar->phy);
 	}
 
-	root_port = of_get_next_available_child(dev->of_node, NULL);
-	if (root_port) {
-		rcar->perst = of_reset_control_get_optional_exclusive(root_port, "perst");
-		of_node_put(root_port);
-		if (IS_ERR(rcar->perst))
-			return dev_err_probe(dev, PTR_ERR(rcar->perst), "Failed to get PERST#\n");
-	}
-
 	/* Renesas-specific registers */
 	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
-	if (IS_ERR(rcar->base))
-		reset_control_put(rcar->perst);
 
 	return PTR_ERR_OR_ZERO(rcar->base);
 }
@@ -594,19 +583,84 @@ static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 	return 0;
 }
 
+static int rcar_gen4_pcie_host_perst_get(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	struct device_node *root_port;
+	struct device *dev = dw->dev;
+	struct reset_control *perst;
+	int index;
+
+	/*
+	 * Handle two forms of DT which can be passed to this driver:
+	 *
+	 * 1) Combined mandatory PCIe core resets and optional GPIO PERST#:
+	 *    pciec@nnn {
+	 *        compatible = "renesas,r8a779g0-pcie", "renesas,rcar-gen4-pcie";
+	 *        ...
+	 *        resets = <&reset 624>, <&reset 1121>;
+	 *        reset-names = "pwr", "core";
+	 *        reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>; // This is GPIO PERST#
+	 *        ...
+	 *    };
+	 *    The PCIe core resets are requested already in pcie-designware.c
+	 *    dw_pcie_get_resets(), but the reset-gpios GPIO PERST# has to be
+	 *    handled at this point here. The GPIO PERST# has to be requested
+	 *    by index since there is no reset-names entry for it, using the
+	 *    first unused reset index.
+	 *
+	 * 2) Separate mandatory PCIe core resets and optional reset controller PERST#:
+	 *    pciec@nnn {
+	 *        compatible = "renesas,r8a78000-pcie4", "renesas,rcar-gen5-pcie4";
+	 *        ...
+	 *        resets = <&reset 345>;
+	 *        reset-names = "pwr";
+	 *        ...
+	 *        pciec40_rp: pci@0,0 {
+	 *            compatible = "pciclass,0604";
+	 *            ...
+	 *            resets = <&reset 815>; // This is reset controller PERST#
+	 *            reset-names = "perst";
+	 *        };
+	 *    };
+	 *    The PCIe core resets are requested already in pcie-designware.c
+	 *    dw_pcie_get_resets(), but the root port reset controller PERST#
+	 *    has to be handled at this point here using subnode request.
+	 */
+	index = reset_control_get_count(dev);
+	if (index < 0)
+		return index;
+
+	/* Attempt to request GPIO PERST# in PCIe controller node. */
+	perst = of_reset_control_get_exclusive_by_index(dev->of_node, index);
+	if (!IS_ERR(perst))
+		goto exit;
+
+	/* No GPIO reset, test for root port subnode. */
+	root_port = of_get_next_available_child(dev->of_node, NULL);
+	if (!root_port)
+		return dev_err_probe(dev, -EINVAL, "Failed to get PERST# in root port\n");
+
+	/* Attempt to request reset controller PERST# in root port subnode. */
+	perst = of_reset_control_get_optional_exclusive(root_port, "perst");
+	of_node_put(root_port);
+	if (IS_ERR(perst))
+		return dev_err_probe(dev, PTR_ERR(perst), "Failed to get PERST#\n");
+
+exit:
+	rcar->perst = perst;
+	return 0;
+}
+
 static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	if (dw->pe_rst) {
-		gpiod_set_value_cansleep(dw->pe_rst, assert);
-	} else {
-		if (assert)
-			reset_control_assert(rcar->perst);
-		else
-			reset_control_deassert(rcar->perst);
-	}
+	if (assert)
+		reset_control_assert(rcar->perst);
+	else
+		reset_control_deassert(rcar->perst);
 }
 
 /* Host mode */
@@ -616,6 +670,10 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
+	ret = rcar_gen4_pcie_host_perst_get(dw);
+	if (ret)
+		return ret;
+
 	if (pp->bridge)
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 
@@ -623,7 +681,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = rcar->drvdata->init(rcar);
 	if (ret)
-		return ret;
+		goto err_init;
 
 	/*
 	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
@@ -646,6 +704,8 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 err:
 	rcar->drvdata->deinit(rcar);
+err_init:
+	reset_control_put(rcar->perst);
 	return ret;
 }
 
@@ -656,6 +716,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
+	reset_control_put(rcar->perst);
 }
 
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
@@ -830,7 +891,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_gen4_pcie_prepare(rcar);
 	if (err)
-		goto err_prepare;
+		return err;
 
 	err = rcar_gen4_add_dw_pcie(rcar);
 	if (err)
@@ -841,9 +902,6 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
 err_unprepare:
 	rcar_gen4_pcie_unprepare(rcar);
 
-err_prepare:
-	reset_control_put(rcar->perst);
-
 	return err;
 }
 
@@ -867,7 +925,6 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 
 	rcar_gen4_remove_dw_pcie(rcar);
 	rcar_gen4_pcie_unprepare(rcar);
-	reset_control_put(rcar->perst);
 }
 
 static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
-- 
2.53.0

