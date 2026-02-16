Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CA310768
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251715; cv=none; b=UxTO/DGINySckQmzwDwAttdP/XITwEKcRPgclg1d8VtUHVmnzRFdlLemi4krmpkwyM746FbX0MadDvN8Ww3Xf9U24luWyXl7Km/i8b8A18O3S5gJzk+q92JMxpv01gjAbNSeMvTWdwSxBrNPIQHvBWun/FfwBus5UWdRwXLoLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251715; c=relaxed/simple;
	bh=3AXiIwSq8L6nzDQfXChSLBVbjYhE+/7MBD/NWJrTKsM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E020Z00o+U+oqjVF1045cWsxtVa4Mj/RZ6SwZsf3UlARSa8T+SccbdlS1horG/jdLcI2z0lV/t0akzWAUeFX6XUSTanZiqlI9u84tz4SRBFBwXvQGHO2LEgv5g9oIo1QEWzyowJezHpMun8yQrAN6U12smVSIVZQ42fimM8+wS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFiATbPe; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFiATbPe"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so31318615e9.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771251712; x=1771856512; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbuK1/Mkk0qHzf5Z6SkYJv1LBlhiuNH5yjaPDFPJh1c=;
        b=IFiATbPe9OtdN3sH1xItYwqyPYRsKlNbDg6Xv69VdJ9hjvi6I8/4WtRvs1XgV14gc6
         8yhW2/POCb1S9AOfU2eWltXRe7IlTGg6JrhlF5SmKifzqHKhH66aQ4urMh+uheF6DK4T
         e4uAGIXxDPc1e1CMulyAcDHpT0jPuGUsSROgm486M0SEslUVHIcRO2n0NxamksjavR2k
         kSRNsVmHYjMlJ+NUV8SX9SoVdtY+pkIy5QehLRMO+XPlvJzyzG/GwPKisyolBhiY+Weu
         8BlT2blz6A/vzuvWLCC/CoY2R4c5IriHIl9xa8XYC26bHJ21si5SpLQxkeXDDEv8WIPY
         7vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251712; x=1771856512;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbuK1/Mkk0qHzf5Z6SkYJv1LBlhiuNH5yjaPDFPJh1c=;
        b=iYV/Y4NPt+9DTC0eXgBU4uN67NlGy9n60XH28b7T+10O+aPK/1Xk+qO2sBbhpaFd7H
         3T8HXX8sKiiyUFHH+KZPeXa5nrnewytzfYMZ38LvhdzxbsgAYLtkg+2zjSS8sINi7Oxk
         iJIb3QOq06/Hi8q3noBus5hkuImrWDZE4bJp6d9V/LBwTzgZFZHhvOmLHCsXoCxWycmi
         /zuCV7nTT+/Trfjwuoz1qxt2IV/Acagu5+yVAqAt3bi3rW/O0Toj3P19mIpUGhtYkOWW
         IuSi3ut8tFvfUTkKsJ95pttg1kKHSbfSnL0nrkW2dUQiazKDnFLEdTuSKXpa6H7cmbDC
         4CDg==
X-Forwarded-Encrypted: i=1; AJvYcCWmOCN2JlS+YlU3hseiLC7ZNf21dLhsdH0uC2qxAgD8yZlvk2ON7RjhXQZGiV6XGzpocBxXvNrPT4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/wBP6ZNnoG038N0er4zaAYPWNCJYTio9AKqqc7peFaowGoTM
	oBG6OJodX3awB/BtcanuJO5KRKtsz4mMfDWaPajYyiyWtTzAslZrOoCA41Mt6vRdmg8=
X-Gm-Gg: AZuq6aKU14v8yqg9ArM0ypDB2jeTQfvyzopSUyNXFslycJU76VEeXBgR+pdotm/vWoC
	nogg3BnYLg9vqf/kV+P1mNHn1oeOYqI4QOsJ45cbvxvAenvwAuexX5sXTJucdt0+6fRNuUa9wzr
	lhUGGtewgLeO0dUnfmUAOW0Dh4nMlaSqYuJN1vUKkBLK07o+dOKNlT+UxcZ5Old3Y+zgKAl5Chw
	IyqoQQVBjcDIJfXf3QoM3CPfJayNxChQClVJ5SVE90+oS+ax0/iE3jrnz59Rr5laa6daMcZCT8T
	VaYVHZu2Pt1/XLANSta+APiaPchSqGUo72k/uWlmjLbZ7gE5ApSxxuJ7SARsR/nHf42Mf8EtLOe
	oPZSWA5iHf+4OKZjpjkxMaF5jhG7Qqyw+LsoYIvXlXiJ4a2XnEHpKXsiKoj16ZkEj3JXWEbogMk
	PwishUxgsln5dlTQaJ8n7+CjYeHX5TxXLj9sZM206xC8kh
X-Received: by 2002:a05:600c:8b38:b0:483:456a:514b with SMTP id 5b1f17b1804b1-48373a1babdmr176881285e9.12.1771251711991;
        Mon, 16 Feb 2026 06:21:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a63afesm86717475e9.9.2026.02.16.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:21:51 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/9] arm64: dts: qcom: Add support for the Ayaneo Pocket
 S2
