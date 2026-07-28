Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971482E54D1;
	Tue, 28 Jul 2026 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202413; cv=none; b=Y4hn8yaHPImrRe5Jv71Wk1XJueH8FT7ei89D7BtmG+rUGj2lbo9+9e0Yl5xqyxccx8g98JQzK1gyw2lubeOnfs4mJN9AHLkbJqLpoRPNRDUJHxCuYdCVXcP0qpwYeWDrVKSvhtGg5HaQM3z1MQ8sY3wj5YlCGVti29lk8H4nar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202413; c=relaxed/simple;
	bh=Dq7Da0/ui+RB4dobomei3tSx+0546DaO2lvIDFuvTjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNhyMCHRKHmui3Z56Acr1+cT+6OMbvWfMbZ8n8PFfwrWAotgAHLVtP28tGPMMVx2Q/FtM9pi6pfTu6tOeWQic7amDPH6o9qDOM00PAPlA51ect+6h/o0X7e30mEmhyHYNslE3uRf2xABSaEIvvyJ1IA6+JZFse4E14NQa3Sd61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qOp+2L3S; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=m/15KiF8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qOp+2L3S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m/15KiF8"
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8HzY4zH8zMlJ8;
	Tue, 28 Jul 2026 03:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msWnAS1rUreCbFMfDmP9iCSbk/R9NxiBHwU2LkRIypU=;
	b=qOp+2L3Sx8mE4rE8Cq7x5XxdclX1u3Ovg8oGRGofOJvieEjutu0K1neP/VMZTRF9hYRH9D
	xOTBK9ipNCQffRWxJEdalHby8NdEJJjb7CYtHQctXc4Ykhazva8msocZOY6HHIMQkCeE8u
	gW9psD1/jonQRGj6AAadYzMEB9yEZumfG+iq70wZgBmR3ClLuJs0nzTeO1uTa8EW69BV4E
	M5ihMnZRrtFE5SkEFTcqDJdSdx4hUOBkce0nrJP1MwHwpG2yo3upkzKTpjswGby34YX7Z/
	Bcu4kscF0VTBzA/rc16QXkmnfKppJX+Y6no1Y1S11wtRFtIyXBV/OkPvHCC6zw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msWnAS1rUreCbFMfDmP9iCSbk/R9NxiBHwU2LkRIypU=;
	b=m/15KiF8PkgR4Ob6EkSK7RWV6kggPAvp36NY5NMrbzfI+3gQaHzsn9ulwPuHae3Vj9DHIW
	gDSc0UcV5dBnMoCElmsnEXpPaU+lVHaqy4LrhJiKc0G6Q2SJSHGeTaUhIA82LMrr927M1R
	64zIHm62s/Y79sH3u48dxRq5FDo5bCmFTKj6FoWL3ALS1ZoDPESMz/BMpCGD0dmYDAWemN
	IS0/u04VUlg3mGEhlGoorsH9Tu3H1EbU5DrQZJwIm+IyGtP5wbh8tWJ6MmD3Mm+W9uNJ0M
	6NOVAzv8MvBuhFtBHOQ6OG9kfoPwAgWrQK/jOAPxhtETeJf35tF3lNdpYndKVQ==
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
Subject: [PATCH v3 2/6] PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_drvdata .additional_common_init into .init
Date: Tue, 28 Jul 2026 03:32:35 +0200
Message-ID: <20260728013311.466242-3-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: m9osf1t6qrg6sxibegea7c67t4xbs78g
X-MBO-RS-ID: 0fced647bd0e7bc08f7

Rework the current complicated initialization callchain that invokes
host_init->common_init->additional_common_init() for host and
ep_init->common_init->additional_common_init() for endpoint into
simpler host_init->init() and ep_init->init() .

The init callback is now always implmented for all R-Car Gen4 SoCs,
therefore there is no need to check whether the callback is not NULL.
For R-Car S4 the .init callback is rcar_gen4_pcie_common_init(),
for R-Car V4H and V4M the .init callback is implemented using a
new function rcar_gen4_v4h_v4m_pcie_init() which calls the common
rcar_gen4_pcie_common_init() followed by R-Car V4H and V4M specific
hardware initialization. The hardware initialization sequence remains
unchanged.

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
V2: Rename additional_common_init to init, reworked from previous patch
    PCI: dwc: rcar-gen4: Return error code from .additional_common_init
V3: No change
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 56 ++++++++++++---------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fbe465a29068f..278abdc7ba2d2 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -87,7 +87,7 @@ MODULE_FIRMWARE(RCAR_GEN4_PCIE_FIRMWARE_NAME);
 
 struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
-	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
+	int (*init)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	enum dw_pcie_device_mode mode;
 };
@@ -241,9 +241,6 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 	fsleep(1000);
 
-	if (rcar->drvdata->additional_common_init)
-		rcar->drvdata->additional_common_init(rcar);
-
 	return 0;
 
 err_unprepare:
@@ -252,6 +249,31 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	return ret;
 }
 
+static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	u32 val;
+	int ret;
+
+	/* R-Car Gen4 common initialization. */
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
+
+	/* R-Car V4H and V4M specific additional initialization. */
+	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
+	val &= ~PORT_LANE_SKEW_INSERT_MASK;
+	if (dw->num_lanes < 4)
+		val |= BIT(6);
+	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
+
+	val = readl(rcar->base + PCIEPWRMNGCTRL);
+	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
+	writel(val, rcar->base + PCIEPWRMNGCTRL);
+
+	return 0;
+}
+
 static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -420,7 +442,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 
-	ret = rcar_gen4_pcie_common_init(rcar);
+	ret = rcar->drvdata->init(rcar);
 	if (ret)
 		return ret;
 
@@ -487,7 +509,7 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	ret = rcar_gen4_pcie_common_init(rcar);
+	ret = rcar->drvdata->init(rcar);
 	if (ret)
 		return ret;
 
@@ -683,22 +705,6 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
 	return 0;
 }
 
-static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pcie *rcar)
-{
-	struct dw_pcie *dw = &rcar->dw;
-	u32 val;
-
-	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
-	val &= ~PORT_LANE_SKEW_INSERT_MASK;
-	if (dw->num_lanes < 4)
-		val |= BIT(6);
-	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
-
-	val = readl(rcar->base + PCIEPWRMNGCTRL);
-	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
-	writel(val, rcar->base + PCIEPWRMNGCTRL);
-}
-
 static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *rcar,
 					       u32 offset, u32 mask, u32 val)
 {
@@ -850,23 +856,25 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 }
 
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
+	.init = rcar_gen4_pcie_common_init,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
+	.init = rcar_gen4_pcie_common_init,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
-	.additional_common_init = rcar_gen4_pcie_additional_common_init,
+	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
-	.additional_common_init = rcar_gen4_pcie_additional_common_init,
+	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
-- 
2.53.0

