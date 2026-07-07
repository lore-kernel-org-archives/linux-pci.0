Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8E386429
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402817; cv=none; b=bYMatjl91pUaKjyJFQTcy5nDZ3aEfIsTsqJ4GHMImlrQeNVWkjyo3pVMODi0q1FYw8SdkRt/gTUfHLJmffnbHjadVNsFrSXYaYrEvsxy8BFtdCNJyAZHp3ehGNBj0Fh6dbk0eDOq1GS1v7Gwq4ArT5uvD3yp/8vLcO62cT1RZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402817; c=relaxed/simple;
	bh=n+m+WGrSXjSisXtKmhqmlHLjEHZOILl3o8Bjfpc/hiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKfoYCm4RHYPbRTyNDoGDluTpLw5Z51JvQUBSDfyNuLD9AotxSkV4DQEKnupzGvRzsbeW4HKAIq7FTD6ntGosyQyGIaUQb32BByQZYwirzB3a0LwBqlsZ5eh23pmh5Am6nXyRU3WUvEF1ZNZ/5b3Aa5iiuerfvPgwuI993Wr3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUWnDpcs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzWnmxqm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUWnDpcs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzWnmxqm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748pIW2687448
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhP3fYK+aJLFo/yxK3ki9QBFiA0G/X1T4yRKAQjIIXE=; b=bUWnDpcswnxLNApa
	PUSIJ7I1FGtbNZhqlAs2QI+vROlMS5snVpQ52eKy/wtSvQOvIUic0pYpVtsjGmCj
	R0rGUSH6ngVvaijeQ931c3DYSA9kMdNdcLh0dLsML3HNoDj7C7kSI9GVVg5NwKDh
	GE90lNml0nzKvt27GjXxJpZiqMWJQNLsbbAowIRC4M36pe5Fz45XmPfPfEV2dMpd
	WmbYEuRMoojuaefDYaxwHgTjB3NtCnGV8Ng/RjBjvocPA9QrSQhIKV7JE5jDYLje
	H9OWqQaDOiQf6OCzG7ieLTRZ//hvdryWjpJ3WNZ4rBM/MRV9OgjqQ5mzDi1BFWUz
	aAtEtw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gvb79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:40:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381d039b797so2756526a91.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783402815; x=1784007615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhP3fYK+aJLFo/yxK3ki9QBFiA0G/X1T4yRKAQjIIXE=;
        b=TzWnmxqmf0s7vZBas+VC78+aAC5asIcVzGPqPKvEPV58MqoxWXNBd/WXoIJjXcd//T
         dJm8QCNbd6CGby6ezIU2qN41TwT9Z8W+DncMM2ipdnd1PjXxnohwnLySx8xyGurKDoSU
         k9JhkmDx7feNY7rVaaOWU6toQGpZxWpJ3xCZAIHzNxx2D8iZl/QN3hCtlof+4ic2eI3u
         ximSXrUMB76EeqyyZJY7HLHnoa4Ntd3G/fjiqW3UEg9le2KEVsyGd69hNaG0XOXma+CJ
         oUJ+Sn6tL+3Zyf4OWTuwmMGSZHyoADVGDWDC9FP5F5EhdILs3vL+XOihKnKV0AHkv41S
         giBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402815; x=1784007615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhP3fYK+aJLFo/yxK3ki9QBFiA0G/X1T4yRKAQjIIXE=;
        b=owRXWbbt4CjxcSMWz3kkA9aojuC50wtKj1dfQ0ZSV1gw/xswKxjuNSQnIzqTG5sQFg
         /rXIy3X4i7i1uCR3JY2zGgnv9/0BvJd7eaml4dNUFB29bbVI/RYXtZnALesDJqBaRTgA
         rgjQzNgtxaAdKc17imHjBjCt20MGr9vysONGb97MQQyE6RsRF7hQh0Ux4h4d+6Tz5530
         gVV1OZDr/MS5EoVFuAYspHQLdVCF8Nbr8epPoEysjzSQ5rLabWJzOqtDbnTAW5T0HxFR
         rqC1xKxZvrDcgNYwYEeHrYzvyTnHn+3Yc7jVHe+ny91HMq62ZjZZaijjhkVFfNQBQS9o
         TpLw==
X-Forwarded-Encrypted: i=1; AHgh+RoohmB8Sw1AtrSGZ3MpqAObOl/hzGZTqmacHo8UA9u5Mz9k4WQUzW28Act974ysqAui9Ztz4btStLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqj9rPuOpJeztL1vAbCJ0B2TBBnh0PakdP2Y4tBo6YT4nIZRRj
	yoegJCjiUH4paTKX5TOCpNt0ziKF2C1aqXzRfWvy2xhBLK4c5c89JJTCftmPm7aUDGXGu7Z7siL
	/k/SpDtMTBRmKHZ8y/LqUelwzPFm3rbCGkO1VGV0wxRChV7EFKjuUUbbsMHS96nA=
