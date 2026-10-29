Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267170;
	b=gacJo/uvFpB6O9rcCjF4M0oOBkyyCC4xFPpj2y3D1MJFKM9LjQN8WErtnTDTejDsCwlJ
	 ZWYnsFCWvm9QBjr0Bd74jSdZNCdv5gh/q+asNW3k5u8Rt/a7HM4SKhtBMTO7KELUBDCrh
	 iWHOwoVdseluuj4sv9CcXtttBqOw6/1BCRqNGqn9RVCFvOEu9g7GD13Ddqj6uOIXSnTWW
	 hrPNqmm86+2hxF+TcOaOYNu+r0PuRcBOJtWXrnPkTPqSASMthpLeaL/bzaLFzBe8xvP6k
	 CPGoY9g1lb3mTewcki4uiFVcHLCz5ON7lA1WnLpYnJE1T21FBHwxXH5ewV2Kb/HM6FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267170;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=Eb+YjF4uyYIy76ATCpeRBu9oHfUw5Auh4r0xp6/hncE=;
	b=SjvRXzEdeJ2XQpB4q55P1nrWKePaV4v1l1CPC/nWf1QL7u5/tVzP42FI2VFLxA3u2/tE
	 j2PwdtsMOnKbqCEMiEZwAwVxXvDlX9ZeqY7AulPNb/ZZk66HbLc0tsX3io35h+Gp4HLJz
	 mG5DwOGf0uHvEYtx5xn9na5xm8ZmK7VQqVpi5Y63EqIsQGiCMY9hxfFFfWk9IkcLOH34D
	 8+/tZC27b/hIet6IPkwdJQpEa+UAl8Zxy8n5zZsYxlt3EaWK5bZ8UQheEPJjVNTe4+uQQ
	 PBteiOoYp2fOryU1wpIdpWN3ZUBd0ZmqsRnfGt1X1FH6hxplkZVIva/O85EG1t/+8Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC5606A31C;
	Thu, 29 Oct 2026 09:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BC5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1793267077ta2b7e801
X-QQ-Originating-IP: I+vPHSJSDpobu6fSnZn9cbX0MDgRUYSMziygJGOmxQQ=
Received: from [192.168.30.244] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 17:44:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4232526379047253764
EX-QQ-RecipientCnt: 33
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH v3 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
Date: Thu, 29 Oct 2026 17:44:27 +0800
Message-Id: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPy27EIAxFfyViXSpDBkKy6n9UXRgwHapOHpBEq
 Ub59zKZqh2pO1/pHvv4yjKlSJl11ZUlWmOOQ19C/VQxd8b+nXj0JTMJUkMLgk/Gcj9njjUGp0J
 rjZWstMdEIW7Hpte3e86L/SA33/CfRqJpKSfme41ZzMTdcLnEuauEEijqE55Ik9M66NZb0ygoM
 4AOSkITGmw9e1TrqkNMQcOzM9LANvJpGfkYezenT67QGiySVKvQrTW7mZ1jnof0dby8ikPk33e
 r4MAbT2A1NrUH85LQb/hcZI8dq/zlBED7x8nCkUchSHlCYx+5fd+/AbkGeuZwAQAA
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
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5241; i=sophon@radxa.com;
 h=from:subject:message-id; bh=/zhIWTwL1Cz0zrP35Sl8LOl5YIDsbDAvUa7zNtBYbeU=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPRWuPTjKMuV1fdUFm2pOdUX/zFVZMFwnKY/gebrE0x
 uVW6tSPHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACZy4QPDX5HkvTlppzgCK74K
 7D1f+/2xuEEUw1av01s+v5CSTfnXvovhn8r0vv9zAxr79pUYZHy2qoq5cOmwhl/9c1nVW0slGdS
 luAE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NkLA2q2LD229xXlFYkv7wmpaCSc3vnAuiIm5YfuC8W79ynlckx9nwZBM
	UIVNU23oiM0JD/qMpdEu/4J1LzPnXqevz5EauFiEHzjkMZKGVr0wBTQLQqkJCCq9COtj0QF
	FyZW8/CU62uOEVxk2ahAOIQii8V5BZShQH5nHVHRuvPSOV1sUOtFvwDyKWylg2n6nPp/TMW
	O6mPTdUzhUxKItb/G334b8PrDwrBSHey5Nt8jMc51Cyr5HSe36fyYd0X0LxB9vGv+22Uwka
	uVNKiZ46cIM+AeSVvoyGLZf3R/qOSEDDp5GyzQ13/DFboKaKvIDLL8tE4EYMvcpc3QDs+my
	PQvNM2Cpwyr6iBgnsCT66Ni6BMkNNqAO2h1bd9AwK3He5wvPZYX1ly7cxj3rapYRjZARqG2
	8i1LRylI0x+CbDCIQbOw4iwvTmc1D+HRLd9QnOayVrE4ZS2r8PjGJ2LbfnmFRXL5BESON+2
	aBpTlpjV1SSoIhhOB1Vvwj+z/8ZM7CSC7Ov7nUe5xvNlUNzuuBi72yVGJ6qk+e4ALNej1kP
	W6x4NkGwrV4dNPhSy5oaxK8G+H6fgtW020blL/zjT66Nc9W6x4UT/PKS8JL5hIReEMru7/s
	SV0y6EqGyWiVqAg6nVOV50hgWMQzeE3PO8teLMIzcC+ilBPdB8mlhEg2wTPMBMAsp5VPX4J
	52RSXr+rkfv5f5OlqLGK/OtghkXyZhG2D+8gUm0TW2u0BrEw+ugV9qO8Q/bdZoy6vVkD4pU
	E0/VTuQkbskH00xTTil7x4eF08syp8AWpPEfIG2QyuGsqEJ2j3E/aeVOPd3t/fonQ2x19S6
	tKBDlG0oQFBIwz2HEa3kLig3J+hnzWDYedZNAtP37s17e9u/KYIXK9sD4JSV2XILU+qkiOU
	12QTYVKdlQ9cVzdVT+rysgw5LHANlnJFFXPqMYrVDnuvGqwHFmEOZ2N90HdcBsBRnXZ8OaL
	DO3kI2TxrBWHPV5Lg4XS2dbkCreA4II3rOG3oKObl7NeGyhI880IcxVRxV8tD8Q5zcMXxu/
	xOfBEjOluPc5LXXctqUD0CPCX66Sm8fJd5BtW4vWJ5gDrFiGQ0/j8kU7DRDHsCFoq9j/lbI
	PqjwO1qjCIRByHptrFi4iyBBU6cpwp7GVpRpEEQNQ/K
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
flash and requires no host-side configuration.

