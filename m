Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2A364057
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701233; cv=none; b=hAokn1V9585FMVIuR6AtJYdtzLwDbzpFZOzOKlYe4LD3mRHmIAk3nUaLsGRTdaYNHSO6T9+zkqWYcn7OkDJLn0dhimpLO3Uu4QTGtuMShQIrRUMxL4MLJPLt70aNZ3JZCn7g6GdTMaJouhDJJhVcqOvHWe8+Dxv5I47Jgs0L6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701233; c=relaxed/simple;
	bh=n9Fc58azlTl88dGqttef7BVIdeXVIZctkw5Ln4SbTVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRGiLxbZtfV8ZfyQy5XyLytLDunj7ousWO5RJ+nmUFTmtmsqXqkuednxkknRZkEJp/fnmIQQCenZKQ8FN8x8y6ND8q1x3ZIJZOmcfliKZgdkJ9IYwPQ7OV73KYXU0aSYJufjfXURBmPsyOtcqS1SYel/6gFOgtpsom77/pVEoio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P52m3yX2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MNfM07+8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P52m3yX2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MNfM07+8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BkB0628696
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 09:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AiHEjSZAG4Mqfi9SoOwsJ/RPKZBaqWBE4m83Wyn/ybs=; b=P52m3yX2Xvq1ovMd
	xX2lLqrEVfvXZxZEGlfrwt6OtPMkLFtUDIsBR16e3VWXHw5TLGVjwnTL68Z762pH
	izetg/Gt6qaRXjyqXJOfWo5879w4oIVdfyzYle6x9AVbkG//Ik58BhtWYG1Hdj9m
	U4MAOWixwsi03L/GSb2HqojNaKFtoWvWx7LQYMZJb/kRQI0n8RNa9H7JHRexKD6b
	FE+J0ZFRiefZwnDLtpwwkeaVNiQBcuv+Ht51UJ/g4sa+JlUTsq3g4TdRrvS54J/V
	pkISgqbpekr2i72GIzfISCzcjuw+vDabMAyHzdI8cLiuy1MJrBplrMMYC490iEFd
	7DUy/w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m2kpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 09:00:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8273965546bso18231387b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 01:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772701230; x=1773306030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiHEjSZAG4Mqfi9SoOwsJ/RPKZBaqWBE4m83Wyn/ybs=;
        b=MNfM07+8Vp0r11qFbjBJ+RX83Mm29OQYJACMfSJTOGeuDJ5RaRzgGaGTdMFEWjSCMc
         zpF2jgjWdvzxEnDV3RdYj7J/7IM3HxnNRI3C2jMIvBKSpr3O2dkqv6hAZY5Pt8Hsl79M
         yFXtCz061gzuiLj1LhexEHcvp4Mgbzuj2wA+Utw9dJkMaPB94U4pBHD8ZZAhqfUgLmOW
         s217VllgSENVCXV114w4hLSs71V+8bEdkiG+e41ZwEPtMqZa/91I2mved6RhjZw/8rVa
         z5GSps35YiTKpjHBjhv2U8pg1jS8jqE1e0fS/V4426DCcrNm+7pC+HEcTQjpfrlyb2ma
         fOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772701230; x=1773306030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiHEjSZAG4Mqfi9SoOwsJ/RPKZBaqWBE4m83Wyn/ybs=;
        b=Rpvy67j4RBnZlFoRtUoQYYulxv8X19YXlOg8XIfBBflDWoHQH9IG3571AC5dNmGZVT
         u7Oxt4nDFhDWpVAYF+DEhU9lr3hPSMk21n9gTxglr+mb+rW2YwddCtDstvb0x5YW4uG9
         CQUbezyT7vc+S3Id8LzbFnillqeRqps/Pdx1+7rPePNXOMbJtrTPDbeb8HFmO54ZWzPz
         RDdiSYcYpyX5AblAWdd8T1PzzjJKIx6Guxw5woPz6f9eFp+qoOfKDIH3ofp5U0lV2PIe
         +ixI/Jy7sPt3gTgqGyrn4bK726ypE8HSjVawfAzOAUWZeFA59z6vyFOOhMrluiWvVSGl
         DXuA==
X-Forwarded-Encrypted: i=1; AJvYcCXYhmKACMoa67e+03QJFLJeZGa0YZ4KgaHmiy6+4GT1Hfe3uXQSGM7uUmIBOCzsl/dfizhbrkWaVj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2f8yU9UmPo9S69ObQnRMu4LQBZNRcRfAsfu0KyTzp83qEyy4R
	8mrx/MoX/ykmwB9zAlf7jYXksQR/KMeqAUgkGXxZDUrHOKLxAqzpaM3LN4OqJTQQwVK4w1erphL
	pcQQSlY5IzUTRqqwTbjVPuNrb8sZQLIn17U+Miw8STxfk09G7ck/+oW6hBBz79Co=
X-Gm-Gg: ATEYQzzaCRyxXkOiSl+1cxqZRX8zlFay/fOv+TTojUV98zNt25j1Q4bJh9aWGhTDkqK
	tPP/zdrTlTUpMZO+FtPIQFi9i5Mr6Qg0TvVWyG5n7RZ1rXUASFiqPWv8tsLNYnzZlMX5TlsdApJ
	c9oW2eceiHbhH2YCTRebkVaao7wa0DRrfL0iw/LwqKgmG9XQkvMNZO45zDgh6AyzlZebrvhnaNc
	p9XFMiLaei4aGBoKjeqIJPt6EQSJpbgtYQtmmJlbxbpx2Qb1uehbuJD42Zn0ZJoX3jdJhYWtBkD
	xrFw97YF5ZE5QOQsUqmqEFdsUJi/CoA5obyRXO3AtPH7hI+ArPGu8las2tZ3/Wa86pAxwWmcPLH
	sAX+pSh1PChtRr1aj68PEzPyI6aptdMolbgdgCjzELi+X9W6KyIqxFg==
