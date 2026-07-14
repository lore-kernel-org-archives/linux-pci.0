Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26A37F8B3;
	Tue, 14 Jul 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027476; cv=none; b=uu3B/2bt6tGWE+BYZYs4ugIfSTHLsTiIAedFld7sWmeSBIi1x/0rG5Q7dBxKMv0rtbyeunmoIfq+/mg1lUleb/5BheHjEPFvq6wEIF4RlHGUX/gSj3EhHtsGQuimSX0dQApChXOJniOjBKphlCbWkRFI8agtKT2ggMAlHwGJlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027476; c=relaxed/simple;
	bh=pCAOyvdduB1XcGuT04dcxci2V7+hxfJWUoh0vHekRAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BGGN62mr9UmnkyBisvTN49OmuJBJRBSZlptLC389vx0GBwWrbcpnhnbOdk52klg9k+i2OIZhNQPaHlZ9F9TmoZ3mYlC8Av9xWYcUf0N8dHNO4UdLIwsBz5uq/Gh3zP9VPN9/MB3siEOWwEgrHOyHDEKpJ4p3tKCsQeKtSkAjr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOw51fSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOw51fSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD11F000E9;
	Tue, 14 Jul 2026 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027475;
	bh=2u1MWmHOBstphNwGqspfNihw/7sEfBgtJXrEunPy2yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YOw51fSoBXlJJ1Hu1q91WM5UWA9fmRSzqWE7Obrg+JfHdq8j68Hk2Ge7DZw4z9MVk
	 ImDu4MlHQZYOzO/nVC1jFM1/hehin78Ro+ZYQH/yKQNjwUZ1c+3+4jf4N6BEbM42lO
	 eZV8wx5zHOodC11VPHd0PuVnuEr34gX7+/Ik8t5bB/c6EDtQQgMMrQD6i6XiLVu4GY
	 EFybC46pi3c1ECf/EOd5oxkJyfo34CsUy5sLJgJPPFgQMH6iBAspEj1xTfWm6rpGHs
	 JrsnyYAa1w2WrOWjDZD4S0kYJLUQ4nKN8Eq9oVOirK0Hr8SZDAf4LJHYZOcmSCh/31
	 zydRUe/UXLrjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 10/16] PCI/TPH: Add pcie_tph_set_st_entries() batch
 ST entry programming helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-11-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-11-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:11:14 +0000
Message-Id: <20260714111115.34CD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] API return value collision: PCIBIOS error codes masquerade as succ=
essful batch writes.
- [High] Partial success return value hides fatal global TPH disablement.
- [Medium] Calling the batch function with count=3D0 disrupts hardware TPH =
capability state.

Pre-existing issues:
- [High] Integer overflow in bounds check allows out-of-bounds config space=
 writes.
- [Medium] Lockless data races on PCI_TPH_CTRL during concurrent updates.
--

--- Patch [10]: [PATCH v20 10/16] PCI/TPH: Add pcie_tph_set_st_entries() ba=
tch ST entry programming helper ---
commit ef45067b72f46179b7e7c22243bc81d01093a5bd
Author: Chengwen Feng <fengchengwen@huawei.com>
Subject: PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming =
helper

This patch introduces a batch variant for programming contiguous Steering T=
ag
(ST) table entries. It modifies the existing pcie_tph_set_st_entry to act a=
s a
wrapper around the new pcie_tph_set_st_entries helper. The batch helper
toggles TPH once per batch for better performance.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 633dc6308b68c..8194f8b45e3c6 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -378,7 +376,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsig=
ned int index, u16 tag)
> =20
>  	/* No need to write tag if device is in "No ST Mode" */
>  	if (pdev->tph_mode =3D=3D PCI_TPH_ST_NS_MODE)
> -		return 0;
> +		return count;
> =20
>  	/*
>  	 * Disable TPH before updating ST to avoid potential instability as
>  	 * cautioned in PCIe r6.2, sec 6.17.3, "ST Modes of Operation"
>  	 */

[Severity: Medium]
Will this unnecessarily disrupt the hardware state if the function is called
with count =3D 0? Since the loop will be bypassed, TPH will be disabled and
immediately re-enabled without writing any tags.

>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);

[Severity: Medium]
This is a pre-existing issue, but can concurrent updates cause lockless data
races on the PCI_TPH_CTRL register?

If multiple threads attempt to program the ST table concurrently, they may
race in set_ctrl_reg_req_en() which performs a lockless read-modify-write.
Could one thread re-enable TPH while another is midway through writing its
entries?

> =20
>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -
> -	switch (loc) {
> -	case PCI_TPH_LOC_MSIX:
> -		err =3D pci_msix_write_tph_tag(pdev, index, tag);
> -		break;
> -	case PCI_TPH_LOC_CAP:
> -		err =3D write_tag_to_st_table(pdev, index, tag);
> -		break;
> -	default:
> -		err =3D -EINVAL;
> -	}
> -
> -	if (err) {
> -		pcie_disable_tph(pdev);
> -		return err;
> +	for (i =3D 0; i < count; i++) {
> +		switch (loc) {
> +		case PCI_TPH_LOC_MSIX:
> +			err =3D pci_msix_write_tph_tag(pdev, start + i, tags[i]);
> +			break;
> +		case PCI_TPH_LOC_CAP:
> +			err =3D write_tag_to_st_table(pdev, start + i, tags[i]);

[Severity: High]
This is a pre-existing issue, but does this bounds check in
write_tag_to_st_table() have an integer overflow vulnerability?

write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag) {
    ...
    if (index >=3D st_table_size)
        return -ENXIO;
    ...
}

Since write_tag_to_st_table() takes a signed int for the index, and we are
passing unsigned int start + i, could a large start value overflow to a
negative integer? A negative index would bypass the bounds check and cause =
an
out-of-bounds config space write.

> +			break;
> +		default:
> +			err =3D -EINVAL;
> +		}
> +		if (err !=3D 0) {
> +			pci_err(pdev, "failed to set steering tag: %s table, index=3D%u, tags=
=3D%u, ret=3D%d\n",
> +				(loc =3D=3D PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST",
> +				start + i, tags[i], err);
> +			pcie_disable_tph(pdev);
> +			return i > 0 ? i : err;

[Severity: High]
If write_tag_to_st_table() fails on the first iteration where i =3D=3D 0, c=
ould it
return a positive error code from pci_write_config_word() such as
PCIBIOS_BAD_REGISTER_NUMBER?

Because the return statement yields err when i =3D=3D 0, a positive error c=
ode
would be interpreted by the caller of pcie_tph_set_st_entries() as a
successful batch write count.

[Severity: High]
If the loop fails on an entry after the first, this calls
pcie_disable_tph(pdev) which disables TPH for the entire device. However,
returning i yields a positive partial success count to the caller.

Does this leave the caller assuming the first i entries are functional when
TPH has actually been completely disabled?

> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D10
