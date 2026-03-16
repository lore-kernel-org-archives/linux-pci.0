Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6823EA89
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773637602; cv=none; b=XhqnJAwzToAGttUvJw91lD1p6e+Z0uc2bQPf2x9iugbBfW4GtamLa8NQXuvxcNnlEzLbASZu5ErECYfNUBrcWx2OyseE8Rhibzh/DRCeQJWpYoSqPnlz2hhAK61J0rc5cj0qj2z9DuFlmpqAEOr57GkTUQXxl8jqKPNyah8tEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773637602; c=relaxed/simple;
	bh=75a8s4cKGm7+10c01zsvahwh2i/HgyFa3IeYL+aD0ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiU37620vvMEaY0WlY2MVRe8I3gcasLdQlUzrA3dPT6AlErCR5UcoNTQ38PNgtIS7wur+XVmEOcJvuByFc1wj3SQzqg1CQ9HbFP1B1N8+uvLWkStALsF3i6kvavCtFeSEAE56EoQypeRr8xvU2CORogrO5tMUScqfWu09fEi3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A5FuCJdK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ngoj6nnu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A5FuCJdK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ngoj6nnu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G3Zxug3432042
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H0rXwYZw49ux9UnyBDwy/3943rXzLigavQY3aeK/Q4Y=; b=A5FuCJdKfMuoyqxD
	9rAexqLttc378B9YmfrtYfzbI8gdSk7zQFdUfJ68B5orUcCCgKSq2m3PhxLnXN+o
	3SpVud03w9b7AdcHIMABY0rzoVZ2lm5ZW5taWXHqYCDZvalUdwZqoyeRN+hbpwlp
	BFZRfXrgOCWxyiUo7gWgUeFTtcDS2PsAeejdD0hnN6iOwz+KUJlRl9Keh0+bmEz6
	6pNQFZTG4EdSfANUfJSVXDQTHQGaVKgIcGFLGRbtxGTIPFNL6EhqCXtDZUu+9CPk
	OZ/uW3mRCGQl4Bq1QyXc8r3dADsIj+rGG6n1VJO9AjHb9jfSKs3k5KbvZLkQc2+1
	r/3nFA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00am8ua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:06:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b04293b16cso94095825ad.3
        for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 22:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773637599; x=1774242399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0rXwYZw49ux9UnyBDwy/3943rXzLigavQY3aeK/Q4Y=;
        b=Ngoj6nnuG9gpgFFXqiicyNS5+N1CDP0xuvJUBQicVCjP7eWdFn+r2p+OPh9thG9l9N
         FW9vY7T5oFrs3JcXgxRUUqao4ODBRI75bUw89nVc8fKZQXeEJKPQNPQz+MaB+XglGlBR
         MKihUyljYrSoke70OWJ117pwsJiogBKPfo3dfrFqXnD4YiL4bDAGFp6deK676Mf11IV5
         6/+kVrZJOeXoNEW2iuiy3BSNPdOICCY1dm6pYjIgwgIF2GeZJ0DSfI9CGkMi2DrGkdl8
         UxGgY9Ar2/TTDvDMqTddGSNkb0txOn8m0ZZmHQht90Dk6rZ3InArNomukhYsozKxby1L
         XGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773637599; x=1774242399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0rXwYZw49ux9UnyBDwy/3943rXzLigavQY3aeK/Q4Y=;
        b=doBYnGVdjnXgyOzTjwr3oVGHSEPLt3ht1/e20KLkDiaf2fZ0HMRhhxYX+2GGrNkdJd
         K3OPUt6dYg4sWFs0XB9zkbxViy666CHZgYMJXM3nADGd/PwWcJARlhKXLMc5PTsb23cW
         DbpwNiZ9uWJmOOQyPgtudWr6IMyZfJY3ooYE950dVj12pUlRV1+5iTqLFlgS2jVj11/u
         JIyhhsnQ5yZ1rx+aM+eGHL3Hi6B7VeVpjdsv+U4CiQvk1RXO0QGpSHBVNFvsO/Yqqs0c
         5bQjZznYAXY1bMi1QsUxKm1Pfyo2xqht1ry0bXh1jj0tNAgeTx+g1A9jp/JPlem+EzE5
         ds8A==
