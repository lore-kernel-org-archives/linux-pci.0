Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FF31717B
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429498; cv=none; b=SW3rtzwbfT82PvUWql+YL+AcepHuCJzlm/xCJzCGO3PRUZocid42wt99zygKZTipPWud9vpuAp5vcQuYTguKCQS0A38HSpB3RMVgkutdOPLEheqxSfxGuPDIiYIZWbH5JqbsWR16BPhUEZIeboZQkSg93NoQsN6nmViSUdjhlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429498; c=relaxed/simple;
	bh=Ppi6hQERjQLR9FGUc7Pbwa1ZIIuN+DJU2f7GSXTRchM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e24eNAckVcIYQQhpbYCjnRZWqOY8tXguglbXIYgEu0NXbKOb9G4BsI9pgMRD1y6FzjrxYcMlWQczja+pgM+zGS8NjM5a8kEXCXP5+XACmnVsyw2NsYsZK54u9I6a1gQ4n04UGdFk3S8eEfGs74NjatvR1QWb9/KYZDoVPLoQWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=azEew83o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="azEew83o"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2addb31945aso30414865ad.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429494; x=1773034294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ly6u8R7bmz5Bdr6kesmUkfvdxyNrxQnN2igtDps6Mw=;
        b=azEew83oLG4kBcq0xdKtHP4cay9iWpSMXd6t+t3FRtBhMqtuIxKP5Cz/HbErXblr5L
         KKWjgLwAMwtfm4qhdbZBwRYQIZutv3d5bdq6XjC2b5EIvX7LZLJGr2Gr/G3Bf/hDe3wl
         yK8qinvjwijz706VByQs7P3fp44AXWEmfp1W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429494; x=1773034294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ly6u8R7bmz5Bdr6kesmUkfvdxyNrxQnN2igtDps6Mw=;
        b=KgVgitLu4fiGkA/1FFe+yW1y3Fe4XbBs64nEiInO0ngPcDVyqm1uGfWAURR8hl21/8
         PERX++hXlV5l+0O7CC6D082QyAn04fMZfrdJ3tefNL8MUSh/jMkVEM/xtOkT7iRzgzQ6
         6YdR6/XYPVvqJpA9nLETOahK24tOEnMvRlBeigj3Doll1SIq0O1yvbk+L7/zpo5w2B4J
         jJ0gBiEKIrMmB19s2NtanZv+z3+0rJuXf9kWbXAbL4lceT8ja7OeFhquq0mOBPYT/pkL
         sHz539crzGRKVFdZIYA2scuo7ywPBtJz5QSsu0cDTUEsPTX23Eu2fnM5N8InJouWWK9w
         Sa6w==
X-Forwarded-Encrypted: i=1; AJvYcCXxYb1Ii5lnpMVmWHh+7Dti1y2VMybfC5qU6nM2XQTeIDlBsXRFlKN+eFmHWQQCgZP7iuNeOGC0p+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJakUfsi3RYs+oftgzIs03Hhto+02vcfP7yuZcinYDZ3Dy6Ih
	O6BWk5xJfPy1olD2NLNMgbF+FTXG+JSIULnoUdD67L2ZnjTC8kOzVZ3Orx6KzehSzg==
X-Gm-Gg: ATEYQzxOp/e7s4p3RW+soUJADE4dj19tz2yT9chKtvbSslzHwGvfXkzt/Ylm/l/76GX
	Lk9JKOtaGz6+SVanW9Wr4KtK6V1P1FmX8RTY76HHomfzkzetUOVYoD2K1o9UJNGUViG8833KVg9
	rjyZ5fl4a/+zLXeFGGMz57vtNLTVBg4OQTBH+cp6H3GhNai6W9Gxiy/kIS1BnbC+87X5VdeUyGU
	cTGIDdFeQnm++6MqWwz0NQztajCT47zybcLtF0JcEdlafww569zTqrnBcws15jWggt/IAvNvqaQ
	XZc5/F2DNcOH44AM5cDmUFswALVwXKctmQ+NizFfa7cvVmLOa0/lVRyTDUnBSVKZg4Vziu1TEhq
	qGDDP+YGOQH2sTDfHlZzzmVsp4oxvMYkziIjjVQIfAOF+S2FfskCM8VsdAyZI855ESg3zihSyFT
	g/sByggqM0XEn/Q8X7o7AcDW+5qZP7h7PZnde/xQhBmQP3SR2uIUKc0aI0uZKl3WP13jxHkV0u2
	jfSgdvB
X-Received: by 2002:a17:902:e74b:b0:2ad:ae4f:3458 with SMTP id d9443c01a7336-2ae2e4e2c8fmr110384055ad.55.1772429494577;
        Sun, 01 Mar 2026 21:31:34 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:34 -0800 (PST)
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
Subject: [PATCH v3 6/7] arm64: dts: mediatek: mt8195-cherry: add WiFi PCIe and BT USB power supplies
Date: Mon,  2 Mar 2026 13:31:06 +0800
Message-ID: <20260302053109.1117091-7-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
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
2.53.0.473.g4a7958ca14-goog

