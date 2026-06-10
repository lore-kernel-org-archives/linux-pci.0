Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E2346A10
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128617; cv=none; b=l+Yxs7y8qn/supZ44260OnigZ4DMBqoGbFM5U9i96d80sOSokJXbUl6F4bqrhEssTS2cDuu0j5SBGJ9P6Lc9Fw+J69WTt5VMvvRcKYhK64GvrjZkimJms70j/FD2qByPWNBWCABfVA+X5SGk5+dtJeftKMQiG7ID6RBsFhDaaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128617; c=relaxed/simple;
	bh=7C0NhotO/ct92vsmQM84HeVr0jWz7wq5ePgEtOqQBso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1FJ/HpvRrPwtVAa5uNq7abKjcS2yyxHoug2CrwksQKHjZRNsgScAvkywpXl7LbBDcylhLQQN3J56IT9bYxHZsGaoy3QxZ5/0muiRr+eUqUl9l1QrzEJqFfi/iqB5CpLWeNd+COgkleP13T0e67nd6ckWQqUcND9F0esMxghirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k/Lr07SU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k/Lr07SU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu6834146619;
	Wed, 10 Jun 2026 21:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qB6cAt
	h/KRZuXG3KU4XmHSoiE44CuZfxcJe9UF9jpN8=; b=k/Lr07SUPHEvvQAZZsCOpJ
	7CkhApHXwwPKXTOpGz9du+CROo723WR7LFJD0zngsFLb4vircHym6pNnl9hNirM4
	FDX+PauyQIRTUiDoHPoJWYoA2A5kmjfgn02M29vAvfbHocBEoufxcXoafPjb4erT
	loFoptsLF/eaiL/OOkj0RQ7uIBHg3EKCPBucSbq9xDc4TGSx7u0tlNKapGAV2R/K
	nsMAviDNkrDNCPwbgD+QzEox/IKpjeNxxeQEFKBEz+fDQdHxQhKntJxwVZ6aKJrJ
	5gUKvzAVWLTpwHSjhg3gHrZ6Lkf2zVfCHtKnHlZXgKtf23xzC5BMuelf7Xb2TDpg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c0e3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 21:56:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ALnfn7009800;
	Wed, 10 Jun 2026 21:56:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09ggvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 21:56:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ALumRD10420980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 21:56:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C23A258058;
	Wed, 10 Jun 2026 21:56:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 639F058057;
	Wed, 10 Jun 2026 21:56:48 +0000 (GMT)
Received: from [9.61.241.23] (unknown [9.61.241.23])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 21:56:48 +0000 (GMT)
Message-ID: <49059c51-e61b-48b2-81a9-2e164e0bd763@linux.ibm.com>
Date: Wed, 10 Jun 2026 14:56:48 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
        Alex Williamson <alex@shazbot.org>
References: <20260610200249.GA388221@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260610200249.GA388221@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwOCBTYWx0ZWRfX77q6sYhY06Wt
 Kf+JbuXPUxhA+Etoq+AzOTpDfSuLOBqmmRJBx1mwJI5wbfXCpBKbCg5hjB2KWfhAxH1dWnulJsh
 20xG2t+cUzP9Kpr2FteeZhS4RB0EBF4=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a29dda2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=whdsKiS9fNiBw4FZXBUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: X3WdM7nHMXNKvfmwHjUYVjMgl7kTSNhG
X-Proofpoint-ORIG-GUID: X3WdM7nHMXNKvfmwHjUYVjMgl7kTSNhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwOCBTYWx0ZWRfXzmObRcbR7Pbb
 agISDvbpupAHoSABHzx0VgAVGpdRdXf0vwBBShDJEKdAydlceRPGEV+1F7x7G7bjLV1nC+OSW4t
 Kq+/55iGio+lCYY1nXMdkSTHpjbxOjhf2obRWlhd/NfQtwcYCuDTfZmFM1IjfoqYBOIO+huh7AE
 nM35JPmHbaq63sdcNIcu5sfhvyOwxiIlbKxXlcJkeX8xSVH3lPgadNQFHXg0Pb/rZaw1ZfOClU0
 lSYezBi66xAeWKZGwKGzHztbAVwyhQqCo/CDDlFM1zbiANJt5DcXChSL4rUqoQdU/matLg2Bg6o
 /8lixU3uUcueD3TFYpVX3zs20gizgW6G/q4v5h14T0tBGMqIppEEenOS0p0CYMWLnuIzrkMUW21
 CHTEg6iagpgKbWp3XCXHEqjuADyFaIP9jCLabmanErfDdhcHBjc5b53C7zi+uYYWsXvBKEck9XY
 HfLq7vCmUua1KHVx30g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100208


On 6/10/2026 1:02 PM, Bjorn Helgaas wrote:
> [+cc Alex]
>
> On Wed, Jun 10, 2026 at 09:51:55AM -0700, Farhan Ali wrote:
>> On 6/9/2026 3:33 PM, Bjorn Helgaas wrote:
>>> On Wed, Jun 03, 2026 at 06:57:36PM +0000, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>>
>>>> Pre-existing issues:
>> ...
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
>>>>>    	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>>>>>    		return -ENOTTY;
>>>>> +	if (!pci_dev_config_accessible(dev, "FLR"))
>>>>> +		return -ENOTTY;
>>>>> +
>>>> [Severity: High]
>>>> This isn't a bug introduced by this patch, but does placing this
>>>> check in pcie_reset_flr() leave direct callers of pcie_flr()
>>>> exposed to 60-second hangs?
>>>>
>>>> Direct callers of pcie_flr() (like network and storage drivers
>>>> during error recovery) bypass this wrapper. They will still
>>>> experience a stall in pci_dev_wait() when attempting to reset a
>>>> device with an inaccessible config space. Should this
>>>> accessibility check be moved into pcie_flr() instead to protect
>>>> all callers?
>>> I can't remember why we have both pcie_reset_flr() and pcie_flr(),
>>> other than the fact that callers don't need to supply a "probe"
>>> argument to pcie_flr().
>>>
>>> Is there a reason to call pci_dev_config_accessible() here rather
>>> than in pcie_flr()?
>> The reason we wanted the check in pcie_reset_flr() was so to be able
>> to escalate to bus reset method if we can't do an FLR. I think the
>> check could be moved to pcie_flr(). Is that more preferable?
> What if we added a preliminary patch that folds the body of pcie_flr()
> into pcie_reset_flr() and adds:
>
>    #define pcie_flr(dev)	pcie_reset_flr(dev, PCI_RESET_DO_RESET)
>
> That would mean pcie_flr() users would start paying attention to
> PCI_DEV_FLAGS_NO_FLR_RESET and PCI_EXP_DEVCAP_FLR, which seems like a
> good thing.

Looking at the history, it seems commit 56f107d7813f ("PCI: Add 
pcie_reset_flr() with 'probe' argument") added pcie_reset_flr() to add 
the probe and remove pcie_has_flr(). It also notes that callers of 
pcie_flr() that didn't call pcie_has_flr() remain. I guess it didn't 
want to change the drivers that called pcie_flr() unconditionally?

There is also reset_intel_82599_sfp_virtfn() that mentions the need to 
FLR without checking for FLR support due to some quirk. So I wonder if 
there were genuine reasons to avoid doing the check for 
PCI_DEV_FLAGS_NO_FLR_RESET and PCI_EXP_DEVCAP_FLR?

Thanks

Farhan

