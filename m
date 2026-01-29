Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DEF2E7F39
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665147; cv=none; b=RKrak7jwNe2htVmPjUTeHRVPjQp5S6f301yChpbCWFlFCAWFsWP6oJPSZwrPUAxgr64NAXjh5bEiR3zkzL2FANwCASL1liTOgcOnOI9O/7DVylhAKBJA59xcdT28O56/DyVI20m5PpBG6RAFFk5U8pR4ijWyMiPj1V+kNoBKMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665147; c=relaxed/simple;
	bh=HyJko60eCRtF4DyCZl7x2QscYp8gyL6nycvJrzkIlL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aifmPjgCTByOqdOWXl0q6O6rn+B+0qSyO01QN46RbhXCW6IfoNWH2Y2H5SJnYZffCiT82svQGAkuy4cLuvfbIh1OHIEaWJkAdzqOl0fy8Cto1Ghd1/JStvJLzk6Z+s6PFUSvJ9JGXI8tZw/WNuOKC95KVJF7vTnb219o7gqSeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HOZGFFK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dYcJw+q7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HOZGFFK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dYcJw+q7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2p7nG2061110
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VkukUrhkikTfn5enumCD8SQWrFh8BVcAlcVi1tx2nYg=; b=HOZGFFK8wpj0xw1g
	UE1nkYDP7qUKO0k0bGR5HP5oK7OIMpZUCsKSoc/fkrRjAdGmP7OLbjQzi+rYl8Sr
	L42BdhvPKhCre9Q+1ZBk3jCbJWOXd5rdOqtsZOs0GWJR6WLa7F1xafkUkgYZ06Wm
	Lyc6gWGDM2uwUupe+ntb6vyp5lzA/wUsgX6PMyQwYFHDVBwI0t9i1MVpaaDpalGu
	rx726EM5vIP4NUh+5TyJ4e5amm0Q0DnCjdLTm1+ulnzzQHBJumbM2upTUFyIerBl
	IXy02z8MHoY+Ujhq+GjOGswfOkovHH8/n71QHtQXT7yfnChwZUGXnTAvHhxdoqq7
	w6X+HQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bypgrj37e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:39:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82181ef69ceso291565b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 21:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769665144; x=1770269944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkukUrhkikTfn5enumCD8SQWrFh8BVcAlcVi1tx2nYg=;
        b=dYcJw+q7xVdXI+1PJh6N5qhvA05KDfr7ZruG8UXZxJXjB1julNU/AOACY9TdZ7d5rn
         lVjRAAICtTK+EW1oeOvAijtRZpIXzl37QmUyVfaBo2F0iqyxeDcbCEAWSV3FYh2Fz7kn
         Ku71EsW2DOpNjDV7W1E3JIfwWFBLNcp3Ae9gF5z/1gKMcHzKW/VzJ22OeFQmNGSLoMvz
         OfObPENQe3y9KhUQUK61ZNrDpOwEqKbzLC9j0McjU9R1d0gpqQNrV4hKA8llz7mQuE9c
         HLYEedMErzmncYhwT1m2dThzDW5fBCWDlytEpPfw/EYwt5FiZnFjU0MtaZ+g1YYIhkGQ
         /YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665144; x=1770269944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkukUrhkikTfn5enumCD8SQWrFh8BVcAlcVi1tx2nYg=;
        b=mQSBtftcTtJZ1vBjTFkIKGEm9IXcnSLMQUCRUrsELuP0ToQ9JBFhobNejpzra1FRJM
         qwqx2OTDIQByqeAxa6jlemA00+nkqiaunA6TYaX/MQg68XWdgtFMNVZDjVRSkdwfImqA
         Gp0ffvb+1FSIHlLUd8XNh02wWb0tYC/dP3YZqQEN1lz2p0KcTa7MHjx7yqZHoyuCWJ3U
         5nYRbdzOz5O6Nh8I7pxCcZ3sE8+60glGa4jy0ClnAj2GIV0YPHSeAosFW/KbO4KOBvXF
         0nTKQ+Mn5Nci0i/gU5FB/TIFFOTWyEL/dYNbT0pSauSjnow7CPZ15krzSq2kbH7N5OgL
         7xOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDH9CM+jAeOhkYph7r7YDmaAmpvhiNKoHbDbuanx7kSBT1CeOECPl5yD6VWQE70CEjTRsmFHs8RqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYYYsbO5L5DMUAmwWtJMfAWiBR6AuYMbkPz7N2v3H/ZRkU6fM
	56/7g8du6fmHgrT0TE4eM/ZkYEfVilLZE+FnhnJXfqgolJJKKcIzA1E4jrqTxlfRNrhuwpE+fIL
	IRL20LEJEUN0uaV7g19+vSb5Snd0t+6O6U028TG0PhBHyv1ue+k1+vfgazMpFhvM=
