Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878593;
	b=Ny9X/JMIN2LL2Pb/r5h6GNFfcTFaVuVMNH6a2CYALv3ElSt3xCOFzs9H+e0FtHBfKO0A
	 w871Pcd8jTA63zwe5kKy5JN4N5a/onIdVGf0FZJtGRt2esRPMiznk7pNXjg07K/nenq6v
	 2ulVz1iBsA11kn/oiVznJi2CVZ7gBfVWJ/G/BGTKq/qLguIm4ko+Hj045Ncks2dfj5O0F
	 WZZAh2Zdi93LSKqqiEfWCshbyyH0+hafLqRrI7RnwleBQR8MuPeUThGJ8cZ0NT1JrSK93
	 Y4zIsqEFNM68jG/edVQZY9QSZ2I/247X2LSsRDUNeYtNJn2oycw8J8SuvJrWPJbESEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3NhPpUUiBx8/fTcqcZZZh3J0CctL/rOpbWxqhlr3k6w=;
	b=UtwtRauguVqhi6FUs39CXiObHYLiBaOAFP1AvS81o6qyJJkGidZr3Hd4b7lGkQvnlDmC
	 Em88u9mote1lU0hyAaDKo3QMvkfRd/v3eJRuCGgGyWmBdwCPojMJbG+46JcJmoUPFMQt7
	 nTMxzj08QykHTyVimcIY4wAcx4r1uPPqx6Zn/FoUd6+MpV3i53lXJ5tk1I6aDgLGQiGa2
	 /yvWVkTDU14jBD/Y/M1GhKa6k57KSJzFuhhiJNX7HGmE3v++BQ7qeMfLD8TkfRdxAmygs
	 k51h8A8UGf9uQJdodC8cuzCRo0t7jk7iEWu6EOxqHh8PCjfnc5IzJWNNJZEreq7gyUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b="t8/U0tXE";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nN290CcK;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F4606A32D
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC2F4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=t8/U0tXE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nN290CcK
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D2CB1D00169
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 06:36:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 06:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793878591;
	 x=1793964991; bh=3NhPpUUiBx8/fTcqcZZZh3J0CctL/rOpbWxqhlr3k6w=; b=
	t8/U0tXEVszm1F9kh3HAIjo8DuppJuNQE+0Jmmid/HO4MBhvSKp1RR3vi8UMCpZn
	9+tevS1U0lM0pNP9HvEPJOk1lzJym0Y/2ced4Qd8xGtexpHbzSmu7XQBg5H/Ien/
	GycJPUx0x2tRZQJH567ifKq/znwA6lR879cQVp3Cn6F1fVJx7kkpWIBbQySnxgNl
	Vuk98Jno5qYZCjx8fsu4YUhRMe4JsA7U22Msi3D/TFI/suXYmTHD5MP/ntfDu1tV
	EFNXa8hYtbJqrqIkqVx/wn93BLpVpEKEkqB5nLPdq7Kk+FmGUj9lRBmLt04AeMWA
	0hmP/sPqGt21gxgJ54Fhwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793878591; x=
	1793964991; bh=3NhPpUUiBx8/fTcqcZZZh3J0CctL/rOpbWxqhlr3k6w=; b=n
	N290CcKnC9topvteDqAIu7Nl3Elx8LhEMBycK/buXwZM95u2ASS0d1ly7Wgd7P5/
	0p1L9UENnCsjAgcLYVatgI2APsXtR7UrNy9Lg2Pcvl7sEZbkTXflETyTmFObKB9E
	kzGIx5NhG5b88HRVzASiGP4Sw/AUjOlCgmFDVofVBTP2OvdDc9TXy2DXGdBmGOYe
	f3MRpo6/3zC4ar5a/duZm5wm57XcI/a1+yS7xUeqLEhEWd3o6RiyuqAjsT1YLjfG
	tFzLAi40MDJ+fhX11P/zOqIq503+tttYDNJ6rXt1AoNhuuMpS9jfUG4AwAiDN3uP
	Ht5Vl6OZJBiN6exwlFQXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793878591; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mchUEOOYEMT3jh/iYW0gYPnO2j2s2C6brh1rA+4KmGJ2E9+
	t0fVkVXf8+xuV1rgJTpEr+xoUmFjn0jDvF7Pen6ymNDffWOZl3lL8jL4ugwxUkMI
	glh8DH5tpVwEGLxfrJFvTA034I4ZybsaP82GgltaqyTzx6l4nPHLy03JAhrEyxE+
	lCnZavCvzfNqEWcMl6d74L5+VhI994pQ5xccKOYAyauUfIe2bxRi1/qG1xkc2vZr
	x6octKv5TBe7m/yZ6odDPFjdMtb9cjsTkum3aSpfEqOhh/FiL+A8HPnksjeqH+8j
	MfHhSWReNkWHmxadEwaJC4kCJeRSzYRFS0+gdWg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UhPw4TGWYtY/Dd3GcJ6OxecX2keU2+wo3Y67nJtI2oI=:kjuk0kiHKUVKuHCdCxiQPDaH9C8FmP0elq5OqHT4UPs=;
