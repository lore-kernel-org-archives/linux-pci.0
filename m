Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E53D75AB;
	Tue,  3 Mar 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565016; cv=none; b=tiYJSPVjGAV4sv2YebmA15LQI3xjy1DmZ3DToZ8XMhd24h+2yMaAO31V05kNFF0qVeYidIdO7F3xge5C/FkNZyHvH4IUQvx/v8DOmtZ5UYLpilYZ08YZDCMfCiJ8eWhE1X4rCxBls2/BUxi9VgBcVKkwso0/Pxx797/hg+QwFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565016; c=relaxed/simple;
	bh=o0Z85w/VI1CVGaEoDBkl1+BDW5F3aK86mCE2F+k5prQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1B+NpxqxFwcwqSKm+521lJbRuAwjyE2bLb49YxGibLnqEHQcleGkKz8QYxdfG687hoCk09qEQ7gDjxwdnyMaVDTtY++iX/MNe7qeQpwa691nMzLj96p+6HQxg8yFOpJEqcbGecAU9rDwThJtT3sdSxAq44O1KzZpfpfx0pbMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=Oy4kMsIK; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="Oy4kMsIK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B8F120D516;
	Tue,  3 Mar 2026 20:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1772565011; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=YeYcHOU6O1PcxMMN13wZpxAP+6Z+ixxDNPaLXhkt61M=;
	b=Oy4kMsIKUpN1ifXgxMapAw9eWZUzib2dteeWem3sYhWyzFArKtUyf3n1hZsmH9IaTWEhV+
	qPdtEvGKXnQOI+lDMeRoep+jsXV9Ya/XcNOY1r/bcjAbzjLiMQ8/KlJE7CmOVdDNVUOT8h
	cDB0BJvRwLk3aTYOlu4wJaAc1s2L8z8qa0IzCemII+0ANfi56E8OqGT6ddYuocq6vNGHGU
	uInyDrfuf93mq1wycS0x2/dHLdx751rIU1qQ03Yn08tWvIFAqIS5MP66vvn1tIs1QfPjX4
	/1Yl4egPmk/AwaZJOJXUrulS8+zzWDOfb+m7Id0lV8qZzUHSHIHhIFyE26hc/g==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-mips@vger.kernel.org
Cc: naseefkm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjd@cjdns.fr,
	tsbogend@alpha.franken.de,
	ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nbd@nbd.name,
	ansuelsmth@gmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8] mips: econet: Add clk/reset and PCIe support
Date: Tue,  3 Mar 2026 19:09:40 +0000
Message-Id: <20260303190948.694783-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add clock/reset and PCIe support to EcoNet EN751221 and related SoCs.
This builds on the Airoha EN7523 clock driver and the Mediatek PCIe driver.

Patch 6 is upstreaming of Ahmed Naseef's work on EcoNet PCIe, which was
developed to support the EN7528, but which works equally on the EN751221.

There is also a workaround in patch 7 to gracefully handle PCI hardware
which does not advertize a bridge window and instead always reads zero.

Caleb James DeLisle (8):
  dt-bindings: clock, reset: Add econet EN751221 bindings
  clk: airoha: Add econet EN751221 clock/reset support to en7523-scu
  dt-bindings: phy: Document PCIe PHY in EcoNet EN751221 and EN7528
  phy: econet: Add PCIe PHY driver for EcoNet EN751221 and EN7528 SoCs.
  dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
  PCI: mediatek: Add support for EcoNet EN7528 SoC
  PCI: Skip bridge window reads when window is not supported
  mips: dts: Add PCIe to EcoNet EN751221

 .../bindings/clock/airoha,en7523-scu.yaml     |  19 +-
 .../mips/econet,en751221-chip-scu.yaml        |  41 +++
 .../bindings/pci/mediatek-pcie.yaml           |   1 +
 .../phy/econet,en751221-pcie-phy.yaml         |  57 +++++
 MAINTAINERS                                   |  10 +
 arch/mips/boot/dts/econet/en751221.dtsi       | 114 +++++++++
 .../econet/en751221_smartfiber_xp8421-b.dts   |  21 ++
 arch/mips/econet/Kconfig                      |   2 +
 drivers/clk/Kconfig                           |   6 +-
 drivers/clk/clk-en7523.c                      | 236 +++++++++++++++++-
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-mediatek.c        | 107 ++++++++
 drivers/pci/probe.c                           |   6 +
 drivers/phy/Kconfig                           |  12 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-econet-pcie.c                 | 180 +++++++++++++
 .../dt-bindings/clock/econet,en751221-scu.h   |  15 ++
 .../dt-bindings/reset/econet,en751221-scu.h   |  49 ++++
 18 files changed, 869 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/econet,en751221-chip-scu.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/econet,en751221-pcie-phy.yaml
 create mode 100644 drivers/phy/phy-econet-pcie.c
 create mode 100644 include/dt-bindings/clock/econet,en751221-scu.h
 create mode 100644 include/dt-bindings/reset/econet,en751221-scu.h


base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
-- 
2.39.5

