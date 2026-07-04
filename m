Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6F3822AA;
	Sat,  4 Jul 2026 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783138091; cv=none; b=iBe9U/nTYhO85xLTUQmfGflq0wDbZJicdp0oMs/eRtrUZ8RZueYa0qgCN1QAzHC3nDh2beZ4nqyxqGW3bHAZPAMbmU04xH1ywn3gSnKg745mHSdAyzuez/hAerB3AgwhfdRRHX3+VJYfX8rGbz+s+Z68Kow1yN3ROA82J+Rpbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783138091; c=relaxed/simple;
	bh=nXymSW/VcDeMtmXhKW0zT1XxT85EAUSLbI6y+AmpCMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKOAMzwYB17hfaU5g0p/efjpFmMNHX0gF0L4m8neI+ikl8BL7N9r0r/ROYrGdHE2HRLcfmVLtQbFfJc93xVeybYcOXvQAkJu7Lwl3ucYE4Dd6KUW5oZ9u0KnmX2FnIPiS3E6ScbC/BDWsyXTngFpNOHN6QncOhcw/Pi/H/XmW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpsz10t1783138057t5d0dfb99
X-QQ-Originating-IP: Dagi/XUOgU2h5qBFe9Smlbn5jn2uD2jIEPlXcDV7yKU=
Received: from [127.0.0.1] ( [119.98.234.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 04 Jul 2026 12:07:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6974827005784446003
Message-ID: <926681E76F71D6A7+5482f550-9a97-4a01-95dd-6d4083bcf5aa@radxa.com>
Date: Sat, 4 Jul 2026 12:07:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 2/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
 <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDqtQ4jGWXAGJPZovyvPCYJer8V9eEM4AWqrivPcQd+WchzSxAehjxoX
	krgFJgp0S/EU4O68ZatPVubjx/ZtsNZ2Nd72eG/TJuHdcr3rlMGkFJ7Oy52Od/325WZ84Rm
	xFnN6p4ZhymwbDOT+8yUCDMnWOQzJYbwQsNhdLbz91FTfb21wym2/DyCxCGf3a67CT+l90y
	lO5bq57tZae4YRRJ+gdAcpmy43gacqhfliqQoSgdiBbNRJRNFHalJugqKTiYkIIg8XkePVo
	6nvchU/cJXcWKe39ZKS114xeCVKk2x8a/8dNnKawhGoZRd6KetBlnnBqKUBrzsDNVrDO46Y
	oxtBMy9CyoSCl03rMQHN+0a3nnQtUjujjP1x/tWm8yOscCxTsfOF9gqKe5Kr0f7tu+C3P32
	NfhANdmwW1Ka8yX2SJR+AKH679uPf75Is4UWuQ6Qo6Q79ZaqYi0supaiK1OepiTIpZgAduL
	A7Z8TBePoC6xhj8ZrgWfOl7pDxYBHXivprZkzuJwr4+AT8+KTuIXHIBzbfBJ4sAmCpczRV0
	mCgY6EcJ9hW7OEZnUyuXWUQtdg2X2QW/GP5LssysWmsoHS/OcepQSEgcX9aPTa6ni0FAOuR
	AO63PmxZwOyVxaCVFAEticzF1PYSWmuQFPlNSD0SHMRlsi9SgF214zaz++pKJR1QPAuyVLi
	D6RD+VXAQFNbQS75JpgJd6o56pDB7i4MK3BohaeO9/3rqFk0vkdamg9u1iNSXI3FaoaWUfG
	j/PVQ7gmUSnE1RFzPI6e/MZREcPyn0rgwxz5VjgYVipf5sQZZqrXHogm7LZeIEb+E/fksF0
	24dyZy5DzinaknOygPG6YEmenqD7+Sm9mhmwOAaKFNizcuUDqnuTbiHvh6lhiHUjmnaB4u+
	nunku9l0LtTMq5ECDq9fDoDTqnpxTwQV0Bdavxe7Y9+D2WOtruMGXRmoknug4JQrGdmxAUe
	un52AOqXHS0asndeClvWf67Gv4WJVpNtePgzUCItY/FCDhjfJmFE9VidKGPTpV/Cf3oYHf9
	v0fi8Uey38uztaIKq+sEFK6PBzrKwgNJshcMPt8drN7Oj8rdXF
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On 7/3/2026 8:38 PM, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 141 ++++++++++++++++++++++++++++++++
>   1 file changed, 141 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> index ba41dbc34b81..c2afb8372ab7 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> @@ -12,6 +12,26 @@ chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	vreg_0p9: regulator-0v9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_0P9";
> +
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vreg_1p8: regulator-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_1P8";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>   	vreg_pcie_m_3p3: regulator-3p3 {
>   		compatible = "regulator-fixed";
>   
> @@ -102,6 +122,104 @@ pcieport0_ep: endpoint {
>   	};
>   };
>   
> +&pcie1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_default_state>;
> +
> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
> +		    <0x100 &apps_smmu 0x1401 0x1>,
> +		    <0x208 &apps_smmu 0x1402 0x1>,
> +		    <0x210 &apps_smmu 0x1403 0x1>,
> +		    <0x218 &apps_smmu 0x1404 0x1>,
> +		    <0x300 &apps_smmu 0x1405 0x1>,
> +		    <0x400 &apps_smmu 0x1406 0x1>,
> +		    <0x500 &apps_smmu 0x1407 0x1>,
> +		    <0x501 &apps_smmu 0x1408 0x1>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l1k>;
> +	vdda-pll-supply = <&vreg_l3k>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1port0 {
> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +

Just wondering, is there any side effect if PERST# is described here as 
well?


-- 
Best regards,
Xilin Wu <sophon@radxa.com>
