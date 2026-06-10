Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293D428463;
	Wed, 10 Jun 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106892; cv=none; b=dfXrfgEm4EqeVK+fdVaJ/eyymBOc2uzOLTDgdlpIdCUnGa7sMGAdROPZNEfAFv69Et+s4qAa4jXgVbRVg8S7mvF6356e2U2+S4+DZ/rQEv3cQUmj7mF0eCgDm2iJ9FfNM4uXHtFCfQcjvg+/aqJnH3lHHdtDxekW3ORZBg/8LDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106892; c=relaxed/simple;
	bh=ukW1c1uMt9ueafvMqFkHXTOSlFzpWGuyC9gLsCXloss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VPveNsCe9eVP4YoUIIoPcP1SMkudypZ4QUmDBHJ3/goRvcS7EcXTCoNjvfYI71ERW569IrhOnAjiFyEX+tKi1xgc+EBf3g8ccRBMopn63QigSZIdz3lvucYf9VZLnYsrFVZ2cWey0eb/D/3s4Y7P68ELZVHhF8baOg5HX8be+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXwMepDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXwMepDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E831F00893;
	Wed, 10 Jun 2026 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106890;
	bh=oP35lkm7tGMje2LGiaFXL2/xfgQkw9B2auCSNuH9frI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fXwMepDghijxTfr+6Dwkpzz5P25W8gI+zIZgXmML989ZTt1kvi9ezwsQe+gRHxp5D
	 5mB87Un+iW4kwbYWGoUOOJje/8mB0NvgXxoN/sO3+P1lLrg5cf8TOsvVHhYZJIHclJ
	 kzV4aRg0JFmQMb/tJFw0413aVJXMNGwp4QVt7i/YTEq388pHZVKMKdNhMy/n3vvGck
	 AmzgfGcs5JDF38NgAIVrzcu9F+XcLfZk3ja5quiU55GC1BQTbHU6bT9rGuTdq/X9eU
	 H5VfKjLto7LnA5Vb/ohKdj7OM8FPgVQdwowyTwp1OTurvVQ/QCN1LrqrYq21jo25lk
	 LLNKUrIhSsEBA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] PCI/P2PDMA: Introduce a helper to release P2P
 resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260610151853.3608948-6-praan@google.com>
References: <20260610151853.3608948-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:54:49 +0000
Message-Id: <20260610155450.32E831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] `pci_p2pdma_remove_resource()` destroys the P2P memory pool wi=
thout RCU synchronization, causing Use-After-Free and NULL pointer derefere=
nces.
- [High] `vfio_pci_core_feature_p2p_register()` modifies P2P resources with=
out acquiring any serialization lock, causing data races with concurrent io=
ctls and `vfio_pci_zap_bars()`.
- [High] `devm_memunmap_pages()` blocks indefinitely in `vfio_pci_zap_bars(=
)` if P2P memory pages are persistently pinned by userspace, causing a loca=
l Denial of Service.

Pre-existing issues:
- [High] Error path in `pci_p2pdma_add_resource()` leaves a dangling devres=
 action, causing a Use-After-Free during driver unbind.
--

commit f498fe90fe30c1dceda58fbbdcd2de8314934e62
Author: Pranjal Shrivastava <praan@google.com>

PCI/P2PDMA: Introduce a helper to release P2P resources
   =20
Introduce pci_p2pdma_remove_resource() to allow manual teardown of a
device's P2P DMA pool. The new API enables exclusive owners of a device,
such as vfio-pci, to cleanly release P2P resources during session closure
or hardware reset.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index adb17a4f69396..2a48ffefa01c4 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
[ ... ]
> @@ -466,6 +469,41 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, in=
t bar, size_t size,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);

[Severity: High]
This is a pre-existing issue, but does the error path in
pci_p2pdma_add_resource() leave a dangling devres action?

If gen_pool_add_owner() fails, the code jumps to pages_free:

pages_free:
	devm_memunmap_pages(&pdev->dev, pgmap);
pgmap_free:
	devm_kfree(&pdev->dev, p2p_pgmap);
	return error;

The devm_add_action_or_reset() called earlier registers
pci_p2pdma_unmap_mappings() with the p2p_pgmap pointer, but it doesn't
appear to be deregistered here. When the device driver later unbinds,
will the devres core execute pci_p2pdma_unmap_mappings() with the already
freed p2p_pgmap pointer, leading to a Use-After-Free of p2p_pgmap->mem->own=
er?

> +/**
> + * pci_p2pdma_remove_resource - remove all p2p memory for a device
> + * @pdev: the device to remove the memory from
> + *
> + * Tear down the entire p2p DMA pool for the device. Zap any existinga
> + * userspace mappings of the p2pmem/allocate file
> + */
> +void pci_p2pdma_remove_resource(struct pci_dev *pdev)
> +{
[ ... ]
> +	gen_pool_destroy(p2pdma->pool);
> +	p2pdma->pool =3D NULL;

[Severity: Critical]
Does destroying the pool and setting it to NULL here without RCU
synchronization cause Use-After-Free and NULL pointer dereferences?

Because pdev->p2pdma is still active and accessible to RCU readers, it seems
this can race with several concurrent operations:

Concurrent sysfs readers like size_show() might read p2pdma->pool and
trigger a Use-After-Free when executing gen_pool_size().

Concurrent callers of pci_alloc_p2pmem() read p2pdma under RCU, see it is
not NULL, and could unconditionally pass the now-NULL p2pdma->pool to
gen_pool_alloc_owner(), causing a NULL pointer dereference.

Additionally, the driver detach handler pci_p2pdma_release() checks
if (p2pdma->pool) synchronize_rcu();. Since the pool is now NULL, it skips
RCU synchronization and immediately destroys the xarray, leading to a UAF
of the p2pdma structure itself by any remaining RCU readers.

> +
> +	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> +
> +	pci_info(pdev, "removed all peer-to-peer DMA memory\n");
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_remove_resource);
[ ... ]
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 7913b8916df91..7b58cb344408d 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1704,6 +1704,11 @@ static void vfio_pci_zap_bars(struct vfio_pci_core=
_device *vdev)
>  	loff_t len =3D end - start;
> =20
>  	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
> +
> +	if (vdev->p2p_registered_bars) {
> +		pci_p2pdma_remove_resource(vdev->pdev);

[Severity: High]
Is it possible for devm_memunmap_pages() to block indefinitely here while
holding a critical device rwsem?

Inside pci_p2pdma_remove_resource(), devm_memunmap_pages() synchronously
waits via wait_for_completion(&pgmap->done) for all device page references
to be released. If userspace has persistently pinned these P2P pages (e.g.,
by registering them with RDMA or io_uring), the reference count might remain
elevated, causing the kernel thread to hang in uninterruptible sleep.

Because vfio_pci_zap_bars() is called with down_write(&vdev->memory_lock)
held, this hang could prevent any future operations on the device, including
administrative driver unbinding.

[Severity: High]
Can pci_p2pdma_remove_resource() run concurrently with the ioctl handler
vfio_pci_core_feature_p2p_register()?

It looks like vfio_pci_core_feature_p2p_register() updates
vdev->p2p_registered_bars and calls pci_p2pdma_add_resource() without taking
vdev->memory_lock or any other serialization lock.

Since vfio_pci_zap_bars() directly calls pci_p2pdma_remove_resource(),
concurrent execution could cause a TOCTOU race and corrupt the p2pdma pool
state and pagemaps, as the PCI P2P subsystem assumes exclusive access from
the caller for state modifications.

> +		vdev->p2p_registered_bars =3D 0;
> +	}
>  }
> =20
>  void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device=
 *vdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610151853.3608=
948-1-praan@google.com?part=3D5
