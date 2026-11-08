Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147785;
	b=VGeHlR08Tns4bthsc6oxqlO+xxNU/BHiSa6GU0s3I7ouU+YaT5njGVgQYuW7rPeuJbbv
	 ZYp3fxC6tqIIWJjMpCgOWWhrlUDkSm4xNHnCKFp4aYQmsHWJZHAarFgEa6AOdvvRSmp74
	 zDmFeodok2mMJgC1BqRBFMMt+E0gnii31x5SbbRc/P3ONnFBKqDtaljAHJfKeGH+JerEK
	 RFZIdAK7Ut3d23F8oelzu5xSdAgXXThCgnAQYPdQxgkxV3BtQBJv8fir5FVauJ/llnBxW
	 N4Bee+QJiWpRnVCbxKjWKU9wbT+yS7E5ctNXEUtLqTddqemRDe089GV5H8s/7nG0t6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147785;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sy3GGXbiim14+3emT4jupITc5ljZwoqUwy2yBUcnLsE=;
	b=PQdUf/x6fOXoKYP611rCVEodbyiLlk840r0o6RozbA31qso5h0PP3BAZpZpAfc8ezsEX
	 ZU2QTGBExLajaHZHhTLIOmYCgarsh2Rvfwj48XJaybSBDPoVbEya3CuBj6ZK4YdbQGkmf
	 tK6s7+5x3nA2r1PGRvwZVJmsvdmWbvyXNUCov08SMr/NqtxKSZV1aKnTghr2cCXQTR1Cg
	 uJ2DBTGg45Z9hAcCAfwNVYR0uSIr+4XkPfYa1sLOlZX7TdxI2D7X16V5yk5Gt9RIj7puA
	 hyYdELHAzQfIq8wautI+OqSS3GgeNQLt9SOGWdlGTD8gQ7dtuKP3ElgCNz1bXbiyzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=P7wBufqO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D8ON+GoZ;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512D606EEA9
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2512D606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=P7wBufqO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D8ON+GoZ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E4FC1400131
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:23:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 08 Nov 2026 09:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794147784;
	 x=1794234184; bh=sy3GGXbiim14+3emT4jupITc5ljZwoqUwy2yBUcnLsE=; b=
	P7wBufqOpBUk6Ke08YvlIrIlH5udt6hHqIDgASBRkcZKQ/mdy+h9r1be4LlJUiyj
	OHHQdqOzJWSWn6TTCLPO/7jfZO0LWnWMeiAlfoi5YdTYItjc9jwEpEdlQAM5FxeS
	MBYly9iPmwJxX4mAiXSnVx4upqQW/Dd3edeNP6YJU3oHFvRBmx3F2WOgsEaenAn/
	u3AH4YpYoPBoH275ifwTxzwBNWQuXred2b03K+cLDg4Cc0ccImpPxdxlPui5DwrY
	KYaZk6d2EwXGQGLMiPlzZcmyGhnIfq0/c+udiagsZe/g7ghHk5YcFRtItPYB150l
	fxDKIORkegpOaznysOctUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794147784; x=
	1794234184; bh=sy3GGXbiim14+3emT4jupITc5ljZwoqUwy2yBUcnLsE=; b=D
	8ON+GoZi+Je8djjLbi2eVHPbiXV6DhfOOn3KexTn2Y2W0rkgp247Z2K7AacmIr2a
	7JTng6BidpURIeJw5UktOGOZBsYj5L31TJMyFtjLNLgwNZQp5wXzOo0s49dbxeH2
	rig5BxCO1VUXx53Ez0selqFx2bYtS5ZXWvxIcs0TDc/zPZcE5Fl5ZRJE2ZNKXKTw
	RPNtHoYK3CRw1wgdAPw6+ly3lwQ2XJM62KiClSMv4PTBlyukiPka3XxHmUbyXJC5
	w5V8LwqeBzL68T0/7rTuER+S0uQKWvV7bJs+gSVuGLFSnb5Fmq208qYq5+RfcsTU
	CE3ghBcZ30FYqyUFAudyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794147784; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hjCMv80kxf4wM6A4EJsD6LJZ0kbkBJeZXAye5V9Ej/i41HY
	l1FosxiX5kS0qgDDSAEUJxDtHroxxNV2OGDp4lugCMNewB1VrGs87NBPMToJNzRT
	E3uvMhGTdUYQ+O5sgSw3Y6xti9skkm5dvABHY6y1dWIdZZT/Qn8U3jvWP92fqYfC
	Ib4GgMkHPbdg8756QeNDAHQzy8ERxZl8rXHRsYECQy1WQCjV6zDFwjgfZ0cnqnvr
	SK7JfBQAO90kMS5Ievxwf3hOe02Z3DSfi+6Rgcq6prEiP/fkIsXqhq98L3Di2qsI
	AoWmExAB2FXHyUM6eaJTPPeZWC70aZfsXgZmo4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6u3X/x9kbVPujw5Uk7rK/S3zUmt16smiZtaWQWH6PqQ=:r0rG/WrZOCC1QYcD/cUXrP1oUDkkSB0W4xjAYgXMERo=;
