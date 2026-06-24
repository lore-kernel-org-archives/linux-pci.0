Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1EF264612
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307958; cv=none; b=SCAakVmOvdXWPHUkUNSHS2RlOxrLP5cdaUvypvqA4EN0FOe5NA24HbBZ6EOIMKQyPZ+YKIwg0u+d7A2386vYKhJ4JE00zu5vBR/I3ovYY5e1QTIIdI6uMlQwGteim+h41r2z3z6SP2BgW0B9xshMuxFO93HdwcKYKNW0pnVMN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307958; c=relaxed/simple;
	bh=omwyuqulGFGHWQeeHx5ij2yog4yrYPZqWTkWqeld3S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaEePYEKdZw0cB1ub4AHvMNJBmXI+50idcb34uglozC4cjIev+noLwYSAU2ajBDaKtkrWFUjCg1U6eU3NI7UUAbu/2QsFj3Cbc8a8BzDSlw1cbjlBbsowyQR5pCOcqJm1D3ntr/himLA10DKmnA0o2X1/ovO4h+wqEqI610lznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZ4t5G6u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CnNc1cNh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZ4t5G6u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CnNc1cNh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OANbJf2583059
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dgs9noh+aVMYmMVI+RiZ548pHFrtQba3o3tk53GSo6k=; b=WZ4t5G6ukBEor6jW
	Ti7uDiJOoY0Fx4/D9vcg4oUOoEh+31mpxDiCC4gG3Ifq0IklBiSif6yGccNOHXsE
	LIzKYk152+ObLrTxvt79LqZUEXjzCauSJI9PjVlmpIeQCK7kYFDKDu8wsSV6595S
	pDBqcAZVY3Tp1SYroMKkBZzkwj067vLl8Huy3WgIZRU2XBC8ybEAeg2ZM6mCn3YZ
	/SLWedBJzbRch6WvT2i+4gzNTuJ6z6TYieyiGNYRhzJI+P2KsMCdkwHM6RrgWJwg
	dYe4mc1yqNSFkSpiykPmD1zVYHEmK56Uy6zEeFHgaC4WFJfx2T052aAbsVambpyH
	mT5akQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00evbacb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:32:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so813868a91.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782307956; x=1782912756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dgs9noh+aVMYmMVI+RiZ548pHFrtQba3o3tk53GSo6k=;
        b=CnNc1cNhA9eWn7ohd6uTDhsCmPZD9wJPZjZp7GWEB6R2dqKhILGKHCM3duCLzbtKFB
         t+qYMdmHLk3vGRfSf1jKqgMDIjXKftgCD66Qt8l7PwpL8wnsXikDeno9cvjwA2nuEBQd
         U0Pt4Vt3CF7ufiz5kxu8f2Wxvl1qfn/5iile+b02FYKHW7srwnQnToPLHy7IVOvFZXH6
         yP89Qbi0bX5iFV6wvQFubKJ50DUH+uk35ujbKb0mY3u2slv3tcNXqRc6IPhrMwK5TOBn
         cuhybxL8F4CGBzFEWvq3McXpxIixTT6rGTTmwEsxOSuWQI31WOR2ayl8kyp8zVP3u0yd
         aaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307956; x=1782912756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dgs9noh+aVMYmMVI+RiZ548pHFrtQba3o3tk53GSo6k=;
        b=NGAxz5e6lPtbfDUW0cszhaCNHzQl4laFYovsWZO57AdkaXzvFnv52SP/eN5IscI7rp
         R04Dxh2J6BGHXMYFFRETdk8MzYE8GG/LtLKYuC5V9fKjpkiDjB7RTq/V+a1XP663GyFC
         KOLR/w8Or7WSJFHUIlFbyD6IsccSf58V6Q6KIc3tnXOAIO4PIIUKD5+xFyduEquvSYWd
         TWM94zoRIcNQKS8CriidrWR7fSWULMcqRfKmMfiIlH7ytIY0ndPnSMb4rB9ILaVvkRbQ
         t0BznTjtkwgBQodWrLeGXJ5VF/SUdiMYn56ibceO3SC5mYDvy9GsbXmfmlpzkJnOUvOC
         NlKA==
X-Forwarded-Encrypted: i=1; AHgh+RrV+3fQtXQJa4KXAbxfPnVDvhv/26NIjpfzFb37yiWG2VLDBSF718ZIOVvX6dJ9J/GBlQSucxo5pNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUOzLmdKjkY+NIOGUedub+AnMHhnh2YeBRqeOQvbxWoD1leNO
	p6ZrEuLMykEL7v7Ww2agfQU3qmDCFpZM8E/K1y7lQNOsGCMo1eEZgPUfqlvJXEU20F+3ALgaCma
	sM+CCWuceWoEGSCYzek8kezP5iKknxdFCiLyChiMuZI7XUwdsE8efaaotdudW3DA=
