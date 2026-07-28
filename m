Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDB372EFB
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226138; cv=none; b=ZqPUM4xJxFuU/V8uEUPs8uUZXojG60v9lwhMWTC0kk2JsBAZW1UvayuprN+1LHKmqL/x4lM5KUMLv6xS0y80cym4uSjDp3gleDSyJa4tyRhl07CmDRpd+PjFTWNYc+pbqoOyBzX1Gsuxv3TKRbw6JKnX8SBjaXo1/c7vociiZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226138; c=relaxed/simple;
	bh=mPDXysXj5lzIWFwy6wC2FZ/rGmW2AByblfFrnVyPj1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pryPGyMQoMvJ6Qtk+TeYZHYX4txFe+sLpVi/fVeD+cjeFIB8q+7+IzQzp/syp9oKBwjepSkIImqpUQIvi3UuRtkpfpAG3sZZxcldzDDF1WJC7GjW+e9jTEskLPuOip4xnJNpWkVMUGmNyqC9mAXtaYBqO/Zgw1cEpxP8zWN5R2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oECY8N2U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PkIsBEDI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oECY8N2U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PkIsBEDI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82le22275985
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 08:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k4JyYcB4rNl1WLdr8qEJ8Cc9TJtQG+TnKG6hDCnD3Po=; b=oECY8N2U1G+KxAvF
	89Mm/FeNM87wXi/JdA1ceMollKJ2MVFvB6ZtKMe3BHkVvOtxGH//KO8Jj/yJngPI
	REv/xoC5Wz3GMGHH7mZZ0cXoKKwz9ASwKdCz+vF/NYDoGWREo5yApcDlI/BNe7zu
	qfONhCIckdfvkr7xjBWtKLnK1+a+uMGyBpkW3EQ7RORkMmTPTbZy6l+WVYQSRUy6
	Koq9flzKVVc81KvQKJTmG4hg5g5A1J8s8QXyK0w5i/3RXjkEwBriH0j1fPh2Z0k5
	N2YGxL8w8Zy3M0foNjcvf/uoJwOoxFKSzHFlZii1b6c+9WlywSiIFg++CuiLdui/
	4c+dow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsu4u7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 08:08:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52845bd815bso6030421cf.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785226134; x=1785830934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4JyYcB4rNl1WLdr8qEJ8Cc9TJtQG+TnKG6hDCnD3Po=;
        b=PkIsBEDIS4ZPZa0rt1c23ECvACVhGPsM7hrk9EwXLEjtpkTkWrBzSbVN/CP9diQk32
         KFaa460/41vInvVcRH0+29GG41mOrk/9svfRWLXbgyjjJ9rnvVB9PWiXGEZYmFKQi8Qt
         TuIHoFbi982SfpwdnqMAHaU/65HITDrZJBGj4FQYZ2aXpabymyWco38npH9aGr0NySFP
         4cS533cp7Y02uiALzI8cogrJl7P83SvAFUwKEp0D8H65qdMc5NawwHlhn8HYaPy74jot
         G4UgQ/AB06W2lCcbTq+r3cQvD+Vk44+dQHUYy6yU/wyc9InOchT37Obu7kbOxYPPLUWz
         wm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226134; x=1785830934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4JyYcB4rNl1WLdr8qEJ8Cc9TJtQG+TnKG6hDCnD3Po=;
        b=EApHzelzWnGOu9GtrR+Cgfv1+bOoCzzIG+6OR0FpToeZSM+tS5y85MUqYFfasAkxJ0
         eX6UZS3/zw0jkcBOfeBHR7WdQacLK2Mc7xdcwysrLka9WLwWGGsIeFAu92u2JAKYrBUJ
         AEIRO1ZnQMyPM9Wvr0IJWQqG3XKvJddOCFRW1Kzhj9cSSU0/lOQatHnQJvW5n8/IOh4k
         16L524c0Re6gedV3BWQVPadkT4zUSY67Vlxqvo6sVTDlNwQkqQ+ulBoVXfaNDdyjBuT4
         fpTqCzXVCDoDzi/5UKOS/WIr75M9c06qJeXUUyEIuR4VKfUdc5gw+K/ybqF6IyU8q7uS
         rQVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbOiVhPG5M9FR9y/6rMF/XQKoB/Wt05hd7Qqa/1YKOYCVSP4Ql62C+bTxDHfxfFnZh94Nr9V5PSZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDF3BqwyzLtVCGfTrLzOgMFlL1jUOuMMOtsJP/swwjEqFsSVz
	I/wdufeqTEZfw9TI/JEtftV/qwzkOMPSunwfBtWn/l0hI7svZch1CZo9fREnNYSMq9b3NN/yb9B
	NuoQ3jaiXQrnF3yXIqzv3L7bjNPCkPOYdkIht1QbMRcCvWy2eX4P/geY1VjGJf/c=
