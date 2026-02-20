Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047524A069
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599892; cv=none; b=k5Sq84BBHxNwEuhbve+SCfF0OM+GYWLc4y0HamYFdhtunKC9yapu+ujiXX17TtErnJg9YsT+rih/vEqGhrmbK4zmdIBzgFsyZChw0blkdmzkgWeiFHCbsEO4fAmkyzZiql4zOP5CW1CtU8DP8x6P+j5Elfn+I2/iFW/6lxPP3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599892; c=relaxed/simple;
	bh=xoU8ISrB26+6YVm1gdRipQlyceyvKNLhv4a7D67LN8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A1BOEnAx6LSnuOkxan3o4BnFbiUb75UO8htgiub4RlF0S4ZEydQoRRlzvJ0RQZtEv4hrste+vg6KhiM8LoYYfhhletejDjaKP5ow66F6WJgZUt4lADyfHxOMPsrfAFkbmqbI0JUtKjvRraDveiDutnVNVOMWVI+MODnj5q/db74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=orpLyneI; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orpLyneI"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4834826e555so20894505e9.2
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771599888; x=1772204688; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhPrMDeDWb6Rul2iE8KmjoIdz3JVUSbmf3iPvnOF3bE=;
        b=orpLyneIPMsWwo7yaGlCrlmppifI+U5sQiZvWJ8/LaaHBazLLsr/TnIUuYFdrs7Inf
         Qrms7aM5G92kBxdDFNXaEDP6TPPqmYCA3qfP0g6my3Z3R3v90L0UOuz/+0gEnss7o89U
         m5Yf7+MKDdhd4uwu7LLZcE1aNSRqHnW1F5viWCMj8uTHIKtq0PHMP27p1pfQcj5EYdU7
         ZykgI0fV2s7rKEYoR6J6biuqLF0WFRZY+2BjjP/mfX0mywnBF4lYBuEfcF+WLvLnTme/
         /Pt/6oTsU2DY0VeWPCmNWHZ0mE37zyUAx6J581NvGDNaHOuqrgUeqCTKlfqUanykxeUp
         58GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599888; x=1772204688;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhPrMDeDWb6Rul2iE8KmjoIdz3JVUSbmf3iPvnOF3bE=;
        b=M2mKq/HV0bcRbR8N1M29c7KHVt08pv8ueoMxpF267GIyIAHAHIHDIiMbwnCjSF/42f
         /NbdEQQheLk5hq4ysatjPH4O0ssVOjuKPdm2x6wEJsdIkGL4vI3WPij1JzCrlD50yIFw
         kHgHdoNiPnQzeHevJZ9RDHQ1n2DYzGyW8e8HpFsoCkHxJ+EfuvcspJqPUhfaC5vMUuo9
         2x9ZDEGE65MNy6eZ3EBTXo/nqp/T5lzuuT+FsfNsQo2HwpBWLqnorqLPH/k+TA2vfwXx
         GrXAEhDW895PFhsgEXamro4RNluxTGRVJH3d0x/rqa+b4R/q/1FfBLFds0g/O8KGICPk
         wfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdw6ke+rczDNOtXtVmWcWbt4RKKIi3JHR3zi1IHVjAOmo+T6a6Xn6htw66VST7X0+Oo/javRg6FU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IMY/2HOvjcZ3uGd9VWaJxc9viXClNDTZ1VGZHjXyuyAy7L+O
	gYwDTXzQK/W2H0aUrpnSX0m9qQl/zDqsztkWaD6dLqlou0MOFV5E1wKtIlyx9ZIlXDM=
X-Gm-Gg: AZuq6aKWQ9fGu+xT8s1q/14nVfdaZziGt/uECn9tLdS/L+gFnjMeI4oouV13HE8+nI5
	7JrP6qZTtgzYZpniz5KHzlbQjyIrh2FefJ1RURrOmRcy+T0GjvjcLjWPXrZd4ksPxvc2uau83QV
	EW5x/fryahan6TDZ0G4Hwf8J678tagD1iamVk6e0ADkZvwaeYhzKxebCt3O6rcr++v7NNHMkNYL
	XKPFUMa2XSIzjqox8Y3V1g4kFi2pe8yUaMEBgf7Y2yWad3tfBFjxxgk/VKy9UIr/2uktO12AqVw
	cRZzw+qKaHuFq19qIU61cDq9JylH8uXsReU04+zXyGzd8bcwHMzfHC1dbfFG31FmFT9Z1mrfX1F
	SXTuW516AZaOrp/vyWQzcTnCq3NK+TPBoVHSzn85VdATACSu2UNT0alaxze0xj7/5Bn3gUs9UvC
	wwdg7B1bGMMZL+MhWQSC2AYM/JaBxoE9KPaYrW9AjoXj83
