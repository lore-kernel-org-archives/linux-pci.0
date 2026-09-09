Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A915293E6
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951384; cv=none; b=mlrSzf1FYTjUN4k6M1tzKkHvmbjCVZ9j5hiETsCDIRDk4nZpDAU3xlKrmJYFj3nAK9BsKmhNH2hmeCiKsh/ra3KasDnkCs4Z42KejStlTR1HB2ReRCpLae/gsyiD1lLQcKMI18uhdpQMNERCQDECRd/a4qiK0e4Vi9CZnVuimRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951384; c=relaxed/simple;
	bh=DxxddZWg+QBWyHQkUpleRuQRXk/I9FUByrHy5QgB98g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiwHG74c1Z7IS/tb5kaCtcbCcG9tWDAacS+sEE7PkU23Mgfm0XgRIv9Y36gVbALQDA3zKrgjAClR+VC1Pb2Gz8gtWNnt0Jxb/r4aif19InjLHPJlqaie+ddYl+/7fMZN6oFI9xMxSibte8uaQw7desDNt3NVXVchX9OrIrQaTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hclNH5M4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aGKwupQm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hclNH5M4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGKwupQm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689Aqx6h2294353
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 10:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	auQFLUmyjDXuDTVQTivuKNJ2Vj1/bxUapYoge8mUhQA=; b=hclNH5M4ux6dUmNI
	R2Ru0QWruT4/BEHvLI6nILGeRAot9YguXGZ4dlB3v9J32SUYxFQOQUTUYcHAzVBa
	jHyDIIWTlDEKqNCSYcV1AI649MQ5JjqBgZ6mUq3vOs6+hD8vGEn+WEfy2eqaDpQr
	Fva0CtM0OPGp6TwANOJQ66Ra9iQ+8jr0wcTeqvqhfNGDFR+1w11x/90PP9mJjAAQ
	N219zCcuq9DsUltUlC+ld90esYdar9b06dUoGGx93QWiv58sTnsUjtX3RwvRBcaV
	p/oum13fZr1Iw8zq/Qb0CoMFIbvehnWHnxcw+biINwPmNqq8j/tW3/efr3WLlDIJ
	14eh+Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru0304-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 10:56:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9102fee9920so11699976d6.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788951378; x=1789556178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auQFLUmyjDXuDTVQTivuKNJ2Vj1/bxUapYoge8mUhQA=;
        b=aGKwupQmtLQ7KWj4X9s38+p7SrgYMsjYaZzEa+FsMkfECnsnSjEqvoUqEnZOA/TYMg
         2pPVZhzKsrbFQf26cOlS3y7yIixLKxzKCeduJ7VRuwlMFlmcXCQg03RaPsPawPI66zFq
         9KfPYfdfse4vx+DXZ3BACbx49JKICidnHbn0Ffa205B2QtkRqmevIdSemJeh/ozlZxwp
         8aTJ9NaGeWKYu9vpf6oRBfY6j4jGhujTanUTGJRHW1NLaSrK8SJOP+T5bAh4L4bC8NKX
         1eMigJE9Z2NDFpzD7KqVCCx07xPdBe/xqx4RwATUtGARUgDb2dGuFs8yRDH4MqGdztYW
         14yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951378; x=1789556178;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auQFLUmyjDXuDTVQTivuKNJ2Vj1/bxUapYoge8mUhQA=;
        b=svDO5yD/czaU2FBUJAsmb7WfEak+cz8VHTPehKWdXKHyRYwywnIYJ5uPZiZzmvkZ5T
         Z7MvCUqo+oFtx6Zn4KyoHRlC2TtFlh39I7kizAolhN5Z0g+13lEMV7sq1GKIuVk8BuKB
         ntDozHHo99cGOKc0rA7j9BGY3a+Jwpf/yiGoI8D6OrGBdqcqA8mPef2yQAXeRH8IxDmH
         AGiEziDofF8iLYbLwBu1ZvBd1wJl879bz9ggzQx/qDh+mTlvQVTrTCdvoDxuMa2TCxbJ
         PKppakyDMo9Z51B/AiHdNwpzPZg1SBW9wfXRu31BDHqNG6R/kWyFnt9PxMwiKIIGhAfc
         G2PA==
X-Gm-Message-State: AFuF++mTdGC87cPVlQvsPNdnucVM7fMTX3/4EkW+aQ9aBvMsLFjKp9HX
	wZQH1MVpLQ6+SXIEzdRmBaKdKI1sUYDg4WcT3NWv2qrFp0ip3AKY/2tFZl82lH2247S6GNzRhRv
	mpQ1FDTZfItmVWXptlaqCUufoJGTJzgFbPs2Cu966nJsPjV6HNhgvB/MyTlLWGKE=
