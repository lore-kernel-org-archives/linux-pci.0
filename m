Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915B432E64;
	Tue,  1 Sep 2026 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252527; cv=none; b=aUpjb14biZqmYXNOcCTZdnwxg0UI3Xtf2UwC/eIAfbajARbujhrNurQaQsyZxx2Owa/caO4vHEh2/74HjVDYVBGW07JaquCrmV95PHILk9gkHpnb3Sd7beahEzMFgHGTkkZISUvcFbTlc7EHcGUF+4cclJts3yNGuQN8zty6z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252527; c=relaxed/simple;
	bh=UYGerCvtrg1gf7Fe6mKZZbNkuqt5Oi9rbPIybdcPxmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uqprwpnRzYRcSsfowFb/Zkbgb3xHalJuQpgcEYzBF5SJOxOkc9ffY7EuPaJPH1EYZkpL1Ug4hYByk3EJxqYnkk+NsaYC/LuIZVhpMUWLMkbPKfcoRomqCqVCtWH5GJ2gTgdpo9cuYQw+hv/frCHIcRssp2RX2ciqiVX2vY4uh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1788252487t74d85662
X-QQ-Originating-IP: 6/M5hO7GM94hyD+cP78f4MtHvhzmO/aswBYiw39aBq8=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 16:48:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16767261653343235957
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH 0/6] arm64: dts: qcom: Add support for Radxa Dragon Q8B
Date: Tue, 01 Sep 2026 16:47:53 +0800
Message-Id: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OzY7CMAwGX6XyGUupQ9K0r7LikLguZLWUNkkRE
 uLdN/wcOI40/jx3yJKiZBiaOyS5xhwvc4V21wCf/HwUjGNlIEVW9arF1QUcS0av/cRm6oMLBNV
 ekkzx9lr6Obw5b+FXuDzPP0aSdasvyluD4LMgX87nWIZGtLJkHWm/V7Yjw0J94M5wcMJ7241aW
 tFk4TttaF5hRnWY2ZFTtwXXbcElzlzSHxofnK+Ros00XAkOj8c/XJgeTPMAAAA=
X-Change-ID: 20260901-q8b-dts-a3afc5f9b8b2
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=sophon@radxa.com;
 h=from:subject:message-id; bh=UYGerCvtrg1gf7Fe6mKZZbNkuqt5Oi9rbPIybdcPxmo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjp/X7S1/uXBtY3yvGWyJy54GitMrP3+9jVf2Py1Y
 Y9Cb9okdJSyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZjICmeG/+UvUwWLwtrvbb3n
 wscqmuD3m0uslP8P6zLJEJkfjvVmjxh+s8V8/cVVwsFU+3Dtu7n/nvzyblm/NiicO2XDrXdLhCT
 e8QAA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MdLfOU3VbxhILlcMnbHAhRw1pfnHtP8Mtu0MhfZzBeVj87/RTFPdLC89
	qTCH13/4/l6/yl9up6pKaZo57I149s4PEo+uN1h1tOoICFfyZbCP+8yDreOCsOMGcEZFoFD
	DSQZA/72FTjEDm5iPKNXVrvveV4dTDIIw2o18fRIIX8SnCqXmfu73ZxqMieRjXtKAZUyoLh
	k8dqf9mLiepCV5YgA6NM9XweTK03QGeSzTqh82H8N9a3QTc6BBxGce1SyfPvsVHmMAu+eib
	q/eJ1m1DgYq7bWpf6ILqyiOFV1dbif/lZ+KZfA7JVCDbFLOSFsky7yNYrjP0bHUMA0sOiWV
	sByZaJJjMgbE4Xl0MFVDsL5/3EWHM6OlvpqmgFu5wiMAeqD2p2Ilr3MWKDUbdHiUAUotfzX
	dMtfzHw9mneon57TkVFSA3F0BwhvbZHZmDU+X243M3uzqly3OiqqT5qqMXCSFjro/yllYlq
	BPoG2X6qHxzMJ04uXFjFbA/k9FuAAvkJH33qS5lKLU3sBqiddmCmPQvqiABrUvW34LrGi8b
	hBpESEOq96GdLm/9QDFfT8j2ILz50ASWEDgYvHC+l8IpwMFOOgA3+69YSJtFhxa1vM6z13g
	KR8Mhv0/xQe4Dge1hKbfdOeRsLpQCEentLw0BL+c0JupkIqElrPZVGxDC9Uql+ETsE40ajM
	0Tgt3bKCknM2F4ThGQudvDXkpFL5vctGQqr8mrF7l4k3BydHyXiNRflzEYhe4jy1XPlzryF
	lfDk4cP1rscg6vj6Duc+0bcRYtWIHbfuk9XD8suDQw2Kw5yWuRuL+sxAg2fI3iD12dar+j+
	yj6YjE2ZNV61m80wc6UXPreMta3yPrRDstpobzJLVV2C4EqXKG2ISBZTcI0e9EC62BfEZxc
	tTYiRaVSYlqwPe4GPiL8hrHkRk0c7NTm/60s5Ltu4FOiEqkuMo66f6nlaiX9YjENwpcPAJ4
	xDWfh/MlWlCITrA365E8tEuLVNwlc1TeADHg5v2qlAuXpPA7LZyDM0vj0ymSqSHhdNbxLpf
	CqhPD4Sv2pEYGqv4TNXfZOGQ5pncm9UxcaPwIgr68Y0lM3G3zkt2nYOyqigtE=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Hi,

