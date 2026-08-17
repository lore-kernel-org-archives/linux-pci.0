Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DE470458
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997525; cv=none; b=eeJTYzuhqbmIW2VNYSxOQ238LMZIB4gUfVQNzCQlpimWcBhYOYo2OryKUs1YdGWNwcEs1CnBW2glVQ7a6ZXNsxVcPjGeyMjallmhGO2zcm/QJZQkFeo6x3uWcEmjCjVykXlxiMaieEL0XpRBEYIEIQyfqyoE02N0UdH7UtRCUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997525; c=relaxed/simple;
	bh=oOj5Dl4AHOnjR2t4aklUFzjoVVM+DjvlkDpPc+6RDIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lsElfzA5vdk6+NH6RPl+ob2X6Qdy61D29Rdpudi3mX54insL1d+qMjvQRz1VwTZSVvoq8Ru3Br/LAJEgwnKLhWRP+e+WWzxCMJCZFEqju5O9q61NLdQOt9Mf5mAO09o4Z14RwTwoa9TAluHEEZrb6Wop2Di9nrmbh+OtKK7vNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0u0jdyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0u0jdyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B9E1F00A3A;
	Mon, 17 Aug 2026 20:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786997523;
	bh=iDAa8RFhn14bdLpr1zlBDQ1O+IkyNFbCRYx1oSck308=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0u0jdyZfKG5O+xb22HzNz9oc2dqkpNTxEdEzulDV66sbvIzHhjjICnCtuujD8xvX
	 ThcymCuj5EJYNbwqBUdJR/ghZNOtO4v9dXkHqZb3a76A3t84kUmI90cAW3BJNBkJ+t
	 f1JcGMm32IDh06tjoaXt9w83hv2rbsANjkOJqb1j/taOZkvnDV6V+VtzqHswZBvPZk
	 9J0mfcM2gSdrs44+lMcTmbAkuR8Alzm9mAMqUNrjQLSSBRAp070BzI6gQRqaDIzr9v
	 mHG/IUodisDHzZdDXQcwh/evGehU4v95igfahtZyibiD/vib7MBMNJNdp6LJkK1RNv
	 1t238XEOTuO4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] PCI/MSI: Don't touch the MSI-X table while the Link
 is contained
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260817195626.3091331-1-vidyas@nvidia.com>
References: <20260817195626.3091331-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 20:12:02 +0000
Message-Id: <20260817201203.34B9E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected `readl()` operations in `pci_msix_write_tph_tag()`, `_=
_pci_read_msi_msg()`, and `msix_prepare_msi_desc()` circumvent the MSI-X MM=
IO containment fix.
--

--- Patch [1]: [PATCH V1] PCI/MSI: Don't touch the MSI-X table while the Li=
nk is contained ---
commit aba17efd26855fb96d48aa82a9f367120d469a3f
Author: Vidya Sagar <vidyas@nvidia.com>

PCI/MSI: Don't touch the MSI-X table while the Link is contained

The MSI-X table lives in device MMIO space behind a BAR, so it is only
reachable while the Link is up. While a Downstream Port has the Link
contained by DPC it completes accesses to the table with Unsupported
Request, and the read returns all ones.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 209373c92e9e1..5612cf2ff2800 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -249,7 +249,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, stru=
ct msi_msg *msg)
>  {
>  	struct pci_dev *dev =3D msi_desc_to_pci_dev(entry);
> =20
> -	if (dev->current_state !=3D PCI_D0 || pci_dev_is_disconnected(dev)) {
> +	if (dev->current_state !=3D PCI_D0 || pci_msix_mmio_unsafe(dev)) {
>  		/* Don't touch the hardware now */
>  	} else if (entry->pci.msi_attrib.is_msix) {
>  		pci_write_msg_msix(entry, msg);
> [ ... ]
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 0b420b319f50f..e372e9c875087 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> [ ... ]
> +/*
> + * The MSI-X Table lives in device MMIO space, so it is only reachable w=
hile
> + * the Link is usable. While a Downstream Port has the Link contained by=
 DPC
> + * it completes these accesses with Unsupported Request, which the Root =
Port
> + * in turn reports as an RP PIO error and answers with a DPC of its own,
> + * taking down every other device below it.
> + */
> +static inline bool pci_msix_mmio_unsafe(struct pci_dev *pdev)
> +{
> +	return pdev->error_state !=3D pci_channel_io_normal ||
> +	       pci_dev_is_disconnected(pdev);
> +}

[Severity: High]
This is a pre-existing issue, but could this regression still occur through
other unprotected MSI-X MMIO accesses?

While this patch successfully shields the vector control write inside
pci_msix_write_vector_ctrl() using this new check, there appear to be
unprotected readl() operations that still bypass it.

For example, in drivers/pci/msi/msi.c:pci_msix_write_tph_tag():

    FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);
    pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
    /* Flush the write */
    readl(pci_msix_desc_addr(msi_desc));

The flush readl() is unconditional. It bypasses the safety check and
would complete with an Unsupported Request if the link is contained.

Similarly, in drivers/pci/msi/msi.c:__pci_read_msi_msg():

    msg->address_lo =3D readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
    msg->address_hi =3D readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
    msg->data =3D readl(base + PCI_MSIX_ENTRY_DATA);

And in drivers/pci/msi/msi.c:msix_prepare_msi_desc():

    if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
        writel(0, addr + PCI_MSIX_ENTRY_DATA);
    desc->pci.msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);

If an IRQ affinity rebalancing event triggers a TPH tag update while
the link is contained, or if the link becomes contained concurrently
during MSI-X initialization, won't these unprotected accesses still
escalate to a Root Port PIO error and trigger a DPC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817195626.3091=
331-1-vidyas@nvidia.com?part=3D1
