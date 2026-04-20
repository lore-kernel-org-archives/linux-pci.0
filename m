Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654438945C
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677350; cv=none; b=kTQD9R95ozM4FTOHJNDyy37wqN+mxmLFQqhlSsoNT7ppptjzVu6ral9aLt1fUfy1cCYGWu9LRp2LLqgFJhiHFsjb73QihIX5iqrgxS5Z6I554+NgBbtlWdhP/d0p63+KdLGt9pNkwu9N01GrpPOKfcuUc5wk42+97JFHMEct92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677350; c=relaxed/simple;
	bh=x7TiyUkdDfYp1S/Vh1JCZvHLfeXfMofV3Sld/1PbEiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGBq7/ws36kyv6CcX74GscsMt0thlEfoRiiZbnXEt9lnFmowXW/zOSXQzaOXnbT56eVLK8FjHmMqhau9Da9b/8+DqNcTG8Nv4Mhwd8xFmra4e+8a3TWV4IPLq1m+NxCoMWH7Akk0ESXZPiW0oQ3g97f9/7nsx8sQYtzqemcVCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kQdVTgTf; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kQdVTgTf"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fzgCz3rzCz9tnZ;
	Mon, 20 Apr 2026 11:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776677343; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6ErzniT0E1fKKEStO4sFTUK7zJLaixswSUKmn39sLg=;
	b=kQdVTgTfYIzb8WA+hbNVqhlX/vnvZVOgRB7o1iLN+fM83hbTXDMWLJow894H6CtuzF7wDF
	oActyA7GCxm8U1zy+RhktRIJcEaSGCxk2vUrqsK+7UPB3RzFzwlOP9VBJ5KWsSHs7n3gF8
	qpAZf7cOUF+bqyamyOEC85F2ZltLeLFgFYHcfju7IZ1rlVi5fpj8ycmNLLw3UaG9V4g7N7
	iQCK+ND9yGQLEmdEupJvlJVbWD+8jOOioztrjFuumEyC4WxbqBND+obs4XKe9o+ZvySGHG
	q2ssEK9qGTr5Ro0ow3LHhMdtECWBPQvNtcL3Z2/L12/74/rNLi5xUm6/glzrIA==
Message-ID: <cffc558c0110ba06e26912ea10df30ea1fb288cb.camel@mailbox.org>
Subject: Re: [PATCH v2 1/3] PCI/MSI: Add Devres managed IRQ vectors
 allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, phasta@kernel.org
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 Apr 2026 11:28:59 +0200
In-Reply-To: <c2f0d971-2150-7771-f9c6-cd02f05a5441@rock-chips.com>
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
	 <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
	 <a688f479ee522b101f02d17f9fe81c64cbe5f70d.camel@mailbox.org>
	 <c2f0d971-2150-7771-f9c6-cd02f05a5441@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 49dd4ba7dec644f03b3
X-MBO-RS-META: 9ik4ykgo4wkt54xf5ywpaixa8es3cjpj

On Fri, 2026-04-17 at 17:33 +0800, Shawn Lin wrote:
> Hi Philipp
>=20
> =E5=9C=A8 2026/04/17 =E6=98=9F=E6=9C=9F=E4=BA=94 16:44, Philipp Stanner =
=E5=86=99=E9=81=93:
> > Hello Shawn,
> >=20
> > On Fri, 2026-04-17 at 10:26 +0800, Shawn Lin wrote:
> > > pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are cr=
eated for
> > > pci device drivers which rely on the devres machinery to help cleanup=
 the IRQ
