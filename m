Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED92F532F
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415481; cv=none; b=kxOunI78R9bGSZvMJF9xq8Ri97ShwCN9J4YpAxebHXynxZptsF7oKxP5TBL4z6a3iZGdj44YN1BftLG/YoBGsnKeibkkk825Zgebww4ZXtI7UqibiQdm0AOy1knZ2PkDm/ciczzlypp5QroShfY38/TgSJ5kfJI5WQQ9ZMoPbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415481; c=relaxed/simple;
	bh=LzLfSmMqkxxBQDx7RKbg5cYHZJ3QetjqB5mjFYhHfcI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=egFy188ybEmvAdZa+sse6rYleN9oD9ECtgjZ8fZHal6tu5G08ssw+nKfn3HAqdBemkdRqCp14EPVGKdYt5LJmBoQwqiIoNveWl9oK+A4anM3mjkZhUD/v0Qnjsko7HZthU/a62JDFEhc4jey7P0joLoZiVNqV9ggffFsFSv1QPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kjfrEH0S; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kjfrEH0S"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fxpN30mj4z9tsW;
	Fri, 17 Apr 2026 10:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776415475; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pc4AKGOAkJyll4Gwgm7UxI/RhCv1MvaWzCa10tGDeeQ=;
	b=kjfrEH0SCKsPBDA7rfy0bGW7tcsQmDrlEawtDjMTQnp7QLn1CojH+SAZog9dqcr0rk8WYC
	9Yi03LBVOpsqGVEMR4/UDoHH827lFbelVGZrGQtEDfvPZLpqS4v67pWCMrESMFaTRJt0ED
	fzx5XYlffOdKS1mZb8vP9PMnSF+R13FrgUE4XCJ6Av4AY5JXcZfiHVbJhuZTkN+x71BEf1
	QtcSQg5pS0PrQE0LsM199f7fjccO8qb8tTHsB/6lyBWaYjKQEiT8OdbbtkGnF1DlnjWBx6
	C3GTR1rF1rGgRstcAB3X/35FQlxtFwppeBVhR7ikKnb2bTFG0yClyIW6991Rnw==
Message-ID: <a688f479ee522b101f02d17f9fe81c64cbe5f70d.camel@mailbox.org>
Subject: Re: [PATCH v2 1/3] PCI/MSI: Add Devres managed IRQ vectors
 allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Fri, 17 Apr 2026 10:44:30 +0200
In-Reply-To: <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
	 <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: nb44okfzyy9dgbfzasfxanhfuobrt5he
X-MBO-RS-ID: 23fd5b5fd99b053adac

Hello Shawn,

On Fri, 2026-04-17 at 10:26 +0800, Shawn Lin wrote:
> pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are create=
d for
> pci device drivers which rely on the devres machinery to help cleanup the=
 IRQ
> vectors.

The commit message doesn't really detail *why* you add this. The rule
of thumb is to first describe the problem and then describe roughly
what the patch does about the problem. That also makes it easier for
reviewers to quickly match code to intent

>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Could contain a Suggested-by: Philipp Stanner <phasta@kernel.org> ? :)

>=20
> ---
>=20
> Changes in v2: None
>=20
> =C2=A0drivers/pci/msi/api.c | 26 ++++++++++++++++++++++++++
> =C2=A0include/linux/pci.h=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
> =C2=A02 files changed, 48 insertions(+)
>=20
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index c18559b..2362fca 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -297,6 +297,32 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *d=
ev, unsigned int min_vecs,
> =C2=A0EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> =C2=A0
> =C2=A0/**
> + * pcim_alloc_irq_vectors() - devres managed pci_alloc_irq_vectors()
> + * Interrupt vectors are automatically freed by the devres machinery

nit: "devres machinery" is not a very common expression. I would just
say "through devres".

For correct docstrings, though, you need to describe all the parameters
below, like 'dev', 'min_vecs' etc.

Also the return value needs to be described.

https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

Do you do "make htmldocs"? I think that should provide warnings for
that?


> + */
> +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +			=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags)
> +{
> +	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> +}
> +EXPORT_SYMBOL(pcim_alloc_irq_vectors);
> +
> +/**
> + * pcim_alloc_irq_vectors_affinity() - devres managed pci_alloc_irq_vect=
ors_affinity()
> + * Interrupt vectors are automatically freed by the devres machinery
> + */

Same here with docstrings

> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int mi=
n_vecs,
> +				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> +				=C2=A0=C2=A0 struct irq_affinity *affd)
> +{
> +	dev->is_msi_managed =3D true;

Do you have to set this to 'false' again? If so, who does that? A small
comment here could describe that.


Note that for your cleanup, in the long run, once all users are ported,
these helper bools should not be necessary anymore because devres
already stores all the relevant state.

Likewise, I would like to remove the "is_managed" and "is_pinned"
flags, but that can only be done once all API users are ported.

If this is the case with 'is_msi_managed', too, there should be a
cleanup TODO comment in my opinion. "This can be removed once=E2=80=A6"

(But I'm not super deep in PCI devres since many months; but I think I
remember that not properly dealing with that flag state even caused us
a bug or two in the past)


Regards,
Philipp

> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, affd);
> +}
> +EXPORT_SYMBOL(pcim_alloc_irq_vectors_affinity);
> +
> +/**
> =C2=A0 * pci_irq_vector() - Get Linux IRQ number of a device interrupt ve=
ctor
> =C2=A0 * @dev: the PCI device to operate on
> =C2=A0 * @nr:=C2=A0 device-relative interrupt vector index (0-based); has=
 different
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c44545..3716c67 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1770,6 +1770,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev =
*dev, unsigned int min_vecs,
> =C2=A0				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> =C2=A0				=C2=A0=C2=A0 struct irq_affinity *affd);
> =C2=A0
> +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +			=C2=A0 unsigned int max_vecs, unsigned int flags);
> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int mi=
n_vecs,
> +				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> +				=C2=A0=C2=A0 struct irq_affinity *affd);
> +
> =C2=A0bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
> =C2=A0struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned =
int index,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 const struct irq_affinity_desc *affdes=
c);
> @@ -1812,6 +1818,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigne=
d int min_vecs,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> =C2=A0}
> =C2=A0
> +static inline int
> +pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_ve=
cs,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsigned =
int flags,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_affinity *aff_desc)
> +{
> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, aff_desc);
> +}
> +static inline int
> +pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsigned int fla=
gs)
> +{
> +	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> +}
> +
> =C2=A0static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
> =C2=A0{ return false; }
> =C2=A0static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *=
dev, unsigned int index,

