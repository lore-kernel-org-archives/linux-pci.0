Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707613AEF3E
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910518; cv=none; b=Qmd3BUH5CnWbzA1ZRmT92gqDghMHXDfGvHgSTHKgzY7Lk76CKtloMh7dkQpX9RvdcMC97rPLJeg525ZmQ0g+LpsKJzaD9T67Y3urKaqQyr4XIAKkhsa+kwOb+KRKgy913aJrAKArcVXI6vmGKRAlYGTFXpp5YRd8nwQxgFLa9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910518; c=relaxed/simple;
	bh=XvC/+pHwVb5NzB52XjoWhWvsP0QalYMxdzFh9h/c8IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATWtr9UEXg7ScVZEQMrLIGr5QWvYKZh1wT2KqC1EHM5Ep5GIS8/ivUTXJDYfRmIisZO8hyElxqF7OMbl1/w1KKeHghzGPvicGEhmfQzNuRqGAsgUudCHE9C2GOSZs0RUymEJA8XGy06xDIQV2EHss0IRrSKA/sIfmag8Ivm9vIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvPbnmpL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvPbnmpL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b45bb7548so435171f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773910514; x=1774515314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2I3d/W72WxunPTgbW/r5o2nF4g/KFg/bIY0fMyHO7s=;
        b=PvPbnmpLZqwUTwx9SWESa78OKPrdCWncJDzn/y73jLgxkvUJEJRoKDWf45RJFVknnb
         E/qpfQAud9zdgHdMcl/Ys9zrSgaLeFkBJTBOhwMCXWpSqyN/igYPDe0dkCN/HyCaHgk0
         jP+++enAzNM7RoCoNwIw6/dTXRWM94tzEt5s4dA4whgv8RHP3BAAwABEccM7VOqXS5eM
         ve86KtvNMKYVb4GgrA1mID9u0roVJq1FrH4muahx8U3fsp6hBBijhHElMX8Ajg21tLJg
         TwTH3B1J5unPoKM3OCpjDcDXImQhuZrST74yqgeZWHGlPBTTApF8wZjE/x+zryKwbkgw
         Qm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910514; x=1774515314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u2I3d/W72WxunPTgbW/r5o2nF4g/KFg/bIY0fMyHO7s=;
        b=W40FpNsdCpQ2QhKxPuUDXGDzslUo5FUXP22hwG86Sw25QrlXgCELFlfTxsnpm4b7u8
         9sG/qodQnUa2C1Nqeh97DexoXtwdHkkzA3ISlyNyU8O64FyMC3oxNnH2Pc2omhMdnoS5
         GfHaCMCxKDrZ88MYVe1RSxiTE8tIV2wVS6vDVYtw5ezKA+pFo7XmO6XywRgaRffj3mZv
         IUED+KzZkWyUEUkjBevFjpqkuNpAmvzg2Rseh7VoeqmdoSe7KH9lg9piPy49te7gPKsN
         5kHJa0gvZ40RVOVeJswt00inPg2r2C1gveihpfL992gisZXWu+lwapYaHu83bzyCfyty
         R6kA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQlESBT1clsjGVmfN3f0z0ArR1K+WnbKDqack5upeNY7ELg1jXZ2dgp0LmG3DOpPSeiqimjCQj34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhc8xoLap+fdT8h/X84jHCbX6IqX4kcgxnNSYDxfauyDeFnIO
	6bZBOgXi/ILKlZFePHCWMypBp/Oxc62u+WZSmijYKGtIXeJAtEghB6eM5Wlpl6PfMEk=
