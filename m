Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878590;
	b=LC4kckyjTP4VjVCM8lY5yA+wWzmW2593gnOd598eUpvGxmojmszYXNUakfw2Hhp61vdh
	 OvFqS6r+5vCl3qFLX2SW8/OgikdZYxj+jF5alc6vhxybnNXf68SvRAzXtVmC6VrXmEuCu
	 L+3c5TZOvGykIhnRccMtdaTkDmx8fp92o0KsXvRi5+Ig4/KVT+PdZnJO9kJ+d1OoYO8J5
	 aKDjWm35xtmp0i46k2RXb8Q+Xa9j7dIVAyclE6x9wBQzGG5+Qc+Gw4k6YJV3fEgMtbw7r
	 Fxwy2L7ujugiOd3tiyHLMJctM2EEHi9EU/CjAMUDA61ZixoZIyJqto4B3KZ/q20sIFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878590;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Kte5WYMT424VKNrj5TrTokW/zcBpMOsYidoEzhcRPUY=;
	b=xjvUJj5+uMoxPvuyX8qi2su/LcDA2aCEla4CGdXoPObadjbeC4LuDEqIkPA5LlPWIg1D
	 7ddhR01h1x7vJXc9OARbK2DpntDEAHt/DdGI1utkRpgZZg6SXvibvi8JqGqRaNdYcYvOt
	 f7uEQvwiPp3Kr7TdIvWmEDHh1s41w/NuQeOuyrGE2VMEagbWIB3cjfcMVlQB9mGxWQdlX
	 KUo1ZyieC7ovFy0GiYtkDq3tRVW/VHYFdR+0LYb0M3BanpuuFnsyQ5XXXOHJzfULxiZYX
	 mzd5+LwF3nO9f/P6v2yqywGh3vpu835kJsO97V7od4vXgskrayeriuu+li0ErSuekhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=v4ldKWv3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jYYFRCsx;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192DE606D805
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 192DE606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=v4ldKWv3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jYYFRCsx
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CBA11D00172
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 06:36:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 06:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793878587;
	 x=1793964987; bh=Kte5WYMT424VKNrj5TrTokW/zcBpMOsYidoEzhcRPUY=; b=
	v4ldKWv30/9T74Z3UbL2JoGhGMJEFYo8GXvPxdXbv+qzSy+SiCyfIBerdZ5Gkkeb
	in7+Lf/7mHGcdgaYaktNwJLgewNG+kuJqeoo1y3OaYQQtMM8be2Lc9xTwoh/O+Ms
	08eFFsuVP3CrBcH+62ZBCYig1xgbOaxzX6c7nAqhF1BlVtWevgYH2JVVydlHERHa
	OUnt4o0RtiWpl2IQe5oV1eBwqIa17EyzgPzU/wYOIt2fU+H+YhP4BLX/NqRT5Np3
	ktTpOHC9xOKZIVsOni9748g4LzmMC3EGUvfkG+zMq7ToFi1/ErB5wrCCvc59SIih
	+uvsJHF7JjxFBjL+skM4bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793878587; x=
	1793964987; bh=Kte5WYMT424VKNrj5TrTokW/zcBpMOsYidoEzhcRPUY=; b=j
	YYFRCsxmKNpinJYHCEFVFsuho/8JZD5mw/AQvsnmDSc8UTUghXiLNuLyFTrbJOzc
	EQK0K5NzpTe0f9xIGLJdyNpNZG7uLFxErU+t8ynaGl432FijfhgUfLgGFvPGG+Rz
	eORJ8/BJImqbtSzqhkfD3VueRrgJGcdO1RDLAxHwGsYsC/ueMoQ04xRUV1fuC82P
	O1GjByD0jhOBR4NhPIG6LHjrhQjk6rhSHObBesI+F75jDRvqVAkQ3nv0kbTYjKBa
	QVzHzjDBrnRmmlvDK3cG5ku4WC3Tv0KfGqE6WpDuE/u3NR0PAzVX6U+GCRODONhg
	Bjf6bc03WoMkAjWsRQ/rA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793878587; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Vw7Fx0hY9tyMd6FhLA6rbgTogNrJ9P4m7A1SSB0kSJI9va/
	hoIAi6V8jKQYq5FdJsYxLec3Th9TNwCRL7hIHsyXkOI5NtpVMbQ45tR96KttbgbN
	I0uodJ8D7NUNm7x+Wl4t8C3JCIP95KfOzMTlMOmCV45TERVAuqEDNVZjgNhIQ4HM
	a9K0tDeVmh0khmhTKhjKCOtf/tNSxqxdeDOzel9JWO0Sj9XIZ7gnrXP0PadPmEkh
	d59sqi7fkx19Abi4UxAeVh/CXKZ7X2+i4pJ8AQ19gqXj3ZLwsuuK2tOYCb04RXFp
	j7Y2brSQG3Hlkc+v7RDQU2QXGl+fVRyFz9EIiVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:D35VkODGQvc1SK3/ZPvDKyGJGOlLcwZZhByDXLG7crY=:38WaFZSMlnnR6BRrfybqqIYKvxpuFmMHf44pTN+EAS4=;
