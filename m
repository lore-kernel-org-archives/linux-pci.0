Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D6426D1C
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389447; cv=none; b=FfFErGkyKo9PXG0fBYZPsKyhxHUWtwH16qdgnplRmhUYJL3f4/ok0ek24L6MMCpRtVfdXElgMLdMXTvQyTw5fghE7UAbUngng2tBkuIjjyg80UoODc2rwQlbd3+z/oN8cTwx43vNDacYAY1WM8f03ZpRW5FAy1fxvTOo9xOQ+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389447; c=relaxed/simple;
	bh=g7pVEIyvtjR2rEj/a6QvbvFSLtaV0ediGa8aTrfiBNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mo1lLexTzG2m8a01jy9PQe3QO0G8CA410zyQ5mlyIVADTZcVA+4Cl61FexlSJRV7qhm5dv4vF28e1oE2zF3n3ET+stj5ise4PNwxtHfEmcjKTAaTiKBrS6+3B/px/UiyRRQ0YlXGxkk1MJSzTuGW6AuVwIzSfYbuaMi7lu/lO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IN/oYr9o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IN/oYr9o"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso19501115e9.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389445; x=1770994245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlSYfEBBAdIRU1v5SNtOD7nFSWy/9WeV76IFE0K4K+Y=;
        b=IN/oYr9oLoIDZaHr6u8+gif+1TV/sgRC+SW1cmcE/H0ETLeQW1YJswrnIFfiPtstUO
         WFpESeSyJp1mK+GiJxvXqqQCZytNvoCtzF+r0SK60aTcKk+rNDNkaQFxVsgsyDftV7zR
         TB/rMu7F9yM7xRfpiV66KczFFk6asmHkWokgZ9t3hSZMzAtKnyOuK5cfNGoMZyX9d5Lk
         Kf9Bbc/EAV2GwRtrPM0TMh0ANpsUAbv4UujAVUoD4gzkHolSpraJMSWVTK+iSznkovB4
         c+BpKJ3QTKRkHvMAiCHqurzF//2s09wJYJKB6W0xf39IZib2e1dZdJS+6oDVA2mV2SU1
         2zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389445; x=1770994245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FlSYfEBBAdIRU1v5SNtOD7nFSWy/9WeV76IFE0K4K+Y=;
        b=S36tghaHXsSrPsyxx5X/xX0U8y7GR3F0RQFPFxlEDUOOvc2j2ZgSe4c+r++Ox/9ZRi
         Mz2sXGqvUKhJ+Q0WEoe+RZ5Wc4MQ4RHoS78OTqO4tBex8OwJGIcxxinLlX+PD58G3Te4
         TI6CDYGZwvDxrswT0D4BkrrXY/GEw6W0pEz92ONTPR5QWrTdiqV1TJpJH8Lpp9NQ2jRl
         QTC7yhX/5HG9vNQFOjNEUMKMZEbXnHOSe7RnEziZ+mDdH5ueZKyrfvv2raiuNiPr0hwn
         lJq3QOtF7i2WGTIcFIKWsRbfs7416ZPHK6S7dEjdV2FrzjZc7Dk2q+58HQo0i4TNZEto
         2dWw==
X-Forwarded-Encrypted: i=1; AJvYcCUG7Vn4JyA8ApoBpROdNDYweUqZTVl9gqlk5PxuU/rg7RnuMPnKikmxNovKIeUqJY2DPlOaYAaZqK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxESZwjgoLGgfANsVVdJJb5l51CEU0fPyJ84NM6gYNMJO79KBzh
	iPAr64KTiEnP070mWdN0ljk21u57rzhqxBi2v6msk1NpwYjQE28Zol3S7GeJPb5bKaA=
X-Gm-Gg: AZuq6aLWou6mXKyIlQLQzXvHJaMPM52cUr8ZR9aA72RRq2XnDv6F8kHlm9Y8fB9eXs2
	xMKNrOVliIr3y5NQ52OVFfFqqtnWmHYskLR8mSqQh4D2FlpfTz7mTRYAqGDEJQTYejNLxalQhP/
	Q6rmhtWQAPfUIgVR4/qK3HquQP+/OfJpXqEA1+aZPghIdykIbVy5KOz+pD0/8Rf95JGIzrTDyln
	M1rKe2h3VEPJuYT1kNEOWykd9B4QrvqXoIhugEy4sjFRMeUl6h3AjN9ibsMmrdRNRH3Efp4PV6C
	0AsNAUYbzkFNtL5SxnN31e3F46RYS79Vp0qcSRVwb3sPRKQcXFSFeOdBzOzJnO+k519t+m/jU4f
	1FuKziOUS7hOYS0NNDRir5SfQiSRDQiAaWfQfSKCYjMFDIuxcqp4jzuEzxmE/Cn3tNikDmqkir/
	4QoIaKI3+iUtznTlOflV7B4KB7n9nB8Xvx
X-Received: by 2002:a05:600c:1912:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48320966cf7mr29773605e9.20.1770389444512;
        Fri, 06 Feb 2026 06:50:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:44 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Feb 2026 15:50:33 +0100
Subject: [PATCH v3 5/9] arm64: defconfig: enable pci-pwrctrl-generic as
 module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-5-5b79c5d61a03@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=g7pVEIyvtjR2rEj/a6QvbvFSLtaV0ediGa8aTrfiBNA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+8083v2BvmoVt+DFmY1AnidxnT2LmfSJLsmFlx
 0lKrmyKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/vAAKCRB33NvayMhJ0WatEA
 C+UqOH3jAZM4aVjDBBFAb7wLBX7vQELxv9cJXnfxleS8zwNPVxBPt0D3FbLcqPFGnb+UCfJWk/hPaT
 bso7oMzVMzSHVQnNgd1dTudn8KH6ZOtBkkHC0WtpaytBs/9iUPAb9xLdzkTSIy0whDNwmzr/+gO+yN
 ZhMj6zb+tiwae6Q5O02Y3C3DxVf91EcAApB61NmRKEWc3ONhE/jRsAotIcEiWL8eTY6K0y7av9jSNi
 MxB6BNVsowUbkjGhfWfSJb9meVSUA87VOk1lWY+Ceuh8+jgIGgl5BJpQH8RwlGQQdV1uyEjGkKIIeK
 XSObr4TEVOA5huii+4DJdW0Eufs086JQ9Fln/uGmPG7NtDC3AcLIXW14LBTrquWAO33ofDwIkKR4T7
 zMMUXheuYrjkk6KVS48Htfp5GRI5XA7JKtOlWa/NCekDN3g1XKZzht5D15XwKRfXqxBDtpKHKWdrFi
 bQZV/atcF04xRJoJj5R4uwENr+w8ecAQV8yr3j+9Ks+/9SP808IPYck7lB57HCOWttzic7TzjDJj/Q
 Q20wKq8ywo1gFMFHtW4CHZwHqKchviU7xnN1oAB76/yFSmKlRtC4olc6dP57qtTxSvhJGct0b7bk0X
 Cn+d+2jsKioO5wqf1TdFvtXwDWx0VsmahBIMRkvAWReUb3Br6wVdLR/Xbrvg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the generic power control driver module since it's required
to power up the PCIe USB3 controller found on the Ayaneo Pocket S2
gaming console.

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

