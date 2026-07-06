Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B640D599;
	Mon,  6 Jul 2026 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320237; cv=none; b=Qht51QWXnpeWBXJzx+1mSClgdEysvzTXpzVEevEdEjWh2d7SYnSJniGQ/2iD5dRUP80TGs8sAOVdv1qkmps2orIOrs9SvpbGwUXAZvJVJwRmSa43cs535t7yJgegHeA2UCmY0a5mpEE1AwYlv5RkvCAsovxdNc7xkKCPQINlHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320237; c=relaxed/simple;
	bh=TlNY0EcGvrM0sj1hh7yuKBLj/ZVCWg7JlEkJjg1b3dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjmkoijjjE4qYvJaHcFQB0Yddqy8Lf/Z8oCa+Fx22ulqkT37dmNTvHDt0EfxVmmKyV3CH0ifPTJisUZSP2qd21TNFTyl4z4+D0VtS2oolrwcS0Vu0HZvhSmSqaDLZKumoCxjDdCkbVzbFpESbDTtK+WAfmBUfDRSN66taK1WTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpgz1t1783320208t3b13217e
X-QQ-Originating-IP: my94fDoV7dC/ybLuzi/EbUOU8875QnkU0y0oQbmSUmg=
Received: from [127.0.0.1] ( [119.98.234.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jul 2026 14:43:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9542639158901383598
Message-ID: <10ACF07CBAE77BF1+7fa077d8-5041-456e-8c66-94248f253065@radxa.com>
Date: Mon, 6 Jul 2026 14:43:26 +0800
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
 <926681E76F71D6A7+5482f550-9a97-4a01-95dd-6d4083bcf5aa@radxa.com>
 <797bba33-17fa-4fbc-a4b1-55735b3b5d57@oss.qualcomm.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <797bba33-17fa-4fbc-a4b1-55735b3b5d57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MfJtHqZtrd+O26MDlUcoaXsQjh99TDxwbU5aLcv76wrVFptgKkEejERk
	eGtAEceT2nV3kqVrbWBfLEzoELoDK1tCpSWdW+9Uqh9QldH2oPprSX/UgMYNqRFv4B2WLzY
	o7XDihOnnsFaYrZ/q0GSLnbZVMk/odhh2Iggsj3MaABODmKKVfduy9M4azfyYtxUlRIKIVO
	OeKZFdyOqTkMafFHZPWZvIZmEkxAOTEvMHC/abjvwMAif60JKiSuBIwAFGIGSH8mydvz7hX
	aBWL7AtuD23EC/2vPu4Qih4wNMI3DcGuV2nRSn/48PXgUljTbxRmUvEKcIAGMfLzYZaHxra
	qrkv4kNbX86NUJcKljNfwscPh3TWW7f0T1LUrSLxxrjO44WQO4fXeyz1AuSmCyCTCLzNbR0
	8qaIED/gXdLNXYpse4W8hVr50aKUCynRUZGLFvqRAiga8kiiqYSOFQF1Y3+sb5TVFhFINQp
	azgfK1yPYrCHYYJ8HWnHvFkFs5D+jem0E0Xmf4EsNfNnBtjTGXhksYSdjyGckm1aKsP5lFH
	hpm/8vOLpELetIG5DlE7xyVFoPRHn3BM+t4eldi0OXGRMyGDfhl53b3r0EeB+GkI2/V/LcO
	VShfSdkQHZgdwVIFCa2HDwCmojkhrwkip9hLcBIBnbKp7eGvPjcITl++fEPADQ/DZOZyZDe
	rn+Mkke7H8Qtu9LgiiVJRK7WJxgafN0BfCG9n2MVwzaalJjKlb5od0CVi2EV757lOFsO3x5
	Q3XVSJDptqufAng2ahid81pjXnh6fS/HOhAL0iYjuBBlPrkA4FdcZgFIrZBbmS4BA68CnmO
	jWnf93rhhC1MpVDFGTsFhhbs/j0AULvLluFYdwKjN4qRXc+ja6oO0k1x1DRkHslkLuhcYsM
	bDVKc5FdYsF91+18+WG6Crcfax8kUTio+5vPhZ+V1EFkEmKsG4JzF3IHGGlwHkJVQ7NSUQb
	sM00KjRjlLm7euF0m1WUv2AXxATylHFbaYlHATXoVATchYjvt+v814AOC0OxTd4PeRELyfx
	gqKI6LVgZPkJrXLFLDv43GRcqWPgGEmiLXBysnhQ1bWCIhGg8N8dKqncVHgGixMuBLkygIU
	Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On 7/6/2026 1:24 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/4/2026 9:37 AM, Xilin Wu wrote:
>> On 7/3/2026 8:38 PM, Krishna Chaitanya Chundru wrote:
>>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>>
>>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>>
>>> Override the base iommu-map with the expanded set covering all the
>>> switch's downstream ports (0x1400-0x1408 SID range).
>>>
>>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>>> from the PCIe controller.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 141
>>> ++++++++++++++++++++++++++++++++
>>>    1 file changed, 141 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>> b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>> index ba41dbc34b81..c2afb8372ab7 100644
>>> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>> @@ -12,6 +12,26 @@ chosen {
>>>            stdout-path = "serial0:115200n8";
>>>        };
>>>    +    vreg_0p9: regulator-0v9 {
>>> +        compatible = "regulator-fixed";
>>> +        regulator-name = "VREG_0P9";
>>> +
>>> +        regulator-min-microvolt = <900000>;
>>> +        regulator-max-microvolt = <900000>;
>>> +        regulator-always-on;
>>> +        regulator-boot-on;
>>> +    };
>>> +
>>> +    vreg_1p8: regulator-1v8 {
>>> +        compatible = "regulator-fixed";
>>> +        regulator-name = "VREG_1P8";
>>> +
>>> +        regulator-min-microvolt = <1800000>;
>>> +        regulator-max-microvolt = <1800000>;
>>> +        regulator-always-on;
>>> +        regulator-boot-on;
>>> +    };
>>> +
>>>        vreg_pcie_m_3p3: regulator-3p3 {
>>>            compatible = "regulator-fixed";
>>>    @@ -102,6 +122,104 @@ pcieport0_ep: endpoint {
>>>        };
>>>    };
>>>    +&pcie1 {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&pcie1_default_state>;
>>> +
>>> +    iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
>>> +            <0x100 &apps_smmu 0x1401 0x1>,
>>> +            <0x208 &apps_smmu 0x1402 0x1>,
>>> +            <0x210 &apps_smmu 0x1403 0x1>,
>>> +            <0x218 &apps_smmu 0x1404 0x1>,
>>> +            <0x300 &apps_smmu 0x1405 0x1>,
>>> +            <0x400 &apps_smmu 0x1406 0x1>,
>>> +            <0x500 &apps_smmu 0x1407 0x1>,
>>> +            <0x501 &apps_smmu 0x1408 0x1>;
>>> +
>>> +    status = "okay";
>>> +};
>>> +
>>> +&pcie1_phy {
>>> +    vdda-phy-supply = <&vreg_l1k>;
>>> +    vdda-pll-supply = <&vreg_l3k>;
>>> +
>>> +    status = "okay";
>>> +};
>>> +
>>> +&pcie1port0 {
>>> +    wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
>>> +
>>
>> Just wondering, is there any side effect if PERST# is described here as well?
> one of the driver will fail as both are different drivers both are requesting
> same GPIO.
> 
> - Krishna Chaitanya.

Ah the board is using the same GPIO for TC9563 RESX# and PERST#. I see. 
Thanks!

>>
>>
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>
