Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84343D517
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071148; cv=none; b=slxmgb29llMTBEvesXO6WyhoV1blJWK/QwB/Xj3ka70RyNqXiPR/fR2YGCizWzEMoXe7ldFStEE2WYa/mpu6MBnsQs21SN7+cmkc4auWipDF51CUO67lTivQq6AEqGRDmNxDyfR0y5pW5AcZDqp23IISAdww2w7PIPMmuWDUXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071148; c=relaxed/simple;
	bh=9uK3VSzqbg7Ou/qYuZlh2e5GSopEy3iqG6qmAtrsBwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P6aWZC6X/pt8ITyrjbik3DH4/l7DS6SlWIjiIFRfuppaZR3z39CbTEdzMRGncwqaaOgDLJNJkUEPxcR9rbCD9K62SB8CwzcU1PoBQqIDeMQ08uDWH774xPJ6r/el7yjiPA8EMPWbj6F8/SIhhEsCVI+TTO0yO1847m+7RW9OI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0T8HVhu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0T8HVhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2928C2BCB8;
	Wed,  6 May 2026 12:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778071148;
	bh=9uK3VSzqbg7Ou/qYuZlh2e5GSopEy3iqG6qmAtrsBwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q0T8HVhu9w00JYGsKG4K6Lc7YrnBxXD8RWyu7jpUUanN4O4YBPfJqgxrV6VZ83kcl
	 IQkeh1B9W9HmggIrfIED/jjH4zSvrBcSgGfqJXw7XHyjnRKaXIV5NRNcPVsSIZr1r8
	 i1sJxZrZDB+llsxxTzhsx2qHGkFWNdacf8al4Ywrd5OV2HjEgZMVjJRdygKkgAmzpE
	 o7Y9ogw9pM1X9TtnV3tnKGR+MyceHq/vACSzNh1XhDQKijk1IfNy9HYlAoe3EmYM1T
	 t0XOjo5geR2g6onoBmLxDu9WVQvxPsL5A9akpvjhO7SbUcrCg0WdmocCu38kF7rpVy
	 g5ezJH8bqvkNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] PCI/TPH: Export pcie_tph_get_st_modes() for
 external use
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506094623.29327-3-fengchengwen@huawei.com>
References: <20260506094623.29327-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 12:39:07 +0000
Message-Id: <20260506123907.E2928C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing error handling for pci_read_config_dword() in the newly =
exported pcie_tph_get_st_modes() leads to falsely reporting all TPH modes a=
s supported when a device is disconnected.
- [Low] The !CONFIG_PCI_TPH stub for pcie_tph_get_st_table_loc() returns an=
 inconsistent out-of-bounds value (0x7FF) instead of PCI_TPH_LOC_NONE.
--

commit d23fc69219a490dd1458be7c3d6f50ae929f70cd
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Export pcie_tph_get_st_modes() for external use

This commit exports the pcie_tph_get_st_modes() helper so drivers like VFIO
can query supported PCIe TPH steering tag modes. It also adds stub functions
for when !CONFIG_PCI_TPH and tph_cap validation.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index f17b74b5fb1e3..ba31b010f67ad 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -145,15 +145,27 @@ static void set_ctrl_reg_req_en(struct pci_dev *pde=
v, u8 req_type)
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

If pci_read_config_dword() fails (e.g., when a device is disconnected), it
populates the output variable with an error response (~0 or 0xFFFFFFFF).

Since the return value is ignored here, will this masking operation:

>  	reg &=3D PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;

evaluate to 0x07 and incorrectly report all three Steering Tag modes as
supported during a device disconnection?

> =20
>  	return reg;
>  }
> +EXPORT_SYMBOL(pcie_tph_get_st_modes);

[ ... ]

> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f83..586c75b19e019 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
[ ... ]
> @@ -41,6 +42,12 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *=
dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> +{ return 0; }
> +static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> +{ return 0x7FF; /* Values that do not appear in normal case */ }

When TPH is enabled but a device lacks TPH capabilities, the live function
safely returns PCI_TPH_LOC_NONE.

Does returning 0x7FF in this stub introduce an inconsistency in the API that
forces callers to handle arbitrary magic numbers instead of relying on
PCI_TPH_LOC_NONE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506094623.2932=
7-1-fengchengwen@huawei.com?part=3D2
