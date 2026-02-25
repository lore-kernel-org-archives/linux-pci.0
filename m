Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946A314B61
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004189; cv=none; b=aJNhO/eIlPqOkArb0Lva7WRsXWBMf62J3l3FRf2n//mKFAc+Ff09VW2Vdrbh8sNe1xai3bbzYg1NKJ7WdsLkJyx6KbxRzWFkXMWNnNxMw8EkirAwmBD56+A21XuSn76cOKDoQUwxnPKW2AIJQvPI/oTK3X6vPj2D+iEe5ZwMX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004189; c=relaxed/simple;
	bh=AapoS4b8lIgfZZ1KAd6SWpC9XkmH5YI+lO3u1HjiAtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1fAksGGZqbar/6t8kj4wuxAACw4qNe9Upi0HKznXQGnNL+1HF9Y9LgClucpFB2whXGG9RlTg36k3ET6GtQbiVxS6T+47DrOH4YxKAA1m/6ScVywtkUbZSGarSfNFHxtzXbwsVso6+lHIv6w6pb55sZkSqsyQb8rWayhjm/AUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZqDPBcrV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZqDPBcrV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso43164815ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004187; x=1772608987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUlMJL8sDqfMhOaBSEuOUb8RroUd2MJOVQPpugM29u0=;
        b=ZqDPBcrVMLB0O/vVSfiGUnWAW/YAOQldFzwMVh2U3Kf8ab8vRcvr3RDKzsNMsJUDQE
         jBmYB1KroeE7MZXMjYxaahrYk9NU/VOJn9tVOUZD1XrOKuyVernNoCWs5wTcY/hAT54g
         2JCETYPNS1hYUyRHwmQZqmW3w4WJIigiQCV7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004187; x=1772608987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUlMJL8sDqfMhOaBSEuOUb8RroUd2MJOVQPpugM29u0=;
        b=lzeOpXY+Le7Os/da7LgOZV1gQ7Pe+yssp6aYPdsik4hQIm7LarbY9EB5wvNBG3oWEX
         4+NbIIh1TEIAk7Q6iNWPvS8S2eoJZNE9oEglTkSmUa2b6gVWJHJMIPXmEAvJAQUhq1B6
         HKIT4gXsAkXjsOKqYfP53g7ZBzLGGUy4gE71Be6kKsk1COASQZgM60UjdrzjBjvfonvk
         CExMO7ONHPiJCYWfX/7w4QBqHg5MKoW0NDtVm+qzJf/4iJarPIQX40VN6FfuW7SUU/M5
         9AUQuvLnyOXM6ud8XoLjwM0Al5uJx9AZMQzHLrofNSf/FEA5oy7/LKZ90qm2wXePOMVi
         SUpA==
X-Forwarded-Encrypted: i=1; AJvYcCVaBahnf0GTlplkp/BVGQTH75SsvQd0uOLqxg1/oej1tCDfzxHZzaf+muW0zi15X2uXsaQvoByOvwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygVyvMfEVzwKiOlKcGO4FWJrzokqzUfIwe5Za5hiKXiFXnwG+5
	Cu2zypj4KeapVimKeIHB+VNap/IpBixW8MWWYp8OOGpeXp2hv1aXLffZ7SEJU5EtXg==
X-Gm-Gg: ATEYQzxFpg5fbZJ0AaEPfhbU4AIvmees+e85FGbHU1tByUrVohvcOVmNyZeQTk5OtrV
	8YFD77QlzwJwLIo/l+xzxV6Lpv10j19qY99i9hvV8XHjs0itFG4dvxV/+wNngs79tbMdZuDef9j
	u7ofqPoVJO4Fo4epry9kjYZGDji4lwLMlvtrUfJ485knCJuMKYhpHFAR1lB4FmOzgY0WGuvcXgl
	XaMTUvSGBIH4KsQVcgTiaaN3CAO7GwnbmtV+m1gfeDpgJ8X1bQ4BgdTZepuQ+wfw8n8eH4E8Tmm
	kmnNmH4VvMJALU1A5rGU8yKHMe72YsA40U7aqlTpsud17maQmlR0vblOoWDvXOx3lhuWRFwQRFD
	V5mt2aa9KRiQ8iUV9Nw8raXMTRZR97sAE1vPSv4VjGfsAoMDpm228qH7RlLQDS3mhiTCaMIx2cT
	ZK/wS1RzQ/cxp/kXoI9POC5h0f7pYbbOV1zQREeqc662Q+LNR3j4pycFUhHOnKlKnvx5+eNtBUP
	ZARuQ==
