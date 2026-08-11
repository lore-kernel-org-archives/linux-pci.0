Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA644606A;
	Tue, 11 Aug 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455985; cv=none; b=j6rZZ2WndJ31H7bAdWl/AwMPeQzpUOEnLNN7IfHR9GziFbbiFSxGZOE+Ty2KhAyAXH4YdgI0Tto2YfIqiKqjZEnPZNpP0tl4i4hDJqV4CHravja8q0wNv9BMWIjhARxpe7yq0PMKmxey/Bx/xGaVvUjPREtYRqeAVek1yBp+3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455985; c=relaxed/simple;
	bh=zsvWkYna6OM6Tmijg0IZy/Oe59hq8QBIQoQpya6Nd50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjZHVLPSrHOUgSf25lahEyNAt8Mo7aTWD71c2ylQModEKGsp+dCdI404CVL0fLe0CG6bYkBnS8DipR/qqLmEEjHk8sr4hYDhMfjQWTaZqehb+m6G4vvdFZe4UGEIUN5UhSEUW+i93Jo8TH+nLjCvHQ1koePk5dFF6lXDi0Pt9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=uh81J75z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="uh81J75z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1786455975;
	bh=jWJ1sfiQUrY8eZSJtbwUs8Sji3PCSlk35DzYAJePwXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uh81J75zaUrUxSobgiM/jehSkH7Kx3sml7mNHJOktOTkrmWsgPK99z1dgQP9jViCI
	 cMwNBxcYDAwwrmNr7sXX2aC6EYYHASdV3yQHDY9p5zyqh9utzR6I+Ji8k+8wi/qbuz
	 I+pS+OzWr94YiAgDrpzWv8IgyKw4DHpyPGSsxhqLF8Sk05aN0o2W8NdCfiWC3nmbLN
	 0QxE8H/7mUiACxbbyEF97xnzNadd/knMo4jkl0aY+gluYFxJ24OnA1xiJaVoBhNYZu
	 1f070xwYiYXlHE/hN+LT4hbB4Ueq1HgbvkKOM36v8RNBmZbznO43gUIRI4451hO9M6
	 0284DIxfautIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hKCZN2mfJz4w9r;
	Tue, 11 Aug 2026 23:46:03 +1000 (AEST)
Message-ID: <1ccd055c-9369-45ea-b3b2-e26c39b4f696@ozlabs.org>
Date: Tue, 11 Aug 2026 14:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alistair Popple <apopple@nvidia.com>,
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
 <72c83c2e-fcbb-4925-ba50-5be01af359ad@deltatee.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <72c83c2e-fcbb-4925-ba50-5be01af359ad@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Logan, Jason, Alex,

