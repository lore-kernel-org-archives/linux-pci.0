Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588205;
	b=SvNu5UPMAT5uT3nzQ+4ITbevAdQ9KnKTeOWTrnRnzQ0dag0/DyoX6mnh8u2z/hbNnSu5
	 h+CQ3QXKELaQe1cjb9VLjVSevk2AdJHRpxZGhqkbN4B++6EI1nNPPLCOTnSQiCGiYMeui
	 z2GMCUkqbQUKnyPrPsBKCf1e11QzXYayUZgCnlxOtlEfsUFETedfGZSmA2JGdj9bTBWUq
	 aq3kv+osLsELhGkQn8hPoBSZY64JFVLWgGTPk/UELnQV6SS6KK3rvR7imOUmbUbw5wvX9
	 UANC8pxlpsX2l9Gva1z1/0PMkJHIxFzETKiaKO8yDhSdHTBZGTkChg6z8b30I34/aIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588205;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SXTRDOXzAHUSWSl+Ai9JHB2q0oBka0VriYkwNpTKYKQ=;
	b=TylGlSGCd6U6H984BZjr7OP7fZCeWUvfrwJkeMMKCNLYk/7iAKGfa7nyGeKly4hiecZX
	 R28oQE89W43sxOVBMJsm1VJV3U/jr7Hx69B3Oo+dahsvs9tWNggg8e1yD99pfPPU4cIER
	 XHhbbAzxKdKLZZVQaTqNB+Zr5CLd4z5pM9w1M2kDSqLro6Hl4SGlWJic7w/0qOyi1Es/+
	 SqOOdIkiI8XQW5AtcJFGNfOkUWpkPv8DPtf0uyxyD86B3vXEn1RbcatSUYctqCl0XNJvy
	 BKCu/V14jS0aHTgzk4LrkTShoYXtLHFPXBUh2mgoD/kv3D88IzF2eR28zIazCAzX+gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=CdXKfPYY;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EDC606A32A;
	Wed, 25 Nov 2026 06:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9EDC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=CdXKfPYY
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 060184C89A;
	Wed, 25 Nov 2026 17:29:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795588189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SXTRDOXzAHUSWSl+Ai9JHB2q0oBka0VriYkwNpTKYKQ=;
	b=CdXKfPYY7vWtoBevximD0MhqDEw04bj+8tHBAbkGUu4t6QVOiQ+gXd/fqzJin9OnfczbAa
	MV9IDkhaDTNLsAsIz9cqrjJZu3KOMwU44vghIwhWucmg8rNH+8lyYUpRs/A0/AIKmKi7Eo
	Icr5+kbPULm2pgPX4/rAowLWwzqiSYB/M/o/1B+bj+t/WmUarxEE2Q7ShHvaZPci/vZu6K
	nO/bRgOHqkLCYiW3aKQBu1BVa/t8Ogw9L1COCQxkS606S2mk63X3k56Tptrn5Kuiikqjw0
	0seIhxUTEXW4GDHjWJ2SJKCFBgEoGqGFmm2s+eSXdKt8jsv5FcNeoz8+mJxhDw==
X-GPT-Reason: This is a legitimate technical communication. The
	email is classified as personal/professional correspondence because
	the sender (alastair@d-silva.org) is a known entity matching the
	recipient's domain context, and the content is a standard Linux
	kernel patch submission regarding Allwinner A733 hardware support.
	The presence of specific technical diffs, links to lore.kernel.org,
	and the absence of any marketing, urgency, or phishing tactics confirms
	its legitimacy as a developer's contribution.
From: Alastair D'Silva <alastair@d-silva.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/5] Add Allwinner A733 (sun60i) PCIe and Combo PHY support
Date: Wed, 25 Nov 2026 17:29:43 +1100
Message-ID: <20261125062948.1234677-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Devicetree bindings, drivers, and SoC Devicetree nodes for the
Allwinner A733 (sun60i) Cadence Combo PHY 1 and DesignWare PCIe Root
Complex controller.

Tested on Orange Pi 4 Pro with a Micron NVMe SSD (1344:5410) on both
cold boot (no bootloader PCIe init) and warm boot (after U-Boot pci
enum):
- PCIe Gen3 x1 (8.0 GT/s) link up via mainline dw_pcie_setup_rc()
- 8 MSI queues and Root Port PME/AER on legacy INTx
- Root filesystem mounted and booted from /dev/nvme0n1p1

Patch 5 depends on:
- "[PATCH v4 0/3] arm64: dts: allwinner: add A733/Cubie A7S support"
  https://lore.kernel.org/all/cover.1795034153.git.enzo.adriano.code@gmail.com/
- "[PATCH v7 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU"
  https://lore.kernel.org/all/20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech/

Alastair D'Silva (5):
  dt-bindings: phy: allwinner,sun60i-a733-combophy: Add binding
  phy: allwinner: Add Allwinner A733 Cadence Combo PHY driver
  dt-bindings: PCI: allwinner,sun60i-a733-pcie: Add binding
  PCI: sunxi: Add Allwinner A733 DesignWare PCIe host controller driver
  arm64: dts: allwinner: sun60i-a733: Add PCIe and Combo PHY nodes

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../pci/allwinner,sun60i-a733-pcie.yaml       | 187 +++++++
 .../phy/allwinner,sun60i-a733-combophy.yaml   |  84 +++
 MAINTAINERS                                   |  16 +
 .../arm64/boot/dts/allwinner/sun60i-a733.dtsi |  76 +++
 drivers/pci/controller/dwc/Kconfig            |  15 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-sunxi.c       | 505 ++++++++++++++++++
 drivers/phy/allwinner/Kconfig                 |  13 +
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun60i-combophy.c   | 372 +++++++++++++
 11 files changed, 1271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/allwinner,sun60i-a733-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun60i-a733-combophy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sunxi.c
 create mode 100644 drivers/phy/allwinner/phy-sun60i-combophy.c

-- 
2.53.0

