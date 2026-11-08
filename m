Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147783;
	b=XHnQVt/4SGVB9eQxKGBSXdWo6/RqnLc/GxcnJ9DSe8y3/TScgbQ/42k89ZffqXKgzhIN
	 J6X/3ld3KrYx5qKCcThXjRE4slicksYAPRdOi6M9MkL+wn7IFCY0RW0/vBhsmeOjl0mUX
	 LMUaL7Yv427mjlqoY1Z2hhgHqqo6fbfNveMvtWkKHSNUeYT0U2LbLoxxsTg2rSTce0mpK
	 YAymz+I0YPMPO2fzNr74W03A/nmzv7wxmmi+/GxLwBZV7e/NNajyM4bkSv2VdVAnrdSkQ
	 e2xgq0NlCfUvjGr7acne74fiCci0CXuB0kIBDHObToohVMPuoY3FLUatCjqMNMg01yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147783;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aI72RnemPfgqAGvAnqPYoxeIqdUZbHxOjDefy4jubv0=;
	b=CwXmRDWdyvDz0zmSN17fG8Xzy4KIoN4hzVFJ6T9yaq7/WHbfbKENIrpncKaX4B/d6qH2
	 pNo2KX0DHSJUEVLEmu3tRWGnPjTAJMz83munXoyy83uGDyuAwlBVI9A49Vtyy5sSqznY/
	 GZoX/V9okOxOA92iT1bhmXNz2j+tKB4vAtzPT5xjC4folJEQNiIp0A/QB3qJOS6EvoK0m
	 I1bRHqxngqJzU5q7OY+1jSQeAzUrW6uEIZvXVTYVJTHR17CujM9XhGZDUalTmKUfLqFIQ
	 dQaOuoUKccK2dkpqrMKuC16V/iKuUaMHI/nJwiZI/QOiS4W8xyS+bn9uxdvWjh+Njww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=JZ1scAon;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TVnBRbOf;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B48606EE8D
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B48606EE8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=JZ1scAon;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TVnBRbOf
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACDA71400081
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:23:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 08 Nov 2026 09:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794147782;
	 x=1794234182; bh=aI72RnemPfgqAGvAnqPYoxeIqdUZbHxOjDefy4jubv0=; b=
	JZ1scAonkokh3SB6QqYoJbNE/YYlg0gyOPD9kh2Ka2IX6HL3V3XL6zgOm+Iwff4t
	oVcUv+eOgGyGQmZu2FnWE501Wp7XBh6R9RFelb3/8dQMUFwe1kPOSyTPdDrdJUHX
	dlbbOM0BCiZ9CEOw4xyLpwLcA+V4V0CTlxnflhTlB8mMZHCfGY2MMiZo3rsJVbJv
	+cAUwGdT13aGkEER9Gn4oRToxmok89vptHacqEptM0a5zhl9pWTVEdrfMM9hXCDt
	8oBL5zjeVLeDrxYR6bn5uif99B9qJPYnZusWHfY+a17AgfuSc6acmPP+aXaxLeyX
	MQxpCR0ruXEWjW0pI8+E0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794147782; x=
	1794234182; bh=aI72RnemPfgqAGvAnqPYoxeIqdUZbHxOjDefy4jubv0=; b=T
	VnBRbOfmfY5x6jwJ0tB/DGpPpcU/IiHHFNbgfk0+GSqirvZ2k4BYFcgzJ0Lua/K5
	n2xAJ3zqVKKB8Y58yOadDaNZAnwFW7r7lhTuvx4yq0HH3HZI/VFWplY6t5R2VprA
	byeBm0+ScjcfFLvXWpewWAaDVaEWZnpSrx1tuEQIrmhSOR7Lrqw1iRx8yH7IMPWS
	1JIN/HX5J/8wjDb0xS9m0uM5f/KXppg1eUpETWb6ojkQnndRfQIXL5Wr4V4Iz3MY
	7x2pzBCgZY9opV0/cLPjTBDMRXkQEKeqhj1SBUeLm/qtDIHOheOkLizThC8FB68H
	MvaNInyX3gxApmx9sFkTg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794147782; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UE4fq7OG73/v8VwLmYeNiHAEAC+c75oO8I8NQX7fx+O3DWK
	taEw/bGsV6juYUDBc7YyLcRXbBItitDlRpU0mTeAKa7tskiEqkLejkcbc/HpHlxd
	qhN/iKqA2I507CxM9ehQWtraoQpc/zmlY5RUkxpKyxP68WwrHvdoS1L9bHMY6p7e
	Ot4PYeCAEj1fr4jmRp4whBMEmFwv5sBWftWgiMAiPZ/OrOJm/+TUh69fGdWI3L9E
	DwqweR41PGhmEKasOzwaGJlMKEz7NYoHEng0LCIfSJrAbNT/xoCGj7ovK7KRosW2
	coBtuggb8vIiag79mnvrBeonMxPrghbBNk51S7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7VU4eQGgYYPPvcgfjzyscnmx8tobKf1dArdkuzn9Yw4=:A79coCvVOs+xrKvBa3dJDJwY4bxLrS2yHlD+ojtPLBU=;
