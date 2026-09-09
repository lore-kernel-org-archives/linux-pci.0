Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0D556B9A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957408; cv=none; b=We7rrt1CKSUdLsqYlHewYOYOlsqn8IbCPumV3h2tTz3OvhgNpt+bOhowHf58URh8bkExpiKy+3J50IVnuBsQyzM+InaFi5xjkvb9z0WfoxaU+WXgsiYihBuIFl0uVXp1TM4SH0aGtWzddtkxYYU34qZM10ypcL8F9XwuMb27W64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957408; c=relaxed/simple;
	bh=CBbe2vkoiOw7V3EAxWKEV9fjs7z6XjSKGy4+UZu5Qxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVAYRH23b1BkF8jmnozhd7lf7SUi2sXzeaYMdJxqzIJphffwDfbGaRCJ4kVRMdiLHOL2+1676IxnPL9JbCRNkfvN8vIfnpEh/y50LC+1i5bD0VnElPDBICY6Jjz42h0TP3fx6H32A6OwNbbhqIwfHoOsnt1rOPA/3p7nJviFRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Esr0TM60; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kO29GeBU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Esr0TM60";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kO29GeBU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUBR72171847
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 12:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K4gwwlnQiATgJHV0AanCiCbhFa2no0RKiwLEYoKNKPQ=; b=Esr0TM60/fQLo0jJ
	un0tMClv2opoanRsJhR6Ygx9PwQ13WAslA3ghkMSGOb/RLokols5Xb0TQm/oKn/8
	na8T7GobwXSjGO2W1C8Ms8Ui8Xc7ikvkiYo0M6hzuow5bl0i0fRHrrGkNGvkipes
	cVBb3lk8GoRZeI1Byvsho6y+9HxeLSI2+HW13gFOT74qfomfRRKaz43vGOUh8Emg
	gYWJAaWXnEpw8fkWaE8rg87KJYFd0wnXsmWgxNLyZZ7S0HPC6RUM/aCzip/T5QH4
	NCSKotQ35g3booZ9BxwBLKEobi8labIiCRzvgKswwLjOoIFhyo7r2uuqBxDm+u8a
	8z77UQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5rggeka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 12:36:45 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78a1ec363beso88031137.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957404; x=1789562204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4gwwlnQiATgJHV0AanCiCbhFa2no0RKiwLEYoKNKPQ=;
        b=kO29GeBU4w/6R4P8v8cTRZRgyHTJkmx3CVcjBdu1j6KNTZP21kPQLRDK7y1dHKxLzO
         uVxqeoFq67iD0qtA7YrnpJguyx0g6sGJ1B5rE7O3nTzYWi+d/iHKsbx9bnj7hH74Xxjc
         cbzOcgxFRgIiFYf4+bXm+WOOiLVw5i/FqkuIjJeNtwmahtJNHn2/S7o6B1GAcVcNsHC/
         qDqcEAEdoCP5DoTtBem4ENyoNQ1n2XAZK0rWCO2+4J/MUOQNI0+ZaDh9ZoW0VxFRF71I
         P49ZNTaVdDHRljnSP17dDT4COckXnIxDo3qBEGfVO1bUeplwGLAThtLCm50coFNR8f+O
         yCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957404; x=1789562204;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4gwwlnQiATgJHV0AanCiCbhFa2no0RKiwLEYoKNKPQ=;
        b=MewEZcqhDDXs/AaXhZ91Hijxvhy3FJYlqb1JWPT3ghTn25gWa5afynLzF3VrfyAlxX
         iRdu8UiZdF1rYOXiULuCpvyN0jD5nbqi5UXinGyXZnInT5Gksu2cjTeOiRpl7hM6QZiL
         BJRWNLfzDDbcGzEpaHO9dK3wM74vUSTZBrCzAeNQZQLFubDreZ7CQwfTKO1blPueZSd8
         x0PL0tx9EWP5kG7IlvIdL4C2btE18sc5AtDYZ4GLtS997+oHTN7ThaNEZ4DANgkIVo2I
         LK82e348DSOYAq4rgpThvG7XtBBS+/0Mf4T2vYvLTA0KG5ShjwSkpE5vqajJLSGRx+/5
         b7ww==
X-Gm-Message-State: AFuF++khOTG6XDA8pbuLcGB63BrLgsT9GRKSOS8WLJfEVLkA/MEDLAHZ
	BhPRjUHncUUywGOizJzqCZKeZi8fJJKVbHvUMQFaJ5Pk/9rZOGGrIp5AgfInfY2tSujpDDGcBLd
	qS5JLt/QqpRLbjtQdfpfIHII8OeCjCuD8vjGkALao0GFzMLMLTIsDG9IoXfqze+Y=