X-Gm-Gg: ATEYQzwTJFH2sVI8ajj7XY2fIdYIPZrAUI1uRRc1DG/aR1RdR/lUj26kvVE6AKbTouW
	vK26ytTNzZXdm7YGbDT0mJMJsiN+L83UIz8h5zy3DfAvKFrSZ+KG4Wr/yJ47Hi6+IJEykp3O5lq
	egoU9q8Tb4fuTT3ubR0VYpWuR1M3KgDQSzpDAIa5f0RW9+8P5wW8VfWYKS/4ieoLwvryA6qew9o
	jBakeBobCag/oc0uEhZSEWxfpotbLEmn++5DcDvhRFSqQjtn/E0QEzjj9fS7GfyI288eGaW+Y7B
	xL9XjPp/akM3B93YYvcj8VcLbNUyt0U8y+cPgmJ3J7kRl9PtweRG9tAt2w2fZx9tPFR0iDMfP70
	IoE1z0dr1mnGKbp77SC6MLT3AW9mAlvp79kdp9SvXdYYtibppkU2PhwCAVpuLT7dOOq+vcvX6in
	0S8TZHYAycaYqFchJ4JapvvcLiig3LtCRxrlov9mtpRdkx
X-Received: by 2002:a5d:5f82:0:b0:43b:45d1:f44f with SMTP id ffacd0b85a97d-43b527c89fbmr11259355f8f.41.1773910513729;
        Thu, 19 Mar 2026 01:55:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518588a0sm23072267f8f.16.2026.03.19.01.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:55:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 19 Mar 2026 09:55:07 +0100
Subject: [PATCH v6 1/5] arm64: defconfig: enable pci-pwrctrl-generic as
 module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-topic-sm8650-ayaneo-pocket-s2-base-v6-1-797bf96df771@linaro.org>
References: <20260319-topic-sm8650-ayaneo-pocket-s2-base-v6-0-797bf96df771@linaro.org>
In-Reply-To: <20260319-topic-sm8650-ayaneo-pocket-s2-base-v6-0-797bf96df771@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XvC/+pHwVb5NzB52XjoWhWvsP0QalYMxdzFh9h/c8IU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpu7ntK92VjPgJU6LusU96CCjpdrZznIp+B8cqAhWc
 IjaiDqqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCabu57QAKCRB33NvayMhJ0a1PD/
 9imeLObUOro2ziHQTn0Y0AKF4JJ+zd3UMzIolL+jH1PiXN/0saQQY/LYb2CTMEpRWBQPN78SQPEibW
 A79nzVQUJzwY2rAmo6OGLM5O+AfAOHEPJu9AvUWyMik8IopXmKxM6ph6Yck7Y0d0Qa2vWAykpXqONk
 EMucxj79YcQZaYTQtbJmUrrwTcEhimGlRdK2j3iO8S7BqANzmgBMeqQPHn1SoHniv2r2/uBVqRfkje
 3v9VkJzSkqgbI+uxuqLvs6S0+bAl1RrFUey7aqR8Q2PcNy2+2UIQ1AvrpgSJyNDFuLr07FJPDEmCgT
 lNkFjmisl1+JNf3ScVXykx7SJyhOlivlY8/kLyEZceIsSHrBiNn6E6MHWTKObG7Cy9KsNx/dN4da7N
 piE8v8n636zjFsYRaWEyZR341bccb1fqXXuVHpWSOIAov8IQloVj/Ln9htwhqds2a9dcebRcoaTUyn
 INHsmZGLeopDkjv44/JbirLyGJJuN8GE884Vc8DGFcWG3LkVh3s/dEN8MvgLUW/Ev9ABxsMT3lfeIZ
 XmLHFVXKegUPUnyfZtuRdSqwg7XHchxRSzbjK50/+335qj1WcUivl7Up2Bc7+XW8KzO6brgDzColmN
 2cfm8i4ex5gyxpd3iG2KIB6FG6rkDbe2BQSCc2rJrLAp16kD5RctSRRJzevQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the generic power control driver module since it's required
to power up the PCIe USB3 controller found on the Ayaneo Pocket S2
gaming console.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 18881bd239f9..47347da14900 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -258,6 +258,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_GENERIC=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y

-- 
2.34.1

