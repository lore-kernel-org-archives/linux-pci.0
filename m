Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588234;
	b=dISCMii4hwUxG0PAV+Y55TT5QmGIyJ1fFXTYvc/Vg/iJNvCkGyhpijvMbXptL/xKbwoa
	 jvye5FaqYT8VRDn45GbtsSQpJJACWBzBUTasPPWZarLofcPh5FF3PdyjNhG7tl3qn/Mxu
	 WK6+ZOTzg1iCrJr/ya8fg3VUG51A8812RMeTeS0t6qVCv1sIOPqB/sSoXjONjaG79awya
	 KKbUQvYXlxKzwJTlh9Xa2bQnaF6kLF74hsa3+Ya8wMhTyQQLYkrmpffCt8asxC7q68LIj
	 Oy6TdXBgW/tsPeid9QLHPz34o7roISLFu8CX79ok6Q7BvSPaiDjX5iiRzJ5t+pq2Vjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588234;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Jd9GpNnKuAEXDZRlaw/A4HJ7oebPS5UXTKzQT7tnSw=;
	b=WOD0OfrGFFtbjtYyGeZAVoSb5jRQTDotq54udH/p4rEyuLVLbWzxmvq7iyu3+Kuww9Ql
	 fci9JggPiokcYkCbQ4pVfO+zu+6CDMgwemPaXIbZAFmLzcIVijFyA9q0SSbv+fhw8qWhx
	 IF50idxPGV3lm/Uo/rTsICu23cdyEpxFhfqZx/mk+QDMQF8HA1wPE6FibSpnUCWPPS+y/
	 NtyWy7ZXxcj04OvHMI2WbUSmT6QShDVHMeYiN8wHCWlIrYi+4ggztHoWJVdH6GZ20Y3fM
	 1GTCFg0CqrzYU9wcVrsBQsxeWj05uJu8biNqSbxQPJUn79rada0LFs+9MsD2zMY41dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=pXDTTIPR;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534F606A327;
	Wed, 25 Nov 2026 06:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C534F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=pXDTTIPR
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id AAE8A4C951;
	Wed, 25 Nov 2026 17:30:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795588224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Jd9GpNnKuAEXDZRlaw/A4HJ7oebPS5UXTKzQT7tnSw=;
	b=pXDTTIPReYFx9AL9Bd7ktHuVmFgDB3d218cZmrxtQG6VGpcK9QT741Mqbktcua3l8/FXPv
	UZOpcjQjKzYChKkqXPLE204ZSlNadlz9ZetzY/VaPNGsJUexhOoaB2++r9ZQFkWQVB5eDC
	BPfWGUgd1fprwXpO61xpyvOKLW7CstcW0iaTv75ipaCX27XnTSYyyG57W7POHz4/eUvTDA
	tnrFby/SjutnTmbYjYKOiBe7n82EH+OjD3rTNTBTIwWuVOgj1jnjQuMhEp53tWdo3e8Wbs
	r5f1peoT28tzk3Il0jw49/Cj0893XFSdlyYU+H/aAlzYkY9kE6BOPqczzmjYOQ==
X-GPT-Reason: This is a legitimate technical communication (patch
	submission) regarding Linux kernel or hardware driver development.
	The content is highly specific to technical engineering (PCIe,
	PHY nodes, DMA ranges) and aligns perfectly with the sender identity
	(alastair@d-silva.org) and the recipient's known personal domain
	(alastair@d-silva.org). No marketing, phishing, or scam indicators
	are present, and the technical nature of the body matches the expected
	activity for these specific users.
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
Subject: [PATCH 5/5] arm64: dts: allwinner: sun60i-a733: Add PCIe and Combo PHY nodes
Date: Wed, 25 Nov 2026 17:29:48 +1100
Message-ID: <20261125062948.1234677-6-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125062948.1234677-1-alastair@d-silva.org>
References: <20261125062948.1234677-1-alastair@d-silva.org>
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

Add SerDes syscon, Cadence Combo PHY, and DesignWare PCIe Root Complex
nodes to sun60i-a733.dtsi.

