Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147780;
	b=jBDQKzMrUSsdQ4+rTAoDAClHovN5Q1hbcNuIOHOdLGoOufZt62AlswOzkTgc/EKgq64D
	 hERgdi0uFxLUNzxjvK9Fn22jZDjMo1RTzmwesWcWZr+F6/0DdgmB3t8z31iIeunqcYUF+
	 HtyTOO0utWPkmhuDWq0pKlWfJrKbi4WlNy3me3prV1BF38gN56frmwkby1n5V/eJC2Rdx
	 MhH8HPfYl99ruPrIVyvrNcMD8O69qn2FYC/1OBKipKRRhuR7+/BrUoPSSSOcaTrilLVEQ
	 15JSwBiDaZD58jpDVrU3w1m4R4APLoxrFv6KVjkSGRZL+SBYSxeQMXKVMwcm03Cx8LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147780;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3NhPpUUiBx8/fTcqcZZZh3J0CctL/rOpbWxqhlr3k6w=;
	b=0BY/4lV3KP1wCqZwzb4DpPTFRULV2p8mehZ5LvUAFd1JtzlJzBQpMVR//9ElSbgDSh00
	 TEho0KKfV1+4cBhr6vh+HIctqtbL3Fpu9Q/R9tsr8tQwzJmdfuneX6erBJ+0PI6SqjUNk
	 JGRwGv08gr2HXwWWV/RJNz7pqGsi2xurYnIdt1/LpXkFqtNyOA7HE4RQyeCN4xx6Xs1lk
	 hDI/w9z1iLdUh2yF1wsy1kzP/n5dAvpSL9QkQDy1TNkHejlvfzA6B/kCv/px0dZX5NMwu
	 IXGdBQBM3Tr4oP7Qra2U4OGmZdaGMdue9+C82RKbiVfeaCUEVStjSHBf+rtlA24ZuUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=iWhU0X0v;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="G/x4nsIR";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5D606D82C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF5D606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=iWhU0X0v;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=G/x4nsIR
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AFDDFEC0303
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:22:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 08 Nov 2026 09:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794147778;
	 x=1794234178; bh=3NhPpUUiBx8/fTcqcZZZh3J0CctL/rOpbWxqhlr3k6w=; b=
	iWhU0X0vMcI8CF8sthB32f+TGYUGAK+DwvXsG1BbOC4XFBjqDXflHtQ60R4+/i+p
	/ZKzg19f35c6Mdb9g29IH1jxiM91DYZGEufseXa0n3N0mWjRdhdHpLHdq4Tpts0j
	vA8rOEcT+k4spKhTjmrdIiqRKtgMvP3N1OhjX0F8ZFnj/svwByQuZyxECOLaIbsL
	4xULmcPW/nURJNBPtKTrS02BvceciaFoAsiN4nFPCyzoTrS1m7M6Qugk4AeptS8U
	LU+G7Y9+08lT3E/xX+TQAYUf6KdhtY2/HdFqPB3wfOvZqeNqsjPVI9bdvn42cHSg
	e2hh/PPTRg0Arc9x2cDLow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794147778; x=
	1794234178; bh=3NhPpUUiBx8/fTcqcZZZh3J0CctL/rOpbWxqhlr3k6w=; b=G
	/x4nsIR0V9YsFRn2yjx55ZD7ii9sxWLgJrGDNy46GTTHje7o8T+rZJpMrkCV0ILt
	J+aonYvptT3E84xZ54VaSUN1gVYeK301gScE8q63PM6pzfoUN76rdKaEHELKdKyM
	kXUD0Mowa4Fb3K01RE2phinoQx1OJ0ytz5/bvoJ0bNRTqFpoMJWA9U59cUTmt+oT
	Due3kgLoTKxwikjyebe5Ggfr4FA54ft1LKDKJRxSyNNOksH6Aqh+RkKimbqeunIp
	/i8ziYlUdh48EvpXKTzANjlxWFGPtR8HzZQvYvIVmRtVV3KYWvI/tTk84qOrFeFk
	Rg3JYZmKcY0TPSE1Qg7rA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794147778; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cvgq1arRPCKsBR1qqv/0DKYXV54kEYesh8T67LA1E5EM3fy
	N2qRJeNnhL8LQq4Ys6Y5T/pOfypRC/ExvcbPWhSK/e5u7mXDlI0Gb5FgV5e4qBAH
	DEcDIl9PLgGt8st7iVB9bFetC2Ax0xTdqod9vLlsUbekegVYIf8/0w6d3o06nEZj
	sM7M8TAqVQy5mzvm7ZA2tidHKf3c5B4Ct9syPkZbPIJUU0QkHF/7cCwfTzxMuovb
	8Q3LBKfVlEmDewmVlUy7Vk9amSP5iTInxg4o23N5mloSboBO4JTQcwcghPL6kmqe
	yx4lotKMcBwOr2/9X9vUUFRxRp1WTrW/NZIVmvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ouPjY0LHe7vcBLlxJeCCawnyVv3T0mwVsnW8Qx/E4Sk=:kjuk0kiHKUVKuHCdCxiQPDaH9C8FmP0elq5OqHT4UPs=;
