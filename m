Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1164A341A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954463; cv=none; b=gdXuwxoKBW1YehPOK+F62FIrYJUD2m+jwu0+o3Zs/d+vrmp0/A/YSc+hZUnZ/q1oNDkmk3yA0b8V8M/Vp3QzYoM+OWli2sQum8Q+z/dV7YOgouPBXS3R8bD1PD2cMBSuigIPronzaJWF6LF/8Qu5fFrkACxW4tgKAB17dbkF0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954463; c=relaxed/simple;
	bh=bE7gFNvJpgqAb1CCf/LUtrOOgo9UiCo9vR8xhbQKK7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIUjdk1IGSVMHBPQeXPvlWXy+BR8KQX9wn59pO49FHWn/X6CBZnJRER3d7uK2+tjQISjtS4kCMfzV5zoF5mPCh7Nrj7sDqELAixq48b0uNjGCJZD6DK0fNu9h2pPF/4rMPP2gjxKvW0BuSeqGGK02HBzNtJmXfjK3WOvkp26oIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hc0SLmX0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SfTp9v+M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hc0SLmX0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SfTp9v+M"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUAOa2653583
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 11:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5LtEQ/D0fxKgSOw/wwJk623IFAnhoZEdLxvz4TnSVR0=; b=Hc0SLmX0LuMgPx2/
	s7usEhsEMGxv40BYRumnoi1d+ragd1vSsOAlOEIYhmukDhMvpNUEW3ShpMNJ7tgf
	N9dGlxVMk+Cni5hkkoLFsyJRsM5lbSyIU+UAY5c3lFGguFMmX+MehFOtIjTvaEvo
	+BFXKJUG0nj19kr0RTN5wktKr/l3FWfF2dvpEHIhJJZa0OedoGskYHrkOrsPSGa9
	xTKLsiXsl7iaK4pqL8ZZDTZO2nlzdpipBVvssR4QZtRMQ3KUKUwNcxEsDNs6yIxp
	3NAFWmkjHiV25v+XHSiF9m1+YpC1SbIRwE1alcPsOCYpUPml0yX8nCME/CNEHAdn
	34w1KQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqha3uf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 11:47:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6823efcso59124935ad.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788954461; x=1789559261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LtEQ/D0fxKgSOw/wwJk623IFAnhoZEdLxvz4TnSVR0=;
        b=SfTp9v+MoAN855dcFDV4GOpBAoeSnkO7HFmgdJzwW3nUWhM/++vzKV525gqAzQ+kTv
         5uIJ62oxzM6XNYQF1+6T9TMqOWurlrxavPEaYgR57+9UabW0cl/y08styhzj3ipt0SHj
         j/6fO3kiq+ZzhtBYLW1/27eSghFIjBuSQJF77z9OzRu0Gqs9CHA8g6JystdfeyuMzNDc
         +h+vt1qvVhD5izBR2KIKPVX6xFPvVrL7UX+9ARhGyAmW/12y/DMmkzcs2bym9BtQKVQE
         tyUFslBN+9fv/PAVg8ofX/Ant52WoI870kYsJsPWG5brKfca8uvtSQwhO2xfBCQfrqrK
         Z5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954461; x=1789559261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5LtEQ/D0fxKgSOw/wwJk623IFAnhoZEdLxvz4TnSVR0=;
        b=WhGj8gqN+p+aPdhpLAJZ1hAVEQEM2ehJJ2kmdZSxpBb1zQaeJG6S8xlgxwO9a/Azds
         49TslZ8saLTJlpmMdoK2TIiF3K9s1DWhPAUArpE+3/N8u1sxbxOa3JY85JfZZlizyaCR
         FK71qhdcQUduMYtmA6uEUp4rF1L+zgCBFv2b3+zWxGjTrxdcJzZ6YHn+eGVABlXm65k/
         v7VSfSs/EiwR3ZnoSj+apNZFforbNn9qWLoO4g/D8oEs3nooVU4cHZRKjUBj9Sj4Sal0
         V3qL8sD48jnfmLl1A5j3sCG60rM+UkS0hYDFOA9V4dTOtIHZZg2CVgL2DMBS30S1skMB
         eiCg==
X-Forwarded-Encrypted: i=1; AKwUvBy3GPQzNFMvRCkPEvNg/JpBMn+Xf+SyGtsXW7POMFAIYdhDgB6Q8E+AwQJjqACEbs8fDU3bcS2fJ0w=@vger.kernel.org
X-Gm-Message-State: AFuF++nBiMlpV+drO5cVQsn0WOnQlSvfXlpjIPpiA7Ls4Z++hsP3tBQc
	DtiPg4Kg7GpjJTasd0XMs0TxQvl0dhLcQH215pH4o2MZTYGg2dWhqCBJAGSocKbd7E86xWtgOIR
	RbZB/s5MhlV9eEt7V/LZBfb0T+P9Gtmwx/2wjGF+mHMCpzKUDX0J4INcZ9uOpyTc=
