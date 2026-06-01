Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12427144B
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284977; cv=none; b=mHXlM3QtMM6w4dtj16Fg1pejPsN/qOIOQ0FMA+rRq2JKmvrDr80eMMZ+rMpVIS4XWE09I4U/xbj1CAZ5ynvEMZ9dEcV1LXyEfFZqjqBx4YO3+PSPiPqWWtmWiDVqn+YDMxZsEUJG7nITaIM1s50d7zrRNUK6f2ig4yUwxUiki4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284977; c=relaxed/simple;
	bh=QYXh0G06AbouZjAF7Y4oeh+7Cu5VBjT4uihuTQRXQHk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qbilKsspd1YzUVfqSKJEAyvkGlUW6oh1sabVHgb/T+F9LKSaovx+44LxE7KOJzKMnyhZuYMBU0ZGBf4B1h91dDHW4P08RJCrnSS4rD1zN/ZZAEapqayXxOK9tNL9WLhcXTlhTlsVk6cUxT0a5CSuMxU+wnfdMFO91aQQc/uV2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXs6O1ZS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JLJMfjrL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXs6O1ZS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JLJMfjrL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VNo4oE023799
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 03:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0df/1k9XEaXhLJ49wVkByST/loTrlBqvGZ2UoFrH28c=; b=LXs6O1ZSP52gKZok
	GgPCQrVadnDyWKv7azO18f+kDTWjK+8nGoT0dK/i62HlH/t53C/R2Nr0L6BIPnpZ
	nzYEHpmEepKddYXt5o4HmdojObrxxHcIf9oZ2BtqRyL4GZ8xt55PYuD9/Gd4pLIl
	1jGqX9tJhuNqFydOoEcis39QKAiuDPdpowm9RfCQ2i3MP7IQ2OU40pyTRjswai2V
	n4MOJhPvdvAVLcklGoCA7YoeytAqMPJKZHJqJT3Nhh0pvIpRRSPoRxlImBjlXuPa
	XfI+NQacWVIsePoIFmDVHn2alXinLlSLm4HqN+CkHWn7M/WU5DxHixa61k0Zd/NA
	SvKu8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efn8pp2xy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 03:36:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c272e532so10503805ad.1
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 20:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780284974; x=1780889774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0df/1k9XEaXhLJ49wVkByST/loTrlBqvGZ2UoFrH28c=;
        b=JLJMfjrLPEDcP4GNyJv9EjEt6T82g8Q075LExRF8V1/00Fd33d/14T1n4uTHEBC8Bj
         X98h8yXxdWFsIlXVmOGN2oRl5cEupj2ixvl1tnnLrvZZwoMYkItOJQ2oSKUAWMDBFNnp
         z8FCD/BpDE1hSpOJ52rB7TyWlqkDrsY0FL/x2/xpgNRHNOgCPf2YaHdK1mma3+iwYU1S
         sSGlDZH0Z5q9HYQO2lQQkgzCW1ldAeFi/to3nRl0guU54xBLodV7a3DTsRthpPW/kmbG
         OBjM9Hmz8HqiehJZaUmR0eAr3SQVS7yOjUlQNwcCDEusdFb7ztVBpZHC8VmZchFxa1+a
         2IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780284974; x=1780889774;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0df/1k9XEaXhLJ49wVkByST/loTrlBqvGZ2UoFrH28c=;
        b=Ggso3o6oZkgtLxbO7kXgJbR0HTN17sIVreQ2DPpOjCIjfIVTGHxg4aP3Y+EJ1KZgjU
         zR/WkIS9bEAoVuxoEcOviWSBizkCCOfjHdqJldPAx1WhDDd+R2Gi/aYbbXLplcEBO0N2
         rUpI3qMNfJQKTfGsHVMPLWwPQobgpcY2zD+YzKHut3VoeJcy8ELZeMHAGkKUiZSjPZq5
         pzcw6lpZrRkxXr0w9x9JrWh69zVnqdf+LVAG0Oc5+h56Qow9CI/Oh5s9cJ4owzMYxUij
         X0Ti8ufQx1f16iY85mJp/DqYT8BVJN6+l8GOhz5QplJRXqE60bPeh47sx8NYQ7ojBLLz
         qImg==
