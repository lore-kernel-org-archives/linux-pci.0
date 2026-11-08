Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147781;
	b=n8ocvm9sctwqtmObuxlRZgwzuzI0PYi5/LG0/KbMveF9kd2+Mc6pG2kQIzNIifF5iGKt
	 LXsKthuC244t6ohVCfDrl0lP7tgSBNIMxzuxymmGd68T6fThNfvR3GCrelQqlYHXJVEZj
	 afEQbs3D0vlgNLvRWbvSPC09pR1/eZfAg5sgXP2R0wZV6sme9qs/t9K2weYQp/gmudNmV
	 sSc0vqdAZEt3BwwCnmEymnI/WTjW50/nUnTV5zZoXOuie1k1E2XPN6pEl+8udLkcUDb4z
	 +kg5Y+A8CREX725t12fMYVptFl9c1zhDPtPyYh6xDPgT7Y4K8inlK/F+EYbSkZZBPBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147781;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WK0NkUOTRv8s5/APUMAy4zxliMrv812rU6CaWplx828=;
	b=gTXBJ7jbIM00s4oInk31I6bMJKylSI+PDfdxTY3Bs15SDkzTlXFyuJhMJ1JPy72rc9c7
	 B+G4Y5+GlURSaSHlh5q2mf6XzQXNhlJrbcwnr4NqRJpCkJ0FEgM96R0k/olCkJLAByr2l
	 gE8Pr0JxCAdzlesa9Bbdo4tQkqSdG3vqBLJ4fBiTdVCISo3jXbBkrNAc2oEsr4JR6ng4N
	 rxhbGgpFM81bbFxqsjyFF330WihqKMrWsMZlHH+q29hgrLUBSjkdoOI5zmtcVVuo2hSoi
	 9/hTI4g46AuguexR0rGTy/2g7l2H2ee0j/1uMFwGrCHUv6gF9IgWtC2AGY1knMirC9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=B93Ii0uL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fj8yWokF;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B08606D838
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B08606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=B93Ii0uL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fj8yWokF
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D150EC04C3
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:23:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 08 Nov 2026 09:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794147780;
	 x=1794234180; bh=WK0NkUOTRv8s5/APUMAy4zxliMrv812rU6CaWplx828=; b=
	B93Ii0uLg1lwyrSewZ9eZZYf3lRN1sLFTlVT5Q89ztlsjxHjIoKTV5tBCF7l++03
	+tIyplBt7pbJedu3aN5LjNe5ao8/0sQJ24Vtq5yWSzfsjrnzu1up3rBMpggj3mb/
	50JtPeg7HK32qLiqFoRkaMIHipokKRY9xYJ4fwh2ngxcu7fLyMUOhwtapxbILgnk
	Floyykrznb5EJc8zTglWXq698dMLNANe+tpbRi2J4AD1r8b2rq3YvO0NQD3qJGXY
	7UJNFx6vW5hFuiqjxYJD4hUg0KY2HUmKDeRKoHLMJq+Tx1RQT6KA/YL9iip3VJIi
	ZZrCWnSaQZMwSOPMyDShow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794147780; x=
	1794234180; bh=WK0NkUOTRv8s5/APUMAy4zxliMrv812rU6CaWplx828=; b=f
	j8yWokFkLGUDw5TbGImfh+xLGfNESFI26SN2pVnISOtlTUqsLTx70QaaN9Lo0PHY
	fKnnQz5D7zRRbO5BiM3su3eCfi+4JOXEfpumxkyT/icjGYhmUp/7pOi2KgRvGigu
	b9+A5adV/wmg24aeM028t68EkysJNK3mWavj0VOlAsV/3CDfLDhW6F/UBJYOOg2v
	0IxjQIulDn6R4Vm/yGIrkGpOzWjy+nqIINetQ8ITxuS/PCOp+HU4peBxQC35B5AX
	lBZQ0PXsETDD/z1riUM1xeeVuuJYE+wXiQV52jgH2yqifZrklmJR2qGnmOR5fFU7
	4ytdvlW3ba6Z1nU/rIuGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794147780; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jHVetLCLeVhWxG0gAgbJiLUZKehbUaAXlY3RarvbbMjTYjL
	YE8HH8SzZDDSFP0SpIUmq3/gOWvqpar1Tpm1bSjVH/GDwlF/lJejXUj2SuWXuyX4
	TbXGVr5E5DaMmDooNrbZWcPKFWZYeF6v/h2cZBX9zI2WpJdMm9S0pfKMWBzc930t
	yOGIkQraxiefYRKiiQvTvZiAQePMdjR2XDDGzTm/Ujr7nzlwuiqcBKkQLITEYLOe
	7pT8Ua1C7QraLEhUehuCM6ePdJ2OxNyP1PBzzV8W1H5f5twvklBnUnQf4Gh6y7j3
	j1jY9Q0TXkLx99V/Bp99UwAyvfyvE/LiYGvY+CQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oYxLZMYZen+tUCH5UjFJ77P39tL3kuqVGODwJKDxggM=:NZQbBl++Pp7SMouqKWUSJWHwErySawfccycfBwLrK+I=;
