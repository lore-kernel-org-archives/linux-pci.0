Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290383793CC
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192344; cv=none; b=HQJoAoFIEqOUWipxKHOSho4aZej07wEGG2b0TDqtrwLMXiRDCxmWmghO3THP7ZpQIqx1mpqPbPyFr7B6oqmwNY+o6BV4nm3yC28nsJco83zxfEYBdKs4exyhG5ZhiOCcOJWh6o/o9Pe5XMaOpBDuytqfD5VBGkOOoDlYGVVpU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192344; c=relaxed/simple;
	bh=H3JEqO6v6F5iO+Vl9lhr9b2r8U+jo3BC39KgpYfO3yY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAOlt0x9m31d825o+GPLBRokBaurrFe712MlSUFMdffAjJBOhhYAmz3Q2nqXBQuxOd6ltb9/TKA4uUVmdyw6HcnJoSteHTHr9GobtpuNAcXVnAQP3ZlxAHoQ1yDNAqIMWLlqeumZDeSEpmdiprzOFwM2Th8LsQ8MFnoDoHfVgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM8gThIa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM8gThIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77885C2BCF7;
	Thu,  7 May 2026 22:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192343;
	bh=H3JEqO6v6F5iO+Vl9lhr9b2r8U+jo3BC39KgpYfO3yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VM8gThIaM6KYgxdR8qzY3bqhXv9VIJ3MMkjLe9+AO87LhO9P2FQT6US84fPQbrVHg
	 Js6hk0yEGlG21VuduBjdPPQPCZXezAUQm3Y/K1fNg+9QkRtbWIHuQTccUl2USxz9yR
	 kVhCguONRSz5eUh+1Fevsrm47iZ+of8qQAX/C+IfKFKj8uDn4rfw4uC/ncD6v0UGWN
	 OypRdQKU4yH+maNYu3G+GMBevx29+2zDhTcISpnRSGT5R6rgHnUQzHQ2M8j0qLCAQE
	 UA69RgxD/IYHundOtcP59+vNj4703sEVPSEtOTip0qzSBlFnlhARo44KO/4pssvlPk
	 gJ6o2bTey1TuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] PCI/TPH: Export pcie_tph_get_st_modes() for
 external use
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507130956.34441-3-fengchengwen@huawei.com>
References: <20260507130956.34441-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 22:19:02 +0000
Message-Id: <20260507221903.77885C2BCF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `pcie_tph_get_st_modes()` and `pcie_tph_get_st_table_loc()` fu=
nctions ignore the return value of `pci_read_config_dword()`, leading to fa=
bricated capabilities being exposed to userspace.
- [Low] The commit message incorrectly refers to the configuration option a=
s `!CONFIG_PCI_TPH` instead of `!CONFIG_PCIE_TPH`.
--

commit 4a10965994892856e6b789d0c75e23d0e2e09be7
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Export pcie_tph_get_st_modes() for external use

This commit exports the pcie_tph_get_st_modes() helper so drivers like VFIO
can query and expose device capabilities to userspace. It also adds stub
functions and tph_cap validation to prevent invalid configuration access.

> Add stub functions for pcie_tph_get_st_table_size() and
> pcie_tph_get_st_table_loc() when !CONFIG_PCI_TPH.

This isn't a bug, but there is a typo in the configuration option name.
The actual kernel configuration option for PCIe TLP Processing Hints is
CONFIG_PCIE_TPH rather than CONFIG_PCI_TPH.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 877cf556242b4..ba31b010f67ad 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> -static u8 get_st_modes(struct pci_dev *pdev)
> +/**
> + * pcie_tph_get_st_modes - Get supported Steering Tag modes
> + * @pdev: PCI device to query
> + *
> + * Return:
> + *  Bitmask of supported ST modes (PCI_TPH_CAP_ST_NS, PCI_TPH_CAP_ST_IV,
> + *                                 PCI_TPH_CAP_ST_DS)
> + */
> +u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
>  {
>  	u32 reg;
> =20
> +	if (!pdev->tph_cap)
> +		return 0;
> +
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);

Should we check the return value of pci_read_config_dword() here?

If the device is disconnected or unresponsive, pci_read_config_dword()
returns an error and populates the variable with the standard PCI error
response 0xFFFFFFFF.

When the mask (PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS)
is applied to 0xFFFFFFFF, it results in 7. This falsely indicates that all
Steering Tag modes are supported.

Since this function is now exported for external subsystems like VFIO, does
this risk exposing fabricated hardware capabilities to userspace when a
device becomes unresponsive?

>  	reg &=3D PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;
> =20
>  	return reg;
>  }
> +EXPORT_SYMBOL(pcie_tph_get_st_modes);
[ ... ]
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  {
>  	u32 reg;
> =20
> +	if (!pdev->tph_cap)
> +		return PCI_TPH_LOC_NONE;
> +
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);

Similarly, does this need error checking for the config read?

Applying the PCI_TPH_CAP_LOC_MASK (3 << 9) to 0xFFFFFFFF results in 0x600,
which is an invalid, undefined location enum.

> =20
>  	return reg & PCI_TPH_CAP_LOC_MASK;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507130956.3444=
1-1-fengchengwen@huawei.com?part=3D2
