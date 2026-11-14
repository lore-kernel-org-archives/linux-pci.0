Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621572;
	b=RbcRQX86jwqHYljYLzmjpVWd9OYsehFEfl5EZQ431t4XzaJTOFOCwUY7SCQFxKF2/n7R
	 86pJIOfrJOxhBmoSQrSWyc2IFRO4/Q9hBmNIWubkMKwa1TUxcd6kXInxV1f0CTX4LekxM
	 ODtfgB8MXaWaL2qhfXFCRpxJNxbN301UOOGVxQpvzMOM4OUmOJaMq84XUqoAWJlJikv6O
	 vbtwVESXNHKAix20pPRPEjtLd8+YFv7/xaBrV60dHTk6Lddk77KRJK/uJ3rrxDmlsDoks
	 t8unJw6q1UADZT5eNgtPNNp2R1Ut22xVwEbo/mBZaobdaBFxVFZt7lFo50UraHwVY+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621572;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=H47W/ULwr2k6/yvJ7HvMMOZaxS3u2gLpACgrzkSuK2k=;
	b=GTNMfEEpFoHl12kLDxj7NwM99lfj8yo+sKPR9USiOSUVuhuS/K1sR3wz8Sk0prog7yvE
	 DxV84e4qJnKoydvpO4ifJbX5r6smMInPbMUzAnH5VaIPSzo9pRjn5AjQgJTIOtzCibimw
	 GbH/dzsOr1hgeQSFNlUO/ODxB7OpDDIgqelOe87lnR5yz0VRyq0oSJw9ClxbkvmDrPlfV
	 v5FQAzuoZypQvE1FqqzYTzQcafCqL/WtbI+btu7Q0a2IkvxYOZXKU+cPdN5gPNJYw2lze
	 idO3jkoRD6VEnbWUoRqA15bnzKLLgtReszFgpUFaEr+3w6guoQ6WQzEj2LkT2yLEN/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mWqzWnOt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YqGW0fVJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F96606A338
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F96606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mWqzWnOt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YqGW0fVJ
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMbJm91645073
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H47W/ULwr2k6/yvJ7HvMMOZaxS3u2gLpACgrzkSuK2k=; b=mWqzWnOtyjcZ28PX
	i8rSPIzVIxYYHi20GiKVcYzP1YAPyQsnsquh0C0SLRS9x8D1Io61rEf0Z//+7lQD
	J9P+4q7sMlpA/j0hFS0bJt9lZPr0I2thEsY22C4WrDr/NQSZ6uJGL6lFxgEq//7B
	KpcLO8ENn/rOWnfXbVpGLVX1/6urGa+e9Ied3sn5VK9GPKh4Ll3hse6LcEw/DVKk
	jM9pxF2LzHDSoOTCjBvHCETJyhuxRd4jRH9qVCrCw1hw3kjMOn3NANp6uHvUmNPa
	g+CZzb+gJsG/7zD5zr1hsfraLRRwtYrUsKBaZHC1JkQSiziGYlaelhRICkNd1nIJ
	8a84Eg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvjac2vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:59:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so1851735eec.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794621570; x=1795226370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H47W/ULwr2k6/yvJ7HvMMOZaxS3u2gLpACgrzkSuK2k=;
        b=YqGW0fVJv8EqIUevGZqgCIRhLgPy0Cwns5ltjmcNvdfd9Ud6cJwlFwTkyoHSm7gX9k
         Rbq0pJUZNloYVlFmKTiQPmcIlkzuLe1SKXfacZWm9DeQr5TSpWSqynFRMHabWqmnG2sH
         6rVkubjeVrUnx9k5HsHhiHQPRaqqIXifGdMatW76OG/RF1CGyAJj3TxVGItAJnKAEwQN
         zqypw7obwQRupKXunE4BsKetyX3BwSAbuE7aAoD8m48h5Hn+OrBR5cVL4ANUyND42Y3G
         POKH9t2Nnbacbq7j4gbYmSfnYMUtfP7TN4xcvf+Ek2Lk1D80a5YcE/G8fK/RvaUTqGLe
         Vd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621570; x=1795226370;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H47W/ULwr2k6/yvJ7HvMMOZaxS3u2gLpACgrzkSuK2k=;
        b=1Vj3y35yVnac1c0cQBDIzg0Q9GuaK3J2UzkUqcHjPdPtku7winNU51iIN5oZWarh3n
         QGskf2UbfE3eWSRWFGn2Ng6ZRfcL44rm8HnT+xY85Dmj1NottPwy30gpDjxqYr8+gBpg
         RHokxB/eNH8GW+jzPsuxF/iZsCeb5kbXfBNXRLe9JuWJ2LZf781mmUYnXIjhDCqzTMs8
         pGC6VibUBmsO1cLuTWiD5pV0EpKRJOmxFEOjW2MY4eyrjL6MfSEibcfxP5ghgdC0fUNw
         8z8+xKQ1u08Nq6v23dge/sUSuXNgnRHFhcdxiFbjJswSxpcQIxXyow0Gnod12bH3bkKJ
         FKXw==