X-ME-Sender: <xms:OmrsaqhXt-PAMx732lFNG-Z0qqjxQzSzHcZpuu8xT1jM0ejlSdnLTQ>
    <xme:OmrsasbZy46wPDgFscI9kB44IbuBnWL7Qg-Wrufrrd1r6fYCBLkHLC2G3VdWjpZM3
    tpsKpdERyihA4sSSGHyLZz6xZn1ZTuOL4Q5DALQiRzyyetzIFmCUjHH>
X-ME-Received: <xmr:OmrsarVcsgTGlTFEkEpPt7isA6ybt2avKu2wj2tVwG57v1Bg6bRR2XcAwvXjvzTixE5Q05DDOHUAVotHN6FodP5se22XSgkWC7E>
X-ME-Proxy-Cause: dmFkZTFxL6fPj/83KjW+fPrzD7XIhU0ugn9J7NLmcT7qkhSOHV6Af82MPa5XBOzqpSBIeN
    Pp7p8OyM+TI/GES+hrNz1pWoLtoPr0PQyTaY9NPuTzBRGPiAAcJ3TBtaGIGFJ6EIOXXhvi
    OmWkGixLiwFSU5Ji8fLekxxR6EJsv6volK4Aa+XkeiLpTkZTvhHs0PqHDFrfqL/zb/0ZP3
    9znFWT6W8alLK2f1H3T6MWoAM3iYPGn74enSenY1WYKm4dI7WWKEv57BXjNOh+/gVX8bJw
    C1jhLxJz5rZaO//peRzsXKtK782l6mQSftbsv/PkoCji5Zyj+60teGD5l3K8E1b3VAFApe
    dUmhRI9J/3YBjKWcVQaiXE4gIgLNCxEu4JlILdknU4mJwJbmqd3f8UOgPZJFHkSzAsFEC3
    nEenC3onDhpeKOx7ZHEGN97k0l3uPEc1kmrFWzTNAKaJl8g9jmkggmY0bY0yBIyIbjKJKB
    ZI/eymcEm2LAHy4YsjFbt0CDuCUIjpYTZVCxTOZ+ZMGsw/F0A2xwTPOfNv4kj3iEG+d2eK
    WYyC9yFrY/5kd7LjA1IgMagEb8ocQYwuRHSLqruVVGvakZsA19XAzH/dZ6QyWkmogM+r7R
    RJL3aN/mR3IruS1Tiivo3esvoNQHr3Vcs4FcaEwvkRdA9jJY5WrnrCTVp2ZA
