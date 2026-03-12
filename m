Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E83FFAA8
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341018; cv=none; b=nO01iZ1R34xFkfeUzWQ+hVtwF3MvsLFg/lqQ+WVaCfVarPdJFJz1Djvl8a27z6FtHMZ0a4AcOsSDJ+eJZf5TdHvxJAgZBWpHSxS2XtfLEG3a4+CU3SjbNYSax3KYAsfIqQWCZHwqIi19n+o21IkY2h/zn96p4SMAsXIN/3X7Obw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341018; c=relaxed/simple;
	bh=UZd+Geb8yG5u7UAC+xwI5W/xwTRghe55WnSVbIOTPaI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TL1DpY2g3OFdZfkll+/SY2Z8xX5hyzwpL0C71uy01m3IzBUxr0mUHcLULBued3hUt/n6xy39HUS9BTQn2JIkgisMeX/4J/4VX/ZAgAdsYJ0vc14ZIDcEdEijWlSdGfsnZO8eqP4hdItI8i8Dh3Ah0KGn5bQ8/U6+apXrq7QaYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1V66zlC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KE+sUx9F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1V66zlC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KE+sUx9F"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9XRva4028372
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 18:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Zc01U8xwFgE7zVY6+zc3nHFgkyKZtRvurVNrgmn4qM=; b=F1V66zlCPKRa6yhx
	e7Pc8eTmX0CuyIUC8aAypkjsBzrm7ia2GTrH8ohrl+uG2jLbRp0/Chn/yYgzeKdu
	e3QtrAwCMFhoV0BRtYRm2dxmyl8ungfySC5cxXCs9fFz2cDoJna86KZuR9vfLcz7
	roXIRquXWl5xV1wKExCgq2UUrfvl6hPNx21GL0velcnbb6puTE5rR2ECXGShmDvc
	qeauZzgaGgipOFWY5Jm754jcB52+D97dHVFdDTB01vCXrtGx74pJo/P+PW3Zsaoj
	eAGafmiZ4mgxUK/GuR/0yFEGBoz1snCoJPYeEsgTb8HRl46oCvoOdVgSjx6pjAmv
	oBNfhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh54u5jg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 18:43:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd77bc8186so1240503185a.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773341014; x=1773945814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Zc01U8xwFgE7zVY6+zc3nHFgkyKZtRvurVNrgmn4qM=;
        b=KE+sUx9FmLVT3HqsQBHYXz2sGTdi783FP/CPYP5wvC4jDfKxNShPpVjCbYFHBuTBCo
         fISG/5cCqQpa+YKfHFthr3HD3b16tTYHcdh+FS5djNA8Jfk76cSbOyyn30zAoDEzpe/F
         ukzd4uI10H+r3QGwwwMUxxaYvc5T7zXX9IKu1UCiEwYJ64ObH+WLxYM+C8yrF3+6qjTl
         2yIHpG4/0te6sQfGafL4Yj7Bf6XPvGvg6EkRyAfxzAsJfhd3dOLuHpgjyRFyMGUfZ1Ki
         usdhqhVH3tUbyy2nRPUP0HrbobmrOA2P+NdLVF/rP0H8kE+sE4784cyBGqYsVBPM+aIK
         SiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341014; x=1773945814;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Zc01U8xwFgE7zVY6+zc3nHFgkyKZtRvurVNrgmn4qM=;
        b=jaGgsggy9LVewDZ+Ruf7YwfwQ1iibYcTlB2/x8cLcMW7Xiu73ggJpYu+i+oGz6Ugtg
         +wMSp9F0NNBKm6AaXdMVOzIcMOzwF56L3stat2ayz1cTFJuu5Nv2YDbiAoCRuLAO2qUC
         rLd36Xkz+uUdQkYM2JSYsqxGzRn+MqcgkgHDfkZdz9EcXIFNqmqZ2sSATowEsP9lx2nx
         qlfC6ue2MeHp7woh76der/bCaxekOdrl0BKGe1GzSdM6Hk3wOJ8ce3BAQ/s6FhCfOVr4
         O0AJjXHKOgIgOYWY4KIZk7VrCmZ7/vBxY4toXUqoDh6G5zfmd2PLs6HMFUGQ/sqwJYkI
         M0+g==
X-Forwarded-Encrypted: i=1; AJvYcCUkeFcRrp0MRWw2Y/HdlFBgZnmmH92M6mbHeAyBgxDXTgtwUqxCJePFglwEfhKIRtBDNH8qvOnA+AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFr7njlyMoxaprvCJYbm0f05Z9//D9iV9sfuh3KrmyiK8fyLyg
	x0w7vo4RIo2D9c0KbB1c33WdHhkRhqM6RqDdsfAxlVd1rcPvaktHfeMYuHHLEAcdslKgNjk5yf4
	sqW1XWt9ZLTrEK3mGsNf+xxikbIqcL3Y7Z9Zb+PIl1GKoFloYTmPhUhjKHTlIrYM=