X-Gm-Message-State: APuU4Z/cgxFmswkWpKmJq4Q738m51H0Zs7gek2S4RFUWrS0EcohfBQ7u
	Ey7ShMYZQfJJiYy4SlT4gXsNJv9jHZH4urdvvFfubZ5LwL8vhchQB5MPGbGEilRn+8CkVDGyhNv
	Y7UiEcYQuqG5cTYWhIOFg/oGNxY/mIOpCSmcMcakawddIutvefE9xcUpj5ZTLiyk=
X-Gm-Gg: AYBFou13RKjscfdhY+OUcUfXcaquBf8oOpqVjwrR3ptYj1Fq4FErXvL4esgS9tIvJ+U
	pvWGalX4PHjLnYYHuBs13gcP90SRhUQ36pJFaU8eZabFX758SqHl+nrNmE5DktdWTGJWCLztjm3
	Bui9VdNuFScK83Yi/pY1gJnJCFFGuxYik/akHM9u8Yzoi7aimJ+AacHJUVpTK7y2uFybtasP9HN
	/l93xnwJX08Lpslwp7W8m9Rs1q+SOmQrz2mnqovxnwQpSn1btcMG6lwzcr5Q+nggB3V2nsR52ah
	PAZaNfWbrg9DG1c9n1I4uRjLnKjKxxaf3IyPutjOEy4I1n6usPtyRB6Yqbbnw3H0xZI+K+Pwxjf
	2bl+7LjZ2dIhYJYyWQyyfzJ2F7EN8UJ7vHoLG5qRqiLB17E4355QF/t1/hCNemZqXyctSruyyI0
	Mq2puH/zwX
X-Received: by 2002:a05:693c:4153:10b0:36c:9af3:22eb with SMTP id 5a478bee46e88-379681c99b3mr4512367eec.34.1794621569852;
        Fri, 13 Nov 2026 17:59:29 -0800 (PST)
X-Received: by 2002:a05:693c:4153:10b0:36c:9af3:22eb with SMTP id 5a478bee46e88-379681c99b3mr4512315eec.34.1794621568916;
        Fri, 13 Nov 2026 17:59:28 -0800 (PST)
Received: from [192.168.29.63] ([49.43.231.124])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm11346264eec.0.2026.11.13.17.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:59:28 -0800 (PST)
Message-ID: <6a87cefd-7dcc-4e68-9c4b-413176360a00@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:29:23 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] PCI: qcom: Implement shutdown() callback
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
 <20261107-shutdown-v8-4-bf607c6429b0@oss.qualcomm.com>
 <fd8b69b2-5487-4e99-a45e-d6c2ce9ae1f1@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <fd8b69b2-5487-4e99-a45e-d6c2ce9ae1f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Lyvkemgk64zvcpIS_f1alVTt_7wlGGA_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfXyKAObiqz6Br1
 ha2G6gtUgJnm4SKwddXun4UhhWjXShkXB6E1NbwWarko2R4TBPjQ6qvgaW9FbBT+BtwvQINMTng
 6U+bq98gYQ/8XRNpksI8Et262ge8wYs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX3xdFykPI5FAV
 M/xcJuPtNO6J5vOILs0hyoD3Mmj9Y6vojo/3K2HsUUjtp2VT0ZWuxnvYDKgHV7Wy/uo64+f55kg
 0OrIGdWvVB6bumOV9gMzSGRV+rkmrAx5GBGFyUeBk3fXIvkGwk3bT0WY3iCNj7LMyBjiwmha/k4
 wkgBu92tMQgS9+0wMW450MQSWA7BrxjAZqpOiBEKLpc+HNrQIlSDIMnn8AajCnyo7of0RCDRgQV
 uHMGea7O5QzFoCJauFJn9pFdrqWBkJt4hggttuGSQDKmcs7YJy9eZvsWooQuRKNeMehKKOEvY4O
 pkBR0+0z/OqK4n9U0K2zcNIHMWbL8o6mPsy3enspZOxY6yJ/BvHyVBTXqwqZdh+gdHK3FELt+xf
 AwERBPxwItoT3NgeU4UshmF0je12XMJ1o/nuUjkAU19uNk5PNYEFkw3G2C6nO4SIbowfNsieT6P
 1tHdt3nz2Feg0fL8bJA==
