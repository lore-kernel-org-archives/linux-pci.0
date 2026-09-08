Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46036A341
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848365; cv=none; b=MYrofK4F6w5vXMwveis8/ODkq14Ygp2C9MU07tQyDNe/s+9udEOnYXvYf253tgMUV9Y3T3Xumnknw4F+Qc1CXjW6aDI3JeveJaN/RDyS7JhCxhADY5m9E/Wyhq3MLnJNkK1R++Jhsui783yyZ7Pg8uW6OaPGjBIg9QOkL3+8oq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848365; c=relaxed/simple;
	bh=GG7G+9T2Oo1QKtwlAlwwLqKDet634AxeiXNEgqyA6mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiGzP3eJTXxSGrnyVpWRJ+Z1P+JkiY+XEyPOPiMtfmhbwBgoGOmwxKOS9PisQZuANDDLLzm7+XHU0On9pl/Ui2aaKz9POkcYL5IDQDn4DkTboycXv7J8mccXtnTqNuQBOlCJLOcUIrBDMHvhc5mer75oZ2sap4TyeZr3+fQ48Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZWjWtvg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OGo6dN9O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZWjWtvg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OGo6dN9O"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6883p2dD1150721
	for <linux-pci@vger.kernel.org>; Tue, 8 Sep 2026 06:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GG7G+9T2Oo1QKtwlAlwwLqKDet634AxeiXNEgqyA6mE=; b=CZWjWtvgTB1ecmzk
	kEU5K3FZaJ96nVZgvlQm1brKVcKbfztNoSBCOgwJBhxeFnrtmeG6m3LATHUdUYqw
	g7jUqu/uOOAI3nwekpNOV0AMJyBCTEWQAYsh4WlnBRX2BjuKTm2xJoVtQ80vl+Af
	ow0Vq8vQSpqsP9kGqKETsXejVsoNNZNIkOzN8LScczEHYp/NGrmeqOsAH13EesLp
	NgVIXoi/r8IJaasqQpdm6aaR1WNhcURFNd4DouujhtZ57+p0oFtArNPutlpA8qyH
	tL/1e7UGt/FDiaYP2NEydZaWWKZUxzTDxG9U7kNFtPbifaRdFpmV71kN0jtozX/8
	/Lq0jw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjatjgf3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 06:19:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso3371050a91.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788848363; x=1789453163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GG7G+9T2Oo1QKtwlAlwwLqKDet634AxeiXNEgqyA6mE=;
        b=OGo6dN9Ob8HZmmLJbvlWZUYq62xaASgGahNuonyxqwexYVhSQM3GfNjdpCJzwENskE
         B6+89C0yrQr6FmiRQyk/CHPkuyS0exTH72hA81Q6hLbrpl3pTifoJaLGc//LAthLdrfn
         0sNIf6YpH/BB51UNPTAJmA5pDQ+Lg+yBQeLlCHvXP5IoVgUtZV4GGh1tZvziAgZznlKG
         UrEg6StBz6ahBT9H+CHMhNsQQy8XQhXnLNi+t46IAIIH31NFWff8y5bjId3xVveqNHh/
         h5gBO6ShUIKxb1NfDd5FsQ5+i9Gi/0b5WG2MGoO6nYfkZ6jfuGlhXxzWCl9K8+wt82hy
         I9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848363; x=1789453163;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GG7G+9T2Oo1QKtwlAlwwLqKDet634AxeiXNEgqyA6mE=;
        b=ZDsdWcfWsv3JuMNfRIWbne6aRDWPCeo4i9TgxE98OzfyTKJB0zJgKnKTsEr5SoCM0o
         lMwaKVaYP+Bqvb4HUF9AHU0BDzOluj5vjoZMrSjkPPjgkznDSwqHP3YYABPeA3+CJX7G
         SU5rAUrDsFGJVRIKHJmOEFq2ua9KPadc2wcVswuZJq5LsWhcQz5n2EuyggkW7ynuMoJJ
         bW4uff2KAYxj+myEpuU5ULFP0Jr9sOX4O4+J7ZcoOrpb7iQDPykOy63SiE1pgXUcBvA4
         /j3gBdCcY33lf7M8sy7s1xJBIKRGtkTysq05lZGnLEkc6hIjBL5UxMhx9ScORt/kgpMz
         fdCw==
X-Forwarded-Encrypted: i=1; AKwUvByWlFeKFoe+YmwHgAF1OwwKmZDfiAXBFC7NJ+AidxtGsIouTUgqUJnLfthQuUagg2lKSqgQbureXqk=@vger.kernel.org
X-Gm-Message-State: AFuF++l+KZ8bgckTXrNwnZURfj9Z19bmLmRJISEEDGcxtLRUriOr6rys
	sD1lrOtTrBkcPpNnPjKe5xBB7VGaK3ClBuamDhpcq5JqpVkUX1off+eI/Q8R8H3xxhzZx5oQo1u
	Q36kzWlpX7gFUP23n9aB/ivQxlSR6zQqVCYCOyEYoAs62P55994nFTkYxfxfzDl780obVu1A=
