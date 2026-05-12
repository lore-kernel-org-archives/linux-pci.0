Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB837C917
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592512; cv=none; b=IyeDk4JY6imTJJ3HH3bNzVjzjFv2CVYQrxUqY6heJdcEMKNY1BflLu4PBRNhC4LQmgO5XV3Om00BmmPhF8iJq5AG7fhrm7Ymb3TJwvnSUEEJ4AsDgkgokjLPSxPrSENPyCH2ZQdeRyZ0H1qJUdOaGvc7x1cHLbgOZSPRH0vQ1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592512; c=relaxed/simple;
	bh=yIiVK1T3FAAQiAh3sp1XgyZQCA7MMuMyr+6wiiABQeg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPZ3Ao2dJDlSbQDL/pv7a+/WTP0x8JLFsji4MtXIPh7wsrtH+GiX2YrjFQXZufIIMJ3nwJ4PZo6EanBbChjqVXe8Y0LdxA5MgbtcEZFbNYtDl1ZRSobVdx5FZkzs4HqpJq8r7aravk+Af8Mbx3dIdgVYYcGA29Q3DOyGAUidhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LQ+2Rr97; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LQ+2Rr97"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gFHTx0z45z9vHM;
	Tue, 12 May 2026 15:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778592501; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFQVW3C2zZ8UnxQwxrQ7SLfCMsFxRwa+IsrHeD666I4=;
	b=LQ+2Rr97yQ/Dcql7EmUiL+F0elE4KGjKyyd7F9DShMrFzy8PMRPsdyV8vMQu8FYAJa5NS5
	Rd4zxuEpB4+uJbqwm7P56/ySNWP9ba1/VQhVNzKup6pqBNah0YCA0m1Z5xi8xcOS0gD5T9
	K+4wm+4KOsDvknLNBjZm/PHr1vGr8JBVW9t0StVlqetcZK1yvn46tDM+iBfuH8reDfK4Yg
	i/h7a2Py8Uy1Uc+iYmkkn4d2hxh1E5jSW0XgWApKvGOfqwY42hFNHsEBPWJZbKD/XFVLEO
	4p1Vwrup5fpsyxnsptO5g6oGO0xfCjEcHesZOMURHQIDVkLlG8gyEsGkuKZDww==
Message-ID: <a608578c7818cd25df79c1c76fed3486d747e1af.camel@mailbox.org>
Subject: Re: [PATCH v4 5/7] PCI/MSI: Add Devres managed IRQ vectors
 allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Tue, 12 May 2026 15:28:17 +0200
In-Reply-To: <1777017460-243543-6-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
	 <1777017460-243543-6-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: o8tp7ajawszhd9ashfgtckbhhpd73eqg
X-MBO-RS-ID: 7b5368d078e698a0201

On Fri, 2026-04-24 at 15:57 +0800, Shawn Lin wrote:
> There is a long-standing design ambiguity in the PCI/MSI subsystem
> regarding the management of IRQ vectors. Currently, the management
> operates in a "hybrid" mode. Sometimes it's handled by devres but
> sometimes not, creating potential for resource management bugs.
>=20
> Historically, pcim_enable_device() implicitly triggers automatic IRQ
> vector management when calling pci_alloc_irq_vectors[_affinity], as
> pcim_enable_device() sets the is_managed flag, thus pcim_msi_release()
> will register a cleanup action. However, using pci_enable_device()
> will not make pci_alloc_irq_vectors[_affinity] register a cleanup
> action.
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
> in multiple drivers, while 37 other drivers correctly rely solely
> on the implicit cleanup.
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
> in combination with pci_alloc_irq_vectors[_affinity]() to use these manag=
ed
> functions, and eventually remove the problematic hybrid management
> pattern from pcim_enable_device() and pcim_setup_msi_release() entirely.
> This patch lays the foundation by introducing the APIs.

Cool stuff.


Though what I'd also do is to warn somewhere about the current API
being hybrid and fishy and therefore users should be careful with
pcim_enable_device().
That's not the case right now, is it?


Regards
P.

>=20
> Suggested-by: Philipp Stanner <phasta@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
> ---
>=20
> Changes in v4:
> - Rework to create dedicated devres-managed function (Philipp)
>=20
> Changes in v3:
> - Rework the commit message and function doc (Philipp)
> - Remove setting is_msi_managed flag from new APIs (Philipp)
>=20
> Changes in v2:
> - Rebase
> - Introduce patches only for PCI subsystem to convert the API
>=20
> =C2=A0drivers/pci/msi/api.c | 84 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A0include/linux/pci.h=C2=A0=C2=A0 | 22 ++++++++++++++
> =C2=A02 files changed, 106 insertions(+)
>=20
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index c18559b..405da7b 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -297,6 +297,90 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *d=
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
> + * Interrupt vectors are automatically freed on driver detach by devres.
> + * Drivers MUST NOT call pci_free_irq_vectors().
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
> + * Interrupt vectors are automatically freed on driver detach by devres.
> + * Drivers MUST NOT call pci_free_irq_vectors().
> + *
> + * Returns number of vectors allocated (which might be smaller than
> + * @max_vecs) on success, or a negative error code on failure.
> + */
> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int mi=
n_vecs,
> +				=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> +				=C2=A0=C2=A0=C2=A0 struct irq_affinity *affd)
> +{
> +	struct irq_affinity msi_default_affd =3D {0};
> +	int nvecs =3D -ENOSPC;
> +
> +	if (flags & PCI_IRQ_AFFINITY) {
> +		if (!affd)
> +			affd =3D &msi_default_affd;
> +	} else {
> +		if (WARN_ON(affd))
> +			affd =3D NULL;
> +	}
> +
> +	if (flags & PCI_IRQ_MSIX) {
> +		nvecs =3D __pcim_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> +						 affd, flags);
> +		if (nvecs > 0)
> +			return nvecs;
> +	}
> +
> +	if (flags & PCI_IRQ_MSI) {
> +		nvecs =3D __pcim_enable_msi_range(dev, min_vecs, max_vecs, affd);
> +		if (nvecs > 0)
> +			return nvecs;
> +	}
> +
> +	/* use INTx IRQ if allowed */
> +	if (flags & PCI_IRQ_INTX) {
> +		if (min_vecs =3D=3D 1 && dev->irq) {
> +			/*
> +			 * Invoke the affinity spreading logic to ensure that
> +			 * the device driver can adjust queue configuration
> +			 * for the single interrupt case.
> +			 */
> +			if (affd)
> +				kfree(irq_create_affinity_masks(1, affd));
> +			pci_intx(dev, 1);
> +			return 1;
> +		}
> +	}
> +
> +	return nvecs;
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
> index 2c44545..6eab553 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1770,6 +1770,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev =
*dev, unsigned int min_vecs,
> =C2=A0				=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> =C2=A0				=C2=A0=C2=A0 struct irq_affinity *affd);
> =C2=A0
> +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +			=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags);
> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int mi=
n_vecs,
> +				=C2=A0=C2=A0=C2=A0 unsigned int max_vecs, unsigned int flags,
> +				=C2=A0=C2=A0=C2=A0 struct irq_affinity *affd);
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

