Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878598;
	b=LuBXY33CwH7T/Wj93EMzF/I9YFw0WB/MVnFFkfvfRL4L50PBNx839eOt1z/DFRHVuxNM
	 ldzHwKOUGKIDVFO489YRsxlPNV9tMBWAdetdqlmGwHXSZ4PkrLlHkU2qJaYWA0exb6nrP
	 HnvGXSb8NYVO84dSRIwrUp2dwso3Ffp7RMs+K44Cv7LYYdO0K6mnWPb4CPAS3p2jT5kqw
	 3Nku/FzvZpausLyvqNmiXV0uCzZbzGRrXtQlweqI5OgZ2HKOd/kvOeui/CNEA7k9m55iV
	 Qk94MrrvrzWEhP+5wKhexUBfmVs7F3YVi70yP1jQoqZfjyt7WRkXYjbb8UGfu1ICWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878598;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WK0NkUOTRv8s5/APUMAy4zxliMrv812rU6CaWplx828=;
	b=DShKXd6MvME5hK5Gvwvn6q7j3X3jDGfiM+khabdV+2pnDraTdAAeqDlZGMc+1BQ/psRK
	 J65A5i2I7pvmJ82SYAT0VYN8vxDBUQqIm1bARXIaoXZlWv6uhVBrDXlOvNAC+ufEF0+5Q
	 MhfHxvldC4YoGW+U8fMVTj0MmIsQizPlbopKQlR7+FH3ER/pHmsp5LFlRKy4wzrHraWgQ
	 kgTIQbDxqEyyxGzN0Wop6sijyr70fWmxCvrK0h6/RTS7am9G+DGKXxpIYmJ6MdZ+mOIEF
	 O51dmwZODwqqmx2dUGSbO/lvUW9E1te6sWTlFL4+6xUR8CHAQqF4QBmE7vJd9cUkv/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=oGIjcS4E;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=P5gULBW4;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD0606D820
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95FD0606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=oGIjcS4E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=P5gULBW4
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF7037A012A
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 06:36:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Nov 2026 06:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793878596;
	 x=1793964996; bh=WK0NkUOTRv8s5/APUMAy4zxliMrv812rU6CaWplx828=; b=
	oGIjcS4Eg6A8x5cjvRRV20mS2STs/5L/Ac9/uSjRIb3HBA8y0kqzrHuVM/u1S38E
	9DEjlvL8I6qTosjUdbn4TEDepe3K4heEs/+6Say3Un96ea/BaPM1QyEqv/KkVUkU
	/CxzxctuBCZOmJ/KVpR2LPcgUxUNn5FV5j5WM0S+bTGdLdmAwjyeNRW5RBmneak4
	ZWRyQiK5hgyOtdCoSlrG0C60g18Hmjv16WtCMHQP57nlvyEI+KzuN++qou1yC2lW
	HFuH5OwR/S9Ssl37wWcmeSBabtzdlakbsZbUVYeCi37HS01eD8QfFsBmeYfJzI0g
	WYpk93aavP7lMb0tDHPrsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793878596; x=
	1793964996; bh=WK0NkUOTRv8s5/APUMAy4zxliMrv812rU6CaWplx828=; b=P
	5gULBW4Em8ZrJL2o6fKXp7OuIIVO+0ZOjcYWoSbdhPu65iahH8+d9Elr8eILqMIu
	rm7I8Hx/tOsa21TAKlmerGvXWPm5boASdVX8IsX8et1ACB7IsgSHZXJcGy5aL5m5
	4vYkKe2sXDGyHe1fwpTI90Xo/LOg+JI1M2ODepNzsdQqjd75miKbMRhpFhuHomeb
	2e4Hr7UPgEKJavp+zWT22SrJ722/5wnVxvcKRwEnVXAYDoizlsG9Hb2ewhoYRh7v
	q+6pki8D4Y/j843j462GamFjyInmTlbRXGO1GQnXCd0jvgfipMe9KQZd7qm2aPxq
	0rTRhmYtR5MorHHtS/wmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793878596; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WEEL+/jezY8pPG+MJmY6r1/DxFkrSMjbvl5pHzmDQ/80q77
	RAi+30cQaCWKdaG1Ovj5aXr5F5fnfal+y27JIpESvqxTQwmqxpOfQKOuyyOsnmxB
	ykzIqx/d+pk2uzgbvJ9zn5QFdaBlYtQs2TWjH3ML9P946KCkokCMGeDTL+3OzfaT
	+/KqitDP5OiQlY3rxJkWt/wR8uxOdAtcU20pVYjHpV8EXlFkl7xkeCinNPtPZ9cC
	VGZ8HNqK5k3xRKa8MOy9PdgdiD3cPOS+LzVbAmMCUQpbUMu8jAHfxddPiJ42IKKo
	Mg5xwOk9h04BngomdUEo1RQjne333oNQva0Mf0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hrMqAZetmNfQY5ccM3eGAeY/1GZoIwK2U8p1eHFHxFo=:NZQbBl++Pp7SMouqKWUSJWHwErySawfccycfBwLrK+I=;
