Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1C3264C3;
	Thu, 13 Aug 2026 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661348; cv=none; b=HWPNkOyFbda1w/phTO0aZ867hCCs6+pWbXSz24dqHeT6ZrNP6TsFjqZHl6w00BKXdD+cqim+NaHTmBX6905UnAuHbdho7k/dJtRWYSJBGuYGaRkl0fecBsILi2zcmm7lh6Rw+gH+cQTzfETAHpWx4ynpOUqJoAO3vYtIt+HXMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661348; c=relaxed/simple;
	bh=VRCs2IGgGXqcTizxjuDiKTACPTnGs+V+R2c/aaBY6ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpb9CCkmu8Y+f7DwP5E+I+FneOConKFMi4gbktZ0ur5vOaVYDhXBrsyKR3gRjg/5oOUUrY2wt8RuTDisCsA+7mlf3OOsbWk+ynwj3QkjY2PY9NbGgXGqO+Notw990yKfOBP1QpgPVtWKcsx4rVKHFs/Tc7TK+tVVziveNK4yfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JRAz0Esb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KsSAkvm+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JRAz0Esb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KsSAkvm+"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8806D1D00445;
	Thu, 13 Aug 2026 18:49:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 13 Aug 2026 18:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786661343;
	 x=1786747743; bh=/sAO0fdSJ7gqX3uvNc8o4wMd/1apYOaeWHbU0IuBUAY=; b=
	JRAz0Esb9DiuVjrFI8nFhD9SvR2aQy33Ulg1KxnToJfwvazJolBLBmO9mOm18Del
	Dx/ONd3SnuDgFDku0M0UOiOMLwZHJNFueEgSelvfA6/9Iz0bNYkYqXBO6xI1mSiu
	molXbArLWJIy+v9xOY9Hgm1XDBF8B6GdiMkOsmzVGnVy6SJzmun4OPo2D+HzxCb/
	a4DRp/0ZRJxe9s76ZDw4jjJF7mwPuCm5ptW0ASiOq2knv/x8aYk/aa+jN3SeOqQs
	xbInQqZSY0XGmG60bk3HUPbBfWEtjN5uvFnsfF5QUSLD+U+wmpm/89IEu7CoiSN4
	bAyeXfE1hrLq3I10QOBySw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786661343; x=
	1786747743; bh=/sAO0fdSJ7gqX3uvNc8o4wMd/1apYOaeWHbU0IuBUAY=; b=K
	sSAkvm+4y5/8na5atNP98r581X1ueSeQxfeemO7/NYKrbfp5MgWrfXK8qpzt23I3
	lf0XKwQh2ltvtPfAEZKgYaBUcBvvib4slRRXfNL/c/wVmPv/m09IE5JJ5oS4kLVB
	DCsS46wC79BCOeXRbeMeCuJgPymWko1XkFVMP2Y/XuZPjpmOZ8XHWvENVLLuIibV
	d/xDOLzOiQfIZZ+FbQUoGB3cGVtSNAlnJfPa2NFMUG2AysjxVh8zHkqDNSZ4hdNA
	Cy+9qZOm5ykcRNLgilsJpYUYzntmjl5NSwHxaTHNHACBw5bq6QX8z75dAuDoCEUs
	w5GbZ21SSor2PxLe+j7AQ==
X-ME-Sender: <xms:3kl-aqPreNHMiHSv1WXiLC7gJs4hd2hsuOa8n9pa1YY9epYHAYRp9A>
    <xme:3kl-akbYvWenhyDMMW12Ei4kYzuA9KZ7hKaZQ4KKrTD8AbUHuod_4rguNHWgjkqSR
    KFl6zXBIwszF3t3x8sFpUeOa71S5gWh3cmetVRMfl5YR34Pnc6lb9c>