X-Gm-Gg: AYBFou1Np89aJ/KHjz+JjHiPIyPDyqsB9/IVL32cy/UlG/xCjPdMGurAhZ0qIObpTRh
	Ru5wkoeqc4nmI/ca/vaDy0FhwRHgB3FlToswY2PCoOdIFoxiQ4Ox/vVGMqpU/5Y07K8QeixdCfX
	VJb8SD13ZlH7HPh8VPDN2YKPzIGJXFDRr3aCgKoJtuluDWGhErqUQMMVMX3eofcOPGFV4TZyuRG
	zYxFPIctrngXF5pJtK1Bf7CJT8xYrBXv3AlcjcOYc1AmO/hINC2xdRaNTBEn+ik9npB8q3oSfKD
	AUy3pbXZ9p30ZMypY9Yvrj02bVu/OJQf9iIlSsWgioMgM0AusyaW6hmmigM4mfmaNZcFGrV5+2e
	20pvwEnC95xd6yfQH5pTbiA==
X-Received: by 2002:a05:6214:5015:b0:90c:76c3:2aea with SMTP id 6a1803df08f44-910479f881dmr288322476d6.5.1788951373609;
        Wed, 09 Sep 2026 03:56:13 -0700 (PDT)
X-Received: by 2002:a05:6214:5015:b0:90c:76c3:2aea with SMTP id 6a1803df08f44-910479f881dmr288318726d6.5.1788951368368;
        Wed, 09 Sep 2026 03:56:08 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036469sm756477166b.1.2026.09.09.03.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:56:07 -0700 (PDT)
Message-ID: <ca45caec-01a8-438d-a91b-98a2ef411576@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 12:56:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI: qcom: Implement shutdown() callback
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
 <20260905-shutdown-v5-3-f0c6bafa1d4f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260905-shutdown-v5-3-f0c6bafa1d4f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa13b53 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=Z7REpkxyZKBgooIMAs0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: P4hEz27A7qTe4WdRK9B5uq3Y0EO508FE
X-Proofpoint-ORIG-GUID: P4hEz27A7qTe4WdRK9B5uq3Y0EO508FE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEyMSBTYWx0ZWRfX7XqnmsBiKhpR
 p3SXLsluhJ8Z4t5IsTcOaCIKT1RIJHX6WhBQnmurdyHqyQkWhG0HzT17l84HXdt79hRJeYN6v8b
 awQ9DMIVcVEwVSM5I/li+O/76yQX5aw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEyMSBTYWx0ZWRfX/rlrd4o24MEA
 bUrz3l2Po/o3g3wwW66lnabcYEAsGygMxt9xJxv3xZoYF0Irs5rFr4GdYKX2CuIOcy/pqLXDYP/
 mQR9KTuJPCZ2ZJ/ObWpVHG/zgZQ6Ye0IeU0GeDBpEKv/ToVKvOZytOFE+OccrTsXsSyt/z6M80t
 yNZ49vzlgnPm3Pxkq0KfJbqG/aLk9NKtaJOw52erTw3pYYYD56lvLpGoIEDJgAxxCSFgBmOOFM5
 asxgohn6EIM5mAx4NSWzpWreoHGIRG9QP0v9E+YVQ59wn+SL1McbpmOuMLbcgLni8Epn0ksZeVu
 9fHQyVVP05K+Bctp6/pkgDzv4Mn9jgCAMBfwv/dGkrc2ZlIZgG7t69zi2HN7Z7XJ7QjOV+sOuEp
 CPpqGJwOF7F9SHmJb/pEXfq8VHnv+EizWn9ZtxeR5sSRW3EO97R5xNBSkDCB4g01kKgYGBKipVU
 hPUdEbf3JR1htSygLng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090121

On 9/5/26 2:48 AM, Krishna Chaitanya Chundru wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> PCIe host controllers should bring the link down cleanly before system
> shutdown/reboot proceeds to remove power/clocks from the controller.
> Without this, the link may still be up and endpoints still have
> transactions in flight when power/clocks are cut, which can trip SMMU
> translation faults or NoC protocol errors.

[...]

> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
> +	struct qcom_pcie *pcie;
> +
> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
> +		/*
> +		 * Firmware owns the link teardown and clock/PHY shutdown in
> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
> +		 * still need to be masked off before shutdown proceeds.
> +		 */
> +		struct dw_pcie *pci = platform_get_drvdata(pdev);
> +
> +		if (pci->pp.use_imsi_rx)
> +			dw_pcie_free_msi(&pci->pp);
> +		return;
> +	}
> +
> +	pcie = platform_get_drvdata(pdev);
> +	if (pcie) {
> +		if (pcie->pci->pp.use_imsi_rx)
> +			dw_pcie_free_msi(&pcie->pci->pp);
> +
> +		if (pcie->global_irq)
> +			disable_irq(pcie->global_irq);
> +
> +		pcie->pci->pp.force_d3cold = true;
> +		dw_pcie_suspend_noirq(pcie->pci);
> +	}
> +

if (!pcie)
	return/warn (should it be possible?)

if (pci->pp.use_imsi_rx)
	dw_pcie_free_msi(&pci->pp);

/* abc xyz */
if (firwmare_managed)
	return;

will save you indentation and de-duplicate the free_msi() call

Konrad
