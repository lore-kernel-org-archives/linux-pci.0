Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09AB356A3E
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738949; cv=none; b=GKh99ZJZFT3hdlashTv/94t/5h+YHldHt7CKrkC/XcXd6QJphIKW7/OMpJX7mGp/AvpmERBc4T8YO1AG00XFkxHcHuzuvyib+XITa2zVDsKkJZGg08OR7SCONSFrEkGxt+UZ1I8RWtCkhWOI3LEIBj99HHPlfkW92Sk/m7Cf8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738949; c=relaxed/simple;
	bh=tLDsJ3xH3Spdcca9pdvNzIb9hidWDi/5wO6TJ9xN0hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9sgYYH5t5BCEtAQkwvuSqbShgm4rdRhCX26fUDgxc1CJglFh89BHE8zvEalPMgIPcEIRFKb/OVkFEyPHp+WPzgqrh0mLQ2S6yaXhlmVa7ZXTbDZByxYctDJX/xZY7di9AZ3x9zcPqr9BEj1/m+dIsN7S/0R1DvpNHc/9pUaSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpA55TNu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UmfYvzh8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpA55TNu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UmfYvzh8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H51AiK1428768
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 09:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vOuiJ6MeDMkaWLveMBBkfhjpipSzpptBgVxbpSymF94=; b=LpA55TNuDvPNJoZJ
	o2ILbP6uuKoSILs/FaBIqRvUNZ3rXskSgY0pe81mRBUvlXjly7VqErYdDVHkSMyl
	5Phvwp6ukaLmdxsEpnSGz9YvXu97wZj+sSBdPaiFBpVT8z+FKETtM23WP5UWEbSp
	PDJZpysve5jZKLKrzg5V6ympYdkRal7q7DrD+dPYwwijhpG6Bc2XRoXIGjPO6HFU
	5mPc5T+DC5BY/WjjNVTl6jgxo4Ubpxa04CQFzd/rYgUa7UKELDjoxeGLITkf7Bqn
	TWCXdulkZg+Yks3teRIS/oIzbGqFSlLlfNQLz7bsLGZeOCWdMtJVPf8/IpJjzXHP
	tUwg4Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxh99c3dc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 09:15:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb38346fdbso398584285a.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773738945; x=1774343745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOuiJ6MeDMkaWLveMBBkfhjpipSzpptBgVxbpSymF94=;
        b=UmfYvzh8Ru4caShAWZS0a4yn32y8OyztfdOgNZfLRK4yBy8AVtUT0EhUnmoz2NcmUm
         T0WZNjXhBsdOebUKgqxlFL1BWOWF/S6CbM5LEyabGXKZ/BK66oyJxwg9PvXbgGh8lL94
         nB8Q9zxMA8uKmS2S/IJRL/opQW7QnDhGNue8UrUIfMml+rIYDoXCOqSG9IZxL9UeQKLu
         SfRVvqkviiYeIojMDrtUr+/MXVMZAZqnsebS5UwvPOgAY+mqc8065KaFSfhsL4KgAUCg
         AvJ+teA+yd56jVaAvMxTJA644TkrdJ5f8V2LI9s/JZAUshZjON8ec0pMINoTEHZPYV1U
         7MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773738945; x=1774343745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOuiJ6MeDMkaWLveMBBkfhjpipSzpptBgVxbpSymF94=;
        b=qMruJBfqbjoXRCUPsUQvrWViq18DnYjbvuz2tYmdT6h076ZMVzYECSZjWjjUzjSEft
         N5CZUM9/gc2SHnQiM/u3pxIeU7EMCpiO4TdfeePOdykvyLvDkDdEYXt3CJwzVu/pGXu7
         EuJf3Lwo6DWMLbYPhLNtWj/Fb0MXVgjd6cJMTOuU6VXhcabiZcyIVLcE8nAQR42vQwx4
         6V3dWKB6O46j8LGqo0vYbFasym84tXhI1MImrpnDG+1CjOxuUZKpa/oMx80yyLK8gxn8
         KdG5VPx36IcsBTG8gJsSMbjIkWMDEKJFKK4/sA+UIN9QmimXuHOykUEYH6kFRpOj8DrK
         /K1w==
X-Gm-Message-State: AOJu0Yxd5iET+9Kr6/nehBiBk/BtvyG7I05zskzHVTlw24ctszmz5YbS
	X9ubSUP7QsNr8FqtoQPzFNJwji+vUZsPh81H33ZT0Q5NguwjeTiLp4mG20LZht4XmZKKu19rDsL
	4DZDu2EuFDEARay8h7CDPl9Wey01wzdgrz+hz0OKe6p8dbIYVUmL0V66mtS2NLL4=
