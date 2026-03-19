Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32F3C13E1
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917981; cv=none; b=cAgr1ZXDpSL+8KTMeX2fyFvjA5aBnfa/T0QzrHyZW149euoKibl1w/EKxwFPi2RzbvWh8rxj2IHFgdM53qCNRta4k/L3jpAkbhbHFdl5n5uQxGa+KUY/wUPFms2QMSuwOKeq93qOni/+Goj1+RffYFAXW2O9wjJgzvpGu1A4qR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917981; c=relaxed/simple;
	bh=pzszq0HkOw6sfYVi3tVEkP+MTEocAtB93KCgrcheo8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1zDdPo4Hz5LLv0fATNRIJ/enwRcFwDwRFQazFnN9UJYKaZ88pmRB9Q2nsysEe8GrRUwrvFuNv6RJxzKbztazQidCVs7GbjjHthm9cdtSdE+yp7w+qULz622SjSZTYGanAyP6cAfXVZKh0OBiO1py4ZD7vOtZd8vcu3E/jnrZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IsiYArv8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eEIKbcNs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IsiYArv8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eEIKbcNs"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J73t8b2544563
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X/cavrXHuPLA85bpbOfu7XbzKNw0TWykcRtdU9+1QI0=; b=IsiYArv8Q5wCOWcn
	aNPzLyYKAYTH2FWy7LAWhYJCKCPLLXUUg0qBzUl1yrYCNs/QRcFn9Nhb1xB7CBdD
	KRry92ay+r6is7rb6gSO+XJj3Y2P+FqtD3H+9IumvnYKdRR64JznEMjjvko3Ycbw
	Q8rwt8BuKxqkyCs4GY46XdRczNQzg+fLpDj8pAE+hhwo8tQbJJ9yZHtTphkdfPQG
	tU94rbHXXHjm5xO6eXa9IwHu8U4qRfPBbPYhv5p0GpcaWJrM9JRlsDdLwG6+wMX1
	Xba9rrMr0BNxoiyff7TpTBIlprb06A3G8vu4MClzUBSI2rxDIbhmB8piiKshcYuc
	GPRh3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0957s9fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 10:59:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50910ca6ccaso11491061cf.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773917978; x=1774522778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/cavrXHuPLA85bpbOfu7XbzKNw0TWykcRtdU9+1QI0=;
        b=eEIKbcNszULI/5Elzc6Z0dBPQlcSG7tekejxckm+02+VMk+jxyaZ+dPYxU6Ar6eRbP
         TCueVbHF/zkH8RZTkJTquC9NEl7Mlm/SkTqoxGyT+RaaCt1JuqmZ0Oa9VbaFYOB4Qh4d
         ghbgKEYRByy5trXZaf7lEp96y4USw8nZo9IpfWygsCHOrpyX/YUobWfJ3aLvrG9NXwf8
         siyZ6TReY8JRualZc0irm2Yshpx9MVgvbF8ExVTm+WDgNX85BYU/wtknIZpDjJxNMgU5
         3NCClbazwd4Q9TI02mQJcTvmh/8UHOma20rmBXp44zhxBU7RczWeBsqpeXbG+RbVIx+J
         tpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773917978; x=1774522778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/cavrXHuPLA85bpbOfu7XbzKNw0TWykcRtdU9+1QI0=;
        b=sAvnKNEL4YWeJWq6BqEQJHeJgmrrEaEUefT9lHGQWFDSxZHl/SXiXtVDowCTZ6lPzk
         LdXa7ZmmiGivok+mjTpFDngiTXO5htVThTfFS6OvsLoTao1sD6gwm1lu7wT2kcPvI4mz
         HzruG9qESyVfGQz65nAtLd7gFypIvDTuVgl7Hau9mahAiLO5A52ZE5/JoNRjF+/5Ddno
         wFsRI5SjRRyYKK+V0ytf91b0VM7KblxYwike2vpyK6hiLsEkgohd4PSjLaGwXtfzOp8T
         9tMUHMro0kw8sgIMf+sJCaayxKxlmvU/wYLJ8EJDBNnILRKdY9oXsrcgHiUMtdVm8tLG
         amlA==
X-Forwarded-Encrypted: i=1; AJvYcCXycTfulET9sKwjX1k7cXfdbb5R6twyLiffSJqjNlFwXGVPFOtAYqKKtKU8oMHwbJZ/jTk34frFryE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSuiUUih9Ay2s+gUDfPloCItiAsJiCPGWj4US+WQRJJOI1PShY
	AV6Y1oxapDjWO7LrHwKl8YaigZWFSOGAUmzhGJN50sXjMq/IxvMV5mELeBI2pjT9MI7mcPpwz0s
	ubVDWDrcJcZr411wpkfRIuUwdpGD00xnVWfBi1ABBew28nVFLoOBQ1ZS2uvwxup4=
