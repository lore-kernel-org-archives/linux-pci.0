Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA65616DC
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957614; cv=none; b=M+dNHwu/z7o5r8qjFLjnGKQLS2NegMVt17AU3nuCqWBbpQVREsfO/GduNnkcpEcC/A2UQNs3JvIg47wp6DBPpf6ITmG6MJ56FCd4Kh51lfn4wu6hooVrdbTsoAgYygYNZLvXUpdhAlwLBfY/4Mro9KPidwlupZ0174WmH8taGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957614; c=relaxed/simple;
	bh=YpCHSUgFsjAgRcrIEVDbWdnvlC2gcwyfmx27eH4VmGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVseRZtZ2MjsXjR8B2josnPoIXywRhOg+3c00sgGdKzqYRrzBnZdOa/CIIehdOV/DrvqzfnJhJZ18XWP/ighOuLi/UduY3cKWnYZ1JGiISiSkMeYAr0TkhZxzs2eiFYWzRMNl9qTMIHMibYZLeWZdkM02OPXIBm0Pw6zYLSETYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NPBmY25q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KYNfkQ3G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NPBmY25q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KYNfkQ3G"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CASsn1233053
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 12:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJowskWp33T+oKp/4P5mw9Ucu72byhvA7Sw0lNZrfKs=; b=NPBmY25q0huKVN2r
	6l7jzCcfVf6Qy5Tp/yHN86dwA3gbyKxId1U+D7aYeNdhmbocxhiKPwuhggxzlJhM
	o0JoYJ3TKfkhmrSPMUTFEX5vdhsz89Fkg7SiNo9K+Rb4ChUjpDjo+h1iHZj2OiKv
	mauofkOy5O1WHrzdVNvkMqRokg6stJHZiIU6C51k3e/m9XUWsFuZI8zf0MDPdWX2
	ZgWaz8byARBf2wzhc81GaxVgdYPcVTJcSnPN/fvTa/FiznKE4nS7vg7XxCcYYDwN
	EgpGqz3l2PpGikGzbB5tAiC2E+FOzyvI2mf5DlBuM6AdiyYG7YAjZLUEcT7Eqt57
	vFDNeQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk77vg308-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 12:40:08 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f36427abfdso7646555a34.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957607; x=1789562407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJowskWp33T+oKp/4P5mw9Ucu72byhvA7Sw0lNZrfKs=;
        b=KYNfkQ3GoLgqNpi03SzLZ2+vxaUl/+g6F8hmPZbRoEEuf0/pOMHcazexHn988VJMDi
         yjbvasLKGWDYxTi3Li1OCPLaaAoJKR3hWUrbXeIKYFj2pejEdZuni9e/SSOfpbP45tK3
         yyo06i75fiUzn3F5CMr1EmCQtgk5euTNK/RtsLh3GgJCoU8ZtH0g83lNh4tFv+Ukh578
         x/aVm0Vl0YDyOyjLHTM4VCNC9FXfvB96RhN1WzSavPTXL4onqabAnB3s3WvgIy8UeznA
         gpV+fseEHt5+32HLKqRPc/A2Eri8b0uZVv/fxwOlI5RB09scnE7U3mU6aHAFrEDPqCRe
         M2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957607; x=1789562407;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJowskWp33T+oKp/4P5mw9Ucu72byhvA7Sw0lNZrfKs=;
        b=DXmGqMraO89ty+nxknKmo4QFtuSfgXl1hslehdedze1Dje+Jxb/AHuAVsSn0VACay1
         ru663VSr5r/4xXP5UDBW+Jkb15SS3kWu+0ZeubzKX7KG86UVxM45KIWMjs4gJwFfB8sz
         m9aZl9gIO4RCluHN/ys4JywNf5ZJ/5s11qJjYFZTYjXWqTh43MQvSWacPjIhusT4Dszv
         GEry9KDQKzOfdEKgYVA/qtKn9qkSCvKgoOhTUJnMkjyXBJSdxoqDPyPk/SwLXln5QXb7
         buc1wkbuMEeZP6y1khxBbeIPbgDuKCL4euqhYlcKiTY13w9s6kwq0XM5zMMLoDo0PZzf
         t/0w==
X-Gm-Message-State: AFuF++ndcLRuNrhysc3RhUtxz+ZPTahJJRSZ8C1oiNmQ78UfyLq5cXUJ
	Jh8A8CHwmcWK+zG7egpfItgMO/ourCZVPOMmKMWcxgd4D7fpU5atbOxrYSFmt9l1LsqEWzdDORf
	ovAjHiPJ1mv5kBFrou7nQiqrStQfyiGBcEyqKVvZEgX3YDTPvJ0q30W/VpdOXZWs=
