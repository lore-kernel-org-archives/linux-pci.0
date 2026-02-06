Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EF42846F
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389448; cv=none; b=GOEKZ9+bAS/vjWnnSNXDN8cae4LtTaxVoRod+73ggeeHRC8mmlrmUP80PyWWlrV+vQPUcM5lh0ysCbfWEi15wgHlfmZRmyFZr7nCp2RoN9ELB209vPsqCPbUMceTZCfxHUetise31hX3rZej3PMvjs45r9UJ5F9cnvIVygB2+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389448; c=relaxed/simple;
	bh=pirzvUMS8i50SX74B9DHasjEK/A+JFKmccu8rvH6JXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRpLFrGKtHlZCaOFD9wEN1/Bg4HiLM/as3bkoJotbEwgHBpnQozzTzf6yA2la5LbxuSSy4tlimQp3gOYmREKoQksuy+ZzRB9FbJq2ioebRt1PSfKlk3T1HK9IZ2ggos6Jo4dc6n0od3NwZCqAEQeophGrA6b+ndd5/PlZ6L9ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w61DOjpC; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w61DOjpC"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-482f454be5bso26962755e9.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389447; x=1770994247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/72d5PFTHkT60QbelpzW/GReN1mxIpLMWRlkdIN95Hk=;
        b=w61DOjpCrOOldTj6kJXzEcy1+RRqFagslwNCBl72Zl/jsH1KYwsFNTyvalNVrab77b
         dLSLS/PGXKdiGhcy9nFPNuv/9HLZKafdVEMcHzRxPSd/G4fUHdkwlqZpyqa2RjavY+sL
         0a//fMMERPBcKzGX79TsjVJfuVZ8BCDoVBQnRKu2uuGIQVC6tLsXTtINL3cEZRPf49Mr
         M+yCjBpIVIUXLLsfVdAFHijfVIL2QXtR69ZVsPyn6J5gR3G1iheH9jMMRNslrYFtxccZ
         /lnc/xYVhV42xUOpR5u5jN1RnSDEu52cI3vQJFxJiyOhih13FHVv41+ok3JviTMjMSAd
         9uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389447; x=1770994247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/72d5PFTHkT60QbelpzW/GReN1mxIpLMWRlkdIN95Hk=;
        b=UizPPOQzQcAFLjngz+GEzIlhFDPjaqoUtKbqY7o4yZToUiox+LcJRFIef5QFMpcTcO
         ayWhIJBWEqlYX0rOHj8KBgY9tsgTGAc+D4f6MMn7HYc/xHHzxpt+SVFdGSzeHQBS4PcM
         WyubZJBA0Uo3kGGOBiZfOJLU/ieVfPmthsHJYsQDHvgUfyOVeucvxkxHSDpdutJSTJqo
         ZenZDxhkeTmXIiFZBESL75jpfG7jWE6KcOw+NzFQSz49Y73QPw7IrTs4mhM05cwQB3nc
         FA4ZUQl31/AnwjgnxXf4Aj3eJUPHQVfKoCH2q32a/8Kid3aLTdiLL4cvgwgsP9O3qbu9
         sCNg==
X-Forwarded-Encrypted: i=1; AJvYcCUSF/Ekf7Ds7LyO70dOzfZU4i2d71ytNeqBbm4WuAoQVs3d4RlCymkbWpKzhk4eb8362OkyK8bF7K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxECGEGv7m2DmUEMIQCkDq37FtsyfP+dYeJd4cOuzKli6IbBTg
	O+BA5mU1aeBg+lWMWzZ/+LXW7C7Zy9Ifm7nosJfgNNcD1dV0Mv/I2se9MRbOT9TDoV8=
X-Gm-Gg: AZuq6aLA1fq5bIi9MWZ6ueyPP4fowfuSDvqFTXKy0g1JyE68Sp8KI5vUbr1SCaBHzYp
	SIzqL1YhLch3msGSn5M3x/mssc0ZQOZS/emHAdLj+McOFgJQDyy/SJDC9DEl6Qhj5nmiMl//Hfu
	sMcwVdL5omJMjiDFqWH45S4S3plJ3MznVrGW1dcH9pxaNnPg2UZWmOGI5RsLsjH48URNCOpKKnO
	NLh5xtAwLwXhhyFUXeXtBQXFKetzr8f94eaJcoU8rwmi7+uqf+TFuniHgDgQzsfExoM6HoVjTSb
	AXtS9lXrVe12HgwoUaOFNIwn7up1hXZFvStw0bqDTuKUj0RaqZhEKmZm8EJX+aEkVYOVsnQ6HIH
	ku3V7dfel0poeK4m3ygKxyGBzRcI9ysf6jkqAw4dUxkC4Q/godLqGlk1R1kFLZ/YWDSEiiW4BSX
	uKMCMckmdk/gTZn4MJ3C54AOwyqt4ixvF7
X-Received: by 2002:a05:600c:3e14:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-483203db77emr42394815e9.16.1770389446464;
        Fri, 06 Feb 2026 06:50:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:46 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Feb 2026 15:50:35 +0100
Subject: [PATCH v3 7/9] dt-bindings: arm: qcom: document the Ayaneo Pocket
 S2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-7-5b79c5d61a03@linaro.org>
References: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
In-Reply-To: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=716;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pirzvUMS8i50SX74B9DHasjEK/A+JFKmccu8rvH6JXg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+8LIVwVOGfaj8vA8kiyspuw1o2XKUl5qHvBU3G
 YjPBJeOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/vAAKCRB33NvayMhJ0a4ZD/
 kBUC8ByNS0Z8Z5TN3IU/BTmOXJ0muNmK93A0saVzteh71XXt1UYFxQdDpGOVUgGS17Ml7LDcCSpnDy
 n8DkQkQQuUQYbZAS7zKZqMft0O6D0ABRS9CW5HNqPIhwyJHXhoibqLs1KrSY2xFzZhwxdyLHgcDUrW
 dlrRch7T7JdIygSFiTWzsc1BCaOC44MzEZQQ2hA9avqObcNKHrMrjlbAqcuY3u9JNXD8TXK6PNFsKc
 1x17X7B7ZWdh9xVvT6dwZqXaNCejL94wWvEYFjVqo70YgFPcsmDYcw2dCSEKH/pV/7Z8UOmdl2Plbr
 O3WOBhlozx04I8XWSrKkQ0KZJ3OREgz0LqfOgVVTSOKeUbRMwSN0mUzRxEWuDItyxTndSMvgDKaEPX
 pXygzstIhoYOGMar8ZlcJApMhT7xq9iW+JVLfdNIHoWQfU2+Wgc+zYES1gXBV23C2X5X5eadvwHk5m
 8c/aDlNqYiDW/z0Gi6FxTCL0wHo+8KKD59/SIoQRBpO2AfWiyc7lJR+VAaDsf7a+lJMHz7hfbdUtIg
 rJ6C+T0YKfzjO0ak/CMsGPIEEFFyMASlz661ELcYdJqEskI4+4udHvh3DY8KPntKPjehmrmbp93j7I
 J6/0ra7CTmZdAQ9G1jx5gSfAAqS92j1AjdxlANKszyhOSLylRTF7+Wio06kQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8650 based Ayaneo Pocket S2 gaming console.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca201..351cc2eff14a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1042,6 +1042,7 @@ properties:
 
       - items:
           - enum:
+              - ayaneo,pocket-s2
               - qcom,sm8650-hdk
               - qcom,sm8650-mtp
               - qcom,sm8650-qrd

-- 
2.34.1

