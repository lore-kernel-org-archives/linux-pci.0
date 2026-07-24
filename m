Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD63A900B
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881461; cv=none; b=VMBHu9mMSlcOtm93QmQTFdAgbF/01a81ze6zX+0J/DgTir6wZ8vlgD72+wyocJub+xc0BoIkp1S1VRza7vNMBJzLa6qAdzkLrtqYRzdMvTn37juunVIi5ST7pbZZfwpvNvi4wxwpA0HbedQdH4UNRdnamqF130LgRyZlruPANK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881461; c=relaxed/simple;
	bh=Y0EyfXp7yrNeq21sEKo7MWHCuPuxTv8jOAGHJnXAXeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh1pC/HbLo5RDx5nvmp5TAw4aLeepPemeBVfWCOyoE2wiSp3IVJRAHusWvc/69l2OE4CTJs+0/FtwOQUhJfKEGb+RbzfuN+83KQ39NUYMSrL9s4jVJQHPkGS3ru5gYyK0+Y3Pkmz2ITQDgF3RcnoVdSCOKfqx2bEFTzJuFdyiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n33EMt0c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FcK5okjD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n33EMt0c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FcK5okjD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lLGe2276409
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 08:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	askDjVkAxFPwvHcTAV+zi0ANzlszBe058FKv0G1PdwM=; b=n33EMt0cWSBDjcgB
	O7MV2O8mJWPTix6kb6a7pDbAKyCysKiyMUaL+XcDQmRWiJW4q0gy+cePXJ4ZeUtR
	sBBugvXwzWY8n32CGrkD1lUF2LaKqAZW85gmn2fJPbRAWPIEammoKjBTeXvctFwp
	JRdZXdvLVl8GgVFS0nLkJCwehkRQNGgBRJM2pza05SDH09nV2XIIoD6O1UVerjUf
	KJtsa/A1HpNVuHQPEH7I9bEzMVUK6iEVscwStKH3ALPLQSm1SYsFR74Gmp3YtIZ+
	Icw5s6yGbhmGzU0EALLeCLsIJi0M2E/FknPpr3OGZAQS1N0RyiCVodsW2zE3vAWw
	iDq8bw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0atpa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 08:24:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1e6f602cso2441441cf.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784881458; x=1785486258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=askDjVkAxFPwvHcTAV+zi0ANzlszBe058FKv0G1PdwM=;
        b=FcK5okjDvQtyVb3oP0HtV7Hbh+bCKtFZ6x66wQrCN7QtRL3KcEO3iLhh5DjXuFvhbF
         eKzqGU+JSOA9BlTDnvTGYeFZxLAWma/M6GpQDnUdjJoyZfTYdVf+Y9q0jYquS/bcJh/J
         rPO+LCQBLn2qqYTKFPMhY3lp3qWGLCfFvbQlvfYHDtYoHda+lPsoyNe4ANAAnBC3/OjU
         t+tRB+UG4SGGHLZzD/jD2ZdXHV4suc8y+PhX4e7/d28uCEnTluM0TWdveak4+QRADYWy
         J3XYxqivtEkMv0CXwAFSQtb2AhdSMpbPmh5EoCpEAVWx7E8fjpXnRM6fgc8mwRiZh0I1
         IArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784881458; x=1785486258;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=askDjVkAxFPwvHcTAV+zi0ANzlszBe058FKv0G1PdwM=;
        b=XLYGALnmmkhtwToApRNRxWnRVrCjf5iNOS4ElFDOcXvTKKDTvvLViLVThmIIt67azZ
         P3RjuDTBWYNQb3+E/1jVblS0oJ7/trsSVKiNR7Q9D9BKcHJN1gOM2oPDQswyOA4AWqcl
         rTjMPGfFhvpkiPUQMDjMydFMqFyPy8kFnLXSa76oFJEb2mk3q8nusUWSwYjJ8NxNuWFk
         hQNqfd8Zggl8wCeMKyV+8noViuNq7wwhpUNVqldb0C9MXnpCs9ITTrPBr1lnIW4zYI21
         plD6DjowKWrQ5YmpTMO2L645lqU1iTdtj4dHTS4xQPLGBzBUWD/NzMqYE7xyqAZu3u36
         7fUA==
X-Forwarded-Encrypted: i=1; AHgh+RpGsoBT3Gv9skWndWdBs36dpvgIhtkcUowJNGHwOPECpPCADsaim35wth76zKFaoQVMKiHGzCFpaF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXC086vWZI9e3Ts/cXuJTWl2WPOd27uAgo+pl4M4qRgOe9luUg
	zD90UUOPzSMmVs69PXo1OCGne8/nRXCgFavgUixGHqO+1h/bH9zl7MVEseuUiOdWCRVlS7KHvvf
	n1Iu3ny9n0d3/L39skV1pyRQn9KrVIM9voXGOAjU7TOU3/zWeAry4N/SpB1s+R90=