X-ME-Sender: <xms:xIXwaiLOYJzq33FPi4lWGAWQ_rAHTw6rfk5d5b-cnpSCTSBjeNwyKg>
    <xme:xIXwapaIeDaDPONczba3FAhzy4VT7GqNa5v5rDLOL7SK19YIV0XEom3HBiBqipaJW
    9ujd32BC1GcpwNolMWROGTpxEAAVus4nzO61A3PKyX9mdvfOeKMcko>
X-ME-Received: <xmr:xIXwaljgr5QIfle2S10uzSGuUYxalzhXQEmI_l0-cd_FhcT2y9ZbkpJRssZ58F3ES3LQvMVZr-1BLy33a-eUciUPuXmR9F2asDE>
X-ME-Proxy-Cause: dmFkZTF/4np9WrxrsknsRH5mltw+17GTLhVtpGeJgUgrmsjRqfN8hrAbvdhFiFpLvOYTXl
    DuHDQc9mgSkcC90pYTEAyhekymqCifk8aAMhnODJoNlhYUKo0beXirnRZxlSxQ/2I9OgL9
    xk6kmZaYqEdOfJ8HfIxagYR9ET/6cFiAiuPzbUtuGLcpzAtASXWHvfXk0k7Y4TUAp1q38h
    N8qPRJS/yKU9GDYEW55v//QQ8Wv/Fb3WCveNnyS+6YG720aCSLmRrSAcYvhmr9SIkAAJUQ
    9Au4OmQM2BEsvTGA5DbZ3cMuJKSv6cT9cCqL33ua9z8lZukdN0coTeuJrKEvCwAuX3GlWO
    vMI4CkKMYfuvz5hZIP5fWontpbJ/Qsy+gWq9Z794puVq/C5Gh20yv4Zbv9a9OjtJYXwLT3
    32WBBgkTl/VOuaEWWoTOKFb/mCk9fysB2v8LLtvHWX4QqtLUboekkBBvE6Mosb67I6C5tJ
    SmUknqyKvoUl/6ccBaW190kpdPujlcYO3aV/1AZD9/7T2kPuM00f3yueSgknhDqfHhRwKs
    /RQbh9q+HAmsy7UhEgX/vZefbz/vLnsF8uWdA9SRv6s25kaXLcqkQet2wkRrvE6hv8jrLk
    HX9oc3xUnuQBEM2q7PXpla3OSpscOQABa41TYHi3i92E1Rlffx4uRxhqC4lA
