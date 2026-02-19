Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C1286891
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522407; cv=none; b=lLtNQCcVGGstsAnFrazzhuhDHEq4dulKe32tNlYLRkE/TluHwb3W8ZAXbNgAp/ImwZ5uc5dQeaOxPNLkTO7rRHe0374x+2RUcbzwyZrBKG+XdIll5hPUJD/LMcWhatBgB9+an8N7QiWKSYI6112TFIaECVzigAi+SCn907LNSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522407; c=relaxed/simple;
	bh=fAI4nM/1m6v+bFelY89s/OJxRCalci/9YE7nMNkonms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJiDm4IAte7KZZgMSAWK3t7Vhqnyy/EZ40uF6saKrpqYAozTwvJZBJDvHM16/+x3NR8EP56kNO1C8BTw3D4QtjJWP3leijRpIs5jgx0ScwbHGGqgjfnNzdLmDlNhR6i6LdCBLh7cPQx6P3AbVSntHQEIXjrZ4zxQ8H39oKqCHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CDvugY/I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CDvugY/I"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J9A3A41295387;
	Thu, 19 Feb 2026 17:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PgQSML
	eDkj5nSmnmR4kutFgBv2sfucUa/iJg0BU1oXc=; b=CDvugY/IpG9Fpc2CoDWoeV
	OrA4sLnJhUr+sGpEvpL5zwl7BDrtoKLjJP75ezoKdsk9i2VlkaJDVog3jqMXVD7e
	IdccgP1tYora2qZGPyJI+Y5p0ZvJsrZAtRpn5bdOEFP46vsF/6XlJCiRt1erR/6m
	yGHRF8/oFXarCdItEeUloRqH5ENALIVEMVgK8O6ECY2Du/jLCmtJxsxmkXyu4HiC
	ZKa0oUWEpxiqYbU+aDcP9v0zjkawzROm7N8/eDxWFVAUeA6tjDhFacD52rwOjHsR
	OH7AArUevVJzSHS16M5vrY7cRcmBSHA1Z90+J6RfTbb2SEn4lnk1d18Z1lj+Nt2g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj64e10c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 17:33:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JDYesx001395;
	Thu, 19 Feb 2026 17:33:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bn4nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 17:33:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61JHX520852524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 17:33:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C1DF58056;
	Thu, 19 Feb 2026 17:33:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6398458052;
	Thu, 19 Feb 2026 17:33:00 +0000 (GMT)
Received: from [9.111.6.127] (unknown [9.111.6.127])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Feb 2026 17:32:59 +0000 (GMT)
Message-ID: <20554bdb-68b4-4ff2-96de-af6c3a434290@linux.ibm.com>
Date: Thu, 19 Feb 2026 23:02:57 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/pci: Initialize msi_addr_mask for OF-created PCI
 devices
To: Vivian Wang <wangruikang@iscas.ac.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org
Cc: tglx@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, gjoyce@ibm.com
References: <20260217174537.1154686-1-nilay@linux.ibm.com>
 <6f02c046-1ff6-4086-8fd0-a276eabece10@iscas.ac.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6f02c046-1ff6-4086-8fd0-a276eabece10@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: g68hyux_Y7EgdCHBX6K4888FqFyiH6X8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE1NSBTYWx0ZWRfXzop2EIr17vje
 qbbY7d1VVSBWxiqAUY03d3j9LO8BeuPlyfrVd+x0eOEOFO7jB9RuZdpJJeU5N+AoBRtsIoeVKWu
 BY0vrEDFjE597t+u3x8te32IU18/j4AOrRGymB57Lbp/hSA+B8OuNdthAyhMB4eb/PMmJ4X9+Eg
 074g3kxg2r7T/0OWDwUa6mhBswf+N4+8QNjh2svjdKCfwCzzDECQpNy8bYyWuuQl+yyDuZc+PCd
 0A6U7eMxjTW7AKmlozCM+iXvV0b7E0OJlojKzzHgMRzh1QAAdpHzgRkpnxkOfcfHxeTMSCxZKnM
 Xw6cTlAb445b9XFgS93Lj0gkuGanK0R2hQn2zs/on6Jvvg4ZIb6kaK/Ll37WnvGh8zHXd05Psq8
 CppNhlt4yPuvUdTllkEuGcoGx6uBwPo9KFbo56MvqEoSIGH052M8O8GcKhpceQ0e5CGSsNTgSvH
 2sdatbOFu5pRZzRu7sQ==
X-Proofpoint-GUID: NMa6vD6-26Rr1YT02QhRe_z9t9mZU6Az
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=69974954 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=3Jw2BVf9RI64lIZzIOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190155



On 2/19/26 12:52 PM, Vivian Wang wrote:
> On 2/18/26 01:45, Nilay Shroff wrote:
> 
>> Recent changes [1] replaced the use of no_64bit_msi with msi_addr_mask.
>> As a result, msi_addr_mask is now expected to be initialized to
>> DMA_BIT_MASK(64) when a pci_dev is set up. However, this initialization
>> was missed on powerpc due to differences in the device initialization
>> path compared to other architectures. Due to this, now pci device probe
>> method fails on powerpc system.
>>
>> On powerpc systems, struct pci_dev instances are created from device
>> tree nodes via of_create_pci_dev(). Because msi_addr_mask was not
>> initialized there, it remained zero. Later, during MSI setup,
>> msi_verify_entries() validates the programmed MSI address against
>> pdev->msi_addr_mask. Since the mask was not set correctly, the
>> validation fails, causing PCI driver probe failures for devices on
>> powerpc systems.
> 
> Thanks for catching this. I had naively assumed that pci_setup_device()
> was the right place for adding this initialization, and didn't think of
> other possibilities.
> 
> I grep'd for pci_alloc_dev() and found these uses:
> 
>   * of_create_pci_dev() in arch/powerpc/kernel/pci_of_scan.c (this patch)
>   * of_create_pci_dev() in arch/sparc/kernel/pci.c (*same missed init*)
>   * drivers/char/agp/{alpha,parisc}-agp.c (fake pci_dev, should be fine)
>   * drivers/scsi/megaraid.c (copying from existing pci_dev, should be fine)
> 
> So, while we're at it, can we fix the SPARC one as well in v2? The code
> seems similar to what we do for powerpc.

Yes I can do that but I don't have access to SPARC machine so I can't validate 
it. However I'd add SPARC maintainers and mailing list for review and so someone
might help.

> 
>> Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
>> of_create_pci_dev() so that MSI address validation succeeds and device
>> probe works as expected.
>>
>> [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/
> 
> Nit: Link seems redundant given the Fixes tag below.
> 
Ack

Thanks,
--Nilay

