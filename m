Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA90318ED9
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387292; cv=none; b=Nz9pjayqJHwJ28lkRg0RNGOurvSxJtk0pwe60kO+XiXVEBlGwdvE54bdqqJIqdLpxRwqYRRmamMOL6Dq+ErNMrQ5+8fEi9EW/oTf/Tw1oyl/rQlQwRnWzxFLYZ1Qm+YvuA+tO/bnMi2sThrZYX6cp1SUEbKc3lBzjScC4PNHzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387292; c=relaxed/simple;
	bh=DJi34l55nC0jshmqjUK4O+tmpesNldcVNWMQq3/FKIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kXBC8dSiX7xgyUO6q6lTXfbmywHaPssA3sdx22BelrWlWEpwfizrAKh+4cs7XfvL6Xpp+FLEosR9D1oM7SYA5cXK7ZiHHsrdyLqZ0/UgrPLyJPhqsGChEXxKrVo3owPDd0CazxxEBhMba0NY8gePthasAxWj1ZAxvNSDxB7jP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DwGqpX+Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eLNcRflQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DwGqpX+Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eLNcRflQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tjaF1015006
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hELCUs/F0rEveloJZAAxgjq+aHyLZKhn2O84b+AWRDM=; b=DwGqpX+QrqOaedXW
	7nvWuhK/b1JmSX36mpulkJiLUGzJixLkGULxAcx2o88rgEyK9AunDS7edllxVDFk
	G+OC6UWWzTyLyIteJaq4VjGNh/jIhP+Y2DGYnC5vvGvduw//r4lZ83GaeT9dFWq0
	bKjPe8DlEMrojHk5jVMWwbO7tf/ohpep71C6hyzqX5jhXCCAvAqUM/1PFoLnkAne
	S/YMkU4izjsR40jvikoiAu8+xgrWixtcXUVpG2f3O3Hn2w3LcLGa83N3/na1I4lH
	jJDr+aYNhfRQETYOJTq+VMurBcOCr9/1Zdz/1TCOPAGZHKtRycH2VUI9sN6ph8MJ
	Lkc3jA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cumvdmcjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:34:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd849cd562so1206158485a.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773387288; x=1773992088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hELCUs/F0rEveloJZAAxgjq+aHyLZKhn2O84b+AWRDM=;
        b=eLNcRflQ5miJhjzBTMhN3i+tAbPY1Quc+7IUQJUZa5PidwJVsdf86UI51NsTiNmuWg
         AEZ0WmTrFSkm/DsuSJXYTDXupq0wJpVOhwbPYelFPg+ag96H9F8e/9S1Hf27sPS8R/fG
         RBE+7PcErjjeyT9qNszI80WL3EPsFy7puLkORdo0ttIkU0wAXWjfu4Erw7mDKiwNqlVf
         4ILulxPBP8BQW1/Sv5vEoMqDALX4+nxysfrz/tQ90EgH7DV3kFoeLBaPkbIA8Lge7YyA
         ECn/JV2Li6NGzg/c5zptWqCZ9HCgs5Lp9FQrKTZcMus22Qt3iq155xWRZ+fPio6BiWx4
         o2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773387288; x=1773992088;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hELCUs/F0rEveloJZAAxgjq+aHyLZKhn2O84b+AWRDM=;
        b=Efo/ofQYo1zaidsCV0OgfI+ZoWzuG3EB0iNBE9fd5hm2rAc2j0/Z4m/gfrD//T8vtw
         TUa2NMtKth106p01DKHWOpPQVE96HK8OX2rTNxruqbRfY01KOCrhP7B6eOGk2pUd+tJ1
         lbYzeLk6CPA4aTGbd84aNmF4MkKcuOhbCL1GdmxGSvQXWYsgIKlrOI86fPX46fgOCxSF
         oBjRzq9aZnfqdZirERw8VdrsrDyiTh9Ss1bDrQF0Gh9RWpuZsKwa3Aa3h6n6ACtifrgL
         vr5l1SXNxe20Q1hqmXuQUmYEpVU8QDCCG02Ra+VZuebXb+ZuH/KartruonbSt+nJYQ5W
         1Jmg==
X-Forwarded-Encrypted: i=1; AJvYcCVnx7Ech2jWoxGI0SfeaMP/6ij5Uc8MrFueIElf6sUMES5qTF6CE3SUF9OmoYAX+G7oq3j0YTWPm+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsMBpvD/3Ncg8jy3W+MrSvYu6aOoEmFkU3/yho2wx+iPh7k2D
	5ck6Rw8VvIYjWUIpXNXX2FKBZFU8Sxrwrql3SLii2p9nMJgwkdSRMoaiqwTs7d5zIUzMy1C5NRW
	vKboDT+kwfq5JNntQsZ8LZ6Htg/pEyfYiLzEkAbRWq8a/R8h1W+BX253sJk9MQIM=
X-Gm-Gg: ATEYQzwRTyngkaecq/jnRqMZd9qVxmBNgXs5X76stzh0CwbVESWvzDyu1xsmkuM3se8
	C9lsb8eYHT9zZlAVdFYxb6omICRvyihy/Bjwl7/3InEi97d50s2MgkBXcE4WlMyE/FOnu1G+KoH
	H48QFNd6RLlBIH0WHjdDaTVAzrCksEAd7NAvob0uLL3CMNB1ygFngsEqGeD+XOrbl34jga9rdXB
	BqExk2RQmSjhALNR0/kzzhIIBKASZANFMdo+SnnQpO4IQLHFu9naHzGwBlcV81TocQ+lFFidCRQ
	1EEMBXu2wx28MJh1cFM8BR9c+02YfwHyZ0CFYTnlQgqUpDxwPxdHMSrq0hf/F68sFbv1svW3Xgq
	vLpHrZSylUVVoa3CoYTX1QKcFn7J+Lj5Za6u+C7wDO+rP0Dja