X-ME-Sender: <xms:yIXwaubI3ZDWo9En0esClhJd9dqiiLyeozoqNnmF2vfsy9vLUjSv5w>
    <xme:yIXwalXtqzSTQTHnA7Ar0VCLT3RNmcMrGXKbganSriVKZ-Ig4BdlfvrcC9itJPab1
    DpOMHpoQmjDtbLqppWh1QUgQDbLLDgQrqQcqzwN0ReZEYIE9eu4pTc>
X-ME-Received: <xmr:yIXwatghwWiThFUlP3zvWBQMPsVyFIJZpqt_f1UsYEAR4A138q0BekkvRGOaxR4lCbjd7H29VG3E_uynt0DtXhHLSt2NZ7j7Ge4>
X-ME-Proxy-Cause: dmFkZTGo3CfmNkGVcoCqQm+2xF5BgQTQHLEob89QGgMg/fmpPsx9Ba22YEWDsCMCAsJVht
    iPMwYglQfWngG0EQiTCIk1j//mHbmcbWVDR0k5U/uGGvuPWIdI5VF0QmVDi2K9omMvQXse
    1SsImkgs2/+NnGnQwBHgKzDKk3rdaZCpy9lOm/CBgsoPRaB2SL90jN/DpplvLkjqri7DRF
    34GZFZT6mx2KG6dtb3J1oKeeuxv77VarACJ5K9flwFuG4XW+zRuJ4up6S+R6m6RCgUFeXK
    suuZS7ohMrlLQBXad0P686p3sxTyrb8JLChbCEM521ZgNKvK+lIcmDaAFt7tO6sNGMYcC3
    RZLn9/XYtFZgJSS0cPJ8yXmfha/G7VDOQF6DaezHzwGKzHYhuyM+8kOQkA59AWxNETtVKe
    EzbkCFzPYmMtyTz8XVn88G+NBbXiJyo96YxVbXtHLsmn2mCwpkvp5ZKuYpGql0Uiab8yUK
    FwPwRRN2sszuhmkzumWh2BQGVSKfNezPvSOac6x1MAv40rF1/sCj2ogFdYMZk4o3wl3imn
    dCkCqWDS5szo6gYA8WBJkMz2BZ1CkxwC/oYMjE12245xeVpUW0uu/cl78wHNqCC+GylPsn
    dfRfY9Arfa9i0r4cQiFNBYdrWUE6oeOSJMB9GsojDrIdsMH2Q7ftPzwElqJA
