Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A2282F26;
	Mon, 20 Jul 2026 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513136; cv=none; b=OpnsAk3jRNaCfrCM/E9p4nL5Qrfblg1Qx06u1A5qNMqfakbJrzUKHAim8zRn/PIDXrC8YjzFM4EuLuaFW5rs+/qyISxwCc846fpVl2UbeVGQfl5hfzHKMs5qLVL05ZVQIp6fqdk2CyQ6LJBu6y7r4BI6mXVilpc4T11RxLGg8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513136; c=relaxed/simple;
	bh=fQYaYq41N03hP+xwNJmkJ4dotFmrUNyxTVgogjewmfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tz36rSkKW84jRCUIYOC4JbUuUHcx0wam3pDpz4nHqFI0YqPOU5hOS9jeL9ewsJWiNijCZc81xyekSFiOBABFfFPhP6/xs+8ypgfsnufCFbz0XEx9qbZ3/+oJ+OsWTIfTRKjbJe975FcvlcdZ+ZZ9Xnn6MTpfDPgtsDvIL5zbtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IOHDTd9w; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lCIGUmGp; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IOHDTd9w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lCIGUmGp"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h3P420JDkzKs8b;
	Mon, 20 Jul 2026 04:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrLRIaFCiSjGKemS1+PTENGyKItMA/JqxcvMIUVTg2s=;
	b=IOHDTd9wTtXj95iAPr42X625iawuXumxUal4vXGsSSE9Q5vBWIFisv8b2UvbcFqxHpAPfy
	h66PLYtAp8DNfFh38U3XUY7p/aklf3w9hHz9rYlqgzZZCVZdUanTs3WzoP7vE7gj3prO0c
	tlRUpdK/iBE0wYYuN9jqj2lgw1mVymqKRJSLaT0ysZWqY/X8Xpce+vShtfCYAXuhEsHzAt
	E/Knm2iOIDbf9LRhvUdPKumsyz+32u6rFS1Zsru+vkbRxFwbcYvjzxnxFgE1RfxGor1XvO
	+rg9BvHFnAzSm3qSJLcHTgw4HNBM6JFFlShaQQnSZPtgF5AHS4ZVLx7K5K4SwA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lCIGUmGp;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrLRIaFCiSjGKemS1+PTENGyKItMA/JqxcvMIUVTg2s=;
	b=lCIGUmGp1O15zUrwZjypYliMhdeTnTk3KSmPfEyYwaZGUJr3uVLjYKcO61vt1GslJo+plk
	ozeXajpQs9DepclamEjrW5+BUmdiPkHGYfiB72VNWqJtm0MK4mzamfzlHPgwNvU4yA31hc
	wgxJTKiodZL+XxPffvDGMGDFhY0JmUuu0/yicD4AqMCtV5JiYxGigjZ0Zr5v72DqYzUkvb
	0I7NOx6qoECXOxE9Oh5eOlzPE1+rubkQfIAyPtzYNTNJR3G9aKqI9+0Y9tq3gy22AmbEHK
	fAALuqpO3l1u0qSmqWixZKrmByMnMoiatzbDwT48e2FosN3s8KdGMVxif/f1Kw==
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
Subject: [PATCH v2 2/5] PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_drvdata .additional_common_init into .init
Date: Mon, 20 Jul 2026 04:02:30 +0200
Message-ID: <20260720020505.315335-3-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: 7443db17e511f9236b9
X-MBO-RS-META: 6eq3xis5bfhq79dkmbxex788uwqsg43m
X-Rspamd-Queue-Id: 4h3P420JDkzKs8b

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 56 ++++++++++++---------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5f7211b91ee5b..5724f64eadfad 100644
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
 
@@ -487,7 +509,7 @@ static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	ret = rcar_gen4_pcie_common_init(rcar);
+	ret = rcar->drvdata->init(rcar);
 	if (ret)
 		return;
 
@@ -681,22 +703,6 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
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
@@ -848,23 +854,25 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
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

