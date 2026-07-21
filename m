Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9E417D9B
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616327; cv=none; b=c8AEDl3GP33yUf5X79vZB1zr/hgXxWCy3iU0uNehjIrDBF4kBZEYFXBl6in1QaM5JJes1EgYsjahS9D4/qNQ8Vv5bDR+GZDFQmi1a8jPThSImRdSG7B0EXZ6ot8tC2CjIa/6xI8j53ZjtUxIcv1SZ+qEKrrWaSP65nb2QeQsM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616327; c=relaxed/simple;
	bh=yVCm8pu2qst+Q8cj8iPalYZM3k9L2JEslpvUbzVZ7Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtV+VD4TfbJt2nsLNrtMNH/VK4zsaSUALF9TIIsKywZWHeYOMR0ExgTDc/OJr9WbQpbnmhHnFFI67Vwka3/3NyXgAyhTWI+B4iAAfRiGL/7VwKnHuoci22SyM9Zd13aeCElSjiHqpViYsGD1d6mc8T+zgZ1eS4S/CSEj0gq7GCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CfJXZldl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ad0pq6PJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CfJXZldl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ad0pq6PJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L2T9X4092273
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0A/ouygtLvij5YrVEYKZa7V+tOCteR1RlhOKH0lQmNc=; b=CfJXZldlHxC8XOkl
	FfoaFECJ1SxD0J/qMMfPrF6q9M6XlcVRQOQcs2B41whbVXpuRShQ7AMABywhl61Z
	krvTt0x7Rdj5P+a0waGS3xcPD2NmwrVtvUF89CpL3jHutzKMd9uQ6EXG/hOTsKK8
	ECGs8KGaLeREmB1OSqAQokKszU1HLsb4dlEpqr6zHsoI9i+qg8nwldygnurRH2ly
	ATB9VuTtg7XDL3j9C9xDPDxLNGYWoFyPDSwD8j0HHf4nSqJohOnC1V7kOwvFpEmv
	g7QdSSk56LX48xkEZI1xoXobFkKh1cHI/tNuLBXBqcxAp4HS3YpeoJ1pjT925MD0
	3KWaUg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a8xfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:45:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so7344368a91.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784616324; x=1785221124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0A/ouygtLvij5YrVEYKZa7V+tOCteR1RlhOKH0lQmNc=;
        b=Ad0pq6PJLtNgeK67L4Es5JqNv9UucQkg4V0wC1GDY8cMfbTQgCpddV+auWw8nv1gw3
         DUVfmerQpqKl3HVbsqSf9y8JHVBZjVefV/Saw/3e+bYq8i2YCO8+6s8iDIqEqFJEh6Od
         qlBjGa28c7E8mrv7cFj93yFlLgF1JSj4shTs9Eaejr5Db+XWSTYx9kPt4GuevTeCyvz6
         jF4+OaSNzUZa5kMi00WB6a4hXkfXWSXukCn+9FFIM4nWS4UAacHIjnpWbm5x9kazF7+s
         nsklBinb827cdiF6wLxH6GCCUTvtUiBeED3CgbTwpSWdSROzQAsVDIBvSRAkjNZqarJV
         8UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616324; x=1785221124;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0A/ouygtLvij5YrVEYKZa7V+tOCteR1RlhOKH0lQmNc=;
        b=QXG8DNhKRsGn0e0yrb/RAQSGzU18jzkGcZ4SU7SyfmGypQxhPM5HDaQU+DRSxW9G/g
         6namQGgMVSmZbacB3X7VZBToIPcZUjJYGWFHmrodqvDqnrtmxnW2f1yrJ7tvWHSfegT8
         oUjgK+bO1oT68F6zDBcWPLq4Vjh99bztVX48UURoOX+7lv12JkR0KRc+DEkFRetMOip6
         2E8ktr4C7X/osubpPEvxlMAbLxbjMp0+cEU8PVaZUF26WwSyvDtqs7e5EPf/qb4DVWkO
         NxB7cqkZQ9molGqIgnPwr5Oqo0Xljxas2LWF66/ErPEfgdYMj7N5t88RJ96U2FW3z1YW
         mG9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqiBgR6FVjZEPgjJ7KI2JVuNgUOInvitRNKXSRsslanNs6BtWaFMScaeY8MXFQzRcXNFbeu69l6Phg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRbgHZ6A/IwqwT8FB08DvHuhGxYOvpHjIFTTXdBSpWd5ieoTY
	Gjsr3NcudAdstCTNB/GrDZ77bsEkrZXNXfWGJF2WZ2/30c6K8zltxblJ3wCZf3AychcpfUheQq0
	/Wym74HGUaxJnss2ZnLSk0+yb47cT4fxiOhzp19fLfPrH3P8u6MeC84XirxyEPQc=
X-Gm-Gg: AR+sD12bj8MgHXLtZfuQFiGOrOchweeT+N5LiFg55k+Fq8H26GFAsLFtPGmEHEnP4pa
	6Gb5U3JKsE7qI0hX5wkWJqavVH4Nm2u72PFIvJNYiczcXtKcbc9L576CZM6A35Txuo1HRMEwxTC
	S/+qmb68YP1DP17SWVezbcZAF9oHVyOK5dzI2niMrgPuTLm0Ny0aD0wXNQ0i/yn7HPyYYdpAjg/
	tW1VKUa5WImqOPwkg3eH2cDRq2Jcki5qVuwzsEntcLtbUupkRuIbaJTbeqyy1Dp2pZYk4+IRwmF
	5wxDoegpG063B/cKTF/Cr59diRWpawFa/RtwplFQ9kbZ4UqvropNP/ovgzT7kfWNSgHTPjK5Cp7
	GjbeT+ItH9rncMmtna4AVkf6pCuE3s4rb