Place pcie@6000000 at the root node because soc@0 uses 1-cell addresses
and a 1 GB ranges window, whereas pcie@6000000 requires 64-bit
dma-ranges. Use the DWC integrated MSI receiver (msi IRQ) while GICv3
ITS remains disabled.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 .../arm64/boot/dts/allwinner/sun60i-a733.dtsi | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
index b0f642f37803a..64bab9e90b72b 100644
--- a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
@@ -4,6 +4,8 @@
 #include <dt-bindings/clock/allwinner,sun60i-a733-ccu.h>
 #include <dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/allwinner,sun60i-a733-pck-600.h>
 #include <dt-bindings/reset/allwinner,sun60i-a733-ccu.h>
 #include <dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h>
 
@@ -539,6 +541,30 @@ mmc2: mmc@4022000 {
 			status = "disabled";
 		};
 
+		serdes: syscon@6c00000 {
+			compatible = "allwinner,sun60i-a733-serdes-syscon",
+				     "syscon";
+			reg = <0x06c00000 0x8000>;
+		};
+
+		combophy1: phy@6ca0000 {
+			compatible = "allwinner,sun60i-a733-combophy1";
+			reg = <0x06ca0000 0x20000>;
+			clocks = <&ccu CLK_SERDES_PHY>,
+				 <&ccu CLK_AHB_SERDES>,
+				 <&ccu CLK_MBUS_SERDES>,
+				 <&rtc CLK_HOSC_SERDES1>;
+			clock-names = "serdes", "ahb", "mbus", "ref";
+			assigned-clocks = <&ccu CLK_SERDES_PHY>;
+			assigned-clock-parents = <&ccu CLK_PLL_PERIPH0_600M>;
+			assigned-clock-rates = <100000000>;
+			resets = <&ccu RST_BUS_SERDES>;
+			power-domains = <&pck600 PD_PCIE>;
+			#phy-cells = <1>;
+			allwinner,serdes-syscon = <&serdes>;
+			status = "disabled";
+		};
+
 		r_ccu: clock-controller@7010000 {
 			compatible = "allwinner,sun60i-a733-r-ccu";
 			reg = <0x07010000 0x250>;
@@ -654,4 +680,54 @@ rtc: rtc@7090000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	pcie: pcie@6000000 {
+		compatible = "allwinner,sun60i-a733-pcie";
+		reg = <0x0 0x06000000 0x0 0x00010000>,
+		      <0x0 0x06300000 0x0 0x00100000>,
+		      <0x0 0x06400000 0x0 0x00080000>,
+		      <0x0 0x20000000 0x0 0x01000000>;
+		reg-names = "dbi", "atu", "app", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		ranges = <0x81000000 0x0 0x21000000 0x0 0x21000000 0x0 0x00010000>,
+			 <0x82000000 0x0 0x22000000 0x0 0x22000000 0x0 0x06000000>;
+		dma-ranges = <0x03000000 0x0 0x40000000 0x0 0x40000000 0x3 0xc0000000>;
+		clocks = <&ccu CLK_PCIE_AUX>,
+			 <&ccu CLK_PCIE_AXI_SLV>,
+			 <&ccu CLK_BUS_ITS_PCIE0_ACLK>;
+		clock-names = "aux", "slv", "mstr";
+		assigned-clocks = <&ccu CLK_PCIE_AXI_SLV>;
+		assigned-clock-parents = <&ccu CLK_PLL_PERIPH0_400M>;
+		assigned-clock-rates = <400000000>;
+		resets = <&ccu RST_BUS_PCIE>,
+			 <&ccu RST_BUS_PCIE_PWRUP>,
+			 <&ccu RST_BUS_ITS_PCIE0>;
+		reset-names = "core", "pwr", "mstr";
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "app", "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+				<0 0 0 2 &pcie_intc 1>,
+				<0 0 0 3 &pcie_intc 2>,
+				<0 0 0 4 &pcie_intc 3>;
+		max-link-speed = <3>;
+		num-lanes = <1>;
+		linux,pci-domain = <0>;
+		phys = <&combophy1 PHY_TYPE_PCIE>;
+		phy-names = "pcie0";
+		power-domains = <&pck600 PD_PCIE>;
+		allwinner,serdes-syscon = <&serdes>;
+		status = "disabled";
+
+		pcie_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
 };
-- 
2.53.0