X-Gm-Gg: AZuq6aL94x9hudeJZMUmp4EbyksNgvpwHthSsru/e6YVJU0idSd/cFexoLLTBdRGucL
	iPypeEaIpxLfqS7SXKBwyOjRxSGbTJMwz8PUXYJh0KCAgg1J/G8h3UO25yOzG1PSGjvbkW2OVkA
	6SYjbdeKeo6Fukl4WTaYKGjdYisq971Ilye+34kd15yiKevoR/Fahccr/Tr8ipB/rpU17WqKxw/
	g26XHTepGEDM0l9xWcVp/1dCekRBDLMjVPUG7UlyRJbC9msLxGStmK6Tb0E7+m5ETvRDyf2iMla
	bXPHdfdC15m64DrJu3sO4/pbAh0Rd8nwPQApnFbkoeqzFnEsLCPqq7VmtNQcsoKuj6KA/EpDye0
	Gz5ppxnDxCSxCUBREoiNBMou/Sa0FwyyFeN17h7bPkw==
X-Received: by 2002:a05:6a00:9a6:b0:81f:a85e:a627 with SMTP id d2e1a72fcca58-8236917dcd2mr7727722b3a.27.1769665144378;
        Wed, 28 Jan 2026 21:39:04 -0800 (PST)
X-Received: by 2002:a05:6a00:9a6:b0:81f:a85e:a627 with SMTP id d2e1a72fcca58-8236917dcd2mr7727702b3a.27.1769665143884;
        Wed, 28 Jan 2026 21:39:03 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c5a190sm4725770b3a.68.2026.01.28.21.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:39:03 -0800 (PST)
Message-ID: <832e8ea4-2b85-4513-a285-9d4ab1dd66b0@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 11:08:57 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: host-common: Add shared D3cold eligibility
 helper for host bridges
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
 <20260128-d3cold-v1-1-dd8f3f0ce824@oss.qualcomm.com>
 <kztudduots342zz7gnx3twtlvjm5pd7sde627zxcsbe6c2imqk@7mmp7vjght5j>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <kztudduots342zz7gnx3twtlvjm5pd7sde627zxcsbe6c2imqk@7mmp7vjght5j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d7T4CBjE c=1 sm=1 tr=0 ts=697af279 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=kJBpcOZ6olZWUerAqwAA:9 a=QEXdDO2ut3YA:10 a=-_B0kFfA75AA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: YOKhlgjZ96oP8jLLuca0TsnvWOxH5pZ_
X-Proofpoint-ORIG-GUID: YOKhlgjZ96oP8jLLuca0TsnvWOxH5pZ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMyBTYWx0ZWRfXxKd7+qJO6ocz
 5CwdjnGx/ZHxNf8/7tPfy/l2Z4If4JsDWKYp0DLJWn9UEF9sEQVVgwbsJiN4bLURV8LMK+GyqWG
 E36PLxwX/ml5tLarvN3me30BU+2ezXFkSJiDE+l8qytXWhrNU0QQiHCigmJ0KH6sVA1UX1ZFl07
 yfNLMDJ7BbvqO6YEevOPFjvon5aac6ehAiFuuWEo/Y/RZ3v2RepeuQKA6npbUUFv5x7SNL+C6+S
 hReVX8lXSaQ5dKGoIv8ftJdncC3Cjjo3shW8uX8co1/cUKETYRqqwHRBVMxk7lpXplC8NTqXRcX
 i34qTZGyTFII0qChATPGN8k6+2QiJ8RYN1G5zvUP1MuDHHRoR0oJ9svh/INemna6lexaqDzb8U1
 Prnj8GqN4lJFwhQeDDfTq2ak+ROpEevP3cHjt0LlVAYkqNyUk3S2JLgXJghNjf7mWh3rEw0/gQI
 NLs10kigGMpQqPgpAag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290033