X-ME-Proxy: <xmx:xIXwau5sY_A6C8Y0DWD4yFkNGjct6EB8C-0wiSeUCna-SUgQ8d8-wA>
    <xmx:xIXwatp957BID-HTSVu1k_-ftFPNGafb3XDEtXrSTT1RJvwp6CkFCg>
    <xmx:xIXwarjAnTqkP5Qp6yfiPmzrS8zdXs5UH1EIfqE_5WnV1weAoBRxzQ>
    <xmx:xIXwaltFBPPwkSdapBgy4kVy-ylj6Ze_mRlD37JTRWJJ9JXAbHAO8A>
    <xmx:xIXwapPd4sjzyvWtFOkUBNbANyCfoZYyndQYBIcvSkkJaMJDsPGcosOw>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 09:22:59 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 15:22:39 +0100
Subject: [PATCH v2 5/7] arm64: dts: apple: t8122: Add PCIe device nodes
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
Message-Id: <20261108-apple-m3-pcie-v2-5-0e5ffec71da4@jannau.net>
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
 Alyssa Milburn <amilburn@zall.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11368; i=j@jannau.net;
 h=from:subject:message-id; bh=6VnD2O3unzh18AVoLbGUnllQO8vAvLOBJtr9smydWkw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPrdtk9uUebrK6Hrn++4l2obVGPLMLsqZ/l7gl58F7e
 5+cn4B6x0QWBjEuBksxRZYk7ZcdDKtrFGNqH4TBzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjrGOkYMXJwCMNX7SxgZTkydISjL0XmpajPfb53PdR2xfi87v6gLCETxGuc8NvC3YmRYtVo9OVp
 7z1bxKRretZvb/VU+r1nz7EKrhH5p+0LWr3EcAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Alyssa Milburn <amilburn@zall.org>

Add the PCIe controller, its ports, IOMMUs and clock request pins to the
base M3 Pro .dtsi file.

Add PCIe devices for WiFi, Bluetooth, Ethernet, SD-Card reader and USB
xHCI to device trees and enable their ports and IOMMU if necessary.
The bootloader will fill MAC addresses and calibration data properties
in their device nodes.

Signed-off-by: Alyssa Milburn <amilburn@zall.org>
Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t8122-j433.dts  |  28 +++++
 arch/arm64/boot/dts/apple/t8122-j434.dts  |  38 +++++++
 arch/arm64/boot/dts/apple/t8122-j504.dts  |  26 +++++
 arch/arm64/boot/dts/apple/t8122-j613.dts  |   8 ++
 arch/arm64/boot/dts/apple/t8122-j615.dts  |   8 ++
 arch/arm64/boot/dts/apple/t8122-jxxx.dtsi |  29 ++++-
 arch/arm64/boot/dts/apple/t8122.dtsi      | 175 ++++++++++++++++++++++++++++++
 7 files changed, 311 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8122-j433.dts b/arch/arm64/boot/dts/apple/t8122-j433.dts
index 34205d173a9b..6c9185dc01b8 100644
--- a/arch/arm64/boot/dts/apple/t8122-j433.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j433.dts
@@ -16,4 +16,32 @@
 / {
 	compatible = "apple,j433", "apple,t8122", "apple,arm-platform";
 	model = "Apple iMac (24-inch, 2x USB-C, M3, 2023)";
+
+	aliases {
+		ethernet0 = &ethernet0;
+	};
+};
+
+&wifi0 {
+	brcm,board-type = "apple,azores";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,azores";
+};
+
+&port01 {
+	bus-range = <2 2>;
+
+	status = "okay";
+
+	ethernet0: ethernet@0,0 {
+		reg = <0x20000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 00];
+	};
+};
+
+&pcie1_dart {
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8122-j434.dts b/arch/arm64/boot/dts/apple/t8122-j434.dts
index ead5afd77efb..e2f4880095ab 100644
--- a/arch/arm64/boot/dts/apple/t8122-j434.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j434.dts
@@ -16,4 +16,42 @@
 / {
 	compatible = "apple,j434", "apple,t8122", "apple,arm-platform";
 	model = "Apple iMac (24-inch, 4x USB-C, M3, 2023)";
+
+	aliases {
+		ethernet0 = &ethernet0;
+	};
+};
+
+&wifi0 {
+	brcm,board-type = "apple,iona";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,iona";
+};
+
+&port01 {
+	bus-range = <2 2>;
+
+	status = "okay";
+
+	ethernet0: ethernet@0,0 {
+		reg = <0x20000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 00];
+	};
+};
+
+&port02 {
+	bus-range = <3 3>;
+
+	status = "okay";
+};
+
+&pcie1_dart {
+	status = "okay";
+};
+
+&pcie2_dart {
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8122-j504.dts b/arch/arm64/boot/dts/apple/t8122-j504.dts
index e60ec3039196..9a5951ee28c5 100644
--- a/arch/arm64/boot/dts/apple/t8122-j504.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j504.dts
@@ -32,6 +32,32 @@ led-0 {
 	};
 };
 
