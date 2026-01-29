Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BD2BEFEB
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664459; cv=none; b=mYrjJNMSyl8nLYMunha954DchUnJvrOe+FCVe/N0Q8DPLYP2K95vZOGFqhSzlq18F8rDlnVfaQ6v7oLByQdqKD5hgVOLW8ZZS1AJwqPoECkdh6FiaUVPJy1Ak2Fp/i3RISAI20JV12bGXGKk1+0Xjj0DbhugOOEYonbbPm0XETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664459; c=relaxed/simple;
	bh=iStT7iBgxnm5qqn9kLoLhSDoutuiN+yQT4k+LPPi+OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxnR20iOEjlBuQftU/2zZ/RjBdUvl9okj3ALw5b+GbAcI6uQvEN6fkkhdO9hdXMKGAYWsmsxAVCgF5PuY2TnM0Gl0HYsAjDrznd1/vjnDu+qlQzs3qx4bz1SuiRLmVzuo6cD5ENrrChiT8Gi2c74nOwIFXDygXrYXEcvM2bVY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HAmmDBgI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AFpRZcob; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HAmmDBgI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AFpRZcob"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2okjo2033247
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mp07nSl2tmcDysrgCxQSISS0sVufQL1Lv7YkLibhp8w=; b=HAmmDBgI8ArT+IuO
	BcB/YaPxwK6kJpmQbg+LvkQc2j8Z7Z+1ajsOGke1kIaQyyZieD3pSumS7WumuilH
	Wd3J+3abuBi/e1DI1NVJCJWtU7WyrVZ4hftIbOcGBQpQfpxf6PjFK1rOcAcZbCUB
	gk/NzhZSJKnqpDzAr6EilEIop70cp+l/2suPLl7NNXI9UvWfUizBUFplnWWV6BOm
	azsqqbes+wjXbqFjt5uwLz8GpYPqpSU7rMdzitWICaDL51KT44nkEirt9/UcEKk6
	K42yMAm6QALZvY5XGMTR/XHPjrRThGVCRc4SKfkgIdugG00HxGEI2UaB2Im73ol7
	LQ2gtA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bytqy1484-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:27:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so7389245ad.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 21:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769664456; x=1770269256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp07nSl2tmcDysrgCxQSISS0sVufQL1Lv7YkLibhp8w=;
        b=AFpRZcobVeajnJXp8IpklI+4nHuB6m65+72qtuJ1hxLdssi2OSVSuxtv9G/ArM46rZ
         OFXlQDsbPbl7mKMjitUvxSmyK2RLjD8XSN0mg30p8TSRX0biRpyW/4/RpSlDsonu0Sit
         ivEedWKYjUxdkqtCfHbAcc1cVHZA4Er7bj771IJfq4ijK6rLUuycMpJVr5GK/hGKaLf+
         u9GTkmbTq64y5wauc2ue2msrKWSj5eS41aiikagdG/OBo73dK4ktGZ2tfjJgvbIafUhm
         bHQAuErQXUNJO+KVQ28QrM2YZStVczZYpdiffpOyaUFH/tcreW+EaMNtIa/ir01EOH8o
         jC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769664456; x=1770269256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mp07nSl2tmcDysrgCxQSISS0sVufQL1Lv7YkLibhp8w=;
        b=R3/r0VJjMhbYh32yr6yKbEQp8AfSoreZG6Q22f8OqbRAaw+a7opX2vQi+Z73ZGyQ/w
         4sIqIhb5KX2dYfoHdddUQaSgrw8dfiB+X3BP6VXMzsVTvZFTSWxx6GB+yfSweVpsx77i
         cW5FH7m0QtvljQTulZkTj0s5NQTRkSxFCAhBYRnvupM48bm6BdJMnoNfhzsM+5V4xD4T
         FdCOC/fW6QZK1lLUX0SOW4BE/C0d0UbjXurHkZl1a44xOnIy0TsueCIEr/B9/loiNNAq
         XzYRCIzAVhXwRHPB+MGC14Ic681gaRQ/a/iz2KVD2wCD5dDajtGhckxYYsv18qe9iBt+
         uoCw==
X-Gm-Message-State: AOJu0YyIf/M60QJZNYv+n97Tv4Bta7U7DEGFPYRyoWdXPqYyYvaWHgHN
	hyYFfvt2x8Uf9ZXCS9dZRjj2O66q8p90JBey41zN0lHEdrYii2WoGDDdiU6jnKuDVETAJV/7TvT
	lUzdbiuT74MNll9XZjmnz4sgndKUV12AX/sXDl2UyK1wYqR23ouIvJbZ28n8XSwE=
