Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3B425CC6
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389443; cv=none; b=K/AiVtO6jmkExT7MuC6gdSioiqzTpBB1n5Sb+QQ3/n+sC87u09SGCB4jv1l/rdqMXuGEHHTajs2ErQZk6Cj7KGwih2euZFmolivURoqi8CLN/zs4XVbIN0SD8QHXiw7BzbQRCLenJ6OAGWHx6m7bSIWBpXA4wNB1YNFvK3dv3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389443; c=relaxed/simple;
	bh=33n8yIN+nVndHUM92vsEWQbIZQCGyEl0FMmvY5W0kN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Svp3kX9V/6LqSLkk5FcQviB6vS6muxhNUqgQE2eC5HK0u+k2Unc1fbXZYQjGucE0XcnRFi6GCGsqLdpAXavaZOnYRMsOBPRZV6E4rNaEPRMzD3NIa/eiCCoW8U6yR3nnHDQNK6zberqVt9mlA4lzfF+pZ8kYf8R41UqT1cMDAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pIWoxU3Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIWoxU3Z"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-480706554beso8442585e9.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389441; x=1770994241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jYI1uALYJkFrAPwPw3yluO6uCrxkdhLf+K00rEaGlg=;
        b=pIWoxU3ZxjGMqR7oN9B8mOPd9Z2Wq/F6XXZHPmFus4jVNo3JlS6PxYNBMYfe1kVc0H
         gAmvDD354q4xIkJld53LTeAWdJIT/hVQdYtaH9pjoZ1zR/TL3E4YZqU5fY70wmpCZz5s
         xZlGkDeKetFUx1pOA4GilIemCaDeqQclAj7SvsqhoJxCnZUsFgmsustfGZW/LbwT+sCr
         pHR3ZJ5J/L4olbo7XJB2hnqAWrsGuI5MW2NRqqBcifyMmwU9yTYenYjZrA9EeqILuARa
         DpKTKYNYdWInYIYZLhw//zfB66/DwTt5sSvqDDf0NnezJr2bUvQlzmTMm2NxVJPyMbLU
         AKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389441; x=1770994241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jYI1uALYJkFrAPwPw3yluO6uCrxkdhLf+K00rEaGlg=;
        b=vXti5C5A5BzqwftluNCo4KYurq0kqhok7mM9SrLXDQdbGyab3/XnoCyjl+CScovu+c
         gx+9RQljowc5Ezgj2tZyKdwUtCyC9wNJwpevYyUAelibLRshx93EB+34iNlbfIfhc3Tw
         8WS3IQ2QUABM+sNMrRfl3/VvUls4hEKC9c0dBODlJcZhlHEyjegnwepPUKdNDXIiTUPo
         U7J1nG7+rJdlNQwa5VvYr9jEwjuLY38E8EWLyE7HLbqCE1ijlOY8IHeNVqUTYwWjGd8b
         6JVikjXfQhF6sHBFI/bxsv8xETBzbvDid81OAcL+dKH1vZ7j8UlyTuWmL/n3UXaWMWKn
         gILw==
X-Forwarded-Encrypted: i=1; AJvYcCXmjc55qngv+ePEn2NATAUNgiLf5zBeXFetHuvmezTk4GENl/JeFnXpe9haHGMHsISPxCDGDfc2cWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQ3SRs99YQqxTQNc84/GnzuoVmmwLdvaHPwkEr91A6Orxq/vn
	8nPuUrQ16CORx5FqK7rv7f3L4jyfaFEfWQ4kW+yAFDp69u9nw2OaywVyLRbGuqqrQbQ=
