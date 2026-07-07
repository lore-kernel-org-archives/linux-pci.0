Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D53EB0FF;
	Tue,  7 Jul 2026 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456685; cv=none; b=B222hasMOkuP5TsAsEhVbU8AiZ/ywmAu0xv7Qyu0dJrQEcIyn8UCDv5RYeEb/1bxJekbxPrZzRazg8LN31cP/RoW4LIh4QkN8/3tKt7Dwtcl1OYiGcXyQlGnlg3F5Q4ftD6RISI2hYfxdtF4KUwgMnQpv1SnVjNP6jHFig4HejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456685; c=relaxed/simple;
	bh=45ktKS63svINguA/03znAG+kUb0GrmqNXv1eYU/+Fto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TW7WqYydB1v4Fgm07UO5gb4jlPPZpx/YbXgmVzWjZMqTOtNvZKorvPXxrK/BfSsAU7inrA9PnHIRR04JP53CpqQTwjNuLR3KbeKrlsRrROwSrqWqExq62T6vY5kvu39oBNm6Npfma40YFfzmlreBHl8Hicv2Rgh3BxRVASz/Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qG71dQnD; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=W8BbqTMc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qG71dQnD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W8BbqTMc"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gvtMq4YlWzKnYq;
	Tue, 07 Jul 2026 22:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783456679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkxAlTQFGbaiuEekACY4kTmb7QT3eq8R9Ya17Km0roM=;
	b=qG71dQnDHH5TbSzfaJY2ona/Zb/tcdBlDpng/N0QlID4fOXL5xmMnK5F9f2JuF4e5oP5pe
	TPcfE75Dvf2+4gjiZp4hPYZAWRQOjh88H+uho6Yy4RWLAQAz1VcCbiz2M72Fh3ulQJnyDX
	1Km6wm68zp6THQZUjy2gSHFy1ixoUjrerDGF9lGRTKhslmXRToya2dWnY0zuCfd9Z7uUrN
	1ytkNDWC9YS5M2c6BpfvkGq22zFE+54bu1bVYdA7iQlMC4Am4x7J/GRBavyV3fFvGWmsoH
	NSVsnRKca3e4IaOlLcV42xwz8w0deYIliR2HQhJ2XDCKsp679HdB0JDJPM/RDw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=W8BbqTMc;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783456677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkxAlTQFGbaiuEekACY4kTmb7QT3eq8R9Ya17Km0roM=;
	b=W8BbqTMcowFTauoj2C93jHgxjUCLS+vheaflWcub1dTsog1pIptOUUE1eQNpWlQQ9wa9zv
	Cvsb0wGqtDb8Lz/IOtZ7WvOYoW2tQimEw2SKZIu2xK0D2yY4wg9RAqpOzUO8Z4PTvjMSnu
	bhuubDLXN5RnvxwtFHwp9WF0WG427YJNBX3GEM//Q8/h8T9/Oba954959U1+pIlwMNkEFx
	HC4xTe2+XQkbC2cNH/dnFqwWsArN3GZYK4KgW6++GDbGkcUaX75oRUcXhwoZumTOpy8sPW
	GgzPrVzL90wf88N6SXzYzfkR7cm66ss3blUM6PhP6cs7jlgvgHNvzP6m5T8U0Q==
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
Subject: [PATCH v4 0/5] PCI: rcar-gen4: irqchip/gic-v3: Handle GIC ITS
Date: Tue,  7 Jul 2026 22:35:38 +0200
Message-ID: <20260707203743.88299-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: u96g9godcfeirhu3zryyw76zncezkakh
X-MBO-RS-ID: 68c9bf0ca49950fc27a
X-Rspamd-Queue-Id: 4gvtMq4YlWzKnYq

Configure all R-Car Gen4 PCIe controller MSI registers fully, both in
case MSI are enabled and disabled.

Patch GIC ITS driver and add quirks for R-Car Gen4 GIC ITS, which is
configured to 32-bit address width for AXI or APB interface.

Switch R-Car V4H to use GIC ITS in its DT and describe the GIC ITS
implementation cacheable and shareable limitations.

Marek Vasut (5):
  PCI: dwc: Determine whether iMSI is used before calling .init
  PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
  irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
  arm64: dts: renesas: r8a779g0: Add GICv3 ITS and update PCIe nodes

 Documentation/arch/arm64/silicon-errata.rst   |   1 +
 arch/arm64/Kconfig                            |   9 ++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  31 +++--
 drivers/irqchip/irq-gic-v3-its.c              |  24 ++--
 .../pci/controller/dwc/pcie-designware-host.c |  10 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 118 +++++++++++++++++-
 6 files changed, 168 insertions(+), 25 deletions(-)

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