X-ME-Sender: <xms:xoXwal7rW2LNO6b4X9Jn8RKEDMtm1Y237RLO6YRfLi7YxltIepE60A>
    <xme:xoXwaiLj9xlv4eCjcoFR0fPr2MQJlWuWbkWfK5bZw0-Su7u00LbQV3KMkYj7aKQ2H
    ktS8lDRZKC1--XefFWPSeCDNAbr7ZS2askx5RdtZMa5ICR9UAED4KCp>
X-ME-Received: <xmr:xoXwavQ1U758X6kHP7rhEEkLP8PnO9iSEPEABm1MHvBoXJqPoGYgHBl9Rb7W_fbS34oIaJgYqow80jDrjWhZzDjKkePHCutcBMo>
X-ME-Proxy-Cause: dmFkZTGr97Ugm4Lw1uWXHAbm6vRQHHSmAZqg2KlP2XDjPoWUO2WE9ZVqibkqMDFgtrtYNT
    kOKLbnHGHpAeLNXsjow4Ek8AjW6sOl6K5SWu7rEUwrJH+TTVpXNtNnbLtAHULtMfHNJM9z
    UQkgKEDeRjM8mqPhmdAZGHoglPfNAkXvvBaR5O6MNaA2F1VW8O5csGZOQLgHWVq0XXisTM
    xRvjAdA+Y6CWc7X4i8dqhChIWSKlUSUab2PioslGdN07uWERgEvY2tSy1LGUtzlrS2r3nP
    D2AdjHjPjw7Hipx/uwNmqZEdKCqoahm64FXcFjIxhqlQcFTlLJsrlw4OTpChRBR1+SPNpo
    HtftMjYQbV2Ff9bRnbyRXipvtMInWDyW+eU2JlMKndiw+/HLkj8/7FFlDvXWFYrcKSkEwn
    OEEhsgfTll8a8zqDD1/QgUeOAWZF1cPFoSG933VTEmjkUckVbF9xwiFtnBACQLsh6ixTY7
    AROR2G/rOgli/ZtEoTb3LLWP/Z0btahoHfPxgSfV1qKpFb7zhIkCxBxwXv4xVKH9IVHb++
    sRRtloQP6Bfwu4WJTmqqB9eVS8y7TGqSZMyuzlysj7yRujrb4006F63xQZQ8eTHsR3qLs0
    NIR3UxVFB1awNTaIg3LfvcrwuQ1QOKlJW1pZ4AMA/RfaJfvFtyAtciqwj0mg
X-ME-Proxy: <xmx:xoXwaloIqZ0XcKST9Btpxy0nOYtXxa0KlUaweGLPhuLC-nZpaqtTdw>
    <xmx:xoXwatayvfC9TGH0e3052sHp14jxGRjGk7Dfs-S1XZ0VGtkY5lVU2Q>
    <xmx:xoXwagS4vDxICkeJsxjGQGO8t7PUIbDwVkXQy3rB7FS7achP6F8kOw>
    <xmx:xoXwarfYcY5pJQFBqjt5MOcpDIkFPpYqRbtCL0BD0cqImyWzcFv1zw>
    <xmx:xoXwait-EyrY92Jt88K4SnrGe1be7ExpA7WMTnqM5iNWr75JKwxgHP1u>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 09:23:01 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 15:22:40 +0100
Subject: [PATCH v2 6/7] arm64: dts: apple: t603x-j514-j516: Add PCIe device
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
Message-Id: <20261108-apple-m3-pcie-v2-6-0e5ffec71da4@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5268; i=j@jannau.net;
 h=from:subject:message-id; bh=zkIhhD2NmqoYf8eX5nIre2dd31NDDPBOJDfauDzHwj8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPrdsS/imx7i/K19d87brEs9/a/OEvZ3Yl/en52g2sg
 arae493TGRhEONisBRTZEnSftnBsLpGMab2QRjMHFYmkCHSIg0MQMDCwJebmFdqpGOkZ6ptqGdo
 pGOsY8TAxSkAU51VxvCHj8dj6wTf8BfblH133zbeIfqr/af+99+9Hhr2M//nlOt3MvyvlV1TERY
 +79+iOTxTlwUuZQ6bNdWsMSJiR39NPsMu87uMAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Yureka Lilian <yureka@cyberchaos.dev>

Add WiFi, Bluetooth and SD-Card reader device nodes to all M3 Pro and
Max Macbook Pros.
The bootloader will fill MAC addresses for the network devices, add
Wifi and Bluetooth calibration data and set "apple,antenna-sku".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
Signed-off-by: Janne Grunau <j@jannau.net>

