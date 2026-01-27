Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3C3382EF
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507871; cv=none; b=le2yM2UBfzmUVJzx7EPjcLDN1NRxMYRcxpiK+PKXio61b+jj7APIwrhHgzHf0EpJ9s/uXv+a7YiAHe7aHfJX208UrQsg9aSf24OomHPutrRQ3QNw2eQoFgI2p3MhwVgfHcTdKqj0LLq0NGuEciEF+adBuhzbjh93ONXX5ZIIqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507871; c=relaxed/simple;
	bh=fcj1K5xSZY2CMfrsTNN0Bq9cIxFPL5cWnSbqgyt59Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=og6ThRmphDfXRHgX5OEljvg+iqOh0EvimWjY4DZYHvRUNC3xRyHxcLXaSNMqIjeBPXjRDGxFSyMifm/wCxqpQ0Zoiat+Jf3HlNggIoeZuSasvwNMoh5HoaQVeSSBACymjUvLtDy375uOj8D54YdAG+LC8lksg8Dy8It+OWkxhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DR0DNKFo; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DR0DNKFo"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47edffe5540so62106305e9.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 01:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769507867; x=1770112667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mro/HVDsckTjaIY+Cj9g2EfEbDMs6DWKlUVvgKAipvA=;
        b=DR0DNKFoIY5z2OXNJzVhYHQMy7AJIvqVInaxb0fhHCKzEBun8sLDhU8lzRAG8H6qRq
         Qc8ZDpbO5HvLqmrSRzu0C9BfcuWvjy1kMrskGZnQzIjjeSAMQtijmHCqKyVFFmC7wtA9
         v0U1Dr2BoOe68x7gOgnJPXKN+8fqI3myUSZxxNq707Uy8lTfX68P9RLvLAxn6htua13o
         xWDmHpWBEUpz6QI8B6q3EsCuM5ZvNwGzlV0MpNC4doLWxMxl8LQeNu9SXwwC8L3QlDon
         /hghB2DIKmT6HeXE9DIhYOSyabRk0kUO+o4V+AZWj/0ahVxvASyWqDFdtXopeP2FOA02
         rFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507867; x=1770112667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mro/HVDsckTjaIY+Cj9g2EfEbDMs6DWKlUVvgKAipvA=;
        b=xSg8BQ8hndhSGbPmI9hCLLPTbH2DueJG2CsL52ESBl/284us63a1EwO8+PoCzJz/j5
         7STFRATr5/v+dALOVUxRm9tmRZnifbEX7SncgaMxd0vfbqrOx/bdA8GWG3GzR1ed9dL5
         lJgT5W+zBPcMGQxpxqrGf23NnEdSXdYqq069d7I27ihWz+jx+BywM0lepE+F6mocUQtS
         jjMOlLbqkMJqoCL+kgZTOq4+o1Vtuh6/4lD7XBK6anUZQjCQPnvXZWu41VVnG5HtfHYA
         rMdwjbR0bliEJGandAOWa4OXVAUmtzZYzSca14LlijKaH7Sgngw9Pi/aLZxYlSWtZihm
         Zurg==
X-Forwarded-Encrypted: i=1; AJvYcCUcEYvFLGKZw7XURvPxNv/XvRVwxhaqiWLyjIqHWnyOiHqtxff+wrWNTR/uyvKQy9ObYikyb5ob7NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkwrylHKLSRrlvY782l1SfQx2Jm4frWI7ZRjZb+8ThSFmR6RLa
	udp4gF5zQITIKshSnpXx5JMVVAlJzpJCs8LauOfq+SPZ06BEf3UcUjoFQp5pD96obA4=
