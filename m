Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A483FFFA7;
	Mon, 27 Jul 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159947; cv=none; b=TKH0EnlcKEATQWrv5cLtGzg7fAlTHL6eZ2ZPLlqz2kE/rB3Nkh/lybDUWF9/F/Xfn1uCgxTl+DoDJfJeiWSBQSFMKYneyU82KygNAD4hQIPIFj5AFUHrXBw8ryFj68NnQvppwnLFG5hXqMDYsQ3W7GO8iqTUgVtE0RYRQiRv06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159947; c=relaxed/simple;
	bh=EqJEGbOSLQLehFvBcMH7Wr5miHhqpSaZeAA9r9Ntj8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu9H9N06WO5NShimzs3kYNLNxuwmNuD+zN6gpjYgg43nSwO0WsEx9P9rXrR5ZJpOSn/n3eXmILOuXkyr2Tp3PTePY1HWPygBekEeAoS4/3ec5FjooNmKif8R2IPGyKWyHEbjq/2zG/LUQBOF1dmqXMlnBmfU8iJgCDvcctgGMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=GZoI0Vqp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="GZoI0Vqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785159937;
	bh=tOYeOAk17BY7x6FHTRObGsa4k5RaMqI7iSQeirc1V4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GZoI0VqpX4cCSFC8+DmKKvOShlQ0g1LlfzpE8TUt+/IEsANda3l47c/B+FAoLno34
	 Ow3ObZ1DZPe5sPFlaC1AeAJVzQulJSr3jlcrhw05g87aQWhwosaCkO7X/oc2K54OEV
	 Y/0XIouZPN+LfMTDyQ5dEJLq1OJX0yzLFq6zoUR1sfHjkFkTryi9xJJNZ5DlwNxAEe
	 XnwdAIpCoHaJgt5VTWvGzvmMKz5EVUNi5Fd/niXzUimOZ5McQCUVI/HqRRk4euWymH
	 BweRK0wvHn76qjPJsnwhJv+1m/N35OqAhVXS2p+DWbFjqTf/tZ4fPQK5HxIFisp1HT
	 wSJcGQreySVIQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h80Gl4lTgz4w1j;
	Mon, 27 Jul 2026 23:45:35 +1000 (AEST)
Message-ID: <66843447-b39d-418d-9561-04191c54a787@ozlabs.org>
Date: Mon, 27 Jul 2026 14:45:31 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-5-matt@ozlabs.org>
 <20260715181228.D1AD81F000E9@smtp.kernel.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260715181228.D1AD81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Sashiko,

I guess I should reply to the robot and point out false
positives/misconceptions for posterity:

On 15/07/2026 19:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing bounds check on `res_index` before calling `pcim_p2pdma_provider()` leads to out-of-bounds array access.
> --
> 
> --- Patch [4]: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA ---
> commit 733300e7a6e7bd6d5e79581e31e2eac09e4e5c22
> Author: Matt Evans <matt@ozlabs.org>
> 
> vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA
> 
> This commit adds a helper function, vfio_pci_core_mmap_prep_dmabuf(), to
> create a single-range DMABUF for mapping a PCI BAR. It also refactors the
> existing vfio_pci_core_feature_dma_buf() to extract common export logic.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 7c047400dfd16..74c02794bfe28 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> 
> [ ... ]
> 
>> @@ -460,6 +473,75 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>  	return ret;
>>  }
>>  
>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>> +				   struct vm_area_struct *vma,
>> +				   u64 phys_start, u64 req_len,
>> +				   unsigned int res_index)
>> +{
>> +	struct vfio_pci_dma_buf *priv;
> 
> [ ... ]
> 
>> +	priv->vdev = vdev;
>> +	priv->size = req_len;
>> +	priv->nr_ranges = 1;
>> +	priv->vma_pgoff_adjust = vma_pgoff;
>> +	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
> 
> [Severity: Medium]
> Is a bounds check needed on res_index before calling pcim_p2pdma_provider()?

No.

> If a caller passes an index like VFIO_PCI_ROM_REGION_INDEX (6) or higher, 
> pcim_p2pdma_provider() will index the mem[PCI_STD_NUM_BARS] array out of
> bounds, returning an invalid pointer. 
> 
> This invalid pointer could later be dereferenced by pci_p2pdma_map_type() 
> in dma_buf_phys_vec_to_sgt(), which might lead to memory corruption or crashes.

The index is checked by the (only) caller, vfio_pci_core_mmap(), at the
point of first consumption from userspace and cannot be out of range here.

Defensively, this mid-level function _could_ check, but then the
argument could also be made that pcim_p2pdma_provider() should
bounds-check its parameters before pci_resource_flags(dev, index) too;
evidently we've chosen for callers to ensure things are in range instead
and I'd say that applies to this function too.


Matt

