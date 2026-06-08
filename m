Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80E3B6C08
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911903; cv=none; b=fxmP9e37f1WuRhT0mDMa9dKLvPFyYT7RefbyWQnIgLeflYrYY7Juspekxyd9PDx0eiVuCEImqQ/S4IOOAsQhgTEvrlPqejps54KCEvkolxnn7ZkjNa6UJNK6wTORoaX+zj/8mrqXv8OvNQPzDG3BL2FaU9KLQn4F7FVxcGeVkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911903; c=relaxed/simple;
	bh=Vmr+hFusuYAL3gRCxgWvVJ/q4PobECw1SQhrGuoxjwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQeGb7GKvZ20jerwnV93FvhOPVe/1qTjhci4V77EjNY8FhPU4cwbZSMk1muNE5r4tmyalV8jqWjV9K7QhLi8+6NB8ULIPHDdCApyN6jVoTUdq6aRQAJNUsALdLIyl77t71ne6Aq1btQjQ8OrOmikrTBYjVcgB9L5cRLzhDjckQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k++ZXwGu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i46kvl/A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k++ZXwGu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i46kvl/A"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OfXV2385924
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 09:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Tzt3nk2yUkhDZipgo0L0eDdUW2ER5Qt+0SMe1w2hT4=; b=k++ZXwGuExiMngbv
	5eCp4gwEWx17XykpFT6ox05ja+dLT1GGNO2FdEdgO5HCk8dpTmyLAlGWd0KSYCby
	q4+ErgVOsLdFvtFzgi8+aZefsVYdjHvLFvvebeyi3L6Qq6yU/bX0sNiR/ZrMdTjJ
	f3QWiGmOmMAQcUnp/4JsvypxEJ2UA25Er9m0y69WCteH+KxPFlCsrd8auwDLLVEF
	mXrEyzEj48AhsHIXa3QsmB2ZAc+QmYNP0l+dcBfOB3H5LA20juozrFrvYaChA3I3
	IwFAddWNOzNGHQIxyOz8UcfTyGa/sa9gfXAfFA1k+4S395vWcyEU8itHNtkhvSpH
	Ld08qw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8xyjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 09:44:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5178ded346eso7700061cf.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780911899; x=1781516699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Tzt3nk2yUkhDZipgo0L0eDdUW2ER5Qt+0SMe1w2hT4=;
        b=i46kvl/A0fK+YiHst2YWqRKd47oyc3R/P+ML+r/CUu6LwUiD6AYlrVKOK5Kc/rcZZy
         /YNFeU6mQRmUWJwtbCILZEd0cINgffUoQ5lF8NiuSEKCmYDIucQsf6ZTUd43Hx6YHlRw
         5bfBjtGzEmUckzKEbv07BDNx8PICfTtgOo80EP0Scezi//Pk8gJRGuN3tS38nCOAPYkt
         997+7YLSmdNnOkUTVtyN0CLDCRneCly6yx5AM42kmZ+Pspim3aLyXarX6T24jDxy06ba
         rEEv2XO2CHNTs4+gzIv7DdEFh2qHuDqYPTSnqGAch4LZu0fUQ1OVOj+XkUA5BxZsgnQB
         QB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911899; x=1781516699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Tzt3nk2yUkhDZipgo0L0eDdUW2ER5Qt+0SMe1w2hT4=;
        b=op6s/4KyEL5X7JKtjKYrKMPeV+1WXAGc3Pj2F1FFgvfGMLKe/u2D+GVobCNHCjeehw
         ur36WZrycsENEAEQ1ZleUiHDNrdS6Z7hs7rkmw5ffrk4x93hGy9EETlVqToqXvgpMXeG
         zvB1qdSX3iH1o1robfVuskLkNIpemGOpBeMIDOz7KbCWJhrjWycKY3QnTKgcaIjWlH/L
         uHQFXJbgo8H0z95k6mvloEYl5zB+Rllv11pxmMfCpuJpsceE0IDQNKIizZh0oeygzlNI
         jW41I0QYkNG0GyFZ/vJcPbJUadTQ4aLjIXQ9g51097xfBcjP59tEZMgFw10ybBlLpjZk
         1cug==
X-Forwarded-Encrypted: i=1; AFNElJ/uDXZQIV1WlvgAYdaAEnBxZRnra3gZgW3rOnFnx7FT4JttTe4GvcLDDFWEBUb/txx3icMlMn674R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQ8J3ZuzW5a5P2JDd2Cabj5g4r26bN6ObIcyIEH35bNDKoRZs
	cGwvO0e4HahJ4DPOhjZGhtKpsvcV0T8uuP/9OcBGK5WLkR4ap4Mfgx2iV9/e0EzhzBS4trP/cce
	SsoLxIBfIiaiz8qqw2ODdc3+weAxoivaooSVtcO4SSmtOJhz3cUAIV4XMIpXz0sU=
