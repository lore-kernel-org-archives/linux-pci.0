Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982133986F;
	Wed, 10 Jun 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110326; cv=none; b=AAMVu7ijk39wiw7m+JSf/iHL9R0Bo+G8EFc4jnOcCXGJZPKAjAF3MIvGcjGOUlATQy1Oq2rNcjgdX1s59SAT/a3NZd+uBYNEMykooq0OpoFgWZPBNYYXcsnWzLZUUwSNMZTkxxyJ9BI/ALpBmzlEVvCiuvkAJgODqXqbVEEiyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110326; c=relaxed/simple;
	bh=9g3LnZnhZXVLFc+bSSI8JunJ3AORIelItZfpL0q6hSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OU8j5IA5Ja2++k/bhGmKZEDl5kgj3X/QS2CH66Q7PMxt8fapDnfejM2UGdZ+vwFAX/MpdQTokWhs6cNmT0nwzWUZfYaD0lOjQyvt+RTiqXTPDsNoiN2S4HqeL4QizQz3KW/hEww0VxJJzlVzhejBXt143IT+LvFpapZ0LjUyB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q8rfECLb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q8rfECLb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AF4UXV3420508;
	Wed, 10 Jun 2026 16:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NPXuHq
	vvYLt5zWP6sN8XsQdOsZoUKtQYj9UDQIL396I=; b=Q8rfECLb7ng4FO7a2Ct/U8
	WGGo/WreNPwb0KA7CvdVii0JL+zxnJ6zsVnvKGBr+CqN22wK1YAT45IIGepvRIfd
	ALYtNEobOMpH3guQ1FEFcKI0C5989xkZ/TqtTz6eU+AdcD2AI1EASm26KZJr4u18
	ma86JmtkD3rSrwFtWK1P27E582qjmCsd0LR2aGxFWR2jtlThby4WeliIoCOwNX/t
	J/ijTbHp09iOZyg9Hm+ZESnQGEXmIEop+3DB1xiQapj+GekIKcRwRo23BDw1Ch/f
	EwQW8cGf//DUVirQqJ8YtgmInt4NTWf4fNb6q1SaPNDyhpEx8qbp74bqEtuASGuQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye9s0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:51:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGneIg013516;
	Wed, 10 Jun 2026 16:51:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjygma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:51:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AGptHL34341394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 16:51:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3CDD58054;
	Wed, 10 Jun 2026 16:51:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77CFE5805A;
	Wed, 10 Jun 2026 16:51:55 +0000 (GMT)
Received: from [9.61.251.150] (unknown [9.61.251.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 16:51:55 +0000 (GMT)
Message-ID: <66cb5988-ce72-4acf-8e1c-0eb72b4fbd41@linux.ibm.com>
Date: Wed, 10 Jun 2026 09:51:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260609223351.GA157386@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260609223351.GA157386@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX7B1YizrRt5b+
 Kyb1g0HY5VfQ/AVrrgoEorB7WE1iooQHEXWdz6qvdtgbJ/XDyw05OdBCmkOKPH7DNb8J2y3U3/n
 SylaBXPAhDMmLkGszahrB+e908ulzBflFo8z9ErsyZa/a1VYBr8O5W1EJVzEGuO6MI7JJaha6Nz
 7Wu0Z0/xn+4cl8PFf7WprgfcS6E0DxHYuAq406nXKDRToZnmFwwXNj/KgFLY/V1Hx7NcZbefaMH
 hbjVIwe3BQMp/V3c37qgjG+UAXdsvjLpU5tmUuEkKbRAOP5TIFdv/Q9I9uJpm+ZlQ5sNbwvgtDn
 Pd18ZqyKsifJarteF8kxoBXb5SCpBsDnhm/syrImGyiohZm7sJXjiilLwkd0k/AcHBkwzrx25pj
 UE2c+f9GIapSzvYBNsY01EkOm9nKeYH2CvmlSkQMV21/KFJudk/LLbR8rgUkdXp99IaZiB/AqqR
 SxlWV9iwRpE8xcStbyw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a29962c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=U98x94yJvRYjzxI7CFwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DNNNCkJXf0NT4DOD7sBkiB5bI8nsPi5B
X-Proofpoint-ORIG-GUID: DNNNCkJXf0NT4DOD7sBkiB5bI8nsPi5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156


On 6/9/2026 3:33 PM, Bjorn Helgaas wrote:
> On Wed, Jun 03, 2026 at 06:57:36PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] The config space accessibility check is placed in pcie_reset_flr() instead of pcie_flr(), leaving direct callers of pcie_flr() exposed to 60-second hangs.
>> ...
> I don't know why sashiko calls this a "pre-existing" issue.  This
> patch *adds* the config space accessibility check, so it looks like an
> issue with this patch to me.

The way I interpreted it was, this issue in pcie_flr() of 60 second hang 
would hit with or without this patch if config space in inaccessible.


>>> +++ b/drivers/pci/pci.c
>>> @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
>>>   	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>>>   		return -ENOTTY;
>>>   
>>> +	if (!pci_dev_config_accessible(dev, "FLR"))
>>> +		return -ENOTTY;
>>> +
>> [Severity: High]
>> This isn't a bug introduced by this patch, but does placing this check in
>> pcie_reset_flr() leave direct callers of pcie_flr() exposed to 60-second
>> hangs?
>>
>> Direct callers of pcie_flr() (like network and storage drivers during error
>> recovery) bypass this wrapper. They will still experience a stall in
>> pci_dev_wait() when attempting to reset a device with an inaccessible config
>> space. Should this accessibility check be moved into pcie_flr() instead to
>> protect all callers?
> I can't remember why we have both pcie_reset_flr() and pcie_flr(),
> other than the fact that callers don't need to supply a "probe"
> argument to pcie_flr().
>
> Is there a reason to call pci_dev_config_accessible() here rather than
> in pcie_flr()?

The reason we wanted the check in pcie_reset_flr() was so to be able to 
escalate to bus reset method if we can't do an FLR. I think the check 
could be moved to pcie_flr(). Is that more preferable?

Thanks

Farhan

