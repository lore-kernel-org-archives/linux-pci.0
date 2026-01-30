Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516C242D6C
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772072; cv=none; b=fV5cxTl9xpjwIJ9x2dFKhX5rIoWnDnS0DR63NBwDwEP43z+g2R1FfJWtcoY9hfz6U9AMK8FVvF81SI+VUZP2rxXdwNQOq21xkJSv5hi+9FgMGjGDi9QCoIlIab0GXVNMYKVPV7PQ4KRh73g4hNv9WBE45hw3B+cc7dQZeYiUe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772072; c=relaxed/simple;
	bh=8XTGJt0WxjfvBTMsvs1ASjI5pNp+pYhASDar5eWdgi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0E1tP2wsYFkamflPgo1LPE80FNGfkT9qN/6ix/AYw6msUtnqTmDjFMNFd8SwsKxq1FobJuH7RSjcPcF4F26Y7JyLDgVFmGqvBAy/IZtdBR3vbgLhQRG3o2G1ldT1+VinY2blnZzbY/PTab+2Zw4QqpfAgYSgq30XOjhzWJY4sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eeLkMX0i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NPlzy6Fh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeLkMX0i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NPlzy6Fh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U4bKdJ1485236
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 11:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbcTK2WZjfHEQQ39q4AXBDKxCctb3txQ5lG0R1mMthE=; b=eeLkMX0iElqJMZIv
	JKwPktQIB4bgh2Vu2+TDkrpF5y42WfD2KBx+fXCvECzkxBO4DvfLR3AMrXqNBw2Z
	MEbxZbW9zvBDIXYc7sdEPumuqoQwfLMmx5qssdu14N7bSKqbeBfZ0KPL867hhzcG
	PBR1plwIhUnLt/QBcWnB2gcd7M59r+ItWKcdOTZKHCvllniem9vE9hfQ1ywDuTo/
	kyi8J6ky9mwsJK0cpP7VtPTVCVUbj0W7j/GlViwHTGE6JHAWtUdY6wDggEFkMuXT
	s33CkGpcHpk+M+P7At3DIjbA/jm9g2VgIRz2jj+7GJIWsbDdKbrM2s9da9ZT2ePV
	eJmU+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0nsf958b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 11:21:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a182d4e1so38817685a.0
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 03:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769772067; x=1770376867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbcTK2WZjfHEQQ39q4AXBDKxCctb3txQ5lG0R1mMthE=;
        b=NPlzy6FhLtISATgIfeQHls89cJKNS3QTz+jXJnq1e7H5Zvz1IBRu7yTZVeK1yILFpk
         5NERLa+L9grM9zzGXR5ouBAfllpOQXLrsOoHv16Mvyb6VcBPkgx/+wz4BxUR2c2UVdi9
         dEIzCsUGvak2dDPqJc3IHI0Uu950zDEPyIqAOIIhvxeb8MNqJuy3KlW6T3XSZMyNync7
         +JHtGQewHXxbSxmLqX8QuvKlc4OKaPWwRbLMn3gV896+wGau1vQBu/T8QyHM2eg0tlpo
         przznKML9qdH1F5aTKtvg9iklJU1rxdkumdCEp59aogn+OEeZV8EnA/olWZTtzwxkKF/
         Lf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772067; x=1770376867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbcTK2WZjfHEQQ39q4AXBDKxCctb3txQ5lG0R1mMthE=;
        b=nUnVpnw4k42v1RzkFffnfyWleY3ZfnFGtcfegP9aHvuF9kdl73mZX7zZHiBO0Xw5So
         uga5V5FiU92W6OPeLBlZ6nXtT0lI726fj20Hqi/SMeFJAXPT4OlD50A9bqeoKPDTz+Qr
         d1qO6ErSOQfVt2+7QHktafnSiQJOVWNMUPpW6ez3Z08ZVfFMIVVqc4UDR9pnLkKeGf3H
         LiYn0Z0liIl6xiRsyNUqdftU6zYgDUuiokoGDSQ8dIrnuj26CK2WLwGqWSPSdTD+IUz3
         I7wsNy/9MiXLFtfRWPsvwisNGlucLl2snjZkucSRvA+I4KmE4mt4tKWxdIZ1CNShGmCH
         3J5Q==
X-Gm-Message-State: AOJu0YxNz2dxMzuDtVSfNkBp2AcdfPmSWFgtmSHeVeQx0jSletYMJt3l
	ku1t38o1l88nPx6xETsOeHD/rrolI0nsgN3mpzg/Ck5if8Rr9ZozQn1J6oMXL+bCXfl33P+pbF+
	Go0B/ED7MrBIlxkXIXqxh3ePyzCtN/J9Y6/M290qf3kPhY6VdocY+MAcQLZLUlI8=
