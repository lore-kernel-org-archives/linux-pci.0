Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37964426EB1
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389447; cv=none; b=bizKCDHbiXHNiBh+jBmgqqJWZQkDlrX2CefMfhBofKd4fF3DZwL/EpwuQvrt3NA6Vb06cPZckGDzN/oPJEaNU43YYxF2WzzcS+Pp4aN7/HsxX/V0PpvhC60R8lGM7AfQDeY7OAwK0mA5I0Pw94xwatlCf9pQkOSGYhfGeDEJWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389447; c=relaxed/simple;
	bh=xjSbwzZtG5gO7c0c14CObzQrxd0ynl2lj1Czc800QEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kex9vM/8YFvu28NuuWYGefnIgFIhoeeT4FqeYz4HY1xd9R/TcF60yKyq8IHDTNAtiXGrIy+UymxYtFmhnXxLb6Scdf2UYnLxS2S38txRvjnqCRASNCkFEx4qK4DG6djGEQ0aTqkcpVUeag9YP1yjWbxsRPatMAyC0r2ZIpE00Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0aorkFC; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0aorkFC"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4362e77d7fbso346013f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389446; x=1770994246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/S0eg0m7isWhJo/g2N8HxsSID1GAb0gdwF9PpLKomXQ=;
        b=i0aorkFCznCoPibSub6kpOKyeDFgw5BAx5m46zB8uf0JmChu/HrIa6mLHKmJSJfY+m
         6rBYFgwgO0q6FG4WvR+q8EtB7oJaWn17GJ/GZIkWleOmyDAyj4mJmJ0uaIrPMVkR2Soc
         VSYQMxUvKzoMw5S5Y/H6hHwckh7Fok8SghmJRtbxu1TO/8bno7LNk3ZNQWEjdWwRJdLB
         tCV2tKH5QlzL1k6BRhICQmzaToV0BX3vvKZLfWCkFoHeGYHZZug+1nrqIioAFo6A3B0J
         XC0r9UvK9B9VcxGoOKByiKXfSAcupguIGoF6aoIQu/sGan3So7ZLYq5hM0VNsanF74L8
         hEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389446; x=1770994246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/S0eg0m7isWhJo/g2N8HxsSID1GAb0gdwF9PpLKomXQ=;
        b=SyRLLlj2zlKPXIm7RScQ4I5kNRKbajnbsKKhqxEun9XwA3j8WLjCg1/O0EVYx3W2e/
         OfH2YsTXGfMXwQFcRmptOmxQvS20LHy4sekWVa9X+VzSjjvJ3rRfLWq8+gDm6z+upXqj
         PqJgPz6ztQs3WGydRQ1WtGneGMIUGunmikBJLmB9bVOpozx4KRwy3PZxltGo6kIx43gd
         czjqZs84EIszHNwFnrQSE5GDU2V2SaBcfuyT/UsuYUVfHAJQKFBo3yqWV8fW1qk0ZtNr
         ZJaDjQIu4Bdbiaz6bFVbi0CNBd44Mzkj/hMcHWc6jom+/3Lr0AKOLZpxPlXfXWHqWJgS
         vjAA==
X-Forwarded-Encrypted: i=1; AJvYcCXC0f9bRD6esoHZwQNEMUcXWcBj7HtVFirzzb2Ikxb9A5keABQqmCb4BK+BTR/5d9u6DCGK8ruH9IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6mLIrrkt55htxWTYSNrqP+qCOPztkYP8gdCPbMDEqRMPfx0S
	oAemUQVLt88zgkTjfEYukkNUnIZMfhbMSJONtZK9xI1Pf8oCorLoKf67LfJ4+OOLzvA=
X-Gm-Gg: AZuq6aKhPSTvo78vjxle3qChImntNiEzeGTKpVeWWZcpv34IStr1x6KoVP2Y0Lo0Wuc
	BzOszbH3shcw0CcI6Hyo6dWicpc9ekFDevyI5ZUKdyo6lOTE7C5HOKZLrktyCbpvJ1AAAl6VheX
	JAmvnM0Q1twytv8hbYQHUUCehHWzoIZuT3DWJW6nzBsa0qmRUxqDKvm4KgRndh7eieNgIM8/2Qg
	hiETd40qb7LkHXA7rNwV0vMeSZY/VK2b3FA2ElCUTY5Fn6baGhgus18JMLz1rE6AW5Rwk5gi5um
	nh/B/tQTlQHQqP3HTsmI2vETMdP1SzZpmPL1QTVaNEU7NZJjMrb6h+gOLUT+ubAmYTO1XBdcrsF
	Lu80L9sVZNWoMrs7TDOanLMc5txa+9P5vFukYmPaZCPnr4CxNc3MTfz8icLFwHmG6Sw4tLB2Ve+
	fLltXAs/YyhDcHuyOWKX0kqfkkFDtvIF/N
X-Received: by 2002:a05:600c:3f08:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-483201dcfc4mr45291315e9.2.1770389445562;
        Fri, 06 Feb 2026 06:50:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Feb 2026 15:50:34 +0100
Subject: [PATCH v3 6/9] dt-binding: vendor-prefixes: document the Ayaneo
 brand
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-6-5b79c5d61a03@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=982;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xjSbwzZtG5gO7c0c14CObzQrxd0ynl2lj1Czc800QEA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+8g+1NPjgeJYwBAdgU+CA8HJk/PsNY/WtwXdyu
 i3Q1KXSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/vAAKCRB33NvayMhJ0TJiEA
 DK9zFBLu9rmXyXa5in0iqKaKheQVxSDqnHAbfbf3BXqiEmnHuedAe9egyNmclZSJ4NOohRn8GVe3pk
 ztmewIdHh/6pQLHWjZMt8i5/l2vXZ0wosRXVom0ot+22LwCh5oufi/RMCiJff+JhdM9Ru+epbf3KFM
 J1s1rIUMDnF/fd5N0Eu6BVklVQh2UIQCn0C1Ya4kAhj/6ElouepZllyAR/jaK5H6z4pNuu14imyfSW
 38xlF8sBmpyXsoYXTZMRqe61qh5eR02Q4tZHjrK9QGPMWJkUtbKf1WzwJZ87M5O5aLuqnJtjTlv+j2
 NTy4RCxKQzMRLMK8qUOFZ+bsapALsB1ZOstCRRPKPCZRJgwLhkiT9kWltlsVqgj2yb1gaALM4MndTc
 32X2SgvyxLg2lrxXoqBZUdxRx1ZJDSShwWZdZo8OyISYBoPbwEx2ZuwhWtXft1BHvjpvQlFLhkS1mP
 nvyF+1u5TbBY39cCom+gUh1Kkwx5o9Tz+w2+pQCAm0gUNuakVgGe8ABOHnPo7m6TrDtP2mHZByH3oC
 +7hvPhq+a1J6jKmkjqQbJCYRkZvAYykYHoU81FiPo4+EaOU4yVZkFXxOqX1Cm45FDeFk7N6MbpniOk
 zRFxYjShLB6j8itkdh1lveosi+F0TgjtrGcm82hsfNFR3yFBVTGjWvO+b7og==
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
index c7591b2aec2a..45fb1a3a3a06 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -217,6 +217,8 @@ patternProperties:
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

