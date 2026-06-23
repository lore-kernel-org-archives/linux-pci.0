Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019FD21A92F;
	Tue, 23 Jun 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205491; cv=none; b=OxAx0mE0rRxGm76st5DKB+IEkByyjKRlCEn1hGYQjA0fE2U5Hd065eSCwnZ/8IVEjc0RgVqeSf/I+A8jZxC1KMPcjFlSuDwjfgDWex4H3Nskz0GvK6Z4lE/4W1jFJ3Usv9jXs4lnyhbATZv0O1+CmzkvcDvb3aJv5GY0aA6hRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205491; c=relaxed/simple;
	bh=f+sUawWSZHxvpDtFno1uRhAphsDB4CJI1BydYp5OI4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kxnI95vDc7b+i9Hi7f1VxIlgi54Jbp3T34viJ8D7ksHc/3uHya18HbMAkwLf+jN/kJcitgOlPaXtueaac+YCX9X+CT/gBgbIUezT1nx7s9UqyRjScjpIz4y/IsHBnC6q9h70+O+gEv/vQaTa19OasOx7Y36HmdzjRs8xCYOWQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyEDQQh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyEDQQh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA661F000E9;
	Tue, 23 Jun 2026 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205489;
	bh=Uo1GzNmt2x+u852q5EwlhRt/WH2pdT22kjLljSpMiNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jyEDQQh5rkWVEwsIhcm6KgQDAnSuBVjyOLJoh9tB8FzQjmKqmEyZ+UVi8GwJ3uUVX
	 hz2OoKSdCvTJzuc/+6ShAwVV7PdufE0UfY5KbdKT5dN6UvIDkX9KOoUoaVGYdTKzdq
	 y4B83ArrcsJgCW0W6zhdmLaXxBTskxZDk4v6cjLKXUqsWXyIhDp0ZhreHXHz0sd7ZF
	 BE7w6kfeiIeOTR0WqdXVkRL5c9Q5hZPi7YIPysM+gCEqQGxPIrwsGZNkEDBol7PlL0
	 nwxd6iTST2w6EWLjEGno1KQ9VMCLLou8zOSYZxiFIHTswnFUWXGcRL5/bWU7y9bqv4
	 i/iMibgTdV1Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 04/12] PCI/TPH: Refactor pcie_enable_tph &
 add explicit requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623085048.51139-5-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:04:48 +0000
Message-Id: <20260623090449.AAA661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `pcie_tph_set_st_entry` can violate the PC=
Ie spec and corrupt hardware state by modifying the ST table while TPH is g=
lobally enabled.
--

commit e3b30f139c34eadf8039e394826ffa947655fe86
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant

This commit refactors the pcie_enable_tph implementation by extracting the
core logic into a static internal enable_tph helper that accepts an explicit
requester type. It preserves the original pcie_enable_tph behavior as an
auto-detecting wrapper and adds a new pcie_enable_tph_explicit function
for explicit standard or extended TPH selection.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 4097787ea98a1..c22eb7f4b0bd7 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -400,10 +384,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	if (!((1 << mode) & dev_modes))
>  		return -EINVAL;
> =20
> -	pdev->tph_mode =3D mode;
> +	if (req_type =3D=3D PCI_TPH_REQ_EXT_TPH && !pdev->tph_ext_support)
> +		return -EINVAL;
> =20
> -	pdev->tph_req_type =3D pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
> -						     PCI_TPH_REQ_TPH_ONLY;
> +	pdev->tph_mode =3D mode;
> +	pdev->tph_req_type =3D req_type;
> =20
>  	/* Write them into TPH control register */
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);

[Severity: High]
This is a pre-existing issue, but does the TPH subsystem lack necessary
locking around the TPH Control Register and ST table updates?

If multiple MSI-X vectors' SMP affinities are updated simultaneously by a
user or irqbalance, concurrent calls to pcie_tph_set_st_entry could happen.
Since pcie_tph_set_st_entry temporarily disables TPH system-wide:

pcie_tph_set_st_entry()
    set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
    ...=20
    loc =3D pcie_tph_get_st_table_loc(pdev);
    ... write to ST table ...
    ...
    set_ctrl_reg_req_en(pdev, pdev->tph_req_type);

Would CPU2 re-enable TPH while CPU1 is still writing to the ST table,
violating the PCIe r6.2 sec 6.17.3 specification which cautions against
updating the ST table while TPH is enabled?

Additionally, set_ctrl_reg_req_en performs an unprotected read-modify-write:

set_ctrl_reg_req_en()
    pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
    FIELD_MODIFY(PCI_TPH_CTRL_REQ_EN_MASK, &reg, req_type);
    pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);

Could concurrent IRQ notifiers cause a data race here, corrupting the TPH
control register state?

>  	FIELD_MODIFY(PCI_TPH_CTRL_MODE_SEL_MASK, &reg, pdev->tph_mode);
>  	FIELD_MODIFY(PCI_TPH_CTRL_REQ_EN_MASK, &reg, pdev->tph_req_type);
> =20
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D4