X-ME-Sender: <xms:P2rsai9-1XLGlI2UtR275kYkXX9J2AkFinkBCF8dojpWZSjAdlFdiw>
    <xme:P2rsah8sT-7JIqtGcnSr5tGdHnbfXUZM4Hv1q3hv8Y26O7VJXo5Tqo-KsN4WIQKNP
    OKrbYAxuPSr5y56Qz0KFBTtp2Mf4vqT4Mft0DEn7O3Z8sRG7O4Bj8HT>
X-ME-Received: <xmr:P2rsaq2XTEKnTKbonYClQFFQ8ZXy8hl5BayAAOGNQDGVnt7kBMPXGgGF7YHzQTeNSscsJUPGB8WjCnFEboM7Rb8urMt9wt9Hkik>
X-ME-Proxy-Cause: dmFkZTFiB+Ef/4hhUELr0xJWI4RLreggeb5lOnSYygbUpmh2w1HzCIgOWn5JqSrKHbnJF6
    Gu1E5HEoFycQcf9fEZZQ93o1mpIX6EUiid5vBGRrjChidySlNGfqHtpNB3U8jUEiqhLfm+
    6xPvXbkcR2ibvNg4OOVM6aiptmnj/TBjEYU3MAKCpGrhxPUrXjXMmo51E4LLG/ceVfW8Tr
    4gql17P4ewfgE57dF++9gDAvlAmy04Q63lix9EUpqSjLhUwBck5DsW/uy2pq/U97T8ijHs
    +ZwSFDLQaHL0/V88gw6RsuWlYcPx9Yr/hGUZyb1Kz3jC9+2TNJOFxe7HAtdL+9BuLuBcWX
    3/B9XldzfQwx0pOLgLOfFa5VaCVUhA/26gFBAtIE1H4XYnFJKj0Tqc8WxwlsXTsk/yCH3U
    J5RJHgJXWqHfAV3YTzoLy2hfJKyV+La6Ouhw05iMYPGMCtjQlofFiHjEE6MPHHBIp/AT5c
    uy+MoQmWSZnziSJuHiaUUG9MSyuNt25a1WyU0v56bbfNmWNNmNGDqMuewlyCUGsKUVZQvW
    QgzPE+FE5tkGHghoVw3aTsMk9gx55G7TLm1oGEtP+DAD5NxJkfi0hbgA8C8lF61aRNK38T
    bgwJ2VtMaZwlBNgrSndtorbJv+JwTKFco0R7RaWSoHB5bhcpL2ObyPTIVjjQ
X-ME-Proxy: <xmx:P2rsah_aL2ERCYUBo6RBhXTBcrYCFKwk4vDWP4zSHE_Y82QjAV2Zxg>
    <xmx:P2rsarcBOInO47oXMwonU97dr_IPDimim0E4fmRbLQkIOVhu-5vSVQ>
    <xmx:P2rsatFzGuHEtzr1AJpBC6MeBmJpGZPv7V_FqHnFA_vEYjSfRj3rbg>
    <xmx:P2rsagD9EKidkJjXefj-uycZ6881k3j__Z6nvbL6pMOe6XseAvpGkA>
    <xmx:P2rsaqQkJmv-SiqAojoLoSeQ0qrztAerPP_0yDIfxAPMvVScpWBrQ54O>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 06:36:30 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Thu, 05 Nov 2026 12:36:01 +0100
Subject: [PATCH 4/7] arm64: dts: apple: t6031: Add PCIe nodes
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
Message-Id: <20261105-apple-m3-pcie-v1-4-e00a72a604f8@jannau.net>
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
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Yureka Lilian <yureka@cyberchaos.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6804; i=j@jannau.net;
 h=from:subject:message-id; bh=x77/1VYiLOv5Z/RiZPfZfLJlhGGqM59JzKpcO+5IWaw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqw3WRql19y87+SrdLPteN29cU5/wjXJiVsmM8v9KzwZk
 G1UeL+qYyILgxgXg6WYIkuS9ssOhtU1ijG1D8Jg5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmOrrSxgZXv051ZX4cut8w22Wpoy+QTp/tHXrZRWVi6977CzpncvfxfBXIK7mDPM
 +/RVMGyNnif5mmTZ/T1/pxXlGH7etPnR3TutvVgA=
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