X-ME-Received: <xmr:3kl-av8fnSBEGVC1Oz2guRh_DC6k1x90buU1g97ZBnPKQPXvLTxRThbAQDQyRg>
X-ME-Proxy-Cause: dmFkZTEX8IudBVk14Is0tXOWIXKYmE57AKtN9s3juRQ0vlA48+l0VwkB3sdE7LBYFej4JO
    g88SWg2upcOJFDhkBNO32p2OSQCAAGPamtSsgz0BD8DthR3SCrGsWseFAn0kifrx7h7Oex
    mQxR8vhhHWCYbX9uDMHk6UXG3iiaJdHAlRcY9FLlRVaIgr+xinl//cH5MJ2hW1Qgx0nNRr
    q874TdGn55K+IYYglEi7LXoNI+BtPPVHu1eeRnDowr56j2kojR3/4vPA0hODZqfgwiX9qt
    rM428kbTe+Gof37ZmI1lNCiMf1r5ZVorT2J98P3FGvlybtkQ+8nVV1xwQKktmWZI2xrLUb
    g64nOIB7N841uvwIRmKaIqpBUY9kW61P9UbXR9HgpO5jPo3XlUD9rLCM+YzCiTFf90027E
    /WB9yPE69lWBqNPuAZmJm3DQYmtyia0M3ERzPsiFHFYbdMbZ8c/69+/3bPb0q+fOasR0an
    UuYnnoMEEodRPO4zIH3hfsSV/ymET4Ez6wDnyF3eitNtHYBCm9CF2swdFV1kZWgcV44/i6
    Ud8xk7BAoYGqKHn779/DVYdDYDQedIsLmBj+es7Ln/+hA3E6GPoF0TvQutJzDijMU7SjjB
    VO9Egv5tggQx8t02dby8xn+m0m0ehdSTnXXphRrl/Tr0i025052AMPI6E12g
X-ME-Proxy: <xmx:3kl-an3oWwdv55SJOVajFMbyi2dlnDIq0M04HC6NOFPIyunFjP7uJw>
    <xmx:3kl-ao2XiJaPPOocYWAp7Ry35BA4agPfXXK1NSUhtKFA9Pa4qEFEZQ>
    <xmx:3kl-akzQqV--wSBi71KRC63H8slsOXFlL-TbNThXJmTkZvh0zVs6Qg>
    <xmx:3kl-akWpgDezQ7qIjtkDesg3dMbZl5ObqGjcC6PZSGDm9aa1lNDoeA>
    <xmx:30l-avZBsujMldtYGbZq4OFYrqGAlbKIdGPgt8S938kv7iXcjpFlyo30>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 18:49:00 -0400 (EDT)
Date: Thu, 13 Aug 2026 16:48:58 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava
 <praan@google.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2?=
 =?UTF-8?B?bmln?= <christian.koenig@amd.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, David Matlack
 <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Message-ID: <20260813164858.2459c660@shazbot.org>
In-Reply-To: <9a615f22-c0d4-46ae-9654-db11e94e5fec@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<20260715174737.15287-5-matt@ozlabs.org>
	<9a615f22-c0d4-46ae-9654-db11e94e5fec@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 23:39:37 +0100
Matt Evans <matt@ozlabs.org> wrote:

