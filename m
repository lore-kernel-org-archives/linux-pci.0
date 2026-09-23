Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68F4A3407
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166652; cv=none; b=n70ZQhVs3ArauL/Km6eZhstNQgTw6Sz8gSUxU1xbpOJ3zTxBqhdizboD0q+Lqw8Is1IivCgFDBaOMYfI/lWG6uFA1mNxub2j7cdOu7201kH0XlXTa+yymlH6tPtTL5BTAiU16Q5OX+5bssPy9zbe7lvFbgXhOmHQ/qXI47VaVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166652; c=relaxed/simple;
	bh=P2KMjpECG8nbDMf/4txi0vvfgQ4Eaw95S46ULcI2wFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQDdwZrFHBUaOWiVOP3ZTvrOz82i7Le0hg7xALXOXBRrDq+aqngC7ucZXYzhgsBeVq8nLGHAsIRmmEAc/pFFVCfzn3/yaOVETflpnOmvsQ+pwjWNcgy7KIVDgmnctuCJci10Xstjig+uhHD2ttegt9mpNToAaccexULOygGmCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=URbtABXv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gfQrf2aK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="URbtABXv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gfQrf2aK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbY4T3295670
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P2KMjpECG8nbDMf/4txi0vvfgQ4Eaw95S46ULcI2wFM=; b=URbtABXvmexx3sbp
	0Iq8Qy7UnglB1B1wqM08d+rIFKiY/wGdbmVLlMafKrfnaaR103Mx0gVDYPhatMGY
	LAtfStdAycxXjyqnMTkjUgZq+1KUiJkfnAFPJh5PI7fiGW7fld8OXsVELQze2HLE
	T5DLSPQMek4d2AW4JLxccKdoClCBgWGZYrW+Kkjnj+YJDrupl/EeA48rRZ5TSz9e
	iHzg50j+Q8+QPRFzbUVr4M7BEyvIr1qrlVtW9lFn5ODzjBt72CZ9Z7saMZIrqp5G
	DjOahZ/LyT0VZ+7oWmViwHt9i80mREtW9PocNnUvVdZknwKVQIQBKFyXEvJ5roEK
	HIUipg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm8suh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:30:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db87f759c5so8489595ad.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790166649; x=1790771449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2KMjpECG8nbDMf/4txi0vvfgQ4Eaw95S46ULcI2wFM=;
        b=gfQrf2aKR3kDN5r2KnnbeqLYm5S8FTpB2VeBr1gamyolpjUeeUuC0WsVlexrWCiYFe
         zrmfsg9YXJ7nm53MrD/QlxvGtVQjQBKjA/W8tY9Lf47ohevnxQHfw8YueVlMdP0LsTlp
         dhf/cn9oRPJMvaxD/JTqrGtXbOF+JVrggM8AcEBe5TS92UefbyZhDdxeN38ih53NiNCZ
         tkrsrMPueUBxAXsNwaa/efplHhMSMqRkE8EelAx45cuQ4z16y3qMmcHHiXuRC6NxzWu1
         QMAeD4fZna43PSP4fHoqnKnP7C9/Ck9JE2Lkq2dXIkrYJkiXYdyFhkNZ8xEfySJSHZ7w
         616w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166649; x=1790771449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2KMjpECG8nbDMf/4txi0vvfgQ4Eaw95S46ULcI2wFM=;
        b=hdSCOAafu/rmODOyEoJkT1jExqgItzarVxoCepyvhQpy8uwQ0t/rsS3qYcFxNorLDd
         XgK29BRM8dKe3xU7DZfAguV7H+xvtKZ5sx8jQGYTm36HtjOr54ag9MRiG22IQfYMJlL5
         aHi/8x8RF/2ea3syXwlIRiWuoiMpUdpnqfXs0Gg9AoGt0y6UDa0boFiwtw2jhclaMeNW
         icqX5RxwA8pGuf9YKAAnZbS9lNVtRCpQo/soIk9oQFjO0zCIqnAQW2obqHBNJwTpLLmS
         WYDxv7mHZ4snSgnL+5ywhhia89Moh528UIALpPxu3d6iQuY8ceOr1ghYPOvagkeuaeMy
         W7Ag==
X-Forwarded-Encrypted: i=1; AKwUvByxGxRmbCHzNx7rXY9tCVaAEbWerL5G2uO/ExxKzWp8mucGwp2PT5FiQjWMRVjkX+E6ER7Zk3FpYho=@vger.kernel.org
X-Gm-Message-State: AFuF++mEkmzCR8/RO7jEIn64/O26Ow8xJgEtA/5rdOvkZOZ1ex8msmcQ
	ogVZBuz1P3OirkC4u9PfYUQkbS6vYJKBg8u2x7r/+EptiterMbKwA32h0rtsftz/DocHxziwVsu
	UJSScMH+B6tzKfB5ElWhZI4c0YGW5drbYUZR8ZcfNXirqx2bTMl4JsjuQYl2C86I=
