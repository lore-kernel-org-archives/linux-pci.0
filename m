Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC133BCD02;
	Mon,  3 Aug 2026 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781352; cv=none; b=tJXLu9tHhepSQd4rGLIg4S858l3+Wdl+U52iEAwwWO5dV147c2ee3/BdSXp4tEnQjvPUaBLYyo+94mC+fAlzrmQ7u5WrPbrzE5M2FRRv4pymnGMJL0+sbAyTtPkUxcUh8n8y+OLW1hzRXhGJ4lIEXRCwdPCcKKUhf1dN+og0ioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781352; c=relaxed/simple;
	bh=AfnigA3w/g7XJUKTyhYsTpdwK9jfjnjfeW5kFpQp0yQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BWh9lo0YVQ0DsJE096sJdQQJS/DKOhDSPf/ghz3+fTPOO0tpGsddXjttXiTWJpa2yNocsuOiXUCUV9Q6b9QaEJkSdny0/KFHKqavf3DqLfd5gM2+fa7itdWCIMxTuwPRx+zN3tkJ5Rh0E550mSc+EzzG8Cj1wZY3L9Cqkq03k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=WHOANUn9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="WHOANUn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785781340;
	bh=LiWzGw5wFji86+tISklPZjK8tL47Uu/AAQbscmCeg88=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=WHOANUn9d2+jaJfWGND0nEuSsUgJ+XAMGQG+7X9OUv+AwFhCw/iNfhxEjOf8CgPYn
	 IrVi5aiiGgzppLeCyjduVVRnMxbTZyatq1LCtzmc9L8CQRihzd8AcyXs7Z51StT1mF
	 0OmgoU3x0G+9iKFjjH10g7xk9VcMwOa07r0qzkSHmebUB9PSDlB7T6GsRVICIGs/Sn
	 1buePw2xB3hiadZOxXNIjukRpHOUEhZApw8QPRGhfbUoS1gH2naTcVpW3z/Awe3HjX
	 tfS+juEk5B4mSjdWp48WMF4LbJi2AnPL7AS8ls0t5+4WvVSJRvna3TIVjsVQpbLgdx
	 AF+bmJW1OJOVQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hDQ4f3MW5z4w9b;
	Tue, 04 Aug 2026 04:22:10 +1000 (AEST)
Message-ID: <cfae30ec-18ed-4f06-bf96-ef294a8c2744@ozlabs.org>
Date: Mon, 3 Aug 2026 19:22:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org> <amvWXNRtviKEuUoV@google.com>
 <ecf9b355-9fe1-440b-9281-08671a995139@ozlabs.org>
In-Reply-To: <ecf9b355-9fe1-440b-9281-08671a995139@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Praan,