---
Changes in v2:
- fix copy'n'pated error in WiFi/Bluetooth PCI device compatibles,
  adjust to BCM4388 used on this devices
---
 arch/arm64/boot/dts/apple/t6030-j514s.dts      |  8 +++++
 arch/arm64/boot/dts/apple/t6030-j516s.dts      |  8 +++++
 arch/arm64/boot/dts/apple/t6031-j514c.dts      |  8 +++++
 arch/arm64/boot/dts/apple/t6031-j516c.dts      |  8 +++++
 arch/arm64/boot/dts/apple/t6034-j514m.dts      |  8 +++++
 arch/arm64/boot/dts/apple/t6034-j516m.dts      |  8 +++++
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi | 41 ++++++++++++++++++++++++++
 7 files changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6030-j514s.dts b/arch/arm64/boot/dts/apple/t6030-j514s.dts
index 3ba2c9ca4347..f7c1307e76bd 100644
--- a/arch/arm64/boot/dts/apple/t6030-j514s.dts
+++ b/arch/arm64/boot/dts/apple/t6030-j514s.dts
@@ -20,3 +20,11 @@ / {
 &framebuffer0 {
 	power-domains = <&ps_disp_cpu>;
 };
+
+&wifi0 {
+	brcm,board-type = "apple,texa";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,texa";
+};
diff --git a/arch/arm64/boot/dts/apple/t6030-j516s.dts b/arch/arm64/boot/dts/apple/t6030-j516s.dts
index ab07bf7939ab..9f9609575ed0 100644
--- a/arch/arm64/boot/dts/apple/t6030-j516s.dts
+++ b/arch/arm64/boot/dts/apple/t6030-j516s.dts
@@ -20,3 +20,11 @@ / {
 &framebuffer0 {
 	power-domains = <&ps_disp_cpu>;
 };
+
+&wifi0 {
+	brcm,board-type = "apple,jura";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,jura";
+};
diff --git a/arch/arm64/boot/dts/apple/t6031-j514c.dts b/arch/arm64/boot/dts/apple/t6031-j514c.dts
index c1507158325e..8cc2224ee0fd 100644
--- a/arch/arm64/boot/dts/apple/t6031-j514c.dts
+++ b/arch/arm64/boot/dts/apple/t6031-j514c.dts
@@ -16,3 +16,11 @@ / {
 	compatible = "apple,j514c", "apple,t6031", "apple,arm-platform";
 	model = "Apple MacBook Pro (14-inch, M3 Max, 16 CPU cores, Nov 2023)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,texa";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,texa";
+};
diff --git a/arch/arm64/boot/dts/apple/t6031-j516c.dts b/arch/arm64/boot/dts/apple/t6031-j516c.dts
index 841b2bb10b06..5dfe886d47a9 100644
--- a/arch/arm64/boot/dts/apple/t6031-j516c.dts
+++ b/arch/arm64/boot/dts/apple/t6031-j516c.dts
@@ -16,3 +16,11 @@ / {
 	compatible = "apple,j516c", "apple,t6031", "apple,arm-platform";
 	model = "Apple MacBook Pro (16-inch, M3 Max, 16 CPU cores, Nov 2023)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,jura";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,jura";
+};
diff --git a/arch/arm64/boot/dts/apple/t6034-j514m.dts b/arch/arm64/boot/dts/apple/t6034-j514m.dts
index e31bd0bc0592..dfae771ec626 100644
--- a/arch/arm64/boot/dts/apple/t6034-j514m.dts
+++ b/arch/arm64/boot/dts/apple/t6034-j514m.dts
@@ -16,3 +16,11 @@ / {
 	compatible = "apple,j514m", "apple,t6034", "apple,arm-platform";
 	model = "Apple MacBook Pro (14-inch, M3 Max, 14 CPU cores, Nov 2023)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,texa";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,texa";
+};
diff --git a/arch/arm64/boot/dts/apple/t6034-j516m.dts b/arch/arm64/boot/dts/apple/t6034-j516m.dts
index 4d6513558597..dc5c202a787b 100644
--- a/arch/arm64/boot/dts/apple/t6034-j516m.dts
+++ b/arch/arm64/boot/dts/apple/t6034-j516m.dts
@@ -16,3 +16,11 @@ / {
 	compatible = "apple,j516m", "apple,t6034", "apple,arm-platform";
 	model = "Apple MacBook Pro (16-inch, M3 Max, 14 CPU cores, Nov 2023)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,jura";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,jura";
+};
diff --git a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
index bbee373044f9..a3e4e5d734c6 100644
--- a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
+++ b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
@@ -21,7 +21,9 @@ / {
 	chassis-type = "laptop";
 
 	aliases {
+		bluetooth0 = &bluetooth0;
 		serial0 = &serial0;
+		wifi0 = &wifi0;
 	};
 
 	chosen {
@@ -67,3 +69,42 @@ &serial0 {
 &fpwm0 {
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
+	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f72";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
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

-- 
2.56.0

