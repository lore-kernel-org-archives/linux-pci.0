Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48755383986
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592372; cv=none; b=nggZobrAJDc0BW5ddZ2Kq3SgUi6P2Z1rAf5JqNWIjKawjDAK/yErM0Vc66sgOqiTsha9B0fNkyELqcGVbXR3mqid61zFG2jWiXF/05m2CWubgfjnPY45+6UoUBKdhvjRkfba559rfZbDQQx0hKnqSnmZt4BA31jgurDXwEqXcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592372; c=relaxed/simple;
	bh=lHaAg/49p3Hnpa/UhIqJB38hpeP/7+IkMxw02qU8whA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4cn3qlhQfxk26PpDhH7XokbwxRgR+OGT3LEx4UpeJc8RSMODq04xGoUXg+Zd6eKscqvUd6zC6WQ24IG7LP3cZeBR6biV6l6MJlmpAfdY6c81sUCWCN74MieMosfEX061f5opVVxTY5XmZXJ4Tft8KJBKvxC73amq6KsKkxJB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D4F9eNfp; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D4F9eNfp"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gFHRM6BGYz9ttC;
	Tue, 12 May 2026 15:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778592367; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgUehIJtWSrqShxnCXqkAFiccdaaJ1oL8KTJ9x4nj0Y=;
	b=D4F9eNfpZx2rAGlH0fDH3H7c5FS3q2I741o2CH2XNOBe7JSVGAWDNCy3Ohr47NzLySFCrX
	shREGUnNtLsEyw9eQbcBi0SKwAmqJnA/bbfJEiwel1hRUNhBhd4GDQEf3Asy+2Hz37CaI0
	DvDDhXrsMzzy4BOLQ3MrnAh2R0yJ+ebRMKNb4X5HH2kioymS1KiIC1BLW9mQu6aqQni0EN
	7VeOQgzUm95mmDQV51+yQVJCga6J35T/jEiSYmOR2MKGLpDE8am018XBCreLcn5lVh5b5Q
	4OdxRo7V8FHhM6JU/lQN/H2tZPt8AQ9xuH2iR4LhMoB+gxN9rK/6CYjq/uDmkg==
Message-ID: <c133ec95f31874624349d38f67362bc5589fb80f.camel@mailbox.org>
Subject: Re: [PATCH v4 4/7] PCI/MSI: Introduce __pcim_enable_msix_range()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Tue, 12 May 2026 15:26:00 +0200
In-Reply-To: <1777017460-243543-5-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
	 <1777017460-243543-5-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 3ty19d58rpczd9ewd9j3176m5orf3wup
X-MBO-RS-ID: 3915287758bcc66bcba

On Fri, 2026-04-24 at 15:57 +0800, Shawn Lin wrote:
> Introduce __pcim_enable_msix_range(), a devres-managed variant of
> __pci_enable_msix_range(). Similar to the previously added MSI variant,
> this function provides automatic cleanup of MSI-X interrupts via devres,
> reducing the risk of resource leaks and simplifying driver error handling=
.
>=20
> This function is particularly useful for drivers that already use
> pcim_enable_device() and want consistent devres management for all
> PCI resources, including MSI-X interrupts.
>=20
> Drivers can replace calls to __pci_enable_msix_range() with
> __pcim_enable_msix_range() to benefit from automatic cleanup without
> changing their core logic. The flags parameter (e.g., PCI_IRQ_VIRTUAL)
> is fully supported and passed through to the underlying functions.
>=20
> This completes the set of devres-managed MSI/MSI-X allocation functions,
> providing a consistent API for driver authors who prefer automatic
> resource management.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>=20
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>=20
> =C2=A0drivers/pci/msi/msi.c | 22 ++++++++++++++++++++++
> =C2=A0drivers/pci/msi/msi.h |=C2=A0 2 ++
> =C2=A02 files changed, 24 insertions(+)
>=20
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 0aaff57..8fdf40d 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -930,6 +930,28 @@ int __pci_enable_msix_range(struct pci_dev *dev, str=
uct msix_entry *entries,
> =C2=A0	return pci_msix_range_init(dev, entries, minvec, nvec, hwsize, aff=
d);
> =C2=A0}
> =C2=A0
> +int __pcim_enable_msix_range(struct pci_dev *dev, struct msix_entry *ent=
ries,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int minvec, int maxvec, struct irq_affinity =
*affd,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int flags)
> +{
> +	int hwsize, nvec, rc;
> +
> +	hwsize =3D pci_msix_range_alloc(dev, entries, minvec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxvec, flags, &nvec);
> +	if (hwsize < 0)
> +		return hwsize;
> +
> +	rc =3D msi_setup_device_data(&dev->dev);

Uh uh... wait a second.

msi_setup_device_data() also invokes devres below the surface:

int msi_setup_device_data(struct device *dev)
{
	struct msi_device_data *md;
	int ret, i;

	if (dev->msi.data)
		return 0;

	md =3D devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);


Do you have an idea whether that is a problem?

Looks suspicious to me. That's more than just automatic memory
management.


Sorry for just seeing that now. I might have seen that last year and
concluded it's one of the reasons why porting is difficult.. can't
remember anymore.


P.


> +	if (rc)
> +		return rc;
> +
> +	rc =3D devm_add_action(&dev->dev, pcim_msi_release, dev);
> +	if (rc)
> +		return rc;
> +
> +	return pci_msix_range_init(dev, entries, minvec, nvec, hwsize, affd);
> +}
> +
> =C2=A0void __pci_restore_msix_state(struct pci_dev *dev)
> =C2=A0{
> =C2=A0	struct msi_desc *entry;
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 81c6b099..e6364a8 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -97,6 +97,8 @@ int __pci_enable_msi_range(struct pci_dev *dev, int min=
vec, int maxvec, struct i
> =C2=A0int __pcim_enable_msi_range(struct pci_dev *dev, int minvec, int ma=
xvec, struct irq_affinity *affd);
> =C2=A0int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry =
*entries, int minvec,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int maxvec,=C2=A0 struct irq_affinity *affd, =
int flags);
> +int __pcim_enable_msix_range(struct pci_dev *dev, struct msix_entry *ent=
ries, int minvec,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int maxvec,=C2=A0 struct irq_affinity *affd,=
 int flags);
> =C2=A0void __pci_restore_msi_state(struct pci_dev *dev);
> =C2=A0void __pci_restore_msix_state(struct pci_dev *dev);
> =C2=A0