+&wifi0 {
+	brcm,board-type = "apple,tresco";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,tresco";
+};
+
+&port01 {
+	/* SD card reader */
+	bus-range = <2 2>;
+
+	status = "okay";
+
+	mmc@0,0 {
+		compatible = "pci17a0,9755";
+		reg = <0x20000 0x0 0x0 0x0 0x0>;
+		cd-inverted;
+		wp-inverted;
+	};
+};
+
+&pcie1_dart {
+	status = "okay";
+};
+
 &fpwm1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8122-j613.dts b/arch/arm64/boot/dts/apple/t8122-j613.dts
index 40274a983849..7fdafe803e57 100644
--- a/arch/arm64/boot/dts/apple/t8122-j613.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j613.dts
@@ -31,6 +31,14 @@ led-0 {
 	};
 };
 
+&wifi0 {
+	brcm,board-type = "apple,dnieper";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,dnieper";
+};
+
 &fpwm1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8122-j615.dts b/arch/arm64/boot/dts/apple/t8122-j615.dts
index 61833f6d019b..d32686f88b76 100644
--- a/arch/arm64/boot/dts/apple/t8122-j615.dts
+++ b/arch/arm64/boot/dts/apple/t8122-j615.dts
@@ -31,6 +31,14 @@ led-0 {
 	};
 };
 
+&wifi0 {
+	brcm,board-type = "apple,tuzla";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,tuzla";
+};
+
 &fpwm1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8122-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8122-jxxx.dtsi