X-Gm-Gg: AYBFou2vzr3Hrw/xcEbZM02YRIhEuJIqQioxLxRCGciCnS+H5zY+j12xjnSVWVtC9cV
	z6FK0Es89F7CyWOyy7eUEObxAYajqdpguNqgtfyNK/0VCp68z7gFsBsWUcB/2zPtKbTWlX0Gw6U
	JFTbSOWna0UQnZ2Z3UJO/ASbX5+asOvXva2YM7E9vE7ERuWWB2irlyttBpTzTC/rVLfgbGVxjQq
	X9oY0KEAMqk0txkpQaatEaP/aFq4daYBROtjlU8McwM7gmJVToz9lAP/fN14P0eFAz43+HAxPkh
	MPoTMmEVEBrlyVjB8gEaBpI49gEKq57pVn5aGEv+6kFByL23KqRWXHHSl3H34kPfFDKbusgSDfY
	VF6AHzUWcpb+RW7iOFnc9G4JsZpCZMOE+
X-Received: by 2002:a17:903:1aec:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2db125ca3bbmr502542085ad.11.1788954458804;
        Wed, 09 Sep 2026 04:47:38 -0700 (PDT)
X-Received: by 2002:a17:903:1aec:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2db125ca3bbmr502541325ad.11.1788954458215;
        Wed, 09 Sep 2026 04:47:38 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33825669695sm20505746eec.3.2026.09.09.04.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:47:37 -0700 (PDT)
Message-ID: <86e53b35-b096-41d9-b15e-e029ac59d84c@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 17:17:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
 <20260905-shutdown-v5-2-f0c6bafa1d4f@oss.qualcomm.com>
 <tkcout2ymlzvcx6my2hal5hgh4fxcpppxl2t5s4wogz3hjykp6@k72ig7seb7m2>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <tkcout2ymlzvcx6my2hal5hgh4fxcpppxl2t5s4wogz3hjykp6@k72ig7seb7m2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX0OCgEGzC48TA
 yJ21yQQlKT1VIw7z/If6Rvt0s0q5sKDLHLX5xo4B6IHjXrROLkxnFu9KRKPC/xI1CUsRZCckXO8
 X8NmXGzBK0wuYfzOW9hCh+rZc6nrEjyLcj7Rz/8UX2DWqD/+N9AiPkG03j86mSd3fZ/x+zW2zfd
 NqEOtUxXIO7XqlsCtap4ZBDPIpkOzp4hjShu8cRHwnuUFxupQE5PnQ3/EPon/2ir97hodsVtfbX
 gIjwcr12bOkeVT8k7TiGPMtXuIAH7x0NH/ImVLtAaox3QyYVfhwGZfFERqdsBHWNR3yxrvaMmme
 nLd9zK+lKNlcg0vMCX+W39eyOCjKMMi6rLmTUq/0FSwn4FIlhNKtQItBrvKjgZVmjad2mW39eyq
 ohVBL8EI9MuSC0vrDGVJOEnXPgYWV9iwf/mvlCUiU1oqmsJXo1FZp4vPO+3+0cKTh7tsEb5leL2
 CwHGCMTgFvRoSORAruw==
X-Authority-Analysis: v=2.4 cv=Z5Xc2nRA c=1 sm=1 tr=0 ts=6aa1475d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Q-PrnzyzFlRskm0mrpIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: QAXrOtvLbDk73DqTDdyDmDBBXWMqs2y0
X-Proofpoint-ORIG-GUID: QAXrOtvLbDk73DqTDdyDmDBBXWMqs2y0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX9JmaqlCEFzHC
 PrywZHGX3Cv21KVj9dV8Exg7xIZQ7RaxnJsgttKipWx8H84UJzsteHtv3UMpbZSItIWoJbTMALi
 v9XDciDxGJqDTh3++H2b92RBSAM6ZJY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090131



On 9/9/2026 4:30 PM, Manivannan Sadhasivam wrote:
> On Sat, Sep 05, 2026 at 06:18:49AM +0530, Krishna Chaitanya Chundru wrote:
>> dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
>> to check whether every downstream endpoint can be put into D3cold before
>> bothering to move the link to L2. If no endpoint supports it, the
>> function returns early and leaves the link up.
>>
>> Querying D3cold support during shutdown is actively harmful, not just
>> slow: pci_host_common_d3cold_possible() requires every active endpoint
>> to already be in PCI_D3hot, and returns false otherwise. If any endpoint
>> is still in D0 -- which is common, since endpoint drivers aren't
>> guaranteed to have suspended by the time the host's shutdown path runs
>> the check fails and dw_pcie_suspend_noirq() returns early without ever
>> moving the link to L2, leaving it up right up to the point where the
>> system cuts power/clocks to the controller.
>>
>> Add a "force_d3cold" flag to struct dw_pcie_rp that callers set
>> explicitly to force this behavior, rather than having
>> dw_pcie_suspend_noirq() infer the shutdown/reboot case itself from
>> system_state. Still call pci_host_common_d3cold_possible()
>> unconditionally, since it's also how "pme_capable" gets set, but ignore
>> its return value when force_d3cold is set and force L2 entry regardless.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index f5a38e6fd8d7..a8a3861c2956 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -1224,14 +1224,15 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>>  
>>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>>  {
>> -	bool pme_capable = false;
>> +	bool d3cold, pme_capable = false;
>>  	int ret = 0;
>>  	u32 val;
>>  
>>  	if (!dw_pcie_link_up(pci))
>>  		goto stop_link;
>>  
>> -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
>> +	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
>> +	if (!d3cold && !pci->pp.force_d3cold)
> I asked for a parameter in dw_pcie_suspend_noirq().
I misinterpreted your comment,  I will do it next series.

- Krishna Chaitanya.
>
> - Mani
>

