Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCB4218B6
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389452; cv=none; b=XKOCLyw+IkACufGDT5DhCAoz5TEILIcpphkikTlXG6/qgKYYcutLPMyc1t0xJHm/vezWiyAn3YRupMmX1+n+KormDb4ngefqOUL0Ra4TB2y71w/PckaMcOHGZxiGBCtitOtUTH0HXGdkcWoUB6fyJY/wCzXnN+Rf4jwhUmi/XaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389452; c=relaxed/simple;
	bh=UhlMaTJRZ9fLa8E4fuLuIg9nXiWgxX4wZpZOm+FPpVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tddwKk1CJkCHn31B9281Yqz/ZUiYpIFCCzZr1SCvPM9ffEQnq+ZSvT6pUXr7nYaTMOw5GCDwHvYblGA7xdMl6RCluA0UREAYoX3WS34RDTNGM1neL46a0uMkgZAvRytTJpZOVaD3WII514x0De5jV7FKsnD31aX7ppRGKYcKgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3F17T1x; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3F17T1x"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-480142406b3so17957905e9.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389447; x=1770994247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZLm3gI01t7k0CB1F3RPdej8cy0OV8XKyJkxMLlBgyY=;
        b=l3F17T1x5KmKDPKefmsOelWKnrkIGrn0+Tr36gcjkJ6TFZrRVMSXBRZcYQdIEJo0Zz
         KDhSIfKvCYpuEQo/Lw0lgeZGJWPF64dQy2R0B/CHP+sBTfdkf2E0sU7F7X+VlP07K4Sg
         9OGVa07wG8/BLOdb19Qy8TM46vtJiGb7FRAEAcaaaaHiBpYB1/XdgCT9ZFJb1hFpvzqW
         nZwAyfNIfRJiGeYWweoQ9UYHSfxJRFOrjPZusbyOCxa37cmB9io8WvLUogWe8kbFvai7
         yP2D3zeyP6vwL5bDnmjXiv4W1kqd3XTzh0v/tEPl9Ecm6dzZOI0Yea7R3Yue6Zpioiu+
         YDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389447; x=1770994247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZLm3gI01t7k0CB1F3RPdej8cy0OV8XKyJkxMLlBgyY=;
        b=ENV0sVAL0ccNHkQjksYOhFRA3c60qoegZ5YO0v5Pia8UHKPXNig8q5VQCnW1Wp7X3N
         Wp+8Nau+mT0oCnaDeiUNfsH7ewNcfNcP+DUMjZAtT71IQ9kQBqG1BRy6bTapzP8/XGob
         R7isc8jmsU5BBrmvnEdypZXjbYhR1opPC34R8AGUptKbKcb0J6n3VU9GDYksjaAf+rUy
         bwhjJqQhYRKUbFD9d4WqocoZ51PAS7DzXfn4x2Zv2GyHPoWMEwGGJXwxPiFTkAw//bAd
         CADRdMqVrVwpw91n1Hs4dxLuUKhKIgfDDNBKdCRkp2nRH59HEaFBIIhOVSbEk92u6ODn
         XenQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4QFEU3M9O3vt43i2+j4/0ZU3URzoDDz79cG9X03MP741FjAQ1v+n322Mo5wsPe8ramzX1X/EYIjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJo5joXPvU+J0I5yFwLjgNFEb8s6FhNplpWi620rT1V30OueHk
	xZQzz4RKTFzQAE3J4SKLiA8w/lnI9JK0BjyoxIBpLD0Q6LfPCaPErletyNz9JXugrps=
X-Gm-Gg: AZuq6aLWejedBDsAf/UilC/pxOp+jptWPUuv5p2gnO1auEAzoJtvq9FSHeXhEpTQFkM
	/zh/91kGvnFd9pm+mCFEMhsXKNHdKHKCky1tgGKAe1iwd2kNysW5ddgSd5KfnS+A6b0daBNJ3us
	7TL5WoidVzQzWLCBqzvEvESlpiOg+C4zP/qtZ4CAqOJ+Bf0Yw8xT8EGk0mTFWpntImUxVnU2HNB
	4i8sUVtj8PxhsnjcjVmCjlNc72OjhxpWRh4NQI7oUEOVTVALg85IiEdV1pXy4ubIJqocvrcOHWg
	XhWOpIZexjiYA8HDq9gpESCK7RCCEpCwqdEx1FfDRi4z02qn/D4O89SxECb/DioF29B2Z1UvIT9
	9iRt5YI2GO53FTXwFYY8Ghe9lY/DOju7X+AIjHfX7vW9IvLR98SrsSTdPyWcS0ENJPF/XyVxu6X
	P2wFjN62HMIr7/Y4fGgx8BGBfoOqnBzCKm
X-Received: by 2002:a05:600c:c04b:20b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-483201dd234mr30633915e9.11.1770389447403;
        Fri, 06 Feb 2026 06:50:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Feb 2026 15:50:36 +0100
Subject: [PATCH v3 8/9] arm64: dts: qcom: sm8650: Add sound DAI prefix for
 DP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-8-5b79c5d61a03@linaro.org>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=911;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UhlMaTJRZ9fLa8E4fuLuIg9nXiWgxX4wZpZOm+FPpVM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+9dOWkQJdFemEvoKTFH8uS+Q1yurC4xUWEq+04
 Ez4l+PWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/vQAKCRB33NvayMhJ0SWWEA
 Cllz+WrqIxsNn6L+HEzJo0XSTb99cY1OZnLekrQchzm8OSteWlk0Kkjo77xwJ3O0OckSF/v80Cqcar
 BFD4sAhTbleidT1MrwOiI9kLphkIHuyce3SrFjA8H4BTI3fjHrdMPPU9DeS0jw0PgG3YZkIWhZZr5b
 zLv6LfGiuvFkikodToYoH3vrbT/FzRSNWzh3W33qMUpfpVCzwtOgbcyFYcD/RuRmE//y4odhejSVRs
 sWy10lGRKxgk1dLCZsTM8AnGXFTKI3/l1+GAhYYVKyTskZZFzhFyLQa4keb3+T5JeT3LtXFO+d7QdD
 J9LEjWTlxcCiDl8gpLLGEGQCZr8llsp6ORuWu94QlTiGIHZdVxPMS0T03u2y4j/n8IF3cFIrKzzU79
 5CHgeY9Rphxai1kHkQoYMNRN4sP9UTfj/tpH6SvJB5Vjsfz87PrjfU6tx3jLPlaiCXDUpEdZAramb0
 fSSj4hJ+QCI2dH/kjrpPOCewEv2EiyyHjRQRGnckASODzh0Ah37uY727Yi9L8Zxsj04ubdKWzTtQ77
 6j4UKKPiNDJ3JmFzfJFOfZrKneNLTXQnQUpbs2x4RBBcKqQE3EHyN6jjzfPyWCaxY/jTtmXrX5Yun8
 VMctwj3AjUmzm3OwGz0p6iHVDwiWB2qOyRTUzKx5NeIXqWw6/PXzpfyMlQdA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Sound DAI devices exposing same set of mixers, e.g. each DisplayPort
controller, need to add dedicated prefix for these mixers to avoid
conflicts and to allow ALSA to properly configure given instance.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index a7a06f78e564..6098d6201002 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5773,6 +5773,7 @@ mdss_dp0: displayport-controller@af54000 {
 				phy-names = "dp";
 
 				#sound-dai-cells = <0>;
+				sound-name-prefix = "DisplayPort0";
 
 				status = "disabled";
 

-- 
2.34.1

