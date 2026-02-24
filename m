Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEB396B78
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935626; cv=none; b=nIZ0wrIOjk89VyMpWhP2K4VRu4plv1GihJCKx2e/QYBTB2r1NWk6SxHxAa1jQ2HYQYBQmPEJejrqEhBg/VcL9FBLlvtrg1xsnzf3ANM/HM/4Czlsv/muu4oKcnlqhnWy7tIfktyuOaO4JM7X6F1QqE805qriCLczJ/V0W9r/Asc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935626; c=relaxed/simple;
	bh=Vlv7hjadzolvGAJw7ypQeoRDm1X9EIwDs9/wBQrRNZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZjxgR6wMMhbpGJEeq2nweoFHPxFuKT+VVD+seVT30d4TwhlsOFMhBKMh6K6RTnt0BFhYV3eMExc4Avm4NL4/aPeeuaLmCHNr7iKjnPtN85HtYbHOpGKrFiMqVK5VXDXlXd+1zGO8xxHbOBcpaBJZG5A9byYUJ5GJTZPQqh76lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crWRUl71; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crWRUl71"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-823075fed75so2464165b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 04:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935624; x=1772540424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDJ0Gfg7oWDz1xGI8ZNNKjjsgjUS855MyxuHLu+cOXw=;
        b=crWRUl71awcjTgB76VKouvnpvuiOZUl1y2antwG0t6P7OmqbLxZodUNKpnIVRdhE0H
         EXohvyKwNI6ORwx9T3EdFFglU73it1amVLEUTVVR1+vmHWBCOtYdjTSoQgxN5YhaVe6g
         LC5U22NTl0bteIkmzdvJIqMYsZ/dders4lUOyj5Ukq+/6nnexOtXfx12fGeoRnhp356x
         1eiSzpDLIv8glt2+WpTC3FNpG7+njrKjs6ac08iR/2yg/+vBs5WxV8/CIqhO3Xkz8GsC
         llelz+oG1oSHrdDaGsLB/Y86uzj6r8LFv3td/cee2qKpqFi3girZsn8CTDNMjGgOxRmm
         8zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935624; x=1772540424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDJ0Gfg7oWDz1xGI8ZNNKjjsgjUS855MyxuHLu+cOXw=;
        b=OxTPtJfrrgOP8xatq6PuhFA8ZkAdIZlGrzwf9uELpRS9USxdLAHdKnfhQndsRBvgcv
         e8F6Ad3Xh6/QIgvxg1wGlk1OCZRFZ/QtZM9n8AV8TUqrTnEtmYgxeutjfYJkpWPLuteg
         K7KV8CMfZj6xnsclP54OTVwbdMEbKhxm+dmn4Ou5HJgpHv5fhmN6xvL44wjPwn1h8rhd
         JRAqGOV9DZf5WiH/WKyiXK5nxUn1lIzaYq0LIZFDJScBueRqjRGbnZmZSLMXOd81J01Q
         MX8byu6y9WUONpP/MTtf0XGbyO72UJf2BnqF2r6SrR6EdIFe+YzWuevVfGOMUziCtt4Y
         schA==
X-Forwarded-Encrypted: i=1; AJvYcCUqtRV9S1JK0wx4qHdjgTJDreSxCGi+/oJSdCetw7/sn/meRv4vWCDHI/0K2xTiT69620rBPXEA9iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DlE7jN1bYpaZx5Y5moOHbaDgIPFWM/ebRW5s+81oMxt/01ts
	5TacyVxaDfQuLkJPtd96wkzUhQxUZTsUbZNTmH6OiVcAkfjv8HWvU3gs
X-Gm-Gg: ATEYQzziPANcdWVIK1+hJl0sTKnHDfJ8eRNwqXtJ7orT4exhunF1jhlVD6ydKtHKFPM
	MVCS8pkkptNW2jvBAno5fUSL6zTPiStdJqzrRkiE5vHoYD07vHRIWkI1mKNV7uVcc0ghUdFcc3x
	WO2Q1/X0SwE0+hYyd42gqqxlXGfQudJl4YXNCliduzKNOf38JBpJ5DCescdjMasXSMECQ6DA3Eb
	hv953gUMvtGox/sDtQTd12LDCBnFQVnjgDRisRG6TTbi7RR6ClF79DZQSeZZeeuzXk1LETAPqMK
	s/CWdU5mVI7MKm/LTwfwO2jVK21i+UEjcKJQNQmXbvlxlvRdyp+uhPAuQBPAHDVDVZLZJJaDcdy
	9lXD9UIf7zqgNH+JcZvq54tIGXlEUjE8boLvaSdDV1QZuO95CCKelUT3YpnCCyaLflaQGXwvK/3
	PB+LbcCvuZXh3jAbEf4aVjGX7DnGz6dw==
X-Received: by 2002:a05:6a00:198a:b0:81f:4708:b46e with SMTP id d2e1a72fcca58-826db8c010bmr9648841b3a.20.1771935624430;
        Tue, 24 Feb 2026 04:20:24 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm10613950b3a.50.2026.02.24.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:20:23 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 2/5] arm64: dts: tegra: tegra186-p2771: Fix invalid PCIe nvidia,num-lanes
Date: Tue, 24 Feb 2026 17:48:58 +0530
Message-ID: <20260224121948.25218-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224121948.25218-1-linux.amoon@gmail.com>
References: <20260224121948.25218-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVIDIA Tegra PCIe binding schema (nvidia,tegra-pcie.yaml) defines
nvidia,num-lanes with an enum of [1, 2, 4]. The value <0> for the
pci@2,0 node is invalid and causes a dtbs_check validation failure.
Update the lane count to <1> to comply with the binding constraints.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: new patch

http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml
/media/nvme0/mainline/linux-tegra-6.y-devel/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dtb: pcie@10003000 (nvidia,tegra186-pcie): pci@2,0:nvidia,num-lanes: 0 is not one of [1, 2, 4]
        from schema $id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml
  DTC [C] arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dtb
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 8b3736cee323..b4c6bfb09ce2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -2433,7 +2433,7 @@ pci@1,0 {
 		};
 
 		pci@2,0 {
-			nvidia,num-lanes = <0>;
+			nvidia,num-lanes = <1>;
 			status = "disabled";
 		};
 
-- 
2.50.1

