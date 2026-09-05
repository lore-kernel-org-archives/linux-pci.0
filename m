Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6E36F8F1;
	Sat,  5 Sep 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643632; cv=none; b=bzft9d6W33u3tyh4/hw4K6a/227y8dX9PTxreTkE55I8OlVJ6GpE9pmlKQ/oF6ff1U5egGUoQlMR0JdrjH+1uYuMQ7V3pkbjxHqRLFLUjYal/+lt4vw/qv3i3vHYhFxZWra4uCQ7ndjcCocxn8wKM1zv93obCf3t/1/tINx8Vyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643632; c=relaxed/simple;
	bh=YjshxZODtN5IKVjpB4QtfZY+xDjxX/VCz+txsG+2Y5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6ncIsVykfJOgsLft8XlZ1Uk0pZ+LbJbOvCEAg5nCqIjDmg8u/tUuYbAkEJezXq47o8UAtsDUw9IbtsTLQCOpJRZDFOQCLPU+L3Hi2Ph4vG8ktvMsNB8z4Mg4Fj5Fp+NSVw0hz0e2PDvRiKnvlC7jnXc3mb9AneI75TyFiyLlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=G1py4CDz; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vtRk4dk0; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G1py4CDz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vtRk4dk0"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hcmcq4h6szKvwt;
	Sat, 05 Sep 2026 23:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9N+he9sxxtxrNIn22r4COJqbJUj6mIguKAX03JG3t8=;
	b=G1py4CDzB9nCeJC3vbDKKFKPBYlQ8/SKWWb5vBN5KiZFQj69EoEk2864J+5rgHO0bwT6bl
	E9jg+rzNPvQc5AeDLQk2niXMtLtWNp87NtTXa1v2D6RqthvSraVixQeZ/ihqRD/QUdFWDk
	5Y0axQ7hcFNUB9iu+GdrFtQXufWgWGxo/DtvAT98i82nuOa3GYw69BHCinIDw8J1FzWrqw
	Bauvs6BvEjdE13aLS/RBaBagLmjK8i1NOjDO+LPPYPXZMybrFwz8fsBABby5OqNK06S8+1
	9KrKk94uZuUIc+6SSzjUSCVEb/wh+yQaimpywOfK+TaJeEotY7g+V+AYOTyxjA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vtRk4dk0;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9N+he9sxxtxrNIn22r4COJqbJUj6mIguKAX03JG3t8=;
	b=vtRk4dk0c2ACWdchK3oX65YZUYr7fGaOu50rOgu+jrwyWic35QH3YwqA8tfI3ozPbZppiZ
	Raq/1xkPI63ZYS62yMpos3sfEb5PmodjzIRpBJ+LhJR/72+QhoUH/5SvZUiUKcLsRKXi8l
	V4VtF7jdJb43ZTyvy5wkUrtHTTmtFrtkt5AvC47nHn3Zge9LNlfo4azNsk9qoytzheEnK1
	yIxhbKJ3KIEXqDgEHD1oY0PCzB7Kc3+qqjbCO11jYhLTnDMyrEqJ1KxmePl4eNua3hy77V
	UxKhqFzSVw17v6Owt+UdizhZojPjEigojuEmVW+R6lc4VDX+qVGd8zXWGStwjw==
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
Subject: [PATCH v4 2/6] PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_drvdata .additional_common_init into .init
Date: Sat,  5 Sep 2026 23:26:23 +0200
Message-ID: <20260905212649.360498-3-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: n1u1dmjpyj4g3cuizzmkefmgwcui6apa
X-MBO-RS-ID: cb659758d2db5ef1c3a
X-Rspamd-Queue-Id: 4hcmcq4h6szKvwt

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
V4: Rebase on next-20260904
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 56 ++++++++++++---------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5a076aa3f4904..a19ebbab2f8c3 100644
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
@@ -474,7 +496,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 
-	ret = rcar_gen4_pcie_common_init(rcar);
+	ret = rcar->drvdata->init(rcar);
 	if (ret)
 		return ret;
 
@@ -543,7 +565,7 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 
 	writel(0, rcar->base + PCIEDMAINTSTSEN);
 
-	ret = rcar_gen4_pcie_common_init(rcar);
+	ret = rcar->drvdata->init(rcar);
 	if (ret)
 		return ret;
 
@@ -739,22 +761,6 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
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
@@ -906,23 +912,25 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
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

