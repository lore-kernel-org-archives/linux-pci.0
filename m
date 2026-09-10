Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C112E5B2D
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010807; cv=none; b=ajm4MMzq+SMFRt4qZerGH03FT2OdWt+ZhjSo7Pp8ZpPRigTpcrVjLtAEN/wT+Qidn8W5TKTnTjfCQmhQJKIDA61y2dd3TlxpbM0vG8kVRxSqaxLrtmjsuUkJId1JUzXpCwSNxmGFMF58GyytwC72/tehZaAyK1O2M3lujs8Yf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010807; c=relaxed/simple;
	bh=UJnFcG6qwNrgHEmfO6bvSB+lMsHMJEjnj9V4eTIYsac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6p+SUJkeU046AoznTAZGoQsUuwbNoupRiP6BacWfTPA40qDIwg8E0xO+qF2rG3xJXv6UCZpyk4cr2FOhtnpqSF2/7m6QSS7xcEt957AqIk6JJtGUrz3IsyrPhPWPJnC4427adCnd/kDo07nzwCLV8nVpQtLA5LMSz5B8kmS33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfSOz5C8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N15ccGIZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfSOz5C8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N15ccGIZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A1lTuo3030026
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 03:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	szOFuM63HR18UcmMmXnvtaunzOu+6qWLkKEnlyU6mwk=; b=hfSOz5C8U5Y22/cP
	JwVkDDbJUsmcSEr5wkd3kn0qRZkuG9n6C6wjTXRr2kDpZpdrltlMWklgkWB6PhmU
	ZSpetBymH4hRGjEGdHvd4oQuDRbOOS4IJi69+mEVIZIbmIjOJ+plKF0YkLjF/qw8
	5iSQeIwcwsJHEG7lGFZUEiOR1ddV2g+jDizeU/3ClE++P3ik8UZGcww6ygCUCHjK
	m/vJTiSk4b49l2BKVxTLx5TVIV3ISsJSzAoWbbyZwJkVaK7F28AOwrMKU8jF86dT
	0rsPeFfRSWoo3iueJKFdCd0eheC801Qkf1DW/GSjISbRuEntb3vQQGMxpI2s+vo2
	fKE8bA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyehtj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 03:26:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-868f443cbd0so759057b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 20:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789010804; x=1789615604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szOFuM63HR18UcmMmXnvtaunzOu+6qWLkKEnlyU6mwk=;
        b=N15ccGIZi9yg9U9oQpsYhMMFXmU2vFEGcM+5qA7y1YxEqmc7Pi8D4JOImTXghdPqTK
         n9s38mNSpTPXJ7aNrCGdqYmttj9GUUjM5GuFsJJFgakHLEgxDn675iu1NMpN1n9oDJp5
         P0r+SnLkASuHFvvy5Lqn7gVXMJgsMO12ipxjyxcHecupCTpQkX9/2uPkfc7Lg9JGT3KD
         7SAKm2PE0rfgZ0LuAINda8tD7NZGwftytiIvvo1NpS5C7djZ6HfuYrPZC4lqH8KMW+DH
         NC0Z38CYe/Zm0Ee26IMxAzhII3KJlthDnuupnYIDx9dTnxvWvWEvhXVsxUia1IvuOOTm
         z/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010804; x=1789615604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szOFuM63HR18UcmMmXnvtaunzOu+6qWLkKEnlyU6mwk=;
        b=IscGDfoC8X+72XKqL6u7+Km2T0R4Aou4dKh3J9/hhX3nUslTbL5sUgZbrVcy6OMSBN
         OknnyQXXR75ZiZeBZKOT01+bzkrBqRzm+CnB1dlmhlWpM7PKz+Ia7PrMwLQlbAYYHEtQ
         weJS43JmuvrzxyjwFupA7CoAYU1l8GvsAkhixoctHwOPPAfxMgOQD6n/Icm/YQJNHU3i
         laMihP00X9PwHszEfJTRQbKfEuDtUGSqxSQKNIEgG8ZTslxqw2nh++FsDjdIeNLPRgaq
         Macip4IvQwncjHTSy/1euDGDJAT/fQlFRm9BMXNkodW2Wpz3/eqF73AchOlE4bUG9Yvn
         uGMg==
X-Gm-Message-State: AFuF++k+wliR3+rUA/G3uGJiyIweoC4EipnZzhlrCFBYZPdBnwP5eAQ7
	tQiYFAK9unIYyJsipcC03WPxp2PSqCKQZO5TOoNUGsl4Wi5rxju+Qidbnvr4TsHTx5b0/BmxmtM
	8v8eCugOGf5UMY5hUK/XFkRTXwX/1Y863vJa4cLwsguLAlKh10+od8eX3AAfnPlQ=
X-Gm-Gg: AYBFou1DOrZ+n57nH8a76Luqi3oA0Ye/DCji2Qqfw1IvvdMgiMlLsuElcwt66ZW0AeB
	fqUj3XK4zKCdb1R6b8cyuelN8887bc98WHQUirJu2AnV6uY+/RKp1sY4YyXJJuybCA1XyLYOWcj
	TwtIe5KPrLbgmeT1/XgXeBzPBI6oG7gyIDcdDd2jZHNx7VcB5TuhSb8CNdkqrnr6s3vGW4GhjmV
	w839jVVC3IsZVQG/jw+jIu3UIjNORRVbDeIJshX47ljDw95jmBmCl4tptIFuufuwdgO6GQ2Jlz7
	SVOvRZadYcbGiZlQrUj8NrhvhYpyOCAescQ/+lPwECXxpgJCgqdqKsVIIeYQJg1sF2Rglfjz6x2
	f2foZKxdbl2qkub2oj+/dIk0eOtMD+y4v