The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
Snapdragon 8cx Gen 3 (SC8280XP) platform.

The board provides UFS and microSD storage, two M.2 M-key slots, an M.2
E-key slot, a QPS615/TC9563 PCIe switch, USB Type-C ports with DisplayPort
alternate mode, USB Type-A ports, HDMI 2.1 output, headset audio and
a 40-pin expansion header.

This series adds the initial device tree support for the board. It
describes the regulators, storage, PCIe topology, USB and display outputs,
audio, remote processors, thermal sensors, RTC, EEPROM and expansion
header. Build targets for both the regular and EL2 device trees are
included.

The TC9563 power-control driver powers off external downstream ports whose
device tree nodes have status = "disabled". On the Dragon Q8B,
config-space reads to these powered-off port functions raise an Arm SError
instead of returning an all-ones PCI error response, preventing the board
from completing boot.

The first patch therefore makes PCI OF enumeration skip config-space reads
for unavailable DT-described bridge functions. Disabled endpoint functions
remain discoverable so PCI fixups can still be applied, while driver
binding continues to be suppressed later.

The onboard HDMI output is provided by a Chrontel CH7218A DisplayPort 1.4
to HDMI 2.1 protocol converter. The device boots its firmware from on-chip
flash and requires no host-side configuration, so the series documents it
and adds it to the simple bridge driver.

The series also documents the board compatible and allows gpio-line-names
in the SC8280XP TLMM binding.

The PCI change is required before applying the board DTS patch; otherwise
the disabled TC9563 downstream ports cause a boot-time SError. The display
binding and driver patches can otherwise be applied independently through
the DRM tree.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Xilin Wu (6):
      PCI: of: Avoid config reads for disabled bridge nodes
      dt-bindings: display: bridge: simple: document Chrontel CH7218A
      drm/bridge: simple: add Chrontel CH7218A
      dt-bindings: arm: qcom: document Radxa Dragon Q8B
      dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow gpio-line-names
      arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 .../bindings/display/bridge/simple-bridge.yaml     |    1 +
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml       |    3 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2097 ++++++++++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             |    5 +
 drivers/pci/of.c                                   |   27 +-
 drivers/pci/pci.h                                  |    5 +
 drivers/pci/probe.c                                |    5 +
 9 files changed, 2144 insertions(+), 2 deletions(-)
---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260901-q8b-dts-a3afc5f9b8b2
prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v2
prerequisite-patch-id: 1060ddda6f3ff07b36691a0dd7d783a5be2cc993

Best regards,
--  
Xilin Wu <sophon@radxa.com>

