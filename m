Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5282385525
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848540; cv=none; b=DkTLjAhRiysXma6BWsxHml2UOL0yP1E25Lkwu+WSDTGMQihDRajpENYaGYrPSq6lR2lbhpBOWqnf+Y5gX9xl+VYDA8yVBI7oB/EJM8xTg419St+giW7veex3sWC2r5DgqimvhxrQ3ZcagzdPaYJrpL0nFONjSnE5GcZI17i9XmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848540; c=relaxed/simple;
	bh=Oqnfe1B7pgXZGMnxOjT9IdortdmUJNYX97ief7kKKuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlJaaeOusbE8PclvTvs4OhSxQFxWT+3n1WB4gGsSr+ifF6c3O0H2a8R1jyTjCTqFsbqPimabZx2fVnHqxsyS2Fvt5lQhKUtEQ/6NoQWdnqSUxrRkLI4gL66uxbo/zLAI7UWFq8oZHBGBEQVrSeKYWkUwhHwz5SGzqUx0DMgocAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5lCeoyS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UaSiGMIs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5lCeoyS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UaSiGMIs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U3NnIq1974830
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 05:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	20GNW5it+X2su5CUYneKv8hJ0SfE9B5LXD06+2GpUP4=; b=g5lCeoySpJ6p+RGZ
	xk5oP67iwVMc1hZO7Zph4sopamh8o7qo1u0ZHjXuRWpQVOcxa63+QEavAACHGdlt
	TbYQqLRmK23SAtatcXsAjoX03lT0H338vBOnzvt54beJK4OyH6ZHPNBYizKdHa8s
	QJ3PkYO7pQf3qPip/ZfTTGSP864jYNeAjMDha+s/uyaTJYAYz4UlQfRoCkcN3PvK
	Zz1EVi7IwrRGOQw+dI4DEMElxbrc7zeT/XeBpq4RZ5QE2AVizqtYdjT4SUn2gLSU
	PaYNuvCEwg0bXAOiCM9+2/ZdDXUN54ouW+auflLfMi8Tif+oG/ITyMi6LUtpbbho
	TZuShg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6ufmjm5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 05:28:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7381a9a932so2671375a12.3
        for <linux-pci@vger.kernel.org>; Sun, 29 Mar 2026 22:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774848537; x=1775453337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20GNW5it+X2su5CUYneKv8hJ0SfE9B5LXD06+2GpUP4=;
        b=UaSiGMIshcosvF9R5288wyE2GKxGSH7kh3jjTz0dhtvuSFU2LkZaFokyPPW0IgciIV
         3uezwJ164dUiAbI27SEie0nqoOzvD79uIDPv0X9eZ+g3Vb+1R547VWG+RF5eh8/89uOb
         NxDiKRQKMMUWRYcY5jbOedorsXJ3eAJyIQFV0DHAqPSAvXK3RX3owvSbptw/S+U2TrZV
         mN0P2ilC4lsT1etYIR3WfG2vNpSLLRT1CaXw9G40WeTzGEN05x4HcE6+wovQd8b1GELe
         UDQGzRrmrS+sh2dVdDltcJ5EY/Iopg257T+ynH+ghtgglx2QRBFLawNTA1/xKBrAVRG7
         eGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848537; x=1775453337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20GNW5it+X2su5CUYneKv8hJ0SfE9B5LXD06+2GpUP4=;
        b=jN+ezRGgIsJzsFsrHSlFOsrRc4yi0g4amtqf3aRX1L3Jy8iLcanniRIp7GVXXGtvTm
         Yshtdh9q8ajASrZVS28N4GIOce473XnQwSrH+55s47odLImHAz7irWjsWTt+B0TTyfKa
         0AcPD/HHIjxnWCxogEuD1jhcs4OKQYgpg6KuYV3Wwmus+8y/7IwnMbH5Ol8V19+ObEKU
         Df4pCEhq4bcx8G0w13mFRPWm1FTd0QGfJRvKOzYoTRBMYQSw+8m5QtxMe5DJfDPDAMgZ
         fBPaxucwP3z7hUActODvBNC3PzNLwMxbB4/kq5G47BbfZAmURluW1uJjZ4bS6fiteOa3
         gNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwAAH8Rt5Lf4tDKrCrF9AH+0XraZAgynJXWCokkjhFhzY2C8bZ1EarzLt8K2vDv5VFIMNrWbUF0y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziuKtn3a4q/HciWjVQo9hOrlFv3sBYumjsOi3PdlKUU8ho7HbG
	tU8wW69k7mFxwzoOBBwgaqNcVRqXki0wYteU37Bzoz0bgeEpuOP5BWiu/qACCv/s1A0vluoeO3F
	HRmaTEwcnRImnrdHy8RWymXg3cji7L93fKwmIACKJSLjdAilM3NZi67yshj7SDH4=
