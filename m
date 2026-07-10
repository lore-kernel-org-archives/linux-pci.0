Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655B3BFE47
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719455; cv=none; b=lUUBfJjHyl2qsL5ZDHSPbsZ4r2h9ZwpQMDH+luYZ91j2dV7jq9cIP+9iauzAufO8rV6l1y09WhaS9WHFU8Xjv7gGKlLReHRQSOvglo4Cjl8O46UECtnQuH+o5D3TOqm8r9PAmrbhyZ+MUpfRXHq1eD8O0OBwlCTVM7TiyX8E7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719455; c=relaxed/simple;
	bh=uyiOuJHT80NMMd8HYiC9bsF2mnSRT19McqEZIpeI1Lo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TK2xe1crgIVFVSkwTDiVvcHurIYvSAgoTQ1H2SiILHqD5bjk7lVanC04SpK/rpqaaW5jZcvgDUtRnPaFRo4PK7Idj0pAfECxtDoiMlQySyBy12VIf1rEQfAZJ9v3YbwUo5BoaAJ5lI8H8jrKxB0Xsqt8fOY69kdk3XeT0XBDRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARam3pBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARam3pBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A461F000E9;
	Fri, 10 Jul 2026 21:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719453;
	bh=utJV8EcY8oaF/W0cxmO+28jyTVKBq8XN6QCIson4Fdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARam3pBSsHqpCKl3bleXXucvHjuT0a5L77Xdr3j9pfGk7zW/V4dPNvNEd9rUfkHEV
	 im9okj57094KWX+zrYY1iuX9RiQiP3l8/FENJIiqmQO0k5wWcdnHMluKxbm6lYcSid
	 1qxJV5ohULa/FXvVOty0OFclWEg/TzIm7t+YMaXEQIKoE1t1az/WTeGG4gWEXJuJdm
	 baNoscYjc5Q7CLRJLwygecFX61f/ZNCI+09jCUJFKHSWd7aI/umz4ghTi0LAnG+S18
	 Nh5kVj5G+DN8v/oJfYR2w9+kmStwzgvcy3rBpXz1ueO10Oq2duomr7owfibUCBqoeY
	 D/VlWs+Wr+n7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-10-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:37:33 +0000
Message-Id: <20260710213733.B4A461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data race on the `ari_enabled` bitfield of the bridge device.
--

--- Patch [9]: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Ena=
ble on preserved bridges ---
commit dba41feb80b848815c664a662c635fefb4ca7403
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges

This commit inherits the ARI Forwarding Enable on preserved bridges during a
Live Update. It updates the pci_dev->ari_enabled flag so preserved devices
can be identified with the expanded 8-bit function number.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a95bfe5eff770..74a11e520f0d3 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  	return 0;
>  }
> =20
> +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> +	dev->ari_enabled =3D !!(val & PCI_EXP_DEVCTL2_ARI);

[Severity: Medium]
Can this bitfield modification race with concurrent updates to other
bitfields in the same word?

In pci_liveupdate_configure_ari(), dev->ari_enabled is updated. Since
bitfield modifications compile to read-modify-write operations on the
underlying word, concurrent updates to other flags in the same word (like
is_busmaster, is_managed, or msi_enabled) could be silently lost.

The pci_liveupdate.rwsem protects liveupdate structures but does not appear
to provide mutual exclusion for the pci_dev bitfields.

> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 739ecaab2e76f..e0c133b66a359 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
>  	if (!(cap & PCI_EXP_DEVCAP2_ARI))
>  		return;
> =20
> +	if (!pci_liveupdate_configure_ari(bridge))
> +		return;
> +
> +	if (pcie_ari_disabled)
> +		return;
> +
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_ARI);
>  		bridge->ari_enabled =3D 1;

[Severity: Medium]
This isn't a bug introduced by this patch, but this preexisting fallback
path in pci_configure_ari() also modifies the bridge->ari_enabled bitfield.

Could this also be susceptible to the same read-modify-write data race
against other flags in the same word?

>  	} else {
>  		pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D9
