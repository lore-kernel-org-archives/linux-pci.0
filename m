Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337C51597D
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787125; cv=none; b=YpaCVKjmkHTPTnnuvJAhyorMReqhO87O+NdtoOclemS2utduoksHj04l4F+5ld+Atsf4vzIRYPMXyRUHZzonYKjsHMDNziq3hTDdoZr50HHLRdx87evMVlRwvZ3RA6Kltllok//mTUglh2ql2XL82ADxIXu7wPXzdF3qF7oLE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787125; c=relaxed/simple;
	bh=CnxtVH5Su/hnU4Ak1MO6R56WxWWK6v1TRcF8dD+Rap8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Odlh8MmCEfPubB3rcOhtr6fMw1xS24UnFW5SubEsIMR6Cfm4d9mxDtqmsLwbEkuziEvvjy9il0BvNGJ9X12oLQyjUzbBPmRTz5HpAPIoML3nDWnlHr42m4F5vXGQKbcRAUP/wlVDG47yqPRk0yI1bKpmv+RqzfaqZMJxiAKfjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ff8pMkVW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=frLMA3uY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ff8pMkVW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frLMA3uY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxqCt3519842
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gWjBtQND9hftR8rh8j6Q/GZ/XpaAGXkJ5hivwCTH91o=; b=ff8pMkVWSasf5Oq6
	yOdKJJ+0xnpYoMlI/UWTVo84O3AAGiAwq20c638b/SfBTw9y0YvRUytHvcFsDih/
	QRbvqBJZRV1ILlztZRIUxI1lNrIEbxnyro8TKgFUrK+oO8y9WCEgxnT+DrSg/mAe
	1yHx23doTeH2dfu3aY7M3mk1vK7T+nrgw8zr+u0zKp8X+OmMjCRdrSh5/lCrdoRB
	mYfdpbcsOHKOxcyCRv4IYUNkTbI7qxQjft6AkDuf67zrtqa9/JodRWO0WXKK+Vp1
	I/UunVQNnEJNG/l34wOnDjxNB21SgQIZypltqErRHQZN0Cwqp2+mp/maNwsEU3YU
	xcXM/A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27jgk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:52:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dff6253so18719725ad.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790787121; x=1791391921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWjBtQND9hftR8rh8j6Q/GZ/XpaAGXkJ5hivwCTH91o=;
        b=frLMA3uYGYz07GDjEDh+m/dSRdlbNpx8CdysnunplWSv2h7AQfdrBF+0BTQO7ByYw2
         EORk+1+wjsBUCrtK1yPUgzn8D9f/eQLbvRiuUO97rLi4tqAmk/e4QRSw6uG9py4tPXVd
         KeR5dm2KkEMj2bQ76Ro+BRfUbjJxg0CsyQqNzzyMI49qyHWa9w/M/NUmK4+ONM0Kw9hr
         BQYKEIR2v1svLzp6cexl4j6vubNtLeCg9u4UKnTjUszq7L5H6aNZhr5kEpjY22nDBHxT
         5ejqjtYHJ4ZGUpJu6VtYU7hG4UbKLzGk1sw9Y23HwpdWKpirNGsUXjRe8XZOxEPvgHut
         lFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787121; x=1791391921;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWjBtQND9hftR8rh8j6Q/GZ/XpaAGXkJ5hivwCTH91o=;
        b=y2YTF8DZxnLQrTk2BKzYqsU7uym8/te/HHmYKutjOqoI5D7PrFJAuGK/yywe4/E5pB
         tu91xHsQECu3GWYMTcfRsqWxsJGy3It+ZaWXAph0KGpCxj2i3Gr9+OnTDQK+Jo2zME6n
         9TuZLZKm0u5rTP9JZcN2+6Z0IZcl5ToV8ALhz0nHhSs03XBLqdyfn84aCA7Kwbna+QIp
         EbHUpGrx6/dNnwwQ2nJ9105BKQ+pgyqK8uyPNLBIYcSyUOVDukJtjz3Fpl/Mfz9ig3nh
         uwCO+uGo+fbNkSnZKVmXmtrfJhSY5pI/CJCjKS8sA2tgThxrSOFdiNQwsvogriAWgJ3l
         w0QQ==
