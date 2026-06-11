Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892436CDFC
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781220554; cv=none; b=BzYNrDB5xCuvl1AS5xX4zahu+ciJKUcp7TwucX9h4AjwT9N/nCU2hmLdVCKMMgsOe4W0wsfJ68Jngi1tsgLfe0fNzDf0ouhwqOIV69yVlAkWxgUhvaBJNqeNwoLYIIyjaAUJLVpIhq0E1GlmUdS95yv4cycoKBk+azL94mHQZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781220554; c=relaxed/simple;
	bh=Pm7af7dLqeMPNCSZwLOFmr582pPUG+LONo0RlZhWmuk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OVljm2iwkAW9oz0IfIg+M9dExaC7quLMDCnZ+BVgxlbBLaCzmK4zCTicZ85lzXX9hGC9UVcgr/wXxzXajY4pGcbOcIbC2DA52t2zt+p5WFb8lhHMhrxwBKzS2q8ySv2MviWrcqcGj/mV3khCoEGKvHdGwJ8O8zVwkLUQBGOOuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X7SZ0Pzn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X7SZ0Pzn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBABDU722462;
	Thu, 11 Jun 2026 23:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HvUAM8
	uB+jIourDZyyJ+heUVI3gU1WxmGWRC/FX1fpM=; b=X7SZ0PznZUVRJS4a5EoOa1
	uOa6nVCvXqrnZQqwTqP2jWJxdmhkQfcvYlD1o8beDUGgcW2DIc4s57W6Wac8BLLS
	pyYw2RXyO0PZ2W9TXBa8+ROZki7prbM4JO1zd2R2nFmYGJb5SOo+So/Cl0oHBijA
	NsyWliDvDlPlvjt+sPXq/57EDiPoKA//L4Fu2G6MR8lNgaNKogs1JPs/acEfiFXn
	M+3xPbGZ/MsnpCTsqFWMB0aQlr9IRhBYFcpRZGhqpXVfQDi2fkG60PnxvYui8StK
	oiNGPbni0Fox3XIYk5kXKqEqZKBxUe6KPQPBtvHFef0wHzJRyskwZ4imvdvTLhzQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8debua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 23:29:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BNK8X3005982;
	Thu, 11 Jun 2026 23:29:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09wd2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 23:29:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BNT5s455771460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 23:29:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6085805A;
	Thu, 11 Jun 2026 23:29:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8015758051;
	Thu, 11 Jun 2026 23:29:05 +0000 (GMT)
Received: from [9.61.248.230] (unknown [9.61.248.230])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 23:29:05 +0000 (GMT)
Message-ID: <1edb130d-8db5-4d48-8f26-1ed24dc544c8@linux.ibm.com>
Date: Thu, 11 Jun 2026 16:29:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
        Alex Williamson <alex@shazbot.org>
References: <20260611192217.GA405982@bhelgaas>
Content-Language: en-US
In-Reply-To: <20260611192217.GA405982@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfXzpS6ct/b/CNc
 eUlrIed966Tkh8eR7WUvmPb6Xj8GcQ9MKZyaTwrKrAXOJKRZCL/4ARO67jnoijkwUF7AxBGKk5w
 IzItkTyW8kWaGhCWpWqwZTf21OSp3BA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfXxBayqoU8j6Gv
 Ye9WSFxnPKpnKmreCDqmwTnfil5J3/i7h7ncoS6KEe5JVZ3c4/q+V8Rx5w2SREw9N1du4h2nAeO
 Enm6YzbBqF5siG/2iIZFtO+oHjrVfHvYafCDF3cdUPYFSKUWkKT3f5MVnBZkOzuvATAjtI8sVoS
 uJ33cuA3ZFx4MX320v7DNVwyZyjpfVJXLMKGlNXp/ykyezstFgumSSm1zQU365cL80nOM+vl5b0
 5DVuE8F18rxctZ9bAHLo8vsjAdpNwX+vG6ZhiTpalGzdbRXl0eoMRHRCIPWC9SvyqJT3ZCvlZ1X
 qGkT7fP6GHZ2LOK0p9P7UGCnCGM8oSlaaNljS34xYMjJ0tGcKcp05vTwzxKWe1yBV23owShecBO
 3cpegD1qK7Bg5QVfThOZWn5EzwWUadzO5kHBLVXoS/nJIR97Clhh5mEKj8YhAXr0XjZ4B9XI5Tb
 FkoY6DYbzncblRqf+gA==
X-Proofpoint-ORIG-GUID: ueFsAY4KOXun1-40pakHIVjo4dDwbnxP
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2b44c3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=Lg2p-DhD3Fgrwe0m5VcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ueFsAY4KOXun1-40pakHIVjo4dDwbnxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110232