The PCIe ECAM and 64-bit memory windows are defined in the shared
SC8280XP DTSI for all five controllers. The board DTS inherits these
SoC resources.
The SA8540P PCIe2a and PCIe3a address maps are kept unchanged.

The series also documents the board compatible. The SC8280XP TLMM binding
change allowing gpio-line-names has already been applied and is no longer
included in this series.

The PCI change is required before applying the board DTS patch; otherwise
the disabled TC9563 downstream ports cause a boot-time SError.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Changes in v3:
- Rebase onto next-20261027.
- Drop tested-by tag in the dt binding patch
- Drop CH7218A patches which have been applied
- Mark vcc_5v_s regulator as boot on
- Add the device to the QSEECOM allowlist
- Move PCIe ECAM and 64-bit memory windows to a separate SoC DTSI patch
  covering all five SC8280XP controllers; preserve the original SA8540P
  PCIe2a and PCIe3a register and memory windows.
- Format the board DTS with dtfmt and fix subnode and audio-routing layout.
- Drop forced output states from the SBU pinctrl configurations.
- Explain why full-pwr-cycle is needed to recover the SD card state left
  by boot firmware.
- Link to v2: https://patch.msgid.link/20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com

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
To: Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Xilin Wu (4):
      arm64: dts: qcom: sc8280xp: enable PCIe ECAM and 64-bit memory
      dt-bindings: arm: qcom: document Radxa Dragon Q8B
      arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
      firmware: qcom: scm: Allow QSEECOM for Radxa Dragon Q8B

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 arch/arm64/boot/dts/qcom/sa8540p.dtsi              |    9 +
 .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2049 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   25 +-
 drivers/firmware/qcom/qcom_scm.c                   |    1 +
 6 files changed, 2077 insertions(+), 10 deletions(-)
---
base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
change-id: 20260901-q8b-dts-a3afc5f9b8b2
prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v3
prerequisite-patch-id: d799218553d1a8d44d83ab7d5c36a9ba7dd05e92

Best regards,
--  
Xilin Wu <sophon@radxa.com>

