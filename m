Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BCB2DC32A
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777431907; cv=none; b=SKGO5AwAhKoZ8ekRrJL3msveU3URuICXytEhakl43wGZwe6SCSgXH0wqLij7Kxm/9Zw/42EgxY7iLStXMy1XXkuhgMw4EQ5mhTRaWRHiAMvKYs1f5A0qey+QwrG3YOGbHd44mTUNNzMP00mI5vIVOIi+yu18IxEjVvwN54IB6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777431907; c=relaxed/simple;
	bh=2GGUiaHFX5KqOrq3sYTX7GQ9oHEzmTcuK0OpVgkkJC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcxRvOTd/wrwbBc737+CA3dFUjqrbgq3idvh9O1tC2El3kCPyxrbNUcvfg/1s6V2V37sx4S6EnSqtON9goDH8RH2ELpAj7tXnDCUD6HFZtRzKmizmpNbvc3U8rzaVOPqbXi1NmBXWJd+erQqJVVs59QRK5+FkDpIOILaWItbgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKWBnnyx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tafkcv9c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKWBnnyx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tafkcv9c"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T1KBBR2890881
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 03:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DvpF9N/gAyKtXmKaTyV2WHzu+7iolN9prQ5oE9ZY/7I=; b=CKWBnnyxEvDgCE8D
	00r0hxa8rUY5rWZR0chUO27fCEA2MsqSVfdgvwRt3cBLHx25nwas3fXU9PStCOVQ
	w7MkaSDQEpqnEIlIUIfJhAQMaQ9hy23XDqB+AHddc9iz8QONch/IzCzNaERn7Yiq
	xyKJ8sHHP3N6TFwbCz+dYXd1eJD5paV8MLDmDiNh2DYVFjV0JtmysO0lZlmojGl0
	t0TBEIiiQsLkN3oDE+4EUdNMB5nSdbtXF3oitlc++9+V080gXRQAIiVOBW6DPL9n
	ZE2JfZIMKE2zMA4MXWqmx24JcF30n0HPaOkqPKrFTjmEPX/9E16VKACeNKJeajFi
	DVPQGQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttgyujny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 03:05:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b465bf993cso123704035ad.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777431904; x=1778036704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvpF9N/gAyKtXmKaTyV2WHzu+7iolN9prQ5oE9ZY/7I=;
        b=Tafkcv9cW0pMGZv5/cBxU8et4zLkSZUGBLJDH95oXU8YEejyt4MFkTj5MMCiJNtL1o
         Y9RgQzkGFnSqOczfrGbsHvfO4jlZb6Qp/0hS2ItfZ7TQjs1nTi68tHprya6NJlorD2tn
         SELxYidjjqofknBlEVrOWPNhKkBmXhUT6khnPhSMwGDPP/PZmOyner15xNur9PdPeMlE
         KVjNjFCXsgVSWMIfXRSZe8f9RAypUFmBprfsEKthKMRtgGrdUk0NzHT1NmsJERsq6tZo
         FObiDQ82xeXCrvY3YNif4OLihC4U6p1t8dhYzeJfNt26GS43RB1sonbzQvy1p81MXzMo
         O7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777431904; x=1778036704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvpF9N/gAyKtXmKaTyV2WHzu+7iolN9prQ5oE9ZY/7I=;
        b=cVNg6i72Bj/fVHzFypl1SPjsOU5ttPD/BYxT5q5TD/sAhbYrtpfKOdOj9EUYzlUQCE
         f22w3m1yKtrkbZRl0/LRZXCqRK8xVGbrSHAVNFvmoGmQk4tjqu+dkCM7Cc0/zTBK+hWO
         Cog10ChlHh2+pAk8Kzg8EmGM5HvkNqEieITnjydOCmn7Emt80/NvNNyJgf6P9XHX7dMH
         3+ZrcxGa9XEnmwCgTaVkwPeFLwFEfBkU6vscru2GFbJJ7KE1q4rIh4528ecr9ivbIcwe
         gKrmleBc0VTp/nXTeA78z+ELYSzPGlzx8zf5EpoaGLK2aJpl8cW3DCtOR5yC4mNxYv/K
         o1wQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yKXWoKD0fy0cnee5f/rC8GV4gAlCcQvlZR6/j+FCb22auNLz9ZkqDR6SPaCInYrwRQu1d68371D8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7O9u/9laOce2mjwZMJvTq1FDqhzs/vQaJE/fTTDi0ye3eBwuI
	Jmff/1x5T0RsuVE1tXlKDUkM1BVnOu0khqfT/VMgKWzMW6M08AQah0J6gC2Vsh/7kxrYQBRdmXB
	oVYJDy7rRAq7+VfJGmDvxdCr/MZ/4rqCrDLrDQw0+XORiLAq+RTrzNFNmz/xynOI=
