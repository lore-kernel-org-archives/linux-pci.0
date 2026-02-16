Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C17311C05
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251722; cv=none; b=NDjlKWC/HxEikficHzM2uzbOmdzOigavOY6f79r/d1LBDOn5i6wNZ99i2Vm72/Dy6EXdJzE62E29keh/Dmb+ZGtUdadh2JsfVQku0rv1gQOSTiRe2CoeIlHZISWfX0QPpvVs3t+7LUG1uUSGTHMhRx4XX899zbIU5VA/GlZS9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251722; c=relaxed/simple;
	bh=gNRGWFg8BciC69sNOtnWd0kGP1UBPVT2I+H63GUNNOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y2SDTvVT1lhVp+E9knsi4Mnx4ts5XRZ3U2U/ATjv1RVwcurxUn9tL9MqU8MbJ3D/DOFUCQj6SpRHz0RTQyFp1HBNfa+oJ0n1Fc35s0zj792bPeFHs7mSvnznzqcqwkB4oxTiGrnPSecFcj3y4MpFKo5dGPuRWbg9Gc9tVZohRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=byOUQlHn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byOUQlHn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48375f1defeso24874665e9.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 06:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771251717; x=1771856517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9Swo8EHFlkKGAVfWwzLCgBH0uCFJkUFACNjEB/L8G4=;
        b=byOUQlHnfzdAVnJpsZPScdNFE/ieN0JPrzJrXIbRauIKCVG3eXX8QJiB9etCNNTbOc
         ek6r3fUyO+bJtLccVXZ0Sgm2xeI2izW0i1M+Gf+3mD2WY3udYzJfw8u4B2vW2lFHMzv8
         ev/8VTRa6sJVsiCmhSY6/ij0+ykSnFID9KTfELiBb6zT1BwXBfkxXes2ViyBzK8Z2I5+
         yH0vXybytDnmN6rqmLrfbEoR8UwlVDhDrPU+An9bF0wmVVJNpVung0/xomzjP1uqJi11
         g5PWmY9PXQY9MJxaBbB+LA4t8lRDhNi4Lim6OYwYoGdNl7rmHTW8KrDrP3R+TmLeblpj
         boMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251717; x=1771856517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n9Swo8EHFlkKGAVfWwzLCgBH0uCFJkUFACNjEB/L8G4=;
        b=dhAodMGpU2x9FyjK4UIAGYHyovF/kmfFl22KhCeCjEon6sUlOngcwxBAMWX1KomnHI
         gwtKfEH6cZEJM/OagzzI8HYwoGbm1/UC+ZOO3AT8FMF+MYEieE09oPpeLuWVtNfKEOtX
         eOUwFdtGAVqLuN1eoLHS1ctwT3wskPZ9jGxM+lzVOJw2rd2vJRrza2F0rejs/HM3S706
         oXwOjhD7aIaEePqzzbYDnpcIKdRJ924tr6gm5QTpQV+VGQRlc/IvN1U2hIbkCev//Ylz
         +oYUJo4xKRc0lt5AoO19hzfTa5RAw9ihBI0DS2kpo76HIUGtTh/xI4LyUvA+0TOuGqCX
         u9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1mYx52kj6yrvc6Zy5ub6sYtjyYO0MfnRmWPpq+5lixn9+BUq/D0G4QmmzhFXe6WmF7zuCgwqaPSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04H0pWviuMUFw8BV/BePOmNs+NqDLpCVCc673WuiOF7FyU54i
	JArGn7Q6+VAtSMAhsVLpkZFyc2q8IldQSaZs+ZciPoRUN4EtAGYve47zjW3EbyYbhKs=
X-Gm-Gg: AZuq6aJkAG1lwFAp1rRVdm0WG4vYjqYQexV/v40N1GQqv4DWkREs5pXXZGLg1MAAbVR
	x/m5xCsofZm/f3uXDEEnDpKkn7bjsqBbdVe35EWhQSNySOWVRAW/5sq8rdXXUqFxOZ7Bg/lDbAQ
	EEwGOotS8anCPLiHqU9rF+EMnp43iZ4+q5dkpFyE9LqOARkMmwJOz8XY8cS9YGztqZw3IsyLQQ6
	YRwrKKWzYQfAlWqzX0pcju+wJYSAPoJH2HlGYNhvf7B8Te7trwy9ENWydsFSQins+dOW3uec+EA
	8hYfkwlj5/9A85WHlB8h1LyfHjeRgIir+P7u32R5Q63LthnkBgOs+i+Z7AreAJAbsZz/T3mnY05
	Lo+72p1EeyotIgLgh2vzK3NGqDO1aIZWj3gWoZInkD+WTqOJoRIeOKYylnSyWFPRWOXwW98ie/3
	rZ5/VzCPfr71tenPAGYIYKy0OsfG8lsJPBNB9Lg2GE9fK0
X-Received: by 2002:a05:600c:4e4d:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-48373a661ebmr174878405e9.26.1771251717262;
        Mon, 16 Feb 2026 06:21:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a63afesm86717475e9.9.2026.02.16.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:21:56 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Feb 2026 15:21:49 +0100
Subject: [PATCH v4 5/9] arm64: defconfig: enable pci-pwrctrl-generic as
 module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-5-802c82795431@linaro.org>
References: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
In-Reply-To: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=786;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gNRGWFg8BciC69sNOtnWd0kGP1UBPVT2I+H63GUNNOw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpkyf8RIFsAp7s23x2o6Io6/7zg8SpJVZF1WB8msk9
 5j22b66JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZMn/AAKCRB33NvayMhJ0TMwEA
 CP2YDUnqsl9Gn67wxmjEyV90tlvminbZqLB7TTbMWXXB0yV0fJGEa31VJ4WxYFn3WNgp474NJUgBYZ
 QJumQwJSFEUQYnnCwf7hJ1XXxxEf69SBOtuaetXqLaZSd3fJ+ayWOBE/jCM7L6SWTenA9EyT+75/wX
 ZhbnxGnsONJ4AP5JT6uBFtXC8cvU/mmT5KncLAtdI4kdR1YDxQuSNxrpSBqcVji+DO8461PYtLWdxy
 ZMYRFAS1n+NU70VIesZaYSygAz4VqHkPEuNqwvcBtQ/rnnJqTrRJZJtKPq4QAOVTYv3jDnc+dZY6t7
 Z63l9a5nNtuGuKZswbIz70pOSLe8gQj3coSTmJUM/K48bjFEYV+Z/v01Qf75/A9ZXg9XiSAnV3ULfm
 V9xx3Gdlz7LVxR2NLFfLzTM77WxwMD37+1hfJsKec3Whj5bpBBWv3FEOSueVwDya0MQDb5C5NQ4oRY
 b1JtVubnau7oFZxkj1oVcLm5ET1Zjto3bMwZMK1RqOU427DXquZUUSvFEC4JqxW3o91OKg1G693vvi
 Miq12zKVxb6PcEjJliKdA0hdj0osZk3e2b5MQwxVk+LoclPEaTcaebglU5nTxjEUjoffNy0oOpAGWd
 siGFXe6Ax4wpaZ4geFQC8ofacG0s215dE6zmpsYOe1/1h/VKXBM7jyQqm39w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the generic power control driver module since it's required
to power up the PCIe USB3 controller found on the Ayaneo Pocket S2
gaming console.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 35e9eb180c9a..5efcd4943a4b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -250,6 +250,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_GENERIC=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y

-- 
2.34.1