X-Forwarded-Encrypted: i=1; AJvYcCWU/IdunDSIz9m3yFa8GxsqM4t71hPCskga3aH20hhb2lHQrFymfr+fbEy3auQMBWxqTokcQfr/nHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyNLM4PgMwzSYmF00ooPGMBR7A5JCwMks7faprVju+Lf8lP8x
	8xGxFGfL+6/up7Yz/7iSRlN1gUAJA4PQ3/Mok4p3GLzZx7wVJeNzVM2/Fx7PJT9auAqUtYOBDrP
	eVdxPxHiDf2GXmevVF7OZfmGEf0mz3WDXFHnymCxKfJI6EmAePw269vT5oiROC+s=
X-Gm-Gg: ATEYQzzv/o67RU8ZqI4Ie2zLquthmMp11zN3j/la6clp0krYPhXnimjI7ZFPJZNVL15
	Xy/D9P1CTDAawB/A9ERPmWteJElNuStMZufY5Px1f0st4ckze/XHrnBH4XabqBjSYG3/74+KW3H
	Da8XTtKo53LVlk9ZgNhoN1fLFl0h5n8VNJbMePksy4Aucjxp1oBwz2r/Ff1hGUaBjLV/pj5ttkm
	tizgy9LWEyOfl4q43HpOj7RxQUHjp/NFvZwKV/l+3lB5vPGcaxlh3S1fMdCJTsREX9mY8i42SrR
	MgvNvzHif3RwN1vnaDQ89fNILc9B0EDuCirpcehGq3FBRXvElG59LszR+NduX9ESUcHtHWsQUZg
	IGRNsQjBzTH/fH+lcKFffn1gQNLxqJ0PTNZvTge1LlmlraPt/clt8cA==
X-Received: by 2002:a17:903:46cc:b0:2aa:d608:ec55 with SMTP id d9443c01a7336-2aecab1f70fmr137915425ad.28.1773637598880;
        Sun, 15 Mar 2026 22:06:38 -0700 (PDT)
X-Received: by 2002:a17:903:46cc:b0:2aa:d608:ec55 with SMTP id d9443c01a7336-2aecab1f70fmr137915215ad.28.1773637598434;
        Sun, 15 Mar 2026 22:06:38 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b058c97bc1sm17889835ad.90.2026.03.15.22.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 22:06:38 -0700 (PDT)
Message-ID: <1693abf1-fa52-4e62-8b0c-3b53b6617735@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:36:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI/ASPM: Add helper to encode L1SS T_POWER_ON
 fields
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com
References: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
 <20260311-t_power_on_fux-v3-1-9b1f1d09c6f3@oss.qualcomm.com>
 <fwa3hatuesbbsnk3o34nhi6ohpozkr74rmnqbqwxmesh5bws3r@abidzslkrily>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <fwa3hatuesbbsnk3o34nhi6ohpozkr74rmnqbqwxmesh5bws3r@abidzslkrily>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PYB1muyjJ-b2CYYA10XjjZ_JimLzqAD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAzNiBTYWx0ZWRfX6xCmuovlfnRs
 5ltcuIu+VeeuZq4ZAPIxei4KTlUrCHaJzHur7iSdv6CsxWeaIYJRx1TtHucpUMqr2WL8vUDZeJ3
 esu0pKG4qSltzO9/9HcyjvLZx1H3EgOyih0NuWIM2UJImQGuesiqMNYOBPfHytXkOrDCxeSvsbe
 QQrJFZq7R+BYLcwX1oYyTPBK5Mm/dGafKQTWpMvmPLxGusjGsowFWfHhj+zA2uv7Nt8sfdmaDnt
 Q/bNc/oPJdhAheCU+qlZ6H2yUSvGGQ9YJrmCi5rXoqv9E94v0Hs/ctre6oTOq4mjeSx7uFjYTTN
 q2V9EOYqbFFOKXHPUO8Kq6+NczrPtc4rMjwr1teMhEyjhNlEyLWxeg/de7LBOHcMGxUhzseKb8N
 WbmMn0ADRtKJoPFaq+4aMrVe2ym7PHfUv4ucRAZUy7mqW+eN6BttqGlNJjpdWiXArmyRqFoopp1
 17EhB/SZM/N9cvOle8g==