X-Gm-Message-State: AOJu0Ywxc66RS8cfx4nY1fDxKhgvCqVQxckFZEyairbJ+ACKdi12afnd
	5ospduG038eLR16dlO1dSh4Ebj4eUTKMWyavyDAmSH0rtRk/Qixac6JLO16UzFknWoB1XTZg2RB
	RGhkc/1U37lwMKs4XtkwMQfQUMfZLNnxOjlh5+Ul87nbmDWL7yUqNL+phGaLe/f0=
X-Gm-Gg: Acq92OGo4zey2QOyF2Y8usrW0cbtzcxs+it0Ze6TJ45MMoIt6zOmjor+byZxCNsfDyd
	d7YyxLZTa2ajC7rXg6P4PByBe7X5fZSC5yRNVGNss5/9CJKRPf7li3S+f1y4FvJ5TuedyLoKLzk
	s90Cj642H2+xUxhq7r5qrT45QMKAFwxsWgR5rv2aQmVdOwPwYm4Upc1zkX4SKTaP2z5g0CAKnUx
	pm0dpTZhontGhxpc3veOQkmrjHyb1PuV2OepthhrFsJQfpl/oipHhNwz/6KiiQzys1VMerbGVOI
	B6Sm6OrtJ6LvL+kDuwjmT2P4dG2F7sUT+e8L+k9o0FUVBftg0bUHUIVe7+30QHOXts41ytezGtc
	yq8UBjlZWsNHR0scM9ErCDOrHgb4jIPPoFOgGb0yA28AsDA3nvgPSB1EEf/xOAhx1
X-Received: by 2002:a17:902:eccf:b0:2bf:3126:44b6 with SMTP id d9443c01a7336-2bf368bd5dfmr97438565ad.40.1780284973868;
        Sun, 31 May 2026 20:36:13 -0700 (PDT)
X-Received: by 2002:a17:902:eccf:b0:2bf:3126:44b6 with SMTP id d9443c01a7336-2bf368bd5dfmr97438175ad.40.1780284973261;
        Sun, 31 May 2026 20:36:13 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5c6dsm86930945ad.17.2026.05.31.20.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:36:12 -0700 (PDT)
Message-ID: <a27b623d-8483-46c9-9d99-8cdf6802fc98@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 09:06:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Mask ASPM states based on Devicetree properties
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, sashiko@lists.linux.dev
References: <20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com>
 <20260512004624.B82F7C2BCB0@smtp.kernel.org>
 <e1c6649d-06e2-493a-a4d4-e18b9044892c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e1c6649d-06e2-493a-a4d4-e18b9044892c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7ofs_sGoUoV-dlHrNQko7xVABJ4KjNuN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzMiBTYWx0ZWRfX7tqqVepPj2pA
 6zyxd5DPFy5NPNdddvgaeZys5P/m2EiywMAQtP8gdrhvjbqJYXTsvqRhT1JqVtpRRq8f9Hp2Ljg
 fAsky1rK2TEhvEc1u0lnkYSTiORFeX9dxEnUmB3+rE51ztehHnK1b1hHLXQJwHJllYvST9qVBgE
 u/jRnYtCPyZtpLUf3BSHbcx80Dk0WkDEOaigO1TbiJIRqi5iv18Ri2id7QGVWbz3/ZBlETm/N0H
 qffk1FLFDkeUi5E2awDsCJLlkkkalB13ooh79WRr3toIsbXBu1/3qyb5o6I1DmQyI6UXwYFOBnS
 gf20bUS5N2KQXAGQj6eQaX3pYNZaEq3NgN+ARgt60yT2nFzXqZMqNofNKd82E41j4JzJfULkQQj
 q8XgTsyA800iWZcg+M7qJAdD3MWnDpA9h3E+gmc883OPYceXBgbQREtaHfbvYpK5mFM8+1mYSHj
 RS+Pwag83Ni3l6k3nVw==
X-Authority-Analysis: v=2.4 cv=NvvhtcdJ c=1 sm=1 tr=0 ts=6a1cfe2e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Dbrxa4HYaB7dBYbdm7MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7ofs_sGoUoV-dlHrNQko7xVABJ4KjNuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010032



