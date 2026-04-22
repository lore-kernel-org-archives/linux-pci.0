Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFC1DED49
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863267; cv=none; b=JBnPrRWjyaKHnvSJymii+c8BeOHG7MbCosOcGFZmm6Q/4klEePyAQNuvghOrv5/9bn5qSMOCeLoIy8UpUJjCFYbgjeaHekwfi26LX6Leb7jxZp3SDnHot9ZuYBqVbpJoLtEe50tkEjmLNepkipaktL0L1qq9aHaoI9T61A6AOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863267; c=relaxed/simple;
	bh=E3VGs0lq3iNWy4t7vCZZ9C/Jqka/LhQBO3zDlgBsp40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X7LhkV1UO8X/KsX513etu9BJk2gnq+ukWvPRGXuK+xlgEFweBtwMqicsK6vGa9W7XniIzvmF6/unokK7WoQnfekG/+kgA5cf/EJDQouYN2wwTHvRyuhVTszGrrE7rtRm2RiI0T8VH2OUMEUG/yZJDymDq+ADCzSZ1Jn9BIDgJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UX9Lv3PE; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UX9Lv3PE"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g0zzD5LzFz9v0d;
	Wed, 22 Apr 2026 15:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776863256; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEeNUPL3mjPam1QKNhWHJx8B46rHXKTO/OThG/bAF+Y=;
	b=UX9Lv3PEFRE925CZn0ZO/jpenxnIWMsp7QQzPIEfOBBEisOa2+WM8Z0inSRhBdh+AUYHcM
	f//rYkF3O9gpfyHdgrv3eZyeQ27THo18KOLXMx1Mcm7NNa9+hI1VH0bLpnrSekkreXR7BU
	g1RfxP1TSDx1rdUvFfKZ/HueFHFcR2+31aPDm+jAEWd5pNYUao8sulezCRuZvFOI2RrlmO
	Fpxfce0/bEpx3yDuKtBROnVHdUs1V+ZMIIfpnKpQog1O1jkWjn9cF4cWoxdK4kpGZH6Uds
	+puCuIm5QXHBB3q/R0UPWMsXJ7nBt6GDIRcsn1ty9V/JEA5aFSxjt3VhtWSihA==
Message-ID: <42e31ebc86a34001e98aecc7197e5e5a8fd5bb03.camel@mailbox.org>
Subject: Re: [RESEND PATCH v3 1/3] PCI/MSI: Add Devres managed IRQ vectors
 allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, phasta@kernel.org, Bjorn Helgaas
	 <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
Date: Wed, 22 Apr 2026 15:07:32 +0200
In-Reply-To: <f912358d-925b-1e25-2852-1f265d09032a@rock-chips.com>
References: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
	 <1776825522-6390-2-git-send-email-shawn.lin@rock-chips.com>
	 <2c227e17a573c8c674c027c9b3014c2ec9ebfec7.camel@mailbox.org>
	 <f912358d-925b-1e25-2852-1f265d09032a@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 5rxsjayd9b53yxjuk8y57owsrxibscan
X-MBO-RS-ID: 6db456ed51e2682ecbb

