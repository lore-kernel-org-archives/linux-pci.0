Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA92F3C19;
	Thu,  8 Oct 2026 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440351; cv=none; b=DlUbW5A901Db4CccvliIeZtgBHaEjaRcUzypcLr/Jm7gph6cpsd5ZVwdGJi9RfjRpks5P5IlNJ+w7h5xOQP46q5QmgKlLpt5TlU7sEaSOj1R8XaIQCI4BIaUdTbvM0vLGd1K7pLPu8VV2OhF4ccam7DSxND7dZgN8v+KTik/fCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440351; c=relaxed/simple;
	bh=9zvW5Esdsyr3SqYRBpY2gjHq8X8anEWeDFdbjhJLYv0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SNu8tDveL7VIg0p3ZVsdpYYdP/D8AjjrgToY80TS2c7qHaih03J0D34fbyUYwa6msgaIHyro4/+0nuqYhl95UGFPwSdCAM41rsf0dyDSBha+1xE0agftP9u0bAoKH3rhKN+nKNDGgj1/LHNUNDgP6Pxdxjnj74KFvdlLnKHDBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZbC8TCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZbC8TCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504011F000FF;
	Thu,  8 Oct 2026 06:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440350;
	bh=1LfBdtJhmE5TUQSeHXd/lA9PQkcJHux0O4k2nwaNPpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZbC8TCLnxOaqndSDDYtUAv+ePfj5NT/G5OIyIcJLea5FzKV5iyuuNgsvCd4o25Bs
	 YxRxXszivockas+LejcdB9JwpM3Z5pgLaP406P0dAEaad23z3YF21vt02F0gq4Pu78
	 OhXWhn09KXpWQXc6Vlb1rFpv7SThfGhoQ7xduKDh01X/W/9ubXYsXfdIRlEuNV2csh
	 8eMpNdl6b2/nmL13TjdymU0bWoITy7cKAjxVLK5oUAeqRTLMExUw4iwCWDa35EqE4P
	 JM8bJUplGmXfgNIWYDzss1fH8rMKF4YKk9L+M/EYDSqBGfSU4XgQ+xHu+mC/Y91hZU
	 Ot9xOLR13fuRQ==
Message-ID: <sashiko-outbox-163680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/16] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-15-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-15-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:19:09 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci/tsm: Use-After-Free of tsm_dev due to missing device reference=
 count
--

commit 45c3cda47ad9fdb8464c2ba275fcaa5077625b75
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

iommufd/viommu: Allow PCI TSM backends to provide vIOMMU operations

This commit allows a vIOMMU implementation to be provided by a TEE Security
Manager (TSM) rather than the physical IOMMU driver. It queries the TSM
associated with the target PCI device and resolves the PCI TSM association
under pci_tsm_rwsem while pinning the module.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index dca9634f8d5eb..c8603867e09df 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c

[ ... ]

> @@ -36,6 +38,25 @@ static const struct pci_tsm_ops *to_pci_tsm_ops(struct=
 pci_tsm *tsm)
>  	return tsm->tsm_dev->pci_ops;
>  }
> =20
> +struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev)
> +{
> +	const struct pci_tsm_ops *ops;
> +	struct tsm_dev *tsm_dev;
> +
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +	if (!pdev->tsm)
> +		return NULL;
> +
> +	tsm_dev =3D pdev->tsm->tsm_dev;
> +	ops =3D tsm_dev->pci_ops;
> +	if (!ops->viommu_get_ops)
> +		return NULL;
> +	if (!try_module_get(ops->owner))
> +		return ERR_PTR(-ENODEV);
> +	return tsm_dev;
> +}

[Severity: High]
Does this code need to take a kobject reference on the device via
get_device(&tsm_dev->dev)?

The tsm_dev pointer is returned and stored in viommu->tsm_dev for the
lifetime of the vIOMMU, relying solely on the module pin.=20

The doc comment for tsm_get_device() states that backends must not unregist=
er
their TSM independently of module unload. However, in the Linux device mode=
l,
a module pin only prevents module removal; it does not prevent a PCI device
from being unbound via sysfs (unbind or remove) or hardware hot-unplug.

If the device is unbound, the driver core forces the driver remove callback
to run, which calls tsm_unregister().

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index f791359861020..2fce341ff9231 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c

[ ... ]

> @@ -16,6 +26,29 @@ static const struct class tsm_class =3D {
>  };
>  static DEFINE_IDA(tsm_ida);
> =20
> +/**
> + * tsm_get_device() - Pin the TSM attached to a device
> + * @dev: device whose TSM is to be pinned
> + *
> + * A successful lookup pins the backend module. Backends providing vIOMMU
> + * operations must not unregister their TSM independently of module unlo=
ad.
> + * Return: NULL if no vIOMMU-capable TSM is attached, an error if the mo=
dule
> + * cannot be pinned, or the TSM device associated with the pinned backen=
d.
> + */
> +struct tsm_dev *tsm_get_device(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +	return pci_tsm_get_device(to_pci_dev(dev));
> +}
> +EXPORT_SYMBOL_GPL(tsm_get_device);
> +
> +void tsm_put_device(struct tsm_dev *tsm_dev)
> +{
> +	module_put(tsm_dev->pci_ops->owner);
> +}

[Severity: High]
Can this dereference freed memory?

When tsm_unregister() is called during an unbind or hot-unplug event, it
invokes put_device(&tsm_dev->dev). Because no extra reference was held when
acquiring the device in pci_tsm_get_device(), the reference count drops to =
zero
and the tsm_dev object is freed via kfree().

Later, when the vIOMMU is destroyed, iommufd_viommu_destroy() calls
tsm_put_device(viommu->tsm_dev). This dereferences the freed memory to acce=
ss
tsm_dev->pci_ops->owner, resulting in a use-after-free crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D14
