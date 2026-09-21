Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F549158F
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991250; cv=none; b=tghRgz0VTq7cWPMlQSt/4JeDyS39vSByZPZZtuTEKp3OYig3tOBdl0thKSPNlz28ztyQMHmO7ZKGWjtWfGjRUAw2Cj25+Rru5v5F0sZA9ivk6oR60OUOsQVZGEKzeQgsWC1LUoT5OzGn8M4ytIHfii0ru/tIuRrP+hYxHsVQOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991250; c=relaxed/simple;
	bh=Sn0T63nqhFuSkZdG0v0MjVbPWlaRxlBwArBNEJBe3Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RskVsJ4sH9nKlVLx7Iposr5JjVgQVxuf9O34MqsoAHlNdFEeq/WwXTiLZR5ab3HCHNQTuY0n0jVtS/uqxnMSmjJKWkLp/6GS3/pGRUbHv/9/4vFIAIGX0GLa3dpvaH2jGY0+rJE4nxlLos9Rhw6Neb5cwtwGDnivuLVOQrXa7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nk2AcKEf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X7bU2jVv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nk2AcKEf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X7bU2jVv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAe0nZ1414001
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 11:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZabR1KgkTaq/oLkvUVfPFd/w3RYLNtDhicHspvb9XLs=; b=Nk2AcKEfILidBL4Q
	5iYLAyTrfORZCGhioCcHsj54T0vMwFTb49Mm9g2Bwbc/pishje16+jHRPN72rXgW
	OucXbH3W0bcIyExcF1VUntZbIuT5SSZaG5y+Arvf5sneIbfAhBXHeTBT2wwCnyc1
	6Fj2dDUyXuWo+T1x/i29BxHLYqaxUundn1snWkMgC5DUZjivp3rMw3WnwQpoEbVv
	IpC3nT2zAG9vBa/HHwk+5I5TqZrwDvQAKqkIw3ntMTGwxdoOIraHi0wjOdpfEfMr
	6VawLVJTar1T/4RDUTozcDrlB0o7ekjzDFA4BFlG8Ckgcds3JnCDKoi/Hb3T/PNz
	k47XbQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d123q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 11:47:27 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c9b931e06fso98919e0c.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789991245; x=1790596045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZabR1KgkTaq/oLkvUVfPFd/w3RYLNtDhicHspvb9XLs=;
        b=X7bU2jVvkHB7R+0CiVf+VqD/K18zjICc86SuuatbBsEPEoBaRUN35s8cmzdtFlGijy
         Yn81xgFKQVa1I+uYBD1ipdH3sEFeBt/oaZM/1wHVhKO9bsr2c0QaDPx2k0UF6YqqOpe+
         0uCdSD8mfu4EYUcfGPyw+Fg2Ry3ExZDi058YBss+5TR8YxrWfKGBCjhhbiaS1zsp26xa
         8L8uxEboJNk2Py3Mqo96ZTusFiqdJMoxA1vYPdzcxr1aWR0WMj+FGf/C1h2bumgo6aab
         eBakGxyARM2oSKzrKCJ6xafMgJhQPhVRNVWVP4WGX+8PAT2OCZ9ENBLeEOvtUoVRcAPr
         XD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991245; x=1790596045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZabR1KgkTaq/oLkvUVfPFd/w3RYLNtDhicHspvb9XLs=;
        b=PdI2IzN5m09BUEcTGE0MgD+t28UaEs8zTuJzGcQE4pPNbZQhY1BO97u+WSDMuZGy2r
         vNR1X0Hb4R3mrvegtE2UOpzV4hBLjSZcVRb6eucT49Kv7lhcGlbAmVDNI5zibqbbbnhL
         fRiiWIsnQiksgFPa5oSnNruU99dCZ2yTXUof9Zw8pZnLrBGE39wFnm8QyrIu7vbxs4aG
         ye1Z2Os4+quD+ipyvRp40sZCbHezM01vpw2+LmJNBNoXAzacK5gTuNIT04ltMuf1mbI/
         +An/YHZbNzcPjWYJIj15KWl/L6OdRH6sJLX6E5m75OvgoymFPaVwHwInIgqnQfRSXsYc
         d63Q==
X-Gm-Message-State: AFuF++k5BqodA1DiBI+/CpGiUi8rsxWlhnkR101vuoEH7uw0C3HXNbxf
	UzIBCCBss/qRYzVPfJqGJX3wOKJm+wcg48syuae/0PPx/wXRXQkLPxBqiTNVUy0WXuaACm/NfGX
	HF2exTf9aSLinf7ia4SU3Yuw9nzoJeLR6myeEMF7Pp7v1Fan7BqzmuyAcmiw+Fzg=
X-Gm-Gg: AYBFou0ShWtwo7DbGpyG6LTCSTBs2u1Z8XG+/DP1/KvP/xk2gI2tfPXjhI10nriuJlh
	Mn+dmP+Idi6vj3iNvKNpkT79E2oYRAB37QpL2PIRLLwtWm2j+JOJYwGeqQE6tynS8iZWo0xdLKq
	eF6ADXXT9h57aoO9w98UOjk5Dn5oaGFGQVxZNPU07v+FgT3jiuzBomocD70+SiuSnGjuEOUB9ad
	DfHpb71NYJO0eBFdNA2DL9/3Bx/D+nyG4CXamlfkdFrj651dPlaFi36FRuMk7hYtZJo3d0lpzw5
	fpsDMj3AjHQ0ZhfvBEkRbLQfNXvxWTwycMvP+0o0kxCDLRFP2LGk83RoQuXsgI/Ixn6jqRfkFeI
	Mif9Xvj6PeAhhL4LRrv6WdA==
