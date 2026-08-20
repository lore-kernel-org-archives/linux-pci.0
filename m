Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A421CC59;
	Thu, 20 Aug 2026 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787198405; cv=none; b=EMTGvyeg62+v+1aTgcM2cT8/HG8ASA+MWStD7R7HHcmyrjgz1v963ihaqiy2jSGm/mpWD/PgewzCJH8SLleaVuOMJV+iCkRlofTaUcJemfS/XnC1F4dPWM14T8OnRMwFpcNva2SwasYsPW7rngEWRiqrWh6R11cIujYAtUNtW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787198405; c=relaxed/simple;
	bh=T1h2LR03mJJuGWEcZ7InRFRjvXuUbuH9+qmdJlZ+nMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gou1cjMdIE8b2oZWD0M1py6qNHSSZ7njfbsumudAOUCcQn8oqT3M1DZg3Jc6hYsLwF+NVeDQj0O7jN0XrkjnXZOI4f3Fw2KgOpp/naLEQgNleOnwy/6mqkC9FQ84MIWW/VwyZpYJeUyFpOIWEeUPTP1pMoVJ433lsPC9wmDuRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vqAyFEEf; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LkZuC51D; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vqAyFEEf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LkZuC51D"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hQV7t69LSzMlH8;
	Thu, 20 Aug 2026 05:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787198394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Te1BmkD6rI9pUR+Dh3BzlPWDfnwA/DtFOHMed4y4Ok=;
	b=vqAyFEEf0LuzpQnZGWhNn3PVs7oSwoEcGGVT8PieF2GlmXiIN2zmA+WoeVEi4NEK7hKV3t
	CpvpIrnhvyJJcGrt2O2YfU0PCLWH5YCrauXc0KjTVsAVaJ6cyhhVwF1h+YFIIrpjc+x1Y5
	eCo6DAmq1vIMS4sLIHTvjn0pncTTrxLz5zuWke9jyrUHlrNMlD6JqzQ44OAV2jC1Y59R94
	1GVhgi6m3xzWYkAOWXePEy+QEiVsWhxC3bt5C8/z7E6ZEWzINxDBfKIO+/gqKg5WAPRs5S
	WPHy0WbMZIQk67ida2ZdhwZ77oeD7kD7w160aunoiv1OQ8tIWTcQksnRAN6XRA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LkZuC51D;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787198393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Te1BmkD6rI9pUR+Dh3BzlPWDfnwA/DtFOHMed4y4Ok=;
	b=LkZuC51DcL8pmSCulSk2ybvbXYwXtzsPcFFONQme9n0oCSioXmR8n8nMtp5yNTD+36Vu5e
	ucCD/heb7SmAcF3UdwRCd5Eu74UYm6KvYIajgWHKPiagZlj4i+fM/tEI5PV8MbhllX0kK5
	bD6vUwKGNZ16p2t0l/pE9xl1TbrqYNdtfeKXYwjMbaDl9MTwcj4OAljb5UBnd1lNUqCcea
	AuAvq8eDE9JYeVTTM/NJbIlMfcP5o6OTf3rxNmfng5/BeBkpp5j6FLQKMrVuy8TmeoEnWv
	Piix6RpCKSFm4FK74IlRZqzKIG3yfmQX4f9C7+UhnGo0f2GBhIkeGMWWWXIf8A==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to handle dw_pcie_ep_init() failures
Date: Thu, 20 Aug 2026 05:57:56 +0200
Message-ID: <20260820035944.163472-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
References: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0cc207f93fa27a49307
X-MBO-RS-META: 5ksmjtz1qne5j48feyp3795a5eqb3bzd
X-Rspamd-Queue-Id: 4hQV7t69LSzMlH8

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
to make sure that edma_int bits will never be set in case of failure
of dw_pcie_ep_init(), and will only be set in case dw_pcie_ep_init()
succeeds.

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