> > > vectors.
> >=20
> > The commit message doesn't really detail *why* you add this. The rule
> > of thumb is to first describe the problem and then describe roughly
> > what the patch does about the problem. That also makes it easier for
> > reviewers to quickly match code to intent
> >=20
>=20
> Sure, will do.
> > `

[=E2=80=A6]

> > > +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned in=
t min_vecs,
> > > +				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> > > +				=C2=A0=C2=A0 struct irq_affinity *affd)
> > > +{
> > > +	dev->is_msi_managed =3D true;
> >=20
> > Do you have to set this to 'false' again? If so, who does that? A small
> > comment here could describe that.
> >=20
> >=20
> > Note that for your cleanup, in the long run, once all users are ported,
> > these helper bools should not be necessary anymore because devres
> > already stores all the relevant state.
> >=20
> > Likewise, I would like to remove the "is_managed" and "is_pinned"
> > flags, but that can only be done once all API users are ported.
> >=20
> > If this is the case with 'is_msi_managed', too, there should be a
> > cleanup TODO comment in my opinion. "This can be removed once=E2=80=A6"
> >=20
>=20
> My initial plan was to make it into 3 steps:
> (1) Set is_msi_managed true via pcim_alloc_irq_vectors*();
> (2) All pcim_enable_device() + pci_alloc_irq_vectors*() users are ported
> (3) remove is_msi_managed assignment=E2=80=8C from pcim_enable_device()
>=20
> As you could see, on step 1 & 2, pcim_enable_device() +
> pci_alloc_irq_vectors*() users uncondictionly set is_msi_managed true.

pcim_enable_device() does not set that flag (if you meant that; I'm not
sure).

The flag is already set by pcim_setup_msi_release(). Why do you need a
second place to set it?

> So they don't have to set it false again. At least it keeps the previous
> behaviour. For potential new pci_enable_device() +
> pcim_alloc_irq_vectors*() users before all the convertion is done, It's
> indeed a problem here.

The thing is that I believe that this should be orthogonal.

1. You'd keep the old functions exactly as they are now.

2. Then, you add new pcim_irq_vector() et. al. functions. They won't
need any flag, because the managed state is stored by the devres
backend.

3. You port a few users of the pcim_enable_device() + alloc_irq()
function combination

4. Once you have ported all of them, you can completely remove the
is_managed flag and related devres functionality from the old
interfaces.


I don't see why new code should interact with that flag mechanism. That
seems incorrect to me. Can you explain to me why you think it's
necessary?


>=20
> Does something below make sense to you?
>=20
> int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min_v=
ecs, unsigned int max_vecs,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsig=
ned int flags,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t irq_affinity *affd)
> {
> 	int nvecs;
> 	bool already_set_msi_managed =3D dev->is_msi_managed;
>=20
> 	if (!already_set_msi_managed)
> 		dev->is_msi_managed=3D true;
>=20
> 	nvecs =3D pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> 					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, affd);
> 	if (nvecs < 0 && !already_set_msi_managed)
> 		dev->is_msi_managed =3D false;

Hmm, not sure. See above.


P.

>=20
> 	return nvecs;
> }
>=20
>=20
> Thanks.
>=20
> > (But I'm not super deep in PCI devres since many months; but I think I
> > remember that not properly dealing with that flag state even caused us
> > a bug or two in the past)
> >=20
> >=20
> > Regards,
> > Philipp
> >=20
> > > +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, affd);
> > > +}
> > > +EXPORT_SYMBOL(pcim_alloc_irq_vectors_affinity);
> > > +
> > > +/**
> > > =C2=A0=C2=A0 * pci_irq_vector() - Get Linux IRQ number of a device in=
terrupt vector
> > > =C2=A0=C2=A0 * @dev: the PCI device to operate on
> > > =C2=A0=C2=A0 * @nr:=C2=A0 device-relative interrupt vector index (0-b=
ased); has different
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 2c44545..3716c67 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1770,6 +1770,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_=
dev *dev, unsigned int min_vecs,
> > > =C2=A0=C2=A0				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flag=
s,
> > > =C2=A0=C2=A0				=C2=A0=C2=A0 struct irq_affinity *affd);
> > > =C2=A0=20
> > > +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vec=
s,
> > > +			=C2=A0 unsigned int max_vecs, unsigned int flags);
> > > +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned in=
t min_vecs,
> > > +				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> > > +				=C2=A0=C2=A0 struct irq_affinity *affd);
> > > +
> > > =C2=A0=C2=A0bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
> > > =C2=A0=C2=A0struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev,=
 unsigned int index,
> > > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 const struct irq_affinity_de=
sc *affdesc);
> > > @@ -1812,6 +1818,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, uns=
igned int min_vecs,
> > > =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +static inline int
> > > +pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int mi=
n_vecs,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsig=
ned int flags,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_affinity *aff_des=
c)
> > > +{
> > > +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, aff_desc);
> > > +}
> > > +static inline int
> > > +pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsigned int=
 flags)
> > > +{
> > > +	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> > > +}
> > > +
> > > =C2=A0=C2=A0static inline bool pci_msix_can_alloc_dyn(struct pci_dev =
*dev)
> > > =C2=A0=C2=A0{ return false; }
> > > =C2=A0=C2=A0static inline struct msi_map pci_msix_alloc_irq_at(struct=
 pci_dev *dev, unsigned int index,
> >=20
> >=20

