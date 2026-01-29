Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EACD2BEFEB
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664585; cv=none; b=WdBpPLceRB4xaCtwG5ojqDFUBWevBtcglFEIt0FuRvy0sS6J44G3HbJJABygTQ4f8Lwbyg5z+jILKhL+KQpXtvse6axHFX5AOR3YN7OHnx6KVQFrz8KTo6RrsQxj3txzxzBh1kOmgSf3ACTzJfbz81KB5pThqsycPxCSOQ/4qM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664585; c=relaxed/simple;
	bh=Sbmnk/JEJS9MnGGhYpxhcrCsK6McdFKtukdtdjlVr6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/PFsN8SjZqC7eVkItlJ99N+ID6yGpMx0q4qSDmRZ0leFkqeEBeJmo9941wtvbWY9Xp3/1+xCndQHx/4nr5MvWM7Fh8wt71INges5RInfRpmbmWMl3Cm1944y/1Nhtly8PPvqulaNVz2PJU3rbjVCtEExZi9EXq3budcQBRkKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X4LLkTRh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YhZ7/Wrj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4LLkTRh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhZ7/Wrj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2onvJ2150413
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8dOMexyvUvVvoxQvFfJbShrI1jevTIncrOL5kLI2uHo=; b=X4LLkTRhvyvC/Ay4
	+L7h7c2zvETYGRKjT5wvCjXE+iiRiP4y+7KXorKN80CTAMqs7JSt1wP3QBDG3zep
	ew5XD0sm/9udNmCysACUPyHjI10QnOj1g9kCTLAJox//jr6cCPeIK6HM6R+qnu8k
	iAPxP8pjdY0fIZ1zakderGaAtGSgSHs3xJ7hQk1f35cxlYGlxA24P4nb7jrQm3t8
	YbLy006GESYl46GENLLXvoVqxhMw1x3GwRT4nxR5LgHtVrx5qC7yYRqk8srnfRMA
	1H5WKUMgbeBntU1AJ9CXO8XlCVVvjs8v3PJ9EqjBm1a9NExjWPiE7oip+e19GB+k
	uZciqg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byph3a360-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:29:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0e952f153so14243975ad.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 21:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769664583; x=1770269383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dOMexyvUvVvoxQvFfJbShrI1jevTIncrOL5kLI2uHo=;
        b=YhZ7/Wrj0e3SU9OCYX1cFZ5MGf22kiNbJ/9SvLEUfj4EHgLgbVZDfDsKTmMZBTIwI5
         Vv1iYVHZPibBlTMzkiWCGc7Pz3YWByK9UAqoaYC+QtTLb4PqOHRF4AS/OVnD+eT/vRLL
         Z5TFfmuTU0+lPqJYtXXnM3D7/J7/ely1Ln74rGC+W/T1YUaCGAawbCf20tN/vHPyvF07
         kINmixZkuyfzsN6hc5TvTy81sqWAYXin3ASlBBkT/Mv2+2TJZag3ERxdrcrX963JL4Xb
         n1SqbkWbyz/Qmabo+OIXcKtg+nFlcrPFWKL3FjQeRLvppsOoRmeESqdMExSEKP13JTAn
         9QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769664583; x=1770269383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dOMexyvUvVvoxQvFfJbShrI1jevTIncrOL5kLI2uHo=;
        b=psD5NC3OBKBNVgNYWVmiXfkpqE2wYeiFiBXxSEvef68qFGA/KHmwyTWO8abC5+GbEl
         Rx5XSSy35QVFpX3UH8/j6e/NshiBCXWphIz9m/ImztkU4JETv02C+HCEH9rNgMYcMiBf
         tIuMrIVB2D7x7Fsu5uMrIUXpepyFtX9zVuFGFWDtUc3C/nInX51QCIPM3bhQ9ciQBVjN
         oOeooVJneVF1zSOi3PTuYlypZDEG6eQagp0QcIv3vxPZlKPXLMsD8ASa+mtziHX03QWG
         bBMWyq4DJT37lTEw3Er3NQJTq2aDQNBv5gb86CB5AEK+zxHr7b6HvZgNWAlgjhQRTNWP
         cd7g==
X-Forwarded-Encrypted: i=1; AJvYcCWbqlQCwD9CyjiYMsU6cL971rcrfOj0rfpgtb/Vls50Cnn/gHWTH1Q8b6KFqnNJiFRSmqNXs6TzB14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPjV0k1G/ksU8u9BmD92Fay2G4pDwFxv43IjOAeNZkL1JhasZ
	9y/KZgy58tHh26WGUlgrVeN6igOQr02hTHxKpW+bySiL40KS7VKOJNi5j8XJbN+O4dpXGVi+1Mi
	xmxUoKY8YVBMPjFpjNmAfkvSofJGLW1HKzpmcp/ZSVmxFx/wAa5Jv6IpSwGB4IuZkGOtRVdY=
