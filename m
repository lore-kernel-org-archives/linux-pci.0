Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268915;
	b=wyvh6Wrr/sQaDqi7bcce6fZvDZsUkZYHbd2BAm5zFZQIV0eauPb/3vt1xWcflzZu8iQl
	 LjbMKIi1QS7iP2pVd2UED06sYcTzMDVgxJY0UXtDkRV7uueASyXdqWRPD6maxCAwvFE77
	 XGxLuH2ZoMoZBxYRj32QMAgJS4+gdzca5p6DvY9aGYb8m2GmMnqOmVwc59860vnyTDDxl
	 Cq9Upw2Uwj3V4Bmcur7Zdmx1nxm6txSiwJT1jifNUerY2P3cFsCAxq1EGNHLBBoOIbOy9
	 2OptQcrmZdLsaJDp8ILc/d2aUj6UEp7nMpinPbxr+hB9Fdphg2YXiMutQRt+lkPgrHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268915;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=W534XL0fIHUo2xBHH8CbjpPEd8rz8kzBGaOUMyx9pCc=;
	b=gdEQCYEPH5+Bap0l6yfiUJvfXtPml3y/Lj+mjgs103+3NSesErwOgWrY9O3zk4A1vRrg
	 jMPEW1b7JqbnjAsnzBGZLGW+nNfwozsBJyrszEkATqFbC6nnNmal8iJEBXT4cpHO2yFAr
	 hCLuH+Z1EcQ2nQteL8V1TV1z0KVrHFVp+DT4AxuG2MQh0hgGDzMBAbkatUKxO9gcNFD8s
	 UNrWQydl0wOgXFTgj/+q1Osyp2cth+9WYUepJ+fjniISvX0DCxB0QHE7jxRWe+hr1FVFt
	 oQ6cXoa7+gdzbIbkKMNrF+QRcpkerwa0k3sQBgKt0hdoAzlBePMCHdAv/g4vh+8e68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8A606A321;
	Thu, 29 Oct 2026 10:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A8A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1793268826ta0a5c79c
X-QQ-Originating-IP: ev2Ej5asX813a6CgU0vqNzHqkbXxOv1EU01Mx6bLOL0=
Received: from [192.168.30.244] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 18:13:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11110707060909330439
EX-QQ-RecipientCnt: 33
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH v4 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
Date: Thu, 29 Oct 2026 18:13:34 +0800
Message-Id: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPQW7DIBBFr2KxLtUABmOvco+qiwGGhqpxHHCsV
 FHuXuJUrdXu5kv/zby5skI5UWFDc2WZllTScayhfWqY3+P4RjyFmpkEaaAHwU/W8TAXjgqj17F
 31klW21OmmC7rppfXRy5n905+vuPfjUyncz0xP2rMYSHuj4dDmodGaIFCtdiSIW9MNH1wttNQZ
 wATtYQudtgHtlUbmlVMQ8eLt9LCZeKn88SnNPo5f3CNzmKVJKXjsCh2N9unMh/z5/ryIlaRf98
 tggPvAoEz2KkAdpcxXPC5yq47FvnDCYD+l5OVo4BCkA6E1v3l1IaTG05VzmhtehMi+VZvudvt9
 gVntevlqAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5416; i=sophon@radxa.com;
 h=from:subject:message-id; bh=RgOmRQN8UXUUlOJ5kDJ8nDI75yvgfp9MJNYPBSQG7xo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPZYIvaEsuqfR5cIb9SuZE5SwxrwB1r4TVoVoyes//r
 mjoOZ3cUcrCIMbFICumyKIQzzCXvTL32lOxUj2YOaxMIEMYuDgFYCK+/IwMU+cpn7Y8PnGDtaBL
 UrnMww63NZcu9bQrLXv0eo/JlpreWkaGuxU301667rxpzso2LYR7/evnx3Z8mtFYbFaiOed3iO4
 CJgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NaxljGsqHyovZsgRx5c8kBfij5TCt4enoFe4zCl6cJsS4Ls7JNXSERmD
	IWzloxP/07OvXeU2EFpCszGt7FqGnp0o1WFqkiZm5huia4bKZtD4wOp5Bn1vYMLAi5QAqzc
	b0xy+8m0q7dRYTG1eNK+ibZSe1TbVRHGwv56GjEuFkbvnU2Xed/zWYKGOedlvsyPwsQVwZM
	9pDTfmtCYM1MP8+nkHPST0kd2x2AAOzf000ABjGjfb+YwHcZ4PXUxNNG36HxZtu/3U0GqQQ
	EAtWmRLakzq5nhedLK4j3MYt/Hd3Y0ahBj6JXb+GODoBMrsNPYPlrDckumM1at++l6JuS4q
	zbzohraLror/H0yoMBozQ4QxZc+28+Kj7G7o8d0EXICYiZUN8+JWVZZkbYXUaNo84Ul6DKd
	UQEYQo3CjXDWLYPQ+SJP9OdhjA940jqHq1n8iErMCOf3CsiUmvUed7tnu8ea76N6Ityiu8p
	pRzfS9QSxXIHgdZltKWHvQtMqVlKNgq/0EyocRzLGBXbEtM60Ru7ROKHDsAGc/rjeoYudE+
	/1os7tLdfIRYEUtq1hff6CFRWqjB0mlVrYDnitTU96siScJ0yUXuPueJeSpExc5GIi9w6Lm
	YKuV8hpKOks5HN0NYrgwkN3C6HPFXPe1KKZmuVHCm/dATmhwNVUR8dG7WTdfIW5BlnmjnPz
	sBMKnb8F9+CuxygG3u3rmWc0+t24AM2xAAinymQDg4qaskqfruEPEVHW72zChisPcCsz71Z
	/eWIn+ShYz4XbA53pZ04ZGxeOYertgGaz67KFwBFuO9JODcbIQXyEFFGqxVfW0fGaaTpZkp
	ObOvm8cIlgR7MOd4zsDmV7qDG4FYZOwiks8krFLLC+ojjt4wxdxilw4hBhoehw2+hAVHyFH
	Q/rTpQMB64xVBD2to9KIPDj2CDxSvPoujlyKBdcl17H3YUsPn3Y0bgQUpZ9Ve5CECkFanKp
	Vq8LMn30EJHb+4i7clIQJg1mzxHcl11foILAsyXsCILw5ZmdRJL0ppLDwUOJf8VxbO4IYvP
	tMFtqgakflt359m5hHcDwBp/THHaSxp4ZxMhRGHRbxtSGNt779RzmmIIYOy2HEHfmWQukdT
	6aza1qzvDogRFsZYonisUpjPZnoRayriwWh0SKQ896k/vAz2EG4Ja4pCyjwd2Xgr/w0Vf0d
	KIBajTjpGxHz27YO7PaV3a5rEm/qp7e6/5nipx8mCW9ZO5k=
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
Changes in v4:
- Add the missing pinctrl configuration for Bluetooth UART2. (Sashiko)
- Link to v3: https://patch.msgid.link/20261029-q8b-dts-v3-0-655696dfec45@radxa.com

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
 .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2053 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   25 +-
 drivers/firmware/qcom/qcom_scm.c                   |    1 +
 6 files changed, 2081 insertions(+), 10 deletions(-)
---
base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
change-id: 20260901-q8b-dts-a3afc5f9b8b2
prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v3
prerequisite-patch-id: d799218553d1a8d44d83ab7d5c36a9ba7dd05e92

Best regards,
--  
Xilin Wu <sophon@radxa.com>

