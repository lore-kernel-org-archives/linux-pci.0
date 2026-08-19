Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1F476CE1;
	Wed, 19 Aug 2026 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152150; cv=none; b=u8TlOM6tsMSq10tmrGt7k7mC1GikyNFC6RxD7U6oxM987C5lnmy+yvXmMh81vkb1Tu3slzHFm9oyZ6D4oA5ZCtXzaiSCcfe3a3aJJkgRCKcU37PEe5VP7h72VbnoVFPDVZgv5b/55i5V3VhyTMax0PrasJ/x47DmZQ7jht4k7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152150; c=relaxed/simple;
	bh=lalFD5+POchhha3WSUXofQmK2QXuXQGw0zKdep9m4+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6ilIQgvKpAtdbAS8UUmjSJ9l1jTmEavwlP3lsztr+h9CHxJvIPE1T++Pw9cHM+pQBLFXrWjanjx3JyPirfMIf1jIr21FsdtLO7wUhMyp/VpEwyLo86EGGsmWttEzNJpK0UtyBrgwXGHweWY8kIShURiYRFMJcndcxq/IOImZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrqdMjJ8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrqdMjJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787152147; x=1818688147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lalFD5+POchhha3WSUXofQmK2QXuXQGw0zKdep9m4+U=;
  b=HrqdMjJ8tyop6g7Liy5oAPOnr8hAY929a1MY4GH6YmQ9cymOSDqCEH/b
   PxkTHM1ATSWaZKdNvMREIGvmCuqSzFvxCd7tqGqilGCLi0MJ7ukZ7OMBC
   s1ttxeRmo5M03Hr9ps+lk4tOCpj9zBcPhgRWEeTRQE48Se18g6iz5Rzf/
   Zy0QO2MpN/hBR8LD9zbnZUYE7x0+qFzGJ7xB6Q5pjtclZWrJ0CPZ4+jFJ
   3CglD+HqIzTQ0OIBFNoFZhbKSuZxxdP5HbWQtjBZ92CS0DvQsMiSsbK41
   FPobA9DZoVwCRTqYN+EZ00uA3Zork2zZq8N0hBz7zBCmjNlwGh6xCShmq
   A==;
X-CSE-ConnectionGUID: vkKMI91fTLiMHzLz9TMhNg==
X-CSE-MsgGUID: LYijS0LnRWG5ubv0TH53zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105205342"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105205342"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:09:05 -0700
X-CSE-ConnectionGUID: rcEbby03RDaj6gpO6Hq1YA==
X-CSE-MsgGUID: aQM9aroEQj2b6KbKdk/i9g==
X-ExtLoop1: 1
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:09:02 -0700
Message-ID: <7a8f49cf-2254-47c5-a4d2-c4f9387358db@intel.com>
Date: Wed, 19 Aug 2026 08:09:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP
To: engguopeng@buaa.edu.cn
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, djbw@kernel.org, johnny.li@montage-tech.com,
 peng.guo@montage-tech.com, jingzhong.yang@montage-tech.com
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
 <20260817075854.17207-3-engguopeng@buaa.edu.cn>
 <c01709c9-4c3b-4ced-9635-72947807c301@intel.com>
 <56e8d5aa.4be5.1a017a28956.Coremail.engguopeng@buaa.edu.cn>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <56e8d5aa.4be5.1a017a28956.Coremail.engguopeng@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/26 6:28 PM, engguopeng@buaa.edu.cn wrote:
> 
>> On 8/17/26 12:58 AM, penn wrote:
>>> From: Penn <engguopeng@buaa.edu.cn>
>>>
>>> When MMPT is enabled, a CXL device may expose CXL-defined capabilities
>>> and PCIe Management Message Passthrough (MMPT) capabilities in the same
>>> MMIO Capabilities Register Block (MCAP).
>>>
>>> The CXL capability parser currently identifies entries using only the
>>> capability ID. Since capability IDs are scoped by Vendor ID, a
>>> PCI-SIG-defined capability may have the same ID as a CXL-defined
>>> capability. This causes non-CXL entries, including MMPT and MMIO Mailbox,
>>> to be interpreted as CXL register blocks.
>>>
>>> The MMPT register block may be interpreted as a CXL mailbox. This
>>> causes mailbox initialization to fail with:
>>>
>>>     cxl_pci 0000:3b:00.0: Mailbox is too small (64b)
>>>
>>> Check the MCAP Vendor ID before interpreting an entry as a CXL-defined
>>> capability. Skip capabilities with a non-zero Vendor ID other than
>>> PCI_VENDOR_ID_CXL.
>>>
>>> In legacy CXL capability headers, the field now used for the MCAP
>>> Vendor ID was reserved and reads as zero. Continue to accept zero to
>>> preserve compatibility with those devices.
>>>
>>> The fix has been tested on CXL 1.1 and CXL 3.0 devices. On the
>>> MMPT-enabled device, it prevents both Mailbox and Status capabilities
>>> from being misidentified.
>>>
>>> Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
>>> Suggested-by: Johnny <johnny.li@montage-tech.com>
>>> Signed-off-by: Penn <engguopeng@buaa.edu.cn>
>>
>> After addressing Lukas's comment,
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> Given that you are utilizing the new PCIe MMIO MBOX feature, have you considered migrate the CXL MBOX block parsing code to a PCI lib and shared between PCI and CXL? I did attempted something [1] like that a while back but never upstreamed the code due to no hardware to test on.
>>  
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=pci-mbox
>>
>> DJ
> 
> Thanks for the review. Lukas's comment has already been addressed in v2,
> but I missed his Reviewed-by tag. When applying, please also include:
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> I will add it if another revision is needed.
> 
> In addition, I will look into moving the CXL mailbox block parsing code to a common
> PCI library so that it can be shared with the PCIe MMIO mailbox support.
> 
> Since that would be a broader refactoring, I would prefer to keep this
> patch focused on fixing the Vendor ID validation issue and handle the
> common parsing code in a separate follow-up patch or series. I will also
> test the follow-up changes on real CXL hardware with MMPT support.

Sounds reasonable. Do you have MMPT support submitted to upstream for the PCI subsystem yet? I'm curious because there are certainly security concerns of an opaque pipe from device that the kernel has no visibility to. There will certainly be security pushback on the enabling from the kernel community without some protocol in place to ensure the data being tunneled will not result in malicious actions.

DJ 

> 
>>> ---
>>> Changes in v2:
>>> - Accept a zero Vendor ID for compatibility with legacy CXL capability
>>>   headers.
>>> - Move the u16 declaration above the u32 declaration to follow the
>>>   reverse Christmas tree convention.
>>> - Document testing on CXL 1.1 and CXL 3.0 devices.
>>>
>>>  drivers/cxl/core/regs.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>> index 93710cf4f0a6..c7c14089f2c6 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -133,8 +133,18 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>  
>>>  	for (cap = 1; cap <= cap_count; cap++) {
>>>  		struct cxl_reg_map *rmap;
>>> +		u16 cap_id, vendor_id;
>>>  		u32 offset, length;
>>> -		u16 cap_id;
>>> +
>>> +		vendor_id = FIELD_GET(PCI_MCAP_HDR_VENDOR_ID,
>>> +				      readl(base + PCI_MCAP_HDR_BASE(cap) +
>>> +					    PCI_MCAP_HDR_REG_4));
>>> +		/*
>>> +		 * The Vendor ID field is reserved and reads as zero in legacy
>>> +		 * CXL capability headers. See CXL r3.2, Table 8-44.
>>> +		 */
>>> +		if (vendor_id && vendor_id != PCI_VENDOR_ID_CXL)
>>> +			continue;
>>>  
>>>  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
>>>  				   readl(base + cap * 0x10));

