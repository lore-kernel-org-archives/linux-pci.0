Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0503A7839;
	Thu,  2 Jul 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010657; cv=none; b=pB4vth+BusfRJRyHssijBdoKq0Kkz5HcytHVp81IUXn53YZ7t6imlVNqCDU1zrSR0Gs6MxzE1Twjk1BKt/PTgilZUCFVXuCXoBUM8TaEnlwm4+J6VVcH7lroUkppM2ZvSp08kkpO7DI6BWgFsoQNhp/GXmWkB+A7hoGO9XqPunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010657; c=relaxed/simple;
	bh=J6BoEH5OjHCRK21EB1+bpbUaRLMPjF1qvP9PFjp1GWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMkjA0TZD1WxXzaV6UYdTViqjwqsXVIPmEUvhXwGwK2ntSeuNzuipZMBAMtSgh9s2WH9LNpBsN5r1dXg2NzghiNmxlM7xjhvScvc9gXfTq6gUMme/oEKSphGnp7xD8X6nQZMhcYcJVMM1WB0Rh6P8BtBK1iQU0x/nP9a2IdEs1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=qYEuzK/e; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="qYEuzK/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1783010652;
	bh=eGUo3lKj9bHSKMlrSjRH6DndGp0mwWi4QjeXdG/Uin0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qYEuzK/e9F3skixymjcn8QObes7pQqlCsZmrjKXlScEPaSshFcVeNe8bgyvNaj+le
	 U4RMx12vyf51NkIEuJ8s2Bu0s35PnvlQQtcbTouk0k4G/XeJbnzabM1wMUGS0ZVwGE
	 AW91C7dt35rbBuSWjCTE3V2Rv/CDpu7mLRJLqsuriuEv1G49zTFPlwQY5qbZ2Vn1V0
	 0DqnDc+OvSyymQLyhDIXIM/nVn5//PU8DxS2CmXNsaBZs1gP07YjbYL5HVZ6x6R6Xw
	 W/+IvghDBQLfeljyKzjzEPsuz3NadCWoSSOMhLyo3kkep/i0KryYXAPqKatX9MYurl
	 b4kTQZp6hPKlg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4grjQD0WXwz58f2;
	Fri, 03 Jul 2026 02:44:03 +1000 (AEST)
Message-ID: <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
Date: Thu, 2 Jul 2026 17:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson
 <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260701171245.90111-1-matt@ozlabs.org>
 <20260701171245.90111-3-matt@ozlabs.org>
 <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Logan,

On 02/07/2026 16:45, Logan Gunthorpe wrote:
> 
> 
> On 2026-07-01 11:12 a.m., Matt Evans wrote:>
>>  PCI POWER CONTROL
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 33c88432b728..59d70bc84cc9 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -206,11 +206,7 @@ config PCIE_TPH
>>  config PCI_P2PDMA
>>  	bool "PCI peer-to-peer transfer support"
>>  	depends on ZONE_DEVICE
>> -	#
>> -	# The need for the scatterlist DMA bus address flag means PCI P2PDMA
>> -	# requires 64bit
>> -	#
>> -	depends on 64BIT
>> +	select PCI_P2PDMA_CORE
> 
> Can we remove this dependency on 64BIT? Althogh it looks like
> af2880ec440 complicated the issue a bit.
> 
> If I remember correctly, the original reason for this is because on
> 64bit systems dma_flags fit into unusued space in struct scatterlist and
> on 32bit systems this space didn't exist and thus adding the flag
> required increasing the size of the structure which wasn't desirable at
> the time.
> 
> But af2880ec440 introduced CONFIG_NEED_SG_DMA_FLAGS which doesn't depend
> on 64bit which means if CONFIG_IOMMU_DMA and CONFIG_SWIOTLB are now set
> on 32bit systems that structure will grow quite a bit.

There was some discussion on this aspect of af2880ec440 in the 
corresponding v3 patch, for example:

https://lore.kernel.org/all/feaefa41-9f67-4d4f-a3e0-282dca41f3eb@ozlabs.org/

It seems CONFIG_NEED_SG_DMA_FLAGS doesn't have a hard/functional 
dependency on 64BIT (and it can be enabled on some !64BIT configs 
already, despite what the stale comments say).

> So maybe at this point it's fine to enable this on 32bit systems and we
> can remove this requirement. However, I think we should do that
> explicitly in its own patch, not hide it in this refactoring patch.

Your question does prove it's too stealthy as-is. :)  PCI_P2PDMA still
can't be enabled on 32-bit systems because of its ZONE_DEVICE -> 
MEMORY_HOTPLUG -> 64BIT dependency.  So we're not enabling 32-bit 
support for PCI_P2PDMA here, but it's not obvious and so I'll re-add the 
`depends on 64BIT`.  At least then it won't be enabled without intention 
if someone enables ZONE_DEVICE on 32-bit systems...


Thanks,


Matt