X-Received: by 2002:a05:600c:c3cb:10b0:483:a922:2e8d with SMTP id 5b1f17b1804b1-483a9222ebdmr2920015e9.4.1771599888050;
        Fri, 20 Feb 2026 07:04:48 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm122064505e9.8.2026.02.20.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:04:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/9] arm64: dts: qcom: Add support for the Ayaneo Pocket
 S2
Date: Fri, 20 Feb 2026 16:04:39 +0100
Message-Id: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAd4mGkC/5XNy27CMBCF4VdBXncqXzKOw4r3qLrwZQwWNI7sK
 CpCefcaNqViky7/s/jOjVUqiSrb726s0JJqymMLfNsxf7LjkSCF1kxyqbmQAuY8JQ/1y2jkYK9
 2pAxT9meaoUpwthJw9KozFIPRgTVoKhTT9+Pk47P1KdU5l+vjcxH39V/8IoCDcyoOGIXnBg+XN
 NqS33M5sru/yGez32TKZnpE8sJhMC6+mOrXlFxvMlUz0fWDx6CF5erF7J5Msc3smmm49Eb2A3Z
 K/DHXdf0BHUzYCdEBAAA=
X-Change-ID: 20260121-topic-sm8650-ayaneo-pocket-s2-base-05c348efd86d
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xoU8ISrB26+6YVm1gdRipQlyceyvKNLhv4a7D67LN8I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpmHgKhcbc9ItnTDrNup6RQmyfmJAQjomk9xsfooY8
 vMw/WjOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZh4CgAKCRB33NvayMhJ0fj1D/
 9fgjQbVeIKdyxscU0ejyCmJsP9+fomSQqS7shMSBd7RBrB8EoKU+EZ8ID4M0tpbJM6zR1z5uCeJFw1
 FoXcuExNNN7xYwVnT5yAkaFyPrdnQcABDhJXu4+GhjgZtVtKMItvTzFDs36nA+MPLm1Lu+QH6O19tX
 5G0jMx4/MQKwMI1wF6Glci6kmvQ6FTYjhmdx+Yv29xDRQG3Lizjgjj1bcg7Q53RAiE0fwwaGMJLpmu
 JZbaZdhOC2I78LrZwON7+M80RAdS0lP+PZNV3DjQqhmlHCU+2v7N4mna7bbK9E+HdgGkJ4rv5/FDHu
 9cUBTGnEWW+BVu1BAeXnXLgsFNA2hORMvgKFnEMu0t0Xvi8aOzSCqj1+c/ALgwa/aLZ2dTCJkCfQGQ
 Mcnf1XVg4XMI72xGluWEap4OnGqLWCXyos8zfn/eEK8BAdVlhdIwJnTM13iuNhMFd5+7VoflgJsN4r
 NoGg6B62lvZiZqHCNakN7X9yNlArEtbvsflrfW05ooOr+bo2nNwbFEB5NuoGgWLciciLdO9hoFofLZ
 nZty8lxmPyNqmPSUwsuut38tFJQJLf7uiWmLLGEykO0+rKPcdUuxURm45IDq5v0D4cT+QZx5ksOSQj
 VYBwq/mzH/EsaxyMVtr5wzXVhCOrFQfkQDkmZtsjPLw4/fMjsDvjBbSHRVow==
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
Changes in v5:
- Rebased on -next
- Collected tags
- Rebased/renamed slot to generic based on changes from Bjorn
- Link to v4: https://patch.msgid.link/20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org

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
 drivers/pci/controller/dwc/Kconfig                 |    4 +-
 drivers/pci/pwrctrl/Kconfig                        |   13 +-
 drivers/pci/pwrctrl/Makefile                       |    4 +-
 drivers/pci/pwrctrl/generic.c                      |  143 ++
 drivers/pci/pwrctrl/slot.c                         |  140 --
 12 files changed, 1795 insertions(+), 173 deletions(-)
---
base-commit: df94cc5ccb88d2f6ebc0cac480a1b94162f4ff0f
change-id: 20260121-topic-sm8650-ayaneo-pocket-s2-base-05c348efd86d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