X-ME-Sender: <xms:woXwaiKE67MqneSXpoizpG3Mc5hPqtD2D9tLQlusMxjmmAqDw5hO6w>
    <xme:woXwapYGDKTPopBaGGwZhpeR2070SBBVv-E33m6pMmEDKhuBPWF4XDSCme8rRyBvV
    01gkz7mRTVJbyL3nho6aVE9Ehm_aD-uYzdTIMu0oVanDUYiWKL3Pg8>
X-ME-Received: <xmr:woXwaliGsOebcKul0AmlRW9TuzC1J62p2HR2-6UhQWvN2nK76pspOKpS3ZzuEfKbA2CH74EQfzp-1Vq6NIfyGw4txpSqJv-6yFI>
X-ME-Proxy-Cause: dmFkZTF1/OoyBHZeKkYHuDYGM63j9jjRRAXnSfBClWUCf4gVPwc6DDCJQKymj/NnJ+2tPI
    RaNzmG6go3Fon+4iofKw0vJiG0nMnTUDOLVzdWkQIbkICLQjBhNTf/LSM3bm23TL8NOcpM
    jXZiSi/IhI3kWSBJ3jX0CI9x5kqY+RMkhgvMiWOvsa41kKVI5GXVWm+fNqvGSQWoD7AYpl
    Bd1FfUdvX7NfAQiO60zwpycY+e07StC2WjhSvkwuqwtIJSVHdccKUZoH8krEr76NELNSRc
    zKoyEpExPl9+V+mIIg+5HwVM8DwQ3WlFLrNmqSnCsOEGSKcVq8IS2jjVeCW2/OhvXWFnWb
    JMhiDAuP0IdIoeka6LfuAc2lUtsZ9wLHp/nuIXQL50bNy5c8vRXJKqTC62no5Yi5eEcP8y
    z6jQcz7gtO3/Ky97E9jVMxxoSTjnP/8CLcksNEmMiSxUVLivH8Y3ulwbCeDvpR1qpcwmyD
    B08r9qovl6jCr5kEEE+utO2GOYsv5cbh2OvtLvRmIISkbHPiTWhbU54Siqw71kP0gijn8F
    lr+w5iQMdX2io05LlsDqnwauz+FtDO4nGInhYKvy/fX0VYW3ZOV7DAoEnAHxVs7TXMgvH0
    DClMgJ6/thMBc/qD2gnXsLqDkSyCv+R/smngTyP1AHypc/6iaOx1WNK5lKLg
X-ME-Proxy: <xmx:woXwau4azuTxozCQZVN9_FwTzAB8AOkLc6OksfzBjzvbKhHx-oSx7A>
    <xmx:woXwatqTpwIZYxR89tyC6s_n2_WuQ3wFGC016QnppmR1DKAPrbPXtQ>
    <xmx:woXwargeK-UnmxDYkI-j-IPkpz_0rmt0E6hRJ1HSNV9EGkIT409YTA>
    <xmx:woXwaltLqTvYFsiCMtMkmfm0Gl9c0JnvaHwigaSKfMVbYpeyN4ZKpw>
    <xmx:woXwapPL925OXj20lTPOWqNKETnt0xRuHubQtTWxDC3x9vpNx9awiowY>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 09:22:58 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 15:22:38 +0100
