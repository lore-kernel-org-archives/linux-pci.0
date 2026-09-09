Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603338B7D2;
	Wed,  9 Sep 2026 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976775; cv=none; b=QTRGYIvAoqCogixgDoP3JkzKaaUK9A1kxexw8r9IQyIS8w1NxyoFxzNaO3syoKdI2ugHlaTvxMdNbv8/C/m8pBicFaC5f9uURKwgoEnC1dXBAh80ctDUq4XIAMfio/7gNth8XUMFusAFA0rhGeqHWXjYU68y8Z0tEBfFh7doztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976775; c=relaxed/simple;
	bh=XTIMQpXomokQSAIIs7mFutwU8DsOr98NPWE7+vTdTvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3rdeeBDP8tCRs7iTRY72im23F6gu2+Bd9sQ3Nrn9VyBWBdxOqeKml8oamQk8ObWSvKnZmMsrEDxWWaI1ncDgIc3LcfPyDjyPyLemAATmDO6W9PiBpbvKsieS+bbe6YkpYQ8NABlM7HWf5W6rPIZiybhlKo4BsOOlmL8bFJfpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rK3zkgqX; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NLgzHMOE; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rK3zkgqX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NLgzHMOE"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hg7qP42yrzMlNW;
	Wed, 09 Sep 2026 19:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788976769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zvZ+RLpuQp0o+qwBeKx2vcHy6+eRYrcr7uYrRT9pD6Y=;
	b=rK3zkgqXllSJUp2FxHGWLF6yxHGrXqT9haUOZ4DYKx4aD33YCI9JBmLIyCm77X1tk9TSC5
	L1tXvMee8PZgffYlepKVj34XNRsIGheckhHGFjRdpFCO5WgLW06gTYLTJDVkCVRiv6lWZ2
	4yosVS+X/giwj39itTXjNAwjVFtj6zu74WRKmiHIwyuJKzWhxDhpQFN+8UlPxuGL5pLUIC
	NEwZ8jAuCTJmcEJP+OgZ5on0RZgl+Vr83PlzB0TgcAcx46n1cp/h84MZ6HKbWTiekP0wjz
	5+7zfQQShsj8x/RpEODnNnuvSwkBQvvhUrsmjZtTKQxMGtTZNexjguAfMgmZCw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NLgzHMOE;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788976768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zvZ+RLpuQp0o+qwBeKx2vcHy6+eRYrcr7uYrRT9pD6Y=;
	b=NLgzHMOEaNNhAsHZ8LUXNPm/lhkVSSl8toL6lOxfa6cud8ne590X3uzIWX/IpAJR45BxTF
	shMj+9E3g92xT5lmeVfFvt+YBMLICIRVtsuKmgB+GvRJxoyRn+jkvW3RSTiyhauerYWrqD
	5aYPLpu8OvqlYeg862orPEdPWZE0J51l4c8wjhDA0T0D5f1GgPsRxwPKjHgNREfgQaM/AL
	/NvJzOkoso49K6Hr8JjuJ06fyaHsBCxXTkfeEG88+SWMX7OM8P8bGfat/RypnQzVKQNKqg
	IzeykkMZAY5CTWdtEDO6JzVJrAspJTkYp81vw4pbeCvbmGn4OH8NwajCzPRBNA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [RFC][PATCH] arm64: dts: renesas: r8a779f0: Add GICv3 ITS and update PCIe nodes
Date: Wed,  9 Sep 2026 19:58:46 +0200
Message-ID: <20260909175922.161658-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b5cbc2730be12df5f35
X-MBO-RS-META: e97eicrzbd4yjyht5mzue8seow6mfuym
X-Rspamd-Queue-Id: 4hg7qP42yrzMlNW

This SoC implements GIC600 with GICv3 ITS and PCIe host mode on this
SoC can use it. Add GIC ITS node into GIC node, update interrupt-map
and add msi-map into PCIe controller node.

The GIC ITS does have master interface to issue transactions to RAM.
The interface does support cacheable transactions, however, it does
not support shareable attribute, because the AXI port signals are tied
to inactive in this implementation. Therefore, add "dma-noncoherent"
DT property into the GIC ITS subnode.

The GIC redistributor does not have cacheable/shareable, therefore
add "dma-noncoherent" DT property into the GIC node.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
NOTE: I am sending this as an RFC. Den-san, would you please test
      whether this works correctly together with your Endpoint setup?
      Especially whether the Host-side MSI change does not break it?
      Thank you for your help!
---
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 34 +++++++++++++++++------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 878b1d53fa371..e17e7732a8d3c 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -793,6 +793,8 @@ pciec0: pcie@e65d0000 {
 			resets = <&cpg 624>, <&cpg 1121>;
 			reset-names = "pwr", "core";
 			max-link-speed = <4>;
+			msi-parent = <&its 0>;
+			msi-map = <0x0 &its 0x0 0x10000>;
 			num-lanes = <2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -803,10 +805,10 @@ pciec0: pcie@e65d0000 {
 			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
 			snps,enable-cdm-check;
 			status = "disabled";
 		};
@@ -830,6 +832,8 @@ pciec1: pcie@e65d8000 {
 			resets = <&cpg 625>, <&cpg 1122>;
 			reset-names = "pwr", "core";
 			max-link-speed = <4>;
+			msi-parent = <&its 0>;
+			msi-map = <0x0 &its 0x0 0x10000>;
 			num-lanes = <2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -840,10 +844,10 @@ pciec1: pcie@e65d8000 {
 			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 2 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 3 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 4 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
 			snps,enable-cdm-check;
 			status = "disabled";
 		};
@@ -1290,11 +1294,23 @@ ipmmu_mm: iommu@eefc0000 {
 		gic: interrupt-controller@f1000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-			#address-cells = <0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			dma-noncoherent;
+
+			ranges = <0x0 0x0 0x0 0xf1000000 0x0 0x200000>;
+
+			its: msi-controller@40000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x40000 0x0 0x20000>;
+				dma-noncoherent;
+				msi-controller;
+				#msi-cells = <1>;
+			};
 		};
 
 		wwdt0: watchdog@ffc90000 {
-- 
2.53.0