X-Received: by 2002:a17:903:41cc:b0:2a7:6aa5:68f3 with SMTP id d9443c01a7336-2add13834a8mr16305355ad.34.1772004187261;
        Tue, 24 Feb 2026 23:23:07 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:23:06 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: mediatek: mt8195-cherry: add WiFi PCIe and BT USB power supplies
Date: Wed, 25 Feb 2026 15:22:23 +0800
Message-ID: <20260225072225.3345307-7-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225072225.3345307-1-wenst@chromium.org>
References: <20260225072225.3345307-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8195 Cherry design features an M.2 E-key slot wired up with PCIe
and USB for a WiFi+BT adapter. Previously the power was just enabled
all the time with a default pinctrl setting that set the GPIO pin high.

With the PCIe slot description DT binding in place, the power supplies
can at least be added and tied to the PCIe and USB hosts. Once the
M.2 E-key binding is merged, this description can be further converted
to an M.2 E-key.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 47 ++++++++++++++-----
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 6e99122c65ac..f1ff64a84267 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -83,6 +83,17 @@ pp3300_s3: regulator-pp3300-s3 {
 		vin-supply = <&pp3300_z2>;
 	};
 
+	pp3300_wlan: regulator-pp3300-wlan {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3300_wlan_en_pin>;
+		regulator-name = "pp3300_wlan";
+		/* load switch */
+		enable-active-high;
+		gpio = <&pio 58 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_z2>;
+	};
+
 	/* system wide 3.3V power rail */
 	pp3300_z2: regulator-pp3300-z2 {
 		compatible = "regulator-fixed";
@@ -760,10 +771,25 @@ &ovl0_in {
 };
 
 &pcie1 {
-	status = "okay";
-
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_pins_default>;
+	status = "okay";
+
+	pcie@0 {
+		compatible = "pciclass,0604";
+		reg = <0 0 0 0 0>;
+		device_type = "pci";
+		num-lanes = <1>;
+		vpcie3v3-supply = <&pp3300_wlan>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi@0 {
+			reg = <0 0 0 0 0>;
+			wakeup-source;
+		};
+	};
 };
 
 &pio {
@@ -1179,12 +1205,6 @@ pins-vreg-en {
 	};
 
 	pio_default: pio-default-pins {
-		pins-wifi-enable {
-			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
-			output-high;
-			drive-strength = <14>;
-		};
-
 		pins-low-power-pd {
 			pinmux = <PINMUX_GPIO25__FUNC_GPIO25>,
 				 <PINMUX_GPIO26__FUNC_GPIO26>,
@@ -1222,6 +1242,12 @@ pins-low-power-pupd {
 		};
 	};
 
+	pp3300_wlan_en_pin: pp3300-wlan-en-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
+		};
+	};
+
 	rt1019p_pins_default: rt1019p-default-pins {
 		pins-amp-sdb {
 			pinmux = <PINMUX_GPIO100__FUNC_GPIO100>;
@@ -1570,11 +1596,10 @@ &xhci2 {
 };
 
 &xhci3 {
-	status = "okay";
-
 	/* MT7921's USB Bluetooth has issues with USB2 LPM */
 	usb2-lpm-disable;
-	vbus-supply = <&usb_vbus>;
+	vbus-supply = <&pp3300_wlan>;
+	status = "okay";
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.53.0.414.gf7e9f6c205-goog