On 05/08/2026 21:50, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-05 10:40, Jason Gunthorpe wrote:
>> On Wed, Aug 05, 2026 at 05:28:27PM +0100, Matt Evans wrote:
>>> Hi both (Logan thanks for your comments!),
>>>
>>> On 05/08/2026 01:39, Jason Gunthorpe wrote:
>>>> On Tue, Aug 04, 2026 at 10:19:11AM -0600, Logan Gunthorpe wrote:
>>>>
>>>>> There's a vague convention for this already: the term 'p2pmem' is often
>>>>> used for cases where the driver uses the allocator, etc. (I think I had
>>>>> this intention when I wrote the code and have since forgotten about
>>>>> it).
>>>>
>>>> I've been calling it the genalloc layer and the core layer. p2pmem
>>>> would be OK to refer to the genalloc stuff. So if you want to have
>>>> CONFIG_PCI_P2PDMA and CONFIG_PCI_P2PMEM that seem sOk
>>>>
>>>>> code into it's own file, potentially renaming some functions. Then, in
>>>>> the end, we would probably have a pcim_p2pdma_supported() function and a
>>>>> pcim_p2pmem_supported() function, the latter being used by existing use
>>>>> cases.
>>>>
>>>> Not quite sure why we need this?
>>>
>>> ( [1] )
>>>
>>>> Matt, the mlx5 stuff is the same as VFIO, it just uses the "core"
>>>> layer and does not use the genalloc. So there shouldn't be an issue
>>>> here, if the genalloc is off then the mlx5 stuff should still
>>>> work. There shouldn't be a case where CONFIG_PCI_P2PDMA=y and mlx5 is
>>>> broken?
>>>
>>> Oh, when CONFIG_PCI_P2PDMA=y it's all good.
>>>
>>> The issue is when CONFIG_PCI_P2PDMA=n, as mlx5 still seems to permit a
>>> DMABUF export solely because pcim_p2pdma_provider() succeeds.  (This
>>> patch's CONFIG_PCI_P2PDMA_CORE enables that.)  mlx5 assumes that getting
>>> a provider means P2P DMA is also available.
>>
>> That's my point, the mlx5 should work fine with CONFIG_PCI_P2PDMA_CORE
>> only or it is split wrong.
>>
>>> Later, DMABUF attach would fail, but it'd be good to keep the original
>>> failure mode where UVERBS_METHOD_DMABUF_ALLOC fails early if no P2PDMA.
>>
>> Why does it fail? It should not fail :)
>>
>>> I was thinking something trivial like the following would let things
>>> like IB fail the DMABUF_ALLOC early still, instead of making the
>>> assupmtion that having a provider means having P2P DMA.  E.g. OK
>>> provider's available, but test for P2P DMA support too:
>>>
>>>  bool pcim_p2pdma_supported(void)
>>>  {
>>
>> it seems illogical, if you have a provider you have p2p dma, things
>> are split wrong if this is not true.
>>
>> The split should be only around the genalloc and related
>> (sysfs,etc,etc) not anything mlx5 uses.
>>
>> The only think that should stop working without genalloc (ie
>> CONFIG_PCI_P2PDMA=n) is nvme.
> 
> Hmm, seems I made a few mistakes in my reply. Though I'm less certain I
> understand the issue anymore.
> 
> I did confuse in my response pcim_p2pdma_provider() and
> pcim_p2pdma_supported(). The later choice I really dislike. My thinking
> was we'd have two versions of pcim_p2p[dma|mem]_provider()... But I'm
> not sure that's necessary.
> 
> I thought there were callers of pcim_p2pdma_provider() in the p2pmem
> code (non-core) section. But digging deeper today, it seems like
> pci_p2pdma_add_resource() is the one caller, which I'd expect would be
> compiled out when CONFIG_PCI_P2PDMA=n. Which seems fine. So I'm not sure
> I understand the root issue anymore.

Yes, this has gone round in a bit of a circle, apologies.

I went back to the original change and concluded vfio-pci _doesn't_
always need a provider, so this work to refactor P2PDMA to provide a
provider even when CONFIG_PCI_P2PDMA=n is unnecessary.

The original original need was to break the dependency of vfio-pci on
P2PDMA, since the series made vfio-pci dependent on
CONFIG_VFIO_PCI_DMABUF.  I'd missed that the _export_ of a DMABUF
doesn't need a provider (after all, the phys_vec has the PFNs).

So we can just do this:

- VFIO exports DMABUF internally for mmap()
- It attempts to get a provider for the export, but if
CONFIG_PCI_P2PDMA=n then provider is NULL.
- The DMABUF works fine for CPU access through the VMA
- If someone were to fish out the DMABUF from the VMA/fds then it cannot
be imported unless the provider is valid (dma_buf_map_attachment()
returns -EINVAL)
- Drop the P2PDMA changes entirely

IOW, when CONFIG_PCI_P2PDMA=n you obviously don't get to import DMABUFs
into another driver for P2P, so the provider is unused ... and when
P2PDMA is supported, the VFIO BAR VMA's DMABUF has a provider, so could
be imported for P2P.  The struct vfio_pci_dma_buf only needs to have a
valid provider if the DMABUF could possibly be imported of course.

The behaviour of pcim_p2pdma_provider() is unchanged, as are any other
consumers such as mlx5.

This is way simpler.  I will drop these first two P2PDMA refactor
patches from this series.  Sorry for the churn and time spent on these;
though a cleanup/refactor could have merit separately it sounds like
there's discussion needed on exactly what that goal should be.


Matt