On Wed, 2026-04-22 at 16:36 +0800, Shawn Lin wrote:
> Hi Philipp
>=20
> =E5=9C=A8 2026/04/22 =E6=98=9F=E6=9C=9F=E4=B8=89 15:32, Philipp Stanner =
=E5=86=99=E9=81=93:
> > On Wed, 2026-04-22 at 10:38 +0800, Shawn Lin wrote:
> > > The PCI/MSI subsystem suffers from a long-standing design issue where
> > > the implicit, automatic management of IRQ vectors by the devres
> >=20
> > nit:
> > The *automatic* handling is not actually the issue. All devres
> > interfaces (pcim_) are automatic by definition.
> >=20
> > The issue is the "sometimes managed, sometimes not" nature of some pci_
> > interfaces. I came to call those "hybrid functions".
> >=20
> > > framework conflicts with explicit driver cleanup, leading to ambiguou=
s
> > > ownership and potential resource management bugs.
> > >=20
> > > Historically, pcim_enable_device() not only manages standard PCI
> > > resources (BARs) via devres
> > >=20
> >=20
> > See cover-letter. As I said, that's not the case anymore. It was the
> > case once.
> >=20
> > I think you could just briefly state "Historically, some functions
> > exhibited this hybrid behavior, the last of which by now are =E2=80=A6"
> >=20
> > If you want you could maybe also Link: one=C2=A0 of my patch series's f=
or
> > the wider history.
> >=20
> > > but also implicitly sets the is_msi_managed
> > > flag if calling pci_alloc_irq_vectors*(). This registers pcim_msi_rel=
ease()
> > > as a cleanup action, creating a hybrid ownership model.
> >=20
> > nit:
> > s/ownership/responsibility
> >=20
> > >=20
> > > This ambiguity causes problems when drivers follow a common but
> > > hazardous pattern:
> > > 1. Using pcim_enable_device() (which implicitly marks IRQs as managed=
)
> > > 2. Explicitly calling pci_alloc_irq_vectors() for IRQ allocation
> > > 3. Also calling pci_free_irq_vectors() in error paths or remove routi=
nes
> > >=20
> > > In this scenario, the devres framework may attempt to free the IRQ
> > > vectors a second time upon device release, leading to double-free
> > > issues. Analysis of the tree shows this hazardous pattern exists
> > > in multiple drivers, while 35 other drivers correctly rely solely
> > > on the implicit cleanup.
> >=20
> > See cover-letter.
> >=20
> > I would leave that to Bjorn's preference, but I think that info is
> > useful for the cover letter so that reviewers get what's going on, but
> > it's not useful in the commit message. Your description of the
> > problematic API is justification enough IMO.
> >=20
> > >=20
> > > To resolve this ambiguity, introduce explicit managed APIs for IRQ
> > > vector allocation:
> > > - pcim_alloc_irq_vectors()
> > > - pcim_alloc_irq_vectors_affinity()
> > >=20
> > > These functions are the devres-managed counterparts to
> > > pci_alloc_irq_vectors[_affinity](). Drivers that wish to have
> > > devres-managed IRQ vectors should use these new APIs instead.
> > >=20
> > > The long-term goal is to convert all drivers which use pcim_enable_de=
vice()
> > > as well as pci_alloc_irq_vectors[_affinity]() to use these managed
> >=20
> > nit:
> > s/as well as/in combination with
> >=20
> > > functions, and eventually remove the problematic hybrid management
> > > pattern from pcim_enable_device() and pcim_setup_msi_release() entire=
ly.
> > > This patch lays the foundation by introducing the APIs.
> >=20
> > But in general reads very nice and is mostly spot-on :)
> >=20
> > >=20
> > > Suggested-by: Philipp Stanner <phasta@kernel.org>
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > >=20
> > > ---
> > >=20
> > > Changes in v3:
> > > - Rework the commit message and function doc (Philipp)
> > > - Remove setting is_msi_managed flag from new APIs (Philipp)
> > >=20
> > > Changes in v2:
> > > - Rebase
> > > - Introduce patches only for PCI subsystem to convert the API
> > >=20
> > > =C2=A0=C2=A0drivers/pci/msi/api.c | 47 ++++++++++++++++++++++++++++++=
+++++++++++++++++
> > > =C2=A0=C2=A0include/linux/pci.h=C2=A0=C2=A0 | 22 ++++++++++++++++++++=
++
> > > =C2=A0=C2=A02 files changed, 69 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> > > index c18559b..90b67f5 100644
> > > --- a/drivers/pci/msi/api.c
> > > +++ b/drivers/pci/msi/api.c
> > > @@ -297,6 +297,53 @@ int pci_alloc_irq_vectors_affinity(struct pci_de=
v *dev, unsigned int min_vecs,
> > > =C2=A0=C2=A0EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> > > =C2=A0=20
> > > =C2=A0=C2=A0/**
> > > + * pcim_alloc_irq_vectors - devres managed pci_alloc_irq_vectors()
> > > + * @dev: the PCI device to operate on
> > > + * @min_vecs: minimum number of vectors required (must be >=3D 1)
> > > + * @max_vecs: maximum (desired) number of vectors
> > > + * @flags: flags for this allocation, see pci_alloc_irq_vectors()
> > > + *
> > > + * This is a device resource managed version of pci_alloc_irq_vector=
s().
> > > + * Interrupt vectors are automatically freed on driver detach by the
> > > + * devres. Drivers do not need to explicitly call pci_free_irq_vecto=
rs().
> >=20
> > s/the devres/devres
> >=20
> > s/do not need/must not=C2=A0 <- You stated doing so would be a bug, rig=
ht?
> >=20
> > > + *
> > > + * Returns number of vectors allocated (which might be smaller than
> > > + * @max_vecs) on success, or a negative error code on failure.
> > > + */
> > > +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vec=
s,
> > > + =C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags)
> > > +{
> > > + return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> > > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> > > +}
> > > +EXPORT_SYMBOL(pcim_alloc_irq_vectors);
> > > +
> > > +/**
> > > + * pcim_alloc_irq_vectors_affinity - devres managed pci_alloc_irq_ve=
ctors_affinity()
> > > + * @dev: the PCI device to operate on
> > > + * @min_vecs: minimum number of vectors required (must be >=3D 1)
> > > + * @max_vecs: maximum (desired) number of vectors
> > > + * @flags: flags for this allocation, see pci_alloc_irq_vectors()
> > > + * @affd: optional description of the affinity requirements
> > > + *
> > > + * This is a device resource managed version of pci_alloc_irq_vector=
s_affinity().
> > > + * Interrupt vectors are automatically freed on driver detach by the=
 devres
> > > + * machinery. Drivers which use pcim_enable_device() as well as this=
 function,
> > > + * do not need to explicitly call pci_free_irq_vectors() currently.
> > > + *
> > > + * Returns number of vectors allocated (which might be smaller than
> > > + * @max_vecs) on success, or a negative error code on failure.
> > > + */
> > > +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned in=
t min_vecs,
> > > + =C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> > > + =C2=A0=C2=A0 struct irq_affinity *affd)
> > > +{
> > > + return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> > > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, affd);
> >=20
> > Hmmm, OK =E2=80=93 I am not thaaaat deep in the topic anymore, so corre=
ct me if
> > I am wrong. But to me it seems that we might have a problem.
> >=20
> > Your intention seems to be to rely on hybrid devres here, isn't it?
> >=20
>=20
> Yes, it's.
>=20
> > Because pci_alloc_irq_vectors_affinity() runs into
> > __pci_enable_msi(x)_range(), which runs into pci_setup_msi_context(),
> > which sets up the devres callbacks.
> >=20
> > And this would now mean that your new function here *also* is hybrid,
> > because it relies on pcim_enable_device() setting the flag, right?
> >=20
> > IOW, when someone called pci_enable_device(), your pcim_ function here
> > would NOT be a managed devres function. Right?
> >=20
> > That would obviously not fly. The current (and IMO) desirable design
> > goal for devres PCI is that pcim_ functions are ALWAYS managed (hence
> > the 'm' =3D managed, and pci_ functions are NEVER managed).
> >=20
> > I am sorry if / that I overlooked that while first glimpsing at your
> > previous versions.
> >=20
>=20
> Don't worry.
>=20
> >=20
> > IIRC for this reason I had to provide a completely unmanaged backend,
> > and to do so I actually had to *copy* existing functions from pci.c, so
> > for many months PCI contained two versions of the same functions.
> >=20
>=20
> I was trying to avoid copying the existing functions.
>=20
> There are some combinations here:
> 1. pcim_enable_device() + pci_alloc=C2=A0=C2=A0 -> correct
> 2. pcim_enable_device() + pci_alloc + pci_free=C2=A0 -> bug
> 3. pci_enable_device() + pci_alloc + pci_free -> correct
>=20
> To solve the 2nd case, I need to remove the hybird mode from
> pcim_enable_device(). So what I had in mind is to is :
>=20
> 1. keep pcim_alloc_irq_vectors() rely on pcim_enable_device(), still
> the hybrid mode as you pointed out.
> 2. convert pcim_enable_device() + pci_alloc_irq_vectors() users to
> pcim_enable_device() + pcim_alloc_irq_vectors(), which is the first
> above case. Meanwhile add documentation or code check to prevent new
> pci_enable_device() + pcim_alloc_irq_vectors() user from using it.
>=20
> 3. after conversions, we still have three combinations:
> - pcim_enable_device() + pcim_alloc()=C2=A0 -> correct
> - pcim_enable_device() + pci_alloc + pci_free=C2=A0 -> bug
> - pci_enable_device() + pci_alloc + pci_free=C2=A0=C2=A0 -> correct
>=20
> 4. Then remove pcim_setup_msi_release() from pci_setup_msi_context().
> And add pcim_setup_msi_release() to my new APIs. This way,
> - pcim_enable_device() + pcim_alloc()=C2=A0 -> correct
> - pcim_enable_device() + pci_alloc + pci_free=C2=A0 -> correct
> - pci_enable_device() + pci_alloc + pci_free=C2=A0=C2=A0 -> correct
>=20
> 5. remove the limitation of using pci_enable_device() + pcim_alloc, as
> mentioned in the 2nd above step. so we could allow this 4th pattern.
> Finally all things work fine.
>=20
> Please let me know if this approach works for you?