X-Received: by 2002:a05:6a00:1ca2:b0:81f:5f49:6913 with SMTP id d2e1a72fcca58-82972c326aemr4406786b3a.30.1772701230245;
        Thu, 05 Mar 2026 01:00:30 -0800 (PST)
X-Received: by 2002:a05:6a00:1ca2:b0:81f:5f49:6913 with SMTP id d2e1a72fcca58-82972c326aemr4406402b3a.30.1772701224928;
        Thu, 05 Mar 2026 01:00:24 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297ef26eb1sm2222701b3a.49.2026.03.05.01.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:00:24 -0800 (PST)
Message-ID: <c0cb73d6-262e-4529-8b07-4c545c76015b@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 14:30:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] PCI: qcom: Add D3cold support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
 <20260217-d3cold-v2-5-89b322864043@oss.qualcomm.com>
 <om6t5hlnxadpmet5i2gochjmfjw6mdfllrdbgewiz4u6vj3zot@nse5rbl3je64>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <om6t5hlnxadpmet5i2gochjmfjw6mdfllrdbgewiz4u6vj3zot@nse5rbl3je64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a9462f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=cbGetAF2pF-RjulI4vsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: xu_xKSn8zWhxyK23gNuESDcl-c6r11Z7
X-Proofpoint-GUID: xu_xKSn8zWhxyK23gNuESDcl-c6r11Z7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3MSBTYWx0ZWRfXzf0OinNyrusI
 lEBdV8nqOSp4bOY+77W764VwmgiRj3C/lPaGcYAGXy8//QQ9b+AmGpGqRxzQ93u4e5YJA8Xbz2O
 kqZVxU9fHGQcdR4DrweW6YyCamf+qww9aeVJn7hmn3Mitr1skU3+J6FbFW9xkw5PJUPwb4OgqUO
 xqd5ier+mmiSvOcd8VWHIE5cWUK7j6DrnJUHsAOO2ksB6PfQkDwoHbPQZ6q91QP9xxQkEu5zcpQ
 0VoOpMdRmWAoG9eUUDJY6sygIMiBDShThAni5F6MH04nujlbLx41yWx/dkomTS8q1jSygVHYpyp
 S+1O7IQ3HcrrTd1dUjClFHETlp8zABJTO+HHlKSlURZYtJ0yjPDIEhvma/Oo3KZTnFIs3zIKNt0
 BWBO2WEXlSDG/ShAaSVWDsFfzodN8LWu5MANmppsT2vBELRuSOllXj0demDm/BzXh2ij/PVdzMu
 UT/A04SV9fpYjpdQxEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050071



On 3/5/2026 1:28 PM, Manivannan Sadhasivam wrote:
> On Tue, Feb 17, 2026 at 04:49:10PM +0530, Krishna Chaitanya Chundru wrote:
>> Add support for transitioning Qcom PCIe controllers into D3cold by
> You cannot transition a 'PCIe controller' to D3Cold state, but only the
> endpoints and bridges.
>
>> integrating with the DWC core suspend/resume helpers.
>>
>> Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
>> into the DWC host operations so the controller follows the standard
>> PME_TurnOff-based power-down sequence before entering D3cold.
>>
>> When the link is suspended into D3cold, fully tear down interconnect
> You cannot suspend a link into D3Cold. Link and D-State are different.
>
>> bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
>> by keeping the required interconnect and OPP votes.
>>
>> Drop the qcom_pcie::suspended flag and rely on the existing
>> dw_pcie::suspended state, which now drives both the power-management
>> flow and the interconnect/OPP handling.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 121 ++++++++++++++++++++-------------
>>   1 file changed, 74 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index b02c19bbdf2ea5db252c2a0281a569bb3a0cc497..37442bbe588c36b0b0414cc4d0016da2d8424a87 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -145,6 +145,7 @@
> [...]
>
>> -	if (pcie->suspended) {
>> -		ret = qcom_pcie_host_init(&pcie->pci->pp);
>> -		if (ret)
>> -			return ret;
>> +		ret = icc_enable(pcie->icc_mem);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable PCIe-MEM interconnect path: %d\n", ret);
>> +			goto disable_icc_cpu;
>> +		}
>>   
>> -		pcie->suspended = false;
>> +		/*
>> +		 * Ignore -ETIMEDOUT here since it is expected when no endpoint is
>> +		 * connected to the PCIe link.
>> +		 */
>> +		ret = dw_pcie_resume_noirq(pcie->pci);
>> +		if (ret && (ret != -ETIMEDOUT))
> No, dw_pcie_resume_noirq() was reworked to return -ETIMEDOUT to indicate a hard
> failure. If the device is not found, it will return -ENODEV. So you should
> fail the resume if -ETIMEDOUT is returned.
Ack, didn't noticed the reworked changes, I will change -ETIMEDOUT to 
-ENODEV.

- Krishna Chaitanya.
> - Mani
>