X-Gm-Gg: AeBDievATd/OOlbHyZQrkWmkRIXACpzZYZrKS9Ea5iLCElmquhg6ZFzbymjbyyEc7Vp
	ZNAtMj0+zYjCgtE85CQWLWoCw6kyNGvUvRfKCgy72X5YrE6sjPwtVr2lvLUcdbxcdaMu2Ddcen9
	Zbc2dCuftXTDGEXsjsIJVfV/Xc38RBtNHX0XaDC90lLpbmENPkKI/QgLzh+u9PbYYBY5JdMgQd6
	nkTryc9Xotd0rBQEm+/Ps6W15+V6od2+dUjas6kZsoK4dLjSCwd7rxRAWOLJlaTka2t5yX4EFkN
	2pU+FoCq9g5C9KNsLiAlmLI5wH9R5enFYFeJ62nfxOL3SDdGGzotuarRu8zHn3hS6Z4fqME2NiR
	mCGjcb/n8Iud++j90UV5sBN4fcDuesDQ/KkOquf0wQIydsmkYAWHPHDkoeiAAyWR9Ng==
X-Received: by 2002:a17:902:eec2:b0:2b4:5f67:5914 with SMTP id d9443c01a7336-2b987442b4fmr14370725ad.33.1777431904456;
        Tue, 28 Apr 2026 20:05:04 -0700 (PDT)
X-Received: by 2002:a17:902:eec2:b0:2b4:5f67:5914 with SMTP id d9443c01a7336-2b987442b4fmr14370415ad.33.1777431903925;
        Tue, 28 Apr 2026 20:05:03 -0700 (PDT)
Received: from [10.92.193.222] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988940d08sm5813365ad.43.2026.04.28.20.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 20:05:03 -0700 (PDT)
Message-ID: <28c30ddb-f46a-458d-9680-eac1ce8c5b68@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 08:34:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] PCI/ASPM: Add helper to encode L1SS T_POWER_ON
 fields
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
 <20260428-t_power_on_fux-v5-1-f1ef926a91ff@oss.qualcomm.com>
 <bc3a5f58-676a-3634-6b8f-bffc91d25265@linux.intel.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <bc3a5f58-676a-3634-6b8f-bffc91d25265@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R-2Q-lPYthGAK66DtK_oKFP9mxvfIsil
