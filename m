Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588958;
	b=XNDK9lHT9rXCyZ1s3yx/o+XaBhZe2Asx3GFKVw1N1ZHB9ykUm5kYsCUE2pp3P6ZjDVd6
	 NsiqFXeRxyy678Hgek4BSE6sZKtMiStmRwpMwZhB/EFBKunPgHhozp8e+kRBPCBB/HIGQ
	 geXh452jZNLayoj7PTGrNV7tlqHsvUNYFaRSAY7so/bT6zKrIf19JYqILeiHtcc4FWKYc
	 a1LDJqpAqMbaIiPxFDl42b1ncJrAN/UbW5O2dWxNaZgT/iXK4cpwhij99AQ/OlmuIcOQC
	 AzpOgM187DujpBju4viBU3A0Rxy3CuXQCy7g0S71eK3T6k+r8Twd5xcq2wcDSkMqJ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588958;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X5qEZefSXY1XOL8KRx7YiuNk4T6wkrqw2ZTyxAQewIg=;
	b=MV56w85CQMwSarPcAW5m/8acrSu7p1zDiELkruG19lgkpHDKqoIMS4tHborlVAZ5AQSw
	 q2PJI2fJuRcxdFiuII7XV4+3oeVUrD2BH0JKpU75Y3H7TZWnPz7l8IwpUC2C4ROD0XSvj
	 slXFg5y45l7il3yLhFqEyQg4MI4Uh7QArleUCZuaoNTjud8oZM1eMuSjiijWdwKp3PHuQ
	 wG6XVkPWeFCxefqGnKjQ8kNt0k+RcMsE0ESatDYOMa+t68VF0jhgw41Bzdy9BeOsOF646
	 1cKonqaGURkS1XRInw/np1GN4/zEKHANRk+SC+Nfmq3SPoLgqAlHoMqR7gSVLog6EBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N9A/ecFG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFBE606A31D
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9A/ecFG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0D51F000C7;
	Wed, 21 Oct 2026 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588957;
	bh=X5qEZefSXY1XOL8KRx7YiuNk4T6wkrqw2ZTyxAQewIg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N9A/ecFGZX5SgidsE2G3QuDRFkJ2n45x0NVNPUGomuZjz/ud6hxZFpzzAoy4hSFCX
	 RzJvZ4aJ02EVW1AzXKv/E0t6WY3Sg/fSsAEiUYnL9ciZV5BAB2iZZlPZnzVqNcFEjD
	 zy+Ac8fnGAAh5m4MevHace5BnvuC5jMftt/1micoQqvyeDARSN2FrBzHX2sEPEJAMu
	 1uwMYexc+z+fxsZSlDpUfdDB/hRzyK3iwUoS1N5oLssDl9/brQblssdrdCu/uIl+WF
	 AZNxzpS0UyOhIchItkyppveExddi1fNTQTr7XATv/MVGXv3jeLQjyTAtmnJAG0utLG
	 QCQb2NucLnoBw==
Message-ID: <sashiko-outbox-180299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] PCI: Honor alignment overrides
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261021124956.4250-4-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:22:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI: pci_align_resource() still misaligns resources when size < al=
ign
--

commit b332469defd2a6e720c73527f0af741c6fe04a04
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Honor alignment overrides

This commit introduces struct pci_resreq_data to pass the PCI device and
user-specified resource alignment into pci_align_resource() so that
remainder movement is skipped when a user alignment override is active.

Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.ke=
rnel.org/

[ ... ]

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630a4ab..441a62807719d 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -265,17 +265,21 @@ resource_size_t pci_resource_alignment(const struct=
 pci_dev *dev,
>   * before res->start if there's enough free space there. This enables
>   * tighter packing for resources.
>   */
> -resource_size_t pci_align_resource(struct pci_dev *dev,
> +resource_size_t pci_align_resource(struct pci_resreq_data *rr,
>  				   const struct resource *res,
>  				   const struct resource *empty_res,
>  				   resource_size_t size,
>  				   resource_size_t align)
>  {
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t remainder, start_addr;
> =20
>  	if (!(res->flags & IORESOURCE_MEM))
>  		return res->start;
> =20
> +	if (rr->user_align)
> +		return res->start;
> +
>  	if (IS_ALIGNED(size, align))
>  		return res->start;
> =20

[ ... ]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1ef..ea7d758712691 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
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
> +	if (!user_aligned)
> +		rr->user_align =3D 0;
> +}

[Severity: High]
Can pci_align_resource() still misalign resources when size < align?

Looking at pci_reassigndev_resource_alignment() ->
pci_request_resource_alignment() in drivers/pci/pci.c:

	if (resize) {
		r->start =3D 0;
		r->end =3D align - 1;
	} else {
		r->flags &=3D ~IORESOURCE_SIZEALIGN;
		r->flags |=3D IORESOURCE_STARTALIGN;
		resource_set_range(r, align, size);
	}

When a device matches pci=3Dresource_alignment=3D so resize (user_aligned) =
is
true, BARs in 0..PCI_ROM_RESOURCE with size < align are resized so that
size =3D=3D align. For those BARs, IS_ALIGNED(size, align) in
pci_align_resource() is already true, so rr->user_align is not needed to
skip remainder calculation for them.

Conversely, when resize (user_aligned) is false because align comes from
pcibios_default_alignment() (such as pnv_pci_default_alignment() returning
PAGE_SIZE on PowerNV), pci_request_resource_alignment() takes the else
branch and sets IORESOURCE_STARTALIGN while keeping size < align. However,
pci_init_pci_resreq_data() clears rr->user_align =3D 0 when !user_aligned.

Whenever pci_align_resource() in drivers/pci/setup-res.c is called with
size < align and rr->user_align =3D=3D 0 (whether for IORESOURCE_STARTALIGN
BARs via pcibios_default_alignment(), even if moved to
pci_resource_alignment(), or for a bridge window whose alignment was raised
above its size):

	if (IS_ALIGNED(size, align))
		return res->start;

	remainder =3D size - ALIGN_DOWN(size, align);

ALIGN_DOWN(size, align) evaluates to 0 and remainder equals size. Because
there is no aligning body, subtracting remainder shifts the entire resource
to res->start - size (and in the later commits "PCI: Fix nesting windows
with remainder at the left edge" and "PCI: Place resources to either edge
of the window", lowers constraint->align to 1U and selects candidate[1] or
candidate[3] at aligned_edge - size), placing the entire resource below the
aligned boundary at an address that is only size-aligned rather than
align-aligned.

Additionally, when a PCI-to-PCI bridge is specified in
pci=3Dresource_alignment=3D to allow expanding its bridge windows,
pci_reassigndev_resource_alignment() only unsets
PCI_BRIDGE_RESOURCES..PCI_NUM_RESOURCES - 1 without requesting user_align
on those windows. Because pci_init_pci_resreq_data() sets rr->user_align on
the bridge pci_dev for all of its resources, wouldn't this disable
remainder handling on the bridge windows (and in the later commit "PCI:
Place resources to either edge of the window", reject bridge window
candidates not aligned to rr->user_align)?

Would checking size <=3D align in pci_align_resource() (or restricting
remainder relocation to composite bridge window resources where size >
align) avoid shifting resources with size < align below their alignment
boundary?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021124956.4250=
-1-ilpo.jarvinen@linux.intel.com?part=3D3