X-Proofpoint-ORIG-GUID: PYB1muyjJ-b2CYYA10XjjZ_JimLzqAD0
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b78fdf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0zj2Sjq5_81KAJ-Os-gA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160036



On 3/16/2026 10:21 AM, Manivannan Sadhasivam wrote:
> On Wed, Mar 11, 2026 at 06:10:38PM +0530, Krishna Chaitanya Chundru wrote:
>> Add a shared helper to encode the PCIe L1 PM Substates T_POWER_ON
>> parameter into the T_POWER_ON_Scale and T_POWER_ON_Value fields.
>>
>> This helper can be used by the controller drivers to change the
>> default/wrong value of T_POWER_ON in L1ss capability register to
>> avoid incorrect calculation of LTR_L1.2_THRESHOLD value.
>>
>> The helper converts a T_POWER_ON time specified in microseconds into
>> the appropriate scale/value encoding defined by the PCIe spec r7.0,
>> sec 7.8.3.2. Values that exceed the maximum encodable range are clamped
>> to the largest representable encoding.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pci.h       |  2 ++
>>   drivers/pci/pcie/aspm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 13d998fbacce6698514d92500dfea03cc562cdc2..48964602d802e114a6a2481df3fb75d9e178a31b 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1105,6 +1105,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
>>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>   void pci_configure_ltr(struct pci_dev *pdev);
>>   void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
>> +void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value);
>>   #else
>>   static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
>>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>> @@ -1113,6 +1114,7 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
>>   static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>   static inline void pci_configure_ltr(struct pci_dev *pdev) { }
>>   static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
>> +static inline void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value) { }
>>   #endif
>>   
>>   #ifdef CONFIG_PCIE_ECRC
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 21f5d23e0b61bd7e1163cc869fe9356d1ab87b34..d7f9ae9e48c25dbc2d9b4887e2f74623688098e0 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -525,6 +525,49 @@ static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * pcie_encode_t_power_on - Encode T_POWER_ON into scale and value fields
>> + * @t_power_on_us: T_POWER_ON time in microseconds
>> + * @scale: Encoded T_POWER_ON_Scale (0..2)
>> + * @value: Encoded T_POWER_ON_Value
> Nit:
>
> s/T_POWER_ON_Scale/T_POWER_ON Scale
> s/T_POWER_ON_Value/T_POWER_ON Value
>
> Same everywhere.
>
>> + *
>> + * T_POWER_ON is encoded as:
>> + *   T_POWER_ON(us) = scale_unit(us) * value
>> + *
>> + * where scale_unit is selected by @scale:
>> + *   0: 2us
>> + *   1: 10us
>> + *   2: 100us
>> + *
>> + * If @t_power_on_us exceeds the maximum representable value, the result
>> + * is clamped to the largest encodable T_POWER_ON.
>> + *
>> + * See PCIe r7.0, sec 7.8.3.2.
>> + */
>> +void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value)
>> +{
>> +	u8 maxv = FIELD_MAX(PCI_L1SS_CTL2_T_PWR_ON_VALUE);
> Since this API is for changing the 'capabilities register', you should use
> PCI_L1SS_CAP_P_PWR_ON_VALUE.
Ack.

- Krishna Chaitanya.
>> +	/*
>> +	 * T_POWER_ON_Value ("value") is a 5-bit field with max
>> +	 * value of 31.
> Use max 80 columns for comments.
>
> - Mani
>