X-Received: by 2002:a17:90a:e7c5:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-38e4b244fdfmr16462443a91.0.1784616324196;
        Mon, 20 Jul 2026 23:45:24 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c5:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-38e4b244fdfmr16462422a91.0.1784616323664;
        Mon, 20 Jul 2026 23:45:23 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9218a25esm942198a91.15.2026.07.20.23.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 23:45:23 -0700 (PDT)
Message-ID: <3eb742e3-6381-47d9-9f16-c08915963748@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:15:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
 <n4s25nftmn3ginddls4u3tpzabkgiotwzh4kws5s4jfppup36s@ccbfrrrqxihq>
 <76288f31-57ea-4a42-ad50-8504d8eccfa0@oss.qualcomm.com>
 <2xz7madb3jkifwjwziozuudx3s57g25my3j6ucwjzbguacpgyn@btyrkbzqzh4a>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <2xz7madb3jkifwjwziozuudx3s57g25my3j6ucwjzbguacpgyn@btyrkbzqzh4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f1584 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=RVf7_9FWgS9vKL4VWr8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2OCBTYWx0ZWRfX2su89mLQ5fvt
 4aLi98wm74kVcSeT46zdLfoL7dmEZjAYAJKUYefnf7HXqMxA6FlU+jzqPzdUTYRasuut/qeK1N9
 uDjoa46XU1OeCkxnra3r0TqX6oVicrZz1QLtfLn9N/E6aFvKxW1uzK4Qt/GpP8hW6UHJsSv6c7Q
 IKro3AYOYv9SQWsrlH41e0Gpra84pzFHLYF5SwTAO+sbGVwhv6X8GtNxRLrFt5t5cOGevRDJoiF
 0sgphVZ4MaCwUEqAnH4PFiP/GVzEdiA7qjI5kzU0NDgbbKwvXJwhjElusfMipOcJgzYfpRCJwgU
 0FnUXMwgoziJ38MMNH84X6AKpvP/kWVhKDyxAJAhTFrVVkwLTuB0q77ajadj0k/GefxHmUbZa9T
 bVq0ZayKpfXml6vUNm6XqLIoSXA+Zzx0wnh+5ixYSt0a64VevwSqnNLc4srXKJAFSNS6o/U11Bu
 VQp4dQTy05qTuK+Bg/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2OCBTYWx0ZWRfX7Vs9C3mdkK1A
 gn37rcK6CCX1yNZFUsHx27VV0SjmgPxJi3lxUNhXFke99OvINNEeMhSWJoJKluk6Fopd70AdWSf
 dH5ToxmTFE1kFK5lzDZflIkODcbpZNg=
X-Proofpoint-ORIG-GUID: q5xRdRifZL6Yc3D1CmovfXhjW6iHgRmt
X-Proofpoint-GUID: q5xRdRifZL6Yc3D1CmovfXhjW6iHgRmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210068



On 7/21/2026 11:52 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 21, 2026 at 10:56:20AM +0530, Krishna Chaitanya Chundru wrote:
>>
>> On 7/9/2026 6:37 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Jul 08, 2026 at 11:47:17AM +0530, Krishna Chaitanya Chundru wrote:
>>>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>>>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>>>
>>>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>>>
>>>> Override the base iommu-map with the expanded set covering all the
>>>> switch's downstream ports (0x1400-0x1408 SID range).
>>>>
>>>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>>>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>>>> from the PCIe controller.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
>>>>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
>>>>  2 files changed, 113 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>>> index 6d76715ccffb..e099b7c8c371 100644
>>>> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>>> @@ -12,6 +12,26 @@ chosen {
>>>>  		stdout-path = "serial0:115200n8";
>>>>  	};
>>>>  
>>>> +	vreg_0p9: regulator-0v9 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "VREG_0P9";
>>>> +
>>>> +		regulator-min-microvolt = <900000>;
>>>> +		regulator-max-microvolt = <900000>;
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +	};
>>>> +
>>>> +	vreg_1p8: regulator-1v8 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "VREG_1P8";
>>>> +
>>>> +		regulator-min-microvolt = <1800000>;
>>>> +		regulator-max-microvolt = <1800000>;
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +	};
>>>> +
>>>>  	vreg_pcie_m_3p3: regulator-3p3 {
>>>>  		compatible = "regulator-fixed";
>>>>  
>>>> @@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
>>>>  	};
>>>>  };
>>>>  
>>>> +&pcie1 {
>>>> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
>>>> +		    <0x100 &apps_smmu 0x1401 0x1>,
>>>> +		    <0x208 &apps_smmu 0x1402 0x1>,
>>>> +		    <0x210 &apps_smmu 0x1403 0x1>,
>>>> +		    <0x218 &apps_smmu 0x1404 0x1>,
>>>> +		    <0x300 &apps_smmu 0x1405 0x1>,
>>>> +		    <0x400 &apps_smmu 0x1406 0x1>,
>>>> +		    <0x500 &apps_smmu 0x1407 0x1>,
>>>> +		    <0x501 &apps_smmu 0x1408 0x1>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&pcie1_phy {
>>>> +	vdda-phy-supply = <&vreg_l1k>;
>>>> +	vdda-pll-supply = <&vreg_l3k>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&pcie1port0 {
>>>> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
>>> No reset-gpios?
>> RESX & PERST are ORed in this platform, as we can declare at only
>> one place we declared it in the tc9563 node as resx-gpios
>>
> So this means, if both are defined, the assert/deassert sequence causes issue?
> If so, this should be mentioned in the comment here.
we can't claim the same gpio in two different drivers. the probe of the driver
probing
2nd will fail as the gpio is already requested by the first driver.

I will update the commit text while re-spining.

- Krishna Chaitanya.
>
> - Mani
>

