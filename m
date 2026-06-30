Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF12F7EEE;
	Tue, 30 Jun 2026 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860855; cv=none; b=stTYElRUC3rmlO6Yub0/fcn9JLPFN1DqGShOfDlE7LEpxqfxiS8JwY1O5reT0+iL9p7rwUTkPcNvI7DvEPOUonvD691h0ZDO+BIdArgJhGRvjRGlP9+ICaInNOcSWNWWtNV5F4uMU1dvam4+1N1g3y4brxxkx+9F4F4N26GD0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860855; c=relaxed/simple;
	bh=M/COxJA1hGmftVGtRc5rvlLFI53Tp69rMkrfmSNGuXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=daE7PzEGsugDZ5a3oC0u1Sp5YSsXMVnGi+TfqYyW9T7x/Dwok8ZJP8Nf0uOuuL62LjiSchfmbm2WdADMi+Sb7fdzGCQ4g5gEzghwJfRH1QRIU6TUAk5YqG4Ma/L65KuelWqFjrsUSFs+wUjupbXItmVzRVTEbaMVH6oXfD1iW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa4ycMEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa4ycMEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71191F00A3A;
	Tue, 30 Jun 2026 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860854;
	bh=Stg7AjDBiczf2/4Kj0vYqepZBBQYqeaJ/+PGUOKm+cI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qa4ycMENFl1HPE6hZTpRK7T8y+p1EoYB0ru1wQovl5MlTNJ5qf8fckpjRXYNsr3a6
	 IWe/uBaXoNgWcL/z7/VziMnbtiPT1UY8It9SC5ZCeQGl6A0GyJZfiwuyy8GafC2iDv
	 FOZvUVIcaTrzkFoYKtLR4Sw5+1B68kW29Jl0L+p/upzTpunR36eDGP0He2D28yrPvA
	 pxo1ncWjV0/YERQZIE0+saefE+/5Mk0yVkGA2Km9enj+EHXMQKBjIvlSLz6KyQcx6M
	 Zfx+JaGW8/m830Vp1SJURoobF3ZiJF7Ls+hFge0MhpfBHUHasSiDXhoIDvZH3oT1QQ
	 TKLKBD+kO8gRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/4] PCI/TPH: Add requester/completer type helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260630224328.3218796-2-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:07:33 +0000
Message-Id: <20260630230733.E71191F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The internal `get_rp_completer_type()` function was not updated =
to use the new `pcie_tph_completer_type()` helper, leading to an API contra=
ct violation in `pcie_tph_enabled_req_type()`.
--

commit d64d0831457ed161ad198682067e0f147ca1411e
Author: Zhiping Zhang <zhipingz@meta.com>

PCI/TPH: Add requester/completer type helpers

This patch introduces pcie_tph_enabled_req_type() and
pcie_tph_completer_type() to allow drivers to query TPH requester mode
and completer capabilities without accessing pci_dev internals directly.
It also ensures the reserved 0b10 completer capability encoding is
folded into a "not supported" value for callers.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 655ffd60e62f6..e7693fd9d6763 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -173,6 +173,51 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> =20
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester=
 type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_=
TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}

[Severity: Medium]
Could this helper return an undocumented value of 2 if a Root Port's TPH
Completer Supported field incorrectly exposes the reserved 0b10 value?

The internal get_rp_completer_type() function was not updated to use the new
pcie_tph_completer_type() helper, so it retains its manual decoding:

drivers/pci/tph.c:get_rp_completer_type() {
    ...
    return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
}

If get_rp_completer_type() returns 2, pcie_enable_tph() can assign this to
pdev->tph_req_type via the min() calculation:

drivers/pci/tph.c:pcie_enable_tph() {
    ...
    rp_req_type =3D get_rp_completer_type(pdev);
   =20
    /* Final req_type is the smallest value of two */
    pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
}

Should get_rp_completer_type() be refactored to use pcie_tph_completer_type=
()
to properly fold the reserved 0b10 encoding and avoid this API contract
violation?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224328.3218=
796-1-zhipingz@meta.com?part=3D1