On 6/11/2026 12:22 PM, Bjorn Helgaas wrote:
> On Wed, Jun 10, 2026 at 02:56:48PM -0700, Farhan Ali wrote:
>> On 6/10/2026 1:02 PM, Bjorn Helgaas wrote:
>>> On Wed, Jun 10, 2026 at 09:51:55AM -0700, Farhan Ali wrote:
>>>> On 6/9/2026 3:33 PM, Bjorn Helgaas wrote:
>>>>> On Wed, Jun 03, 2026 at 06:57:36PM +0000,sashiko-bot@kernel.org wrote:
>>>>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>>>>
>>>>>> Pre-existing issues:
>>>> ...
>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>> @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
>>>>>>>     	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>>>>>>>     		return -ENOTTY;
>>>>>>> +	if (!pci_dev_config_accessible(dev, "FLR"))
>>>>>>> +		return -ENOTTY;
>>>>>>> +
>>>>>> [Severity: High]
>>>>>> This isn't a bug introduced by this patch, but does placing this
>>>>>> check in pcie_reset_flr() leave direct callers of pcie_flr()
>>>>>> exposed to 60-second hangs?
>>>>>>
>>>>>> Direct callers of pcie_flr() (like network and storage drivers
>>>>>> during error recovery) bypass this wrapper. They will still
>>>>>> experience a stall in pci_dev_wait() when attempting to reset a
>>>>>> device with an inaccessible config space. Should this
>>>>>> accessibility check be moved into pcie_flr() instead to protect
>>>>>> all callers?
>>>>> I can't remember why we have both pcie_reset_flr() and pcie_flr(),
>>>>> other than the fact that callers don't need to supply a "probe"
>>>>> argument to pcie_flr().
>>>>>
>>>>> Is there a reason to call pci_dev_config_accessible() here rather
>>>>> than in pcie_flr()?
>>>> The reason we wanted the check in pcie_reset_flr() was so to be able
>>>> to escalate to bus reset method if we can't do an FLR. I think the
>>>> check could be moved to pcie_flr(). Is that more preferable?
>>> What if we added a preliminary patch that folds the body of pcie_flr()
>>> into pcie_reset_flr() and adds:
>>>
>>>     #define pcie_flr(dev)	pcie_reset_flr(dev, PCI_RESET_DO_RESET)
>>>
>>> That would mean pcie_flr() users would start paying attention to
>>> PCI_DEV_FLAGS_NO_FLR_RESET and PCI_EXP_DEVCAP_FLR, which seems like a
>>> good thing.
>> Looking at the history, it seems commit 56f107d7813f ("PCI: Add
>> pcie_reset_flr() with 'probe' argument") added pcie_reset_flr() to
>> add the probe and remove pcie_has_flr(). It also notes that callers
>> of pcie_flr() that didn't call pcie_has_flr() remain. I guess it
>> didn't want to change the drivers that called pcie_flr()
>> unconditionally?
> I think it's a mistake that we expose both pcie_reset_flr() and
> pcie_flr() to drivers.  It's unnecessary complication and may lead to
> pcie_flr() being used to work around device defects, e.g., the 82599
> issue, without any explanation.
>
> Ideally I think we should convert the dozen or so callers of
> pcie_flr() to pcie_reset_flr().  Since they never called
> pcie_has_flr(), they initiate an FLR without checking for FLR support,
> so they *could* have the same defect as 82599, i.e., they don't
> advertise PCI_EXP_DEVCAP_FLR but FLR does actually work.
>
> So converting would be slightly risky but I think the number is small
> enough to be manageable, though it would be out of scope for *this*
> series, of course.
>
>> There is also reset_intel_82599_sfp_virtfn() that mentions the need
>> to FLR without checking for FLR support due to some quirk. So I
>> wonder if there were genuine reasons to avoid doing the check for
>> PCI_DEV_FLAGS_NO_FLR_RESET and PCI_EXP_DEVCAP_FLR?
> Yes.  That device looks defective in that FLR is mandatory for PFs and
> VFs and PCI_EXP_DEVCAP_FLR must be set, but it is not set for 82599
> VFs.
>
> When c763e7b58f71 ("PCI: add Intel 82599 Virtual Function
> specific reset method") added reset_intel_82599_sfp_virtfn(),
> pcie_flr() read PCI_EXP_DEVCAP to check for PCI_EXP_DEVCAP_FLR every
> time it was called.
>
> PCI_EXP_DEVCAP is a read-only register that is now cached in
> dev->devcap by set_pcie_port_type(), and pcie_reset_flr() checks the
> cached value for PCI_EXP_DEVCAP_FLR.
>
> So I think reset_intel_82599_sfp_virtfn() could be reworked to be an
> early quirk that sets PCI_EXP_DEVCAP_FLR in dev->devcap, instead of
> being a device-specific reset method.  Then pcie_reset_flr() should
> just work.

I do agree exposing both pcie_flr() and pcie_reset_flr() is not ideal, 
and having single API with all the checks would be good. I can take a 
stab at it (separate from this series) and look into either folding the 
contents of pcie_flr() to pcie_reset_flr() or converting all pcie_flr() 
caller to pcie_reset_flr(). AFAICT reset_intel_82599_sfp_virtfn() could 
be the only caller that actually needed to avoid the PCI_EXP_DEVCAP_FLR 
check.


FWIW when trying on s390x with the limited set of supported PCI devices, 
I didn't see any issues.

Thanks

Farhan