X-Gm-Gg: AZuq6aLXJ3lZdav78duzYopbr9sYSAXJus4ChjS8myOZyQWO3izPIQWE8Bus6AKqUbU
	0BLj167oAzYCYC8efM8UUi2fN4aO3Z/tcrZymGevKwQlA9xvbVJjucQrRk9+tjQPqXYXFn7hXIA
	Kl0OrY9ADYaRfmYqx3Ce6iIdtSqshck+r3Jhck9O0aqbPukIcNouAyzve8N/NsLVALmNotIFWMo
	KM03e3v0MpGU8j90i43LfW2xa7nQkqvH0eu4S/NjmVBCbmG9oEskdcapswv0m8L41+N4o9Vn7hL
	9yKHD9vB6souVuGuthP2GrofgZEXQP+pBDQ3GIMnIPFmAbSK7BmkT0yzpcV7Rh0w3GDWD0JdmdT
	JgTNCj14LO7GOvYPKEaocPGc369fvovNv90OeMpUdEw==
X-Received: by 2002:a17:903:22d2:b0:2a7:5751:5b27 with SMTP id d9443c01a7336-2a870e192ecmr74202765ad.39.1769664582730;
        Wed, 28 Jan 2026 21:29:42 -0800 (PST)
X-Received: by 2002:a17:903:22d2:b0:2a7:5751:5b27 with SMTP id d9443c01a7336-2a870e192ecmr74202455ad.39.1769664582284;
        Wed, 28 Jan 2026 21:29:42 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3faff5sm37408765ad.4.2026.01.28.21.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:29:41 -0800 (PST)
Message-ID: <f9c95baf-f2a9-4057-aeca-2c35dcd943fb@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 10:59:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: qcom: Add D3cold support
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com
References: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
 <20260128-d3cold-v1-3-dd8f3f0ce824@oss.qualcomm.com>
 <qg7hyicnyqcoi7jktalyfecfgxnv4elilmmmfkzvb2jbzrhisd@bq3pngh5n2a7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <qg7hyicnyqcoi7jktalyfecfgxnv4elilmmmfkzvb2jbzrhisd@bq3pngh5n2a7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z93h3XRA c=1 sm=1 tr=0 ts=697af047 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=24nHYv6InDTK1t9ftLgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: KL_8fwIe9EJyuOyJ_LG9N9zWkftJNg6r
X-Proofpoint-GUID: KL_8fwIe9EJyuOyJ_LG9N9zWkftJNg6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMyBTYWx0ZWRfX3abv1tfyidb7
 M8YqfvVV/96tMXXmx170kDjtEZ5oO3q2KlB2Km29+AbKwiGhkMhmxBh+RaE40NGbxJFLxqlt3bo
 01Og89TLC4D8Ci2KvACUKpKmu3ZIzRDGQotUlSpG7tP+rih/6qzTz/71R/o8vy089scVSDEgmXs
 bWuZdUFsJJKqeKidILZm9S7bkw6Bk/NAA+gHUVGVUIqSrmBPsQdG8jwHOCzskB4pLp3QaK9Fee3
 MgtRgk+wNYiM8JGoKU5PpqAH3Jud7cnZxJa8C+6eWYxL4EKjLKJOJPfKXiexSaoQh3DyKXhA3om
 BcJlnCxZPfqA/KbvPm33H7a8XaGaQdjbaxIY/SwQMi1L9llgi/HRjhTjIR/yt88hMC13eeJcyqQ
 Bsdl9A9E5A1H8ip4nns2VVcG5F2gIjdz7tHQUOCDPaD5fin+1ONFI949xJVRepveWOZBMxPW5se
 p14a61VjH9yeTxy9PmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290033



