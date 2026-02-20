Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916434F47D
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599898; cv=none; b=uCQVxipDZlE7crMnoItG21K2LbZip2UDPdtLDcYPEIq0wgdT3tfNDviXX99kjrbOKOh1XfEs/bFCCiCL002/CdPGn09guQ3E0b0DU9UPYbEs9qOQd3d3vkBIB8Fan7TJBJdWiShDQb+0BjkOLSC0xyC9Ms2t4Nqee1szIGuWh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599898; c=relaxed/simple;
	bh=Q4k1qY+2qeDncThp8d0KDSr9HMav0dIlAO3IsnJqkCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idHSlV5yHY/MCTL0LvAHStMt0ZC3qTS30eAHLCan7rLc8j8NpuNdgarZPtoqW6+8zzPFQHgSSIOGgGYhQw9VoCL8v5wXnZty3TLWe80t2J1br9rc/RIswa05b4ipW0e7hXZ/peO/9G3p7h2xn9UA5kz0IkRk0d7+4SGkwtz6OAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GoqEblxN; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoqEblxN"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48375f10628so13418815e9.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771599895; x=1772204695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXw1FfKzRF2kVWGBwLQMXuaHJG0AS6qeU677cniQ7Rs=;
        b=GoqEblxNQrs8/AulhBLnn5ITID5Ezz21Tum4Nvf8fHM+0iephPrArBPznOl5MoAusT
         KF8DJu/FZgom4PQoAmmvljQMt9fw8cNo89LLMNMr+NjYTbsVWLgrgmQsgvhr2sEbRMYI
         bvcbZdoTavp9DYnf1siZqGsA9iLnJn6Wg+oW4KOTzDFrlbY1IbpvJN5cPJ/rE0O+NUWR
         s9oGB5GnVwZiG/pQthdfg/NlEt97He8+N3dmi0N53sAA0OWCvF13wDDcSc5mFgNYQSQg
         BBMP0bdWnvXFsWQYYXDfwkFsOzjxbhC9A1PDP7bIlU1hFJYhE3TZ8DV0+z5wjKT7i3Jt
         aFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599895; x=1772204695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cXw1FfKzRF2kVWGBwLQMXuaHJG0AS6qeU677cniQ7Rs=;
        b=H5XwVSi0Lym8Dr3uGxMEg4wfeQ0qlckmkA8Ka+IZhJbVF3MWrOGA2WpUHji/9NZKCe
         QymZiDI7gEBvVe6icCsqkXhGLaT8eZVpBoU1Vy5L2nHXQ9QfV01krByXSvG+PgFctHbb
         mU8r5BjLs4B1K/gL05bGhTanmRXrM308nvlQ2DvKZ6ab4HbsNx+imAU5bs8fzPighlSr
         XMWuLkVGYUNNkVj1mpRUVwYzZ+dYJSiNAdKRXFD8oXxTl6Ylx3WjiASy75/5GN7y732q
         qNipwQetbxo4fx0COBY3hA5VKW/7GBrQFaTZhn/L9mCezgSvnK/9hB3lwD13+HJPSprU
         Zw+A==
X-Forwarded-Encrypted: i=1; AJvYcCXswSMZyG0VhHcedIL06UpdsG+IkDksjDamGVh6lBQkRkSXAF7vjQQZOrrAuXuIsNL8P7q3XjIqzas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJLGj334lf75Riaqce9vOhBNhhvm4PDCqqTQowBC+buvxLed2
	DcJwjMLsWKGieFyDXBWiV0aH00bXVU6takQXbeKrxs/ybIPGG4YbJfUGhLIZodtnJpg=
X-Gm-Gg: AZuq6aJ+uV5ak7GcmjeNqpKH+Qjy7o6DuST6lTzio4GJ7onPz+IoEaRbs+mbdQkUFqR
	8lILc2lxT2XGDiRvzv0V6iFmOuC3zQAAB3I6MN29Wgt+l/gwArt5T2QzUI7lhBLNSGiGlo0ix3S
	+GxuIzjFS3XZttVxr8pABMEznQ9YQPKe3B4zMOS2wDgHITuvgX+x61t6gGdHIInHCWkHE+FAVAC
	X+rGpMXgYSi3+i5oooRHIbFPcNjyTUfLHNGn8YStne2qGn4vmYfUONLR+iuHhDCfqVHiYONH3+z
	Qu2K5eHuD1v1iZzshsc+sxe/T1TzSlenY6Q+Wrb9ZK9/MwpL0vJ0jE5EvkfmqTkhiD+J+8fx8eK
	nSKyDAax749hATOJxVc+6qzubL2qRSIjwlqsPd3Ggz3TjhZyCJkeejmj57igtoLXUFGoJH8jwzX
	Do25A2PzN6lsXLl4KRZjBRWX3TLb8V+rLUiJdoNA7+qcBQ
X-Received: by 2002:a05:600c:8108:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-4839e63e76cmr110149565e9.15.1771599894480;
        Fri, 20 Feb 2026 07:04:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm122064505e9.8.2026.02.20.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:04:54 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Feb 2026 16:04:45 +0100
Subject: [PATCH v5 6/9] dt-binding: vendor-prefixes: document the Ayaneo
 brand
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-6-1ad79caa1efa@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=982;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Q4k1qY+2qeDncThp8d0KDSr9HMav0dIlAO3IsnJqkCw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpmHgNxJGv0Fz+bdH9uZJiuQAWyBYvq157EGpydvAO
 WnjDWRmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZh4DQAKCRB33NvayMhJ0dPbD/
 0VTCRNj6jKYPXJt85twc7hCebvM+v6agy3pBcFpX3S0lD8WYJyxCMjTqMHuAFHhfwjFyBy9FeJXJZo
 SXPXLZOvAe6heVGxha+IZehEbbQ2l6jnAaFwucsOh1lPNTwLgPxkFFx2Zo3Hm7mm6lWetBEU+5MIKL
 wSGHIhHVUCWZWRdQPHn0kx/qb7U+4DUue3dbGjsLUj2b7DyfJFpGOcWWyMpa8ZMfuFdmmzE/nbYIYC
 4sxLGVx1M+WzoGgAR6lhA7Q7SECMNmLP+/Md2+2lughy+Vv4Zn8mHkcjWYXED/5TznVKxfrQ+hyxgO
 A66Z5nIp11nBrso61mmpHNNei7M4V3WyERjglBVWuHctqaFO1zOPs3ZnQ2SRCgjz8xWiHM+DcgTfeq
 foVpccmyReBhYmOpqkHB+D9B3Fp2eS7J9NISvmgI2x4BaaHAoGu8mw961cB0RX2aGhKQNT3JmZv96L
 vE8CWXwpNMVOFHS119uMrZWP5qGnaJkzGM3nPa9sZMyzu9CBZv3x2J5QXvEuOM4RnQIU3qfOP5wNVK
 261RNWghPzUWOBEhJXQ7dnqYLlT7ucQ7oTru9sETcixPjsl5MfoQWSOicgdN8IniUToAv8xD4GFh3M
 YaorV1GMJU9VaO0DCAIfcG7PeLC93D3AYqDnYNk1n68uoD2RK8M4cAdrrXxA==
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
index ee7fd3cfe203..2fe39a42cbaf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -221,6 +221,8 @@ patternProperties:
     description: Axiado Corporation
   "^axis,.*":
     description: Axis Communications AB
+  "^ayaneo,.*":
+    description: Anyun Intelligent Technology (Hong Kong) Co., Ltd
   "^azoteq,.*":
     description: Azoteq (Pty) Ltd
   "^azw,.*":

-- 
2.34.1