X-ME-Proxy: <xmx:OmrsarjNDrBaL0EkZsFm4zHoWSL-eCSHoihPvtryXhuJuZJoH4OcoA>
    <xmx:OmrsaunwZo7dGWKSeuO69OpC2yPM-zFx0a3eRZzzkLYma84kwCK-Gg>
    <xmx:OmrsasxG9VeBqjggU8efbrIa8bGShOsfPcN8btk8LtH916psAT8jgQ>
    <xmx:Omrsahu_Ca_O9GENWslblVJJt8D0RnLVQ9JRWJbuiTxfltCzjOcHbA>
    <xmx:O2rsapgG7kHxCuUCMgsd4YAmXbkfTENpQeCeB0P0yQeGx3R4LvjlRqj6>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 06:36:26 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Thu, 05 Nov 2026 12:36:00 +0100
Subject: [PATCH 3/7] arm64: dts: apple: t6030: Add PCIe nodes
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
Message-Id: <20261105-apple-m3-pcie-v1-3-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
In-Reply-To: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
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
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6143; i=j@jannau.net;
 h=from:subject:message-id; bh=38WaFZSMlnnR6BRrfybqqIYKvxpuFmMHf44pTN+EAS4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqw3Wepfi+c3WQsL7/zTY1u4OyI9cXtS+KKFjy8GbIid5
 W7+qNS6YyILgxgXg6WYIkuS9ssOhtU1ijG1D8Jg5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmOonXIwMZ6+5nok4krd4Al9C9rItV2VeLnP4mS4bc6Ik4NOM2KIZCgz/sx1mnvo
 64332269fer3+sbyeEqQW+Gf/SrX41FDD0LvczAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Add the PCIe controller, its ports, IOMMUs and clock request pins to the
base M3 Pro .dtsi file.
M3 Pro is only used in 14 and 16-inch Macbook Pro which connect PCIe
devices to the port 0 and 1.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t6030.dtsi | 165 +++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/apple/t6030.dtsi
index 85a16d03e22f..4bac0fbcea8c 100644
--- a/arch/arm64/boot/dts/apple/t6030.dtsi
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -7,6 +7,7 @@
  * Copyright The Asahi Linux Contributors
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
@@ -431,6 +432,14 @@ i2c8_pins: i2c8-pins {
 				pinmux = <APPLE_PINMUX(51, 1)>,
 					 <APPLE_PINMUX(50, 1)>;
 			};