X-Proofpoint-GUID: R-2Q-lPYthGAK66DtK_oKFP9mxvfIsil
X-Authority-Analysis: v=2.4 cv=cb7iaHDM c=1 sm=1 tr=0 ts=69f17561 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=Zlw8WEmqWycuYniGgb4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyNiBTYWx0ZWRfXzYTPe6EXTA2N
 6GXQop25UoAQAXULl8+76ezQtPmnQEI8LAoxYsTeRO8A/MKJP9PeNG8/BTLKfvG7/jrZhh13h8o
 LG3dnOF6MkwMmV3CQfeBaS8yn7dTCtWwqbpgKyJHpPEoIpv2jdsz6Nfo/TYMFcwhLLMD//Qf6rS
 E0BKqPsqMqmzKZIixtf5lsmFVGxLhqixqTtHCPyOWTBAC/qlMTcI5kkZb6AYZfmnY1u0K7eUByo
 S8Kir1JqKQg4lrwelHVw40tc33+B7H1yRS0vgnTnMBUZCK2mT6Air+4Y7/v654bnmb2/jxpHujV
 wtadoAyGY7+2p+YshD2P1PP3XagucsBIrYi7xIDemM+PH0m6zGMZWpbesPYVgUGpM6rVcMmmdwM
 hTr/XQRVZ21vmmhwvClb3Bp7lHBp0XQS/GfAIMX7pqUbavcSAozPJLUr+zUzq79+uEp+1WsYplh
 9GAIv74JGMCafiiONVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290026



On 4/28/2026 2:57 PM, Ilpo Järvinen wrote:
> On Tue, 28 Apr 2026, Krishna Chaitanya Chundru wrote:
>
>> Add a shared helper to encode the PCIe L1 PM Substates T_POWER_ON
>> parameter into the T_POWER_ON Scale and T_POWER_ON Value fields.
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
>> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/pci/pci.h       |  6 ++++++
>>  drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4a14f88e543a..c379befe1ebe 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1110,6 +1110,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
>>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>  void pci_configure_ltr(struct pci_dev *pdev);
>>  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
>> +void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value);
>>  #else
>>  static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
>>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>> @@ -1118,6 +1119,11 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
>>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>  static inline void pci_configure_ltr(struct pci_dev *pdev) { }
>>  static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
>> +static inline void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value)
>> +{
>> +	*scale = 0;
>> +	*value = 0;
>> +}
>>  #endif
>>  
>>  #ifdef CONFIG_PCIE_ECRC
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 925373b98dff..457d469b8d49 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -525,6 +525,46 @@ static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * pcie_encode_t_power_on - Encode T_POWER_ON into scale and value fields
>> + * @t_power_on_us: T_POWER_ON time in microseconds
>> + * @scale: Encoded T_POWER_ON Scale (0..2)
>> + * @value: Encoded T_POWER_ON Value
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
> Hi,
>
> I don't know how the type for t_power_on_us was picked but if it was 
> arbitrary decision, I suggest you just go with 32-bit input.
The maximum value of the T power ON is 3100us, so we are using u16 here.

- Krishna Chaitanya.
> That would also remove the u32 -> u16 truncate done in the other patches 
> of your series which would potentially corrupt the number (I assume 
> numbers that big would be invalid but they could alias to small u16 
> numbers).
>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>> +{
>> +	u8 maxv = FIELD_MAX(PCI_L1SS_CAP_P_PWR_ON_VALUE);
>> +
>> +	/* T_POWER_ON_Value ("value") is a 5-bit field with max value of 31. */
>> +	if (t_power_on_us <= 2 * maxv) {
>> +		*scale = 0; /* Value times 2us */
>> +		*value = DIV_ROUND_UP(t_power_on_us, 2);
>> +	} else if (t_power_on_us <= 10 * maxv) {
>> +		*scale = 1; /* Value times 10us */
>> +		*value = DIV_ROUND_UP(t_power_on_us, 10);
>> +	} else if (t_power_on_us <= 100 * maxv) {
>> +		*scale = 2; /* value times 100us */
>> +		*value = DIV_ROUND_UP(t_power_on_us, 100);
>> +	} else {
>> +		*scale = 2;
>> +		*value = maxv;
>> +	}
>> +}
>> +EXPORT_SYMBOL(pcie_encode_t_power_on);
>> +
>>  /*
>>   * Encode an LTR_L1.2_THRESHOLD value for the L1 PM Substates Control 1
>>   * register.  Ports enter L1.2 when the most recent LTR value is greater
>>
>>

