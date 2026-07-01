Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407D40B373
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902220; cv=none; b=fiw+fUWlVR4CPXbWE6Y7QfMn2NSa2Kap+h3tVOPlLkK9N/0q7k97XPKwoJ5RF1IAlkoQ8CyIFFyoJ287NdaZKxM9soV8ggoMrFFo66dGBXGejlo5Sj+Vp1YO+EvB8aRl/LtWzhpc+7ucS2nW/BEeezwm4VmzogT9wSsCfZFKUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902220; c=relaxed/simple;
	bh=KIgAlnVjO/BDlv/DQ780C44pFtzUmnCoemXQ8Jn6Bag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijbV/zxUOHL8fHU9AZ7i9WZpnPXaQ0XDPJe9U+PNsqmrGdeaLEnY7ZEgAszkpVOgvcjTxX9Y6131ojvNeyxuyYdqo57Z18YPJ7VXTjW4fyAVUpXSWpJfygkMJEnhxTxMjd8xXktIeplayp61xSErdgG7NWrnVWN6Vxed1Kdk3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RZx/Lttb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrqIUbqe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZx/Lttb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrqIUbqe"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8fDQ681650
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 10:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fc2tkNpOohA+tSSWrN3nTCDx1S7JmvYT1YRhgM1ybfs=; b=RZx/LttbQc12SfCO
	oRxTFvMIx6vP0coIhfCZB082iAq0kiE0NVhSaPARcmKMoWCC8k5DZpoAzOLDWQyE
	vKuIqXW6GuwrrHWBVpoUccATaIrmDAgObE0+6IKr88uwlkr07Xjnozf0Vj3yP9eG
	wIMB0a/YgQqENtjiJWwkOLzPzT5gr1w7FFHad5g7KSibW7kh892FlyMZHt6m97xV
	LZrBkI5ZTisnJ7mWpjA5RyD7aStAwTmui/xGJVz5GqxQhe/QsVhkm1y1MglPyuBe
	l/WJfLbDKkVcRi8W1ES5LExN2v5Dg+fw2pnT7JrezUUb8YjWmn6V15NmC82M0EGd
	rwrEWg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3skpyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 10:36:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a15cef334so704541cf.3
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782902217; x=1783507017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fc2tkNpOohA+tSSWrN3nTCDx1S7JmvYT1YRhgM1ybfs=;
        b=ZrqIUbqeLnTkAPl6wkPYDlEbrMdsh3Wio3ouim+SWizw6vBGVOvxPmbcUgL0WG0fKS
         OaEsOE3QPofwwrUgi9eSR+zE7g29o/mxCMGLsTJdCjxEYW3joPfPUZo1f2GFiv1Pz8eF
         MS3ZWcj9YTlgPiNuoHhvHMzVWsreM/kZJnjcMCG/+XUJk2fvOt/vvzHti6Gjy1/3M1pc
         RJO9DcE7fBNRTPAfmiXWkPPZ0GG/WcG7/JsLIxl49LTTtbwIZJd6LChKBz0nP/NIXNh9
         MDfDCPuzEM5clglWJGa2TqASkVYI3heOVxLStAaadYg+Cn10rD6RFUPA0ZQZjg2NsH34
         DLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782902217; x=1783507017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fc2tkNpOohA+tSSWrN3nTCDx1S7JmvYT1YRhgM1ybfs=;
        b=gCSjHRZz2K6H2zWKek5vQ+qO6twg2VBWvabYBtIUB23iVs9XGKhXMT2hHyeEgQ9JGk
         8m8HuI4uRIZShOaVYIoGw+y5fA6rtTqm/4EsGXVYo1KB4jA3wW60TExC2wntScgPquRi
         bMn6+/DyDXadtkHYyrhqivd2ehV3oI2uZQHDS+rQeny4uqTB5OcdardE0b/rstPJpO3f
         xzJ3KMMsJUWL5VuN1YFbxq1sZfzPeJ0N3oRU8j8AA3SjFUSIq8i7tU96bYmJNvGUVd0R
         azHA8l1r8oPES8oTIrrBMgtWmHN9EHeRpWKoUArFavEQnLgVuYoxLaSpXA32cenXWepI
         eZRA==
X-Forwarded-Encrypted: i=1; AFNElJ+pZAkeE18pL0ha9acVVyoqMZDWEaHoCiei8zyIudHeHbA3usnEyALQ0OyzxSBHfz7hHyzr8IdGI3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3G46xHk+joh7CwsuA0NsBPjZl1a6hxxMq/P44QzaC+fAQ41J
	DPU9Oi2OZGRBInw5FvZwePoXON14cdkG7ey6tmWf/XTUQFteEyOAB7BEVQ0kXextaJ8THoxqasP
	NBhOeQ6u1h6oue1yf4adPIU1GufnLCtAVnB9qbR8Kyllzv/+oDHpT5hE4aDy9xtM=