On 1/28/2026 8:17 PM, Bjorn Andersson wrote:
> On Wed, Jan 28, 2026 at 05:10:43PM +0530, Krishna Chaitanya Chundru wrote:
>> Add pme_turn_off() support and use DWC common suspend resume methods
>> for device D3cold entry & exit. If the device is not kept in D3cold
>> use existing methods like keeping icc votes, opp votes etc.. intact.
>>
>> In qcom_pcie_deinit_2_7_0(), explicitly disable PCIe clocks and resets
>> in the controller.
>>
>> Remove suspended flag from qcom_pcie structure as it is no longer needed.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 114 ++++++++++++++++++++-------------
>>   1 file changed, 68 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> [..]
>> @@ -2016,53 +2030,51 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   	if (!pcie)
>>   		return 0;
>>   
>> -	/*
>> -	 * Set minimum bandwidth required to keep data path functional during
>> -	 * suspend.
>> -	 */
>> -	if (pcie->icc_mem) {
>> -		ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>> -		if (ret) {
>> -			dev_err(dev,
>> -				"Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>> -				ret);
>> -			return ret;
>> -		}
>> -	}
>> +	ret = dw_pcie_suspend_noirq(pcie->pci);
>> +	if (ret)
>> +		return ret;
>>   
>> -	/*
>> -	 * Turn OFF the resources only for controllers without active PCIe
>> -	 * devices. For controllers with active devices, the resources are kept
>> -	 * ON and the link is expected to be in L0/L1 (sub)states.
>> -	 *
>> -	 * Turning OFF the resources for controllers with active PCIe devices
>> -	 * will trigger access violation during the end of the suspend cycle,
>> -	 * as kernel tries to access the PCIe devices config space for masking
>> -	 * MSIs.
>> -	 *
>> -	 * Also, it is not desirable to put the link into L2/L3 state as that
>> -	 * implies VDD supply will be removed and the devices may go into
>> -	 * powerdown state. This will affect the lifetime of the storage devices
>> -	 * like NVMe.
>> -	 */
>> -	if (!dw_pcie_link_up(pcie->pci)) {
>> -		qcom_pcie_host_deinit(&pcie->pci->pp);
>> -		pcie->suspended = true;
>> -	}
>> +	if (pcie->pci->suspended) {
> I think this is okay for now, but I'd prefer changing the return value
> of dw_pcie_suspend_noirq() to indicate if it did stop the link or not
> (two different success values) - rather than deriving that information
> by peeking into the dw_pcie struct and conclude that
> dw_pcie_suspend_noirq() did reach the end.
>
>> +		ret = icc_disable(pcie->icc_mem);
>> +		if (ret)
>> +			dev_err(dev, "Failed to disable PCIe-MEM interconnect path: %d\n", ret);
>>   
>> -	/*
>> -	 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
>> -	 * Because on some platforms, DBI access can happen very late during the
>> -	 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
>> -	 * error.
>> -	 */
>> -	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>>   		ret = icc_disable(pcie->icc_cpu);
>>   		if (ret)
>>   			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>>   
>>   		if (pcie->use_pm_opp)
>>   			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>> +	} else {
>> +		/*
>> +		 * Set minimum bandwidth required to keep data path functional during
>> +		 * suspend.
>> +		 */
>> +		if (pcie->icc_mem) {
>> +			ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>> +					ret);
>> +				return ret;
>> +			}
>> +		}
>> +
>> +		/*
>> +		 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
>> +		 * Because on some platforms, DBI access can happen very late during the
>> +		 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
>> +		 * error.
>> +		 */
>> +		if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>> +			ret = icc_disable(pcie->icc_cpu);
>> +			if (ret)
>> +				dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n",
>> +					ret);
>> +
>> +			if (pcie->use_pm_opp)
>> +				dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>> +		}
>>   	}
>>   	return ret;
>>   }
>> @@ -2076,20 +2088,30 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>   	if (!pcie)
>>   		return 0;
>>   
>> -	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>> +	if (pcie->pci->suspended) {
>>   		ret = icc_enable(pcie->icc_cpu);
>>   		if (ret) {
>>   			dev_err(dev, "Failed to enable CPU-PCIe interconnect path: %d\n", ret);
>>   			return ret;
>>   		}
>> -	}
>>   
>> -	if (pcie->suspended) {
>> -		ret = qcom_pcie_host_init(&pcie->pci->pp);
>> +		ret = icc_enable(pcie->icc_mem);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable PCIe-MEM interconnect path: %d\n", ret);
> I think you should revert icc_enable(pcie->icc_cpu) here, to avoid
> leaving the bus voted for with the PCIe controller resume aborted.
>
>> +			return ret;
>> +		}
>> +		ret = dw_pcie_resume_noirq(pcie->pci);
>>   		if (ret)
> And Both icc_cpu and icc_mem here.
Ack, I will do this in V2.

- Krishna Chaitanya.
> Regards,
> Bjorn
>
>>   			return ret;
>> -
>> -		pcie->suspended = false;
>> +	} else {
>> +		if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>> +			ret = icc_enable(pcie->icc_cpu);
>> +			if (ret) {
>> +				dev_err(dev, "Failed to enable CPU-PCIe interconnect path: %d\n",
>> +					ret);
>> +				return ret;
>> +			}
>> +		}
>>   	}
>>   
>>   	qcom_pcie_icc_opp_update(pcie);
>>
>> -- 
>> 2.34.1
>>
>>

