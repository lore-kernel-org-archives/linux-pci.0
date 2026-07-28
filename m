Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AE2F8EAE;
	Tue, 28 Jul 2026 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202419; cv=none; b=aCupTNqb6MfzQiPTLLFmSdxhwQyActdBnHvl4YQAt0G38OMM0kX0Co94cwVSFZjvB7wW9T/xSE0p3SPczcfRc+swDePsFJMhGZ2DJXugWxcRJxzrJtR9ElzYw1v5kmQprD5Yl334kWni4Ks+F0O+Z2i8NT75QkgKu38yMqr/HCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202419; c=relaxed/simple;
	bh=zY/iDR4CrjC3Y1GftiIE0W3FxTh7AXCnxYMKIKmSRKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp24wlmozKkjTuE1XBSa6QHshX+qXj3LldHVrPkpZwGUl/uvMSFxv2llkcyMIJgTPxyy6fCZqkYVh784f5zqUR9lBXh+PlUcBKS/yiegjLbNWGss7uXZUS51Ubp+V7vUWWv5/uRsXt/cgkm4HqfeScTahRnO6cWicnKgNBCiieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O32FS2qP; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eVrUP0zH; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O32FS2qP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eVrUP0zH"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h8Hzg3xyDzKvtg;
	Tue, 28 Jul 2026 03:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBSUVnlkxsfRhsuua6xIF9FTcCIY32bjD0Rb3oVHB4w=;
	b=O32FS2qPzCYu/LSFrZGS57pHiYRRuVi4N00m/JHck9w1TNudeNtA00UFk6ZBZX3mCLsW0I
	XC6DUs5UI6ZUUJalkXcWNcXrom79pPpA4g1B5n0eyYHV2LlsidtaROjU5NnyaWYBRp9bZK
	Ei+Ws9jfcDgCKLNVFeiaP2RDVk8N0O16HXDqZV/K5q8tAwTZNJKvxW0G9Ylbs+R96g7V1P
	xqatX9u/Zz6zX6GWFB+o6hP5RaxnODmp3cKGQfkFRSEUeULIJRrS5/F2V3HR+XpD+VfCrr
	AKbCu1F+qD/XX7ZqaCGMHAM5znWfLpYAbpPSyWTFC+5nT4tv0iqyZgPSQvdihw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=eVrUP0zH;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBSUVnlkxsfRhsuua6xIF9FTcCIY32bjD0Rb3oVHB4w=;
	b=eVrUP0zHJRZB2cMTHhYmnlc6IBIPbv1frMSlKmLatg4K4oJAuvzz4oQawkn4Eb0iinkvEW
	a7eGwLDEHo1fux8KZKxe3GYRVrRTpbjSY22RkQvrz8gPunJfVUHNsrgpzjoYPm0JBu4Tec
	Jdhhytr5SqezFFdtnVzKhcRU0X2h9mtfAdd9U/653cC4K4ybojMoyujPEWwZVbCObxW475
	mn7u73Z7fapauQ4pBdwz+XpPeSrHXL96/EvL4iTmBdhcLa37Ftk0DTr57mjntmtXmYkXfz
	Zz7YDKRCE9n/aaNxK8WE+1Cazd8MqVzviftnRgg58lNP/JDp0kJIVdYJbr6Lqg==
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
Subject: [PATCH v3 4/6] PCI: dwc: rcar-gen4: Split .start_link into ltssm_control and speed_control
Date: Tue, 28 Jul 2026 03:32:37 +0200
Message-ID: <20260728013311.466242-5-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: 7qunuz4cfu9no5a48j378yo15aj7dr4m
X-MBO-RS-ID: eb7a2a3a841bd990d88
X-Rspamd-Queue-Id: 4h8Hzg3xyDzKvtg

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
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 39 ++++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index b39f9bc447afe..ff1969338a276 100644
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
@@ -860,6 +869,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.init = rcar_gen4_pcie_common_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
@@ -867,6 +877,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 	.init = rcar_gen4_pcie_common_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
@@ -874,6 +885,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
@@ -881,6 +893,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
+	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
-- 
2.53.0