X-Gm-Gg: AZuq6aKgH67uIIsEvYro8bC/B7IwIwlNzKty4NSCnc1OyK+EDYAHVc512khE4gkB4T3
	NurbSHJQiuE2xpk/7S6WqTmqXWjs+jafo4/ei77VHCKOIApje2ZqpnJoiBtZISpWTBe3pPF73Lh
	4IU4q+swOGR3Xu43zFpYN1XzyX2Y+iHgGQO37Qx/lyXNDs03CzJFZg+zjobMI00hwJ983fqH1CP
	vuNfm+vjzzJqOEVtbuLwROvm8ZirXGU2mn8q5U1/NqyzYmLjritego+NMZ3TUWe58WLayULoHlT
	SdBfFb473rUFCnlEvlh2MCjobd638fUgcS7LtrW/j6Z+JBj1t89VpMOdlJT1duYWe+dREmxMw3Z
	eVZ2oBaCKbN1V+Rg5CjxjL11XnUWQJXdxxiVX56YceHH2Ljf5Wa3CK8epRa9RYVkI1eTOWpELPp
	bQ6dTm1kwsJtM7aTJb4Lx2mfr0re0CpJk=
X-Received: by 2002:a05:600c:4fd4:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-48069c98e19mr11551965e9.34.1769507866543;
        Tue, 27 Jan 2026 01:57:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bf93cesm49056225e9.9.2026.01.27.01.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:57:46 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 27 Jan 2026 10:57:31 +0100
Subject: [PATCH v2 4/7] dt-binding: vendor-prefixes: document the Ayaneo
 brand
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-4-c55ec1b5d8bf@linaro.org>
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
In-Reply-To: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=985;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fcj1K5xSZY2CMfrsTNN0Bq9cIxFPL5cWnSbqgyt59Gg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpeIwTy1WJEkWNVBZZ8GsnLPMgeoTuWCtSL4q9ZjBA
 vBm3YM+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaXiMEwAKCRB33NvayMhJ0YdaEA
 Chfx3yxxt8m0b/7ToR+hIGbpDEVi7dVvk6HKyCCaysmFwc2cME9eEAVY1DDLbe0Sp15ZqVcAig2Ely
 ueoQa+X/k7gq72oejejmwrUHBpFATZOTgbrz3LR/V8lQLvDhfAv1qiDCYgg8u6G6rkFFTjMSUSxzdP
 3ZuRxvVH+Vtcio7JnzBXwwKr81foFIYPmO6JKZb9aj+cJERy/L9s3TJFKClo2oo02X7QLnm3EdRChk
 q1E327z7zx69Bi7fB2LKQwFZtedEPfx6JpN5ozzrJcefNAu54VP0msYBiOx1F3WLx36f3gwa3VvT0d
 oA2xRTNH+kOKLKEEpAywczEpr4ZierR+1aHP+VdsUlkng2IoagqYEbXzA19LkvHKwLjiLmtBlNLkFZ
 6dUoaVzya+MF0iLBlW4zAT+xTidSVe0j5htwHAg2qo7OaUBf57OFty+TjcvKK5JcrCikSDQpHV9DYr
 8LX5fn21nozGZqcOS1BKfFTE7yx9CqqMRPnfFuSBZMWB8x442MjvnTVQAQKf+li85BD/fRD79eThwb
 +9vyeYty8GKTfgIr2HfUNKYl5FHVWa0v2Af0wkQgtaQhdMQd8ygTDtTspYpj+uEC9y6dTZ+YosqxLu
 CZQfK9wFEx1ZCyq4bdFewiGlK38T2VvDZfRGHWC1+ayaebc0iciFDCy2xzTA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Ayaneo from the Anyun Intelligent Technology
(Hong Kong) Co., Ltd company.
Website: https://www.ayaneo.com/product/ayaneobrand.html

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c7591b2aec2a..1f83979e0d09 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -216,6 +216,8 @@ patternProperties:
   "^axiado,.*":
     description: Axiado Corporation
   "^axis,.*":
+    description: Anyun Intelligent Technology (Hong Kong) Co., Ltd
+  "^ayaneo,.*":
     description: Axis Communications AB
   "^azoteq,.*":
     description: Azoteq (Pty) Ltd

-- 
2.34.1