X-Gm-Gg: AR+sD11+CczOWxb1lcbA6rAQuSOf8fL6gESnBr4bRpFtHFo1OSMmaCr4wXWFFPL8CpE
	m1Y2dGySfKn1r2VQ/pMEFPc5Yjb5gwmfq1UHDrQQqZOsYJCBaA0mLfoDUv20F7OVo8PX1Of5RDX
	/G2EJlMkQfCw2jef/2xR5jAMxj/OZLurueXAh9sbGw0q5uLpHogTbV4vfAwAFeq7KdW5zuQo7jD
	WolUsb1UPklqT6NoSl1cGSkdkNujulikL5WM+h9izDK1k9/KbAOKG9+u/Wc8QRqHMY70Ry8AfSz
	cbOymzETLX8Qtofuo2TJ8Ny4xj7N4H4u4n8UU+4CWO2jvMXBmA8t21dF1Q4YhISe3p3TnvJxFpF
	uAOf+VWmr+rRXrI9wyfM/N5TG
X-Received: by 2002:a05:622a:a98e:20b0:51c:1c73:51a6 with SMTP id d75a77b69052e-529d6fe33e2mr6436391cf.5.1785226134328;
        Tue, 28 Jul 2026 01:08:54 -0700 (PDT)
X-Received: by 2002:a05:622a:a98e:20b0:51c:1c73:51a6 with SMTP id d75a77b69052e-529d6fe33e2mr6436041cf.5.1785226133066;
        Tue, 28 Jul 2026 01:08:53 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32af244asm720034066b.27.2026.07.28.01.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 01:08:52 -0700 (PDT)
Message-ID: <b417ff8c-7829-4db5-b3de-9ee946c493f5@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:08:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
 <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX6B8IW3bXpg/W
 okSAbDb/mHj0JaxCwVxwRs3b72RslCGyJKPV/SbwyoOcYRiOJRob2IIqP48xRciW8Uh0qL+xgET
 ApxEEf+CbVLh2EUCCaybxmvn1ovd6mg8vJyBeIucT6pX5enVvkqZdkJL6IWAygjT5NmevaiRGn1
 NsNdziu+oa7D56OR48MURnSkeuOX2Ei82IXBALOchdQFsCDxNYKu/riJZdl2MbBZno0UHDk8VuR
 DkxsUuG5tQrKDLvj78eY5kROKlfvDYq+xOId+wIR6101z7vuGbd3f9FKBW/3AdwH3e9ysuMCfae
 2MYK70T6p5N378tUdh+8Dal2hVoFPQTJZepd9WbLB9VhqYSx21XuuIPNmhRFif9ORaWP5/JhFiB
 Zi4qiFf2Hm0M7vjSeuC6o7L81CBOoR76SUm+oqz3lS2iTmRhfN0qfxK2NIUgVw8mCTbVefNiL0G
 K/kFpn/YRN9uBgnC/AA==
X-Proofpoint-ORIG-GUID: v0mN8Acikf2t6iwE9o5RQ6ditR6XwzpJ
X-Proofpoint-GUID: v0mN8Acikf2t6iwE9o5RQ6ditR6XwzpJ
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a686396 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=obKXXINtG9EwW41erPwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX7SULQIyfiAVd
 rTyBtv6kXB706cl/hGMA/ApWZ9/uOubj5wAcjjqDSHq0DumvSWwjamVxFrcneXRqprH8myO4ji8
 wYkhWQCoctYr8MM4ibqcAGtp/VUJJZM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280069

On 7/28/26 9:06 AM, Krishna Chaitanya Chundru wrote:
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

[...]

> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x5 0xff>;
> +
> +			pci@0,0 {

FWIW these subnodes should be pcie@ too

Konrad

> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				device_type = "pci";
> +				ranges;
> +			};
> +
> +			pci@0,1 {
> +				reg = <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				device_type = "pci";
> +				ranges;
> +			};
> +		};
> +	};
> +};
> +
>  &uart13 {
>  	compatible = "qcom,geni-debug-uart";
>  
> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index c99bcccae00c..2ecfeddea496 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
> @@ -2104,6 +2104,7 @@ opp-16000000-3 {
>  			};
>  
>  			pcie1_port0: pcie@0 {
> +				compatible = "pciclass,0604";
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> 
