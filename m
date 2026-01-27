Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6703337B8C
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507865; cv=none; b=snWTJkEaSd7DA9Le1jsmSn3inrNKK1Cx6DPZhtBLRVDmAzXZO/luxJEpNTHnOCN/Z9Cci1kuf+26HZFOwHc/Hm6VryLU0zBH0Z4y82faL/oAMOqsQSBeSQO7AqSiG2E2KhDHaAA9r5pnQd66/bMId0ndT/3cxzywSOngp8R/S8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507865; c=relaxed/simple;
	bh=1Ho0XG7dS+YggQv/oK2R0s/FYzjIvQaih1Dhu9EIl4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YeFrlwclFQe74BFto3igg3Lmd42UHp3p/dHQuNy586yKsGDCrXpLgVxyAdyURRQAibya2X0vOzopYGOIgOUC1HAz3c6thsxRyp+lOK9d6jlYgq4d9sB1mwRa/JyLquWlFzosCqqmbin3X6f65wSESItmCCznk00zazXFlQFkGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rG/0sAbR; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rG/0sAbR"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso22168755e9.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769507862; x=1770112662; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2e0LebsihOgK1n8wthh7i3DWNd7QqTelv44kSjU7JJE=;
        b=rG/0sAbR8B6CvOpWrh/ZdIMnfrKv6AU+3ggyZNk+A5ehS4g5E3hz4zdxCZsJpRzMFd
         8iDT8f5u83qjoxzyC8IkIcLIhraI3O9K/X7IiI8FUPRnfoK+A11Rx/q4bMZ83nj/DTBN
         EzHwZjtNf5s83ZTnX3nBPq/is4AbzJZTtNGp6dYnk8CAVOCgm1W1JhRHHkSpWQaRxkYZ
         PdFXPl6YhxTMgfZ4xhjV+ckD4KI1kVNImfNoPsplzB8Cyx0jmvTPp4lZ4HbBvlhDI/qq
         1Ve8pdSfEUtnfFNx8HTLRQtgtTk/u8fYPE0SALTV+jNKjM8pw+ani2dBadFQR/7IROLx
         S/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507862; x=1770112662;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e0LebsihOgK1n8wthh7i3DWNd7QqTelv44kSjU7JJE=;
        b=mTQ4SVSioXUwazpA9hxZXz6xe1AQcu4KmJOTa6ylkbX9prNkkxXs6RY0eHZ9/5lNP5
         ho7qv1IGKgDovliRqLt4fGYho4DtA4m/Xd+tLp/hgqPhm+2ivhvN6oIx2kB2i8WK9Fpd
         SpclDDfsk99CcarJ4f4aQB3gzCfB/LYpH6u3LnFKulDhMEqhJbldR5j14njUOU1ADTgb
         H3Fq5ANvXcYl2ZRirNGnTq3mPd/g5qoTPzX02oAb+TemAXzHcTBWC0rn9ONRRr/CIPv4
         dYcvKVf1u6gndz5WIpa1+a0Ivv8kUOXzTH+VPieNTsBpSaBQ3VmTzL7xzaJrGlh/XSqh
         0hdg==
X-Forwarded-Encrypted: i=1; AJvYcCUljQvl1X8nE7GC5YCKt6ze7sF4tGGYGtJA89gmNJ0KS+6ben78pKvtvd+MFQXLDGBT4OVKxyhkylo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbjLbLwYr2v05QFzpsAqCId4zKHRPo3X20tXTPmHup9kR9tB+r
	RbNOshCTkQuAD7CniISlNvrMriKUezGLn5GOlw/BT0FKpfHZaa+Bh80aYsFEiWFufO4=
X-Gm-Gg: AZuq6aJ4w2apMRF2W9iDkVogN70SfNP/f14TKGvNpQmRqeaX910Ju+obRiMgPMdzgf/
	SZJkAOlmN3+NT4lFp7MS1Fh/0kX4Knm2jdlaE4viGaVxGc9b49tz+O4IpHKxNdusrQYecHRe8yH
	av7WuNBvTsR+kaxwYoQHo6RVXSeVJHL8A3pyvwTu7obDZScd9YRaRC5VN15Tisgm0H5ssfSrw2M
	BAfpkHhhIndRUifA+HG5v0Stjzq1gNJt4xq2i46LiTncn3Brb0FoLbrFYWiHvz4b2v6VIP3D8gu
	lu0z/mlv+Q3CvwahEPAxZVOdB7Qd3lTA6BYdV4Qlsb1C5rd+pGoyJby0xmwdOFJxo+G7fxqkYn0
	Cz/rqqoRiVZjQFuowU05xEqtzfMaXDOOmbbr45UfM9MKWtfpVoU93yRMO20kpaHBf3U3afrv3uV
	iyqr5hyO94UCNbPLd4mwqEIgzs9AsajCA=
X-Received: by 2002:a05:600c:350b:b0:480:49ce:42cc with SMTP id 5b1f17b1804b1-48069c0de5cmr14612455e9.9.1769507861972;
        Tue, 27 Jan 2026 01:57:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bf93cesm49056225e9.9.2026.01.27.01.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:57:41 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/7] arm64: dts: qcom: Add support for the Ayaneo Pocket
 S2
