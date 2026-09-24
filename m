Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58D1C5499;
	Thu, 24 Sep 2026 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253823; cv=none; b=Zq6gzP/UkUyMYo2dy/n1/zk/8DTd80neU/qYXUTCMgsbMYK9NymJWyDZKSZP8O4l8YhsUUzJhS31cidD2w6gqkQwdq25+XK+qSo9uHaex64PVG8UHxl+y+xHHzAxlEoL6mNTZsbSSPmJ18oI8LqfFthmXNJXYpSIeC4EE2h/9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253823; c=relaxed/simple;
	bh=ZCAL2NVRIOdlpTo8zJRXqz7Sm2845Bf0yDs9Z7vBIhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrvK4EvQJ4WijY6rYdnhJdzLE3aFMYcC1NX9+bjAiwKJUWMSrhE3DVc12ABDMtlelAlKb3cYkNs4DIKz9DgTQeayDuULqR0cPQKW1AJsZFw1Jz/zRLGo1OZuR6rNWTb2225BAjv7trYyqIcojOsu9DbX015MT7whglARmbMSB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=gL+ZSAEr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="gL+ZSAEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790253788;
	bh=Q8URE2Gr9VfRYT7mJzVdQOsHMfXuzEs/1e7nQxKnhvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gL+ZSAErvMaeAbd3/y+oLrjwpUPSdNv8f5bDjAhfPfLE2C8rRBsEF1oLoKgQBuK/y
	 uRji1J0DOU899ACSUuccnZDXsXKUiGt4yKNisoJxBMoQyEJQW8c2IIx81NVY2N8vwz
	 vhkqYbwDkSE/BnUrSzWZsxHnM/aE+idsBDxIfnQO4FUkKt7SKN9CPdXrz6e32rYr7S
	 CRaopJTU9LyBLcTDl60/YoFFejqUCMh76+mYtrMulnDNMf4ybTKej/532mqQhYqs4j
	 paPzcPDije+qDjvP4xtXemW1u3oQVP6VA0FexM5vIQ5iGx5ktwrggXFiIo8vV0ZCSb
	 CmbUCA3B+RRSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrD5G4Cq0z4wCp;
	Thu, 24 Sep 2026 22:42:57 +1000 (AEST)
Message-ID: <8f00d827-f7cf-4b54-9609-fe966070c4e0@ozlabs.org>
Date: Thu, 24 Sep 2026 13:43:18 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Content-Language: en-GB
To: liulongfang <liulongfang@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-6-matt@ozlabs.org>
 <1d59a556-c131-4608-e194-d51be3259541@huawei.com>
 <4f26dd49-0985-4049-a1fe-6a0a493c7a51@ozlabs.org>
 <f8eb95a8-875e-fb31-a2a2-ffa1c531dedb@huawei.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <f8eb95a8-875e-fb31-a2a2-ffa1c531dedb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Longfang,

On 22/09/2026 10:16, liulongfang wrote:
> On 2026/9/21 21:24, Matt Evans wrote:
>> Hi Longfang,
>>
>> On 15/09/2026 13:16, liulongfang wrote:
>>> On 2026/9/12 5:41, Matt Evans wrote:
>>>> [snip]
>>>> +
>>>> +	/*
>>>> +	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>>>> +	 * start of the VMA corresponds to byte 0 of the DMABUF and
>>>> +	 * byte (vma_pgoff << PAGE_SHIFT) of the BAR.
>>>> +	 *
>>>> +	 * vfio_pci_dma_buf_find_pfn() reverses this offset using
>>>> +	 * vma_pgoff_adjust, so that ultimately a fault's offset from
>>>> +	 * the start of the _VMA_ has a consistent usage whether the
>>>> +	 * VMA originates from an mmap() of the VFIO device here or a
>>>> +	 * direct DMABUF mmap().  Note vma_pgoff_adjust also includes
>>>> +	 * the encoded VFIO region index, which cancels out the index
>>>> +	 * encoded in vm_pgoff.
>>>> +	 */
>>>> +	priv->vdev = vdev;
>>>> +	priv->size = req_len;
>>>> +	priv->nr_ranges = 1;
>>>> +	priv->vma_pgoff_adjust = vma->vm_pgoff;
>>>> +
>>>> +	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>>>> +	if (!priv->provider) {
>>>> +		ret = -EINVAL;
>>>> +		goto err_free_name;
>>>> +	}
>>>> +
>>>> +	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
>>>> +	priv->phys_vec[0].len = priv->size;
>>>> +
>>>> +	ret = vfio_pci_dmabuf_export(vdev, priv, O_RDWR);
>>>> +	if (ret)
>>>> +		goto err_free_name;
>>>> +
>>>
>>> In the current patch, the PCIe device's BAR2 configuration space can be mapped as a DMABUF.
>>> However, on an OS with a 64K page size, if a VF device's BAR2 is smaller than 64K,
>>> a problem arises where the space is forced to page-align to 64K, it will causing the VM to
>>> access memory beyond the actual size of the VF device's BAR2 space.
>>>
>>> How does your solution handle these cases where the BAR2 space is smaller than the Host OS's page size?
>>
>> Even on a 4K host, there can be BARs < PAGE_SIZE so 64K (or 16K) hosts
>> aren't a new case.  These small BARs cannot be mmap()ed and DMABUFs
>> cannot be exported from them.  (vfio_pci_core_mmap() errors out when
>> !bar_mmap_supported[index].  And, a DMABUF needs to be an aligned
>> multiple of PAGE_SIZE, plus vfio_pci_core_fill_phys_vec() won't allow a
>> DMABUF to be created off the end of a BAR.)
>>
>> So, although this series allows a DMABUF to be mmap()ed, the preexisting
>> checks prevent a sub-page DMABUF from existing and so there is no new
>> route to mapping a sub-page BAR.
>>
>> What's the concern on BAR2 specifically, out of interest?  This logic is
>> applied to all resources equally, and tests pci_resource_len(...) so
>> there shouldn't be a PF/VF distinction either.
>>
> 
> However, the typical boundary check found in VFIO, such as:
> 
> if (req_start + req_len > phys_len)
> 	return -EINVAL;
> 
> seems to be missing here.

Isn't it covered by that statement in vfio_pci_core_mmap() just before
this function is called?  This helper is intended to do as it's told by
a caller that has validated the range is correct (it doesn't duplicate
the checks already done by vfio_pci_core_mmap()).

Thanks,

Matt
