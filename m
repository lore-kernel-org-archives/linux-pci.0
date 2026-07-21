Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E832B11C
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644248; cv=none; b=KsR5POlA7NglEXi3+EUWuTNklW07ThNHtuiSrILDRqyTWTOyINT81r1nIgVmJFYzmN7QMWFaaKCUAa6CBpDEilkWzCW9CoQuFuDljrZEaDc6S3hKFYNOJaH3oYmC91ULj0I1tQ14EcPG1LMrZ+wBbwbAX3TCQruH0yLvROpTTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644248; c=relaxed/simple;
	bh=Dah6iwuBM089oqDaNXeA5gG2dBqwx7GVDzrvA22UYPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCIkyk0/+0eEMtQQtGZyxINqcLCYahlVX7tiBrYg/9SaHrHvazBPeAnql3URaYlgZSxLO55IriROfiioUnTgoE+Z34qs+xRmWAuYhJeoBdwdo0g8cGfCKX3tSUXYbheMrPKh5Or6OH7tNLOn5hzzSqc/pM2AzQjYaJ0ZeKYCx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aAfIuqgr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RxxEqkwO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aAfIuqgr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RxxEqkwO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDfqes1590965
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3D7qMpxCktMJQz4cB+RdsNpxfnXkYUNHjKzS7+j7jh8=; b=aAfIuqgrTlhHZbM/
	giNynWh7qISMidAfWGsQgkyolSn9vgIN4Eo4ObT1W+USomauib5QZQLtPtpDN3Js
	/LLjq3JknIddvVCwSVgS3yNbOsdeLxpx5WR0tvJpTr3/mPSwRkW6/MoUSIjKhnby
	/p3SjrhjHKogXjAat8g4qikw7Gw7IBJEEG40jwlomFVTNE5yaJBwN/4jhXn3DQDY
	y2wdzTCqe9nBxornoQT9uAXAu44/TYAGV6SGLIo4PRA4tq8KgKZZU7dMNMraeVF4
	6PzLxXtgItKh4c+/QHnyec0UL/ebL0603SnGZSkPKMA2EU/QUzag6I8gbntZDIsK
	tAaesA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj0as3854-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:30:45 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-737a6ec882fso298524137.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784644244; x=1785249044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3D7qMpxCktMJQz4cB+RdsNpxfnXkYUNHjKzS7+j7jh8=;
        b=RxxEqkwOTytwQIjoRX8Z7yXe0VfpOYRE1WzLYMpMX1VNC8NZLCyAloPPUqqczneJwW
         Ga73sGsa60YskJxvYViME4v7h16YUjBA+apXOQWEmfzexHNCywUKhIxv0D8wcqUAHGWs
         ZXbR+ZnPXcj6ggfwWVu2VeyDXeMvTxFObwuz6CaLPnNAOUwutA1HZ+WyMAl7VNaJMMb0
         p8NO4cj3T0nN+X9B0JbGbdfHG9paoRNnM3GjPYnVsF19qJ0b9zBjFE56HNPW5IzyLhhF
         eFEbwS+yoY4fuVLceMceGfuXwUap3oFBrMTbNSUVa12XfqBTkHJ0Ivvil7tOtU/Pw1Fs
         vCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644244; x=1785249044;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3D7qMpxCktMJQz4cB+RdsNpxfnXkYUNHjKzS7+j7jh8=;
        b=JY9vE63WKkBArncNjC5q4XbloUd7LfTlwsoRJEFlB3Kdg8axWoSx3X8n5B9+UNIDpd
         +/q3NejhDrRkK7eKrDggSVo7Cv6xBT1LJfHhw7Om8JU+PZR4T+RN4cwF2QJ9ReBgq4Pm
         d4lSUi15ruZ0PhEwZm2HcHXC9SqvKLWqTJQ3TDS69iv+1i+qqKIYk+9uhF5DsF+q/nA9
         AL8npIJAd+kL2gT9iEGGPq8TOfMnwrIMg64dyGOVDoz21UsLkIN2t9WphF0Pgj7qUpzY
         MQyw95lQMB6Y+Ew77EJ1VJx2vnqm0GLu5Yr7coQuVlU2Tr2JyFXjY5353w6uzRHdP59b
         Oo4A==
