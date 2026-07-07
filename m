Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F235F184
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402881; cv=none; b=jefjxUJhvAZfE78fvmzYed+xoHj7o/Vt5si4ya2gI1xCKcUVZfx5jVBu2H/+P/E0NZDH8FsI8aVILF9AtV1u9Rz40Gsrc2hiBa3Kwk9h0vvN49lICWZ8MSQfB3k0AIhxQBkdR6GqLYwErI3bPRNsbC4InyUNGxbKURyJdxHldec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402881; c=relaxed/simple;
	bh=lflEKyZ2GNpJuinbyFUPuuftqGQc8rX0sKQ4/Oimemk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oK96bPCfF+yqfeisSp8tTlVM7oSnGjMR5rsZCFnqjLNd7RELneEXaIwmvACi7HfVL85IO7JfTTyLPnhag6c3lfqCCpA8hUOUX06wXBXfZy2MRMxbWLFr8rbGYhvA9MA1PVOmzyfTL3Kh42YL5xjzGWAGuDcG9l8I49b9pvf77dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIBWH6C/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zfcg6zWU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIBWH6C/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zfcg6zWU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748gSS2585215
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lflEKyZ2GNpJuinbyFUPuuftqGQc8rX0sKQ4/Oimemk=; b=pIBWH6C/GRvvXGyK
	UUKYecCk/BmHWnvjJUWbpCrXeEV6AzYwfHLiD/JB5aCTOi99/Eyg818IG6T3R2FP
	jph2mKiIANbeN/NHviifXypy/T3ol9IJCF/k0UQezDxP8McA5FHoA8+sHRnMXBSZ
	DSQSPVzaLXvJG3VvKLHXaN7DaXUpyvC5o5dH8tcyZY1lMdCExYakJCs/knZd1TTn
	4ezS6YhRl1KMmmkwPbEEWbkj/HQVuJTvFH/XFOJZceOPxAo3lxZX2y3a0SogvRme
	OfpN+ylzzHLEYnj+m+vauhahORUeja6sJGN0XG8bX9g+RQAHCH5s6hL3VH6zRWSo
	aDuq5Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t158a7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:41:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38112fd8b48so4359541a91.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783402879; x=1784007679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lflEKyZ2GNpJuinbyFUPuuftqGQc8rX0sKQ4/Oimemk=;
        b=Zfcg6zWUKRzoQlefCZvmJ/aGKiYNse1E+mPF8aM+zEPioOBh4AmHAQ/x85LbYlX8F8
         mA4EuExwm50BLcmR0f5VPAYskRtPuF/aQqrDkb9Gr06vfMcUJUSE0EVLy5X9GMkSGxWD
         6N8Wyb3xQoYprdFy3f2wr5CwiktQI6G3AR1Z3UybRCBdj9A1ceggzy1swGh4E+WeqBJt
         Sd+IrRXr36gQpZmYn7mJi7y37EhYycRG9GSvaa2rOHRdSmgTS5d/AfRtgT5ehg6qC/f5
         XST2ZFyJCZCOWPrqtKANxTpdhDikOD6rkt9k/tSudk7WA9eLZk5oU/YCkmFlHvq9U6fz
         vOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402879; x=1784007679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lflEKyZ2GNpJuinbyFUPuuftqGQc8rX0sKQ4/Oimemk=;
        b=SrW13F2nLK+28LVI+LepfSupUD0eEYmlDWJt6cL2KdKAXsSz+UICTpFm/LxjxrWoi/
         vRftFruUO1NvNBEqLBTHHTViSse0lTcYciyNqHMqIZaPrJuLZ4Jaiy3gNeku3EBsLiIK
         tg+CLaz6hCisWCGf4qO9GuLpcUlEE0qhK635lzHi9zG5ZiEG/gu1ZbrvQK4EPMG+jG0V
         E8pOFTZcFeZRTn9G3FdOUQ1tyeAuFHQ8rBKOBF7ZARxFURaaNGwNJ0IGGPl7EyWIVUex
         1UUJ8hjw9R396duYtV7jVX52QLG5c1+N9VrJRWZdyn1mlkNXDfbcXjKeGQPS5ylsShsh
         ytXA==
X-Forwarded-Encrypted: i=1; AHgh+RqXC/k4S0Dtwfsq2rhtKEIDjKgbDBbkplAmhOkirwwd9GTzTPenYEVYR9Y/6TBWdrE2ktm+7CbJuFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/q90a0wwTjgIuxJczoKLN1LHOKRPrjovR2XGse+JF8Zc3wpB
	e6cqmkP//uW5uL4N3+mj+urwPOTr7Ftxkx7jEXB3i5xbliO1iLmitHAm2I2ru4SY7qso7+0YeTt
	gY6OS8u851tGSEf2bf4uDdIgDYuBbMej0qLki5sYcvbllNKocXJMXQ/mFzpfHHGk=