index 2dbdb77d5413..c184dd94e8c7 100644
--- a/arch/arm64/boot/dts/apple/t8122-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8122-jxxx.dtsi
@@ -11,7 +11,9 @@
 
 / {
 	aliases {
+		bluetooth0 = &bluetooth0;
 		serial0 = &serial0;
+		wifi0 = &wifi0;
 	};
 
 	chosen {
@@ -22,7 +24,8 @@ chosen {
 		stdout-path = "serial0";
 
 		framebuffer0: framebuffer@0 {
-			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			compatible = "apple,simple-framebuffer",
+				     "simple-framebuffer";
 			reg = <0 0 0 0>; /* To be filled by loader */
 			power-domains = <&ps_disp_cpu>, <&ps_dptx_ext_phy>;
 			/* Format properties will be added by loader */
@@ -47,3 +50,27 @@ memory@800000000 {
 &serial0 {
 	status = "okay";
 };
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+&port00 {
+	bus-range = <1 1>;
+
+	wifi0: wifi@0,0 {
+		compatible = "pci14e4,4434";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 00 00 00 00 00];
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
diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/apple/t8122.dtsi
index 959ddf36efa1..241a32dfe011 100644
--- a/arch/arm64/boot/dts/apple/t8122.dtsi
+++ b/arch/arm64/boot/dts/apple/t8122.dtsi
@@ -338,6 +338,14 @@ i2c4_pins: i2c4-pins {
 				pinmux = <APPLE_PINMUX(149, 1)>,
 					 <APPLE_PINMUX(148, 1)>;
 			};
+
+			pcie_pins: pcie-pins {
+				// clkreq pins
+				pinmux = <APPLE_PINMUX(183, 1)>,
+					 <APPLE_PINMUX(184, 1)>,
+					 <APPLE_PINMUX(185, 1)>,
+					 <APPLE_PINMUX(186, 1)>;
+			};
 		};
 
 		pmgr: power-management@2d0700000 {
@@ -494,6 +502,173 @@ nvme: nvme@30dcc0000 {
 
 			apple,sart = <&sart>;
 		};
+
+		pcie0: pcie@580000000 {
+			device_type = "pci";
+			compatible = "apple,t8122-pcie", "apple,t6020-pcie";
+
+			reg = <0x5 0x80000000 0x0 0x1000000>,	/* config */
+			      <0x5 0x91000000 0x0 0x4000>,	/* rc */
+			      <0x5 0x94008000 0x0 0x4000>,	/* port0 */
+			      <0x5 0x95008000 0x0 0x4000>,	/* port1 */
+			      <0x5 0x96008000 0x0 0x4000>,	/* port2 */
+			      <0x5 0x97008000 0x0 0x4000>,	/* port3 */
+			      <0x5 0x9e00c000 0x0 0x4000>,	/* phy0 */
+			      <0x5 0x9e010000 0x0 0x4000>,	/* phy1 */
+			      <0x5 0x9e014000 0x0 0x4000>,	/* phy2 */
+			      <0x5 0x9e018000 0x0 0x4000>;	/* phy3 */
+			reg-names = "config", "rc",
+				    "port0", "port1", "port2", "port3",
+				    "phy0", "phy1", "phy2", "phy3";
+			ranges = <0x43000000 0x5 0xa0000000 0x5 0xa0000000 0x0 0x20000000>,
+				 <0x02000000 0x0 0xc0000000 0x5 0xc0000000 0x0 0x40000000>;
+
+			#address-cells = <3>;
+			bus-range = <0 4>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 923 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 932 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 941 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 950 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommu-map = <0x100 &pcie0_dart 1 1>,
+				    <0x200 &pcie1_dart 1 1>,
+				    <0x300 &pcie2_dart 1 1>,
+				    <0x400 &pcie3_dart 1 1>;
+			iommu-map-mask = <0xff00>;
+
+			msi-controller;
+			msi-parent = <&pcie0>;
+			msi-ranges = <&aic AIC_IRQ 1075 IRQ_TYPE_EDGE_RISING 32>;
+
+			pinctrl-0 = <&pcie_pins>;
+			pinctrl-names = "default";
+
+			power-domains = <&ps_apcie_gp>;
+
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
+
+				reset-gpios = <&pinctrl_ap 187 GPIO_ACTIVE_LOW>;
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
+
+				reset-gpios = <&pinctrl_ap 188 GPIO_ACTIVE_LOW>;
+				#size-cells = <2>;
+
+				status = "disabled";
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
+
+				reset-gpios = <&pinctrl_ap 189 GPIO_ACTIVE_LOW>;
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
+
+				reset-gpios = <&pinctrl_ap 190 GPIO_ACTIVE_LOW>;
+				#size-cells = <2>;
+
+				status = "disabled";
+			};
+		};
+
+		pcie0_dart: iommu@594000000 {
+			compatible = "apple,t8122-dart", "apple,t8110-dart";
+			reg = <0x5 0x94000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 924 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_gp>;
+		};
+
+		pcie1_dart: iommu@595000000 {
+			compatible = "apple,t8122-dart", "apple,t8110-dart";
+			reg = <0x5 0x95000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 933 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_gp>;
+
+			status = "disabled";
+		};
+
+		pcie2_dart: iommu@596000000 {
+			compatible = "apple,t8122-dart", "apple,t8110-dart";
+			reg = <0x5 0x96000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 942 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_gp>;
+
+			status = "disabled";
+		};
+
+		pcie3_dart: iommu@597000000 {
+			compatible = "apple,t8122-dart", "apple,t8110-dart";
+			reg = <0x5 0x97000000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 951 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_apcie_gp>;
+
+			status = "disabled";
+		};
 	};
 
 	timer {

-- 
2.56.0

