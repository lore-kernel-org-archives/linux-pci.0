Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795747492;
	b=WWhK7e050Sul5WHRAmJKtYcz12uka9alI6WJKg/Gcpm3O8GS1tfmhtMsUU+3wgbTP4JL
	 ivi33pDPoixonr+Xtf+niVRrvb3Aw9qvk8hw931ZGwEHtY0PAVzB7s+Xn8t4EPjemsadQ
	 Yl6O7PMKc9e2+HBrnsrIq3WZW4AtkGfsH1gMysK5Ur6ey4FnC4E+Drw09Wgk4N1mK4+ld
	 zt9JnYF5SQBxGB4Lasa3aHYGRCij0Aj/HHB3n5M1hGo8qxIRCdS5b6sG0RzstkIjbODIM
	 7kCzJvn59dIIyIIYMvCIrfwgMkB2s/7NG8mcx0RdGAt4sOog+Pd/vFHbtEZjQ1b2b4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747492;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=kYbjo5yqCTRcQAiF0cwEtvXIBz+JR+h/RMAQd3IBiYA=;
	b=O98yPMC3KRVhk9DV93rzNOZ92nVHwkSIR0QFpVwRB9t2mx8513O9FnkXWwUymbva5fqK
	 gc5k2ODdOZ2pM45pJyHOr7PPXdKBfSIz/SOKAWxjB7v+hUH4M5pqDe8NHzHOQjfBLu0K+
	 OouBQSTfkFnruGGh9ZaxZaQOibfsE9IbnFklKlWG3ZeAZN5mEPFe0rSNdhSv+8NzCXKbB
	 wOT+7DS8CobjlDQ8k70LCbMvCiVA8sfIqLTvLak0dIuYx7Xl4H4dk1zps3iVIs/RfYR7W
	 E2an4ZfE3jH+RrpdbiAbgKvLYZqF5BM4cJAZlQsAR43fnIrsiUOPlxY9RznHHz5ehYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB9606A321;
	Fri, 27 Nov 2026 02:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ABB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1795747384tf62a4e1b
X-QQ-Originating-IP: x4DU+Xm2DfTGAfcue3PF1ZWucoWXPbJIdSCs3AD5vMI=
Received: from [127.0.0.1] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 10:43:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14243125072824456397
EX-QQ-RecipientCnt: 33
Message-ID: <FE7B564926118C33+50565d89-ad83-441b-b85c-cafba0df5546@radxa.com>
Date: Fri, 27 Nov 2026 10:42:57 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sophon@radxa.com
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
To: Chris Obbard <chris.obbard@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
 Junhao Xie <bigfoot@radxa.com>, dragon@radxa.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniele Briguglio <hello@superkali.me>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <CAPnEM6aAK8hwJ3EfhzS=gdMPTf+bhVgS-=JAoM+axcHzBQ1CGg@mail.gmail.com>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <CAPnEM6aAK8hwJ3EfhzS=gdMPTf+bhVgS-=JAoM+axcHzBQ1CGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NAaMC4onM9At1swkfyODxZFKOUZWV4/ScdoQapcl5s2CrSmw8kqyDCCP
	30SxmXTGB4M6VIidaPxFw1cGdpFIiAhRR/f/lFyYQulwl2/mHDc9mKVKPR/vZW7JyekXknk
	lhLckfHwC+s/oKV2EVuCM54Yynnc+dA5PUaEuOtwly7X8dh3+rRjT5DkAHwwGdrMQVickRF
	oI2dC7XK6gbrowitEL5JVTwe5LCs382JQfukIo7DSARL5QZz7KpeVUl0gW4WmceA+ZARBZY
	sgmtnvIx/pH4T00jMJ811tVntMCXQbTYd3lfsKudtXQvk99bIA/1QdcSZb4VFEYaumWZjpT
	FWXYZavZR2RYbgjcbCH2WJyv6ncX2Q1w8N1O+mtRnbW019PymIEaLQOSiDDTfeHkgnj+xde
	gWTfpqA7m/4PRWSLqFM756vT5Etas3FEhvrF0AKuHVlMxeAGhXBRhfuKqGzMypU7NJTi13M
	VS0BBo3+UjAMnBF4STUW/9/OiOyQ/6RCPymXWw90KyoYtfbRNHmUTKzS1gkkFT/ESxN7le5
	nZSk3uUKgLbfCq67m6Omkqca3w2X0fnkpLWeMpTty+jymi4ZXlBRQCeRujA/N0qx3MvBK34
	wpgU6hq3GwyO9hbcCX38vcH4WjpZF1S9PcjbRdTZziNKFC7zOamniIXzXqYIeA6OpIhTtRm
	1Mpj6tFvOjWBfB9yN0KteFtOacfwJ/q+5EEdgT/kYWWysJjH5XsbCtEgd9/gaMu51/AexKT
	muXy9rQGU3wLe+ClpNzFYKnisGedUAhXwYWLjiOdYNglkFHW2yQnbO9Z4xVc9MRSp2b1fQb
	HsSRYy26IQoqJGCDE3GhnqwUz66guU3O3uA4dLcDehq7BxLD5uSAOUo+SM8jmW7PP6/oqNi
	BcPMiVjGnt8kaFgcHHGFDt7nqwYu5E7KR6lcUB5Fxc+4itV8Fspc/xT6Nh3jrhi2ywDHJ6N
	cNpp+Oe14/lNjRN3xPKdj2X5Tf8t0PEw7+3kkMECfLtYSH7RFaERPdxFRAVXIpxqqGnFpUh
	0cKAw3rAQWu3S7NRAJclpBORX2iUtowtX/7R0osXB5TwJdLEtrRhlQiNH4mAb8/e/iw4EEl
	ZhHRBQZiFamw5eXPJp4aYv/b/kwbsYQ98pPiEeVfa1cZTYIZM4f7R698dE+5W8g3w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On 11/26/2026 3:33 PM, Chris Obbard wrote:
