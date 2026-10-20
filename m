Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487572;
	b=y0ImsnAidx0WWwUjWEpQhr8kJ8bwysRCGfgSk5CUEXlh6jc+PZc3FpEanKR9NCdyyuEd
	 5hj/p5Tlq128mNxw+YTPq7nK+YVj3oRL+rSE1iBD+3RSsDm/X1CGa2oUlfQOHhHwD8Ije
	 5yyXkhyLWaYu75rM69H+UTMsFCl4zqtXjQa4o0zv6aeaqPt18K5M7VPYnDM55sBbCZALG
	 Rz/dtxia3xxF2/YJMAeXhuN/nMt32CTfD3shZ2hYeAQvR9fCUNCkPi4DcDpodYICd0Sl/
	 tzswN5ntsjAhkY4klFUUdpznGic5PNpiPQ1VVnYE23D8d4BXEm7frnrbkd+nGzrC8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487572;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=vU+z02vLYKXPdaAV10b8G93MI5kusn0c4HjxHq8ujnM=;
	b=baYD2oIOWGJp6C4sr6sNI82QiWp4iu3LP9PL9GbX1yw6vWOSfRo4/XY+iK4IRKoNLU9u
	 7rxOpBAim7x3WO0+GuHFc+izWhwyqdGMEOuh2oTHlywMrdfW+a2RUPeTYbWNhaC0LtSyU
	 k/MNACZLXADJ4dar8RBY+XimqLapEGrWw0vdrW4m0Y7c8tsxuqWI5gYHEsH7Ch/aJpNQT
	 g/SZuv0aNkiQt8HyslOewpk5ExXgObcd6tI7ilgglBczRbqjBFYo0/7vPEBQBwzNTX5Zd
	 4jhax+cBP6SENY1cDPtpDydGnCOBKsm9Ft3sNMMvNZONr8L5mgIEA37JOedLi1itGew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00C606A331;
	Tue, 20 Oct 2026 09:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C00C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpgz6t1792487489t04aa9426