+
+			pcie_pins: pcie-pins {
+				// clkreq pins
+				pinmux = <APPLE_PINMUX(163, 1)>,
+					 <APPLE_PINMUX(164, 1)>,
+					 <APPLE_PINMUX(165, 1)>,
+					 <APPLE_PINMUX(166, 1)>;
+			};
 		};
 
 		pmgr: power-management@350700000 {
@@ -579,6 +588,162 @@ nvme: nvme@38dcc0000 {
 
 			apple,sart = <&sart>;
 		};
+
+		pcie0: pcie@580000000 {
+			device_type = "pci";
+			compatible = "apple,t6030-pcie", "apple,t6020-pcie";
+
+			reg = <0x5 0x80000000 0x0 0x1000000>,	/* config */
+			      <0x5 0x91000000 0x0 0x4000>,	/* rc */
+			      <0x5 0x94008000 0x0 0x4000>,	/* port0 */
+			      <0x5 0x95008000 0x0 0x4000>,	/* port1 */
+			      <0x5 0x96008000 0x0 0x4000>,	/* port2 */
+			      <0x5 0x97008000 0x0 0x4000>,	/* port3 */
+			      <0x5 0x9e020000 0x0 0x4000>,	/* phy0 */
+			      <0x5 0x9e024000 0x0 0x4000>,	/* phy1 */
+			      <0x5 0x9e028000 0x0 0x4000>,	/* phy2 */
+			      <0x5 0x9e02c000 0x0 0x4000>;	/* phy3 */
+			reg-names = "config", "rc",
+				    "port0", "port1", "port2", "port3",
+				    "phy0", "phy1", "phy2", "phy3";
+			ranges = <0x43000000 0x5 0xa0000000 0x5 0xa0000000 0x0 0x20000000>,
+				 <0x02000000 0x0 0xc0000000 0x5 0xc0000000 0x0 0x40000000>;
+			#address-cells = <3>;
+			bus-range = <0 4>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1038 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1047 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1056 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1065 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommu-map = <0x100 &pcie0_dart_0 1 1>,
+				    <0x200 &pcie0_dart_1 1 1>,
+				    <0x300 &pcie0_dart_2 1 1>,
+				    <0x400 &pcie0_dart_3 1 1>;
+			iommu-map-mask = <0xff00>;
+
+			msi-controller;
+			msi-parent = <&pcie0>;
+			msi-ranges = <&aic AIC_IRQ 1342 IRQ_TYPE_EDGE_RISING 32>;
+
+			pinctrl-0 = <&pcie_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_apcie_sys_gp>;
+			#size-cells = <2>;
+
+			port00: pci@0,0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				#address-cells = <3>;
+
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
+						<0 0 0 2 &port00 0 0 0 1>,
+						<0 0 0 3 &port00 0 0 0 2>,
+						<0 0 0 4 &port00 0 0 0 3>;
+				interrupt-map-mask = <0 0 0 7>;
+				reset-gpios = <&pinctrl_ap 167 GPIO_ACTIVE_LOW>;
+				#size-cells = <2>;
+			};
+
+			port01: pci@1,0 {
+				device_type = "pci";
+				reg = <0x800 0x0 0x0 0x0 0x0>;
+				ranges;
+				#address-cells = <3>;
+
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupt-map = <0 0 0 1 &port01 0 0 0 0>,
+						<0 0 0 2 &port01 0 0 0 1>,
+						<0 0 0 3 &port01 0 0 0 2>,
+						<0 0 0 4 &port01 0 0 0 3>;
+				interrupt-map-mask = <0 0 0 7>;
+				reset-gpios = <&pinctrl_ap 168 GPIO_ACTIVE_LOW>;
+				#size-cells = <2>;
+			};
+
+			port02: pci@2,0 {
+				device_type = "pci";
+				reg = <0x1000 0x0 0x0 0x0 0x0>;
+				ranges;
+				#address-cells = <3>;
+
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupt-map = <0 0 0 1 &port02 0 0 0 0>,
+						<0 0 0 2 &port02 0 0 0 1>,
+						<0 0 0 3 &port02 0 0 0 2>,
+						<0 0 0 4 &port02 0 0 0 3>;
+				interrupt-map-mask = <0 0 0 7>;
+				reset-gpios = <&pinctrl_ap 169 GPIO_ACTIVE_LOW>;
+				#size-cells = <2>;
+
+				status = "disabled";
+			};
+
+			port03: pci@3,0 {
+				device_type = "pci";
+				reg = <0x1800 0x0 0x0 0x0 0x0>;
+				ranges;
+				#address-cells = <3>;
+
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupt-map = <0 0 0 1 &port03 0 0 0 0>,
+						<0 0 0 2 &port03 0 0 0 1>,
+						<0 0 0 3 &port03 0 0 0 2>,
+						<0 0 0 4 &port03 0 0 0 3>;
+				interrupt-map-mask = <0 0 0 7>;
+				reset-gpios = <&pinctrl_ap 170 GPIO_ACTIVE_LOW>;
+				#size-cells = <2>;
+
+				status = "disabled";
+			};
+		};
+
+		pcie0_dart_0: iommu@594000000 {
+			compatible = "apple,t6030-dart", "apple,t8110-dart";
+			reg = <0x5 0x94000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1039 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_sys_gp>;
+		};
+
+		pcie0_dart_1: iommu@595000000 {
+			compatible = "apple,t6030-dart", "apple,t8110-dart";
+			reg = <0x5 0x95000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1048 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_sys_gp>;
+		};
+
+		pcie0_dart_2: iommu@596000000 {
+			compatible = "apple,t6030-dart", "apple,t8110-dart";
+			reg = <0x5 0x96000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1057 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_sys_gp>;
+
+			status = "disabled";
+		};
+
+		pcie0_dart_3: iommu@597000000 {
+			compatible = "apple,t6030-dart", "apple,t8110-dart";
+			reg = <0x5 0x97000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1066 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_sys_gp>;
+
+			status = "disabled";
+		};
 	};
 
 	timer {

-- 
2.56.0