X-Gm-Gg: ATEYQzzW5VQs4DOphxO+JIDfS83AzUT2XseqlVwGR14YT36SaVHOWWwtg6a7nRAti1U
	kmXKknLB3C42pzojYbbx1zthKj0EuAuyfo0l6G/XCWBTlOy09khvzW0U1uEIABvv63FD3A02xpb
	efwGoSaEGv6buxbHm7dmlXj7a5n3Xz5ukhuVZPW9YxTBckdRfrJABLb9vYyVlvjeSpkqlOF9JmW
	wWkC/TCA5gYDmiHjX7PyL1SIEWqST8V1Wnfq8Ie6im0FEUZzky7TvTzY6qQwcUVP8bYTH7tcq/i
	xcl7urvX5SeLPH/OgCwPUVKilQ3QFTu52/HhAWj19ThHebs6y5H7kEeYRXfl3QWGgfGUJFY1vR8
	XKPEMcW5aYYf8e2lg1IHMsCbAJFZut41gbpFkFVqLleBpSURTAmhAKcj/A0e/EPey/sho/o2XSO
	peOXU=
X-Received: by 2002:a05:622a:1899:b0:509:2a92:809f with SMTP id d75a77b69052e-50b1474847emr69797601cf.1.1773917978075;
        Thu, 19 Mar 2026 03:59:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1899:b0:509:2a92:809f with SMTP id d75a77b69052e-50b1474847emr69797441cf.1.1773917977651;
        Thu, 19 Mar 2026 03:59:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667af38d891sm3516621a12.9.2026.03.19.03.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:59:36 -0700 (PDT)
Message-ID: <e94f9da7-3daf-4393-9455-6707cb963e0c@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
 <t66kmmr22z5anjhhez3mwfbmy64pz5246e4oepvpwf5j5l3u5o@i3gsh22x4dst>
 <015d00db-9ed5-45a7-83f8-1b10bc2ee457@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <015d00db-9ed5-45a7-83f8-1b10bc2ee457@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gbo-th89pTgxv9noE-dvjLa1KDqRghwA
X-Proofpoint-GUID: Gbo-th89pTgxv9noE-dvjLa1KDqRghwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA4NyBTYWx0ZWRfX0TvjrlibnPhN
 iqvk1aY7VmMv099JQ3LRjhIJY10/4Oau09umHDDOf3fUZzhE1wI3HeJjPvUR1gQRi+JRcYuM1EW
 fr17FQc/Ik67+cY56dG7QePVT5syglztS28FCMe8fvW1qj7wYJbpIVUhJJyFabJW87Q8mqo3ppO
 MDLfEM9ruZw8oni6kOS5r8fydpzsHKBMQXr/FlUW7LZq77kR/jPmA2RUEjkXYiH/ufsf3YFaVPO
 ZloWztGuSngoRQX4pF9J/YfT6yl7fHjqjIvwS/Q6bFSUcKcqdgomOA2d6QItLs4BOopq74TUwch
 2mC1vxbMKE+kK/KiUSR6AYEWXwYeJzNaQvB6af9HUSQjG1afRo5Vs4mYSNRjYl+Y/3RyVmMtDdx
 aRya8LmgCa9xGwpv3TYRHojuVS32I15Sf6TN19y9AXs2J44Ztu+YkvZMCqbqC0chsYLHn5QCGS5
 s2DcH0NbOnGSkk/Pntw==
X-Authority-Analysis: v=2.4 cv=RZedyltv c=1 sm=1 tr=0 ts=69bbd71b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=quftkqsqjel3xXnbUM8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190087

On 3/16/26 1:22 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/15/2026 3:39 PM, Manivannan Sadhasivam wrote:
>> On Sat, Mar 14, 2026 at 07:26:34AM +0530, Krishna Chaitanya Chundru wrote:
>>> QCOM PCIe controller advertise hotplug capability in hardware but do not
>>> support hotplug command completion. As a result, the PCI core registers
>>> the pciehp service and issues hotplug commands that never gets completions,
>>> leading to repeated timeout warnings and multi-second delays during boot
>>> and suspend/resume.
>>>
>>> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
>>> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
>>> Capability bit entirely, which also disabled all hotplug functionality.
>>>
>> Just some background: I added commit a54db86ddc153 to disable hotplug for Qcom
>> PCIe Root Ports since we were seeing completion timeouts for hotplug commands
>> and also the PRSNT# signal was not exposed on any of our SoCs. After checking
>> with some internal folks I learned that hotplug functionality was not exercised
>> in Linux. So these facts made me believe that hotplug was not suppored at all.
>>
>> But it turned out that the Qcom Root Ports support "Data Link Layer State
>> Changed Events" such as DL_Up/Down events.
>>
>>> Instead of disabling hotplug, mark these controllers as not supporting
>>> command completion by setting the No Command Completed Support (NCCS) bit
>>> in the Slot Capabilities register. This prevents the PCI hotplug driver
>>> from waiting for commands completion while still allowing hotplug-related
>>> functionality such as Data Link Layer state change events.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 67a16af69ddc75fca1b123e70715e692a91a9135..a2924610f3625f2456a491473c135840e31bafb9 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -358,7 +358,7 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>>       dw_pcie_dbi_ro_wr_en(pci);
>>>         val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>> -    val &= ~PCI_EXP_SLTCAP_HPC;
>>> +    val |= PCI_EXP_SLTCAP_NCCS;
>> Are you sure that this is the only non-supported capability? What about
>> Attention, Presence, Power Fault, MRL etc...?
> Even though there no signals required for attention, presence etc in the hardware
> there is a way to generate these MSI's with these bits set through parf, so technically
> so other co-processor in the system can trigger interrupts.

Are you saying that the RC itself will not generate them based on what
happens on the bus, but they can be triggered artificially?

Konrad
