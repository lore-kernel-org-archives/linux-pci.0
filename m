Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8BA29BDAA
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647872; cv=none; b=rpXemR/Q2p0MQ8Uab6ceKRPk3N0rY57tWeybRyczK3dkPwBK8jJs2GxMlPyvthUY6DPJnDX4P5Pa8Z4nVTyGFqeV5iiSus4DSk7qrVBApeV+TOrTRDZt23ufjNdNIFZ2xY3BhyPuvfJ8usxZnQaShegpU2UJeR0G2ub0ozTXlyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647872; c=relaxed/simple;
	bh=XbGhdM5R6kglST7aIewJwl4vmHrrkLI83o4LjzUAOWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJXgXvPXMem383vFwqF12RaegPlsg7XYh2XgegRs2SrNo6m5rfh80cqY6cFZXxoyUL1riifxtfRYbwTWyACA5XSEnHH1KaQinon2A+hJfKWR0qam0eoYgGS30VOsb9z/lWWTK+Kkxl71NImSA0fIuVucAVYB4OwTByyvEAk4NFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nhizYGFE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ev+WyEJO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nhizYGFE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ev+WyEJO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SIGV513906099
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 00:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M+WZ5p12VkpfX832o5SO9e+P
	vKsqNe/lB/hAlOK3sLU=; b=nhizYGFEF52633CDuU4F8TIdryih2X4NqIejN8db
	TKdy7A8NYkqNhc+Xi5PQxc1HNdOln9lnwsCGcruzVQ0+aSBkhlp70Q5OFHICsuB4
	MTEcbA2Ra3cVw50EckPewbdt/0beA62X/XXBpPjoHYcBty5zEkOdMqgU2GCks9xi
	x3yi3EG0NG00xZwwV5KqabVpDNqT2c2ms6dpHPY6f4Fmfw03abvBoUOz4K3DefJJ
	6kerEiNnk1Uv53ysq09ZZa85w3UeD231qQbITqfeBLl5H3gzpsWzP+lS0DPizhVx
	31+suTnwCsbBugiFlLj9BWIFYdetlurQubsok5wkwseR0w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byjxht8n2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 00:51:07 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94839e09cddso402101241.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 16:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769647866; x=1770252666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+WZ5p12VkpfX832o5SO9e+PvKsqNe/lB/hAlOK3sLU=;
        b=ev+WyEJOZGfLx8/S8IfymMcaj/6GGK3Ip0qeQb2i0VkBUBvmb1HZNgWRBFRHmrNPD2
         qXIrT/WiDAUxfe39r6KLzVp4YExGJ/50l+fZ4mONFr58sJnoVXOcSkjU/qthc4y3/2O2
         g0jVHC8iFY7T/GkK1QE7rXYk12nF+zbaVFkwLfhHkM6IPNhODR/UCwfcr19c0AFQZWhx
         Hr5bZ1Wn8E50Q/PA++06LKRwrIYc9C2+9gxEJvhnLDFtQBzSjXg1Qv8HaPA7+KtbB1o0
         ZN6+kbsfB0vbdNAAvKpCKGf6MSaGbQYO0o8Yytru6P3UTaeDDV7XzYBK6MtwxA8XuEJN
         voFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769647866; x=1770252666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+WZ5p12VkpfX832o5SO9e+PvKsqNe/lB/hAlOK3sLU=;
        b=haqE8d/4hWy1DS2IP5Cg3U8mTCb1xWH4e+DZbOt2gSzN6ZAR6wG2135/nGUO3GHoL8
         uU+kL9u8Ll5oq0iD7jZNsYxCErHWklMDMXbDqvDa0hkrcLpUKOlqZo7Qimg08A5m+pBe
         UQ1aMaQOTeiszOeHzr5euA1sikDMsB2kIPl1Wz2A/KedfInMkqXmbrLB2mMC3p44HhCR
         9d+3dmirufhLe9CxhX2lTzYfGaicjnBjoMZWiTuu05viF3GV0M7WI22Omc20RpGzX6WC
         NJ1kJLDZKqRjQUUpUZfPDsplct4Z67SZeJkqcnuEvK7ftH+qPqSPMwd5oTq7TB3VolgJ
         QeTA==