X-Forwarded-Encrypted: i=1; AKwUvBydF6szh7aOwaW9KtrBVBVSpanm4kB+5UAN/U1ZzSkW0kkCFoaWwuz3oFvJuapCaX4OqKQRrqPSVzI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKSLfiMZfPZOhZyppbphaJc4N1B2K4fQpn4XDqq7mx31LV1dAv
	wEumNgyu8Ryg0T2EIXOBfHY0CQTVzRP3JDw2CcbNfIjDSj9BPlwo1Hb14/S2scc+ufV5g0sHqay
	ttAB848uvA9S0Ux2bn0S9I7cbW2dWjr4f1I+PVrtdLbZqYfGd03xqfMQlHsHUJLI=
X-Gm-Gg: AYBFou06w60IQlW/yMnG/zXUFRBBs4Yfx8EdhJUgdFZL8wwlWEL8jQHCOQ++4Q9fpy/
	P7f1y6j41ZKWG0FCTL4jxxxFUy5pCp97la6QXcK/KE6gr4urp1qLD9HwFeh7kfj48EyCE30Iynl
	bsj1IIeHe60YPCl41I8vbJJf5x45/U5AcA+omXLOQlRDaURo3l3sY300K/+CszkJzpSpWDcHcNm
	oIqhz1ZGtp8J52yhRdTONKlrGrqkeviFe8huBMrWQRzer8tfjoP1fzpXL7PSkFE7u0G7tiV9eUi
	mV4nbhP76ErIHBIbPnsbiGurhx2o5RgTyQokwsso8yjFI9cN9ZWIjJE2P36ej8ZIQlz/Zo8ldB5
	mwkLp8Tb0WkxBqXWNxeuGPNjTmgDa
X-Received: by 2002:a17:90a:1196:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-3a4f1e4d317mr123853a91.0.1790787120533;
        Wed, 30 Sep 2026 09:52:00 -0700 (PDT)
X-Received: by 2002:a17:90a:1196:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-3a4f1e4d317mr123813a91.0.1790787118955;
        Wed, 30 Sep 2026 09:51:58 -0700 (PDT)
