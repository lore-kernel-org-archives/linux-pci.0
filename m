Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7337CD2E
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962825; cv=none; b=bSXG/RSb/T0gs1DYf4mWmZIAfjH+l+PtL/bkF+HBNKsnWxBOOxZ+hdavSx8vsa8Ve1YvGCKE938dIpPfK80/scuRUEuj0CQdskbQ/Bn+/9FlnyDCIHP1PA4dwtEFmcBZ2xUN5eydvu38rzmBFJYDNgiSgr0Q1wt7aDMSdVx/oAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962825; c=relaxed/simple;
	bh=h+lptLSrwl6lS/910QxA/O1c+TuP9Gbsrz1YCOfUQf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOZuzfzpG4xIl77oUanwHfOrSV66SN6sUnYeKQBca5eCRlRBwDHeOjse8kOtklRFdvULlfdCvlh2djuGlQbybnvV7Oue4Axp8lxcylHDFYuqXPXADGGTfdHb1lOrxmGffy8+aU3jsYvhk3RIgk3RL2kobHMdCZEtAyNAuvIcz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ibVHogOP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ibVHogOP"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MJk0Zi4173756
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 09:47:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oVfOeV72AOJgq9KjWrZRAnrxVldfcZIMHauJXVMpJ7k=; b=ibVHogOPtzkR
	LCyiRdlxlYrnV8iqNCbo1hZCrnPS43Id8IO49FUT2Y9Pps3Ht3aesu1pzVaMkhSC
	FcwKOcymJk754TVvCkV39zogrdzIViG/UgSKtGLN9SyDMVhTGgwVW121LwXUEYKl
	9dx4/SneEpdMsxmSZEb/cwnk5FYfQj1N9KP10nR8ph3Xwc2NlWQxoHK3iGExkPKH
	QRkTbRQaB25omw+8ZYnU5qQJ3yWGYCKr3TAj6IDN13Qbg3wBMEt+UEVkLzCyD6RW
	rQ9T7iCZsmBYO4vZbrs31ynaMbheuqlgKaIzdc2JtTobsTtIftw88mxc9f30M6ZB
	NUGWSyZwag==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepadv1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 09:47:03 -0700 (PDT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bda35eab74so6179927eec.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 09:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962822; x=1777567622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVfOeV72AOJgq9KjWrZRAnrxVldfcZIMHauJXVMpJ7k=;
        b=QZiQG18+RBI3A22/SAcZzpuUD8L4TFOO5k4zPEGCjMiQOtxL3/OCEyEbFJYSeeGsUn
         OVhvZr3ZA85tfYKtaqlxUWf42sU1ASLjbABU59u2litUiOqpQcVcj2iTJ/c0C3Y0SOYK
         TCuDdABI87moRYQUd1SB83IImu8x80OXZdgvshJSXniPrFzx8PDLDchbNdGM9SQRBhW+
         aUUuFOVM4oBG0LS7NS+i4j2Ze41nGremwsnTVRtQQxDufMng65Z1R1/SnCoHY0tReSjK
         /lcLJLO65LQ7KWMHyqdhGhm7JwUJzNj+/oCShY3/06r4qLPlE7KgwfVnKFqENeCV6wxq
         ANnA==
X-Forwarded-Encrypted: i=1; AFNElJ8CugFewVMEIsTqSAfeFFgjukx+qF5GyxcpRZi65qfSzavIG6hea0J6lyBB2JDjwDLVZ/FPk8byj8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn76CIouto0TvH8hpVCMiLJjBXPBGx7EDX5KBwHvccXCJJhEP6
	YD2UOFhqXwdeOUVAPLH7VSfutM8mdKBMV3lgbs8T/Z5ihndtxAVOYzozh1VZTMUMuwGhTujhQi3
	ks7we9h7Kg3A2Md5fTxv4YygN1ALfW0UFDvN9rFWHhrnA87OshoW+xhx7TedCpLP7UgJ1
X-Gm-Gg: AeBDieuXQ7JDQkVwAwhH2qd7YuEehxaoNTpcRzBGsPaB221I1hz1CXUePPqyoaI302b
	BxXBXj4K5ZXNSodYztyvHy+b5TPniCuAVqHEIJuDO5fflHzQxs3HJt6pdXZqYUuzrxzn684xSEh
	8fezja9Cs0Qtv379xUGp4I+ytZAuoJC8B/8XToZAl+1txvoYJVRe8WSFPnTAi0T2U8vYenkxsD2
	8X5mfarNe0YqbTWsExFIdmaeymbrWBA4e462XMZgQvDYq5F+VwW3YfnKcQcPd1SD7NPSntd151m
	Q8sPjuCxWp3XoAXriAXqdQrnXmsNdty7vGLRTEqKZCg4EYBDmUqhwrFUC0pGx+muOHzn0sURO0c
	F6JuJD4ZnhlKT/IDv8P00MAvtjFpTm6/HVqRdwXJm
X-Received: by 2002:a05:7300:3253:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2e42dc0732emr9944356eec.11.1776962822109;
        Thu, 23 Apr 2026 09:47:02 -0700 (PDT)
X-Received: by 2002:a05:7300:3253:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2e42dc0732emr9944340eec.11.1776962821442;
        Thu, 23 Apr 2026 09:47:01 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfc1dsm27499552eec.22.2026.04.23.09.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 09:47:01 -0700 (PDT)
Message-ID: <34d884a3-ae25-49b2-9063-8783ff50e095@meta.com>
Date: Thu, 23 Apr 2026 17:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe
 <logang@deltatee.com>,
        Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260421174351.3897842-1-mattev@meta.com>
 <20260422090146.6faf00f8@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260422090146.6faf00f8@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Xwj4NvJgEy_mZ0RM7F6DbAwFpv0naiOA
X-Authority-Analysis: v=2.4 cv=KMxqylFo c=1 sm=1 tr=0 ts=69ea4d07 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=CK8SrSYdo2KBgkCwzU4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE2NyBTYWx0ZWRfX2p97VrbD7TLR
 4C2sAd2T3omrD08cxsUISYWtsd+CzkZvRoIctJF282cTqjpjyrxUcH3prutd4UVH1s5NJtIxVD+
 wgu6L/p/RDRwxw3saG09xlFXlZMq40a0ucV2rTSdS+SiYZX7ZMAT6VBsS9IRWPgnHN5bOQ6dfmU
 LBDgRriepsY1TD27wSkoo6LncPKkBBHy1FxwmEyxUMV+oetcUozVV4LQo4n+3FaK79xWikbdSKC
 Y9QzZQs5YtTDeVOhHkQIQbI8V2u2ClZ0gP/meAWWP16PL2LHQfBE8vgMvApqc3decxXzWGRzNWA
 d6z2mHiI/LRO08aspfv2YQKbgjJsDtbhkOhHz41xyTcxaZsVFkwFFloiMwv5Jbvsd27eefBevBQ
 cpQ8kycSBBWPDA1ElyqD6cS2glM0H2X4VUdAie4k80RBHtFj39VrV2e0HTCIaA7IXo86kcWTxZ8
 CSZp9eLCyNWMLYDKu6A==
X-Proofpoint-GUID: Xwj4NvJgEy_mZ0RM7F6DbAwFpv0naiOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Hi Alex,

On 22/04/2026 16:01, Alex Williamson wrote:
> 
> On Tue, 21 Apr 2026 10:43:51 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Extend pcim_p2pdma_provider()'s checks to exclude functions that have
>> pdev->non_mappable_bars set.
>>
>> Consumers such as VFIO were previously able to map these for access by
>> the CPU or P2P.  Update the comment on non_mappable_bars to show it
>> refers to any access, not just userspace CPU access.
>>
>> Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>
>> This arises from Alex Williamson's suggestion to test
>> non_mappable_bars when getting the provider, with discussion here:
>>
>>   https://lore.kernel.org/kvm/20260415181623.1021090-1-mattev@meta.com/
>>
>> The goal was to prevent a hole where VFIO could export DMABUFs for
>> BARs marked non-mappable, and to fix for all users of the provider
>> rather than just VFIO.  Alex observed that non_mappable_bars should be
>> taken to mean BARs weren't usable by the CPU _or_ peers and,
>> considering that, its comment about userspace access wasn't quite
>> right.
>>
>>
>>   drivers/pci/p2pdma.c | 3 ++-
>>   include/linux/pci.h  | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 7c898542af8d..4a783413f466 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -318,7 +318,8 @@ struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
>>   {
>>   	struct pci_p2pdma *p2p;
>>   
>> -	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
>> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
>> +	    pdev->non_mappable_bars)
>>   		return NULL;
>>   
>>   	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 2c4454583c11..1e6802017d6b 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -508,7 +508,7 @@ struct pci_dev {
>>   	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
>>   	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
>>   	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
>> -	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
>> +	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
>>   	pci_dev_flags_t dev_flags;
>>   	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>>   
> 
> Should pcim_p2pdma_init() separately test pdev->non_mappable_bars
> before the rcu-deref/kzalloc of the pci_p2pdma object and return
> -EOPNOTSUPP?
> 
> That then invokes the same error paths we'd see if we simply don't have
> p2pdma in the kernel and handles the pci_p2pdma_add_resource() path
> automatically as well.
> 
> This pcim_p2pdma_provider() test is really then just suppressing the
> WARN_ON that we'd otherwise see by not finding the p2p object on the
> device.  Thanks,

That makes sense, yes, it'll avoid the WARN that'd otherwise occur in 
pci_p2pdma_add_resource().

I'll do a v2 adding this check to pcim_p2pdma_init() as well.  Hopefully 
Logan & Niklas's R-B will still apply.


Thanks,


Matt