X-Gm-Gg: ATEYQzy2o3jwzPbTF0QMSvLnJQViORqL5O491jU13u1tptcKrGJ0ENQSTJlimBNWRcE
	l3HDR02Nz9yb5MVtReXlZbXAhaI5rvPw+2uAihjnVfPqLjr6XhTTN/Y9eW3DOiJasIWddcFg0bz
	cgJFVwr5XKGW+srNm9Wh01JbKdnnI1+Z00/1GT+RrY9nZbUL6Eb98ObwaenweDS56HZfLtpcQYY
	Ho4k8WJF5GJzV6CS7tETkNS1CcyANrRem6EjvEOUs7xJoydI+JvOyFUcRkKRUEDfOKxUgRHf4Bx
	iZzUYP/V4PfiBLMmwU44exligMR6r8M2di2+ir596+ddp0oI+sLPsvDsDtS2wtQvaqx6iuo2jCn
	aXREk6dgFuuEN5HpY4/h9/Q1eqbbZPLnS7sqf0tH02Iafb4RV
X-Received: by 2002:a05:620a:3195:b0:8c6:b247:4c with SMTP id af79cd13be357-8cdb59ff4aemr119412985a.2.1773341013721;
        Thu, 12 Mar 2026 11:43:33 -0700 (PDT)
X-Received: by 2002:a05:620a:3195:b0:8c6:b247:4c with SMTP id af79cd13be357-8cdb59ff4aemr119409585a.2.1773341013241;
        Thu, 12 Mar 2026 11:43:33 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485419c2930sm412755315e9.0.2026.03.12.11.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 11:43:31 -0700 (PDT)
Message-ID: <2ee77136-0bdd-4661-a5d7-83869e63273c@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 19:43:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to
 undeprecated reset-gpios
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sherry Sun <sherry.sun@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>
References: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
 <VI0PR04MB12114361EE728C74CEE500FED9244A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <800fc82c-1b2f-4330-9a25-e1d067dc83ac@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <800fc82c-1b2f-4330-9a25-e1d067dc83ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CjsLuBSQ7ByGaqJ2mIUdOcWw_YhD7pca
X-Authority-Analysis: v=2.4 cv=BNG+bVQG c=1 sm=1 tr=0 ts=69b30956 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=T0qWzi58jBV6o7NOTdEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: CjsLuBSQ7ByGaqJ2mIUdOcWw_YhD7pca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1MSBTYWx0ZWRfXysTSrWFP1rJv
 rRjvVJimebJZBgFiow5l+zYwjJ84uKaUeGg2RCIPamT99EZ4uUSOnJiSCYSwa0Pq3pgLcHth6R0
 UkU6Q4ik5ctNvz+SzUis6CsTBUvYjFFSn6eg0WtdU8ano+C67ZHuj4iNQsq+1mslCP0lEpX1S//
 1CC2gqV0+SNTm4+WWZcAMkORfeIiLdItK/w+DyrPR/+YOKFgJZAVnktAKU4avMqDMFMe75uNuYk
 VQLZddSqvkf/9xf5Ca8hUrIFxivtNx12UrPseZkaS7aA/o+zYbdePD1CeV7kocWNOubda7iQ/hb
 ni7LIQQSWfLw4AWJL5ufMe+YjsmL36hsS/84+VnXG4j0Bf+vJ5SkB25owqfWsBGUWzqBbLwCTiR
 E3aX5TVvTfb0McM6ze8iAPq0pdOC8UkflAfjgJpRu7pVPnUhsADg3x2TGWydjrrhjheAp0nGKps
 DjyhGJWudPybTPQbhhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120151

On 12/03/2026 17:29, Krzysztof Kozlowski wrote:
> On 12/03/2026 10:18, Sherry Sun wrote:
>>> Subject: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to undeprecated
>>> reset-gpios
>>>
>>> GPIOs with "gpio" suffix were long time ago deprecated, thus "reset-gpios" should
>>> be used.  Linux kernel supports both, referenced schema snps,dw-pcie-
>>> common.yaml lists both as well and this schema uses
>>> unevaluatedProperties:false, thus change has no impact except code readability
>>> and removing deprecated patterns.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>> ---
>>>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>>> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>>> index 12a01f7a5744..b9ba938c6239 100644
>>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>>> @@ -58,11 +58,6 @@ properties:
>>>        - const: msi
>>>        - const: dma
>>>
>>> -  reset-gpio:
>>> -    description: Should specify the GPIO for controlling the PCI bus device
>>> -      reset signal. It's not polarity aware and defaults to active-low reset
>>> -      sequence (L=reset state, H=operation state) (optional required).
>>> -
>>
>> Add Dmitry and Bartosz.
>>
>> Hi Krzysztof,
>> Seems this property is still handled in gpiolib-of.c, see commit b8b80348c57b
>> ("gpiolib: of: add polarity quirk for Freescale PCIe controller").
>> Maybe need to change the quirk gpio_propname here too.
> 
> Oh, I missed that completely. Thanks for mentioning it.
> 
> 1. Having this property in drivers/gpio/gpiolib-of.c means we should
> keep it in the schema as deprecated, because each ABI should be documented.
> 
> 2. I can drop reset-gpio-active-high from DTS as well, because
> reset-gpios have proper flag.
> 
> 3. We don't need to update gpiolib-of.c, because standard flag from
> reset-gpios will be used.
> 
>>
>>
>>>    reset-gpio-active-high:
>>>      description: If present then the reset sequence using the GPIO
>>>        specified in the "reset-gpio" property is reversed (H=reset state,
>>
>>  Also change the "reset-gpio" to "reset-gpios" in this description.
>>
> 
> Also here - no need to update, because this will be used only for
> reset-gpio.

I will send a v2.

Best regards,
Krzysztof