On 1/28/2026 7:56 PM, Bjorn Andersson wrote:
> On Wed, Jan 28, 2026 at 05:10:41PM +0530, Krishna Chaitanya Chundru wrote:
>> Add a common helper, pci_host_common_can_enter_d3cold(), to determine
>> whether a PCI host bridge can safely transition to D3cold.
> Please read https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>
> It clearly says that you're supposed to start your commit message with a
> description of the problem you're solving. In fact, even after reading
> the entire commit message a few times I only know what the patch does,
> but it's not clear to me why this patch exists.
>
>> The helper walks all devices on the bridge's bus and only allows the
>> host bridge to enter D3cold if all PCIe endpoints are already in
>> PCI_D3hot.
> The code below does walk the bus, but it doesn't allow/disallow anything
> as far as I can tell, it queries their type, state, and if they are wake
> capable?
>
>> For devices that may wake the system, it additionally
>> requires that the device supports PME wakeup from D3cold(with WAKE#).
>> Devices without wakeup enabled are not restricted by this check and can
>> be allowed to keep device in D3cold.
>>
> Again, this code doesn't perform any action, it doesn't
> allow/disallow/restrict the devices from doing anything, it merely
> queries a bunch of things across all devices, and the commit message
> fails to capture why this is useful.
This is a helper function used by controller drivers, to know if the 
controller
driver can keep in D3cold state or not. we use endpoint states and their 
wakeup
capability support to determine d3cold can be supported or not. The 
return value
of this function will tell controller drivers to know if we can allow 
D3cold or not.
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/pci-host-common.c | 29 +++++++++++++++++++++++++++++
>>   drivers/pci/controller/pci-host-common.h |  2 ++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
>> index c473e7c03bacad2de07c798768f99652443431e0..225472c5ac82c6c5b44257d68a0fc503ec046ff1 100644
>> --- a/drivers/pci/controller/pci-host-common.c
>> +++ b/drivers/pci/controller/pci-host-common.c
>> @@ -106,5 +106,34 @@ void pci_host_common_remove(struct platform_device *pdev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_host_common_remove);
>>   
>> +static int pci_host_common_check_d3cold(struct pci_dev *pdev, void *userdata)
>> +{
>> +	bool *d3cold_allow = userdata;
>> +
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>> +		return 0;
>> +
>> +	if (pdev->current_state != PCI_D3hot)
>> +		goto exit;
>> +
>> +	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
>> +		goto exit;
>> +
>> +	return 0;
>> +exit:
>> +	*d3cold_allow = false;
>> +	return -EBUSY;
>> +}
>> +
>> +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge)
> Please add kernel-doc for any EXPORT_SYMBOL() functions, so that it's
> clear to the next guy what the API does.
Initially, I had a change in my workspace which has kernel-doc, but 
after seeing this
file I see none of the exported API's had a kernel-doc. Following it I 
dropped the kernel
-doc at last minute. I will add this in v2.

- Krishna Chaitanya.
>
> Regards,
> Bjorn
>
>> +{
>> +	bool d3cold_allow = true;
>> +
>> +	pci_walk_bus(bridge->bus, pci_host_common_check_d3cold, &d3cold_allow);
>> +
>> +	return d3cold_allow;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_host_common_can_enter_d3cold);
>> +
>>   MODULE_DESCRIPTION("Common library for PCI host controller drivers");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
>> index b5075d4bd7eb31fbf1dc946ef1a6afd5afb5b3c6..18a731bca058828340bca84776d0e91da1edbbf7 100644
>> --- a/drivers/pci/controller/pci-host-common.h
>> +++ b/drivers/pci/controller/pci-host-common.h
>> @@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
>>   
>>   struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>>   	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
>> +
>> +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge);
>>   #endif
>>
>> -- 
>> 2.34.1
>>
>>

