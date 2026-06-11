Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A620C00C;
	Thu, 11 Jun 2026 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202142; cv=none; b=g6k0l8n9Fp98XAQ0y6icURUKGGjxCJ0zKP27SsVd0JYqj6lB2IRwLzaLxr9t3+RS8CRuq1N1pbe88ChO3oVCKXupWdMqFBXnIuAhZZagWzP8rzpjzZhuQVMOdFszv/DCLL3ArHUaFXsgB4qQTshEvXnJeIgwHfkShMS2IgGFfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202142; c=relaxed/simple;
	bh=gHkXvJcW0MpBjfxeU5up/TdIelQaUXi91vDSO7IlnRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGXoSsKJoGQWzTlS/XgJz8FASwJsGYAbLOsZmpWfQOt2WiYLYQC2VErSqFgAvOZaOY9sYgJ0aeL/MlZiQ5uTmqRZ+2J2zMwEUpZtJJNn8htzjJwR/BcgHap2bSTopQ/TNwairubJIih0z15MHlrQ6XnTmIhXLiXckXhSdTNDEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMYzOvkD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMYzOvkD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBpTvk4146518;
	Thu, 11 Jun 2026 18:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WOCkPp
	vkJfgO8iHa83T2Vo+PY8doscANaw3MWOsqTVs=; b=qMYzOvkD2pj2430lzCFlm6
	QIfgbrM6QEl7+v78kSIdlD4YMryETbfaht4tbtdQ/yAc8iOuIURWEOGuA6FNvhVl
	PxvwCdAYk7KUcuIfcGoxa/UIEs1ijDmRU3JoGECbK2AAjUKvKTmuJEZzAdJDfW29
	t+DDgR1Ir2Cz2WiGqoDPMhvLi8amu2dsXEbAx0C1R+NrGkOrton/NWQ6EmP8G92h
	JUs5PR0Wmr1qbEwFV1Lnv3G+3iH14X0aXzywk3A0GUTUP2bIFmfaSixwmab8o+5j
	qjIT+IGYppYFfS7ux8dsL9LP3xGMkG3tpQ0Sp416J32vN4mRSudRph035L7hTNjw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c5awm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 18:22:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BIJcdJ019976;
	Thu, 11 Jun 2026 18:22:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09mdh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 18:22:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BIMHHu27984516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 18:22:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 729F75805F;
	Thu, 11 Jun 2026 18:22:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E17558052;
	Thu, 11 Jun 2026 18:22:17 +0000 (GMT)
Received: from [9.61.249.138] (unknown [9.61.249.138])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 18:22:16 +0000 (GMT)
Message-ID: <8f679b6b-7a7b-42fb-806a-edf096f88bc4@linux.ibm.com>
Date: Thu, 11 Jun 2026 11:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
References: <20260610234428.GA433532@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260610234428.GA433532@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MiBTYWx0ZWRfXx5ecl1UMGNjW
 YcvxUYOFGhDiB4SfBz+elz/zhPuGmwI0PpBwqkjkgrTiokOeMHMOnEDJdLr/vaHfQ4D5Kq681PS
 QI+K6zy3G9yBSszNfRkcja1HSiSXfJk=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2afcdb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=daHPmBgdeHGlrMCtzkIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: v0RMbCJcQyXD4v0mEz_xyTSLFv7FRurJ
X-Proofpoint-ORIG-GUID: v0RMbCJcQyXD4v0mEz_xyTSLFv7FRurJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MiBTYWx0ZWRfX4bJh1n99/a3L
 gauGJ1wjdSlCYEsiDhiEY9Qn1flGZ+HMa245gPJpAQ0fu2POlvRblxO6GDk1KtGb3Qn7QOWKqCr
 H4NFq/LkIggg+GGFFdyTK8vOCampSGdsxWdyrFM9CsHlnBaD1geHtP859WDCxadxPzNCl6imWFN
 C/1GJ+uPbWmpsrq5Xo2fokDM/N8+B+RuAMbCL+RXsfmmcBVMCBNl4aX4yfpXxQ+Wbkn/rIwwNJI
 SJEcJvuztdSnSYAWOt+z+hEjVi9QuB0Z+M+q0CRK2fTDzGKQHtsjHvmh616Tx6XoVD+AhJZ3pBf
 UneTSsjXUGlclpkOTEO0ZBsv2chD6cvFXMxRJNBxDT8d6jSp+hP871ijfh3YqgJc+Ibp8LvvW0/
 x5mVMcSoLAcd7g+K/eg0lgEu0C0NxQpJSlD0v8LLuq7XQL1JPPbmkFG0DczmfdKqiNn75ZOTAnS
 A94S+yjmV5dNRj5yBtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110182


On 6/10/2026 4:44 PM, Bjorn Helgaas wrote:
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
>> ...
>>> Is there a reason to call pci_dev_config_accessible() here rather
>>> than in pcie_flr()?
>> The reason we wanted the check in pcie_reset_flr() was so to be able
>> to escalate to bus reset method if we can't do an FLR. I think the
>> check could be moved to pcie_flr(). Is that more preferable?
> I think so.  Doesn't the escalation still work if the check is in
> pcie_flr()?

Yes it would still work. I will move the check to pcie_flr() in the next 
revision.

Thanks

Farhan


