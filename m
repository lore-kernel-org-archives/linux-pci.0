Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E09F423A85
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266949; cv=none; b=Ln+4GX4juuIJQGynaN6Mny1vb3C2WsPfOeaw1E80zCaGoYFmdbOwyZaBdjzgZEo4zNmRfu+s1osvndfd9STfCeReAY/P+BqpaoIsusittWykNaTda14m0t4HPHNfW+ro6b6S3f69efGFSK7JoyVJngJGt97E+1yAI8Mfrl9g3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266949; c=relaxed/simple;
	bh=/sIVyftLqxYoxdkEqHlElojy7FaMvLL41mCvT4YtEbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mp4vhbtHa42hsHqWf9CNIJOGwLYVJzpCoe0d9NJtG7WzLRYBy45wkGcD1rcOoBXAU0K7FFrrzwMVcgbRTUHnFX4X1AHw0QWn+RWAV7w505crov2YWC+gkGbBDzDDHyWgVnIRcxmOmbJ4YoJ8P/jhJM0s/tQa866U7V2zwVtyOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asIhpky9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asIhpky9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85506C2BD01;
	Fri,  8 May 2026 19:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778266948;
	bh=/sIVyftLqxYoxdkEqHlElojy7FaMvLL41mCvT4YtEbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=asIhpky9s4dlM2JEwq7jQNxPm7lqFnSJt6w5Iw00nE4q8ej53/fJhEJ0uRU2EhFd2
	 sasLmpVRK+sqzG4mtxdKr7gC9L0OyvC7qgTbubsVptMgsVwzIgPKnwx7AAfNcv9+Mo
	 1zpggIHX+9xx32ffr+IkCJc4KN2mWJcG5FwQEjSoIqiow4oD4t5N0QVdACDgiRkvMW
	 oRHEl+WQvfTusfrRpNGycdNydBa14j7oFdMhSZLwo/DlmOEpwUKThxSYcGtMnh3/L4
	 vZxbNp34eQHKCKsbFG4+LINuTMZ89LlliIcgnDY5Vtc7tfZtp8uGmjI2f81ncNK/ZU
	 S5mhihBYHzF8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/7] PCI/TPH: Export pcie_tph_get_st_modes() for
 external use
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508064053.37529-3-fengchengwen@huawei.com>
References: <20260508064053.37529-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 19:02:27 +0000
Message-Id: <20260508190228.85506C2BD01@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pcie_tph_get_st_modes() and pcie_tph_get_st_table_loc() do not che=
ck the return value of pci_read_config_dword(), causing them to return fals=
e capabilities on read failures.
--

commit 521881ea093ae852c8fad775f8ffcbe3b9c7a46b
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Export pcie_tph_get_st_modes() for external use

This commit exports the pcie_tph_get_st_modes() helper to allow external
drivers like VFIO to query supported PCIe TPH steering tag modes. It also
adds stub functions for when CONFIG_PCIE_TPH is disabled and includes
tph_cap validation to prevent invalid PCI configuration space access.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 877cf556242b4..ba31b010f67ad 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -145,15 +145,27 @@ static void set_ctrl_reg_req_en(struct pci_dev *pde=
v, u8 req_type)
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
>  	reg &=3D PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;
> =20
>  	return reg;
>  }

If pci_read_config_dword() fails (for example, if the device is disconnected
or isolated), it sets the output variable reg to PCI_ERROR_RESPONSE (~0U).

Because the return value is not checked, this code will apply the bitmask
to ~0U, which evaluates to 0x07 (PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV |
PCI_TPH_CAP_ST_DS).

Since this function is being exported for external use by drivers like VFIO,
could this falsely advertise that the device supports all three ST modes
instead of none? Should the return value of pci_read_config_dword() be
checked to ensure 0 is returned on failure?

> +EXPORT_SYMBOL(pcie_tph_get_st_modes);
> =20
>  /**
>   * pcie_tph_get_st_table_loc - Return the device's ST table location
> @@ -168,6 +180,9 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  {
>  	u32 reg;
> =20
> +	if (!pdev->tph_cap)
> +		return PCI_TPH_LOC_NONE;
> +
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
> =20
>  	return reg & PCI_TPH_CAP_LOC_MASK;

Similarly, does an unchecked read failure here lead to returning an invalid
location mask derived from the ~0U error response? Would it be safer to che=
ck
the return value and return PCI_TPH_LOC_NONE if the read fails?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508064053.3752=
9-1-fengchengwen@huawei.com?part=3D2
