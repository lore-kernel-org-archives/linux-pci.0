Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439B340401;
	Fri,  9 Oct 2026 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532610; cv=none; b=uvUN0Nw4Vqf4y0sTDrl48kzM5Og5gQ5dJjl7OgV1dsNWo1VFMDPKHJAGLXw15JDDYkZBBBm1/Ga30Hpj+yo+TtbgywSwK1HPeRJXLSS8DK4Hn8a7Hn5ydX9fLxvV+LJHay5XfEEZcP6KCPSOkufuMLeAOa5WhEjcTvTeBFWyehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532610; c=relaxed/simple;
	bh=zDhMVNDbNx3vkG4egCOIH6uOAFDS34JQCEN3kVWtccE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L7HaFWx2Pj0wuvg8bBQGoJ6XhswpGUEWuSVDBphl3e1HjX2hdxRz1EjCBSPksG52pb0oUqPZAFwgQcgbe6c4vGy4SGGNotL2CKzpjgQB0tJdV6oXqtgPpUuhQJKw+2J9sYMie56dtVEIGYTriRONHJAd60/73+9deAu5hiUxCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1791532521tcc01530a
X-QQ-Originating-IP: UWuX76hIPH1r9oQg3By8mO++236onaSHj0Sgf6QQ3jg=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Oct 2026 15:55:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7057571656101032469
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH v2 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
Date: Fri, 09 Oct 2026 15:55:05 +0800
Message-Id: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPy26EMAwF0F9BWddVcCYhsOp/VLPIw3RSdXgkA
 VGN+PcGpotKXV7p2j5+sEQxUGJd9WCR1pDCOJSALxVzNzN8EARfMkOOire8hllb8DmBEaZ3sm+
 ttshKe4rUh+3c9H595rTYT3L5GP9tRJqXciI/a8yaRODG+z3kriLBFSqNwly4alA6wta6Rjqry
 V1U4wXVJFCxv7QiPWCSN5CcRs23CeZlgikMLscvkMZqU5AkZN+tyA7ZLaQ8xu/z5bU+If++W2v
 g0HjiVplGeK7fovGbeS1Ydt33/QfMOlXPOAEAAA==
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
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4320; i=sophon@radxa.com;
 h=from:subject:message-id; bh=zDhMVNDbNx3vkG4egCOIH6uOAFDS34JQCEN3kVWtccE=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j4KNmmaZa/x7MGbJzl/juhuWZzie1jvyP7IvQvTm
 t5yXVps0lHKwiDGxSArpsiiEM8wl70y99pTsVI9mDmsTCBDGLg4BWAiDZsY/nB1mDFcFzoz+WN7
 uGh94M+uLY5fnD/LbBdurRS+2+BvxsXwz/ynTUDMrG1Pnip+7z5+ZMbiSqnY7veeiXcvXq+WusP
 1nhcA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPaKaX623R7YUqxAJ4svXN2j22pcV46fl3gGi60OWfchhfyaqgE9FRr7
	oQD3v4vq76ukn4tJ8awLYuORqnATTZV0OmdThyQwDe0ejF1r02fy49u8yX0OFNDJ/s+rNCT
	pZn/9+2JkDKfCQsUP+ZqRXJP8JLG4DaHwHE09o9TNDMPcoHNh/lfADwnpGe0SkWgkHa3HzX
	bGEDqSeFfCfqEDrCKmuyEe2kr+ornu/oWwB2DwBvLZu6vdPCpDYQ9pMBY6KY4Ams4W+u5ZI
	OirWM8tjxF77hP+dFiR3nIfoQoL+aKpQmvQJPGCeEu6qTAesfHZNhf0g22pWGwdcKjO6LQO
	3SV1gabLBOPglzpuWOo5sZcMzBoUtbtM2xQO+SOoB6H5JHNPN1JD9PdZYTofXJIwbtPK92G
	xOdyBzsOE1bc7aFMnror7lKjFWjjQ/FJY5ky/+l/Zi0YZwldZvadjbIFSSzNxN/sTbEIxna
	Inq/vcPr/5j/BeytrTNNCkVGXLoNI9VTpXOVcJtJiDsbxCvrRwyXKoHbg/xzrhjwV+b7Sop
	omkrFBpKtLl/EIp9Im2y5WpuZ9GYYzUvw3tMMdsTzmcHJhvQEuzD7VtF896vmDn3SE8hgdu
	fqjkCRDrSRhsbHqHS8axvoIKKSD9TI/B5mmIxHOHndwgLr1qAVtTeO/lr1BGgzYWjKapFI6
	W/E2Vsffon6k2DMyMV8aWZBmTux9hkXMl7oK2QKS/Mfy4ZKhuXhQHR9qP0vnFqFkjTSS4I9
	HJVKpLomT8sKfjmjYV62f6wCKGe1H+5fwi0xMwfucfS9eVEAOlV5Q0FeQItsNyFPXwwzVJW
	+62mfhwz/VOkOhnQLTEjbeSOQOJ7UjIXmFC85b9lmi1WoBJz77rUc+xA457VgmGsyJIQ0gb
	358K7NQ1Cfa7o5YR7i/2E7IR4yCR9pOO7qo7YzIzCS24PnvIDYSjoEVad8mMAZjpOIoBMbP
	WF9Igzq5LPaZmsbdjfdxuHDsIyQJQFvgsnZpeLB7rKKCnDPd+uEyZ69VPR5mMUo3+QZWynN
	3f7UC7ChMhMogErBRT3kFzgEfPREYNXC2fvYqXdEETrfpGQKe9eBue+HiTbcA7gDrxyrwBI
	FsLQ2YHO+3c
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

The PCI OF change to skip config-space reads for unavailable DT-described
bridge functions has been split out into a separate two-patch series for
the PCI tree. Disabled endpoint functions remain discoverable so PCI
fixups can still be applied, while driver binding continues to be
suppressed later.

The onboard HDMI output is provided by a Chrontel CH7218A DisplayPort 1.4
to HDMI 2.1 protocol converter. The device boots its firmware from on-chip
flash and requires no host-side configuration, so the series documents it
and adds it to the simple bridge driver.

The series also documents the board compatible. The SC8280XP TLMM binding
change allowing gpio-line-names has already been applied and is no longer
included in this series.

The PCI change is required before applying the board DTS patch; otherwise
the disabled TC9563 downstream ports cause a boot-time SError. The display
binding and driver patches can otherwise be applied independently through
the DRM tree.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Changes in v2:
- Describe the TC9563 embedded GPIO controller and use its GPIOs 2 and 3
  for the external downstream port PERST# reset lines.
- Drop "PCI: of: Avoid config reads for disabled bridge nodes"; split it
  into a separate two-patch PCI series, including the kernel-doc fix.
- Drop "dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow gpio-line-names"
  because it has already been applied.
- Link to v1: https://patch.msgid.link/20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Xilin Wu (4):
      dt-bindings: display: bridge: simple: document Chrontel CH7218A
      drm/bridge: simple: add Chrontel CH7218A
      dt-bindings: arm: qcom: document Radxa Dragon Q8B
      arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 .../bindings/display/bridge/simple-bridge.yaml     |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2102 ++++++++++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             |    5 +
 5 files changed, 2111 insertions(+)
---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260901-q8b-dts-a3afc5f9b8b2
prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v2
prerequisite-patch-id: 1060ddda6f3ff07b36691a0dd7d783a5be2cc993

Best regards,
--  
Xilin Wu <sophon@radxa.com>