X-Gm-Gg: AfdE7ck0o/OaiqhoT033iUhKy8cLe5q4mYVDFLk06GUxdunU/BnqFo9PgoNcx9N3is6
	yUOKXsv0HUofBPTKGiJYxEjTDp56YZIztec7tmQAJo+wK5T85ukPhcmsW+5InIGjAucbWpV/HhY
	fqr5QR2h02MQIREVmlbx0AoZ4+SLPuIcu+zaE29L0gOkJ2/2r260YkJKg2TWRRE9D0SLN7kOd4v
	r0NC1vzcD6LGlXQHFRh1WUOc9iTgAxF3PlSOqMkeua6eKPLPz73dUXkGR9SJamg5L6+ikYYZtSl
	j0TRIOX/GdL4yU+Kn3RWNvB1/DrC9EHtTj3giLfcC6P4zo6iiIlHQgui0lsPNfTqFM7KcnF53ch
	xNfEvQJDbqyfKm/2WruaiQvvtCTVr/gSEWRpljWG9I7s=
X-Received: by 2002:a17:90b:1807:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-37dd0dd1110mr9044613a91.18.1782307956206;
        Wed, 24 Jun 2026 06:32:36 -0700 (PDT)
X-Received: by 2002:a17:90b:1807:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-37dd0dd1110mr9044566a91.18.1782307955632;
        Wed, 24 Jun 2026 06:32:35 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3cfc92fsm1201836a91.0.2026.06.24.06.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:32:35 -0700 (PDT)
Message-ID: <475fe567-9e0d-4710-902d-a63470813273@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:02:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PCI: qcom: Keep PERST# GPIO state as-is during
 probe
To: sashiko-reviews@lists.linux.dev
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, neil.armstrong@linaro.org,
        linux-pci@vger.kernel.org, olteanv@gmail.com
References: <20260521-link_retain-v2-2-08ed448b081c@oss.qualcomm.com>
 <20260521134316.8B9821F000E9@smtp.kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260521134316.8B9821F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMiBTYWx0ZWRfX5ZKKDM8RRjNR
 rJM4hh8F2D5AFc8Jt6AV5x4+qJESVcQciAiusiaWMfsNpl6CLmiiFBUTpT8GaWcE2OMvAubNL+o
 s1LpasRn6yGkJjigPGjafi2x3XxZJNJpYsA+yRxJjPgkvYSSzUx6Wqtextn6gepH5i/L5wtener
 O1XKlIzz8ZFb6vxOs6qylMZCY5krKAiWdhI5ik/CMFBOCDUo7AwxkQmzY/FY276CE3mjOqxiZOO
 /iCs4uZplH+UNWs6XmE5ztXjvnzKzXJrcbZ1Zq+/S2yzF5HnGy1JTD67AoQRG4jFta/RJiGjPdo
 B2HuaN1tzNc0D9zaaAsWnGf96mVdrIkbDf9MF/5umYlVHKC3DXdJE/VGCgFOI1O8TOPNLaFHjMu
 Z/tzDaG436sPP16naDyRV3x1r1w1JYC0lRt7YFjtSLeYCtlMGKu25iK/yiWmf4qAOEsx39KmWl/
 ppyuCB7s4QUlga60Ozw==
X-Proofpoint-ORIG-GUID: rql41i5KhvrhpuAtQykveCe-zpNHbXZU
X-Proofpoint-GUID: rql41i5KhvrhpuAtQykveCe-zpNHbXZU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMiBTYWx0ZWRfX3pZl8Q57e3j/
 eF0y6X3DjLoHausU4LuNWncecbOlwG8CJ5CBC9Va9HZUUY930e7vjLUrVkFQ7+zO5VYeR6OEF1o
 x2PNy1r2uH4UzsSpmAYrktX78WUhKr0=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3bdc74 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N6vRwfa21d4p-6sfUasA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240112



On 5/21/2026 7:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Silent hardware control failure due to incorrect GPIO direction when using `GPIOD_ASIS`.
> --
>
> commit b4b7937282f9b2dc2dff52265ec3936b1024af9d
> Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> PCI: qcom: Keep PERST# GPIO state as-is during probe
>
> This commit changes the PERST# GPIO request to use GPIOD_ASIS instead of
> GPIOD_OUT_HIGH. This preserves the existing GPIO state configured by the
> bootloader or firmware to avoid unintentionally asserting reset during
> probe.
>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index af6bf5cce65be..bfe873cbf44f6 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1707,7 +1707,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
>>  		goto parse_child_node;
>>  
>>  	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
>> -				      GPIOD_OUT_HIGH, "PERST#");
>> +				      GPIOD_ASIS, "PERST#");
> [Severity: High]
> If the bootloader leaves the PERST# pin floating or as an input, will
> this cause gpiod_set_value_cansleep() to silently fail later?
>
> When using GPIOD_ASIS, if the pin was not previously configured as an
> output, GPIOD_FLAG_IS_OUT will not be set in the GPIO descriptor.
>
> Later in qcom_pcie_host_init(), the driver attempts to toggle the reset
> pin by calling gpiod_set_value_cansleep() via __qcom_pcie_perst_assert().
>
> Because gpiod_set_value_cansleep() enforces directionality, it will
> return -EPERM if the pin is not configured as an output. Since
> __qcom_pcie_perst_assert() ignores the return value of
> gpiod_set_value_cansleep(), the reset line might never actually be driven.
>
> Could this break PCIe link initialization on platforms where the
> bootloader hasn't set the GPIO direction to output?
There is pincntrl in the devicetree to make the direction OUT if bootloader
doesn't set
this pin out.

- Krishna Chaitanya.
>

