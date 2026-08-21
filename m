Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B791F099C;
	Fri, 21 Aug 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315311; cv=none; b=f/V1P+2Kk6Jeq/BL0m9KLS+3dMgvpu8lMv12w0J1ks6Yo1+U79kACHMcOcsEQcDyvlcH5cDfNYECEdityAfRaSo85CCVauPVsu7Q2cG5Fz5p8M0X9nz3NXn9PQT3gHlceUuZbIm4RJw2nqivlGP6t4dJzfgK2tZYSBpJzmpykUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315311; c=relaxed/simple;
	bh=FQpYfhwGaodFq9h530kJvDJeAPdWPaCx2PqR6L8SvzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZtPt4IeADLxz5NQtnZvE8Tl3b7e3ELW4D8x9jcinNbs2D79dDX4dZlH5WnXffsuKpySwCQAu7lcawFZBubKl/l2JncPazKZPjtmi/hZZpBStQuH1Xni04WKM+zGarG25UqTLa0vLCcESYpl6Vd+Ecfd0WnNGXkadIyPl8pqS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SwWq07Jz; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jCSV0ZBg; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SwWq07Jz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jCSV0ZBg"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hRKN539NJzKw29;
	Fri, 21 Aug 2026 14:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787315301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF82VvkMBcPp6Kh3cyr0M7lo5IrVHWJoZoyzVE7bfYc=;
	b=SwWq07Jzj5FSguELC8fth5c5yPDvGoOB6EaY06e4hPtQvwvPRmGJRmZxpnTP1mZODmpS6A
	A2kNlATwaUUBrTJwI0uQM2XcVcvAk8RJ7D+4tGLGWo0rb6AOQJbcQsse7jK7BaLWbk/YXu
	r1n3Ig7vEHcZVQ9QxFOc9Mj/G4L6qgwxzM7DKUDM3usuPBWLaYs5WLdn5lqhsuVyXegWS0
	slW5sgdhdLbrBU+GMKPUuIHpm+Fh8FjXjbQDRgm3W0aEqXiB3/RfcJz8te2XmP9iIVSZ7R
	jbkVyLubHSblKuMCVLkDg237MFojrj14TWsfUQCPa0IcEiRLnrwe6ppW5rU0ww==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787315300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF82VvkMBcPp6Kh3cyr0M7lo5IrVHWJoZoyzVE7bfYc=;
	b=jCSV0ZBgHtp2oaTOHpuU+SOVLOpweWSNxNa8W7ZMC/dj9Is+aNOK2iGvyRKOmxhKaTh5Ue
	ytAakgY1NAA2KpFHQDHmLNhUokowEHctpRAlxa0/eY+ToFizw6XJWxJV/rXSOUs0rBR571
	lpuyb+KkKeCKYzYw9O+d55AQwNdcG76B17LdFcLkLSlXQUqHRO9NQqv7Z+fFW5BqBfkxee
	fbkA6FhghTbFsNEZTkhtRUh3T5Uh57FBDA2Sv9t3YuPj+YRUaLr/ijByoN1dsgcaYddWNR
	I9rMagKxMFVNebvZ81BChuEh1fMSrZzsXtxAHyO9kd/q2MvdI/MsxCI7DlhWHw==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Koichiro Den <den@valinux.co.jp>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to handle dw_pcie_ep_init() failures
Date: Fri, 21 Aug 2026 14:27:50 +0200
Message-ID: <20260821122808.238248-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
References: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i37hwesgx5x1e6gd8se59j8obmxtiytj
X-MBO-RS-ID: ec2a1b888ffddc70dac

Implement .post_deinit() callback in R-Car Gen4 struct dw_pcie_ep_ops {}
which asserts reset and stops the clock. This undoes start of clock and
deassert of reset performed in .pre_init() in case dw_pcie_ep_init() fails
after successful call of .pre_init() callback.

The use of .post_deinit() callback correctly handles the clock and reset
stop, unlike the call of rcar_gen4_pcie_ep_deinit() in dw_pcie_ep_init()
which could not discern at which point the dw_pcie_ep_init() failed and
might have attempted to stop clock and assert reset twice, remove it.

Since dw_pcie_ep_deinit() also invokes the .post_deinit() callback, drop
calls to rcar_gen4_pcie_ep_deinit() in both rcar_gen4_add_dw_pcie_ep()
dw_pcie_ep_init_registers() fail path and rcar_gen4_remove_dw_pcie_ep()
to avoid duplicate stop of clock and assert of reset, and drop no longer
used rcar_gen4_pcie_ep_deinit() entirely.

Initialize PCIEDMAINTSTSEN early in rcar_gen4_pcie_ep_pre_init() to 0,
to make sure that edma_int bits will never be left set in case of
failure of dw_pcie_ep_init(), and will only be set in case
dw_pcie_ep_init() succeeds.

Reviewed-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: This is reworked version of
    PCI: dwc: rcar-gen4: Fix potential unclocked access in rcar_gen4_pcie_ep_deinit()
V3: - Update commit message slightly
    - Add RB/TB from Den-san
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fbe465a29068f..157e33c4089b9 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -487,6 +487,8 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
+	writel(0, rcar->base + PCIEDMAINTSTSEN);
+
 	ret = rcar_gen4_pcie_common_init(rcar);
 	if (ret)
 		return ret;
@@ -496,8 +498,11 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 	return 0;
 }
 
-static void rcar_gen4_pcie_ep_deinit(struct rcar_gen4_pcie *rcar)
+static void rcar_gen4_pcie_ep_post_deinit(struct dw_pcie_ep *ep)
 {
+	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
 	writel(0, rcar->base + PCIEDMAINTSTSEN);
 	rcar_gen4_pcie_common_deinit(rcar);
 }
@@ -552,6 +557,7 @@ static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.pre_init = rcar_gen4_pcie_ep_pre_init,
+	.post_deinit = rcar_gen4_pcie_ep_post_deinit,
 	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
 	.get_features = rcar_gen4_pcie_ep_get_features,
 	.get_dbi_offset = rcar_gen4_pcie_ep_get_dbi_offset,
@@ -570,16 +576,13 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 	ep->ops = &pcie_ep_ops;
 
 	ret = dw_pcie_ep_init(ep);
-	if (ret) {
-		rcar_gen4_pcie_ep_deinit(rcar);
+	if (ret)
 		return ret;
-	}
 
 	ret = dw_pcie_ep_init_registers(ep);
 	if (ret) {
 		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
 		dw_pcie_ep_deinit(ep);
-		rcar_gen4_pcie_ep_deinit(rcar);
 	}
 
 	pci_epc_init_notify(ep->epc);
@@ -590,7 +593,6 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 {
 	dw_pcie_ep_deinit(&rcar->dw.ep);
-	rcar_gen4_pcie_ep_deinit(rcar);
 }
 
 /* Common */
-- 
2.53.0