X-Gm-Gg: AYBFou1ksr6f28PVASCBwJf/7sLG3z+WGxXTLMkFsaYWTGfk70WWpQ3gHidQFQpPZU1
	gFlm0x3ePdl3cau0gQa3q6TxYy9kWx01BDgJFqFdnllUMK2Au5xl+oU/Y4UKK6Vf3fOYFaMJuuP
	Os2PL2tikui7lsdXsjjU5gy3yzG8MV9XeXih2wT7gEvCmjU3mQYxOwW6k3csGAVdd95zf4SujXj
	1f95RgtIIkF1JnlCvhAjjui499x+xcxvEbIAlNqrIBbv39b9hqUG+WmVKyTYI9C51Pgjme71ymI
	ZuBIrQhFrLP369Wr5ha04q32Xqx2zmxbay1BUQNLeRFph+gyTbbtMvgURkWJYGy2Le6O+f4292W
	Obr/Ne9OcQG9cw+QBj8rZczkwelt7De2y
X-Received: by 2002:a17:903:46c7:b0:2dd:ad74:6d12 with SMTP id d9443c01a7336-2df69d6bb3amr23165195ad.24.1790166649066;
        Wed, 23 Sep 2026 05:30:49 -0700 (PDT)
X-Received: by 2002:a17:903:46c7:b0:2dd:ad74:6d12 with SMTP id d9443c01a7336-2df69d6bb3amr23164885ad.24.1790166648501;
        Wed, 23 Sep 2026 05:30:48 -0700 (PDT)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a69f7sm9548575ad.16.2026.09.23.05.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 05:30:48 -0700 (PDT)
Message-ID: <91ef0d74-2168-4bf1-b390-98d3963db672@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 18:00:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] phy: qcom: qmp-pcie: Add endpoint PHY configuration
 for QCS8300
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-3-63c5282fb0db@oss.qualcomm.com>
 <07ad0b0e-f666-44f7-b5a2-bf9ad016b297@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <07ad0b0e-f666-44f7-b5a2-bf9ad016b297@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX+uuiyK6AcKK5
 bZOhc8V7fwOi0slpv1xJkwkX8eV9l3NoPg/ZdRjEM91wehc1ixDiY1x+kUDdOS4pzAbsDZ9mfIN
 pLlCmcrjWqQFaRm+wOEUeuc1IT/XR6k=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3c67a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Rbhxv05cawg-pCmlirwA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: nblCOslez2IQuqgSaGAxPXB4k_MPpkCP
X-Proofpoint-ORIG-GUID: nblCOslez2IQuqgSaGAxPXB4k_MPpkCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX0ru8kmEc9Adt
 HUoZJswP7lCvQvMEWnPJF+OCODlIWJT2Lhz9V1ZpIeoChG9gddmuJ2Vcn4emDhwp/ByS4+X3//P
 tuLtufcIaX5CvGpLuLYrmnEp/1hNkE2zhChmnLrM5rbsDXUERcn/DL94xXsK1pGNimOpkhrkg0V
 rH5vRKftHVQJ33e/9v1r0XCYOC3uvYb6Ay5M+/rsV0Jth0y9f0o5QrwvYVp+ZsiHY1eRWIYB3b+
 x+pugnHS4cLBzSPCSXzcoHZw+GW5Ju9qZFk6wF4ZvXsKtNg2RzIZqEaVcilja5j4F2OGemiVqb5
 0QSL6l5ows0Y6+cutTIIz7TNNC34qi+5m9rmJMoFn/pLwEALIsK1kXJdLvJv8E0DOwQY+X3Xv+E
 F8OZ5eQhg0oTw0WWZ5Q4faTOJ1LKB++Wg+RXaSu1jBlaOyfODvJ839mu5vlMqcpZgK+IMrHjM2J
 7zVZiNEmqJ0Ep7GY0Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230049



On 9/23/2026 5:49 PM, Konrad Dybcio wrote:
> On 9/21/26 12:58 PM, Krishna Chaitanya Chundru wrote:
>> Monaco supports PCIe Endpoint mode on both PCIe controllers. Reuse
>> the existing SA8775P Endpoint PHY programming for the 16 GT/s x2 PHY and
>> add a new 16 GT/s x4 Endpoint PHY configuration with the required RX
>> tuning parameters.
>>
>> This allows both Monaco PCIe controllers to operate reliably in
>> Endpoint mode.
> Does that also apply to lemans?
Lemans and monaco EP phy settings are differing.

- Krishna Chaitanya.
>
> Konrad

