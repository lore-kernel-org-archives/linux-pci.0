Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF55386426
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402950; cv=none; b=ObBBCi11F7X+PFrMNpcGpzaR0YTQb4xddgqRtgMPmnlWEsHvzXLmA25NHvwn3EASAOfvIWLXD+tnSSqB7/dMUglpkmAXw1ZfGidrTtZOswYUS2XkBfogZ/E4NLZcOAz+S9kRep4VtlH1wA/TatHiOi09MZK1iAaPqOYRiQagLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402950; c=relaxed/simple;
	bh=SaJhfRfeCBEEdb51HU7xQP6Qi0RYIjzXwMnuKXaNLHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPL8QkMVtkIe1a3qiLF+KIsEdDwtop637jfo/jsipbpVBOguz+SKut4SfgoWnmToHcWkU30fiaLaP3TY7G6Mt7l4FIAhFacMOgdm/NLOvia2Nww9LLBTwFh5v6uzqwQk5QzdA5IdW9WHqlEKt4tv/FLOYv/W1JUlEY+n5hXsE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7z4dGHl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DKkFT7Yt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7z4dGHl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DKkFT7Yt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748pk02585385
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eAzXorLcGHEyoWUBEpjb+W55R9Exavz3+bJHHBPcDIY=; b=b7z4dGHlOeLApk4H
	sFQPhYMYmOHOfJZuCM1WMZ3T5QYfOjM2C4mczoEqaW5VvOMfjQsNfMCexXmuEhoy
	nsOjD+LPuku3K5b2IbWjRPioFk/0DhCh62uuyxV9/3p1TRVQreQA3qioeNLpH/03
	fpKaoYenWDNnpxGnggSIeo4TqPpA9rRvnefkMufPwE/UtIPM5m2EFpEvk6Fe4YFZ
	O/28qjpmHD0d8GDiTDl1gS/1R0eVubo9FqiF2tVrZ8HWQ5nGTY+RxYoFBXBUnzvD
	yJoe51nRCwy7H4d/f0Ii5PMH2jqy/GdpFpau+IhD3d/c9ReNiQ6e3oPJotT34NzL
	QGBK/Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t158abm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:42:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84622d6102dso5386132b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783402946; x=1784007746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAzXorLcGHEyoWUBEpjb+W55R9Exavz3+bJHHBPcDIY=;
        b=DKkFT7YtX7WEEpVYRUXOF0hGC1b+Hui59QG8Wi/owbA7/x6eJECgH8pdjKc6KT5VSn
         GcA2UQsQuBiZjA2ORENCYGqm5i0J2JwNyq33BjkZvi5l/w1ftgqzeLU8ST4B02z8pwaN
         ApHZKbQlbdLac+G2pBdeDNX7UsEdqx4R4cuYYbIaVprX1CgduaQ+PwzY2+sBCxGOnU3X
         /jZGoeqZH0R+//nmyKYNEHrNBPWelg7BnQfb7RN/EWDaCNSEmW1+bhlDG9ve14FJKp/Q
         bVQfDMS9zwZcSjF/aYns5kX3kI6VSmIbHiMhIVGkZY66b+DDRMe838A5rFIKEb/hBRu2
         lpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402946; x=1784007746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eAzXorLcGHEyoWUBEpjb+W55R9Exavz3+bJHHBPcDIY=;
        b=ig6D8EWK14Pk6AMfCUWDWD1/R2s5nprPKT4HXuR/qZ42Vj2QFZIwDLlm53INz4eQv0
         sWZIboNBAVHwjLBTcaYtkIM1IwFI6QPXHoIMjeifxVcvNrz54zTRbIUQtnJa505wORcd
         9NFqYHNXhE/NMCijF+eDUSxhqRY3a1lVl+N4+ysNfoebqVzVug0rknLUS87f1BD+6XIU
         pCk5gwLhdP5XA/lWNqPsDvJs56uLEo8uiXlSmZUTaSw+fK5YAka89GBSFNm72yQ5xUNn
         1LxnN2qT91dhoy0+ejSlZtPU6hFjWkafFsZDRzxQ8EOosPcUvQ69grcWXFKTHr/RmDU8
         COAw==