X-Received: by 2002:a05:620a:711a:b0:8cb:4d64:e990 with SMTP id af79cd13be357-8cdb5a50281mr316428785a.10.1773387287669;
        Fri, 13 Mar 2026 00:34:47 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:8cb:4d64:e990 with SMTP id af79cd13be357-8cdb5a50281mr316425185a.10.1773387287155;
        Fri, 13 Mar 2026 00:34:47 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a7473fsm13540265e9.14.2026.03.13.00.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 00:34:46 -0700 (PDT)
Message-ID: <2d658e4c-6840-4218-af78-b01a09218410@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 08:34:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Explicitly
 deprecate reset-gpio
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260312184344.42337-3-krzysztof.kozlowski@oss.qualcomm.com>
 <VI0PR04MB1211433ABEE52392089255E639245A@VI0PR04MB12114.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <VI0PR04MB1211433ABEE52392089255E639245A@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1OSBTYWx0ZWRfX1khHL5Y15JcX
 Qz7p4elTfhuHzlDSH4/gTPPb9ozzkkxGOMFuB3zVqpvBfvz6MR2QVfeQmOLcec9axm5qj9Du1fs
 EPscw5qnoZTDWzg9cpEH6bd+WBCVgmXYJS+LySlbXKiwUYCFGIIzWXyYQdQ8H9CHi6o7NJfeoeC
 jh073D97b6cn7WElKyBX4DBtlPZugNnNEgyI7Hv0iMziqdfU1ymgVUu6JpUV4palWmg0jlYUEpV
 ViuSFHUvDcmoARtfJUpmbYXfMIC6MP690DLKuK4i5Les2RVF9DMBJKIwsy+2JcSUyP5CiQE/Cqq
 9OyChqvok7Qc3+XOiTaFP3UcoMeM88B04N/2nugsFcFJHl0nrdVDfz2vTch1wg7z1o03zRhdUQU
 iTyJHiDqKs7SRBItQ9+axIvrNFJJdrG12GZjVdODDWK6XaBEz/oz3buMkfMMpEt5P/e+5zveNn+
 JADAWH5XNTxZfrFII8g==
X-Proofpoint-GUID: vcSerJhTssVwQyvcITjI9kxvMwNdLrLu
X-Proofpoint-ORIG-GUID: vcSerJhTssVwQyvcITjI9kxvMwNdLrLu
X-Authority-Analysis: v=2.4 cv=XsT3+FF9 c=1 sm=1 tr=0 ts=69b3be18 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=A-5nx1WiAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8
 a=3IOYHEpcAAAA:8 a=9h-gfNwrwJmJoll2F7QA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=BZqX40pHnTnlEzTK8NCm:22 a=ST-jHhOKWsTCqRlWije3:22
 a=pMmX26BmL46gMeuRjYg5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130059

On 13/03/2026 03:27, Sherry Sun wrote:
>> Subject: [PATCH v2 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Explicitly deprecate
>> reset-gpio
>>
>> The binding references snps,dw-pcie-common.yaml which already deprecates
>> "reset-gpio", however mentioning this property here lacks this mark thus
>> code is confusing and suggests property is not deprecated.
>>
>> OTOH, the property cannot be removed from this schema, because it is an
>> ABI implemented by Linux kernel in gpiolib-of.c in backwards-compatible map
>> between compatibles, "reset-gpio" and "reset-gpio-active-high"
>> properties.
>>
>> This creates code and binding which is not obvious to follow, so rewrite it and
>> be more explicit about:
>> 1. Deprecation of "reset-gpio",
>> 2. Relation that "reset-gpio-active-high" is used only for that property
>>    and not proper "reset-gpios".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> ---
>>
>> Cc: Sherry Sun <sherry.sun@nxp.com>
>>
>> Changes in v2:
>> 1. Rewrite the commit completely after Sherry Sun comments - keep the
>>    property, but add "not" clause to forbid usavge of
>>    "reset-gpio-active-high" and "reset-gpios".
>> 2. Because of above not adding Richard's ack.
>>
>> v1:
>> https://lore.ke/
>> rnel.org%2Fr%2F20260311154955.145120-3-
>> krzysztof.kozlowski%40oss.qualcomm.com&data=05%7C02%7Csherry.sun%4
>> 0nxp.com%7Cc630bed6bc4f46715b4408de80675002%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C0%7C639089378371805072%7CUnknown%7CTWF
>> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=A%2BiFa
>> kDVdjPn0JJxUDlTDt1ej4iqnBivDktjwbcpFK4%3D&reserved=0
>> ---
>>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> index 12a01f7a5744..12cd1b9f78d0 100644
>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>> @@ -62,6 +62,9 @@ properties:
>>      description: Should specify the GPIO for controlling the PCI bus device
>>        reset signal. It's not polarity aware and defaults to active-low reset
>>        sequence (L=reset state, H=operation state) (optional required).
>> +      Deprecated, use reset-gpios which respects the polarity expressed in
>> +      phandle argument.
>> +    deprecated: true
>>
>>    reset-gpio-active-high:
>>      description: If present then the reset sequence using the GPIO
> 
> Hi Krzysztof,
> This property also needs to be deprecated as Rob suggested in my previous patch :)
> https://lore.kernel.org/all/20260121164002.GA3427694-robh@kernel.org/

Heh, why that patchset isn't merged already?

Best regards,
Krzysztof
