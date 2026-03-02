Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72126FC3
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429499; cv=none; b=WS8bY+QWsf57UbmrIg8NpoTMY8qejdaavnqsnEv3XIO+5DzdaP20Go4puNKdza9e0aJajfP2LnQ88d7Qg5TO4ZALpyFeHU/ROFdLh2sjsAM4MGFHS/nesHbSkm8nQiazhQKhpluKTiFrG3dUktp65wkI+YyfGWSmTr5+x2TF7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429499; c=relaxed/simple;
	bh=aUhA32YGjPQJB795po9T8wUDAYDJceDw1NoTVN5jakE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjqJOj3nuIM/+MLxyTl1knt0R2+bNQdjeXVCbAtcbLYoguJ5LC6vrBe++nYfol50ERj+FnzF4hS8ixejBXvlEg0soE2dSdjU4gKzkRnCZlX6Zujip9T/hmpXtfVg6nRlGO/yvqFr85VijB1gHFD5WT8BYMZkUgkN5FMe7+b6sWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UEyttflJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UEyttflJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae505619baso2819695ad.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429497; x=1773034297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l55rscaGmzYhvn0+eMNyy4NMWKpZ4qt99Qpf3fX6h+w=;
        b=UEyttflJF6yEwHi5bY2zjb3aCjAXt5DoOZnFO/X85vYdLQayDwCB1CBFIxm0GHIKsH
         qYiYSUDkh29UQnNpe0wEs5P3VweAya0X3y+ALr+sN/CB4dgSlKuhxtGULHPguIGcmPIb
         EFlf6dNzpdobdXHlP9GaRj6xUSZr5mb/HdiMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429497; x=1773034297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l55rscaGmzYhvn0+eMNyy4NMWKpZ4qt99Qpf3fX6h+w=;
        b=sM62LdTpbYtQ87adxjM+SgEguOj9Fff5+WAXy+XRgkm4MiDnVSF6PuPyoNg+GaWAbY
         aOTS90FxZkWn5xmGuH3Szp9PLsHjuVou/XklZx4uryXlIIrftBxOhwHIqgA4oOzs5j3D
         gwPIEDCisfjCSCdYncs1bfVyQKz09Zp6ANQLRsU/jg2B8y1wbvVpnj5OWglKrhPn+EXz
         pfyjkdG0YyOwuqhlJ3LxfZojSB2fXekBqXdtWsth0XkhVR9ac6wNazXEU72B4skOBdy6
         ffMU7e4L9W0Ei7fuUw4+HUf05eiEIgk/fRPrgmr1ln+nfLADKkV5N/bZ557dyW3UJnlT
         2nkw==
X-Forwarded-Encrypted: i=1; AJvYcCWNQaHuxAtDr//UMGKZ7uxSlXO4GCdF5JFNelKPMSaDfJHoOOkTby1S+kCy7j1ITg3fnmk6QKjOArc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXC2j0VELXUznMC1NETCMX/mBiHcJXbKypyD335+QHXz0xX1Y
	jRML2tUADXHjAbZG+ORzSY94FF+Ss8LbhSJTeCExaIYTLFFwV0AM1Lsy9BL3Xwfj6Q==
X-Gm-Gg: ATEYQzxF8Kj+TIadg1gk1SoBTboQriaaGyBw8OH9LFz4Mt9Lq0dvOjNZNF/IZu/jY+g
	2zYp0WdpEywV+pxY/NUcRTCgVYvUq4uYiVoLpkfMzUQGLNo1P3GavyfjHGvJkXu9F6sKw7OE1do
	BYQqOU/lq4zqWYJ50IZHAToYpisBAtLtSAVb4zn1zyH5naeFr1aeEPJh49Sj+qjaWitZRBctYoA
	yaHfdAG4UkGKmECOWxp/wQ+RpWwqwQN+5oVQaOlS59y52JjzzojSFriFqmrN4RxJceIauPXK8Nx
	ZaokzO9XMnUIyC5pqjOV4o4KKXJLEFMEGbQqDEoz5TIzsli+DJ7RS8CqLiyp6GMZpMTnbDWPkkx
	PvGQKCpdrT2Z4V3yvckrbX8J2MlMwzqKmiIibyG8uvsDn+Xcild/3zBDslcjhD31+M7RX+KOETs
	AgSwdIU5/dB3f/8HU8MhdDVZ/U57LH7anaAcoUtwLY/ahIJJoYtZwRkO7kmZQAOucizjX0+/fJP
	FNuSSsIutqTAZoC3Bw=
X-Received: by 2002:a17:903:46cc:b0:2ae:5426:da49 with SMTP id d9443c01a7336-2ae5426dcf7mr12070805ad.34.1772429497286;
        Sun, 01 Mar 2026 21:31:37 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:36 -0800 (PST)
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
Subject: [PATCH v3 7/7] arm64: dts: mediatek: mt8195-cherry-dojo: Describe M.2 M-key NVMe slot
Date: Mon,  2 Mar 2026 13:31:07 +0800
Message-ID: <20260302053109.1117091-8-wenst@chromium.org>
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

The Dojo device has a M.2 M-key slot for an included NVMe on some
models.

Add a proper device tree description based on the new M.2 M-key binding.
Power for the slot is controlled by the embedded controller. As far as
the main SoC is concerned, it is always on.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../dts/mediatek/mt8195-cherry-dojo-r1.dts    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
index 49664de99b88..57cc329f49c4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
@@ -11,6 +11,28 @@ / {
 	compatible = "google,dojo-sku7", "google,dojo-sku5",
 		     "google,dojo-sku3", "google,dojo-sku1",
 		     "google,dojo", "mediatek,mt8195";
+
+	nvme-connector {
+		compatible = "pcie-m2-m-connector";
+		/* power is controlled by EC */
+		vpcie3v3-supply = <&pp3300_z2>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				nvme_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie0_ep>;
+				};
+			};
+		};
+	};
 };
 
 &audio_codec {
@@ -72,6 +94,22 @@ &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_pins_default>;
 	status = "okay";
+
+	pcie@0 {
+		compatible = "pciclass,0604";
+		reg = <0 0 0 0 0>;
+		device_type = "pci";
+		num-lanes = <2>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		port {
+			pcie0_ep: endpoint {
+				remote-endpoint = <&nvme_ep>;
+			};
+		};
+	};
 };
 
 &pciephy {
-- 
2.53.0.473.g4a7958ca14-goog