X-Forwarded-Encrypted: i=1; AHgh+RoqJmTUVq1zLP4t4QjEnRkD3uFB0VSdJFnsfttBhFw2w9q4Oeqh7WHqZNq0oegH4qgspNyNz4UBjXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC1DSCJChVgz8s9S6pR8rzNWZ9y+SS1Wack7+SLH0jJ2I5VkV
	2AOEJ5FD8HdLXTidRX9Cm+6eM1gzmGlbJh18b3AwDuyc3UlWbaC2FDL8NFSX0C2HUUb3nS0PT72
	sR+33+oLNISvNGT52C6bpCU13O+IVJZJ36CMp7hAYMOu0MPBmc0uKLZ5SAV5AIDg=
X-Gm-Gg: AfdE7ck6JzjbKZFdZ/SEUEQxjvk9DTzhGH6GFQVWYBlxVhYXWucL8/24b7WnnqPfINT
	mDxj+a1STMDPGf6holUz6UwL7kESRENPsRoV4gnftodQErDCzK8EfyL6JmVt8KD7nOX6eKpAtQn
	WrX+jqbNSR1Bb7reAwvvlIkngCsmX0ZbNpoRmN7ADPC8jWV9UMk/LWE3NKIsftKSauohd0qoAr3
	ptoITdfJIrPmTnHbvb/UqLIT8DDvgDmMBjQK50zXhJ9Xgv60BfM6v5HePiCcvQRfoAQKoiLocO5
	u02X+zUYwXfCnC03C24Sfb1ohQeIw78pKmNG0DRf3wuvb+NRkS2dFDM/msY0xf9D2ETbw03i9wn
	Pw3rCw/yo0tjGJYGP2B+/HtWU22TD/8vrI/sIbJVJRMv6YrVSVYuVr5ecysR9BNnog36W+kh+gJ
	6lmjbT
X-Received: by 2002:a05:6a00:4091:b0:845:a435:a2eb with SMTP id d2e1a72fcca58-84826d3e479mr3223188b3a.31.1783402946549;
        Mon, 06 Jul 2026 22:42:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:4091:b0:845:a435:a2eb with SMTP id d2e1a72fcca58-84826d3e479mr3223164b3a.31.1783402946056;
        Mon, 06 Jul 2026 22:42:26 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d496besm4787914b3a.36.2026.07.06.22.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:42:25 -0700 (PDT)
Message-ID: <9f938b35-9102-486b-b4b8-0967b2aed1b1@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:12:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: PCI: Add bindings for endpoint gpios
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>
 <178285172702.288391.13610342196466613275.robh@kernel.org>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <178285172702.288391.13610342196466613275.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7KeOnfs2z3po0xWMViNxcwKlKzpuhRtR
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4c91c3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QcnDgq45NsFIHwn4wVcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 7KeOnfs2z3po0xWMViNxcwKlKzpuhRtR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX7KaQAtaBuAs8
 oM7UfCzEVSFrXDhFlOv/SDja8ZIwfipI6LeEO7SM7QsV8fwajJwdrgyAgaOKRM85SH7FkRCgobW
 tBndLkV4YHV0q5KxxB3uHmQQ/z5SrBE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX06+ED8vwuC9U
 XLzQo5CEU3JHLcLbR2fuXhL/iBT7AMr7K9b/bqkBB4PGZrWe/WJmF1rQY8uH4n5EU1mMXBQTBgp
 IucoJzwhpQq/zk9bl0NsDytrbygiymLCgM1Sn6akGHovP29QyJAEpURwOKUDBPz0chA39c1TFP6
 W05Z5/mdm4898es3Oq/zgDBcVQOnlUmeU2bqkM3LBu02cdr/gmfkrniAUqf5srjDWzFVR/LAvgG
 fWBVMtjs2J0l9UablXNGylbSMBkOksveeEeIHY+xEf0iX4Ijh0mfdjEfFQH/ZoHE3PUqoKAQLhe
 4YBRvPRlPY4hVj2NHxlOXnf7z2PzGB3rG67Z9KcGkzgo4uWysDxRVGSuxAIexxSLtomJGIcgBec
 1wCLDiTFYSjM2QVzmFGoqZKauRs7GYlSArJDExuLEgqlu4p2JOM3WjbTbDmBXvxh4/IjMnmhJOA
 tnqtUh+y7HuqzBO5xeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070051


On 7/1/2026 2:05 AM, Rob Herring (Arm) wrote:
> On Wed, 01 Jul 2026 00:32:45 +0530, Sushrut Shree Trivedi wrote:
>> Add devicetree bindings for TC9563 GPIO's which are
>> used to control endpoint power and reset.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml:32:9: [warning] wrong indentation: expected 4 but found 8 (indentation)
>
> dtschema/dtc warnings/errors:
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

ACK'd.

Sushrut

>