Received: from [192.168.4.51] ([76.167.171.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f46bc991sm152391a91.4.2026.09.30.09.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 09:51:58 -0700 (PDT)
Message-ID: <c1213157-076a-496c-870e-cf5469193600@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:51:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ienbx5wjdzhgtdtbmuqcc76ovzy5d4wid7x4nhq5e4bco6u4il@264db3obw2qq>
 <20260911171807.GA402207@bhelgaas>
 <aqeTyRnmsEcChW8G@hu-qianyu-lv.qualcomm.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <aqeTyRnmsEcChW8G@hu-qianyu-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfX38DT6yuZYFHA
 WkFJAPVEO7yazRVFH4ILIBf1c4rYSezF8PtUVlrxiNJ8qn7J3YSithAXsmXQbJvLO2gRpIdvmOt
 9YvtVocXwETvvyigdmNCT9nyNHgbQVE=
X-Proofpoint-GUID: ZIL4idn62PuZhJyet_Q391hST7cXA01y
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd3e31 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=aHhNPKUfMHGsajXC+q458A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=59o7MN0um8TNGaiWInsA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfX7xoujgfMMaiy
 Ur95zW05Pfv/iCkbj9DCoW+A7ksjAmQIvlyihKvIkXphZGNHVv/AFaGh8ZV+xtT1fC09Hy9787V
 XQqY3G8zIoTL1RZf/bjwVKJhk/uy940LPTmpu8l31f3r41r7L1f9rtCOUt5At7smwRs+XDKPNLx
 7vnbgrR2XiIznDjBi73jT3S8D8SqJ6XFv0e9HrRDsxcGa37ZBzg2UUVOKAM9sR4PqZHhtswel70
 UdkT15FIDqSO1QWRnTCUPpMXTi6TIEd6h61caLIRz25ndkPppPAIchZ5aSn7FWRsCfUoBxHoPTj
 gMCpK4lIYEX6y1BNcV5pjY26wgXk2K9iAn7RMwO3NbaQDL0lvRpaa2VxzaBk+pTrRzMEVjVdYXW
 MkQ6CXyZjRZlv5dokUFcJ5jKemaZ5M4KiFHcHnlQjXLeD0UE27A4so7qFg0JuORiClv196BH5nI
 kdrgfJIXBCAbsloIzJQ==
X-Proofpoint-ORIG-GUID: ZIL4idn62PuZhJyet_Q391hST7cXA01y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300067

Hi Qiang

On 9/13/2026 11:27 PM, Qiang Yu wrote:
> On Fri, Sep 11, 2026 at 12:18:07PM -0500, Bjorn Helgaas wrote:
>> On Fri, Sep 11, 2026 at 08:17:29AM +0200, Manivannan Sadhasivam wrote:
>>> On Tue, Sep 08, 2026 at 06:00:30PM -0500, Bjorn Helgaas wrote:
>>>> On Wed, Aug 19, 2026 at 11:36:54PM -0700, Qiang Yu wrote:
>>>>> After a PCIe link goes down, software may still access the BAR
>>>>> (MMIO) space or configuration space of devices behind that link
>>>>> before recovery has run. As the link is down, these accesses
>>>>> never complete, resulting in a storm of Completion Timeout AERs.
>>>>
>>>> What is special about qcom here?  It seems like the Completion
>>>> Timeouts and AER interrupts should happen with every PCIe
>>>> controller.
>>>
>>> The special behavior which is common across many (not all) ARM SoCs
>>> is that they don't synthesize all-one response for completion
>>> timeouts, unlike RCs in x86 machines. Rather, they return AXI error
>>> response, resulting in CPU treating them as SError, in-addition to
>>> AER storm.
>>>
>>> Commit message missed mentioning SError though.
>>
>> I don't know how SError works, but this sounds like a pretty big open
>> issue with respect to RAS.  I don't think we want a kernel panic
>> because a device failed to respond to a config or MMIO access, e.g.,
>> if a card or Thunderbolt cable got unplugged.
>>
>>>> Is this mitigating an issue that will still happen on other
>>>> controllers and should be solved elsewhere, e.g., by changing the
>>>> software that accesses the BAR to look for the error responses it
>>>> gets when the Completion Timeout happens?
>>>
>>> That would be too late as we don't get a proper error response.
>>> That's why this patch is used.
>>>
>>>> The patch refers to the ECAM blocker (which I assume affects
>>>> config accesses) and doesn't mention MMIO.  Is the SLV_AXI stuff
>>>> for MMIO?
>>>
>>> ECAM blocker is a Qcom's custom implementation which prevents the
>>> config access to go out of the link and terminate the request
>>> properly. And yes, it doesn't affect MMIO like BAR.
>>
>> The commit log implies that the patch blocks both config and MMIO
>> accesses: "software may access MMIO or config space ... Use ECAM
>> blocker to drop these accesses."  If the ECAM blocker only affects
>> config accesses, we need to reword that description.
>>
> 
> This patch can block both config space and MMIO accesses.
To avoid confusion, can you rename APIs by replacing ecam by outbound
i.e.
qcom_pcie_init_ecam_blocker() as qcom_pcie_init_outboud_blocker() and
qcom_pcie_enable_ecam_blocker() as qcom_pcie_enable_outbound_blocker().

>> If this patch doesn't affect MMIO accesses, I assume they will still
>> fail and lead to SError?  I'm a little dubious about the utility of
>> this because I assume most runtime driver accesses will be to MMIO
>> space, not config space.
>>
>> I assume this is also racy: any config access that happens in the
>> window between the link going down and the ECAM blocker being enabled
>> will still fail and result in SError, right?
>>
> 
> Yes, there is a window between link going down and the ECAM blocker being
> enabled, this is why I mentioned this patch can *reduce* the completion
> timeout errors in commit msg.
> 
> - Qiang Yu
>>>> Assume the root port leads to a switch, and the switch has two
>>>> links to downstream devices.  If one of the switch downstream
>>>> links goes down, is this going to kill the device on the other
>>>> link that is still up?
>>>
>>> ECAM blocker is only enabled when the PCIe link to the Root Port
>>> goes down. We don't get LDn interrupt when the switch downstream
>>> link goes down. In that case, the switch should synthesize the error
>>> response if the CPU tries to access the unavailable device.
>>
>> For config or MMIO reads targeting a device below a switch, if the
>> link to the device is down, I think the switch will return an
>> Unsupported Request completion without data (PCIe r7.0, sec 2.3.1.1).
>>
>> The PCIe spec doesn't prescribe whether RC synthesizes data to
>> complete the read, but x86 RCs typically synthesize ~0 data.  I guess
>> some arm64 RCs assert SError instead of completing the read.
>>
>> IIUC, if the link from the RP goes down, we'll take the LDn interrupt,
>> enable ECAM blocker, and future config reads would return ~0.  But if
>> a link below a switch goes down, there's no LDn interrupt and it
>> sounds like future config reads would result in a UR Cpl and SError.
> 
Regards,
Mayank