X-ME-Sender: <xms:RGrsav04k-JU2RKtlBd0HOnZq8YRsIN2SKBy9zvAxIPCWk-vTLBYGA>
    <xme:RGrsatXJ1NHh8PJymMjn9vTpkKSE6k9Y3MlKQko9IvYlZR1xMCK3PM50ZL7eIs6SZ
    tXF5jdRq334gLam9NdcPQPh6P_AmjIBtwwCHmWYs1CtcagdQMH5m6U>
X-ME-Received: <xmr:RGrsaitCqmWpA3cQK2z6wBL6X5NmGHAwn951xEadZfD3oyKwKeyanRrxGigu2NkDWlf4jtaTjvA35XWtXw4Vn93Szfqj-7OLhI0>
X-ME-Proxy-Cause: dmFkZTFQmXn41wIJ/ZoMHVipeqOKCGq6BuT2j0XxsfreqMusvMSEiKTUfcZxpjOm2k5EM5
    KXKtudENzPPHUPAbqlGUxxiF+1dalOcy3yEqTY0wRGVzqxmpI4CSegvhu+2MpHws9sDxzs
    hhhe2Tm0sPrlqAbcLURbK9fbLYIOpLFKCizCbLeQgvPIEI167ku4y6mgZtoIB1qVeS88pi
    CzgaNK7Yv/jGJTbCs6ZLdqqGn2xYtJBu9iXGx+c0Zrc3nZhuMtThTYYSqRWgmIuHUqeg3A
    sMPTduDSnLTG8DtxGjgX3hfvOAqdOLSn7yXWHyr/YiRKqY1QEYBUEX/mF5CNZyZyYdA2BJ
    4zGCqI9jYpwvQQ16z6X1HWO7Z3ZL0Pzxu+zkW+Y87bOb1N/RhE6dFbqUvYIYL9ISdxgdfK
    QUJe3ovKL6uc46FYEasYwPpWtcJLbakB3cSahj/Jo1YtL8aDnszgP4vmB+JnUGBUn+Dl42
    Pg/tADqHT3SqmvEC4NK+1CqH+YtvJnKEZkMJ3hdrQuh4X9Xe0+RUiO4Jd7v0cbddaniUZ+
    JgG99pRGTUi+2rc/ebsP7Lb6DcfDKxj9wQnLzA+zHHFNffnpMjPE64zHQcwbbdlwdT+x1d
    3ro29DgafT5FdwR3HYyfUlwOUrL08Kl5yDzRDfdqHBTIiQEn/LbimIocg4vw
X-ME-Proxy: <xmx:RGrsasWlZgcH4kcj_1vKaqCFlTVM_CqIqxS4VF0eFbiniKeIJmQWAw>
    <xmx:RGrsamXbizpHhq8mf6WAX0SfIXTBnwOdETqVR9UHiK03UuTJ4Jgm0Q>
    <xmx:RGrsaud2yEdvT_9BX1Co6pjg2wSt-owK7QE5eAudjb_aym4Xz8ed4Q>
    <xmx:RGrsal4RNqNoNPHOdLghZAgGpewzeD7pVRd3wb99FbH1eQmd7wrIOA>
    <xmx:RGrsaop73pCYtEz8xaZSSblo4Cyc9X6L51X_YvptU-eBfHHZgnQdCo3T>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 06:36:35 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Thu, 05 Nov 2026 12:36:02 +0100
Subject: [PATCH 5/7] arm64: dts: apple: t8122: Add PCIe device nodes
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
Message-Id: <20261105-apple-m3-pcie-v1-5-e00a72a604f8@jannau.net>
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
 Alyssa Milburn <amilburn@zall.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11368; i=j@jannau.net;
 h=from:subject:message-id; bh=6VnD2O3unzh18AVoLbGUnllQO8vAvLOBJtr9smydWkw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqw3WRpT3Q4+yjGZsCtA4ZOd+YnmZz0bmHdzTynSOrf+1
 zcx0/C1HRNZGMS4GCzFFFmStF92MKyuUYypfRAGM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFRbWDAyfP79MHD66R3lbRki7S/Dsx51RsTIueQarg5ecvaDyIMpPYwM94xY+9O
 43aJWWGfpMMs+0gyc9/wAQ+m0JUu6l/0r+7yHFQA=
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