X-Gm-Gg: Acq92OE1GSfZ5gekkbxYoZX24TujyW/JFXeSxrf8yO4dpng5YUTQZ8EJ4pYNCAon3y5
	HnxrMu53q814ZwwnXG67qXK5OV9ewSnM+G6+EmxPOc48RB9Aq3KT8W0RWkfOvC+Y1wsMLGuQO/W
	7kKYH3mnA1OL/DPC15dkT7GUtin2EsUdpskJAwVonagRoIzrXUC5FB8sj06UQMl2l8Z0gA6yuYi
	iLu6z/K71KSxBYnyTnI0dG6MhD+76m12NPwQnx1GkHwZ4JQh3h4U73zQ8vZn1FWkGzkWP/rr5Aw
	bOygp3WaxUTRCQZEP07TwlExpOuBsNA8guOMx5U4HX+90f8N1GTK3kU4dOR7+ofYEMx44MQSC2o
	5I2QRZVTgkJN9Mizc10Vs3IRNr/FNDSWoQp/cld2wy31PK5Wj1tYBRm9J
X-Received: by 2002:a05:622a:1b1a:b0:517:6b29:348b with SMTP id d75a77b69052e-51795c59f49mr123731841cf.8.1780911898622;
        Mon, 08 Jun 2026 02:44:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1b1a:b0:517:6b29:348b with SMTP id d75a77b69052e-51795c59f49mr123731671cf.8.1780911898263;
        Mon, 08 Jun 2026 02:44:58 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-691afe82416sm1478693a12.13.2026.06.08.02.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:44:57 -0700 (PDT)
Message-ID: <d291cd03-ffd1-43a0-b4bd-bbad6a4fcec0@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5210: Enable PCIe support
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
 <20260514-pci-ipq5210-v1-2-a09436200b35@oss.qualcomm.com>
 <dc7cb371-e94e-4f42-87d6-70f0f94d0d49@oss.qualcomm.com>
 <aiFhZsaZJoXzuMSk@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aiFhZsaZJoXzuMSk@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: u7X8eqVlPyxtTc-yIROdd2L0m8gaZOA3
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a268f1b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4c8ik4K-SmYL0_MpgcAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5MCBTYWx0ZWRfX2Z8wooWG8fCQ
 wsL6nvWKXS0nn6Cg8e2otlypSd+hqVxTWgtn6LNc1gQGRoiIqvJUKTHApyLB5eOZarLmLKFntz/
 LPZ9npu3Bkhf8/6LoCTpqcIvy+b/rgLukqdNkY9CiFdGtT0jzdMcE2t29xxUgkR1TLtvKcEhXnD
 Uczj3CWnsRDIbo9ipejDQUnsu3P8JgbfOxDN97lrsK/N7L78F7kFABWwrqJCiyoAg26CMogDD2e
 rYC8ZGIZTSNRJRz1y+ZZHvRA/HvayKgWdJ3y2nKmyMqIYv3joVQCcRq2C3Hn6fAtS/JUe0z45T2
 ffyJaeVHnBYzEr+ttzlXHbVvTxoCBt1AlwPG/CipV4koXrNdSwQhkczYrUXxuvdwyfbtPA2Uk3e
 9gnRs4y1OmUR9yFORKfOIt0OxtfY8ZQ67oFYJCClbouVcYyxNJKai+I3yh4eGJdq9JnsCkJsjz4
 DAMQDSqp9Jv+VUpf0Bw==
X-Proofpoint-GUID: u7X8eqVlPyxtTc-yIROdd2L0m8gaZOA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080090

On 6/4/26 1:28 PM, Varadarajan Narayanan wrote:
> On Fri, May 22, 2026 at 02:24:45PM +0200, Konrad Dybcio wrote:
>> On 5/14/26 6:13 AM, Varadarajan Narayanan wrote:
>>> Add DT entries to enable the PCIe controllers found in ipq5210.
>>>
>>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>>> ---

[...]

>>> +
>>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>>> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>>> +			reset-names = "phy", "common";
>>> +
>>> +			#clock-cells = <0>;
>>> +			clock-output-names = "gcc_pcie0_pipe_clk_src";
>>
>> Having a gcc_ prefix here smells fishy..
> 
> Followed what was used in ipq9574, ipq5424 etc. Will remove gcc_ & _src.

What is the name of the PHY's output in the clock plan? I would assume
it doesn't have gcc_, but it may end in _src..

Konrad
