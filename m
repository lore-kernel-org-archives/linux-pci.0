Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874573F076F
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389442; cv=none; b=G0vYbHcBKn8D5jh7sLwP7+vzmQ4zuAS1dSWanR5ufmvAFpMWCVO1/28xpXv6LjvmB6o5rqcwft02Do8HaLSzl7rXNe8quzg2S94xWbQ9fjRNN7ZUXOQiMPxtNZduhy0hiyzvBy4yQF/PMUbD7V2Sg6D5G5O7IFEqykT7sH9YrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389442; c=relaxed/simple;
	bh=m8IkutoYSK4AIftCStgEEiEuj916nm6elMyF2PBGCKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dlu/NvcIeu9rx18NM5Cma3PKKiv6pw/cneeorkRbSdtGr79u5630EpjHCy2pMvN8zeNAqx6DPQaSxJPzCpzUyZlpifsGkPBT6cQKgCzALG4VcUb5CNjHGoD/2CsfYkY+FtyyponTuLp/zm5rH230wqHfSp540JQwWjB5khw6tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YhoWeGpQ; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhoWeGpQ"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so9357155e9.2
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389440; x=1770994240; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zebTzi77QURIJ5j1GBNLImGicnWPF8kidr8VfF/wJNk=;
        b=YhoWeGpQip+GZtrpTwdbadjMSPRI+BoKU/UJc+EnpBXxZlP5qq38KWfKn39e4IP0NK
         pVMlYE6jTFLPaFzo3eMAggzQ9X+hVG/T0I5mXOvh3xq5K0TNLRCARWGNwnAuLCkac2x+
         VDOfomavkA0rdph7+4gb/0Cv70Ct0wRFyrDA+zPw9tpVbBKjOxRQG56Wx6Xj3Bbfx1Hq
         3GPFZySXyb3Yzl9hZKu2hM/Vcg0trQV7QL+vQ6n5wqAam6t2j5qXcPafnsCtqjzd7E6T
         02QMPIz2UAtHJ+s4+zmgHn+SqL30U3t8y0dubeGXUuVB3McOLGoiNEXJQUjFV3ljFE+F
         Q/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389440; x=1770994240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zebTzi77QURIJ5j1GBNLImGicnWPF8kidr8VfF/wJNk=;
        b=pkUucYni7ByPrZCCkIjtn+lIyw678OZ9PFa94I3NfAU2MqN7omQGVFtLVGduhAtt+l
         VDy28GnAej35NJSaEmFcq743eoNeBEQD11gtKEQmwKxtzhmXd/ya1Ofi5jQn7J4CcWya
         vw5F1YOo7bwtF59UZJLDwaZ6AQhMsuN6+zWLPE2Zc1+gD7PJ01H/Y55vXXBZLDza272r
         HToYrPPtDYxTXWRn3SMX6jTcIInmHAaro+h4bg+a4hzsJQj9qG7Kvgpg4tzBJNwfqni8
         31JciuSv4+bJUPY/KyDDjWWV2w3Gh190cg0WPIguFqeFXfYizDON5+t8jn48J6Bm1Vad
         e6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUAm44DuixJi75jd/xa1ygpq7/RAeCZM38Re/6BDuqy6f66IsQJ0OeoxlSGfV7hArPkreP9khIDg/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sSQkI4PUFVLLtUDOf/tRw7Bn2PNgVC6MDpVMftQ/Jvz/04Rw
	+gQCpShA33Srv2c11PSnL2IhaqD+isIGqtHarjjesjgStlQP14MhyVxWqSwnEIGNr4M=