On 31/07/2026 18:43, Matt Evans wrote:
> Hi Praan,
> 
> On 30/07/2026 23:55, Pranjal Shrivastava wrote:
>> On Wed, Jul 15, 2026 at 06:47:26PM +0100, Matt Evans wrote:
>>> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
>>> find a PFN.
>>>
>>> This supports multi-range DMABUFs, which typically would be used to
>>> represent scattered spans but might even represent overlapping or
>>> aliasing spans of PFNs.
>>>
>>> Because this is intended to be used in vfio_pci_core.c, we also need
>>> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>>>
>>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>>> ---
>>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 153 ++++++++++++++++++++++++++---
>>>  drivers/vfio/pci/vfio_pci_priv.h   |  20 ++++
>>>  2 files changed, 160 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> index c16f460c01d6..7c047400dfd1 100644
>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> @@ -9,19 +9,6 @@
>>>  
>>>  MODULE_IMPORT_NS("DMA_BUF");
>>>  
>>> -struct vfio_pci_dma_buf {
>>> -	struct dma_buf *dmabuf;
>>> -	struct vfio_pci_core_device *vdev;
>>> -	struct list_head dmabufs_elm;
>>> -	size_t size;
>>> -	struct phys_vec *phys_vec;
>>> -	struct p2pdma_provider *provider;
>>> -	u32 nr_ranges;
>>> -	struct kref kref;
>>> -	struct completion comp;
>>> -	u8 revoked : 1;
>>> -};
>>> -
>>>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>>  				   struct dma_buf_attachment *attachment)
>>>  {
>>> @@ -106,6 +93,146 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>>  	.release = vfio_pci_dma_buf_release,
>>>  };
>>>  
>>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
>>> +			      struct vm_area_struct *vma,
>>> +			      unsigned long fault_addr,
>>> +			      unsigned int order,
>>> +			      unsigned long *out_pfn)
>>> +{
>>> +	/*
>>> +	 * Given a VMA (start, end, pgoffs) and a fault address,
>>> +	 * search the corresponding DMABUF's phys_vec[] to find the
>>> +	 * range representing the address's offset into the VMA, and
>>> +	 * its PFN.
>>> +	 *
>>> +	 * The phys_vec[] ranges represent contiguous spans of VAs
>>> +	 * upwards from the buffer offset 0; the actual PFNs might be
>>> +	 * in any order, overlap/alias, etc.  Calculate an offset of
>>> +	 * the desired page given VMA start/pgoff and address, then
>>> +	 * search upwards from 0 to find which span contains it.
>>> +	 *
>>> +	 * On success, a valid PFN for a page sized by 'order' is
>>> +	 * returned into out_pfn.
>>> +	 *
>>> +	 * Failure occurs if:
>>> +	 * - A hugepage would cross the edge of the VMA,
>>> +	 * - A hugepage isn't entirely contained within a range
>>> +	 *   (including where it straddles the boundary between
>>> +	 *   ranges),
>>> +	 * - We find a range, but the final PFN isn't aligned to the
>>> +	 *   requested order.
>>> +	 *
>>> +	 * Upon failure, -EAGAIN is returned and the caller is
>>> +	 * expected to try again with a smaller order, which will
>>> +	 * eventually succeed (order=0 will always work).
>>> +	 *
>>> +	 * It's suboptimal if DMABUFs are created with neighbouring
>>> +	 * ranges that are physically contiguous, since hugepages
>>> +	 * can't straddle range boundaries.  (The construction of the
>>> +	 * ranges should merge them in this case.)
>>> +	 *
>>> +	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
>>> +	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
>>> +	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
>>> +	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
>>> +	 * To avoid double-offsetting in this scenario, subtracting
>>> +	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
>>> +	 * the effective offset.
>>> +	 */
>>> +
>>> +	const unsigned long pagesize = PAGE_SIZE << order;
>>> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
>>> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
>>
>> Maybe I'm getting ahead of myself here.. but it seems like this
>> restricts us to only mapping DMABUFs at offsets < 1TB due to the 
>> VFIO_PCI_OFFSET_MASK (since we have HBMs on PCI devices now, hitting 1TB
>> may not be a very distant future).
> 
> This is a really good question, thanks for raisiing it.  It is not too
> forward-thinking at all.
> 
>> While I understand this mask is needed to drop the BAR encoding in the
>> high bits. 
>>
>> My worry is, if in the future a user were to export a massive
>> contiguous DMABUF (e.g., >1TB of aggregated HBM) and tried to mmap deep
>> into it (passing an offset >= 1TB), this bitwise AND would silently drop
>> the high bits, leading to silent data corruption.
> 
> One of the big advantages of DMABUF export was that the range could be
> huge and unencumbered by the VFIO_PCI_OFFSET_SHIFT of the traditional
> mmap() interface.  It's a way to mmap huge BARs without having to change
> the user-visible shift).  So definitely this is a relevant concern.
> 
>> I think we should explicitly reject such an mmap with -EINVAL like:
>>
>> +const unsigned long pagesize = PAGE_SIZE << order;
>> +unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) << PAGE_SHIFT;
>>
>> +/*
>> + * Prevent silent wrap-around if the user mmaps a DMABUF at an
>> + * offset greater than the VFIO index mask allows.
>> + */
>> +if (unlikely(vma_off > VFIO_PCI_OFFSET_MASK))
>> +    return -EINVAL;
>>
>> +vma_off &= VFIO_PCI_OFFSET_MASK;
> 
> Agreed, for now this absolutely should not silently wrap if the offset
> is > 1TB, and we live with the restriction that a DMABUF sized >1TB
> can't be mapped with such an offset.  (We can still, say, map all of a
> 16TB DMABUF with offset=0, which is good.).  I'll add a check, thanks
> for pointing this out.
> 
> I suggest as something to revisit later, we flag for a DMABUF (maybe an
> evolution of vma_pgoff_adjust) to differentiate whether this masking
> needs to be applied (traditional mmap() path) or not (DMABUF mmap()),
> and then offsets can be arbitrarily large.

Having tinkered, the two-step approach I suggested isn't great because
userspace has no easy way to know that step 2 has occurred and that
large offsets are "now supported".

The second problem is this isn't just a limitation to not do an mmap()
with offset approaching 1TB, because you could run into trouble just
mapping, say, a 2TB BAR and then splitting it by unmapping a hole in the
middle:  the second VMA now has a huge offset.

It seems a proper fix is easy though:

 unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) <<
	 		  PAGE_SHIFT;  /* No masking! */

Then in vfio_pci_core_mmap_prep_dmabuf(),

 priv->vma_pgoff_adjust = vma->vm_pgoff;

I.e., if vma_pgoff_adjust just includes the region index up high, it
cancels out the (same) index in the vm_pgoff.  Thus regular mmap should
work (up to the 1TB offset), and DMABUF VMAs can have arbitrarily large
offsets.


Matt
