Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF4372686
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843178; cv=none; b=cL3aTWM4LbDKCT6sl2b22j4B1cX4P3cAt5HL2XcwikpWWY3okvUIdDwLwQvOLoW0lfUE/cehekGOdVRvAA7bQPL4cEhqkYjgeONvlbN72752rgEC/FAQe+grNudyVBZvfK5xPGQKzdRBCS9L51sbn21j2HGVPTJqVNherOvyZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843178; c=relaxed/simple;
	bh=TtlmjlZQkDPNoPXa/3BrCuSHHq6ZI9/s7vLSNlC348k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vAsbMQq7GiKQRRN4kBLo8w29N1cEzmiu0tDj83IQ1htgf84o6Ka1XT9Bi8Vc278/cR5JHj5TMZCDtFa+50ZyUcd7fE7bWawT0sfBe7l+kPzNYUGmJXl/R4O1AiMcSbOXj7rlY+Z1jncmyAm+FrtmtY/TnS/eboXewMyjAtjyOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IfBK0mrl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IfBK0mrl"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g0rY0010Tz9thQ;
	Wed, 22 Apr 2026 09:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776843172; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSX2IL12VUjIo/4sxCIjIJEvYBv92skLShm6AFvblI8=;
	b=IfBK0mrlA4DyH+FQBQDIjBr5AhGimZU+F/kpF41GLOUwqVjbEpDbhMeXeSNwSm8OtmJ7bN
	nP2mkAvtS63BUL1CjEVMLiRMUuJWDNwpIHRBmI8i99UJkz/0zrYoaIjgysgzCiGhz8mZAh
	XOq0KJaM0f4FwS5lsppbwh5quUqyBGxwkQhObZXmvl+NgwjEpKhLfDRRDBZv4kXk7tFgL8
	idwr/FtvoF6Pqjav3s6iLHiShLiC/4EBd8JbYeODaiuhzXiJSHjTRXgquXJGb6/Lhudunf
	OTFHoaU7HdIoKOCheyYOOoOZkw4Ae/aVMQi9YR+gr2KbFaPz/6imuPl/lVg7FQ==
Message-ID: <2c227e17a573c8c674c027c9b3014c2ec9ebfec7.camel@mailbox.org>
Subject: Re: [RESEND PATCH v3 1/3] PCI/MSI: Add Devres managed IRQ vectors
 allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Wed, 22 Apr 2026 09:32:48 +0200
In-Reply-To: <1776825522-6390-2-git-send-email-shawn.lin@rock-chips.com>
References: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
	 <1776825522-6390-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 616a2858c946addfe3e
X-MBO-RS-META: e66sd9umwpdgm9mdqzq7hpkux8qqbgy8

On Wed, 2026-04-22 at 10:38 +0800, Shawn Lin wrote:
> The PCI/MSI subsystem suffers from a long-standing design issue where
> the implicit, automatic management of IRQ vectors by the devres

nit:
The *automatic* handling is not actually the issue. All devres
interfaces (pcim_) are automatic by definition.

The issue is the "sometimes managed, sometimes not" nature of some pci_
interfaces. I came to call those "hybrid functions".

> framework conflicts with explicit driver cleanup, leading to ambiguous
> ownership and potential resource management bugs.
>=20
> Historically, pcim_enable_device() not only manages standard PCI
> resources (BARs) via devres=C2=A0
>=20

See cover-letter. As I said, that's not the case anymore. It was the
case once.

I think you could just briefly state "Historically, some functions
exhibited this hybrid behavior, the last of which by now are =E2=80=A6"

If you want you could maybe also Link: one  of my patch series's for
the wider history.

> but also implicitly sets the is_msi_managed
> flag if calling pci_alloc_irq_vectors*(). This registers pcim_msi_release=
()
> as a cleanup action, creating a hybrid ownership model.

nit:
s/ownership/responsibility

>=20
> This ambiguity causes problems when drivers follow a common but
> hazardous pattern:
> 1. Using pcim_enable_device() (which implicitly marks IRQs as managed)
> 2. Explicitly calling pci_alloc_irq_vectors() for IRQ allocation
> 3. Also calling pci_free_irq_vectors() in error paths or remove routines
>=20
> In this scenario, the devres framework may attempt to free the IRQ
> vectors a second time upon device release, leading to double-free
> issues. Analysis of the tree shows this hazardous pattern exists
> in multiple drivers, while 35 other drivers correctly rely solely
> on the implicit cleanup.

See cover-letter.

I would leave that to Bjorn's preference, but I think that info is
useful for the cover letter so that reviewers get what's going on, but
it's not useful in the commit message. Your description of the
problematic API is justification enough IMO.

