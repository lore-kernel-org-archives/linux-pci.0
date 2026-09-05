Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88363B14BD;
	Sat,  5 Sep 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643641; cv=none; b=KW7xQw0vRQ+rFvrqGUlEl6xQkYsS0i2NjycDJVp7h6HQcWyG/jILP25lWyrbhUYskmrAXjj5Uivmk0gnLGk5M/M3U7txuQ4Ndk2bJnF9ZlJZDdfVSXQQNZQPQlyqR8ElwY31QKnhYQ+ze195l4g99hXdyOfb4CcP3id9uulS2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643641; c=relaxed/simple;
	bh=q6BQQqGYkpm32aNDSHMtqGBGDzBy0fTVjNPpLA17eNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqMiiPmiJCYQRjBRAbBkI4FJNielU+VJckCuvTbdfH5SY79Ndppxt1SnMtVrPF6XCuc8GtZflgON+3I1+BhBZAXZ635RB/yEBP/q1IPpwFdw6oFuXUVVASg0Bv1EXG0tChZhFAc2qzH35iGz041tT801bv9CV4vzu+MQvMA9BO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=scyuSSzN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VzJdl6Q7; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="scyuSSzN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VzJdl6Q7"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hcmcy73k9zKv2F;
	Sat, 05 Sep 2026 23:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZliHt37nl5oMm3AvjG0cWeJ3vscugv/s7js+m/4ZTJo=;
	b=scyuSSzNZu5kw08c27m5rkldiQbjBBkh9qdv32iSrQb0x1gUzIC+HUE2Pyd6nwVfACfx1+
	gKKkEx5nh2ysyo5akOPp/uZ1WQlnPKTpLCQr37+a/lzKMKmA9qnIWO2anQx2ucTy/B4KJK
	LQFp3MtCPIZ3OfA6MEjxM8mzhaUvpcylZqN8+YgKO2lEf+c6en6ifQkfsvwI71O26aLQJL
	bzn9mvEMj84boCMQ7PsBkPY5TsqMH2zblKT0wlgjVAE6NqQFXfXo78X8uuxwTG6qTv+2d3
	kY23ROVtLDZTwTE7M958uVaqbXNQipbWXs8eft/EDyfeoSV5ySZG7bU3aFU65w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VzJdl6Q7;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZliHt37nl5oMm3AvjG0cWeJ3vscugv/s7js+m/4ZTJo=;
	b=VzJdl6Q7nDPaX2gcVQm28ZZR9D2Jim13tgwCSuQJfR/4c7RoYsf4WipdR+LlGtk6bWcAnM
	+AlToyH5BGjqgwRrWiDnPSsa5wEcTbmu6V67LhgfQt+Duem2WcL9SRW2SLuNWJt2fUvB86
	BfKW8Zzmf7Aal75iK10JIVVK8Q78+DOpELiALXjdUwy3bxO3ph/eNtnG1/NSvJyydn2H2K
	DudVGE5fY1PGlycAO2OrnIKnAXP8EaxUKebQ9K3a6UZUHLC6TWt3R9J0WQZKpUuRU4ZwZh
	0tVU+Ltsvt8ZPDogtVvRLd9bvWwBCXGcwIDcvhTpT5mxKsEvotUrEKIReJVqxg==
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
Subject: [PATCH v4 4/6] PCI: dwc: rcar-gen4: Split .start_link into ltssm_control and speed_control
Date: Sat,  5 Sep 2026 23:26:25 +0200
Message-ID: <20260905212649.360498-5-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: r86oqps6c3gd33uyh1mnretwhc5mjauz
X-MBO-RS-ID: 0b6a4a716ab0c85bea1
X-Rspamd-Queue-Id: 4hcmcy73k9zKv2F

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