> Hi Alex, Leon, Kevin, Praan,
> 
> On 15/07/2026 18:47, Matt Evans wrote:
> > This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> > DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> > commit by VFIO's ordinary mmap() path.
> > 
> > This function transfers ownership of the VFIO device fd to the
> > DMABUF, which fput()s when it's released.
> > 
> > Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> > export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> > this new VFIO_BAR mmap().
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 142 +++++++++++++++++++++++------
> >  drivers/vfio/pci/vfio_pci_priv.h   |   5 +
> >  2 files changed, 117 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 7c047400dfd1..74c02794bfe2 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -82,6 +82,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> >  		up_write(&priv->vdev->memory_lock);
> >  		vfio_device_put_registration(&priv->vdev->vdev);
> >  	}
> > +	if (priv->vfile)
> > +		fput(priv->vfile);
> >  	kfree(priv->phys_vec);
> >  	kfree(priv);
> >  }
> > @@ -233,6 +235,45 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Create a DMABUF corresponding to priv, add it to vdev->dmabufs list
> > + * for tracking (meaning cleanup or revocation will zap it), and take
> > + * a vfio_device registration.
> > + */
> > +static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
> > +				  struct vfio_pci_dma_buf *priv, u32 flags)
> > +{
> > +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +
> > +	if (!vfio_device_try_get_registration(&vdev->vdev))
> > +		return -ENODEV;
> > +
> > +	exp_info.ops = &vfio_pci_dmabuf_ops;
> > +	exp_info.size = priv->size;
> > +	exp_info.flags = flags;
> > +	exp_info.priv = priv;
> > +
> > +	priv->dmabuf = dma_buf_export(&exp_info);
> > +	if (IS_ERR(priv->dmabuf)) {
> > +		vfio_device_put_registration(&vdev->vdev);
> > +		return PTR_ERR(priv->dmabuf);
> > +	}
> > +
> > +	kref_init(&priv->kref);
> > +	init_completion(&priv->comp);
> > +
> > +	/* dma_buf_put() now frees priv */
> > +	INIT_LIST_HEAD(&priv->dmabufs_elm);
> > +	down_write(&vdev->memory_lock);
> > +	dma_resv_lock(priv->dmabuf->resv, NULL);
> > +	priv->revoked = !__vfio_pci_memory_enabled(vdev);
> > +	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
> > +	dma_resv_unlock(priv->dmabuf->resv);
> > +	up_write(&vdev->memory_lock);  
> 
> It looks like a local Claude review (kreview) genuinely found a problem
> here.  There seems to be a new deadlock scenario because vfio-pci's
> mmap() now does the DMABUF export and now takes vdev->memory_lock:
> 
> nvgrace-gpu forwards mmap() of regular BARs on to vfio_pci_core_mmap(),
> so it takes vdev->memory_lock for write here with mm->mmap_lock held for
> write.
> 
> But the nvgrace-gpu driver's MMIO accessors,
> nvgrace_gpu_{read,write}_mem(), rely on holding vdev->memory_lock for
> read across the device readiness check and the device access, e.g.:
> 
>  nvgrace_gpu_read_mem():
>     takes memory_lock(R)
>     nvgrace_gpu_check_device_ready()
>        nvgrace_gpu_map_and_read():
>           // The copy accesses the device
>           copy_to_user(...)         <-- could fault
> 
> That fault hits lock_mm_and_find_vma() and tries to take
> mm->mmap_lock for read.  That waits on another thread that's already
> started an mmap() and holds mm->mmap_lock for write but has blocked on
> the faulting thread's vdev->memory_lock.  ABBA and boom.
> 
> Yuck.  I'm glad this was found now, at least. :|
> 
> A possible way forward:
> 
> Please can I have some expert advice on whether the DMABUF export really
> must hold vdev->memory_lock for _write_ or could relax to hold it for
> _read_ in the function above:
> 
>  - It's protecting the __vfio_pci_memory_enabled() test vs adding the
> buffer to the list (could be read)
>  - It's upholding the invariant of priv->revoked not changing without
> holding both memory_lock & resv, but no one can see the DMABUF yet
>  - It's protecting the list-add against a concurrent revoke/cleanup
>  - It's protecting the list-add against another concurrent export
> 
> If vfio_pci_dmabuf_export() could instead hold memory_lock for read,
> then nvgrace-gpu (or other future vfio-pci variant drivers!) can also
> hold it for read, and the deadlock is avoided.
> 
> The revoke/cleanup paths hold vdev->memory_lock for write, so wouldn't
> run concurrently, but there'd be a new problem of protecting against
> another concurrent export.  Perhaps a new vdev->export_lock held (only)
> in this function around vdev->memory_lock could address that.
> 
> The other variant drivers seem to be OK in this regard.  Solving this in
> the core seems the right approach; at any rate, I don't think the
> nvgrace-gpu side can be relaxed.
> 
> There'd still be the strong constraint that the drivers must avoid
> taking vdev->memory_lock for write.  How to enforce this?
> 
> What are your thoughts on this problem/solution?  Am I missing any nuances?

My read is that the vfio dmabuf code is using memory_lock write-lock to
serialize the dmabufs list as a matter of convenience since it needs to
be held across all the revokes anyway.  It's an overloaded use of
memory_lock.

I agree with your analysis how we could use read-lock, but I don't
particularly like the idea of a separate lock just to serialize between
exports while legitimate write-lock paths continue to rely on
memory_lock for serialization.  I'd rather see a dmabufs_lock mutex
added and used consistently for serializing the dmabufs list.

I think the touch points are:

 - vfio_pci_dma_buf_release(): list protection only, dmabufs_lock

 - vfio_pci_core_feature_dma_buf(): memory_lock(R) for memory enabled,
   enclosing dmabufs_lock for list

 - vfio_pci_dma_buf_move(): add dmabufs_lock guard

 - vfio_pci_dma_buf_cleanup(): up_write memory_lock after move, add
   dmabufs_lock guard around list walk

The cleanup call is on the close_device path, so while it's a bit
clunky that we drop and re-aquire dmabufs_lock between move and list
pruning, no dmabufs can be added in that gap since the device is
closed, ie. no dmabuf feature ioctl access.  At least aiui.

For enforcement that a variant driver doesn't take the write-lock, I
think in part it's that there really shouldn't be a need for serializing
on memory_lock through mmap if we're using the lock correctly, but also
lockdep to find it.  Thanks,

Alex
