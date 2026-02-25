Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDF315D29
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004191; cv=none; b=P8lWfz1GG0mk02zg7hDXs/I+hVf0gEfowyeD1wUWCzUMP9aNdL9n5ipJw0OLgyNyLKa41j2VKvsITuFlCfuy46phZrPU8HsbtIbrX0Umh7aOTMqdYlqTOOVjNbKMCHI+27mqzS9O4hYs/BouZDf66puA/6WR5xhTCTo9hzbeoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004191; c=relaxed/simple;
	bh=soEZe9eXpi1gpdG2KC7zwnFARDxojsqUJRhYaCtZeXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc00qltATRlBtvEIYWM2EnMCJ3QNJpIz1P1/HhUy6uUrec6pHdIMURyvpLA0e1q+8+J6zm6eXbFz9Wzm7aKYyl3KyhbXRqFJoxWaZirAWxDistTj07H8GvsS6fECW4hDLZ69C/E5iq9/g0+D2HxCvWejbZ8Ot1CE9/XOgvltx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAXbGoMs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAXbGoMs"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so56799335ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004190; x=1772608990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=296zJScy32zZ99pggZVYgRNpwHzrGar0aPdVMmqKLxo=;
        b=CAXbGoMs3gHPCg2BmJyoWG5U7kONH7Ci8MTJr3W0bsSbP0gJuN6/0StUhVOj2trMbv
         Av5IGOoIa8Bx740txGylVMnZp9NuaxE02PlqFE3D2r2VAbjL3YQVvwFyfx1scHmMBkx/
         57ZXVXg2+vEyWXI4UxA0A/fxefF43zIy7FtJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004190; x=1772608990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=296zJScy32zZ99pggZVYgRNpwHzrGar0aPdVMmqKLxo=;
        b=qF020E8SyYwXP4IPDYKQxlxl5omVb2Pw1E8tvPHlC+APslyBXBJByhAZg13e79dh3H
         G9ABK5DAPA5s7SiZYXNLIpDYBLyK7TuYUaDpgk0TX7JwpJhIVJF9EqbcRRbaJq1lYqnh
         wNvkLoqlxfgVxpy4qT7GnV8Pt3PAmv86115yA5SnloG2i3QYWLMk7eIsNr3FDtDvhS1a
         jE3FbmrUCpyZofoQN56Fjptl8NDwi6isg5AUro8REyZLMJE407eXj+UfL6Vm2j3sWSA4
         39cHz9Ci0JX/95uj+Ck/EeINKz5WeZv/+RrtcrlAO75lPM9ewtO3n+kc/yTTJ1lNhpGW
         j1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwnMt3Rc2QS2Z3B6qjJwsWy16WefGqib3vEbzYoMv1kbIuqDgFIiqF72201AJXhfd+MlVxFXaxTR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnpPNa94auwK5k1Hdxeijt+dY1rBuEKTKKDLK2Psx3Kd12YpB
	6zmefqgmvV1XGnQhf1v/R8n6EIGBVJ3H6+AZim9kNHSP1bgjv9eQycKMI+HcOYaYgQ==
X-Gm-Gg: ATEYQzyM71gYWexjMhofdD0esV4RmPDPhsGdRXWiPQIXvGOY54uaGdQm7+9QW8dtS/J
	s7zTmyf76Og1KArV5s1YcEQDUNPALmWBofBYN/XrXIFm7i7w4W8/sRnm8NQjYWVpo4PZvO/KapB
	ySzGPjNgfpURIcCDYnurjtnGb58xDhR6Bj655lClVwgwY3e4tk5iBAqXe3cUsP9XetDeLNwKE+g
	an7njZZoXYVWLz2KfrQ1mJ0TxdNBvN98pF45i2lmyCrSBOHg+m6QN8ABcysHUVp8tMZiRnJ2it/
	HYfa/EAYHCVovSFphFYt+FZvvdHw5zqOHN0HssWlKj6unWafa/mw4axHIj+JjTSSVze5tssKHA5
	/v+DzQfi6rYcp5hyh2YMoyzTzkFAOqv5CuGZhLcrBGaqbLlJ3VVGoRhSa5Vx1D7+g4sKVXBRv9G
	iBwrzUIlR1aaUTh6c1SwC2a4R9v+WlrXP6nrJCNy48gc12OpYWz0wKVs7yYqTF5GC2EMFlpm2TC
	Ul1SQ==
X-Received: by 2002:a17:903:37c5:b0:2a7:5751:5b27 with SMTP id d9443c01a7336-2ad7451eaabmr146610585ad.39.1772004190346;
        Tue, 24 Feb 2026 23:23:10 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:23:09 -0800 (PST)
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
Subject: [PATCH 7/7] arm64: dts: mediatek: mt8195-cherry-dojo: Describe M.2 M-key NVMe slot
Date: Wed, 25 Feb 2026 15:22:24 +0800
Message-ID: <20260225072225.3345307-8-wenst@chromium.org>
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

The Dojo device has a M.2 M-key slot for an included NVMe on some
models.

Add a proper device tree description based on the new M.2 M-key binding.
Power for the slot is controlled by the embedded controller. As far as
the main SoC is concerned, it is always on.

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

