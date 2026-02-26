Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDA393DD8
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092033; cv=none; b=BtcQCq039L6jPTnq91JwJqhpZ5FAyOQDDObiHl0eFHo5wRfJqkHKi9I9WxGegY0vTgwqtKuZwdtJwSVY1mSt5jJTpY0+qeyXEMVXv7SGs3ypA/NBFfXjdNbfVhaXrgHSV3c7QGi0Esb3+JfS4MHueSU19BXvdNKTghSD8HlHtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092033; c=relaxed/simple;
	bh=bUb/4Nlik/131VjE3xpg2h9tP/oPh2neu7vE6n1AEhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnEI/1lQ4GLd4pQXjguB5erect0eNG9jMu/PaNC/no52lBVjy00rmovhJMySe1zFe0dnsueyPzP3PeP0lRoXfOyGOFrWzZVz0FqIjVM+cNyrxyqVuqc9jh6Rsx052n0EMJhCoowOH2eOx5rxjH9/IvTfkSoY42UHreS5MVsKMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BrlR1z25; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BrlR1z25"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a9296b3926so4187085ad.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092029; x=1772696829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZd4wVxGyLj+wQvrtlXscalBZuclzdirQcI9cd7xMNY=;
        b=BrlR1z25HERwWfXRFWalTToxQa3kvZU4Bmxzp40lAgxFo17BawqCGv426KcPPjVk2b
         iXMsoHOpyxeJw96ZvRtl183jBrOBbPIHvWQIWZItDTdfyXmmKA5ADqUeKG9t3SUul6TC
         7+kKD2ScArUpCI+GKdWGxX3h3aZmJ+RXT3hh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092029; x=1772696829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZd4wVxGyLj+wQvrtlXscalBZuclzdirQcI9cd7xMNY=;
        b=Kl80idZgldMFDxQW7ZvmYf9O6YapjfwdNSROhquRkc1u8up3OlzfRJccZi+LtOcr+Y
         3u0dvIGBvfJ6xe+ozksDXrhan1/fR3UVa2MAkt31WuV2homzXyx3y06xkKg2uzHUMAgx
         J/4tBtnzu6lWU3UFOXizB7s6xiaowH3hyUH1xt8omp1uEJn1ZHJdRavc61yhWoMTVEv6
         0BiTP6eyPZYOs7bQsY/PbjPMhezN3SDZd0fEfRvHC8UpnMI4mrFWGSlRsDvIpSlrI6LV
         akshjWUBBOrWjABw6LOYAH8FD6dLl6ScDQImw+F/Biq2ZUvSVv1JFqLx+k0T6DKJ7Q37
         78uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHoY4unLUAyTWNMVFQjRq0L0hNfPIuglDhSkdg/z9UzHx+WfdS4R2NyMSt/0isgT624OonHMaU5cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe4+4Ucn1COvaC+GBfQy9pyOwCZq/e1viUOqrfoJ53bVwLfaP
	u7bUyVId2M9bwWiKPa3lzg6B0aobGcGyPwUaSSvy/WnpJUz3iu7NhHHLBb5EhlmtKQ==
X-Gm-Gg: ATEYQzxe90ks1/lVgF1CXj6rt5bqG0bPsFQ7d5J/N0mSzI9fnNLPD8qB38MQud+7oaH
	NtJdg1LmjOUPs3hSvPK1nDhIqAmAWydBmL3euDXZhyGo+ee117pfxh1ZZgoKIboAAumeWE9zqSi
	kFeSp4ci9wkA+C9MwYdbzSaGrQ2nrBqFnf74qL2QmBf9GLEuXcbzrnZtMI7ol8UYh/adgUwArXU
	cTLlXVHmTsp92Gpe+W19eezuPhluiLzHlyOm2FV+XpF/JoyakvMFA300NHXejsYnHL72QQTjxJH
	/sbOLBw6tMggLmB3qwPjWKNaJAzIm4WwjUy9YuYbzv17YM2uC8MhUEfLwHR30pJhD2eBs+QBcw0
	yI6K2KOMHmzEz7EdwJEnx9udt/35BrrSRKd8ofPMZyGMcPa3hOymAGMpiTEFSHVOLOuGULKLtF/
	1Ud5HaG33fn7pJ7r+zXSCGJDVseiw/21Y4pLIakvVsaDm9y9oKM/Xz1vSd3xR/SwnHZbDqdOz+r
	HQ5/Dg0
X-Received: by 2002:a17:903:11c5:b0:2a9:322e:1964 with SMTP id d9443c01a7336-2ae034bd66fmr17012505ad.31.1772092029298;
        Wed, 25 Feb 2026 23:47:09 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:47:07 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: mediatek: mt8195-cherry: add WiFi PCIe and BT USB power supplies
Date: Thu, 26 Feb 2026 15:45:22 +0800
Message-ID: <20260226074524.3808081-7-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260226074524.3808081-1-wenst@chromium.org>
References: <20260226074524.3808081-1-wenst@chromium.org>
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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