X-Received: by 2002:a05:6a20:1605:b0:3d1:66cb:d49 with SMTP id adf61e73a8af0-3da39b71971mr63167017637.4.1789010804536;
        Wed, 09 Sep 2026 20:26:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:1605:b0:3d1:66cb:d49 with SMTP id adf61e73a8af0-3da39b71971mr63166947637.4.1789010803991;
        Wed, 09 Sep 2026 20:26:43 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333959d5f69sm45688920eec.0.2026.09.09.20.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 20:26:43 -0700 (PDT)
Message-ID: <8293c4b5-948c-4859-b63e-835ec35ea90d@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 08:56:38 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: qcom: Implement shutdown() callback
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
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
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <80f626f9-8a0d-49cb-a592-14195900e997@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAzNSBTYWx0ZWRfXyZyrme7K4yhZ
 /Pp8M2JnlCFDHJT36t5ir//d4dMmc+e2rbwqRZ4gnR4FQfG0aSjqoJmnKs7tye2LYmbDuPawSGG
 s+34ia6fZQWyjNUz/fxBNAd6+cwNEh0=
X-Proofpoint-GUID: NM5OCYwJB0-WQijiDuv4amG5eJ3LHAJL
X-Proofpoint-ORIG-GUID: NM5OCYwJB0-WQijiDuv4amG5eJ3LHAJL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAzNSBTYWx0ZWRfX8J5t0zEsFUid
 Tf1f32CP8d+qza6zpbRkir45VuoefTFqCIf9W+yZEcndbyvdkSCz6W7CydMCH6EALYH4JEW5Yla
 oq5ZlvYAMGKvjW2ZseInT43y6J/YOi394TjgAS067vXEVerWStJWfz/0PwEmxPTNhVsgjpZm3V8
 KS7b74HpPnot6ytN86rhGxuJhGfmS1A1LBRnjy3rpf8VSoVXDyxhI/EpBKs0+fXrivTgxnyrnLB
 +HhGrPm2Sho9b6NDz53P59G8xY2QC2mAOkHbdI4AiMR6YijjHfJ0ZAux1HHouIhCwftZwYclpiN
 5xwud2ehELZHI1AU1LvFxFMTDW7CmK2DAiGcvCW7jaqGZX0IsgJT5cGGEcfUAO/Vku7HVrND/9F
 pjKqD5XF2luKa+w1UjWh8N8leJvXqqfn4OZqNYajxrSmdIPXTZI1duS5Na7i0rTnftprexs85tG
 3NuXJZy3mhmDeMnQ1ZQ==
X-Authority-Analysis: v=2.4 cv=Go/XaU1C c=1 sm=1 tr=0 ts=6aa22375 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EfmTqkNx2LSR9vyAH8wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100035



On 9/9/2026 6:48 PM, Konrad Dybcio wrote:
> On 9/9/26 2:40 PM, Krishna Chaitanya Chundru wrote:
>>
>> On 9/9/2026 6:06 PM, Konrad Dybcio wrote:
>>> On 9/9/26 2:24 PM, Krishna Chaitanya Chundru wrote:
>>>> From: Manivannan Sadhasivam <mani@kernel.org>
>>>>
>>>> PCIe host controllers should bring the link down cleanly before system
>>>> shutdown/reboot proceeds to remove power/clocks from the controller.
>>>> Without this, the link may still be up and endpoints still have
>>>> transactions in flight when power/clocks are cut, which can trip SMMU
>>>> translation faults or NoC protocol errors.
>>>>
>>>> Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
>>>> into L2, putting it into D3cold.
>>>>
>>>> device_shutdown() runs with interrupts enabled, unlike suspend_noirq().
>>>> Mask the chained MSI IRQ(s) and the Global IRQ before tearing down the
>>>> link and clocks/PHY, since a late/spurious interrupt could otherwise
>>>> reach a handler that touches now-unclocked PARF/DBI registers.
>>>>
>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>> [...]
>>>
>>>> +static void qcom_pcie_shutdown(struct platform_device *pdev)
>>>> +{
>>>> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
>>>> +	struct qcom_pcie *pcie;
>>>> +	struct dw_pcie *pci;
>>>> +
>>>> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
>>>> +		/*
>>>> +		 * Firmware owns the link teardown and clock/PHY shutdown in
>>>> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
>>>> +		 * still need to be masked off before shutdown proceeds.
>>>> +		 */
>>>> +		pci = platform_get_drvdata(pdev);
>>>> +	} else {
>>>> +		pcie = platform_get_drvdata(pdev);
>>> This is no less than an intriguing choice.. please store the same
>>> element in both cases so we don't have to do this
>> for firmware_managed solutions struct qcom_pcie *pcie is not being
>> used/allocated at all. it will waste of memory if we allocate memory for just
>> this use case. - Krishna Chaitanya.
> Should we move it to a separate file/driver then, perhaps?
> We could share the ECAM ops in e.g. pcie-qcom-common.c
I will let Mani to comment on this.

- Krishna Chaitanya.
>
> Konrad