On 5/12/2026 3:56 PM, Krishna Chaitanya Chundru wrote:
>
> On 5/12/2026 6:16 AM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] Modifying `link->aspm_support` bypasses `pcie_config_aspm_l1ss()`, failing to disable ASPM L1 Substates in hardware if the bootloader previously enabled them.
>> - [Medium] The `aspm-no-l1` override only masks `PCIE_LINK_STATE_L1` from `link->aspm_support`, failing to mask the functionally dependent L1 PM Substates (`PCIE_LINK_STATE_L1SS`), leading to sysfs inconsistency.
>> --
>>
>> commit 3739505256d4ced724de1faf6f3f111a9994fa59
>> Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>
>> PCI/ASPM: Mask ASPM states based on Devicetree properties
>>
>> This commit updates ASPM link initialization to check for aspm-no-l0s,
>> aspm-no-l1, and aspm-no-l1ss Devicetree properties. It masks the
>> corresponding ASPM states from link->aspm_support before applying the
>> default ASPM policy.
>>
>> Link: https://github.com/devicetree-org/dt-schema/pull/188
>> Link: https://github.com/devicetree-org/dt-schema/pull/190
>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 925373b98dff0..3111ef7fd226e 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>> [ ... ]
>>
>>> @@ -806,6 +813,15 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>>>  
>>>  	/* For devicetree platforms, enable L0s and L1 by default */
>>>  	if (of_have_populated_dt()) {
>>> +		if (pcie_link_has_aspm_override(link, "aspm-no-l0s"))
>>> +			link->aspm_support &= ~PCIE_LINK_STATE_L0S;
>>> +
>>> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1"))
>>> +			link->aspm_support &= ~PCIE_LINK_STATE_L1;
>> Should this also clear PCIE_LINK_STATE_L1SS?
>>
>> If we clear only PCIE_LINK_STATE_L1, link->aspm_capable will retain the
>> L1SS bits while dropping the L1 bit. The sysfs visibility check in
>> aspm_ctrl_attrs_are_visible() relies on aspm_capable, which means the main
>> L1 control attribute will be hidden, but the L1.1 and L1.2 substate
>> attributes will be incorrectly exposed.
>>
>> Any userspace attempts to enable these exposed L1SS attributes via sysfs
>> will silently fail, as pcie_config_aspm_link() enforces:
>>
>> if (!(state & PCIE_LINK_STATE_L1))
>>         state &= ~PCIE_LINK_STATE_L1SS;
> ack
>>> +
>>> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1ss"))
>>> +			link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
>> Will modifying link->aspm_support here bypass disabling ASPM L1 Substates
>> in hardware if the bootloader previously enabled them?
>>
>> By clearing bits from link->aspm_support, the changes propagate to
>> link->aspm_capable. Later, when the kernel applies the ASPM policy in
>> pcie_config_aspm_link(), the hardware update for L1SS is guarded by:
>>
>> if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
>>
>> Because the capability bit was cleared by the DT override, the kernel skips
>> calling pcie_config_aspm_l1ss() entirely, leaving the hardware actively
>> using L1SS if the firmware or bootloader had enabled it.
>>
>> Would setting bits in link->aspm_disable instead (similar to
>> pci_disable_link_state()) correctly disable these states in hardware
>> while keeping aspm_capable intact?
> we can't keep aspm_capable intact as this can expose l1ss capability to sysfs
> as pointed
> by you in the above, I will do like below, 
>  if (pcie_link_has_aspm_override(link, "aspm-no-l1ss")) {
>       /*
>        * Clear L1SS in hardware before updating aspm_support. Once
>        * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
>        * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
>        * leaving firmware-enabled L1SS substates active in hardware.
>        */
>       if (link->aspm_support & PCIE_LINK_STATE_L1SS)
>           pcie_config_aspm_l1ss(link, 0);
>       link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
>   }
>
> Bjorn,
> can you share your taught's on this.
Hi Bjorn,
Can you please share your opinion on this.

- Krishna Chaitanya.
>
> - Krishna Chaitanya.
>>> +
>>>  		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>>>  			link->aspm_default |= PCIE_LINK_STATE_L0S;
>>>  		if (link->aspm_support & PCIE_LINK_STATE_L1)