X-Forwarded-Encrypted: i=1; AHgh+RoUo61XzoUNBFFdKr8XNMaxED2jacB3/bdKaEe60omA9T8noNdvumf2aE4wHZkxa/OJDQb0SvMb/RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuEINmvz34Y6R+m2th2OfN3qgAunVNCUr49LX7MCtiPLAMaIw
	7RW66PZ6TKsL3rshvZeo4y+ml+KfxMmD7wz7ZtBOs39wN3uxuxFFhX2wMidG+9vfKqjjZVFgt9f
	lXyIWh76uizJ+KRjrKhmk+8heZ5vng4DBfDSdEPjAQfuSRkpU7wp6HkzEPF/aY2U=
X-Gm-Gg: AR+sD11pOStJMYm+UawZMCrSLDzdDy5dParRZArMOETax2f/3F0QjlDZZGf/bSdt7xT
	/mMGgBsHFK7TltqLaXct1l9SxUme9i11uw/w0ium2IraTSvJPSLB7sZ/0TIXuSO61xcn6btz5Hb
	Ob6yrXRzL2t7eRrlOGr4JdR51R/rMQ/6V4NalUvxGoHKmojOTP02c1iQ9W95EGoaBTVvyvOEZRv
	Y98P0ZcA+4Bfnw4DBMAVv2DI9YJRI1V1dOESATT5JmlGElsNdUZ5ZVvIlwplZ7nMzzY2NMdM8Ly
	SFUL3DLGCh6zCJSWZRusBirFjw28xuKk5ERiiJpC5b+28vI6Q7ofYaAVYUR9R2RVwA4ZbNOFw/w
	V3OOl9tAGoB4rT9S9xsLuVM12
X-Received: by 2002:a05:6102:800d:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-74abc0b9b24mr594870137.1.1784644244019;
        Tue, 21 Jul 2026 07:30:44 -0700 (PDT)
X-Received: by 2002:a05:6102:800d:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-74abc0b9b24mr594851137.1.1784644243602;
        Tue, 21 Jul 2026 07:30:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fff71d7sm5960109a12.27.2026.07.21.07.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 07:30:42 -0700 (PDT)
Message-ID: <e78b603f-1144-4af1-a14f-16822e95f523@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
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
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
 <20260721-eliza_evk-v3-3-92b10038f13d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260721-eliza_evk-v3-3-92b10038f13d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfX3uBCchpzStab
 P3FORRRqEcJUKEztt5FYW3fARGbAWrebE99B2AFoPbQzGEhJYpZgBuMCB0ycsNyMl6DzQRPLeJh
 Q1rhig8tRebXHlgICKy0Tm2bcasWXpkmisG4gohMlS7qDBq4TcLo7tbWwDP1x3q5NW9Y+0b3X2B
 qhv1WoW3aJWR30JI57lluwJylklLhZDVRrWnzJryeKcYdpDgrhTPX3Nc9onxmRHbAXK6/kRs2gv
 fNg787nD6Zdv972OckDtA+omaD+Wa9gQpVHNRqb91rf6V/7cFK0HhKlmOTuYlWEnOuTIzpyvi4H
 ybqXQxxDRp3LrUpnItJAqGusCdOrOTUmiekMPQ8F/ytiQ22HA+EUSwmu50zX1kqI/PTVF3eM1UC
 EDmLo5zPhr7gGs8o899tM3oBzfgPejeI2Oyt3J5EqYbVo6XVIVEiZaSPIwp6Luu8jx8isRFlqKq
 H4olqb/NpflNrN3EWnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfX5GuGhWJ72KNR
 as1hGyyc5CP0GCt7RZhXm1E5WUEqMf5jbtGJPZ6WZxZ0DmS4wxANZpS8s+W8JWeeit1yyopu3Hr
 PITH2+X5ocWwzKOQwSVIeydEyk9lqI4=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a5f8295 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=SOEqy0c3B-33mnQezuUA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: wMxeYIHzVDAc_3oC6vcQa4ou6YHNkg-Z
X-Proofpoint-ORIG-GUID: wMxeYIHzVDAc_3oC6vcQa4ou6YHNkg-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210153

On 7/21/26 11:32 AM, Krishna Chaitanya Chundru wrote:
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

> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index 59b3cf7f168d..cdf5decfef48 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
> @@ -2103,6 +2103,7 @@ opp-16000000-3 {
>  
>  			};
>  			pcie1port0: pcie@0 {

Missing \n above. Also, please consistently name the labels
pcieN_portM

Konrad