X-Gm-Gg: AZuq6aI6GpFhs4sEELW+P9U6gIZrd2VdOwuUlSGXZjZFqSCf/x9qXQnnJtmqxCp1pdL
	k4RnK+amXccDmrw1Z+X4dVOMFflbXNSeWb3pPoxEduykgLfBp2RBTtCdQKgv9a4NpNt18mZxHV9
	aH6LC2FLxLjgFZ2bixkkOilmI/GIbDMgnZo8jIxD3qd1obb/b8kiQcJHApf68Gc9sP9w82uDrm+
	Kbk/Y3TVTPku7dZjXeAUznfBkDQrRtYQ09tUlPnzCw+LA0X6vt99+hGvpaMPlGIolOHD+Ag3Hll
	jDWCyVunigO/B+/jA/iSLl1LCae9vau8jZpqNd5iSWK6KEX+3PIh1wpSt1KBh019uHNNlp0zE5Q
	/7KuevIUXdBMQE58qcwLiGtucL30Zf4DVXjfmy+QVdY1pDnbnmLqYyqh0zlIUQK1QNu/TQYaxAn
	FNrgwcBnXmn/Pe4aXMdOp/iCylFhxs2PqI
X-Received: by 2002:a05:600c:c16d:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-48320216097mr42013185e9.22.1770389439304;
        Fri, 06 Feb 2026 06:50:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/9] arm64: dts: qcom: Add support for the Ayaneo Pocket
 S2
Date: Fri, 06 Feb 2026 15:50:28 +0100
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALT/hWkC/5XNvQ7CIBiF4VtpmP0MUKno5H0YB34+WqJCA01j0
 /TepZ100/E9w3NmkjF5zORczSTh6LOPoUS9q4jpVGgRvC1NOOUNZZzBEHtvID9lIyioSQWM0Ed
 zxwEyB60yAhWmPkh0VjaWFKhP6PxrO7neSnc+DzFN2+fI1vUvfmRAQevanYRjhkpxefigUtzH1
 JLVH/mnefzJ5MU0QqBhWlip3Ze5LMsbT2lrZCkBAAA=
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2986;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=m8IkutoYSK4AIftCStgEEiEuj916nm6elMyF2PBGCKU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+5mybkj4M8sjAXKBnfpNIYlbRXcC6v1cTVndyF
 W4GcPhqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/uQAKCRB33NvayMhJ0RptD/
 4vRDG/iYugtoeGRKl3eTTpWxV0eguyVr+qA0ihqqHccxhcAqOlZP7m1hXzQeGi7G95dnxdWmwVcdcL
 w6zQyrl5UCC/UkJ1HJm8RVpb0znKXYKlWZ+E+1n1T12Jlt6P2b0hys/G3owZ3fIkrkkYXaZqGsRcQr
 VcDs4VN3njViJUSDrvhj97YL9OkrnYJ3ZcxXjLfbIL/J2Y9WXZ1l59nGjEPD8CjC2ay1dId6yWoRRM
 lLzURG4u4OHubjrXFrZASUR6es1G9N8087pHBIko2v5u7IK4PnLHd63USpHaR6kZkexpKh2LyKWka2
 YpDu0iMSxkIxRIvTvxS2ihm+YHt8shfoDDPl686GDJhN5DOnrQlmLg/OTU5QE2vHJxb7VdvLfI7qPN
 GFAcsNlAVmBJltrorVynMJLhsFfOpB+LRoeY+E7rCo7yRf0oSrrjPIP8xNrveo1A8SOqOl2RdQGQ9+
 bfFttpUJoeBbIl1Obpp6eRbsgPp0hJ2qIBAkkt/dMiQD6FwhX20OmDlpocwOoj+WK+8PUKp37nJAzR
 ttlHmtt57G6811bAKFzE+ZXoVBy6Z1UvJ0c/dms4YChZmbqJ9pfKFWFFw9CNfcjqa/qOY7Fxbt1iBL
 1BOxeUDm4lTxnYyu/AZBGE/CRKME7dAWc2DhXXL2VlS2JLctTThu66b5/dgQ==
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
 drivers/pci/pwrctrl/Kconfig                        |    8 +-
 drivers/pci/pwrctrl/Makefile                       |    4 +-
 drivers/pci/pwrctrl/{slot.c => generic.c}          |   16 +-
 10 files changed, 1655 insertions(+), 37 deletions(-)
---
base-commit: 8efd812b03edcd5fff1b3a36c0277b2d1397712d
change-id: 20260121-topic-sm8650-ayaneo-pocket-s2-base-05c348efd86d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

