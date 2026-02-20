Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67034FF67
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599899; cv=none; b=OTfDF1r3SVC4U7YiV2x3zHS8Ynq0HKYuIz3/w7gAnaPkkDLSs8o30Jgqojf81KDTT/l7MU+qnbcnH4mqqYd0p17QW8G4BeJJSvBvz8h7v8m5EckdKif5c1yCXCt7PnNMCGF0tcVNhuTgIoOWhYJjTwpfm7IRbRUKnoW17s8AQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599899; c=relaxed/simple;
	bh=8yqHC3Q06QTVh4Rad6+0BmCcHZT4nU0kbOj9IGmnP+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LM/06rbYUVRY2+Cntt/lT5AhDD6ZKU6v388N6PGEJpziGoPfIiQcainWc5KalfIF2a+RAXMcEAV/MubXQEBrGhUuGif502rQlY8eIeMZZOIVMQPP4lVf4NlWcNPQaBHumGNKh9t/kseb59tHzATMsYw9HgbSP10ndxV5F+sSIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyWC2YMu; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyWC2YMu"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48336a6e932so14137235e9.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771599896; x=1772204696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jy2GARoXO50R7a8K0gt1dh0NietSWwPCxQNes2IOB58=;
        b=cyWC2YMua28r1tvntjSAmSJm5bhLBheQM5AD1FPNJMtQ0SyaRbN3iCcuO0XLbCd/mr
         fWwliv+FT/0E4BgU81mVVJOWFM7+v9Q3x2rNmVdakQzDveVM2V0abykO5CUxllpj9yNR
         v++i+vxxI9saSblO/O6/rLepJLNqJM+pdPfLbiFAEkvEAdF/0HgKBTNUGdT3J/gTn9hx
         +AnQar0/0Q12W1jPL4wpbSweAkzVKUhIqSnyEj/N8/CsH4fkCLXqcs44pH4iG0N0rN79
         lxrKQTRL/FbUN86uKbVU/6D9yRrwdnHAdZ1HbvRq9ZDSXGUjCfkBO0Qp+3aO9CJIZEn6
         yabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599896; x=1772204696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jy2GARoXO50R7a8K0gt1dh0NietSWwPCxQNes2IOB58=;
        b=BBdQ6xq7Pbzu+b1JUvtKzUp9A53cZykqd50wW1cX0sQoWFQ6oC39tBK/7MnRAh/hJ+
         nLNjtik/RxPuRiLzNpS1vV5U3E53WriGRBeR6MNpDcG8MsWNkhVbM7ZIul8X+pBW8w1X
         2fYuT37Xf91SkewD+h/oOig6Y6/ABQQDOepILkYhJipoze4RoJszYpDKvl5UtRbk2zrs
         jQXNNG5IbFbs3i48NRbu7ium+d8NEJmKAuVFHZS5aaKH3f5IGf7TmaAfZAKy9MewnAb6
         UH2tUu0+gbe6wCMv72R6tkrvTMYAD9JTTqLmqCasbszIytDDjSCZG14DzWVgBLeyvDcy
         waSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmb1oeBm16/DJXtMoVQRA5C8giam/iZpJww9JHYyW/TxaiOdJRqUo+fNGsrtNlsTEFVPbPXi48MTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnaDq/zZfbpH9eDm61JNYHxDJxFKHtKXMTsyBSHJMyDWw+7TZX
	A1L/MWb0Q7YPadchif2+H+HdS7P3U3toYBcI7vP8RC8/cGqXVjlJDUIfCzJUfC4WJHQ=
X-Gm-Gg: AZuq6aKboAyDE87BCZU+gcSefBFK14P8hVXGRuXfAhp9sCsHWm8MT3me8t2dCe9g72T
	ang8mwNjwkCOaQxm/3OwXWpIQkNRSR7wnZP5gSZiWA1shqf93s8BDoj4INML5sYB/Xq445V5x7O
	NGY57T8vNgT8Tn0KTmhaluT91sgAI3Y8iZa1RtM7m3MARBKlROiAlEc5B1BuMHazXKzq3H0wOBT
	PZCf4CNTixiDA9zwOgoGoIWutBhlhLmyMcNTFz5knXw78vB/CRpzEamS4Bqco/dQcWnKJo5lTFn
	O5pt9z9f5eEi1K9NZOzwc6SiqL8W7W6c+91FLwX2D243qQBcDb20XGjJEGn6JQpXt8UfLXxNlit
	k3sDMVT92YixyPR8nrrN1w3YnKaUG2l2RRlp2xBCHHFuSz3pNj3YiL66DQcC65n+RkoWie2UgJi
	gjYigizorw6sNEUqurYYZ/nPecv8vnOATvKYyAKW5mUkqZ
X-Received: by 2002:a05:600c:35c2:b0:483:6de6:37ad with SMTP id 5b1f17b1804b1-48379c14f3amr386937005e9.34.1771599895705;
        Fri, 20 Feb 2026 07:04:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm122064505e9.8.2026.02.20.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:04:55 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Feb 2026 16:04:46 +0100
Subject: [PATCH v5 7/9] dt-bindings: arm: qcom: document the Ayaneo Pocket
 S2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-7-1ad79caa1efa@linaro.org>
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8yqHC3Q06QTVh4Rad6+0BmCcHZT4nU0kbOj9IGmnP+g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpmHgN4MX3KTDATN+UnKZa9eCPfPNgJVm835Ie+gP2
 2ZitvCWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZh4DQAKCRB33NvayMhJ0YbED/
 4kpXMeGA1gUD6tjoaezhD7zsaGOM2hv59m08S+AgFJWfvhNoDFQaM39IOv1QKMiNUNsKzm6rb1f6aW
 sUdm11Wkvhy5JSxfXWigf4POVO7pa2uqxFfF4pHVLgYt2V1pfG+jhm6Dp217y3xRq6u8JphpYETj+F
 G0z3Lb23Al42gXanY59/orKNTQHfr9X3qLyCdRB9u/R2auP/lPbSJpbGq9z20I7qeiwGJREdd7Bkv6
 Lyy7wo12wtxan67J06Vh1KZgqpVhWQYjNc3Rdo0gD7p9M8SlwSsHzV//Em3YGSKBobnsqrgK0I1TzS
 Ik8V/sJsoF4jvH3GD9g2ZH9gTwP4bCxZIHIWQlDWRYZ8CevgN5pLG2MgW0ag/Ei0GO8AcVsY/Bevq7
 AMilOcLmkNUetCf3FxbV/F1H5o6uPYUY8AhQlLTUWa00TURW0lsuDktR0KiKrVLzFPHYD0IUdsTvDX
 P7S3Cc8drqMLppXOyKDKVpoFPGsPYj9uObgL3RW29jrIbJXphfaZQanLGwCGuw2uvRJa0bujpPdOoo
 xBlnGsfv+2AmiJyj3JfRJ4IuPS6isyfo3ZhYJB4Z49o/HU7Azgjn5bYF2/jdZ8bnnNwYaYJUHpbXiT
 MMNiia6R65Jfmpjqqgr7AXiv53pdC22cMULi7rBuyKwPyHTRMF4NWzUOCGNA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8650 based Ayaneo Pocket S2 gaming console.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d48c625d3fc4..dc00fd1a77b4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1057,6 +1057,7 @@ properties:
 
       - items:
           - enum:
+              - ayaneo,pocket-s2
               - qcom,sm8650-hdk
               - qcom,sm8650-mtp
               - qcom,sm8650-qrd

-- 
2.34.1