X-Gm-Gg: AfdE7ckH267pBwONw6aMulzHrMZ/QcUAf81gU9V+WiGgAdesto123BUAfh8Ml/NY0ZC
	sHWgKDorVd21hpfAjBfIdHXyZRcDmmpme2oo4S+g64CkCH1tdRSVTlNxXuC6O8eUo/vRt6wbRgI
	RB2BTl/9kBgded8oVWHOzd3bZOVL7gzT3k5lcBfiFQ+7HwTnUlD0zZn0lZVYAb/g4xkcapD+u63
	hM9E5Oz4gb9JMHv39nEW2lXf+tqfkGmZ6Tu/hGizJWZwUg/nF3GcHDGl0e0dK3f9tyQQCj9kAXu
	iAhpulcAFxcpYUFtSXKhDzzQ9KdUp3HL+YeUQZ8r1xvDpvpQW+0TjJEVXCWX/VISQLRf6E2Lmri
	1c5SX5lYQZXQxEusWeVTLx5Uujhf+wHc/6kG4o42kYui8CBepM34apjQF4TcriafJfKOhtNTBoF
	2A27pq
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57ff with SMTP id 98e67ed59e1d1-387e0bb5ba9mr1259369a91.38.1783402814802;
        Mon, 06 Jul 2026 22:40:14 -0700 (PDT)
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57ff with SMTP id 98e67ed59e1d1-387e0bb5ba9mr1259321a91.38.1783402814249;
        Mon, 06 Jul 2026 22:40:14 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d100b413sm451809a91.2.2026.07.06.22.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:40:13 -0700 (PDT)
Message-ID: <ab1cce3f-4066-413e-bcdb-13e89a03932d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:10:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] PCI/pwrctrl: tc9563: Add API to control endpoint
 power and reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260630192838.GA223662@bhelgaas>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20260630192838.GA223662@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JTkAsUnthC-ylIn7ng1u50x0sxJUGexq
X-Proofpoint-ORIG-GUID: JTkAsUnthC-ylIn7ng1u50x0sxJUGexq
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c913f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=153GEgVumq_bsj_kQ94A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX3eu1PudFQhMG
 uc8MoUMS8yJyvhJM3Tg6OdBNUauPolcVioQU8VA0K9YNL2usHZBRhEsD7FZxjNbcIZ2g96n2MuW
 B1rSJwbTuLHMgYhZJLKQMbD+sxs+yk58s0jYgwHXDvjAbJ3i6rJ+U4WQY80Pl/GilqosoLswgI7
 qh/POhS18t0HMM6ANI8e/XkQzxwzQJXIhPtNsu8ydpRFgsb60u1b8JEpyl24LUS2Ban0n8sTh1H
 Ssk8sngQzHyIki3Rkyfs703tpwzORRJZj95ODxPy4ZKuxsE2Z3IifwMrczp6otzzJXnN0JsXpQN
 6c8IAUJXZGVp8mPczlyj/C5kHy4KS2fME8QE2C/9dzj3EMYD+WBNW6Dbc1FLgSovpgpKgqHzo1+
 QxOY+ReAuY9GewY96t1oefCjvajloMvQwAk51H2I5yRNHoeCiiHI46ufL7+LZF3bNRrdglvSbqZ
 f1L4ts+POHtFTgVZcRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfXz1mysUeAy92o
 3uetPA+2ZEPbhBSLtOsUXU8b/oFgq60WvliOnvTL2wME8NdY7Q+XbSnXyXVn6hkBJxVoby0zCm4
 dHiJtugmjt14H1ypsQ9S2+kbIFep1Gk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070051


On 7/1/2026 12:58 AM, Bjorn Helgaas wrote:
> On Wed, Jul 01, 2026 at 12:32:48AM +0530, Sushrut Shree Trivedi wrote:
>> Some platform utilise TC9563 GPIOs to enable power and
>> control reset of endpoints.
>>
>> This patch adds support to parse endpoint reset and power enable
>> gpios from each TC9563 port node in the devicetree. To configure
>> these GPIO's during the POWER ON sequence, two new API's are
>> introduced: tc9563_ep_pwr_en() and tc9563_ep_assert_deassert_reset().
> s/Some platform utilise/Some platforms utilise/
> s/This patch adds/Add/
> s/gpios/GPIOs/
>
>    Add tc9563_ep_pwr_en() and tc9563_ep_assert_deassert_reset() to
>    configure these GPIOs during the power-on sequence.
>
> Wrap to fill 75 columns.

ACK'd.

Sushrut

