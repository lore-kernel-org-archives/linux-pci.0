Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147778;
	b=YMVeQhBBwxOZyes+OabGTSuOTzRVZf3h1o1GOGzI9msS1Oqj5kmgaksEWYt9KAjViT7q
	 gQ+AfVNmZHHCyXZbPaVByb1iVIlLtooik6lvM48l+iV6uF5VR7wKNAfZMBULpo+ry+vo9
	 AXQiKLvDxnMKuzVSXR9fagoCejBBiI1wwAxNEsD4ZlxpqXHna7Rm45+muiZr4xFg8O5Nu
	 bLtF8b2hexKLHVFK3BXF9rQPDnbqcBU7extGw8VMegGBfejv8jIs2P175cPNBkHhs2DnL
	 K2/XVQAOpNY/W64ZWP5T7QcEEzjsTdcp5ggLDz+zFqNm5fncMUa8X76mRaOT3Dkws4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147778;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Kte5WYMT424VKNrj5TrTokW/zcBpMOsYidoEzhcRPUY=;
	b=N6VQ+zOycRO6I1fM+2ullLVCDrI/qLfN97N+zEaE5LwZOKl/0YJJcysabrkJFLj3PduQ
	 HgO+Dj+8JItHLriA1FPYFs212M9O8f3UfBITQ9xaSNJGSizIfetosp/200/Hwb+6UNPlw
	 DnnyhTGCF3n5jb7kCF0p0QhcL2PjXSWNYFOcH2EBfNc2IM68Z10gG3s2rqoQpGyvLreSx
	 Ltjsuk7/QvPJ5sSaiNmXH/izX505CCy0j8R4bPiKpP7BAelstBfCm1Jp6AZyCRYA84pWg
	 qjjNnQCNrmti9L7l1pC25plc3NnHpAo0049T9a8TK2g7D9N90owVz4ybZAAPGjouqhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=P1qyvvqa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VqasOx12;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC72606A33B
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC72606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=P1qyvvqa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VqasOx12
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F0721400130
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:22:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 09:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794147777;
	 x=1794234177; bh=Kte5WYMT424VKNrj5TrTokW/zcBpMOsYidoEzhcRPUY=; b=
	P1qyvvqaxvQuU2Zqb16/NRPVib9d89UgSfgHMASgYY/skgYVEZva8YUQdgcM0E0G
	4PrLV1fQleZcVnoa+kJvic0y+ISl2wQ8R4oidlj0xeh9Be3JTdzMTw7Jh7DUqERS
	YRYa35sX5DppZv6nuOoWvN5E8Dbg2lGBrkBKGDOSdJfcUg2+4Ipg8d+DewDccMT8
	aVSTfuE46aofjRYo+Ydx2TFyaWiiuj14HrDZ3BiQgfh1obkfUQL8onKNsBH3bBMj
	uCRWVuqZLmN7IfFtCP/y0FdMdjtIrBb5WYPjMYW42iKs57gT7rQayuZmPkXZP4o3
	ksSPxm1YkipMtcVh+mF2Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794147777; x=
	1794234177; bh=Kte5WYMT424VKNrj5TrTokW/zcBpMOsYidoEzhcRPUY=; b=V
	qasOx12qUdPznG4L1H+OUr58fmAy051kNtsrr758TxdhuxtEwxYYdcHOeUC9KMKM
	oVeDpcX3WmLIk/QY25AKox9OwSlygQ/J4OK6OJ3WjQenihRJfCSxOw6R8RUs5P0x
	xcKkSmi8Qu+3tyfph/Tw4B2C4VnzXqdjSFSyDrMIajcd6AmdiC6Q9p/tKoKj26lV
	oyc3RdemFH5rp+TXemMRONu4CMvOutp2F1msUKHrSW3ozKdIc4V+rys3D8GQfyBi
	q3oWH+GUayXKghXCw6VVDzvrdUf9uDDz+wZ1kRcVXhp1KbwbNVSavwzxuc/HaY34
	2p6b9S/S5iNEfd7k4wHWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794147777; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:rev8M1bre9kecFxPnJ/110pykWtWtD4wImCGcOW6NsDYxkD
	cUFz016tc1790WEseiYkSQROta2Y/sah216OIvUDkx7OYlx1CVPwA2UvZkQxiP/K
	u67cQjLjQ9+dN5XsL/FbFiE/dOUv4/B2qw4G6AYmZfuSn32PENym/to0/6fHjTul
	1uidy4daktbFAuM7fOhfeqWIWbUz3EyR9uDKMfHJyZIIw0DbDzms9WPjY060U4kp
	pHeVsCIQL2gPULK0kVWrLTDTNsZr1JLQUfYC1WFyU50KXCcVxFz8frZshuQyf5Vj
	VGWfyuVuF4fIOIQ3WUdLCOsQQL7eKUXOgoiacJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0kLRbMVsEm5LotXwHYnzJehhpAoO6fySlBkC1Y53QFQ=:38WaFZSMlnnR6BRrfybqqIYKvxpuFmMHf44pTN+EAS4=;
