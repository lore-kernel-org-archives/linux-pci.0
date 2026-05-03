Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FE2236F0
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777816269; cv=none; b=puK3dGmU00TNUWoFLW6yhFUoMTvXlsqzNyT+F7fMUxH0t41Pdte2yDsGGS0XLdxpZHNgvE8ip6SY5jKh2bcZnHyFu5ii5x9ByanHlpa+Zc/dQlJVHoHDqJA3QcgqgTJN4bC6O8HdXm2XDy1FVhHI6RJJqQsG+Pcrtxjc6VCLivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777816269; c=relaxed/simple;
	bh=DgfVWxrYBRgguAFdrL7fywNOdpoYYzD63n1bUhrK4yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CY0XzCtR7Te1KH7+L5M8JGgQG0KZsYoYl9Zgxqs7ny+dMKIRAfljXYRKzowCdlH66ERkZB/4/KE+wxYiaP2AbEyA7bUnaaiZ8GOGQbuuS/aDe92Fb4PW0qdsZcfQrzoP/p3NYQVszEeaWddHg1us3tfX4VdYTq8PV7bZpllCNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILJ/iEp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILJ/iEp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46193C2BCB4;
	Sun,  3 May 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777816269;
	bh=DgfVWxrYBRgguAFdrL7fywNOdpoYYzD63n1bUhrK4yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ILJ/iEp0UTcZQXo6eRh+LNRnheOFsrE29s8ueNCy/OKwcTEVZaIaRIgmKPeIU57Et
	 x+EUppoSRsa6+eDYv5OwwBgHSsDyMl1Q//4+aA55TkGIGxY6GGnpRVWxMO3zv7wJXf
	 DcDr8H+PlmN4okdEljIDRpWjlMBJplqvt86j7+SEwHnjMhD7qxnAkvxYsJAvpp4tOF
	 37/eERiWs4GK2IgTavXWJQZcOGrFUg60PAelm6eMWfwygWTUyRbMtfmN4SzRk+AmOY
	 eFAgeLKFaLBuj/to0NP/Nf6lW9NA22it0WKtxPOmWTiBAZW1kFuZ7fLHjCUKLKfiBw
	 B3Ngp0QHYLAzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
Reply-To: sashiko@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <785c98b50a7a00d0698848c75d51b8f5669ad18f.1777814679.git.lukas@wunner.de>
References: <785c98b50a7a00d0698848c75d51b8f5669ad18f.1777814679.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 13:51:08 +0000
Message-Id: <20260503135109.46193C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the read-back and retry loop for BAR restoration in `pci_=
restore_state()` introduces a risk of silent regressions for hardware resum=
ing from non-FLR resets (such as D3hot to D0 transitions or custom driver r=
esets). The commit incorrectly assumes the 60s delay from `pci_dev_wait()` =
covers all usages, but standard PM resume paths only delay for 10ms (`PCI_P=
M_D3_WAIT`) before calling `pci_restore_state()`. Historically, hardware th=
at needed slightly longer to accept configuration writes relied on the 10x =
1ms retry loop to successfully restore BARs. By removing both the retry and=
 the read-back verification, BAR writes to slow devices will be silently dr=
opped, leaving hardware unconfigured and causing MMIO accesses to result in=
 IOMMU faults or kernel crashes.
--

commit 28d12557c0e570f2b2d21da1dcbb7889df2f4672
Author: Lukas Wunner <lukas@wunner.de>

PCI: Drop unnecessary retries when restoring BARs

This commit removes the retry loop when restoring PCI configuration space.
It relies on the lengthened FLR delays now present in the kernel, concluding
that retries for BAR restoration are no longer needed.

Closes: https://lore.kernel.org/r/20260416225745.GA41850@bhelgaas/

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc00090..1e386dfaa669 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1764,7 +1764,7 @@ int pci_save_state(struct pci_dev *dev)

[ ... ]

>  static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
> -				     u32 saved_val, int retry, bool force)
> +				     u32 saved_val, bool force)
>  {
>  	u32 val;
> =20
> @@ -1772,52 +1772,42 @@ static void pci_restore_config_dword(struct pci_d=
ev *pdev, int offset,
>  	if (!force && val =3D=3D saved_val)
>  		return;
> =20
> -	for (;;) {
> -		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
> -			offset, val, saved_val);
> -		pci_write_config_dword(pdev, offset, saved_val);
> -		if (retry-- <=3D 0)
> -			return;
> +	pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n", offset, val,
> +		saved_val);
> =20
> -		pci_read_config_dword(pdev, offset, &val);
> -		if (val =3D=3D saved_val)
> -			return;
> -
> -		mdelay(1);
> -	}
> +	pci_write_config_dword(pdev, offset, saved_val);
>  }

Does removing the read-back and retry loop introduce a risk for hardware
resuming from non-FLR resets?

While FLR paths might now have a 60 second delay, pci_restore_state() is
used globally across the kernel. For example, during a PM resume from
D3hot to D0, the kernel typically only delays for 10ms (PCI_PM_D3_WAIT)
before restoring state.

If a device is slow to exit reset, will these configuration writes be
silently dropped without the fallback retry loop, potentially leaving BARs
unconfigured and causing MMIO accesses to fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/785c98b50a7a00d0698=
848c75d51b8f5669ad18f.1777814679.git.lukas@wunner.de?part=3D1
