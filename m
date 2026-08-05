Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A43E5A07;
	Wed,  5 Aug 2026 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963078; cv=none; b=bV1hqRHs/lEKsgKrK1iiNPb1dspxh+feG86OP29lFjBiDmqxfOtgV3GAB9Fqp/DDwW8yVPVqG7WWeeo7gwNCWTk5Jc+VNQkMGe+KTs4n3awTgg24S+5KVtbj8lyID+czIWeKNCn5n1NYXmU2MJowJbAW1WzgbkQiC1u0mdh4m/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963078; c=relaxed/simple;
	bh=bPmAYb2IYLi84WYUPCIzt+1z6+/oIytSRI3tys1S4vM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=H8L9ALD4lFdidLtYAcx/xuWFB4hTFZOZJNdA9sqVkZ++TBuIuXmJnHEJdfVwHygn1TTWKtW0dgMeBCRJLZHUf0X5hGRVip5i/PjvJflK++VFx0zRofiOKv0E4bskcFSs4AclMxBVbPzLYPrTOyrzDrNzm6UXi1KRdFcOpel1l5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=B2nleLYT; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="B2nleLYT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=OVQs2iStLJLV1LuL3mHer5/8sWldCiZ2pfWHe8RSHTo=; b=B2nleLYTl/PeneSE7dR8lXX1mg
	nJApBwd7MAx4rT/cNskor7qwZndKWsVN2eDBy1cQaMwtn3tSTgRdlYzDnTlWxPfAGKWnljYxE/EkD
	uLXP/lP2gMFqcyUReTBIRs1tWAnjebu5tvEZYYA/IjrFOVkh1yDNzUScJThwCgZSDbhP6j9fKevmY
	PKADoN2CSxH8xFGS4WKBf/yCrAOHwuK6CixSyksjqaHQvTk/ZBJ8zXZU0vPaIJJq1FMu9NIVW/crK
	kyC58ekoblBVP9syZJFG6hH8ZIML5CSBhgMBeJMxGrQVo372RUjSV2wJ7lGmz17pwUiYIs3K8iMQp
	qJK5vUAw==;
Received: from d172-219-145-25.abhsia.telus.net ([172.219.145.25] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wriZp-00000000pZu-2PYL;
	Wed, 05 Aug 2026 14:51:02 -0600
Message-ID: <72c83c2e-fcbb-4925-ba50-5be01af359ad@deltatee.com>
Date: Wed, 5 Aug 2026 14:50:46 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
 <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
 <b30e75d8-37d6-478d-bc72-a9ed0b7e200c@deltatee.com>
 <20260805003914.GK27883@nvidia.com>
 <554c73c8-bc17-4336-8e38-f4cfe8d8b3fe@ozlabs.org>
 <20260805164052.GQ27883@nvidia.com>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260805164052.GQ27883@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.25
X-SA-Exim-Rcpt-To: jgg@nvidia.com, matt@ozlabs.org, leon@kernel.org, alex@shazbot.org, amastro@fb.com, bhelgaas@google.com, kevin.tian@intel.com, praan@google.com, mngyadam@amazon.de, dmatlack@google.com, bjorn@kernel.org, sumit.semwal@linaro.org, ankita@nvidia.com, christian.koenig@amd.com, apopple@nvidia.com, vivek.kasireddy@intel.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, liulongfang@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-05 10:40, Jason Gunthorpe wrote:
> On Wed, Aug 05, 2026 at 05:28:27PM +0100, Matt Evans wrote:
>> Hi both (Logan thanks for your comments!),
>>
>> On 05/08/2026 01:39, Jason Gunthorpe wrote:
>>> On Tue, Aug 04, 2026 at 10:19:11AM -0600, Logan Gunthorpe wrote:
>>>
>>>> There's a vague convention for this already: the term 'p2pmem' is often
>>>> used for cases where the driver uses the allocator, etc. (I think I had
>>>> this intention when I wrote the code and have since forgotten about
>>>> it).
>>>
>>> I've been calling it the genalloc layer and the core layer. p2pmem
>>> would be OK to refer to the genalloc stuff. So if you want to have
>>> CONFIG_PCI_P2PDMA and CONFIG_PCI_P2PMEM that seem sOk
>>>
>>>> code into it's own file, potentially renaming some functions. Then, in
>>>> the end, we would probably have a pcim_p2pdma_supported() function and a
>>>> pcim_p2pmem_supported() function, the latter being used by existing use
>>>> cases.
>>>
>>> Not quite sure why we need this?
>>
>> ( [1] )
>>
>>> Matt, the mlx5 stuff is the same as VFIO, it just uses the "core"
>>> layer and does not use the genalloc. So there shouldn't be an issue
>>> here, if the genalloc is off then the mlx5 stuff should still
>>> work. There shouldn't be a case where CONFIG_PCI_P2PDMA=y and mlx5 is
>>> broken?
>>
>> Oh, when CONFIG_PCI_P2PDMA=y it's all good.
>>
>> The issue is when CONFIG_PCI_P2PDMA=n, as mlx5 still seems to permit a
>> DMABUF export solely because pcim_p2pdma_provider() succeeds.  (This
>> patch's CONFIG_PCI_P2PDMA_CORE enables that.)  mlx5 assumes that getting
>> a provider means P2P DMA is also available.
> 
> That's my point, the mlx5 should work fine with CONFIG_PCI_P2PDMA_CORE
> only or it is split wrong.
> 
>> Later, DMABUF attach would fail, but it'd be good to keep the original
>> failure mode where UVERBS_METHOD_DMABUF_ALLOC fails early if no P2PDMA.
> 
> Why does it fail? It should not fail :)
> 
>> I was thinking something trivial like the following would let things
>> like IB fail the DMABUF_ALLOC early still, instead of making the
>> assupmtion that having a provider means having P2P DMA.  E.g. OK
>> provider's available, but test for P2P DMA support too:
>>
>>  bool pcim_p2pdma_supported(void)
>>  {
> 
> it seems illogical, if you have a provider you have p2p dma, things
> are split wrong if this is not true.
> 
> The split should be only around the genalloc and related
> (sysfs,etc,etc) not anything mlx5 uses.
> 
> The only think that should stop working without genalloc (ie
> CONFIG_PCI_P2PDMA=n) is nvme.

Hmm, seems I made a few mistakes in my reply. Though I'm less certain I
understand the issue anymore.

I did confuse in my response pcim_p2pdma_provider() and
pcim_p2pdma_supported(). The later choice I really dislike. My thinking
was we'd have two versions of pcim_p2p[dma|mem]_provider()... But I'm
not sure that's necessary.

I thought there were callers of pcim_p2pdma_provider() in the p2pmem
code (non-core) section. But digging deeper today, it seems like
pci_p2pdma_add_resource() is the one caller, which I'd expect would be
compiled out when CONFIG_PCI_P2PDMA=n. Which seems fine. So I'm not sure
I understand the root issue anymore.

Logan