X-QQ-Originating-IP: xblyLXtYUkaN+mcRUZlY6MFFt1npan14bWp9+SQNemM=
Received: from [127.0.0.1] ( [180.159.160.209])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Oct 2026 17:11:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10771054805953698164
EX-QQ-RecipientCnt: 32
Message-ID: <C782C697D7D26A70+05200ff5-c7c6-4425-ad15-67222a2ebacc@radxa.com>
Date: Tue, 20 Oct 2026 17:11:23 +0800
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
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
 <3bb9a390-3b5e-4321-a25f-77e4f5c88f9a@oss.qualcomm.com>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <3bb9a390-3b5e-4321-a25f-77e4f5c88f9a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M44gPKlhuS3s9ib/HF+x2es0LH39PYX+RI5y1uBElRr3DpD4G/LYBV9+
	jCwpMftPGiziUbPpTd+j9gQgRiapMghIYmKDzE6rZ+emvpDK4sryt5l1Vr1x7GnDaRf4Giy
	6kRo7t+rbhCppjloVej8SJdVh7dZhBPZLnNDReUd3xH38qvJDvP3Zu8vBOF4+Xqh1z2MpQr
	TEr+yXAoLfRD2D0/TX2CEhWVcCfsjRwVFPbIAXFqAZ8soenRlLVIl+kDkHklxvuLdEwdp52
	xmZSGIDpYNz6iNfc2sj2BVAnzfXO3RduVWhtYsjMx8xdBHIryzWZ9xashH7riJoCFaOWU7Y
	uH/MuT7iy7GZ6y0V+9VhMxFRvDy7Q86k6ktS8kXdwm4m1WhBdS76Tm7HLOFk9wsx5nY/jNv
	XG1TcOeom9Ig9qGjywkpBgeFY//LZB+7+6du9UM7U1CZdtapjGFj7ozPR9kq90otC61yNky
	cSi7mJQbBxCzGvxYA9psf6pXP9VWjoIHC55fRbUQOvugvBWlqgchMzsTKFWJDDl4CoJ8Kmz
	RnS/R2QJ44O9KD2zCLiQDFxCWamVW4JPqTKUR31ryViJJW42o5ltGJCk7VUaxCJw3syEdeE
	iSTgkvruCd098ui4vI/OSOCVd+DnZ5zPRturB5+oOYfi466aTwJfNmGAVULCpdBweOuA9gH
	1QZnL74yd3SSak72Ldr1d1oF7kl36vbSb6a69TKsHfllgIC05ZwEJ7O7Nzt6bKYbo18Fkd5
	OLcRT6VHUW7QHw0kK+c4DN9X0xrPWm+7/7Rc5n4KEh6r0mtMYPsmgbymvw7jwjG+7uByIle
	53en9gbGG3vF/yKB4iSMuY+Cou/vPigx5rrnAe43MXjQ7sUg8scmJtAOgkJvXpvo3y/bbXn
	kcoj+ht0rHlOJMDb8K68yrR3+IHkQ3YLu5HP+N2NRvIdVvB/yyV7hMvq9H1BquUyRHnH0jk
	XV1IPRP3I947nL3Pwh1rMFJosTgts4mckeTVv1zjKuVJIcD4baGRvZcBVdyzFmXyuhVdsij
	kV9lo/jIuZlgh10IQe7Srrp20BDgSQJhCGaciICyLmJzWLL1tTWO53T/GgGKLykd/MscYbX
	CTPxSS4Y9QRhMifeGj2iwc/2GsfleKL1iwzv1/Ky4xr
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On 10/20/2026 4:27 PM, Konrad Dybcio wrote:
> On 10/9/26 9:55 AM, Xilin Wu wrote:
>> Add initial device tree support for the Radxa Dragon Q8B,
>> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
>> SC8280XP platform.
> 
> [...]
> 
>> +	pmic-glink {
>> +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		orientation-gpios = <&tlmm 166 GPIO_ACTIVE_HIGH>,
>> +					<&tlmm 49 GPIO_ACTIVE_HIGH>;
> 
> Please align the '<'s
> 

Ack.

> 
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				port@0 {
> 
> Please add a \n before the subnode
> 

Ack.

> [...]
> 
>> +	vcc_5v_s: regulator-vcc-5v-s {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "vcc_5v_s";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +
>> +		gpio = <&tlmm 159 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		startup-delay-us = <250000>;
>> +		off-on-delay-us = <150000>;
>> +
>> +		pinctrl-0 = <&vcc_5v_s_reg_en>;
>> +		pinctrl-names = "default";
>> +
>> +		/* CH7218A needs to be powered on for HPD logic to work */
>> +		regulator-always-on;
> 
> Does the power supply reference at the connector node not handle this?
> 

No, the regulator will be turned off if there's no active display.

> [...]
> 
>> +&gpu_zap_shader {
>> +	/* Reuse firmware from x13s as the SoC is unfused */
>> +	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
>> +};
> 
> Other than the signature, the zap firmware is wholly generic.. I wonder
> if we can just add a symlink in l-f to get a generic path..
> 
> WDYT +Dmitry?
> 

I would prefer that indeed.

> [...]
> 
>> +/* M-key Gen3 x4 */
>> +&pcie2a {
>> +	/* Place ECAM and BAR space above 4 GiB to accommodate large BARs. */
>> +	reg = <0x0 0x01c20000 0x0 0x3000>,
>> +	      <0x0 0x3c000000 0x0 0xf1d>,
>> +	      <0x0 0x3c000f20 0x0 0xa8>,
>> +	      <0x0 0x3c001000 0x0 0x1000>,
>> +	      <0x5 0x00000000 0x0 0x10000000>, /* ECAM config */
>> +	      <0x0 0x01c23000 0x0 0x1000>;
>> +
>> +	ranges = /* IO (1 MiB) */
>> +		 <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
>> +		 /* 32-bit non-prefetchable memory (256 MiB) */
>> +		 <0x02000000 0x0 0x40000000 0x5 0x10000000 0x0 0x10000000>,
>> +		 /* 64-bit non-prefetchable memory (3.5 GiB) */
>> +		 <0x03000000 0x5 0x20000000 0x5 0x20000000 0x0 0xe0000000>;
> 
> Please drop this change on the board side, this is SoC-specific.
> Likewise for the other ports.
> 

Ack. Do you think this change can be applied to SoC DTSI?

> [...]
> 
>> +&pmk8280_pon_pwrkey {
>> +	status = "okay";
>> +};
> 
> I am confused why this isn't enabled by deafult but that's of course
> not your fault
> 
> [...]
> 
> 
>> +&sdc2 {
>> +	pinctrl-0 = <&sdc2_default_state>;
>> +	pinctrl-1 = <&sdc2_sleep_state>;
>> +	pinctrl-names = "default", "sleep";
>> +
>> +	full-pwr-cycle;
> 
> Hm, is that something that comes from the controller itself? Should
> we advertise it on other SoCs too?
> 

It is observed that the boot firmware can leave an inserted SD card in a 
state that makes the first Linux enumeration fall back to 50 MHz 
high-speed mode. This property allows the MMC core to fully cycle the 
controllable card supply after voltage selection so UHS-I voltage 
switching succeeds reliably.

> [...]
> 
>> +
>> +	vmmc-supply = <&vreg_l9c>;
>> +	vqmmc-supply = <&vreg_l6c>;
>> +
>> +	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&sound {
>> +	compatible = "qcom,sc8280xp-sndcard";
>> +	model = "SC8280XP-Radxa-Dragon-Q8B";
>> +
>> +	audio-routing =
>> +		"IN1_HPHL", "HPHL_OUT",
> 
> Please don't break the line here, start right after the '='
> 

Ack.

> [...]
> 
>> +	usb0_sbu_default: usb0-sbu-state {
>> +		oe-n-pins {
>> +			pins = "gpio101";
>> +			function = "gpio";
>> +			bias-disable;
>> +			drive-strength = <16>;
>> +			output-high;
> 
> Drop the forced output state from both SBU pin states
> 

Ack. Thank you for the review.

> Konrad


-- 
Best regards,
Xilin Wu <sophon@radxa.com>