X-Forwarded-Encrypted: i=1; AJvYcCXPH4LwBaGe5OkzesYzZg8G8yKMn8jpGR/IgUTPUR+zQKXgSYcwIjTeNdJ9d8/c0e1pnZ8irScNNTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGULFv1kH9Gcv5jN2C7FgZxWUaTj2JolTOwbcDcs0QFeJ7/2y
	vXimJ6LvkYYXKIeIaoaCFXByfvuRI8LCIqaFL+fob/ixbH8hR8PQW+eXy3Z0lRqjdQVj8CGCmVu
	vzLMXlhEf7FaLMfs8HcJcnxdcCjGXybPsDUORJ3LaXKpB4p6/JDA4H0Zb1LlXiRU=
X-Gm-Gg: AZuq6aIXKAvVS/rhOXlGeMWLRq2FxX4Z7Uwkba0b40f8u/X3k9W7sVBmkorfwyj8vr4
	bEwZNn7qqAPIY3PR+01ntkX1L9di9tF9nWodpt1gFbf1N8huKCTve52ykKKPBVrvNUj0TK//6jU
	aacwW+BeKksiMAoEYMBfMzzAe9mWFM82GFjT2KmgELUbLBwXNNOs/VjBqQIpH/OHeRWiZSYV0fu
	6Mg3dYIQXIqMYSzAyMXDVfATskC+oNcfeWXRaPXFz9CxT+n8v7Tqe9+YHY95gqv4W+oZpC/ybMQ
	wGczuWuaPCObpWlLXGJmYFgMrNqNxM3B1fzXBXrfKdlXcnhM6k3uw7I1JNJ8RkqNUuN6l0hcmrG
	J/QcMGzrnzULvtsx/pLbY6TGc2Dl18q/g6gwsESHrkKPnCu1vHuIM6V3z2Z4SRdDHXxqwGnFXeq
	jHFBii3BgJLMrzKXiRHJO9cbQ=
X-Received: by 2002:a05:6102:32c3:b0:5db:cc69:739c with SMTP id ada2fe7eead31-5f723631147mr2251792137.17.1769647866483;
        Wed, 28 Jan 2026 16:51:06 -0800 (PST)
X-Received: by 2002:a05:6102:32c3:b0:5db:cc69:739c with SMTP id ada2fe7eead31-5f723631147mr2251767137.17.1769647866075;
        Wed, 28 Jan 2026 16:51:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bbf55sm856387e87.90.2026.01.28.16.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 16:51:04 -0800 (PST)
Date: Thu, 29 Jan 2026 02:51:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sm8650: Add sound DAI prefix
 for DP
Message-ID: <77qi3wlmjzdios6a6kqifsbsyusohcddz737fmdgmrgxcqlpsb@f2wkl7sw7nci>
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-6-c55ec1b5d8bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-6-c55ec1b5d8bf@linaro.org>
X-Proofpoint-ORIG-GUID: UUtc208YEm_KdrhL4jul1gbY9B2yUj1S
X-Proofpoint-GUID: UUtc208YEm_KdrhL4jul1gbY9B2yUj1S
X-Authority-Analysis: v=2.4 cv=b9G/I9Gx c=1 sm=1 tr=0 ts=697aaefb cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YAN0IDdG5KZRBbBB4vcA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAwNCBTYWx0ZWRfX1YyPFPxDny/e
 reYzWECHiCt7f9TLLIwXhf99VuGJs+FFzss6gIFY1rbcIvTlkw22pWHTEmxxw9/5jiWmuwXAZQ9
 71Bt67lKeXgi3+hhZaTJNOpwynREl3aQj+UMatZ2iGqvMB7xrCzeubZu1ahglCa0Jn/76X44I98
 w+/Wb/HP6uAWLA0BBXeF49+EgKT6CtaeJw16QLknQDD9iIvh+IPzlzJySO314XKmAGPly18B+Zd
 oeS2jQJ8TaYrQ+FuMMgmOXXemLempnrDRRo0bEbWwWOGEe+uoBkwgOSsJzw7o8VOMSkCPvcEBru
 9BhpC/+qs3FzqD9Wt4iFMnMBmqQiQfchwHu4YkJmA5HkyzQwOI4/7ZhDlRp+I6CtOAf4EAQ6Neo
 g9mc+J4yCNsjxSLWWOi6lstpncfXc72Yzvk4/8Bvu9f0L70wknUIMNr2ni0L1z+ytbjia7wuOtK
 05qd8bn8SgraUDEYlDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290004

On Tue, Jan 27, 2026 at 10:57:33AM +0100, Neil Armstrong wrote:
> Sound DAI devices exposing same set of mixers, e.g. each DisplayPort
> controller, need to add dedicated prefix for these mixers to avoid
> conflicts and to allow ALSA to properly configure given instance.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