X-Gm-Gg: AfdE7ckRmC1bZgNHz5CmLKSaWg8sJ5yiVh2V97Pw7qZJy3gcSSdYQXmfM9rbm+nFpU/
	EsLIxaFeR51L8pFTDTBDdGvRn+ZOQn/vFMCGQpSgkO1tSEYjJ5L56nqaCs3xcQJDa4t9iDLSge+
	U/pID6V1csTkgBknQvcJ0+3h5o7R2UO1ZjgnsAUuBy0qBnfjCL4c81P87XZC+23PxkJSa7rwJRj
	cgO/guj6RuIzgN+TXGHEe7PazZEB30goo85f8qQwjZJ7k50MWSKiR1N/LEcSg7zWJrMxqNGn7pl
	sukSMV7+mz68KYJcnt4oSVB7ADnmxrb+A0vjfmfoZ8R2VPGBBfSZ355MFKzPtxtNpqdjQ6dqI4t
	6pPNrtNm3JqPdC3KzqK+/Sr260u+YZHA9dFeENYsLNAnpe6+rihDq2bwXR1uiSUeEwaqkqU5I+P
	WemYOQ
X-Received: by 2002:a17:90b:53c3:b0:37f:ce2e:32ea with SMTP id 98e67ed59e1d1-3875826180emr3950205a91.19.1783402878817;
        Mon, 06 Jul 2026 22:41:18 -0700 (PDT)
X-Received: by 2002:a17:90b:53c3:b0:37f:ce2e:32ea with SMTP id 98e67ed59e1d1-3875826180emr3950171a91.19.1783402878394;
        Mon, 06 Jul 2026 22:41:18 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d100b5c9sm426934a91.3.2026.07.06.22.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:41:17 -0700 (PDT)
Message-ID: <1602bd87-ecc3-4051-b833-5aac43c2762d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:11:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: shikra-evk: Add TC9563 PCIe switch
 node for PCIe
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
References: <20260630193059.GA225112@bhelgaas>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20260630193059.GA225112@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 32b15kdyMHtHHel2DnccXoXwcZsriQFT
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4c917f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=S2spThItiBpve86ZF9EA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 32b15kdyMHtHHel2DnccXoXwcZsriQFT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX5+tz2wyzr3CF
 mr6E8OXjTFh3zyT3GXKvXnWUGHNz2HaVlIcP6UJzh1fUERi8ldKTVTtpCmLZJ+Unr6i19AJgF07
 oKHr2M+wcbzNcV8+gphav4DXfDkDKsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfXz8gW0vmbjQzw
 U606tN5u61DlsKEbBRY7NpNA9vlrrc7q5Hd4+PdG+oNhCSd7hH6VfjNliBLdKAdTKgQBGPF1K4L
 ozCMc2FVyGCzL79m1AFcw8dLEBbbx0Xnf0Sh3cCUClcuzSiS8DqGvZzMCAkpkL4jZgt15DWgP2d
 T8pwa/ipkc6qGmKfbNHkcTNnz6tpDq/M7BuoTGSe8H09jLZHPC9QpR0rPgNIHzJMGxjghMh7R7Y
 IlO06n7Lq8OaIGNFFQIWK0fj7XPYuzHJsJl8niTHdWQISMSSSvXvUnSdRYEngCsgPAo5fuRKyCC
 FkINngeHjzEccTpueOqj6kUGjJqb6cGRhEbcQFAxoUB/FHXAiXHVtPsXV2+fpkL9HXyfTMiCFY3
 o+CyOKNlBTWp2qIwWQnuJfj4m9GMbVHwRQzL6uixiiGCUAB1OQ/PAPZCztaRVXD5MFm5bRf2/p5
 klCnTRy4azo/azmJPzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070051


On 7/1/2026 1:00 AM, Bjorn Helgaas wrote:
> On Wed, Jul 01, 2026 at 12:32:50AM +0530, Sushrut Shree Trivedi wrote:
>> Add a node for the TC9563 PCIe switch connected to PCIe. The switch
>> has three downstream ports.Two embedded Ethernet devices are present
>> on one of the downstream ports. All the ports present in the
>> node represent the downstream ports and embedded endpoints.
>>
>> Power to the TC9563 is supplied through two LDO regulators, which
>> are on by default and are added as fixed regulators. TC9563 can be
>> configured through I2C.
> s/ports.Two/ports. Two/
>
> Possibly subject doesn't need two uses of "PCIe".

ACK'd.

Sushrut

