Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE440D59E;
	Thu, 18 Jun 2026 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820293; cv=none; b=Q2lo+jvHKk96uoqnBPciooYBS89+9ATOuEYEpIetRyEvF/fC1y661MUsN9YwAwWsN6fWKiPIyfEsamBwtPjMn0gyWSJyARjTTkNk3kQTwTIfdErxc3FL1CZ/d2deqy6XsL9DkmPAmj1U3DKQbt0t3jgGvgdQYZBfF0/Cg8GH7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820293; c=relaxed/simple;
	bh=j6eIsnWMxOzGO0tccrZIGUA03qrwc++Zhwojz1ECX0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfNH2OZXoh15iWUeBxyLo7q5Wrn6NTpENPeJJPJA7t/0NRn5Pr44X/HGEvNtEkQYF86dKqeiae0SjrTX9ELeqhkcyW4UR2qIiwlIm2RYmC4xnDfECLeh0YKGLYeSCEJog6J5GYgRtMI34A3KcGUyC85vGfPyXYKgJpJMLvgo9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mr1aKYUv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EwurEXdb; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mr1aKYUv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EwurEXdb"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ghFBd5FCfz9vH6;
	Fri, 19 Jun 2026 00:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781820281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n9NnMxXotBQdbl6yQdvpSoMthYRel61mgliw+M37luM=;
	b=mr1aKYUvZ4AXIUv3Pj4XI5R5X+g6aQdlgzEFeBkKO15nD0v6INdJdBopB/V0HcRySkpSBI
	N7Cqva+Lhzb4ggYw+MEy/qVNFcqzN7qz3tixK4V3UH+DN9N+Mp+Ur9e2paFuNXhaa1Pe57
	4ugkimo+icpiYwAmQqFBwomeOkBWrq3AMlWN9TYkW5cxwisZobcgKbxkYAkmuigCIeyeki
	+KJmiyClrORI5PCwexlusb3gnN1/bk/IvWE8PXLBCOSaXAFhrhYWc59xBqWBh6WdvE29la
	dlceuxUAsg86x0kuuSgGPVdIAAc9OO5aUuipw8ldKwhadRLuuNSryoZ5It4oaw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EwurEXdb;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781820279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n9NnMxXotBQdbl6yQdvpSoMthYRel61mgliw+M37luM=;
	b=EwurEXdbrXxFe1yfgcECSgqilbKaMuVxYgvVkMzIFCdiBVgkvk2vg7a2ZEc7U41/04WWMB
	CBq8BUDx88qHISVdnpEdXi5hpC5v0ISe61bNsJdjSTz3UtUUC0Il+aSjSrUpX7bNCeCDW2
	L0z3hg/a0aLGePYb1UN7KGG+vTjrmv0kTMGx51Qnf+MFYwSYFvc5pOZGGWdZyZH+jcA51n
	bxxc3mb4qUQkAb4t2sZjX4Px2OOkz/6jGSnx8SgkHus69ZDvib1lirI/WgieJcM7Hwn4fc
	CHqPk+TAQsAVkFnejNGISEx8hPO+5wxGz6QatlwpC9OHYDY6MZnAU7mwhbJEgw==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: rcar-gen4: irqchip/gic-v3: Handle GIC ITS
Date: Fri, 19 Jun 2026 00:01:58 +0200
Message-ID: <20260618220427.14325-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b95e338b66e31c96c62
X-MBO-RS-META: qbmeks8guinjfrjhgnn5mjdmcow15uuu
X-Rspamd-Queue-Id: 4ghFBd5FCfz9vH6

Configure all R-Car Gen4 PCIe controller MSI registers fully, both in
case MSI are enabled and disabled.

Patch GIC ITS driver and add quirks for R-Car Gen4 GIC ITS, which is
configured to 32-bit address width for AXI or APB interface.

Switch R-Car V4H to use GIC ITS in its DT and describe the GIC ITS
implementation cacheable and shareable limitations.

Marek Vasut (4):
  PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
  irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
  arm64: dts: renesas: r8a779g0: Add GICv3 ITS and update PCIe nodes

 Documentation/arch/arm64/silicon-errata.rst |   1 +
 arch/arm64/Kconfig                          |   9 ++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi   |  31 +++--
 drivers/irqchip/irq-gic-v3-its.c            |  24 ++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 118 +++++++++++++++++++-
 5 files changed, 162 insertions(+), 21 deletions(-)

---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org

-- 
2.53.0