X-Gm-Gg: AfdE7cnXsFsUPgKoNe9APHFZrKPrPRNPOKE6N/gNad9MCcTSIqM3a0b9OOKrOdJVFJb
	jH8iVCGNIoDsu7QV4kbFqnZ0M9lE404RCAhozB0ZKINLeEGTCwFVmoABxPG2X9i259UOBFgx60s
	mvWy5zxdlNe4ZWrYK/Ba2GtUyKGQHFoJM33qkzc3WhHgm/6BqcF0ZhLSgWIZdJbkx5xM2CbnPpc
	SlZhQa+ZXy40MoQMDTZPIgahnTG5KP7yFfDIhdrzR0O7Z7yoyy7iJvYvB/+hNbOsl3JSwj1lJtY
	xQ1Zov4pDyjAI+Ar7lp1wufVOjEZzO4nZ87yLPoiD5+ZYycKjcGmSEESIOjf7BGh40d+v979w5n
	j/C11FpxoLgeOVMUm0V24rKPaGOu8S9KGsX0=
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id d75a77b69052e-51c26b3920dmr7346111cf.8.1782902216869;
        Wed, 01 Jul 2026 03:36:56 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id d75a77b69052e-51c26b3920dmr7345971cf.8.1782902216423;
        Wed, 01 Jul 2026 03:36:56 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c128917536csm254439866b.56.2026.07.01.03.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 03:36:55 -0700 (PDT)
Message-ID: <6e42bc67-9a2f-4e64-bb49-30fd845263a2@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:36:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: qcom: shikra-(cqm/cqs/iqs)-evk: Enable
 PCIe PHY node
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-9-e1a721eb8943@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-9-e1a721eb8943@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SIk394RMMjc3qV6Js0FnWxwadeZvPtDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMCBTYWx0ZWRfX5gDsotybksMs
 2XpunWGtQ8cRIUzPCBOfzk0XgGDkcInXiK4vZ4T3In5UZ+NghxJlYfwVCldLJnsuXCEMHY1+yof
 K6AjnlHS4QkTitvlcA0xxZnmWSo5X8HN9pfLh/UOAI0PieiDKKqS5ybxvaYhvwNCqEtQsJSpTvY
 O2VH6Z2bTbBa/b46bPar/tjZ4ekUpzBLNRLvJbxu4w7GwrRXQvDlVchfOwHEQ9UeMYF8VgBcH6z
 HojwfyPdSu8sZNXVFwF6U3TxblvLr2OuUnFd4bUtELqfV/7uYwZfzoRIFH4DuVJaqkg32uUw7z5
 xRq8loK9g52eqRMUJmpywxnw76hakp4wZm7O7VVabdYEp4uGvlFf+ts3uvuhYd6mVzrDG//+uAE
 PpQsk+QQwZstPuk+PIghlACBvfOHpjrLxWl/TfoOrlXkNgd4glIQHpX/dH5x0IErxJrt1MHpVCY
 uttz1V5izOeDRyOthsw==
X-Proofpoint-ORIG-GUID: SIk394RMMjc3qV6Js0FnWxwadeZvPtDL
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a44edc9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-pX6LU1wS3kVf0kvi8wA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMCBTYWx0ZWRfX/XQX0j7LVHij
 gZT98O38/YYbGvkL2fTU91OfyjpgVqWRd2SdIODi7taNvh9f6RWZ41HD9JZOz2hJX7ngLzpc5CD
 Si9WD3WUhXImeGNbUmq9cmluhakxQNM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010110

On 6/30/26 9:02 PM, Sushrut Shree Trivedi wrote:
> Enable the PCIe PHY for the single PCIe intance on the Shikra
> CQS, CQM and the IQS platforms.
> 
> IQS platform uses a different powergrid than CQS/CQM which explain
> the different PHY supplies for IQS variant.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 7 +++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 7 +++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 7 +++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index 683b5245923b..06ad32041546 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -60,6 +60,13 @@ vreg_pmu_ch1: ldo4 {
>  	};
>  };
>  
> +&pcie_phy {
> +	vdda-phy-supply = <&pm4125_l13>;
> +	vdda-pll-supply = <&pm4125_l9>;
> +
> +	status = "okay";
> +};

I think it makes sense to push the status=okay to the evk file
(because we already describe the PCIe switch there) and only keep
the supplies here (because they differ)

Konrad
