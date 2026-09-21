Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03721441600;
	Mon, 21 Sep 2026 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022530; cv=none; b=DATtrj736evCWPac19KQ+BOSuqG0UXlVJ2QKOYG0V4goHvc9tQzyCV7AI2TqaW7hIxeEyrpS0TyvXxb8HZncyTRHe+bJKKzEFxprWj+/obhkd8cSoNX4jbYfSDi9huljwBdoUgdtgT9Pu47qQC1GuTmNBoOehcL3c8fmN5uGhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022530; c=relaxed/simple;
	bh=1keWf0an08BpMUuj0ky/YTTeKeVWhs/NlrxyNYLVSSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqMiTndAVaAgNpCGLlJS1M9p7zHdaskKsOAvJsslRucBSjvi6gDlu//wa3WGkLjsXR5FDd12hEFju3toxfdmAnT1NiU1O/KTeNF11gsa/t7ee8v4PNNUmUDfznauYsHqs3JKbZ9oZkRLwhtDfo8aKF9TR/qi99PbxsxgA2THBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aygeOC++; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EtsFTY7P; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aygeOC++";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EtsFTY7P"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hpZZ7020dz8tR9;
	Mon, 21 Sep 2026 22:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A87Z7T1Dz9zhLDGnRE7Zqhy/TF7eJojsOyBuIgO8RjQ=;
	b=aygeOC++roJpylHvj/PKS+PshAfuE43hGATWyVN3BS/ZniHWM9ZWsQ1SIzmGFIGbBarohc
	1FKDVfKd3JSKJK/6CzUYxbJhRgOkE0c6wjDMfTe+Gdeoytl0m9ZqdqxYZ6xwn6Dc9VauF8
	aDTKW81+A50IxAVq3As6b0FH9DJ0po6lWgqMB7mFNwedmy+yZZ0ZjjrCFJpOROjqQ6difU
	9MdjusWmbl41OYyMPlk2nnH2k1fZASCuDptjBptnSB8CGFa0knZ7NjWd4lJtkfznX4GSs8
	CrXrYNWniXQU6vCnKHLYOoIGKY7NYp78e6ELCH94Q8CsxlX8Ucj86bcR6lyQqQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A87Z7T1Dz9zhLDGnRE7Zqhy/TF7eJojsOyBuIgO8RjQ=;
	b=EtsFTY7Pbfnpv3grDWbFs1XOoFy76qGWWrAgOCJ8i2OhxQeMQyASm31oUfrmv7q6qzdEOX
	6XV3qGwR7mDhWh22YyTbqDCp7Dj0jYIFgViLkHNITejJWMC3NwB74LPzk6pZWbSEBrlBbc
	wM3wOIymK7R6jt4UaQU5yxM/JlADZSXgLuYG+asA72vJp/mGj7H862ETJm2JJD/Z39uXnt
	OakpYUFevTZny2qTxJRbmS4TGYdl/FK/COqM7Q0JIbSWzgoIiuAJQrQFPZlsaGuf3HwekN
	lugImo0LQc/2l08XNpAnxWEydT5n4uTLbHIkCl8iDU/yzquUc+E6wACM7rF/2g==
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
Subject: [PATCH v5 4/6] PCI: dwc: rcar-gen4: Split .start_link into ltssm_control and speed_control
Date: Mon, 21 Sep 2026 22:27:46 +0200
Message-ID: <20260921202823.72620-5-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: a098deee36f747c98c8
X-MBO-RS-META: u8zngxeiz8ad9y87u54n9ngqnon41pit

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
V3: No change
V4: Rebase on next-20260904
V5: No change
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 39 ++++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 04871ac11c348..c768a9c7b3b76 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -90,6 +90,7 @@ struct rcar_gen4_pcie_drvdata {
 	int (*init)(struct rcar_gen4_pcie *rcar);
 	void (*deinit)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
+	int (*speed_control)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
 };
 
@@ -141,20 +142,10 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
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
@@ -178,6 +169,24 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
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
@@ -916,6 +925,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.init = rcar_gen4_pcie_common_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
@@ -923,6 +933,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 	.init = rcar_gen4_pcie_common_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
@@ -930,6 +941,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
@@ -937,6 +949,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
-- 
2.53.0