> Hey,
> 
> On Thu, 29 Oct 2026 at 10:19, Xilin Wu <sophon@radxa.com> wrote:
>>
>> Hi,
>>
>> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
>> Snapdragon 8cx Gen 3 (SC8280XP) platform.
>>
>> The board provides UFS and microSD storage, two M.2 M-key slots, an M.2
>> E-key slot, a QPS615/TC9563 PCIe switch, USB Type-C ports with DisplayPort
>> alternate mode, USB Type-A ports, HDMI 2.1 output, headset audio and
>> a 40-pin expansion header.
>>
>> This series adds the initial device tree support for the board. It
>> describes the regulators, storage, PCIe topology, USB and display outputs,
>> audio, remote processors, thermal sensors, RTC, EEPROM and expansion
>> header. Build targets for both the regular and EL2 device trees are
>> included.
>>
>> The TC9563 power-control driver powers off external downstream ports whose
>> device tree nodes have status = "disabled". On the Dragon Q8B,
>> config-space reads to these powered-off port functions raise an Arm SError
>> instead of returning an all-ones PCI error response, preventing the board
>> from completing boot.
>>
>> The PCI OF change to skip config-space reads for unavailable DT-described
>> bridge functions has been split out into a separate two-patch series for
>> the PCI tree. Disabled endpoint functions remain discoverable so PCI
>> fixups can still be applied, while driver binding continues to be
>> suppressed later.
>>
>> The onboard HDMI output is provided by a Chrontel CH7218A DisplayPort 1.4
>> to HDMI 2.1 protocol converter. The device boots its firmware from on-chip
>> flash and requires no host-side configuration.
>>
>> The PCIe ECAM and 64-bit memory windows are defined in the shared
>> SC8280XP DTSI for all five controllers. The board DTS inherits these
>> SoC resources.
>> The SA8540P PCIe2a and PCIe3a address maps are kept unchanged.
>>
>> The series also documents the board compatible. The SC8280XP TLMM binding
>> change allowing gpio-line-names has already been applied and is no longer
>> included in this series.
>>
>> The PCI change is required before applying the board DTS patch; otherwise
>> the disabled TC9563 downstream ports cause a boot-time SError.
> 
> I've been testing this series rebased on top of Bjorn's/qcom's
> for-next [1], with a vanilla Debian forky userspace
> + gnome, booting from a USB stick (in one of the USB-A ports). I've
> had a couple of issues:
> 
> 1) Reboot shortly after booting; with:
> 
>      qcom-iris aa00000.video-codec: core init failed
>      arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
> iova=0x00000000, fsynr=0x120001, cbfrsynra=0x2a00, cb=7
>      Unbalanced enable for IRQ 252
>      WARNING: kernel/irq/manage.c:776 at __enable_irq+0x4c/0x80, CPU#6:
> v4l_id/918
> 
> Adding module_blacklist=qcom_iris to the cmdline works around this; I
> didn't look any further yet.
> 
> 
> 2) With the above workaround I get to the gnome login screen (GDM),
> but the device appears to lock up when changing the password on the
> first login. No logs or reboots this time, just appears to hang.
> 
> I'll try to debug 2 some more over the next week.
> 
> 
> Have you seen either of these issues? It could be related to my rebase
> or userspace.
> 
> 
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=for-next
> 
> 
> Cheers!
> 
> Chris
> 
>>
>> Signed-off-by: Xilin Wu <sophon@radxa.com>
>> ---
>> Changes in v4:
>> - Add the missing pinctrl configuration for Bluetooth UART2. (Sashiko)
>> - Link to v3: https://patch.msgid.link/20261029-q8b-dts-v3-0-655696dfec45@radxa.com
>>
>> Changes in v3:
>> - Rebase onto next-20261027.
>> - Drop tested-by tag in the dt binding patch
>> - Drop CH7218A patches which have been applied
>> - Mark vcc_5v_s regulator as boot on
>> - Add the device to the QSEECOM allowlist
>> - Move PCIe ECAM and 64-bit memory windows to a separate SoC DTSI patch
>>    covering all five SC8280XP controllers; preserve the original SA8540P
>>    PCIe2a and PCIe3a register and memory windows.
>> - Format the board DTS with dtfmt and fix subnode and audio-routing layout.
>> - Drop forced output states from the SBU pinctrl configurations.
>> - Explain why full-pwr-cycle is needed to recover the SD card state left
>>    by boot firmware.
>> - Link to v2: https://patch.msgid.link/20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com
>>
>> Changes in v2:
>> - Describe the TC9563 embedded GPIO controller and use its GPIOs 2 and 3
>>    for the external downstream port PERST# reset lines.
>> - Drop "PCI: of: Avoid config reads for disabled bridge nodes"; split it
>>    into a separate two-patch PCI series, including the kernel-doc fix.
>> - Drop "dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow gpio-line-names"
>>    because it has already been applied.
>> - Link to v1: https://patch.msgid.link/20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com
>>
>> To: Andrzej Hajda <andrzej.hajda@intel.com>
>> To: Neil Armstrong <neil.armstrong@linaro.org>
>> To: Robert Foss <rfoss@kernel.org>
>> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>> To: Jonas Karlman <jonas@kwiboo.se>
>> To: Jernej Skrabec <jernej.skrabec@gmail.com>
>> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> To: David Airlie <airlied@gmail.com>
>> To: Simona Vetter <simona@ffwll.ch>
>> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> To: Maxime Ripard <mripard@kernel.org>
>> To: Thomas Zimmermann <tzimmermann@suse.de>
>> To: Rob Herring <robh@kernel.org>
>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> To: Conor Dooley <conor+dt@kernel.org>
>> To: Bjorn Andersson <andersson@kernel.org>
>> To: Konrad Dybcio <konradybcio@kernel.org>
>> To: Abel Vesa <abelvesa@kernel.org>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org
>>
>> ---
>> Xilin Wu (4):
>>        arm64: dts: qcom: sc8280xp: enable PCIe ECAM and 64-bit memory
>>        dt-bindings: arm: qcom: document Radxa Dragon Q8B
>>        arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
>>        firmware: qcom: scm: Allow QSEECOM for Radxa Dragon Q8B
>>
>>   Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
>>   arch/arm64/boot/dts/qcom/Makefile                  |    2 +
>>   arch/arm64/boot/dts/qcom/sa8540p.dtsi              |    9 +
>>   .../boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts    | 2053 ++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   25 +-
>>   drivers/firmware/qcom/qcom_scm.c                   |    1 +
>>   6 files changed, 2081 insertions(+), 10 deletions(-)
>> ---
>> base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
>> change-id: 20260901-q8b-dts-a3afc5f9b8b2
>> prerequisite-change-id: 20260507-sc8280xp-qup-pinctrl-5ab8af9be35f:v3
>> prerequisite-patch-id: d799218553d1a8d44d83ab7d5c36a9ba7dd05e92
>>
>> Best regards,
>> --
>> Xilin Wu <sophon@radxa.com>
>>
>>
> 

Hi Chris,

Thanks for testing the series.

For issue 1, the Iris init failure and SMMU fault might be related to 
one or both of these patches missing from the tree you tested: HFI Gen2 
support for VPU2 4-pipe platforms [1] and the missing Iris IOMMU stream 
ID on SC8280XP [2].

For issue 2, I'm not sure what's causing the hang during the password 
change.

For reference, this is the Linux 7.3.x branch we're planning to use in 
production [3]. It still carries quite a few patches that aren't in 
mainline yet, both for stability and to fill in missing functionality. 
It may be useful to compare it with your for-next build.

[1] 
https://lore.kernel.org/r/20260915-sc8280xp-hfi-gen2-v2-1-c52075bc284a@radxa.com
[2] 
https://lore.kernel.org/r/20261030-sc8280xp-iris-iommu-v1-1-1e3fb8562b3d@radxa.com
[3] https://github.com/strongtz/linux-radxa-qcom/tree/linux-7.3.6

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
