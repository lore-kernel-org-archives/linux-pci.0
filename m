Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D1313E29
	for <linux-pci@vger.kernel.org>; Mon,  6 Apr 2026 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466498; cv=none; b=Ztnc6yxBnu1BzfEvSN3LjcdlCTuHYfZpHHYvRjwDK0XzTjCT1dLWNQ1BRqbALdu9CnGwHCa2t/SdDrJwHX85XqfywgqgKCI3ZkAcnSROouRmzT0QePaGg8LMnEdxoPcxpIFxAynRGY+Cn84TxodXuY+/ywP9IfSIQnOPsVUdoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466498; c=relaxed/simple;
	bh=MfwoD0EbgFH+fWluI16EkhQqg1s08M2hAVKyQnPEwBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWAQaecOhJGWJb3x69xpbmW0y7fXA3UrXOKLMrzlo1zjskLLEK5RhfPBNCV+macV49tuYH+ZX/WULilHhWbR/7+35GRyazSds8IvEYO3QFGNDyUNIktCGh5Uv/3nOvAIXixvzWKCtnqzhAVungGYVRpbWcxtGUQ5gXVU8wsgknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RslgA9wt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eHpdcH0j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RslgA9wt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eHpdcH0j"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6364K43h2617803
	for <linux-pci@vger.kernel.org>; Mon, 6 Apr 2026 09:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LM+Y0miUnUzTeudMD3Tda8M4xxPiG7m13ymCNOxTEDE=; b=RslgA9wtaqqpgfBD
	SWVyAGQKq//A+uk52OWqGRpVV2pSemhkJuNEBXY27f0GoW9MqxRqytr+iQEPm6RT
	6kdlb52mcK1fMsT1Skma6YCAQ6ecUaz8kbW3W4cA8qb3lGiJcloGuDmPFc6Smsbi
	2xOJ5dwkzR8EvBeyDyVmP7EEWpTmarFOd2CYjzi9+dwAXv7Bx94aVxnGfvCJLzLA
	CUelAqpk2+j4Kv+7WQ8jBEPW3FESPyBuqyADu6KkZnN7zDLW97WpUCasnKqz7jc0
	6tUuoDyOJwsYJbRUrH1xtLC7Wj2LVdrN3mgtZ2w84ZwiHyID0yVLmgP/JE8S6n6G
	1GEfTA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daudd4hmy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 06 Apr 2026 09:08:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b242b9359aso35910505ad.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Apr 2026 02:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775466496; x=1776071296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LM+Y0miUnUzTeudMD3Tda8M4xxPiG7m13ymCNOxTEDE=;
        b=eHpdcH0jlFmIIub6Pd07hTA+3dzBThUNaLSfoaE4rEc20Sju46WwxGXk8Ht2yLEGlI
         Obn+saHeEyjQ/RpjuA9nhIL4MoekJlXA8biggaJ0TYd11AqgGPwiL7/z1PW2wAAsvgrd
         8jgDirJHsO2uxDeEpNVDZi2yB5O1znn1GCBMrzE7UIfJOYQLhl6go2qO/iNCS0MskSaJ
         ahXC+Lo1DvP4SNE7ApETpxCF6WWhEBIDl+talghxJN3ady05E7dM6L3qWSKvcqaqumbY
         Jvuw6KRiVJvu1hReJA740ZyVgY0d2KgAktysuEs1+I7KnLTTtgIu9Df8ww/uW7BLyLan
         Pnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466496; x=1776071296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LM+Y0miUnUzTeudMD3Tda8M4xxPiG7m13ymCNOxTEDE=;
        b=AOu2XjRiYBISf7Ld+e52/LDz/ohHemcfBfrAFM/Jb8KwxC5RAjbR96Vr5P4tPyQ63+
         Xr8VO/zewp/crKq3Hli0DlvRAMU9LW5z8G4M9+acB7+Jhf5kuCRjtqex4S4xsxTko0AU
         dawd3ooCmeIhZzjoViaoY4186YlHQozPIEzLTGlbOwEhM9RIdC+FaHavtgCxLBBkEDN6
         0ADxy86sxei336qQlMlKFWGnRWNEleODQyvX6Gehko0FQv5jbT/m6PWvx72bivO7nxoO
         Y77ff0hd+RBj4bGdRxzm5K8JUMLr6pwWuPW7CBPJjj/YnuseYUvibexcV3luPv1Ssyrc
         6+tA==
X-Gm-Message-State: AOJu0YwEKyLhONUorGEn97eoP7m2KXQ/BPq5cd9D72cpqXHs+AlbXhEK
	JOWR95yDyEtd8IKC1cIlDdVuLXmJ2bG7NlQ0m9uP/m7jGy2l/hUhrbmNEys9IBiRbJIlDLV7u60
	Fuc6wT+adkT5zk2Kx2ixNZF+Imjy/nzKMI1TFzqUcJxt50bMosXPYG49Vt6WeYTk=