X-Gm-Gg: AZuq6aIRkDAv2XWpx0hDAus906um1xr300d+0q0TF0lCDrjlUCpwGNhqyBASsvW3/WE
	seTUA8AOBUftY8ZHFNTePw6NpttuWGoIUsXxM4+0UI/5aMxizh+07lh65GdQkW5zORAtkT/3Xqq
	yVCjPDvx/7DboADYw1ajtWsIJkfv56S6Ok8HBc7qRj2gJ45V9rVv1A8L7j9VtoGzAkQhAVPC16r
	c1SJkj+0hUk7ukjIE+ThvvS1uOm59+iAmxUpfyrhvvFo0sbjU0MOfqpnE+gox6g/yVvCdiZLdYu
	ZbUofzqh98db8JHk2mqMnmB+grQDdX/TmWHtC3ByQA07npymZ9EwoOjBVRBcmBKVpQo6ub0NAWs
	rOAzkHkh/Jh5Q+mW3ZNvoEnXGU+ZWgpnIfcHf5pQWMw==
X-Received: by 2002:a17:902:ea09:b0:2a7:683c:afd3 with SMTP id d9443c01a7336-2a870d4cd85mr71591795ad.16.1769664456033;
        Wed, 28 Jan 2026 21:27:36 -0800 (PST)
X-Received: by 2002:a17:902:ea09:b0:2a7:683c:afd3 with SMTP id d9443c01a7336-2a870d4cd85mr71591645ad.16.1769664455580;
        Wed, 28 Jan 2026 21:27:35 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f6c7csm39838935ad.98.2026.01.28.21.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:27:35 -0800 (PST)
Message-ID: <45e1c870-f155-4943-990d-5e75a1e8b998@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 10:57:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: qcom: Add D3cold support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <63531057-ea7c-4a87-9848-04e502bffc32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMiBTYWx0ZWRfX28Zs5vSTTjOv
 ovra40ijuhMh4jI4nEvv/cTF7ft8sSW1UzAD0arwr2Kl1an62SuA8TehZ0n9PP3EXFR7Kug8ifs
 uad5nU0TEeRy+GRMKGcJLxysbENmOpoO59PIQmdtjjbeOnf064CP+Bb9SPRTzLxXDNi1ego+o/a
 6bfAnDePBAD0TgLvUsSpOZqFX+WSpXyRFhGAH54gowk1Q80PnmyNaTrBcpjR9P4gaRoz+cCxBec
 Ag1fJ4S8ceQ7Ka5gW17naXlw41lZOtPfefsDASvulTlolysN/Q1QuU7NF/jo59vnYumM2PhRS6u
 HQfNO7xoT3I3NLvvMMyyz1lxeWoo2oVIWA/iy7dgZKZLXwZclEB59Cm6ELQOGe7SZ+yNfzY4Bbr
 Aj0Sc87+y+bNBRHTVHIYoOUFfMdaqjEhHBlJ+Wi+Ux3ALa1u1PfajcMViuvJwyfyYzrs3xLo137
 TuHIuTZBTO5ryRss+Tw==
X-Authority-Analysis: v=2.4 cv=Je2xbEKV c=1 sm=1 tr=0 ts=697aefc8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=TnsRN4puekgCtVQ3KW0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: EeSye22aety719WTNuoiFzlJIgRD1t8K
X-Proofpoint-GUID: EeSye22aety719WTNuoiFzlJIgRD1t8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290032



On 1/28/2026 5:58 PM, Konrad Dybcio wrote:
> On 1/28/26 12:40 PM, Krishna Chaitanya Chundru wrote:
>> Add pme_turn_off() support and use DWC common suspend resume methods
>> for device D3cold entry & exit. If the device is not kept in D3cold
>> use existing methods like keeping icc votes, opp votes etc.. intact.
>>
>> In qcom_pcie_deinit_2_7_0(), explicitly disable PCIe clocks and resets
>> in the controller.
>>
>> Remove suspended flag from qcom_pcie structure as it is no longer needed.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> [...]
>
>> +		/*
>> +		 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
>> +		 * Because on some platforms, DBI access can happen very late during the
>> +		 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
>> +		 * error.
>> +		 */
> I think someone internally once tracked down what that access was
As per last debug which I have done few years back we see access coming 
IRQ driver to mask the interrupts
as part of disabling non boot CPU's.
> Can we fix that instead?
The only proper fix is to keep device in D3cold which this patch is 
doing. if some client drivers like NVMe
doesn't want to go D3cold we need to honor it, but Mani is working on it 
to allow NVMe drivers to go to D3cold.

- Krishna Chaitanya.
>
> Konrad