X-Gm-Gg: AZuq6aJ5tG/7WZ/50E4l/jlhv9YeWMtuFrHLEfmNv0gV0Q+yyTsyql1ZSPvQi493en2
	GDZw4v2kKw6PLRWOU7+JUiVxO74xV8XNwj2BVYvfaxAXiHB3wj4HIzi+HGzDGTjRi3URveP4Lof
	p8DvwBdVaWqog+NBIR96w1LC1REhf6gZznYJ4iFWItCCxWO8Ir314FlK6yayTYMvdMvSJAFu8Yr
	JasUYcQ67tQwd9hWxYPWyYu0//NOVz2GiPnzJIPWNmTxvoEA2tSa6chNuBW8p1Mb9FAzmOSB1y5
	WOsU8EQ4TiLokpDO7iDo0Zd/2emadUGXgbkIvdICIU2sLWxvxdEZNVsp098/8s76nv8iDG950xo
	lmwavNWgJwCAUEOpM+RapsNO/Ep6jV9lcuX4qO1GJl56tOszbW5QUIlMSSNy2Un7z/QA=
X-Received: by 2002:a05:620a:4441:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c9eb312fd8mr274268585a.9.1769772067179;
        Fri, 30 Jan 2026 03:21:07 -0800 (PST)
X-Received: by 2002:a05:620a:4441:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c9eb312fd8mr274267185a.9.1769772066697;
        Fri, 30 Jan 2026 03:21:06 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8df8465cb5sm137854166b.40.2026.01.30.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 03:21:06 -0800 (PST)
Message-ID: <7e61575a-3e0f-491d-ae22-89ab8bb21c91@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 12:21:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: qcom: Add D3cold support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com
References: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
 <20260128-d3cold-v1-3-dd8f3f0ce824@oss.qualcomm.com>
 <63531057-ea7c-4a87-9848-04e502bffc32@oss.qualcomm.com>
 <45e1c870-f155-4943-990d-5e75a1e8b998@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <45e1c870-f155-4943-990d-5e75a1e8b998@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LNHzqVLHw0vRKQDCh6lT6uOOqexTXVZ2
X-Authority-Analysis: v=2.4 cv=EvjfbCcA c=1 sm=1 tr=0 ts=697c9424 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=M7nLEK1OKNC5V3jzK1UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: LNHzqVLHw0vRKQDCh6lT6uOOqexTXVZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5MiBTYWx0ZWRfX6x/2ZqkODnKN
 Z943bmz1cvnb00ti4xIm1YiiOlUEcEHvWQLkVLRJ8vfL5HCWnqWCpeZE/SO6yJZ7KU63byeu6/t
 7e1BMlgv8AJPqfX9RpRnH2ytUcrbwRjSgGS4aKSwCJS9HMDeEVV8FvMq+9m1CKYG1AfQ54e24VH
 2DbMsSlbJnje9ZGdYdwCePVyKeduO5AHtx9SxhipIMPtsTMW3fVrhg5RTBfPiecUmv7pGNTA9Uv
 6PmGgzZwXHruLsh54ZdUrBSKyYfqDIOWqfGyzS8R+DdMUksTHEmF6E3l9ph3fTJ/5+4lEdiUfgS
 ksSyrIu0bTBDebcpy7ot5CyO/kKrwg9q6cwU2Z4Y5zheL1CifjoTEQaOm9A8MzhHhGK8DLLQQiE
 Iwr6uL7TCaOJPXpb/0c5T1mG598d3Za+4cecDd4A0Tq0ze08cnpS+5MZnKtJASIRni0fn6HMFsx
 D4oMqnMS0mNCOo5DGVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300092

On 1/29/26 6:27 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/28/2026 5:58 PM, Konrad Dybcio wrote:
>> On 1/28/26 12:40 PM, Krishna Chaitanya Chundru wrote:
>>> Add pme_turn_off() support and use DWC common suspend resume methods
>>> for device D3cold entry & exit. If the device is not kept in D3cold
>>> use existing methods like keeping icc votes, opp votes etc.. intact.
>>>
>>> In qcom_pcie_deinit_2_7_0(), explicitly disable PCIe clocks and resets
>>> in the controller.
>>>
>>> Remove suspended flag from qcom_pcie structure as it is no longer needed.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>> [...]
>>
>>> +        /*
>>> +         * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
>>> +         * Because on some platforms, DBI access can happen very late during the
>>> +         * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
>>> +         * error.
>>> +         */
>> I think someone internally once tracked down what that access was
> As per last debug which I have done few years back we see access coming IRQ driver to mask the interrupts
> as part of disabling non boot CPU's.
>> Can we fix that instead?
> The only proper fix is to keep device in D3cold which this patch is doing. if some client drivers like NVMe
> doesn't want to go D3cold we need to honor it, but Mani is working on it to allow NVMe drivers to go to D3cold.

That doesn't sound right - if there's an unclocked access, we should
either ensure that the PCIe controller is online for that write, or skip
the write if it's not possible for $reasons

Konrad
