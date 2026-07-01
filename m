Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F533A71AD;
	Wed,  1 Jul 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938396; cv=none; b=g0dQrUCRnns8jUTedrWQJnYYqEngae1O4JA/eMXli6Em9ZGAldmy8jnZkpIu9r1NyjQmZmCNBYtD+MHkWxDvLZc+PWSOPMjjUg1rW3JVmJnVRPIQuxl7u4Rf5Dnqh0kdLbRcVgjwePsR6/TQEUxvyo96dWnbK+YhZON4D757GUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938396; c=relaxed/simple;
	bh=45ktKS63svINguA/03znAG+kUb0GrmqNXv1eYU/+Fto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m62fHegu6bV5VFx/iFkmPAe6GVVTqpjhHqRzn2hvfusM9b84jScFzZGvo96FS84Mm9cMp3QovE0n2UEdAJNsxikft/Hc2JimujQaiAn8OToRg4HmLzs14sAPcdgNJYe9xOuWChpahMzHLChAkGC0y3JE75Qh+HGlMZWwiTxGCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xExFM1qy; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jOfnk6I8; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xExFM1qy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jOfnk6I8"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4grBhf05h0z9v3b;
	Wed,  1 Jul 2026 22:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782938386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkxAlTQFGbaiuEekACY4kTmb7QT3eq8R9Ya17Km0roM=;
	b=xExFM1qyH1faobKmzBOkzKHHYG0vK2RhwDumRw2uDRJf3HzJQbSso9yCfk3zJd/5MhdiWU
	oUQrlYAdGic7O8BNN6XEL5oYfejW7JDmoe3gyFZ7Mc0UEoqtULy1sLZC8c8E3j42Jubilf
	K93v6IhJOj6Bf2th6nlRktBnv2AOhRKfB3OCUtK2sPsoK7yEDJSowuFw5IJXftLTe1Kipr
	8DsIDxWvzCYUl5BlZQn9Tqlkk+FPNuNF/DVVt216wQ3R1JXZVu2CbeuBCCA7r1M4Rsh0B+
	gitTcEXCCrziwHwgUFF6n1Q8zu5X3zI+PLtOf+JqbslK2ofBj16rKZ3nz0zNvg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jOfnk6I8;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782938384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkxAlTQFGbaiuEekACY4kTmb7QT3eq8R9Ya17Km0roM=;
	b=jOfnk6I898Lgh1qcpjzFHAMB9Cqhlmfh/Ok1puVoyftl4dAB3IfpmUPEZ/v3NGPjyCYLyo
	C+32SYu9ziYYtAkLH/vSmqaT9ci9byJs8ua6ifHJ2HUqVgStR14O+JRsV8gtxGaoYr8eJ7
	Y499fjgo5PFw0i92B1dx0MAf+PgC8l/MikHx5cdWZ2UYkjhllVqjfNmoi+wrbwh1x994zy
	InEgMGQqv9q59TrZhmYMfYhH1pISkC7z2iIqETUKdE/V5Z83CE/RkTmMWb1Syt+xSxKwUr
	SQbKvq9CFiCbWEfHwF13981rqC2DL9VoVZOqDC9EoXnsA0dVgyjZYRCLKQOVgw==
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
Subject: [PATCH v3 0/5] PCI: rcar-gen4: irqchip/gic-v3: Handle GIC ITS
Date: Wed,  1 Jul 2026 22:37:43 +0200
Message-ID: <20260701203918.63189-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8qus3hraqq8rxg6as1fu3rbgzyipbcr5
X-MBO-RS-ID: 35fafbef4d7d3e030fb
X-Rspamd-Queue-Id: 4grBhf05h0z9v3b

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

