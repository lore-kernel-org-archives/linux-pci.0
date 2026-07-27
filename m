Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF13DD862;
	Mon, 27 Jul 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159953; cv=none; b=MO7zoKVlzOvdc2zBLNGKaLPsuJz1YMapHKAn6EucFgaJZU/oJz+OAYpOxs1EgGCZc5vZ04bJvzKmcTyl095czZ1wFdpe7uunFrJaH9J4xTZ+eRw1hoUeQWkVQOxfFDaZ7rdeZQZIzbyNwwSTsCuyOoFNTb68pqMmWz791HhLEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159953; c=relaxed/simple;
	bh=lc4wjFp4X2pRx1Bs5M25JTo4gybGXMklPVWB33wLOd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVSQtMY+Ngsg3srKSBIAod7Xxvcq6f0fQh0K0p/XPQ6VElgnaqn5Lkj6HgT05vs89J65mkCjU8Ufr8UaRLW/yL2qgCndRXrWT9qo4T3gg5iwvix8SJ6RZH7uF0HQ8aY+3qZXHx8fbxnV0w2ViEHmrFRrFwj7zN0A7YiE0Eu09fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=ZskU12RZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZskU12RZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785159948;
	bh=o+iGc+GJCTS1xjP0GrNCd6pv34HypihSysnfdAxKhNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZskU12RZmztuM3w4HPFjDsOXIgsG467DxpkSs7r/EY6Nr4XWq0fx2Q7L6sXkwrPGE
	 sF3fyUtv2LSqcvURF4oaHy15JtetLolF9cwePpea9AjleUrJlW76pZSpLOIYXA3Sgg
	 /gVZoPYegEBaNEdpoiU3VZbwagTmWv6jHKsst9cBjqUXttrleZrtn/87gzEYyvK7IA
	 M1KbthkOGz1dxLXoGfBPHo/vvfdnG1wQzwONNSu1dhGyzrD2HFGIq1JWNZp5e8+E6R
	 xFvYOgCvF+G3d5gWHyqJFwsAUucLg/PhU5ljNZcVI0FgMtHE3HuFQcDCXpKuQ7geXW
	 PT/5HM6dcPfLA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h80Gz0DrZz4w1k;
	Mon, 27 Jul 2026 23:45:46 +1000 (AEST)
Message-ID: <fc251875-1604-474e-afaf-b1c8cee04bc8@ozlabs.org>
Date: Mon, 27 Jul 2026 14:45:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-6-matt@ozlabs.org>
 <20260715181348.1F7851F000E9@smtp.kernel.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260715181348.1F7851F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear robot,

On 15/07/2026 19:13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Math bug in vfio_pci_dma_buf_find_pfn() breaks direct DMABUF mmap() by conflating VFIO and DMABUF VMA coordinate spaces.
> --
> 
> --- Patch [5]: [PATCH v5 5/9] vfio/pci: Convert BAR mmap() to use a DMABUF ---
> commit 9a789f4b1551b3573dc4e2e6ba3af07e0aa65ce5
> Author: Matt Evans <matt@ozlabs.org>
> vfio/pci: Convert BAR mmap() to use a DMABUF
> 
> This commit converts the VFIO device fd fops->mmap to create a DMABUF
> representing the BAR mapping. The VMA fault handler is updated to look
> up PFNs from the corresponding DMABUF instead. This is intended to support
> future code for direct mmap()ing of BAR DMABUFs.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f11a9624b9c0..adce779c722c7 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
> [ ... ]
>> @@ -1778,23 +1766,42 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>>  					   unsigned int order)
>>  {
> [ ... ]
>> +	scoped_guard(rwsem_read, &vdev->memory_lock) {
>> +		if (!priv->revoked) {
>> +			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
>> +							     vmf->address,
>> +							     order, &pfn);
> 
> [Severity: Medium]
> Will this actually support direct DMABUF mmap()s as the commit message
> suggests?
> 
> Looking at the math inside vfio_pci_dma_buf_find_pfn():
> 
> drivers/vfio/pci/vfio_pci_dmabuf.c:vfio_pci_dma_buf_find_pfn() {
>     ...
> 	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> 				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
>     ...
> }
> 
> If a direct DMABUF mmap has a vma->vm_pgoff of 0, won't 0 - priv->vma_pgoff_adjust
> underflow and cause the bounds checks to fail?

No.

vma_pgoff_adjust is zero unless the DMABUF is constructed for a
traditional mmap() in which case it equals the vm_pgoff, so this
expression is always >= 0 (will not underflow).

> Additionally, inserting the VFIO VMA into the DMABUF's i_mmap tree with a
> shifted offset seems to conflate coordinate spaces. Could this break future
> targeted unmap_mapping_range() calls?

First, in the case of a VMA from a traditional mmap(), the address_space
of the DMABUF is unique to that mmap() so there's no mixing-up of
address semantics.

Second, yes, future targeted zap will need to comprehend that the BAR
index might be encoded in the offset.  The vma_pgoff_adjust can be used
along with a VMA vm_pgoff to figure this out -- but in short there isn't
an obvious need for this currently and if more metadata would help, it
can be added when needed.


Matt