X-Gm-Gg: AYBFou3rmgLpq9sEzd7cF0D1m2ZVZnYjHQ9NgL0fYSQHOTz3RiLMdEevpQfki6pn7Tp
	SOr5aBuOJ/skrRtK8HX9s0+4Bm3ZlgfvvVYHo3pslLMwem4eipsaUWafTUKnWvZ8BdgG8hPj3Ps
	IgGMTZR9uLp4uhO87MwRpj7mpVp70nmhbz2kEvg1OT+KbHsXqz1XVM+OFkCc5cH6xlrnwEjNg/L
	QpguEqNSFCmNtPjc7Y7yf/zGaWvNjkjDJP/cjpuEF1EBrpl/q7tiVwTs5e2ohJ1GzKBZF+CaB7X
	Y3PBgPZ7tWPYvaPfZz0D82MOUYU1iUcZoMmlbhBQ+3Ksq6zMfg9qUdz0MvWVxos05GGp23BLIgn
	QvXuCtvuCLk+l0baMuyq5sBS+lsMoKw==
X-Received: by 2002:a17:90a:e703:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39b2629926dmr42480937a91.24.1788848362809;
        Mon, 07 Sep 2026 23:19:22 -0700 (PDT)
X-Received: by 2002:a17:90a:e703:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39b2629926dmr42480891a91.24.1788848362367;
        Mon, 07 Sep 2026 23:19:22 -0700 (PDT)
Received: from [10.217.216.255] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1433171a97esm32885817c88.12.2026.09.07.23.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 23:19:21 -0700 (PDT)
Message-ID: <43009f4c-55c8-4f82-9efe-b72747f68cc5@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 11:49:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com>
 <mivyhgl3axsebyqktjqqglqgra3ptx4q3u5a3ybudmnxigvdqy@tn5sga4z45cu>
 <1fe0ff27-abc6-4813-a4a8-8bf8ca92b91a@oss.qualcomm.com>
 <ycyc7cm4y6s4nmez3aojdenqikh35eqvk2ady2azbiyghbbg4v@r3dzmymx2xuf>
Content-Language: en-US
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
In-Reply-To: <ycyc7cm4y6s4nmez3aojdenqikh35eqvk2ady2azbiyghbbg4v@r3dzmymx2xuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2NyBTYWx0ZWRfX8qWCaRwltWDe
 /XBNw055YvAkZ/X7XDvTIye3Cd4VplASF/VISUpdSKjThxify6yegdTipLOL0Wvgdhm7HaYHMiY
 yA3DIfSqWh1eIV1rJKeMcduFObhZRIs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2NyBTYWx0ZWRfX2bu/6tCJDTG/
 5hdBohA9oHD30MqUJ4gD3fTxhOp+rcsThnKPA4KD98lMyEq8DorZmJFVCWXv78VAEB78FSPoSMK
 ndAQZc2U+ygCiYhsN//8IxLqR4poIJ0TiVjZ//2kplEILo7i0IZc4a5WHPDaa39aDd9aP14caVW
 NajgpPlTjkvIZChTfztqpHD6Cp+AWq5EFIBGxPv/QL4HFmxNWGPWFofw7Mtpntah3s0fftXN9fR
 HJB36DyNDj5lwV795IyGuf3CmSH1p5KX3JTP+V5FqHwZPSzpmpcLawTpcRjGRHu5wGCCTaSRY7l
 qYdTq6GK06ioh1UWxrSDRP5Vl3LKNLgktLYNE4q28w3dvpBUa8cIS70sHKvnXqVjd9+cUx9w/9y
 xvBkJFFL/Cda5Pl+xWmQP9IhuRry2+s7ewObrYTnmGVQ2GX9EQ7a/0QzaehsOPar62n2UgX5ljx
 reJ2UeIy2bma2GNZ+hw==
X-Proofpoint-ORIG-GUID: onagjsxRfJvIz3Qpr6sl5_A1lJvbqr3w
X-Authority-Analysis: v=2.4 cv=QrduG1yd c=1 sm=1 tr=0 ts=6a9fa8eb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=YUdBlht9uQjFYAMZ6iUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: onagjsxRfJvIz3Qpr6sl5_A1lJvbqr3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080067



On 9/2/2026 9:47 PM, Manivannan Sadhasivam wrote:
> On Wed, Sep 02, 2026 at 08:44:57PM +0530, Krishna Chaitanya Chundru wrote:
>>
>> On 9/2/2026 7:37 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Aug 26, 2026 at 02:41:20PM +0530, Sumit Kumar wrote:
>>>> Outbound IATU apertures are configured with local device-side addresses.
>>>> When DMA engine transactions use destination addresses which fall within
>>>> an outbound IATU aperture range, they get unintentionally translated by
>>>> the IATU, causing the wrong address to be sent on the PCIe link.
>>>> This results in data corruption or IOMMU errors at the host if the
>>>> translated address is not mapped.
>>>>
>>> Why are you using the same device address in both DMA and iATU mapping? This
>>> sounds like a mapping problem that you should fix instead.
>> issue happens, when host address(DMA destination address) matches with the
>> internal iova address programmed in iATU src address.
>> As we can cannot address in both,  we need to program iATU in DMA bypass mode,
>> so DMA transcations will not go through iATU window.
>>
> This needs to be explained clearly in the commit message with an example
> matching the DWC terminologies such as 'Target Address Registers'.
>
> - Mani
>
updated in v2.
- Sumit