X-Gm-Gg: AYBFou2QTWCHGldrILOfJHhVrUVstK797dT/AgcdGM5jMmWK7xxg4rRKSjxBJnqJR3Y
	jPn0p9dwLWaBI0W7U/HBE7z/C1goeiuQw2wGQxD5EbuFi8Mgg51wbJzqgIg5brSFO3WpfPnJ/+D
	G/wZPOs7r0l/lx7t9Tyni4yssccUJ608SlmHUPToiCTeNfrrzZk/MgYYigCigyORyMzZCXaoVgS
	1eb1pSrZlrd3ocHJCaxY2V/McWnOXxlRBD8YwfAzaLUevV1d+ZOTXWk3yMiqBPUc1DMF7OGVL7U
	btQSuK3L2BCN9TvTyQRDM+5sLPIFjWsBvldkFyu/lMN5lIWsYZq8hTlZd0dsny9N03T+O3UJ0Rl
	xZbTFnq49TR7ZtWRR1qx20nj78KgTDeI2
X-Received: by 2002:a05:6820:160b:b0:6bd:c2a1:3c48 with SMTP id 006d021491bc7-6bdc2a13d0cmr3379224eaf.8.1788957607266;
        Wed, 09 Sep 2026 05:40:07 -0700 (PDT)
X-Received: by 2002:a05:6820:160b:b0:6bd:c2a1:3c48 with SMTP id 006d021491bc7-6bdc2a13d0cmr3379177eaf.8.1788957606735;
        Wed, 09 Sep 2026 05:40:06 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475543fcaa9sm13915069fac.7.2026.09.09.05.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 05:40:06 -0700 (PDT)
Message-ID: <468f4ca4-e52e-48b3-bd60-20cadf7f311e@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 18:10:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: qcom: Implement shutdown() callback
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com>
 <562fd574-a798-4b57-98fd-dc8e7c09f7f0@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <562fd574-a798-4b57-98fd-dc8e7c09f7f0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6aa153a8 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=b7byPlHVSWyC_7YdcAYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WAIl-ImImU3yvckjOAJycjmA3BRlTu0O
X-Proofpoint-GUID: WAIl-ImImU3yvckjOAJycjmA3BRlTu0O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX0P3/kPYOi1uz
 QErlvDQAOKoGnf5nhrREaXvDYT2MotgU67tvKBfeM0VLRjAmpIBwRujLLm9/e6gajwtouxY8qYa
 aFdsxbEKqt9ESYq3+jtp1yzbpcMWRAY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX299K4V1ZT41m
 g9uJVlA1t4tQjay7QGptkOQH9aMqCjU8n2b2qVEKHC6qSm+/wS6TlvtKBdYCux7Pq4Fq3EK+GkS
 F0wYk25fQY7rqVEGDEZ6n3j/3ifzYm3wBGl0HIm43pHNCwhA9lt9OKUjoOc8i5Pjp6vm+7Qnaj6
 mdlVIFqqgX+ByploJk1JozAWI4Rwr6ObqTDJXwIjzmWE+K0IDLJWLvRWMpbnbC3Eb5ydYwZVUtn
 CKww7yRgiIIA5OlWk3xRK3i/WYPixEeyS18r7MYo9S7eGwx2rHvDWNjDnKPW1t0lV+Xo6ljpvFw
 WP7edFPQQ2FEvmU/dCfaxsU47+JVLqXGzirRcWFjySPQqvPY8au3LCvxQdvfNHvNqPar6P7A502
 NR3izSgZM8SYJauvur9OqSEkEntV90/uKWgS3iGgc/kI/wpbOOnoLtT8Gw2VXpIDl9TVJWeheTL
 SMgIgp3zVQ1hnh4lDyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090141



On 9/9/2026 6:06 PM, Konrad Dybcio wrote:
> On 9/9/26 2:24 PM, Krishna Chaitanya Chundru wrote:
>> From: Manivannan Sadhasivam <mani@kernel.org>
>>
>> PCIe host controllers should bring the link down cleanly before system
>> shutdown/reboot proceeds to remove power/clocks from the controller.
>> Without this, the link may still be up and endpoints still have
>> transactions in flight when power/clocks are cut, which can trip SMMU
>> translation faults or NoC protocol errors.
>>
>> Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
>> into L2, putting it into D3cold.
>>
>> device_shutdown() runs with interrupts enabled, unlike suspend_noirq().
>> Mask the chained MSI IRQ(s) and the Global IRQ before tearing down the
>> link and clocks/PHY, since a late/spurious interrupt could otherwise
>> reach a handler that touches now-unclocked PARF/DBI registers.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> [...]
>
>> +static void qcom_pcie_shutdown(struct platform_device *pdev)
>> +{
>> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
>> +	struct qcom_pcie *pcie;
>> +	struct dw_pcie *pci;
>> +
>> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
>> +		/*
>> +		 * Firmware owns the link teardown and clock/PHY shutdown in
>> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
>> +		 * still need to be masked off before shutdown proceeds.
>> +		 */
>> +		pci = platform_get_drvdata(pdev);
>> +	} else {
>> +		pcie = platform_get_drvdata(pdev);
> This is no less than an intriguing choice.. please store the same
> element in both cases so we don't have to do this
for firmware_managed solutions struct qcom_pcie *pcie is not being
used/allocated at all. it will waste of memory if we allocate memory for just
this use case. - Krishna Chaitanya.
>> +		pci = pcie->pci;
>> +
>> +		if (pcie->global_irq)
>> +			disable_irq(pcie->global_irq);
> This changed the ordering of disabling things versus the previous
> revision, although I don't think it should matter given this
> IRQ currently only services the linkdown event
>
>
> Konrad