X-Gm-Gg: AYBFou0Puz9rCfL3I7zEu74B0netvnY4YElw9ZSMAWuqJUz8jN4xJgXjgl6C8eqa4+Z
	hbB6XQo4elzxKRU5Xh1QR5o/jA+2kYxrBOblVlr9gtzRnBowAhEyR7bX1jZpTZnsEmnrDfu2SQF
	W0QVQk7YPAREDLRTis5chdZjALJ8/nF5b9H+rdESHKBOu5LSb1eUeyVUnuc9n4Z0oXHdaNZWUvU
	L9tA3qy7JYEOhScA2KB9fZGQ6JmJn5cm39DV+fGjvJ15wJpyJYbjv3gH6P/17Y11HzA0neqFmqC
	PvklCrCqbO7U9MiblSIYYOOrNLAIdHPjJW4+IDNWYdCdZL9rzwbKR+gpImqR6zVmLseJB58zfbv
	tJvf0bv9897QXX5VN79Bx6w==
X-Received: by 2002:a05:6102:91b:b0:786:c254:b7f6 with SMTP id ada2fe7eead31-78a6082a131mr3897223137.0.1788957404524;
        Wed, 09 Sep 2026 05:36:44 -0700 (PDT)
X-Received: by 2002:a05:6102:91b:b0:786:c254:b7f6 with SMTP id ada2fe7eead31-78a6082a131mr3897208137.0.1788957404067;
        Wed, 09 Sep 2026 05:36:44 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705cd8d5sm40923701fa.37.2026.09.09.05.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 05:36:43 -0700 (PDT)
Message-ID: <562fd574-a798-4b57-98fd-dc8e7c09f7f0@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 14:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: qcom: Implement shutdown() callback
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX1f2YbOMy9ZI1
 Jv0coJuPXYA0sKRnI7FLXrdOGQT9baTqoXRWXWkrYiIupnEE9KQxergnMt0yQj6GgEFKJMGdaqY
 2N0antOrjQbxfq0x8CgQC5mGiQbUztM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX08qL4Gcfzonb
 WnzLfwmQWpU4/Mg/hC9X0yQNbUKZEhSDxjO7H0A9Emd+SoLXdEnen8GLdk08UOClWb6TlWICawd
 ttOV4JjTlkJXDWmgrOMMSJ24uGfGXH+w9xfw6ocUyehyTHvi/nkwMexqWVRgr6u6BlrfaHuUVNU
 pklKUIJf8jblbelGyjUbfdXH94ix/GR40fuAa5ZrIs3dvC2sILHVJ2xi6TNRmbMbDfjrzosZu4F
 Qhy+5Pn/GuY2KNjBL61wFAJnxCB6BA4pz2wKqPlS1UVpuf1/afyO3HBKYB+JKKLvhsc5iyAyAl9
 zv2FV5JAcCmHYUfpr+QrO1XwyuX12o12pNjwr0F6GQOvoXxe3u/wJXvS+E2Uvaoi+Na/nUQNhEZ
 aFduwvXOPwvxQJShcw7cy2a8hG/hE5SB7FKGTXONFTOEGz10/+x8yXGqrZw+9PYpPsT76wjyg/m
 egs0pE8JwxKW7WYGJ+Q==
X-Authority-Analysis: v=2.4 cv=B6qJFutM c=1 sm=1 tr=0 ts=6aa152dd cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p_f2mebja45H0yVC8-4A:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: i4sCYK4_fFmvAeB-N5L2vsKv1YRCQYQ9
X-Proofpoint-ORIG-GUID: i4sCYK4_fFmvAeB-N5L2vsKv1YRCQYQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090141

On 9/9/26 2:24 PM, Krishna Chaitanya Chundru wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> PCIe host controllers should bring the link down cleanly before system
> shutdown/reboot proceeds to remove power/clocks from the controller.
> Without this, the link may still be up and endpoints still have
> transactions in flight when power/clocks are cut, which can trip SMMU
> translation faults or NoC protocol errors.
> 
> Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
> into L2, putting it into D3cold.
> 
> device_shutdown() runs with interrupts enabled, unlike suspend_noirq().
> Mask the chained MSI IRQ(s) and the Global IRQ before tearing down the
> link and clocks/PHY, since a late/spurious interrupt could otherwise
> reach a handler that touches now-unclocked PARF/DBI registers.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
> +	struct qcom_pcie *pcie;
> +	struct dw_pcie *pci;
> +
> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
> +		/*
> +		 * Firmware owns the link teardown and clock/PHY shutdown in
> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
> +		 * still need to be masked off before shutdown proceeds.
> +		 */
> +		pci = platform_get_drvdata(pdev);
> +	} else {
> +		pcie = platform_get_drvdata(pdev);

This is no less than an intriguing choice.. please store the same
element in both cases so we don't have to do this

> +		pci = pcie->pci;
> +
> +		if (pcie->global_irq)
> +			disable_irq(pcie->global_irq);

This changed the ordering of disabling things versus the previous
revision, although I don't think it should matter given this
IRQ currently only services the linkdown event


Konrad