X-Gm-Gg: ATEYQzxy/syDD6Z6R5l0p0G5jYQ6q+acke1eFRJ/9NNCMKQR7UAef6jjZKjXn0AdHjt
	FMKcO0sl09kmBYTX4mRyxj4PU5nc+CeI5Lii1o3nWYKeXwWesK4NlRWGIHuHYvRI5vmsH6+x6Fx
	RVqX9zSBvAmHI9bp8f83Wi6LkfPab3WvwtSMQb3O87u00+MS5+UdptLK6RIcXSrAt+rC6ZujVKZ
	uA5DJBpGYC/AFJwgTk4cFKsRD6TGZBdbO+pvA9pDQ40k/SPLiLUmI/VwXs3DGc5pW7lUXeYsQg9
	9EQp558WCHw8dCo1kDD200OVCkeWzTOr9Yi0lKD8AygHpZQHJvpPwK6ntplTmVMlg97pb3gTgRd
	G9Ig08jqJupeBWaY8nOgAfoVNFuZ3U/k/xx5qempm1g7nHATzJzvdzNT+Y6uUlnwcmMCsSbHjk6
	Kw42Y=
X-Received: by 2002:a05:620a:1a0d:b0:8cd:78b6:e261 with SMTP id af79cd13be357-8cdb5a2d5cfmr1661636285a.2.1773738944991;
        Tue, 17 Mar 2026 02:15:44 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0d:b0:8cd:78b6:e261 with SMTP id af79cd13be357-8cdb5a2d5cfmr1661633985a.2.1773738944550;
        Tue, 17 Mar 2026 02:15:44 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350d73f14sm6262122a12.30.2026.03.17.02.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 02:15:43 -0700 (PDT)
Message-ID: <f3344006-5511-4f1b-aea3-7dc81a091cd8@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 10:15:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add D3cold support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com
References: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
 <20260311-d3cold-v3-5-4d85dc7c2695@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260311-d3cold-v3-5-4d85dc7c2695@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RJ++3oi+ c=1 sm=1 tr=0 ts=69b91bc2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=U-o9HKKhJ6a-R5p13S8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4MSBTYWx0ZWRfX6QJCju7faPt8
 P8t0KyoQNt6EcNR1RAOMltGSIyemQNn2J9qjYb9ONa5/1Fz9xTKXi243s7XO0DzsMt6ouI+3PyK
 MoG2242zWML9BHiunU+q8+8hVy83tBCgmHHqH2gKZakfO3c/RoGJUiD0uOIbs2E1bHZnu89gg5i
 tQlLjVz8tZEQ1UolvuQylbAgLzMlLrWDN5JFwq/rynmIrBxiyB1jPa2MsQc8hSgBMNjc2Qto3qL
 XLUFkV3SjdLY1Hif0wtgjioz0Fipj6LLgfOnfAWeey/+Vpi+wq9W+AxOqxvn/MoP+s3aa7RTQgR
 DSX883VucdAvDmj4m//SejAnWtyZ7yllL0hVRvyE65605rtZrEK1J4t8oOlQbcD+hWJawQIYHgB
 qD6aU9f+aiT3CCOcwdZ48YPv2owXrOFfCYNyYW1aEUuCapO2MxCvv1jGulh0zj94L5aZ4hF5O41
 R2P5ROjdXHSWrld1Q4A==
X-Proofpoint-ORIG-GUID: ANHCjR9X2Ei-UiTzQvvOOdxrDrw6ZIHA
X-Proofpoint-GUID: ANHCjR9X2Ei-UiTzQvvOOdxrDrw6ZIHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170081

On 3/11/26 11:26 AM, Krishna Chaitanya Chundru wrote:
> Add support for transitioning PCIe endpoints & bridges into D3cold by
> integrating with the DWC core suspend/resume helpers.
> 
> Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
> into the DWC host operations so the controller follows the standard
> PME_TurnOff-based power-down sequence before entering D3cold.
> 
> When the device is suspended into D3cold, fully tear down interconnect
> bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
> by keeping the required interconnect and OPP votes.
> 
> Drop the qcom_pcie::suspended flag and rely on the existing
> dw_pcie::suspended state, which now drives both the power-management
> flow and the interconnect/OPP handling.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

>  		ret = icc_disable(pcie->icc_cpu);
>  		if (ret)
>  			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>  
>  		if (pcie->use_pm_opp)
>  			dev_pm_opp_set_opp(pcie->pci->dev, NULL);

Does calling .suspend not drop the vote by itself?

[...]

> @@ -2132,25 +2138,46 @@ static int qcom_pcie_resume_noirq(struct device *dev)

Similarly, I'd expect that .resume restores it (and you didn't do it manually)

Konrad