Date: Mon, 16 Feb 2026 15:21:44 +0100
Message-Id: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgnk2kC/5XNu47CMBCF4VdBrhnkC2PMVvseiMKXMVhAHNlRR
 ITy7hgaQNuw5X+K79xYpZKosp/FjRUaU025a7FeLpg/2u5AkEJrJrnUXEgBQ+6Th3oxGjnYyXa
 Uoc/+RANUCc5WAo5erQ3FYHRgDeoLxXR9nuz2rY+pDrlMz89RPNZ/8aMADs6puMUoPDf4e06dL
 XmVy4E9/FG+m5uvTNlMj0heOAzGxT+mepmS669M1Ux0m63HoIXl6sOc5/kO6f25eH0BAAA=
X-Change-ID: 20260121-topic-sm8650-ayaneo-pocket-s2-base-05c348efd86d
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3369;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3AXiIwSq8L6nzDQfXChSLBVbjYhE+/7MBD/NWJrTKsM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpkyf6wRCOG3hQ13uB+dGuF6/3bQbipSRjzs/BNhRe
 ArpkBhmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZMn+gAKCRB33NvayMhJ0RjaD/
 9Ggbw+0dtusYlUJ/EJRqi3F84Q8OVPCl+4JJWd+z2fTwmVmmvLF5vgY46JTwjSX8djllszqmm8KKXl
 vDspueP5Uy1Lbv47CXEhowgUW47dhlPgfx//zXrljOuzwy0lpkgKq+HlFgKRoaXh5OFd1zr/hPua8v
 brrvaMu/M/zZCh6cWUM7nmytIzpMwBXvYt1uwSnCV6QXn6hAWn5IL8pv/3UUruniHCNKeKTB5y1l/B
 lIAcrDfu8dSa1D1CNX/XWkG+D9p6sKkP/LYUItUtZyXIxdD0B+miLg9tR3424mzKrMrxIst7L3Ztrf
 BGQiyHYI9KM98WJIFtfmBc3I9OKTVSUbU17Wfk/F2F+wASr9gmpXHVg3voIVJWDnFE9Gfl0ZG6ZESV
 RYv4NBJS0piBPLnLAhSIwOyE31eJn3IlQCkBjFxthWmx2hTIaBbYdDdHC/aXmMiYPkbKGVtQu2WZDi
 SKZkVyr2ORIeaEgJcKhVUmC219oQNJJfN7F3/GcqxtC7aWe/QMn/ZbW3dc4dr2/0XbVBRy1Y+Hf+lF
 fzoPq/q6yWWThWmjHa+oJc+FmKGpm7Flujs0xeLujXS0J2P6sv452oI2340TOSHgk20YgWsMKqvQVd
 cCowD2KrJUzo3VFu16JDOq5FQo/pkOhimmLireDbYSuyLVwUOe978Z2qKcCw==
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
Changes in v4:
- Renamed slot to generic, in the code as well, fixed Kconfig & commit message
- Switched the UPD72020x bindings additionalProperties to true to allow devices subnodes
- Collected acks
- Link to v3: https://patch.msgid.link/20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org

Changes in v3:
- Made renesas,upd720201-pci bindings supplies required
- Fixed description and example of renesas,upd720201-pci bindings
- Renamed slot to generic, added renesas,upd720201-pci entry
- Used PMIC_GPIO_STRENGTH_LOW instead of numbers
- Removed all output-low in pinconf
- Link to v2: https://patch.msgid.link/20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org

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

Neil Armstrong (8):
      dt-bindings: usb: document the Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller
      pci: pwrctrl: slot: fix dev_err_probe() usage
      pci: pwrctrl: rename pci-pwrctrl-slot as generic
      pci: pwrctrl: generic: support for the UPD720201/UPD720202 USB 3.0 xHCI Host Controller
      arm64: defconfig: enable pci-pwrctrl-generic as module
      dt-binding: vendor-prefixes: document the Ayaneo brand
      dt-bindings: arm: qcom: document the Ayaneo Pocket S2
      arm64: dts: qcom: sm8650: Add sound DAI prefix for DP

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 .../bindings/usb/renesas,upd720201-pci.yaml        |   61 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../boot/dts/qcom/sm8650-ayaneo-pocket-s2.dts      | 1551 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |   47 +-
 arch/arm64/configs/defconfig                       |    1 +
 drivers/pci/pwrctrl/Kconfig                        |   13 +-
 drivers/pci/pwrctrl/Makefile                       |    4 +-
 drivers/pci/pwrctrl/generic.c                      |   95 ++
 drivers/pci/pwrctrl/slot.c                         |   95 --
 11 files changed, 1745 insertions(+), 126 deletions(-)
---
base-commit: 492852b6c9c80e576537810995fef0de1bea7092
change-id: 20260121-topic-sm8650-ayaneo-pocket-s2-base-05c348efd86d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