Subject: [PATCH v2 4/7] arm64: dts: apple: t6031: Add PCIe nodes
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
Message-Id: <20261108-apple-m3-pcie-v2-4-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
In-Reply-To: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joshua Peisach <jpeisach@ubuntu.com>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Yureka Lilian <yureka@cyberchaos.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6804; i=j@jannau.net;
 h=from:subject:message-id; bh=x77/1VYiLOv5Z/RiZPfZfLJlhGGqM59JzKpcO+5IWaw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPrVsfcEw6U+UufPlAqq7r251TE67GSDXfPlfHWj3Fz
 vHzjFcuHRNZGMS4GCzFFFmStF92MKyuUYypfRAGM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFT3/Wf4X/v4Y9NDjpS1h44cOOH5INT30tnSe2LXZ1/6zOt93iEndTnDP8UFdvP
 PHtM1qQuRP3vUrlGxqPlUzzS+eJak/YfePAxbxAsA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Yureka Lilian <yureka@cyberchaos.dev>

Add the PCIe controller, its ports, IOMMUs and clock request pins to the
die0 M3 Max/Ultra .dtsi file.
All M3 Max and Ultra devices use port 0 and 1 so enable them and their
IOMMU.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t6031-die0.dtsi      | 157 +++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi |   9 ++
 arch/arm64/boot/dts/apple/t6031.dtsi           |   1 +
 3 files changed, 167 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6031-die0.dtsi b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
index b14443436e26..434b16b2a6bf 100644
--- a/arch/arm64/boot/dts/apple/t6031-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
@@ -207,4 +207,161 @@ serial0: serial@391200000 {
 
 		status = "disabled";
 	};