X-Gm-Gg: ATEYQzzPLH07gsqrtkb8Mv/T7ziDqWC5UF9BQYlH5a9pdBpMR5m/62hkrpYiuZdZyqP
	DbkrDQVUMrKre1gk6045HHVbwqYiCCJcnqClZRoGBzVmM8oJHLHNIqw0v1RDCUVF6/UMWcaFnwl
	LIHsxGYkGAhkEj3j5HNTd4lUiqNBRSiizRTRHvrbWr51X9+i8mS7tj8or3x7hpvjlYvmkVYv7SN
	8W+tnV7PTlUsj5pK18rXBe6KJ+CfHzkoVkQg+Mcdd3PPVJaGEBTQQGBOdosltYSqkoBmM0JMHDH
	QOhQQ6RiaiXVxQ5dSEguIWolh+cJe5FwSAaVxpcX1MwNagdhJ0sLr5PIWGpa9XxixN3cSqUzJ6i
	w/3KWRJjtEluV1wKZLZbESewZWEpVYgfD/ftoi60r5Gk/dv42RgE=
X-Received: by 2002:a05:6a00:438a:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-82c95e7c457mr9909612b3a.24.1774848537579;
        Sun, 29 Mar 2026 22:28:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:438a:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-82c95e7c457mr9909565b3a.24.1774848536921;
        Sun, 29 Mar 2026 22:28:56 -0700 (PDT)
Received: from [10.217.219.124] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8465785sm7263307b3a.18.2026.03.29.22.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 22:28:56 -0700 (PDT)
Message-ID: <d98d21a9-b355-45a8-a8c0-a0659792e76b@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 10:58:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dmaengine: Add multi-buffer support in single DMA
 transfer
To: Vinod Koul <vkoul@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
        Subramanian Ananthanarayanan
 <subramanian.ananthanarayanan@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
 <20260313-dma_multi_sg-v1-1-8fabb0d1a759@oss.qualcomm.com>
 <abkyyBxSnwZWAt4-@vaman>
Content-Language: en-US
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
In-Reply-To: <abkyyBxSnwZWAt4-@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzOSBTYWx0ZWRfX57XaPLPo9l61
 J9Fr9CtRkbqAiQ69YeH/pdaLv/Utc7FKIdjKlJzBjN/KOaxemmVNlq7YGG2lJM+E6t5Jz+EcVGp
 xEmlV4Vn0jTAt0SbiQKZ+J/bAe0KlFxh2P+B692W4nBtYbCPqO+SyugjzAfML82HkzNB6PasiZE
 KNLcp01OF1hm5zdObuwozcNdZ0sNusRyNigzQVRJWrcvFgrmV+SHaGDaJtInPbipfqUCzRGDiUy
 ohmTyzZHpvF/s2vBxk50qX3SeQIYhIW1Vy1N0LbOV5OwIloRofU9iu/Fk9qBWMs8l6J//6MW8KW
 TF3MBXUMMOlmU1qRK2d4+69a2IHT8MYGTDhGuOzuAntviwDzCSQ2NMDF4P0ydLnDrM6/AMRZjmd
 9vdz3DcmjdFXV5kDyZCl/KzKZKZooGKnbdaAqT+vixxhBeUsJH3TMDGI1pJYjaMZOeAyvgiDBjQ
 SK6j+F0geJlrlP08M2w==
X-Authority-Analysis: v=2.4 cv=aOT9aL9m c=1 sm=1 tr=0 ts=69ca0a1a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=kGe3cHaNJUDbgVJfyvsA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Mix9pfW1tiYXhoDeZhacWqLg37ChW8gI
X-Proofpoint-GUID: Mix9pfW1tiYXhoDeZhacWqLg37ChW8gI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300039



On 3/17/2026 4:24 PM, Vinod Koul wrote:
> On 13-03-26, 12:19, Sumit Kumar wrote:
>> Add dmaengine_prep_batch_sg API for batching multiple independent buffers
>> in a single DMA transaction. Each scatter-gather entry specifies both
>> source and destination addresses. This allows multiple non-contiguous
> Looks like you want to bring back dmaengine_prep_dma_sg() see commit c678fa66341c
I was not aware about this commit, I will bring back this change (only 
the core dma part).
Along with my changes was are integrated with the above commit.
>> memory regions to be transferred in a single DMA transaction instead of
>> separate operations, significantly reducing submission overhead and
>> interrupt overhead.
>>
>> Extends struct scatterlist with optional dma_dst_address field
>> and implements support in dw-edma driver.
> If this is memcpy why are you talking about dma_dst_address which is a
> slave field?
As we are going back with the commit c678fa66341c we can ignore the 
current patch.

- Sumit