>=20
> To resolve this ambiguity, introduce explicit managed APIs for IRQ
> vector allocation:
> - pcim_alloc_irq_vectors()
> - pcim_alloc_irq_vectors_affinity()
>=20
> These functions are the devres-managed counterparts to
> pci_alloc_irq_vectors[_affinity](). Drivers that wish to have
> devres-managed IRQ vectors should use these new APIs instead.
>=20
> The long-term goal is to convert all drivers which use pcim_enable_device=
()
> as well as pci_alloc_irq_vectors[_affinity]() to use these managed

nit:
s/as well as/in combination with

> functions, and eventually remove the problematic hybrid management
> pattern from pcim_enable_device() and pcim_setup_msi_release() entirely.
> This patch lays the foundation by introducing the APIs.

But in general reads very nice and is mostly spot-on :)

>=20
> Suggested-by: Philipp Stanner <phasta@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
> ---
>=20
> Changes in v3:
> - Rework the commit message and function doc (Philipp)
> - Remove setting is_msi_managed flag from new APIs (Philipp)
>=20
> Changes in v2:
> - Rebase
> - Introduce patches only for PCI subsystem to convert the API
>=20
> =C2=A0drivers/pci/msi/api.c | 47 ++++++++++++++++++++++++++++++++++++++++=
+++++++
> =C2=A0include/linux/pci.h=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
> =C2=A02 files changed, 69 insertions(+)
>=20
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index c18559b..90b67f5 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -297,6 +297,53 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *d=
ev, unsigned int min_vecs,
> =C2=A0EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> =C2=A0
> =C2=A0/**
> + * pcim_alloc_irq_vectors - devres managed pci_alloc_irq_vectors()
> + * @dev: the PCI device to operate on
> + * @min_vecs: minimum number of vectors required (must be >=3D 1)
> + * @max_vecs: maximum (desired) number of vectors
> + * @flags: flags for this allocation, see pci_alloc_irq_vectors()
> + *
> + * This is a device resource managed version of pci_alloc_irq_vectors().
> + * Interrupt vectors are automatically freed on driver detach by the
> + * devres. Drivers do not need to explicitly call pci_free_irq_vectors()=
.

s/the devres/devres

s/do not need/must not  <- You stated doing so would be a bug, right?

> + *
> + * Returns number of vectors allocated (which might be smaller than
> + * @max_vecs) on success, or a negative error code on failure.
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
> + * pcim_alloc_irq_vectors_affinity - devres managed pci_alloc_irq_vector=
s_affinity()
> + * @dev: the PCI device to operate on
> + * @min_vecs: minimum number of vectors required (must be >=3D 1)
> + * @max_vecs: maximum (desired) number of vectors
> + * @flags: flags for this allocation, see pci_alloc_irq_vectors()
> + * @affd: optional description of the affinity requirements
> + *
> + * This is a device resource managed version of pci_alloc_irq_vectors_af=
finity().
> + * Interrupt vectors are automatically freed on driver detach by the dev=
res
> + * machinery. Drivers which use pcim_enable_device() as well as this fun=
ction,
> + * do not need to explicitly call pci_free_irq_vectors() currently.
> + *
> + * Returns number of vectors allocated (which might be smaller than
> + * @max_vecs) on success, or a negative error code on failure.
> + */
> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int mi=
n_vecs,
> +				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> +				=C2=A0=C2=A0 struct irq_affinity *affd)
> +{
> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags, affd);

Hmmm, OK =E2=80=93 I am not thaaaat deep in the topic anymore, so correct m=
e if
I am wrong. But to me it seems that we might have a problem.

Your intention seems to be to rely on hybrid devres here, isn't it?

Because pci_alloc_irq_vectors_affinity() runs into
__pci_enable_msi(x)_range(), which runs into pci_setup_msi_context(),
which sets up the devres callbacks.

And this would now mean that your new function here *also* is hybrid,
because it relies on pcim_enable_device() setting the flag, right?

IOW, when someone called pci_enable_device(), your pcim_ function here
would NOT be a managed devres function. Right?

That would obviously not fly. The current (and IMO) desirable design
goal for devres PCI is that pcim_ functions are ALWAYS managed (hence
the 'm' =3D managed, and pci_ functions are NEVER managed).

I am sorry if / that I overlooked that while first glimpsing at your
previous versions.


IIRC for this reason I had to provide a completely unmanaged backend,
and to do so I actually had to *copy* existing functions from pci.c, so
for many months PCI contained two versions of the same functions.

The reason was that the hybrid behavior was burried so deep in the
subsystem.

See here:

Here I had to reimplement some functions to be used by my new pcim_
functions:
https://lore.kernel.org/linux-pci/20240610093149.20640-4-pstanner@redhat.co=
m/


And here I could finally remove them later:
https://lore.kernel.org/linux-pci/20250519112959.25487-7-phasta@kernel.org/


I hope this helps. And again sorry for potentially causing you
unnecessary work :(


Regards
Philipp


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