+
+	pcie0: pcie@580000000 {
+		device_type = "pci";
+		compatible = "apple,t6031-pcie", "apple,t6020-pcie";
+
+		reg = <0x5 0x80000000 0x0 0x1000000>,	/* config */
+		      <0x5 0x91000000 0x0 0x4000>,	/* rc */
+		      <0x5 0x94008000 0x0 0x4000>,	/* port0 */
+		      <0x5 0x95008000 0x0 0x4000>,	/* port1 */
+		      <0x5 0x96008000 0x0 0x4000>,	/* port2 */
+		      <0x5 0x97008000 0x0 0x4000>,	/* port3 */
+		      <0x5 0x9e020000 0x0 0x4000>,	/* phy0 */
+		      <0x5 0x9e024000 0x0 0x4000>,	/* phy1 */
+		      <0x5 0x9e028000 0x0 0x4000>,	/* phy2 */
+		      <0x5 0x9e02c000 0x0 0x4000>;	/* phy3 */
+		reg-names = "config", "rc",
+			    "port0", "port1", "port2", "port3",
+			    "phy0", "phy1", "phy2", "phy3";
+
+		ranges = <0x43000000 0x5 0xa0000000 0x5 0xa0000000 0x0 0x20000000>,
+			 <0x02000000 0x0 0xc0000000 0x5 0xc0000000 0x0 0x40000000>;
+		#address-cells = <3>;
+		bus-range = <0 4>;
+
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1491 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 1500 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 1509 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 0 1518 IRQ_TYPE_LEVEL_HIGH>;
+
+		iommu-map = <0x100 &pcie0_dart_0 1 1>,
+			    <0x200 &pcie0_dart_1 1 1>,
+			    <0x300 &pcie0_dart_2 1 1>,
+			    <0x400 &pcie0_dart_3 1 1>;
+		iommu-map-mask = <0xff00>;
+
+		msi-controller;
+		msi-parent = <&pcie0>;
+		msi-ranges = <&aic AIC_IRQ 0 1854 IRQ_TYPE_EDGE_RISING 32>;
+
+		pinctrl-0 = <&pcie_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_apcie_sys_gp>;
+		#size-cells = <2>;
+
+		port00: pci@0,0 {
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			ranges;
+			#address-cells = <3>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
+					<0 0 0 2 &port00 0 0 0 1>,
+					<0 0 0 3 &port00 0 0 0 2>,
+					<0 0 0 4 &port00 0 0 0 3>;
+			interrupt-map-mask = <0 0 0 7>;
+			reset-gpios = <&pinctrl_ap 4 GPIO_ACTIVE_LOW>;
+			#size-cells = <2>;
+		};
+
+		port01: pci@1,0 {
+			device_type = "pci";
+			reg = <0x800 0x0 0x0 0x0 0x0>;
+			ranges;
+			#address-cells = <3>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-map = <0 0 0 1 &port01 0 0 0 0>,
+					<0 0 0 2 &port01 0 0 0 1>,
+					<0 0 0 3 &port01 0 0 0 2>,
+					<0 0 0 4 &port01 0 0 0 3>;
+			interrupt-map-mask = <0 0 0 7>;
+			reset-gpios = <&pinctrl_ap 5 GPIO_ACTIVE_LOW>;
+			#size-cells = <2>;
+		};
+
+		port02: pci@2,0 {
+			device_type = "pci";
+			reg = <0x1000 0x0 0x0 0x0 0x0>;
+			ranges;
+			#address-cells = <3>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-map = <0 0 0 1 &port02 0 0 0 0>,
+					<0 0 0 2 &port02 0 0 0 1>,
+					<0 0 0 3 &port02 0 0 0 2>,
+					<0 0 0 4 &port02 0 0 0 3>;
+			interrupt-map-mask = <0 0 0 7>;
+			reset-gpios = <&pinctrl_ap 6 GPIO_ACTIVE_LOW>;
+			#size-cells = <2>;
+
+			status = "disabled";
+		};
+
+		port03: pci@3,0 {
+			device_type = "pci";
+			reg = <0x1800 0x0 0x0 0x0 0x0>;
+			ranges;
+			#address-cells = <3>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-map = <0 0 0 1 &port03 0 0 0 0>,
+					<0 0 0 2 &port03 0 0 0 1>,
+					<0 0 0 3 &port03 0 0 0 2>,
+					<0 0 0 4 &port03 0 0 0 3>;
+			interrupt-map-mask = <0 0 0 7>;
+			reset-gpios = <&pinctrl_ap 7 GPIO_ACTIVE_LOW>;
+			#size-cells = <2>;
+
+			status = "disabled";
+		};
+	};
+
+	pcie0_dart_0: iommu@594000000 {
+		compatible = "apple,t6031-dart", "apple,t8110-dart";
+		reg = <0x5 0x94000000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1492 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&ps_apcie_sys_gp>;
+	};
+
+	pcie0_dart_1: iommu@595000000 {
+		compatible = "apple,t6031-dart", "apple,t8110-dart";
+		reg = <0x5 0x95000000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1501 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&ps_apcie_sys_gp>;
+	};
+
+	pcie0_dart_2: iommu@596000000 {
+		compatible = "apple,t6031-dart", "apple,t8110-dart";
+		reg = <0x5 0x96000000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1510 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&ps_apcie_sys_gp>;
+
+		status = "disabled";
+	};
+
+	pcie0_dart_3: iommu@597000000 {
+		compatible = "apple,t6031-dart", "apple,t8110-dart";
+		reg = <0x5 0x97000000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1519 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&ps_apcie_sys_gp>;
+
+		status = "disabled";
+	};
 };
diff --git a/arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi b/arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi
index 0c0d09964e69..1c29d0ef8a67 100644
--- a/arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi
@@ -5,6 +5,8 @@
  * Copyright The Asahi Linux Contributors
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 &pinctrl_ap {
 	i2c0_pins: i2c0-pins {
 		pinmux = <APPLE_PINMUX(56, 1)>,
@@ -50,4 +52,11 @@ i2c8_pins: i2c8-pins {
 		pinmux = <APPLE_PINMUX(72, 1)>,
 			 <APPLE_PINMUX(73, 1)>;
 	};
+
+	pcie_pins: pcie-pins {
+		pinmux = <APPLE_PINMUX(0, 1)>,
+			 <APPLE_PINMUX(1, 1)>,
+			 <APPLE_PINMUX(2, 1)>,
+			 <APPLE_PINMUX(3, 1)>;
+	};
 };
diff --git a/arch/arm64/boot/dts/apple/t6031.dtsi b/arch/arm64/boot/dts/apple/t6031.dtsi
index 30a91c1a47d2..9fd1d0f46fc3 100644
--- a/arch/arm64/boot/dts/apple/t6031.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031.dtsi
@@ -5,6 +5,7 @@
  * Copyright The Asahi Linux Contributors
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>

-- 
2.56.0

