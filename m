Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EDF9C0;
	Sat,  3 Oct 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013038; cv=none; b=MaeP7APN/F599pYLrUz1a4yO7T7FoNU0AGRm+HDHWT7pGyd3EceSa7gGp6mawQzbsLfK2bIZxLfZe5NGQGVuVZtQaJM8SG+osTjgnpvxXzoznqoyaXVaIgXGt2CVcxa+s5crmtILf1Vxh42RXxk9x0eWl9SKIkUqdQ/HlSxvVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013038; c=relaxed/simple;
	bh=0aBx0MtCQ2r2njawUI5SWobelUwGBwAUqtsWuUeTyd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHiZEMDMJldDDPWIvETluqXqZKRfEXmrNVFyQ64aDwlefrDYHeOjfvpc7Zhq++qao9KRyzGugE4qVjOoyJZoZv9EWAD1jlicDw0DVvVxz97Vs4OMwYFAw5OliqwqiXGXTAia9a5+C89mpOuFtceV2RxymWqV5TWhH2Q48yctY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EHjIxQGG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EHjIxQGG"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hxctB1Wfnz8tR4;
	Sat, 03 Oct 2026 09:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791013026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lo2dFl+s17ZDMckTuQHQmE9dkJgXHJDAONhYrPQIrSs=;
	b=EHjIxQGGpHHZo5trnTcBmKAsOSZFPMFCvthw7UZI1aDvTQgoRr63T6cfnPHHJA0nyIRtr+
	DeIHtHclUyngRlaKIqP+Xqx3wMKaEbKz6quSmQfsv7P/YohDVODF/lMhE0ZxBWvgoyDnFx
	YHDyLEWG4h8VM4jGbYToRf18f98j9VBd0fpiDFo2QJ4yuXedWIWxorMdhOG4yqWLCTiGqv
	L+DWigc5oni1XOTA6GQusGUbNVzug5+HsTBpJIL3s4G3+sxYmJIhPvwfWob0V4uOgLBKdt
	y13VdPh6iJibei0UII1EsU8jGRz4xg1auG7EXPvCt1ZGRVPSasqvdbsWP5sfrA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-host: Validate IO/MEM resource count in DT ranges property
Date: Sat,  3 Oct 2026 09:35:59 +0200
Message-ID: <20261003073701.354551-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: edf8ob3kfe3d3tafos6okh6g1z7sy6px
X-MBO-RS-ID: 1623a08b7c93c571169

The R-Car Gen3 PCIEC controller supports up to 4 memory area mappings.
Count the IO and MEM ranges described in DT 'ranges' property of the
controller DT node, and in case there are more than 4, refuse to probe
the controller driver, because such DT does not describe valid hardware
configuration. Do the IO and MEM counting early to avoid controller
configuration rollback in case of failure.

Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar-host.c | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cd9171eebc289..4bcc8c3051ac4 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -341,6 +341,32 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
 }
 
+static int rcar_pcie_validate_resource_count(struct rcar_pcie_host *host)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	struct rcar_pcie *pcie = &host->pcie;
+	struct resource_entry *win;
+	int i = 0;
+
+	resource_list_for_each_entry(win, &bridge->windows) {
+		struct resource *res = win->res;
+		unsigned long type = resource_type(res);
+
+		if (!res->flags)
+			continue;
+
+		if (type == IORESOURCE_IO || type == IORESOURCE_MEM)
+			i++;
+
+		if (i > RCAR_PCI_MAX_RESOURCES)
+			return dev_err_probe(pcie->dev, -ENOSPC,
+					     "Too many IO/MEM entries in DT 'ranges' property, limit is %d\n",
+					     RCAR_PCI_MAX_RESOURCES);
+	}
+
+	return 0;
+}
+
 static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
@@ -947,6 +973,11 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	host = pci_host_bridge_priv(bridge);
 	pcie = &host->pcie;
 	pcie->dev = dev;
+
+	err = rcar_pcie_validate_resource_count(host);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, host);
 
 	for (i = 0; i < ARRAY_SIZE(rcar_pcie_supplies); i++) {
-- 
2.53.0