The biggest issue I see is that you add another hybrid function, even
if it's temporary. pcim_alloc_irq_vectors() will sometimes be managed
and sometimes not =E2=80=93 until you have removed all users of the
aforementioned functions, and finally performed step =E2=84=964 from above.

Note that even in the past, with the oldest, most broken version of the
PCI devres API, pcim_ functions were *always* managed, completely
independently from pci(m)_enable_device().

What pcim_enable_device() did was implicitly switch some pci_
functions, such as pci_request_regions(), into managed mode.

The solution presented / intended by you would rely on:
   1. New users of pcim_ being aware (through documentation for
      example) that this one pcim_ function is special and not always
      managed (for now).
   2. New users being nice and really using pcim_enable_device().
   3. You being able to fully see it all through to the end, i.e., you
      not being switched to a different project, switching jobs and
      opening a bar in Hawaii etc. etc.

My experience has, unfortunately, been that people often don't read
documentation, especially if they are already used to interfaces like
that working a certain way.
How many drivers are there to be ported, do you have a list and maybe a
time horizon? I took almost a year to remove my helper functions again.

That's not a hard "NACK" from my side, it's just I wouldn't do it like
that. I suppose it is for the maintainers to pick one of the two
solution pathways:

a) have another hybrid function temporarily or
b) have duplicated code temporarily