Date: Tue, 27 Jan 2026 10:57:27 +0100
Message-Id: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAeMeGkC/5WNQQ6CMBAAv0J6dk1bLKme/IfhUMoWNmpLuoRIC
 H+38gOPM4eZTTBmQha3ahMZF2JKsYA+VcKPLg4I1BcWWupGKq1gThN54LdtjAS3uogJpuSfOAN
 r6BwjSOPri8XQ26YXJTRlDPQ5Jo+28Eg8p7wez0X97F/5RYGErqvD1QTlpTX3F0WX0znlQbT7v
 n8B1huUUdUAAAA=
X-Change-ID: 20260121-topic-sm8650-ayaneo-pocket-s2-base-05c348efd86d
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1Ho0XG7dS+YggQv/oK2R0s/FYzjIvQaih1Dhu9EIl4g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpeIwRROCpb0TMHeAc6TMUdXNXB9/fuPUVBZL9uXyU
 2FlCoHWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaXiMEQAKCRB33NvayMhJ0aEaEA
 CFi7NkRxXRZmDOfjdMNhmQFgH9m9TO18dvcYR4Szl4XAM66hsfrAr2BzHliKhGsuZGVQCn21OEacn1
 2psYd7D5fe821xwIpunC1uX3v5BxWozwN1D1h+ZMYLTyRLiOfWeboymDJvSvpQb7bivUNVwQKG5O4y
 maY86FceNdv8JJwC8sx96Bzf2R4r2aPtUJwFU/ua8IYGbGtUAOc8L2DuQhM6RPz1wRNcXiggPUzhyP
 jwaPYUsqvJeCW5+PXLUSHu2yYQKbxVt8d1RC+rzY+a+u7Ur5H9B23XHwGHUl6MnC//pDNtHoPeri3v
 X8F6MS2V/EudvIBqHZeTU4OOlEzEDtHXrMqR2+ZkK1DL/is/kkSFX48e5gJkKEL6J5BFR0gXGC1dE0
 Pkas7nXik4ArNrYr4EsYR1odk5y/a1Ix68QBRSA3M3hn+O9OgTZtveQyM1LuIHx86NiAKVNnrJnkFf
 7ZonrJyjqpd1ei/d+t/ELDeQrNxydxQi0jLuga8L2ZNm03YgRkSeL1/rukXbQ8Iior/wdS0YB2WN+W
 iGHVYXymMyCW1c2ZtKs97b2qGEc1EpoAllwjD2LwdJfFvDLdlsc+mfBbyKANuVDVHRTypu9Af2UY5Y
 X6N+TMHRPHf7v8/JbJ+3SlI3zqCz80sBujApWp0WGIJCilnZgrDhN6eVHVQg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Ayaneo Pocket S2 is a gaming console based on the Qualcomm
Snapdragon 8 Gen 3. It has an internal UFS storage, WiFi,
Bluetooth, gaming buttons, SDCard, 2K display and USB-C
connector.

Product Page [1].

The Initial linux port was done by KancyJoe (Sunflower2333)
at [2].

[1] https://www.ayaneo.com/goods/9344082149621
[2] https://github.com/sunflower2333/linux/tree/master

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Add proper regulators for the USB controller, with bindings & power ctrl
- Add proper regulators for FAN
- Dropped support for headset over USB-C, audio is connected to a jack port
- Cleaned up Audio routing and fixed the DP endpoint index
- Added i2c clk frequencies
- Renamed fan node and used interrupts-extended
- Dropped the usb-c self-powered
- Reordered nodes alphabetically
- Renamed pcieport1 to pcie1_port0
- Link to v1: https://patch.msgid.link/20260121-topic-sm8650-ayaneo-pocket-s2-base-v1-0-bb3f95f1c085@linaro.org

---
KancyJoe (1):
      arm64: dts: qcom: add basic devicetree for Ayaneo Pocket S2 gaming console

Neil Armstrong (6):
      dt-bindings: usb: document the Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller
      pci: pwrctrl: add PCI pwrctrl driver for the UPD720201/UPD720202 USB 3.0 xHCI Host Controller
      arm64: defconfig: enable pci-pwrctrl-upd720201 as module
      dt-binding: vendor-prefixes: document the Ayaneo brand
      dt-bindings: arm: qcom: document the Ayaneo Pocket S2
      arm64: dts: qcom: sm8650: Add sound DAI prefix for DP

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 .../bindings/usb/renesas,upd720201-pci.yaml        |   55 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../boot/dts/qcom/sm8650-ayaneo-pocket-s2.dts      | 1559 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |   47 +-
 arch/arm64/configs/defconfig                       |    1 +
 drivers/pci/pwrctrl/Kconfig                        |   10 +
 drivers/pci/pwrctrl/Makefile                       |    2 +
 drivers/pci/pwrctrl/pci-pwrctrl-upd720201.c        |   88 ++
 10 files changed, 1743 insertions(+), 23 deletions(-)
---
base-commit: cd31ece0d7a4f2fb2266d6d6abd4d33f45e93dac
change-id: 20260121-topic-sm8650-ayaneo-pocket-s2-base-05c348efd86d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