X-Gm-Gg: AeBDiev3hZjIaAr1G4Olu/7YUf1TEp/UyjmkkOc/vUUKRajpwoiTYWs3tIQB8lLJuF2
	+VaKoFAWSq0HgDHvSkagHV8mbD/aE7fujHyqqQqaImopCUuuGI5a2ovOubMrvwJZkJ1WQNUgrJw
	s4XHT7BWLYfABwbJTYRmLw9ffhrB+HpZ9RmWnt6hLBy/GA8A4gqG2DwnypP2MwswpX3yqP1WMXY
	/r4zzGBNjJY59r4K5ddms58YFZdOvS+RiFwoBDnHlk1w+wo88H4S7C6+D4zlrE8ofzJsAMOuWKR
	F+VQAaiwi8d/jQ655BZRs6bL/Fu6JM+XiSZzWf2OdeZXake1/QtUZYCulf52X9e1C5NScC+jsEV
	fNKJOwNLrgRgXv2Vr8xSbSDWj2EWFvzx0FUVqVHBocR+8wErZrj6c4A==
X-Received: by 2002:a17:903:3b8f:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b28164cfebmr127253775ad.8.1775466495646;
        Mon, 06 Apr 2026 02:08:15 -0700 (PDT)
X-Received: by 2002:a17:903:3b8f:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b28164cfebmr127253395ad.8.1775466495178;
        Mon, 06 Apr 2026 02:08:15 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm140897505ad.53.2026.04.06.02.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 02:08:14 -0700 (PDT)
Message-ID: <4a18abf4-32b0-40c0-bdd1-81ea819c4089@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 14:38:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add D3cold support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <f3344006-5511-4f1b-aea3-7dc81a091cd8@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <f3344006-5511-4f1b-aea3-7dc81a091cd8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bkPWd8dwDmcEcqd8WNzrxW0WJp5BSBNK
X-Authority-Analysis: v=2.4 cv=JZ2xbEKV c=1 sm=1 tr=0 ts=69d37800 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TnsRN4puekgCtVQ3KW0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA4OCBTYWx0ZWRfX+T8VvYxl7FlX
 ARZsDVX9wrX6RQ+QTyTJtnrhveDcz4BQl6hXVPI9ryRmjUseG+RPnOyWq9GCUG5uAWUvbYMXrwS
 nin853lPmdH+6QMWH2lxEpkjAwhyIBcg1qRnWAPH0RvSf5BEHzjG7AnExqz0gVyaLLWv9KUOu3O
 Vx8JnlRKpy+vzRcwRqzBD8J6I2H5sqpj2NDveWe/bPT7GgWm2IMn26CcYESdk2UiVeCgiOZLbdi
 uNt1cNixdLuVAAgao3wkKQoEINZ2Oe4fYAv9cp0aHazxmyuRn3wkYO9c8sTAEZtbx0r0uyW94G4
 qzjG+jD5qm664ipRC7DK97KxbTrA8yVmyAgu8WibdXGpLuas7wCijim5tUY5okQJ7+jYO2z43cg
 yVv2NNYcIfrXMElEXYymU/UpB2FIOu0XGuhDNgN4YyMocNuORID/ZH31ff4smeRasfZb/BlWjte
 FIxSZgkv4Frpnqr4Wig==
X-Proofpoint-GUID: bkPWd8dwDmcEcqd8WNzrxW0WJp5BSBNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060088



On 3/17/2026 2:45 PM, Konrad Dybcio wrote:
> On 3/11/26 11:26 AM, Krishna Chaitanya Chundru wrote:
>> Add support for transitioning PCIe endpoints & bridges into D3cold by
>> integrating with the DWC core suspend/resume helpers.
>>
>> Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
>> into the DWC host operations so the controller follows the standard
>> PME_TurnOff-based power-down sequence before entering D3cold.
>>
>> When the device is suspended into D3cold, fully tear down interconnect
>> bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
>> by keeping the required interconnect and OPP votes.
>>
>> Drop the qcom_pcie::suspended flag and rely on the existing
>> dw_pcie::suspended state, which now drives both the power-management
>> flow and the interconnect/OPP handling.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> [...]
>
>>   		ret = icc_disable(pcie->icc_cpu);
>>   		if (ret)
>>   			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>>   
>>   		if (pcie->use_pm_opp)
>>   			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
> Does calling .suspend not drop the vote by itself?
No, unlike genpd framework for power domains, opp votes will not removed 
as part of suspend.

- Krishna Chaitanya.
> [...]
>
>> @@ -2132,25 +2138,46 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> Similarly, I'd expect that .resume restores it (and you didn't do it manually)
>
> Konrad

