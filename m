Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2F50E599
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897867; cv=none; b=Smdu3wfaVXE+l4vxwSjDenZQnYr2XilTpIz+nBkA4ohyxTUo/hy/j6NZNXc6cMx90/7CFgyLbVL7pm/Y9OJ/5ugY8fTrgDDGVlOL+Uh/dD2PPVnXFbol7UAFdZ6aOMImbJxquuHNUQsspfCFjU3j+qh+aE6dSj7P7pktzIXzFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897867; c=relaxed/simple;
	bh=cZ1RmRMc4ZyLvi/6fF16dz1SS+H0XQvj675lH1Qoxvw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=RJ/ko+Nh9+iRqo7/yc1Lpe5aj/TJIEbaBms0ygAU0BubUkGwx0JWGgxK+XDRx+zoo9U9WlsUWcN/TQ5DkyPjQaMsLbY/7HA5vU46l2X2CuMtqloBj4vW2KblR4TP139cEElm44lDNgnGzp/PPR5W/rsYIYUsDK4w/V9joodJAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK1mADeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK1mADeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F821F00898;
	Tue, 13 Oct 2026 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897866;
	bh=a+KTIEiumSQgYw1pEEhiB0F+kfJhtjmJDeRdASjNNu8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NK1mADeR7a/qAT+UywBtFh8vY4i2CK4MZycPo8PnXnwNEZCO+5gHH6zrM9GS+8VWS
	 kS7BVNBDQ46BqQLucbMhBykAQGilTa8F6oYooJq8LlOoVt5tTKgeVqpyWRXStCdkps
	 KvkHBoQDuv2GMMJZRb7QWOJMDqadcpV5uHO1E1Q65SmAFBDQMy5id28+A9UYy8ryM6
	 D9c22nGrIPeQHQYm0LIng6NSXIX3NO3560n0NnllDAaDheXPdIc0923rf4FAv7wbcJ
	 4N//ji8C0Ctbdkm0F5BE00pd63D/DYSRx9TbtBTsAbhA6HtTqIyvFW0979hu8VHGQE
	 O9QVASW/N8ILg==
Message-ID: <sashiko-outbox-169802@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] PCI: Honor alignment overrides
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261013130948.6231-4-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:24:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: uninitialized variable `user_aligned` causes random bypass of=
 resource alignment
--

commit dc4a5f31af386d2a1de50debe4823977860a1cb9
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Subject: PCI: Honor alignment overrides

This commit introduces struct pci_resreq_data to hold device and user-given
alignment. It allows pci_align_resource() to honor user-given alignment by
skipping remainder movement when a user alignment is provided.

Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.ke=
rnel.org/

[ ... ]
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1ef..ea7d758712691 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
[ ... ]
> @@ -1217,12 +1217,40 @@ int __must_check pcibios_enable_device(struct pci=
_dev *, int mask);
>  /* Architecture-specific versions may override this (weak) */
>  char *pcibios_setup(char *str);
> =20
> -/* Used only when drivers/pci/setup.c is used */
> +/* Resource assignment request handling */
> +/**
> + * struct pci_resreq_data - Data passed to pcibios_align_resource()
> + * @dev: PCI device
> + * @user_align: User provided alignment override (pci=3Dresource_alignme=
nt param)
> + */
> +struct pci_resreq_data {
> +	struct pci_dev *dev;
> +	resource_size_t user_align;
> +};
> +
> +resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +						 bool *resize);
> +/*
> + * TODO: Improve PCI resource assignment interface so that callers outsi=
de PCI
> + * core do not need to know about this detail.
> + */
> +static inline void pci_init_pci_resreq_data(struct pci_resreq_data *rr,
> +					    struct pci_dev *dev)
> +{
> +	bool user_aligned;
> +
> +	memset(rr, 0, sizeof(*rr));
> +	rr->dev =3D dev;
> +	rr->user_align =3D pci_specified_resource_alignment(dev, &user_aligned);

[Severity: High]
Does this leave user_aligned uninitialized on the default execution path?

When pci_init_pci_resreq_data() calls pci_specified_resource_alignment(),
the output parameter is not always written to. For instance, if there
are no boot parameters, pci_specified_resource_alignment() exits early:

drivers/pci/pci.c:pci_specified_resource_alignment() {
    ...
	p =3D resource_alignment_param;
	if (!p || !*p)
		goto out;
    ...
out:
	spin_unlock(&resource_alignment_lock);
	return align;
}

This leaves user_aligned with uninitialized stack memory. If this memory
happens to be non-zero, it can cause the resource alignment logic to be
randomly bypassed later in pci_align_resource(), leading to potential PCI
resource exhaustion or allocation failures on architectures with a non-zero
default alignment.

Could user_aligned be initialized to false before being passed?

> +	if (!user_aligned)
> +		rr->user_align =3D 0;
> +}
> +
>  resource_size_t pcibios_align_resource(void *data, const struct resource=
 *res,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D3