X-Received: by 2002:a05:6102:b13:b0:7a9:b6d8:8214 with SMTP id ada2fe7eead31-7a9b6d88352mr358271137.1.1789991244651;
        Mon, 21 Sep 2026 04:47:24 -0700 (PDT)
X-Received: by 2002:a05:6102:b13:b0:7a9:b6d8:8214 with SMTP id ada2fe7eead31-7a9b6d88352mr358258137.1.1789991244248;
        Mon, 21 Sep 2026 04:47:24 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3590afccsm292838666b.62.2026.09.21.04.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:47:23 -0700 (PDT)
Message-ID: <b7753168-fe2f-49a8-8b8c-8137ae2a6eea@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: qcom: Implement shutdown() callback
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com>
 <562fd574-a798-4b57-98fd-dc8e7c09f7f0@oss.qualcomm.com>
 <468f4ca4-e52e-48b3-bd60-20cadf7f311e@oss.qualcomm.com>
 <80f626f9-8a0d-49cb-a592-14195900e997@oss.qualcomm.com>
 <8293c4b5-948c-4859-b63e-835ec35ea90d@oss.qualcomm.com>
 <tvtjjnysk6cluqrwoseyssjpp6fla3qjvkndxbsw3wqqed6e34@74tuwpzgss7j>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <tvtjjnysk6cluqrwoseyssjpp6fla3qjvkndxbsw3wqqed6e34@74tuwpzgss7j>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OxSqZbZ8w6BMIks2jaV--sT5BRUfrKbb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3MCBTYWx0ZWRfX3/vQriSh4BHA
 0/BhYXs1xnDaint9FX4GEcAh1cYMkZA2Hccaa6kXooui5Ed8+ppqD0hHqP+UL1vwcsWXmc9+p/U
 kJTKjicGTj6uIy6vGAQ7Pehd6ji7R10=
X-Proofpoint-GUID: OxSqZbZ8w6BMIks2jaV--sT5BRUfrKbb
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab1194f cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=0dWPBfdzqdCcFQS_4usA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3MCBTYWx0ZWRfXwZavsdzBFJlX
 TW3S4VNGA/1xOn/8Hu1zWnP2Sv1OkDa33sDivu96J81FUhostKRXc8KaCZQ2LRHwzT9jtdFTXb/
 9AzOXh8DvK8jfM+R7pC7/fzlErn2kBXK5UNnG069A7sUwXbUwISAClrckfiN0qDxIX+fzNsJ72G
 NyJA27+Xd/koJ+LEagIe2ixo/NQwKUqi+yz5dxRjyXcFYz9EqOYsvKk54WdwwyOCODjavXkoSvz
 GoArAVOpg1QC7ZjPijX8ymTRXHG7bivDHUiQcUdwTY1xLhC9TZ0qFvNjFofMzZE4pA1eKe60zXX
 Srq5CKBTmPAyXTM/N3vUhzqwaYJ5I5Woaua3KkEW+t5Fx4TGRjAFO4tA2Km0knjjAJWB5kMUsA+
 Ygw7dMzeRwk7sEGmQuuEQy3S87dLRLn4OF8vitoEZYsz1qattFzBXNG1pP06E0C2yocTLJBNVx6
 Hwl9TirCnZNqgAtN8Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210170

On 9/11/26 8:00 AM, Manivannan Sadhasivam wrote:
> On Thu, Sep 10, 2026 at 08:56:38AM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 9/9/2026 6:48 PM, Konrad Dybcio wrote:
>>> On 9/9/26 2:40 PM, Krishna Chaitanya Chundru wrote:

[...]

>>>>>> +static void qcom_pcie_shutdown(struct platform_device *pdev)
>>>>>> +{
>>>>>> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
>>>>>> +	struct qcom_pcie *pcie;
>>>>>> +	struct dw_pcie *pci;
>>>>>> +
>>>>>> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
>>>>>> +		/*
>>>>>> +		 * Firmware owns the link teardown and clock/PHY shutdown in
>>>>>> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
>>>>>> +		 * still need to be masked off before shutdown proceeds.
>>>>>> +		 */
>>>>>> +		pci = platform_get_drvdata(pdev);
>>>>>> +	} else {
>>>>>> +		pcie = platform_get_drvdata(pdev);
>>>>> This is no less than an intriguing choice.. please store the same
>>>>> element in both cases so we don't have to do this
>>>> for firmware_managed solutions struct qcom_pcie *pcie is not being
>>>> used/allocated at all. it will waste of memory if we allocate memory for just
>>>> this use case. - Krishna Chaitanya.
>>> Should we move it to a separate file/driver then, perhaps?
>>> We could share the ECAM ops in e.g. pcie-qcom-common.c
>> I will let Mani to comment on this.
>>
> 
> pcie-qcom-common.c is only for sharing common code between RC and EP controller
> drivers. So it doesn't make sense to move ECAM ops which is just RC specific to
> the common driver.

Right, I'm not insisting on pcie-qcom-common.c specifically. I'm thinking
that the fw-managed RC could reasonably live in its own file though, since
it's more or less only additive on top of the ""normal"" QC PCIe driver
and being mindful of both when altering the logic is/will be a headache

Konrad