X-Gm-Gg: AR+sD112Drpw7WnejdiXFZciCTDeRf80a6lx+XLaVLKSxz76ACSV5aN+hPLX92txEQV
	2pkYzChSef9nETliHPGo2u9wx0ELvZKuQ633bYUEok4jRnDZaNKzYApKwlAvOsStUWMDlzVHwyl
	hr5JvmdB6mmxL+BcxJQO/4SuCiSamFc/Hbdcb6dtY3mVpzVBJXV6JuCPsODxpvsZ4SXrjWZLTW+
	2FNX8jfJU+Exs6Xm+Uz99hCRjbqOxdprg4E5PNUbEcWGADLgPRrPTzc6pIE2t+aRhxBrtMBYoUb
	zATPz0M9gVeVvHnoFGTT72tFjq13q0xiEiuD5XkhTWA+ul2/wxjEQVv7D7Fnch1UDzQOXmtvk3w
	tZSLQz5lQnFRrtfpEKlZvIqt4LWyY6A==
X-Received: by 2002:a05:622a:391:b0:51c:7b12:1211 with SMTP id d75a77b69052e-5283e017e6dmr56331961cf.79.1784881458141;
        Fri, 24 Jul 2026 01:24:18 -0700 (PDT)
X-Received: by 2002:a05:622a:391:b0:51c:7b12:1211 with SMTP id d75a77b69052e-5283e017e6dmr56331771cf.79.1784881457683;
        Fri, 24 Jul 2026 01:24:17 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm35162045e9.0.2026.07.24.01.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 01:24:16 -0700 (PDT)
Message-ID: <f9fe60ca-b801-4915-b7a6-8d4b1a2acf9a@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 10:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Drop undocumented
 QCC2072 compatible
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAMRc=Mc=4BkXsv2efKipwTq_qXx8m0tH2RPTF6vtZjpE_maaCg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMRc=Mc=4BkXsv2efKipwTq_qXx8m0tH2RPTF6vtZjpE_maaCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JDN-J7TVQgF5bntvhhMf7bxdHTAGI-xB
X-Proofpoint-GUID: JDN-J7TVQgF5bntvhhMf7bxdHTAGI-xB
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a632133 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xwBlPVaBI0DFnX2r-McA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3NSBTYWx0ZWRfX9uNUigA+WH2Y
 WzPaXOATmk+36zePtM0KuVN1kHwwIE2EFaeR31T+M0yBbnIFApWx9Vuhp1VU5sQkq8rxDOlUmCn
 Xw4TK4hyQsvvHhZ63DeKFoKwISgMxvLlwuo+bY791yfxzz2oMkCV+R5u8R+jE1Vm60md9kaQ2HA
 +UWoNsDhlJpfO3wOVFQG7geYshC9CAm8AS5VryrJOpvgd331ocscd+XBl8xKCdvzl/DW76PkYnW
 guNIN2WqGB8gJlIRySi6BhIlCUPrhoYkvmLoPo8jwC6N0cV5NqRZQR3idxmedM+dAzknNJCR+0m
 el5nSkBajeBzHLr5MqT/DiNwMoVF8xSGztL4y7Rtj+XHoG0TXhMDByWkbK5bnXR/B3D5LCsGIJC
 IJUroZqxDAUcex/lltYncduOYztkw+CCYxtAoVQ4TgORu3Vvbal6Rnt+5CFMwHpbnF0H8Uj7bMU
 yFXgRf8B2/GLfHP5FoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3NSBTYWx0ZWRfXzeo+AAp9mxeu
 F+iCxSsB6mVAs9gebqPrBxIs4ng6Y34TVra8ZohgNiyh9N5sQ7thsJf2iew8Z/+YDvxm2Mmkzh0
 aI8McCPdtCKFQbuCcJePFLhb8A65sF0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240075

On 24/07/2026 09:39, Bartosz Golaszewski wrote:
> On Thu, 23 Jul 2026 21:35:26 +0200, Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com> said:
>> There is no such compatible documented (thus allowed) as
>> qcom,qcc2072-bt, thus it should not be added even in driver match data,
>> which later is used for compatible matching.
>>
>> Revert commit 162ea02941a9 ("power: sequencing: pwrseq-pcie-m2: Add
>> QCC2072 BT PCI device ID").
>>
>> Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> index 83fe6a1396bc..168e915f2c89 100644
>> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
>> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> @@ -195,8 +195,6 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>>  	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
>> -	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
>>  	{ } /* Sentinel */
>>  };
>>
>> --
>> 2.53.0
>>
>>
> 
> This is the top commit in my queue so I just dropped it entirely, otherwise it
> would be an addition followed by a revert which could raise Linus' eyebrow.

Thanks, this works for me. I expect the commit to be resent/reapplied at
some point when the compatible is documented.

Best regards,
Krzysztof
