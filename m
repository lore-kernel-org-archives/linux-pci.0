Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208116;
	b=TLTw1kAkZUptv/u3Gn4PmAws40wwqCI/7ChOSkq2tAB3FxIXbAih6aBZb0F9FwWByP0F
	 GlRZ7oSTca/iEjjYxZtRv0CM8DBmrb83HYX3FNi9Mvu/3hrAUE42RbgZ0kas1U81zSRzE
	 gQgi13dGQyzdkBG0izKdrDjE1Y8Xe74F5ldjp8AnNNnmto+/8nZ7lBO/mDDF4hBXA515U
	 GKSegS7x/hE24IrFNc3s10D7dQSEDSGhljrHr7DPdwMWjHsOlh+Q/Om0VDcwUooAKie4W
	 TjEcJ+weJft77yOAdPqpFl7Jfd0geNDgup3JRvbC1MjOkc60x1wEFre5QLEC4YZlApg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208116;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=d3kAaHXfzgfs105nLyPzinHExM33Kf5Erj2iCSynZSY=;
	b=AcFv7otbZxSDIFEh2/UG+OEyJfahFb7saXM3lRH+oTxFLt5xKDjHWZQskrK20Zx5ZWHg
	 9kvbMNhlFVQmUIknwrBSI/Or7REvQpjW/wYOwchjRxvLg7kHS+oyrw0kJ7zGbXgVMsqMx
	 hYbUbBNvpTUf2tC6fhhWkwqr8nIKsJ03aTkFF0FsoXMLDHUZXOAAzeGBwtK5DoyGUgLV1
	 54Jmh4Ui0DvQmwHlNtfjU9vaQK/XwSvMU3Xgo06koUGC4W0GaNFG/FCyB1p4QgBFs7+AI
	 A/BzRFU57NiUPS6Wgzb0OGvQYTQIDUWj6sXDon5eL/rbLivCp0YjGQTNPAhQtSj4h/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=UrobJ1EV;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B456606A339;
	Wed, 28 Oct 2026 17:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B456606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=UrobJ1EV
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jFDgH2chWz8vNb;
	Wed, 28 Oct 2026 18:21:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793208107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3kAaHXfzgfs105nLyPzinHExM33Kf5Erj2iCSynZSY=;
	b=UrobJ1EVK4JzxO7qh768gSiromXelw0Du7MgpFoBYf4xKvqOxmgaPge9/AlCXbapLLTISa
	JrbaX6HChgXPtomVXxrce8Lc70dtrpEaLq2LSTlP5NiA/TB67Ah1PaTgTL+2dKtHNJD4EL
	BpHeNJmmWoF+9HVnslKYCn3WcIoVCbMEWFtG4HFrpxfwoXdj5yTEffvFTlGI0n45Wti3Dj
	l9PTO3+iAMTDxN19IkfwFbISlmmwJvvoUFYVL8AyaskP7JK220rht9QWtRSXoWlGmREdIW
	LT+DszHybuN7MVO5EgjXJKieg9n3SnmYPRZRxpdffA6R9JOV14NmyxJ/WuzTfw==
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
Subject: [PATCH 2/2] PCI: rcar-gen4: Inline rcar_gen4_pcie_host_perst_assert() again
Date: Wed, 28 Oct 2026 18:21:09 +0100
Message-ID: <20261028172133.20903-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
References: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-META: bb6ub54kefq59r3m69zx5bnoque3gcz7
X-MBO-RS-ID: de08f5814a00ddbcd13

The rcar_gen4_pcie_host_perst_assert() no longer has any purpose,
inline reset_control_assert()/reset_control_deassert() back into
the rest of the code and drop rcar_gen4_pcie_host_perst_assert().

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
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index d3bf01485e11d..9a64a9f4ab0d1 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -652,17 +652,6 @@ static int rcar_gen4_pcie_host_perst_get(struct dw_pcie *dw)
 	return 0;
 }
 
-static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
-{
-	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
-	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
-
-	if (assert)
-		reset_control_assert(rcar->perst);
-	else
-		reset_control_deassert(rcar->perst);
-}
-
 /* Host mode */
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
@@ -677,7 +666,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->bridge)
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 
-	rcar_gen4_pcie_host_perst_assert(pp, true);
+	reset_control_assert(rcar->perst);
 
 	ret = rcar->drvdata->init(rcar);
 	if (ret)
@@ -698,7 +687,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 
-	rcar_gen4_pcie_host_perst_assert(pp, false);
+	reset_control_deassert(rcar->perst);
 
 	return 0;
 
@@ -714,7 +703,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	rcar_gen4_pcie_host_perst_assert(pp, true);
+	reset_control_assert(rcar->perst);
 	rcar->drvdata->deinit(rcar);
 	reset_control_put(rcar->perst);
 }
-- 
2.53.0