X-Proofpoint-ORIG-GUID: Lyvkemgk64zvcpIS_f1alVTt_7wlGGA_
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af7c082 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=OgdsqUoHhxF4GfobPiU6/w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3O9PIZBSMK0NwXvH1SEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611140007



On 11/9/2026 7:59 PM, Konrad Dybcio wrote:
> On 11/7/26 2:45 AM, Krishna Chaitanya Chundru wrote:
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
>> reach a handler that touches now-unclocked PARF/DBI registers. Use
>> dw_pcie_mask_msi() rather than dw_pcie_free_msi() so the MSI IRQ domain
>> and the MSI mappings held by downstream devices (which device_shutdown()
>> does not remove) are left intact.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 41 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index d39753f0e724..c5b06db3b92a 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -2046,6 +2046,9 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
>>  
>>  	dw_pcie_msi_init(pp);
>>  
>> +	/* Stash pci so qcom_pcie_shutdown() can mask the MSI IRQ(s) later */
>> +	platform_set_drvdata(to_platform_device(dev), pci);
>> +
>>  	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
>>  }
>>  
>> @@ -2466,6 +2469,43 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>  	return ret;
>>  }
>>  
>> +static void qcom_pcie_shutdown(struct platform_device *pdev)
>> +{
>> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
>> +	struct qcom_pcie *pcie = NULL;
>> +	struct dw_pcie *pci;
>> +
>> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
>> +		/*
>> +		 * Firmware owns the link teardown and clock/PHY shutdown in
>> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
>> +		 * still need to be masked off before shutdown proceeds.
>> +		 */
>> +		pci = platform_get_drvdata(pdev);
> Revisiting my older comment, we can still stash `pci` in drvdata regardless
> of the flavor and do `struct qcom_pcie *pcie = to_qcom_pcie(pci);` in
> places where we need it
I am going with uniform drvdata but stashing struct qcom_pcie (not the bare
struct dw_pcie) in both paths — to_qcom_pcie() resolves through
dev_get_drvdata(), so stashing pci here would have returned pci again and
broken the existing dw_pcie_ops callbacks. The firmware/ECAM path now
allocates a thin qcom_pcie wrapper, letting shutdown() drop the branch and
recover everything (Global IRQ, cfg, dw_pcie) uniformly.

- Krishna Chaitanya.
> Konrad
>
>> +	} else {
>> +		pcie = platform_get_drvdata(pdev);
>> +		pci = pcie->pci;
>> +
>> +		if (pcie->global_irq)
>> +			disable_irq(pcie->global_irq);
>> +	}
>> +
>> +	if (pci->pp.use_imsi_rx)
>> +		dw_pcie_mask_msi(&pci->pp);
>> +
>> +	/*
>> +	 * In firmware-managed mode 'pcie' stays NULL and firmware owns the
>> +	 * link/clock teardown. Otherwise, skip if the controller is already
>> +	 * suspended (e.g. a prior resume failed), since dw_pcie_suspend_noirq()
>> +	 * would touch DBI registers with clocks/interconnects already off.
>> +	 */
>> +	if (pcie && !pcie->pci->suspended)
>> +		dw_pcie_suspend_noirq(pcie->pci, true);
>> +
>> +	pm_runtime_put_sync(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +}
>> +
>>  static int qcom_pcie_suspend_noirq(struct device *dev)
>>  {
>>  	struct qcom_pcie *pcie;
>> @@ -2657,5 +2697,6 @@ static struct platform_driver qcom_pcie_driver = {
>>  		.pm = &qcom_pcie_pm_ops,
>>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>  	},
>> +	.shutdown = qcom_pcie_shutdown,
>>  };
>>  builtin_platform_driver(qcom_pcie_driver);
>>

