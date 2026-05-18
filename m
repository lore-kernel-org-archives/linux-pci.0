Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552553DFC6A
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091052; cv=none; b=tqkGdNfTIfrs7ZzVkTQF2cqMY9Oja+WfwW36HGeubQpM2HYcHFtXdghx9JiN2YZ03z4dSD7XcX1cTxnZcFjWywfvGh2rl8ZiXXPzLWlNZayekSltPwdaeo8rlhBxT75FkDQO77S0gR3bhTnhC7fk9PGnEbYh4QJGYz3cUDOZ+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091052; c=relaxed/simple;
	bh=X32Qq1IzNZRO/LavBSM8+dj9KQJViv2Ml2BVUnpE5jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTqB0u504E+FwxYiRpHuedOjPy7wrcFcDLjMnZ6DImU/SaBXU16FgAfxjHDDh5UqSSQqrOU4apzoq4S5C4tr5ICzP6W2shxGAYDEShLOeIRgcOcr2tQWI2OQCCzKnzug2X711G5c6oezX757T79qdOdD6oOPiBrU5ichns8D8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgdGkxVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgdGkxVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAFFC2BCC6;
	Mon, 18 May 2026 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779091052;
	bh=X32Qq1IzNZRO/LavBSM8+dj9KQJViv2Ml2BVUnpE5jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NgdGkxVz+90jo/2OQKEZv21mKwC6bGIMI0+Qm9OSu+ofGg9NmgO51j2rhR/uC4lQu
	 7wS+1Hy9fAFmQ9uBhB1+fjgvrC//Airo7dXqpXHLSfEz8seZ00nOKNFsuXgAFB/qq/
	 r84HXK0MF+wPYWBqFX3wEZkpb21xqMWRJqb7BG2s822FyZST6dyqTUgngmcBvWyGnq
	 HwkKOB90hhzpSHf4WNZHvk7Tygxy2EAOeC4VQiJYrEP6licxyh3L6c13BxGAfzh6E/
	 ODWNiB5zgoSrTf3ozTVNqTNUHLaJvdqrYjt4GuI/jThepvkM32hy1wdCgRHfbu1uGZ
	 QDo8ajbzGZ1eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/5] PCI/TPH: Export pcie_tph_get_st_modes() for
 external use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518071701.25177-3-fengchengwen@huawei.com>
References: <20260518071701.25177-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 07:57:31 +0000
Message-Id: <20260518075731.EAAFFC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unchecked return value of pci_read_config_dword() leads to reporti=
ng false capabilities and bypassing safety checks on disconnected devices.
--

commit 7d284f4750da4fed3caa1876a0ac6b5f46c96ad9
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Export pcie_tph_get_st_modes() for external use

Export the helper to retrieve supported PCIe TPH steering tag modes so that
drivers like VFIO can query and expose device capabilities to userspace.
Add stub functions for when CONFIG_PCIE_TPH is disabled, and add validation
to prevent invalid configuration space access.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 877cf556242b4..ba31b010f67ad 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -145,15 +145,27 @@ static void set_ctrl_reg_req_en(struct pci_dev *pde=
v, u8 req_type)
[ ... ]
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
> +EXPORT_SYMBOL(pcie_tph_get_st_modes);

Is it possible for pci_read_config_dword() to fail here?

If the device is disconnected or the read fails, reg could be set to
0xFFFFFFFF (PCI_ERROR_RESPONSE). It might also be left uninitialized if the
host controller fails the read without updating the variable.

Because the return value of pci_read_config_dword() is not checked, a value
of 0xFFFFFFFF in reg would cause this function to return 0x7 after masking.

With this function now being exported to external drivers like VFIO, could
this result in falsely exposing all ST modes as supported to userspace
instead of returning 0 on failure?

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
>  }

Similarly, if pci_read_config_dword() fails here and sets reg to 0xFFFFFFFF,
this will return PCI_TPH_CAP_LOC_MASK (a reserved location) rather than
PCI_TPH_LOC_NONE.

Could this incorrect return value bypass safety checks that expect
PCI_TPH_LOC_NONE for invalid devices, or cause pcie_enable_tph() to
improperly enable TPH when hardware access has failed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518071701.2517=
7-1-fengchengwen@huawei.com?part=3D2
