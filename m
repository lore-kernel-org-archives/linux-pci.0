Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792449;
	b=sVHotJO7VHNz+u1JLTs9fbteGDtdEnuGQhZYRvD85NPHc7NEkhqasbSPCU33pwg/EhIo
	 +A8R9VTTUw+o2k17uBGA8VckdXbgAV+1rMe8bJLawdVhKsVdXHMHV6qcJegFsQ0zNqVGB
	 xmLtTvOnL3a6sVXINjtnEk6wl48jOFFfzbB2NoCZtfkFLbZlORVqFTpTz6awv8mt4ZfEX
	 9gbIqk+24s6Ilu4FqG/tlAr3vkMjiHXKLCviqnKkdIHz5CW6xrgLgc+7KWvJ/c2GUj3w6
	 2R/h+YrSEraNlWrb4265JoFUKBw66evi+nHVB5LuOKrOa20DfgYSI3z0BUvyKDqZekQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792449;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=b8gdt5Gsl7of0UCwZA1LRvMWZqGY7tF4209QTmH/GcI=;
	b=zxCKbQZg1RdY0I5NktZhYTQIzTzKyjIakxeWCiZAebilL9QMX8XUT0XZ8BkePu/TBjIf
	 9ln9e76tlkTIdkZT+TeK5Z3gNh/Wrz7CreyeWugFlWXujMIKVJHgqEnroTnynj8jxSQgK
	 ShpHn1K/rl4F1DF35g2xwJj2/vdmMaD8JpqdMBbqWvsYSqOLjgrgcev4vyNGvDQl3jbCZ
	 20iUQ5K23D0jmxK20Us90J9sklGN+ELHWGWd9MZdQpqeHCLKLGuC6Am7WxTkl27/7uVeg
	 F8aCSf9C+EzeC3o+vIy2IhxV0IDUzEuwg4wFEIUbqoIMCOyuHNxAeD5k/BNMZm6ISbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=oCERtlr5;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590F606D811;
	Wed,  4 Nov 2026 11:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4590F606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=oCERtlr5
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793792441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8gdt5Gsl7of0UCwZA1LRvMWZqGY7tF4209QTmH/GcI=;
	b=oCERtlr5rn8ngX0o9/IKhBD/Jw7b3jjwg1rmVSJ4QVDmkg7lj+zyv62AhgGsw0OQzhx+3y
	CykiD1aHGSyrAQou3Nw/TbbxBFIfi9y+gIeidxEnRzUWi5q5v08DYKvtAhM7IYX4cDT+FZ
	gBIiy/tLWikwG522MzWTdtNUHfqhMgE=
Date: Wed, 04 Nov 2026 12:40:31 +0100
Subject: [PATCH v2 3/3] arm64: dts: apple: t600x: Add PCIe pwren gpios
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-apple-pcie-pwren-v2-3-216a4066965f@cyberchaos.dev>
References: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
In-Reply-To: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

For the MacBook Pro and Mac Studio devices using the M1 Pro/Max/Ultra
SoCs, add the appropriate fixed regulators for enabling the peripherals
connected to the PCIe ports (WiFi, SD card reader and USB xHCI), which
are controlled by GPIOs connected to the SMC.
Set the regulators as the power-supply of the respective PCIe port, so
that the endpoints are powered on before probing the ports.

Add the 'pciclass,0604' compatible string to the PCIe bridge nodes in
the SoC to allow the pci-pwrctrl-generic driver to bind to them.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  4 ++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 16 +++++++++++++++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 27 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 122a566e75d1..635635c4bfbd 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -460,6 +460,7 @@ pcie0: pcie@590000000 {
 		pinctrl-names = "default";
 
 		port00: pci@0,0 {
+			compatible = "pciclass,0604";
 			device_type = "pci";
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			reset-gpios = <&pinctrl_ap 4 GPIO_ACTIVE_LOW>;
@@ -479,6 +480,7 @@ port00: pci@0,0 {
 		};
 
 		port01: pci@1,0 {
+			compatible = "pciclass,0604";
 			device_type = "pci";
 			reg = <0x800 0x0 0x0 0x0 0x0>;
 			reset-gpios = <&pinctrl_ap 5 GPIO_ACTIVE_LOW>;
@@ -498,6 +500,7 @@ port01: pci@1,0 {
 		};
 
 		port02: pci@2,0 {
+			compatible = "pciclass,0604";
 			device_type = "pci";
 			reg = <0x1000 0x0 0x0 0x0 0x0>;
 			reset-gpios = <&pinctrl_ap 6 GPIO_ACTIVE_LOW>;
@@ -518,6 +521,7 @@ port02: pci@2,0 {
 		};
 
 		port03: pci@3,0 {
+			compatible = "pciclass,0604";
 			device_type = "pci";
 			reg = <0x1800 0x0 0x0 0x0 0x0>;
 			reset-gpios = <&pinctrl_ap 7 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index caded1636f3d..4f9dccf839ad 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -55,6 +55,20 @@ led-0 {
 			default-state = "keep";
 		};
 	};
+
+	vreg_pcie0_port0: regulator-pcie0-port0 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwren-pcie0-port0";
+		gpio = <&smc_gpio 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vreg_pcie0_port1: regulator-pcie0-port1 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwren-pcie0-port1";
+		gpio = <&smc_gpio 26 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &serial0 {
@@ -176,6 +190,7 @@ &nco_clkref {
 /* PCIe devices */
 &port00 {
 	/* WLAN */
+	power-supply = <&vreg_pcie0_port0>;
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
 		compatible = "pci14e4,4433";
@@ -195,6 +210,7 @@ bluetooth0: bluetooth@0,1 {
 
 &port01 {
 	/* SD card reader */
+	power-supply = <&vreg_pcie0_port1>;
 	bus-range = <2 2>;
 	sdhci0: mmc@0,0 {
 		compatible = "pci17a0,9755";
diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
index 8a1494949e4c..412b2fe109be 100644
--- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
@@ -42,6 +42,30 @@ memory@10000000000 {
 		device_type = "memory";
 		reg = <0x100 0 0x2 0>; /* To be filled by loader */
 	};
+
+	/* WLAN/BT */
+	vreg_pcie0_port0: regulator-pcie0-port0 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwren-pcie0-port0";
+		gpio = <&smc_gpio 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* SD card reader */
+	vreg_pcie0_port1: regulator-pcie0-port1 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwren-pcie0-port1";
+		gpio = <&smc_gpio 26 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* USB xHCI */
+	vreg_pcie0_port3: regulator-pcie0-port3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pwren-pcie0-port3";
+		gpio = <&smc_gpio 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &serial0 {
@@ -356,6 +380,7 @@ &nco_clkref {
 /* PCIe devices */
 &port00 {
 	/* WLAN */
+	power-supply = <&vreg_pcie0_port0>;
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
 		compatible = "pci14e4,4433";
@@ -375,6 +400,7 @@ bluetooth0: bluetooth@0,1 {
 
 &port01 {
 	/* SD card reader */
+	power-supply = <&vreg_pcie0_port1>;
 	bus-range = <2 2>;
 	sdhci0: mmc@0,0 {
 		compatible = "pci17a0,9755";
@@ -397,6 +423,7 @@ ethernet0: ethernet@0,0 {
 
 &port03 {
 	/* USB xHCI */
+	power-supply = <&vreg_pcie0_port3>;
 	bus-range = <4 4>;
 	status = "okay";
 };

-- 
2.56.0