X-ME-Sender: <xms:wIXwaiAiQ9wX3T1RX9jNCSppwH-3M0FSl15SQuNJlv-iS92N_7TnSA>
    <xme:wIXwat7e2LB_b48ScEQRdU5dE2ArxPGQrC9FN0oqmG8tpDSL0JUZ3n__C-i6sRLxk
    zbX2no9ugu7oNm3xuUvjhhf-YzJRdXNbul8NFTCuwxLmk2R4kmX_Q>
X-ME-Received: <xmr:wIXwau0X8bgTcFURfiWS6MI5nwKjSh-dKgTv3JuXGC71hH_97hr49y1I5nB81N29DX-IpakrZCc2KJs1sab6ar3wppYu7tTqGX4>
X-ME-Proxy-Cause: dmFkZTGo3CfmNkGVcoCqQm+2xF5BgQTQHLEob89QGgMg/fmpPsx9Ba22YEWDsCMCAsJVht
    iPMwYglQfWngG0EQiTCIk1j//mHbmcbWVDR0k5U/uGGvuPWIdI5VF0QmVDi2K9omMvQXse
    1SsImkgs2/+NnGnQwBHgKzDKk3rdaZCpy9lOm/CBgsoPRaB2SL90jN/DpplvLkjqri7DRF
    34GZFZT6mx2KG6dtb3J1oKeeuxv77VarACJ5K9flwFuG4XW+zRuJ4up6S+R6m6RCgUFeXK
    suuZS7ohMrlLQBXad0P686p3sxTyrb8JLChbCEM521ZgNKvK+lIcmDaAFt7tO6sNGMYcXc
    ERWeo+bc0+cJk00Nc1WuHBj4r2aWD0sY5QgTsRBu11aBmc2RbF0NVzOMWi/ky0pLGb5jG5
    xgpLLBw69wEh56SbLbjxtuaNMIER9vRNau2PW3CPQL/xjo8klgzL7DAaz4BmHd/8yQrtPy
    8swXaLzCNR5u3LXhviVURghCNt0sRL3L42uaPEvbipWbXQYNzhcdOTwPzLuv64z0X7QsLk
    Y3NCH6ASQ/raumVNH1dVG+7ISJtSwu1FyVlVCKg5/Zbqps5Hhhq4OcwLlyKPR86tGOoKoI
    C2d7OuGoTfnsap6BU3lLGgcBxnL4l1JTRlR/rWTaCbH89dXB0QuHUizxFWlg
X-ME-Proxy: <xmx:wIXwapDUmPLK8OCsTVgICrT60ZXVfvOr9X9lXC-41lcbgm5vYsyLpQ>
    <xmx:wIXwauHqcYRwb8RNHdROFOHo7M8gMtAeOlUto46gIubJxYAjS8KSEw>
    <xmx:wIXwamSF1nc2A4uBmvIE6Ae27Fxe2nZ6N1knli7xnXeH6R3I5tybcA>
    <xmx:wIXwatP1TSQI06zPg_SmbCZPM5V4JcxASevN2qD3R6NGQEX4PtODKA>
    <xmx:wYXwapA60ATdUerfQmZyTFE2mWCZdwJ7rMnl_58_2FEyjOlM1rd6BdSD>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 09:22:56 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 15:22:37 +0100
Subject: [PATCH v2 3/7] arm64: dts: apple: t6030: Add PCIe nodes
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
Message-Id: <20261108-apple-m3-pcie-v2-3-0e5ffec71da4@jannau.net>
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
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6143; i=j@jannau.net;
 h=from:subject:message-id; bh=38WaFZSMlnnR6BRrfybqqIYKvxpuFmMHf44pTN+EAS4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPrVt31Z6tMtf8Nv+fH6/cos0TdKtK10gc+nYke9liu
 R6TZNU3HRNZGMS4GCzFFFmStF92MKyuUYypfRAGM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFRn+jMynFl/3c/I892aQ9z7lSbNXZkeGhvhd+3l9rTT03Lvz87Zu46RYUFj3VT
 jGe5r9mQ8kE7YW9Au5/lP//bv11U77A4HivbI8QMA
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

