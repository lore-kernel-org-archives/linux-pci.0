Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969A3F39EF
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527040; cv=none; b=j66ZZuBYH3axhBIquFvquRXG2bOfuiiZI+ltkqnQ5D5T/nOchnAn4tV88tb1ienqmEu3YDi6vDm03/Ok8BdGs1aiZhVaeJfTIILZf5lvrETxMClSEE+q+Ifq/B3UI0EOtY+pmv4uq4ZTt/0Z5AHOaDizhumpv76lVEWHZdvSs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527040; c=relaxed/simple;
	bh=6TVQ+e4xUjvhvekDZkoZyJgF0KtC44K8LN6400wPwRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZNXeGUNP/Hd8gLYwoZGoiOZqtalCCxKUM71gf64nbjFhxT8cLzS/wrRtkzqoZhsCr6v/UHQeu8F88wKTvWd6CCmNPSiEKMs12kPKEUWdWpXq964vwvegaCigHwVyB/zBOfRNZqMwCYpYdsvJp/BqWVthGYFEfMtrLbnDmKjYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3q6fiUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3q6fiUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2361F000E9;
	Mon, 15 Jun 2026 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527037;
	bh=xmVu66zvAjk1qB8pQEr/rKhD5pnTW6CxrkTlJCYcraU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f3q6fiUiMcRqOpsotUI9nH759iHP/soJNBP0GM80/cgs16hHg7W6dos+InqvBU0jx
	 OpfcC60haky6NYQbzihor5JyZSt3tZ0XHI3waS7LER8KPdKJC+Uj/lEUxLHwq4fu3n
	 rAuXqhMh/xJDAqbuMLKJ8xtUGoXrks58ag28ZWpt/0+MmCm9chdWCFuLD4SWTXgB57
	 4WmLggUuRIyJMR5TUU9PElzPoxen3iv8Sc1aHAE6b4AFX6/1KesvtIq1JQa5nhjC5s
	 yYKGtTEq2sXE3lLN/x0Cb3muI1oJ+43GknhuQl3Klbj0onng5bSykwmbuXn9cZsuRj
	 eTWwnU5pqbVzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] ALSA: hda: Add support for Hygon family 18h
 model 5h HD-Audio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fu Hao" <fuhao@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8b38f2941375553e4246167736c6acb5a541e833.1781523812.git.fuhao@open-hieco.net>
References: <8b38f2941375553e4246167736c6acb5a541e833.1781523812.git.fuhao@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 12:37:16 +0000
Message-Id: <20260615123717.5E2361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new Hygon HD-Audio controller support misses critical AMD/Zen =
architectural quirks, specifically 40-bit DMA mask clamping and the AZX_DCA=
PS_NO_TCSEL capability flag.
--

commit b159eff305dbdd80947b5dde567df2ff7e67de70
Author: Fu Hao <fuhao@open-hieco.net>

ALSA: hda: Add support for Hygon family 18h model 5h HD-Audio

This commit adds the PCI ID 0x1d94 0x14a9 to support the Hygon family 18h
model 5h HDA controller.

> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 1e8e3d61291a1..e706d38d7fd6c 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c
[ ... ]
> @@ -2815,6 +2819,9 @@ static const struct pci_device_id azx_ids[] =3D {
>  	  .driver_data =3D AZX_DRIVER_LOONGSON | AZX_DCAPS_NO_TCSEL },
>  	{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_HDMI),
>  	  .driver_data =3D AZX_DRIVER_LOONGSON | AZX_DCAPS_NO_TCSEL },
> +	/* Hygon HDAudio */
> +	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_HYGON_18H_M05H_HDA),
> +	  .driver_data =3D AZX_DRIVER_HYGON | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS=
_NO_MSI },

[Severity: High]
Should this capabilities bitmask include the AZX_DCAPS_NO_TCSEL flag?

Hygon processors are based on the AMD Zen architecture. Without this flag,
azx_init_pci() will inadvertently write to the Intel-specific Traffic Class
Select register at PCI offset 0x44:

sound/hda/controllers/intel.c:azx_init_pci() {
    ...
    if (!(chip->driver_caps & AZX_DCAPS_NO_TCSEL)) {
        dev_dbg(chip->card->dev, "Clearing TCSEL\n");
        update_pci_byte(chip->pci, AZX_PCIREG_TCSEL, 0x07, 0);
    }
    ...
}

On AMD/Hygon hardware, offset 0x44 is not TCSEL and modifying it could cause
unintended behavior or system instability.

[Severity: High]
Does this new Hygon device also need the 40-bit DMA mask clamping that is
applied to AMD devices?

In azx_first_init(), AMD devices have their DMA bits explicitly restricted:

sound/hda/controllers/intel.c:azx_first_init() {
    ...
    if (chip->pci->vendor =3D=3D PCI_VENDOR_ID_AMD)
        dma_bits =3D 40;
    ...
}

Since Hygon shares hardware constraints with AMD Zen, leaving the DMA bits
at 64 could lead to physical address truncation or IOMMU DMAR faults on
systems with sufficient memory.

>  	{ 0, }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781523812.gi=
t.fuhao@open-hieco.net?part=3D6