X-ME-Proxy: <xmx:yIXwaomCabdsDFw_dvndzQNxUREypcXZKNjlaxeCGnMOMBk_73AS-w>
    <xmx:yIXwauwHYxxWTdF80Exqto7jAedSU1bFewXRFvGc-HyFN4daOllMlA>
    <xmx:yIXwaru5x7Y1E5g7In6aujeNh4mHlO_wQm-0kNkPjHl0YZOcYY2_xA>
    <xmx:yIXwartOAsslzalXbZZQkc8i6qoEA_SHL89AEPB8vB3Nopv03Yl5Hw>
    <xmx:yIXwal0K1jHP1jEhSGDEl_mcjm_AJDRdpXu7i2skWeZRxUsox7BuevAf>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 09:23:03 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 15:22:41 +0100
Subject: [PATCH v2 7/7] arm64: dts: apple: t6032-j575d: Add PCIe device
 nodes
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
Message-Id: <20261108-apple-m3-pcie-v2-7-0e5ffec71da4@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=j@jannau.net;
 h=from:subject:message-id; bh=r0rG/WrZOCC1QYcD/cUXrP1oUDkkSB0W4xjAYgXMERo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPrdt6lOorT5Xvydos/KRg2sp5L29rFe2LyNr4fdpzM
 fcvliX6HRNZGMS4GCzFFFmStF92MKyuUYypfRAGM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFR/PcbIMOWWyBK9gLlbeJoOT7k/cbrWvmcHXFenf324vu+Iza6jOxwY/gqF7wm
 QrpZW5JcUFb/HKnjg2FnhGULTviz/Iv2zMZYhhgcA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Add WiFi, Bluetooth, SD-Card reader, ethernet NIC and USB xHCI device
nodes for M3 Ultra Mac Studio.
The bootloader will fill MAC addresses for the network devices, add
Wifi and Bluetooth calibration data and set "apple,antenna-sku".

Signed-off-by: Janne Grunau <j@jannau.net>

---
Changes in v2:
- fix copy'n'pated error in WiFi/Bluetooth PCI device compatibles,
  adjust to BCM4388 used on this devices
---
 arch/arm64/boot/dts/apple/t6032-j575d.dts | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6032-j575d.dts b/arch/arm64/boot/dts/apple/t6032-j575d.dts
index 12991546d4bb..902fd90c25a5 100644
--- a/arch/arm64/boot/dts/apple/t6032-j575d.dts
+++ b/arch/arm64/boot/dts/apple/t6032-j575d.dts
@@ -16,7 +16,10 @@ / {
 	model = "Apple Mac Studio (M3 Ultra, 2025)";
 
 	aliases {
+		bluetooth0 = &bluetooth0;
+		ethernet0 = &ethernet0;
 		serial0 = &serial0;
+		wifi0 = &wifi0;
 	};
 
 	chosen {
@@ -46,3 +49,72 @@ memory@10000000000 {
 &serial0 {
 	status = "okay";
 };
+
+/* PCIe devices */
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+&port00 {
+	/* WLAN */
+	bus-range = <1 1>;
+
+	wifi0: wifi@0,0 {
+		compatible = "pci14e4,4434";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 10];
+		apple,antenna-sku = "XX";
+		brcm,board-type = "apple,aruba";
+	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f72";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+		brcm,board-type = "apple,aruba";
+	};
+};
+
+&port01 {
+	/* SD card reader */
+	bus-range = <2 2>;
+
+	mmc@0,0 {
+		compatible = "pci17a0,9755";
+		reg = <0x20000 0x0 0x0 0x0 0x0>;
+		cd-inverted;
+		wp-inverted;
+	};
+};
+
+&port02 {
+	/* AQC113 10 Gbit Ethernet */
+	bus-range = <3 3>;
+	status = "okay";
+
+	ethernet0: ethernet@0,0 {
+		compatible = "pci1d6a,04c0";
+		reg = <0x30000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 00];
+	};
+};
+
+&port03 {
+	/* USB xHCI */
+	bus-range = <4 4>;
+	status = "okay";
+};
+
+
+&pcie0_dart_2 {
+	status = "okay";
+};
+
+&pcie0_dart_3 {
+	status = "okay";
+};

-- 
2.56.0

