Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A0282F1F;
	Mon, 20 Jul 2026 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513129; cv=none; b=boTbv71vONGkqva9T0w3/Ax3InS/WfVyKisE9ysBpvpXcnN6t3npRq7RPeCvz8MhcMnFGD1djFSJa1v7tTzgGhiOh5sUjF/A9tfKo93rKqepXmMQB92tZVUj7mjV7FfQkysn0Aw7VCzLuXJRyXOTDj0BlKTWhWBbaBc1raAhz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513129; c=relaxed/simple;
	bh=o3EgQFFJ6P1zx7lZzZMEI4om17DH24wPdNxhkg2gPjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAKfctuKW01qXNpPdkZwOUvoomHqMBTGlKBjuY8QQgV7VSK2PCZRg60+9yxPv5Et6/7xSRvcvuknYT7S0sk9hdGE7U2SH0Fgf9OqaP1t5IEH++oFD28RfQwmq4o1K44FZHgy7wgLMZuEcmO501On7fkiGsKyuJF5PkjgNrAdzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kSrWqq9T; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eCVCNSIL; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kSrWqq9T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eCVCNSIL"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h3P4511ZPzKn8l;
	Mon, 20 Jul 2026 04:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upke4j96P67TQl/si4nbcl5wUON9IBWPSX/vdoa7JVk=;
	b=kSrWqq9Tlv7UztALGdsf83oF6Z2NzUbGsrPCmYDoRfOopcWp6VXKqNkYayzm2A97nBORPs
	lmG5sDtqUJsNIZVvpsr25XqpQIuCghPQyNX0ApuqdqDR2uvPWK+FqW9l8nz6tElOJxtSIS
	1gVzAJMlyv4XTgy2pOTW8gwzM8oKec8uKnSnXzUJj9TVGSx4ioAl8ZxwfL/DKBA7O9fTH7
	oDtCodTeObrjcO2LgTMtB/uQu2lxySxi3WbrB/ars5CaTat3adDOFf30JNbb2qDzvjII1c
	FxPZKThOxrpipHMfBojdxuTWorwqbWivZDdmKRqh5LYyOryFxCBWkj3wsbmYEg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upke4j96P67TQl/si4nbcl5wUON9IBWPSX/vdoa7JVk=;
	b=eCVCNSILxFKfs6RWprQ+Uq9oMXRdUdUaatKi3yQ/eX0TIKW8/9LMpebqNUD7TmB9sNLiFx
	CpZ08H0zlIaXx4aE9iHhRI0qWahoncwaGMcAt++RfcixPUDYiFPYHBkNz2VxJj8G30uCiT
	yu0rK/spHaR6axkjD5DxUkOJt11rhK1on3vNAcQXou7B/Ytrzjg/6aKAPko+Eq20mzcfTG
	T3OdF8JUT2h0iznTWQYt1DCLlIB1v3Odgw0iG1Z+gBvLbDBeT6tswyHZTpVp9RXw4VjMgL
	Rk/ukXo2PfinbW/FhUfr+KZ/b7RqgzNNGFSHTz6KPoO6ySCSDA/QaU10v4aQ2w==
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
Subject: [PATCH v2 3/5] PCI: dwc: rcar-gen4: Split .start_link into ltssm_control and speed_control
Date: Mon, 20 Jul 2026 04:02:31 +0200
Message-ID: <20260720020505.315335-4-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: 41c980f3f7a55eeb220
X-MBO-RS-META: 37fzax1n5r4j71ob7hw3xwcsuyzs1k9b

Introduce new .speed_control callback and implement it on R-Car Gen4.
The callback implements the second half of what is currently present
in rcar_gen4_pcie_start_link(), and rcar_gen4_pcie_start_link() does
call the .speed_control callback. This is a preparatory patch for
R-Car Gen5 support, where the .speed_control implementation is
different.

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
V2: No change
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 39 ++++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5724f64eadfad..73b01e74b42cb 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -89,6 +89,7 @@ struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
 	int (*init)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
+	int (*speed_control)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
 };
 
@@ -140,20 +141,10 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
 	return -ETIMEDOUT;
 }
 
-/*
- * Enable LTSSM of this controller and manually initiate the speed change.
- * Always return 0.
- */
-static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
+static int rcar_gen4_pcie_speed_control(struct rcar_gen4_pcie *rcar)
 {
-	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
-	int i, changes, ret;
-
-	if (rcar->drvdata->ltssm_control) {
-		ret = rcar->drvdata->ltssm_control(rcar, true);
-		if (ret)
-			return ret;
-	}
+	struct dw_pcie *dw = &rcar->dw;
+	int i, changes;
 
 	/*
 	 * Require direct speed change with retrying here if the max_link_speed
@@ -177,6 +168,24 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 	return 0;
 }
 
+/*
+ * Enable LTSSM of this controller and manually initiate the speed change.
+ * Always return 0.
+ */
+static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int ret;
+
+	if (rcar->drvdata->ltssm_control) {
+		ret = rcar->drvdata->ltssm_control(rcar, true);
+		if (ret)
+			return ret;
+	}
+
+	return rcar->drvdata->speed_control(rcar);
+}
+
 static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
@@ -856,24 +865,28 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.init = rcar_gen4_pcie_common_init,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 	.init = rcar_gen4_pcie_common_init,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
-- 
2.53.0