X-Gm-Gg: AZuq6aIpJiGN2jQWZQm1eE+s63k2RSNZPS42/Upy86aW0hQu4aG7tTUSh4+Vs46KX13
	R9P71A+Vq0aBSBDt/qFrwonXyivB6uovLzmeBu1BXjdZo1+FJp2R6m2LXQ2Qh0ZXGzCCIY6CP9K
	ktjOiAIpwzuEA8XLr32Daak+5Rp2W+pd2E1j7eVkylEhnD1fHkBJta0MXkfOkYY5KNos2Wxi6Zl
	G6Or8ZagcNLOx1ywPJVhl5+xpjx4u3Pgd87SH5Z6Vc62M/qDRCUJ0CyDdJKV10L4P0eWGgN0ASQ
	YuHHl9jCqTJPj7CVyJ/2w7JAZ4Bk0yEID17tDK0LusJOrFHC+9HmjSU2BwP0f9V6ho/W9DqGz60
	WH17MzQc3rQn/p0vfc2kcX39tIFsHpeSYO4/jFgPmhmOk6riCLJmcJPFFnmM2RWRs1/zGxaKacv
	JZ3cVcHKmLqCQZCla+Sm4XZa/1NfK0P6x+
X-Received: by 2002:a05:600c:3553:b0:477:9976:9e1a with SMTP id 5b1f17b1804b1-483201dc5bamr44985425e9.6.1770389441261;
        Fri, 06 Feb 2026 06:50:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Feb 2026 15:50:30 +0100
Subject: [PATCH v3 2/9] pci: pwrctrl: slot: fix dev_err_probe() usage
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-2-5b79c5d61a03@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=33n8yIN+nVndHUM92vsEWQbIZQCGyEl0FMmvY5W0kN8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+6wfd9X2ApDg141fdSpbDng+mO6Z+zOXHu9eg6
 M4/mWo+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/ugAKCRB33NvayMhJ0c/nD/
 91EiA3VEDhUX6UIxmCvfy9W4XChkZ1cEtc5g8VE/cQHAGkWoZIL91prNqzrXrmUlPenRlsw8fq/b45
 iDe4m/UwhnGI+dNzJEu0VzEddTbWZxSIkbCFkKvOPhFt2U8BFNFOhlyZkV9dUEWvRkAAlrWSHFMlNz
 kFcD5IsJb7dskSKhtbpeSCS3CoP7ORsCb3QumrzrLXBVHj/uKevbNjO99n3M80ucYUi6Vtdk0+eWb6
 YECx3oBKx+l5FTNm5ywUPrwXSViI9gB4mQBWu0hZb0vwHh0ybA13JFezljGtKmuBmJjdVccyD7MVVp
 HfDQ1OYUcX24Blyl+uwehjf3cnreBtsiln5bSp9M44GLxXkzv8few8SC5+gdn2VFofFeZpQA/c1tdW
 Y7DHfZ9Cf4PVKDnwNcDSwWdDUhJa2HqQH0RQF/4cWGMEfA6DRjy1Doxvf/Wg7CNVUkXI0r8mlY0w5U
 4/SYb23Ibxkg2aT1hxJkog6Crwizr7R8MZr3uaBmrzQobDvZoRcRQN7/VjcnWyML3xgapKjZEfPLSH
 gxUxHSlu6vtKECu49Hr3dl0ngZdu1j/Hw8OmAi2KGb2YVJz0yYM1EPxK4PHUhtMeHZGekDAHJhC32O
 1nx2BwpXKFT0B1UekV4lCL0EY86zq8rU06mQyPZL/M2/AvFdx+Nd5mKcVDAg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The code was not returning dev_err_probe() but dev_err_probe()
returns the error code, so simplify the code.

Suggested-by: Bartosz Golaszewski <brgl@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pwrctrl/slot.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..08e53243cdbd 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -40,17 +40,14 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get slot regulators\n");
 
 	slot->num_supplies = ret;
 	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
 		regulator_bulk_free(slot->num_supplies, slot->supplies);
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
 	}
 
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
@@ -59,10 +56,9 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return ret;
 
 	clk = devm_clk_get_optional_enabled(dev, NULL);
-	if (IS_ERR(clk)) {
+	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk),
 				     "Failed to enable slot clock\n");
-	}
 
 	pci_pwrctrl_init(&slot->ctx, dev);
 

-- 
2.34.1