(where "temporarily" means until the contributor finishes the job :)


BTW, please keep in mind that in my opinion, once PCI/MSI is solved, I
believe that pcim_enable_device() should do nothing anymore but disable
the device on driver detach, without any other side effects.


Regards
P.

>=20
>=20
> > The reason was that the hybrid behavior was burried so deep in the
> > subsystem.
> >=20
> > See here:
> >=20
> > Here I had to reimplement some functions to be used by my new pcim_
> > functions:
> > https://lore.kernel.org/linux-pci/20240610093149.20640-4-pstanner@redha=
t.com/
> >=20
> >=20
> > And here I could finally remove them later:
> > https://lore.kernel.org/linux-pci/20250519112959.25487-7-phasta@kernel.=
org/
> >=20
> >=20
> > I hope this helps. And again sorry for potentially causing you
> > unnecessary work :(
> >=20
> >=20
> > Regards
> > Philipp
> >=20
> >=20
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
> > > =C2=A0=C2=A0 =C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> > > =C2=A0=C2=A0 =C2=A0=C2=A0 struct irq_affinity *affd);
> > > =C2=A0=20
> > > +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vec=
s,
> > > + =C2=A0 unsigned int max_vecs, unsigned int flags);
> > > +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned in=
t min_vecs,
> > > + =C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> > > + =C2=A0=C2=A0 struct irq_affinity *affd);
> > > +
> > > =C2=A0=C2=A0bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
> > > =C2=A0=C2=A0struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev,=
 unsigned int index,
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 const struct irq_affinity_desc =
*affdesc);
> > > @@ -1812,6 +1818,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, uns=
igned int min_vecs,
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +static inline int
> > > +pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int mi=
n_vecs,
> > > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsigne=
d int flags,
> > > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_affinity *aff_desc)
> > > +{
> > > + return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> > > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, aff_desc);
> > > +}
> > > +static inline int
> > > +pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> > > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsigned int =
flags)
> > > +{
> > > + return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> > > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, NULL);
> > > +}
> > > +
> > > =C2=A0=C2=A0static inline bool pci_msix_can_alloc_dyn(struct pci_dev =
*dev)
> > > =C2=A0=C2=A0{ return false; }
> > > =C2=A0=C2=A0static inline struct msi_map pci_msix_alloc_irq_at(struct=
 pci_dev *dev, unsigned int index,
> >=20
> >=20

