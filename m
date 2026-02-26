Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A53939BA
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092036; cv=none; b=Z2ItmpWqIYkRZ5EDtNDLujGo2oQMaT7KphLRl0MPFUsascgVGutTRVhto/HKp+wmalNUJbsoknmkKwSgds8RYpsuIZRziES3bkcbtx5Z9n7bEyvfYBOuxe2MzrquinxfCgkLc5YbucAbM9FMzbNTDHHnJf5YHsmE9aeWzzvnFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092036; c=relaxed/simple;
	bh=AypPDr4UgXhu7uIff8wANG2+W1ncKwh2QK1mDknKf9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlLYXueFv2oaL2kxy4Fh5cuYmuaFyuPetGu8mlI8wIkZHhtGALxR2h1w2o6HW6SqJGb5SpX0CiSPROkHXvCiNl/kBKmj5gUn/gXj2UMD6IWYknN7NxAgQXWdnBX7hIuS8bw/FKSN9AkUXY7rwkd4UtMghGFryd/SbuGfClKbMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PLp3F/3E; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PLp3F/3E"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c648bc907ebso326360a12.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092032; x=1772696832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfwUdpA5rCWf9a4/nMgxhcP8TttgZio63fOINzploZA=;
        b=PLp3F/3EUGSCRffLeldwyJIeyW7QQf1M+/XDzP1JYOWRLnuYQ6m6rPs+K8ViO66cCV
         xdjYXHtAezUkhOMLSOkHoTRoIvgJhRarox/WVmewai9ml0igJ3Q7znIwdEaNkciLYUCD
         53T9VYNKcOBUhVAXAs6VFCvcheU22iBI7KxXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092032; x=1772696832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfwUdpA5rCWf9a4/nMgxhcP8TttgZio63fOINzploZA=;
        b=Mg6pPBY+5Y58ejPzw4Nz1UThskINOD+z3WkIbjteaGgm9H+jX8VfRCjNAHSZ5WKPyU
         jk+pjsOIE6URdQKx7a1KTtkaOhOkJrfhBej8yae3WyNtYDOVSlPoU/RlyMHb97rWXfhu
         tQfIQbGwTloIU+2jcNVwb8UeC65cFd96S1JKXPK2sLa/G8rha1z81OaHwh5n40okhAEv
         ObJF5HkMeeqzIzjQNCnr8EQmcM9SgMJHP5ldOtc0CpLAzNaHcnlYxkUchWnMZs7V1qF1
         g00yiHJHu467KyGX2T/w+u5/8h65N6REFGs5jnNFoAGPfG3yBsvrvv88iZe/2nu4G6G2
         y1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR5eMSXIir4rPgmCARR+QN52y+MLfC0K1Y/g/GVbkdnt66+tCT9LvziduKmE3xzqB2iR7Z9ZRnZLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2Kb1Hcf8wkF+RC2q7i7E0QL+FFKeAGnR5JobmVCNdYlBHTgi
	0hZYcZM42x4Y9Xyl3KZdR55yBRP6WvBbt5Ft4EAxei03mKzg4BHlrHmr6Fw58qN9Wg==
X-Gm-Gg: ATEYQzzURavshI1mUXY+sYiPdT7MzMAFFLM9u+2LeSbxpsGndCi0EBjwaGY9U2RqU9O
	PDCgiQfnuECB0WzMWWXdPpZQkizWbltGv2owQj94RDk3CsrAD45ch7nOFHhasE6YlYkeFRBlHZw
	+9r6PEX8Ej9SnT1t7ikZm8fWha+17RhC5FfNsQVt2VcbRCUdn7ou9W11SaclDpzRVkWSRenzB38
	zSsveH+sNGZvSq+feP0dWNSOHCwJes52A3e2b4ZQojx2ESnX0irPRfCmqlauqnpvCmc794Xgifh
	DiBh0oAwimeypLk1GmKslTR/cwrzZyysB5s+owt85ZGV6ohL+zowv6cOD30QR7wfxuNnk3B3lHV
	55O6iZnQZHlPSnshjwsSbjjiWsPygX3PQhIiM8PPjjbmwofLUqlJEoXn3OQHVYlTQzZeDEm4Cv4
	QMANV8Vw8bgIVixXpV7AaLPVnqav3I5dCO7YlwpIpeLR3vjzcDt6eVftW2znO+02TYZuNh0WrkD
	x4D1VBygbk+kVIqAHM=
X-Received: by 2002:a17:903:41cf:b0:2ad:ae4f:345a with SMTP id d9443c01a7336-2adae4f36bcmr89126745ad.36.1772092031982;
        Wed, 25 Feb 2026 23:47:11 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:47:11 -0800 (PST)
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
Subject: [PATCH v2 7/7] arm64: dts: mediatek: mt8195-cherry-dojo: Describe M.2 M-key NVMe slot
Date: Thu, 26 Feb 2026 15:45:23 +0800
Message-ID: <20260226074524.3808081-8-wenst@chromium.org>
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
2.53.0.414.gf7e9f6c205-goog

