Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997759;
	b=G+5xpzWRW3ploOz4PRXSbZafx9pWFvYzrEVdFBiJC27wphDefVxZ+RE59wS3go7P5N2Z
	 mgnGqpVTZyojWw0bW0cdsTanqcVaLWbkIVfmwRVWDZJuFOTwMXtuptV3LuBrdG38mvDv2
	 31MxwukxMcEeMF9kx+YDF4exjBoDtahhEvkHk3ZEcvms2YL3QpaQlGCue0ymrz0OyABOb
	 XZi9hI6ipQqJ7Z4Mxyi6m76TBT32SsRzrEtw7p09SZd6eSa5frNY9XywG/IjmbuJN0iAY
	 F+5Kf/iPgqF246cYdEKlHAU0TzgwrfXeMhyDn3H2ufv+V/b1w1L4RyPQimnCZYVL/3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bXcaRn3cue+gl2zKwMpnwNDwBUBUe5u0O7jptOzXp2Q=;
	b=qQwZts1ercl0PhvUOylWVRZ+3kc5sd9LbxSvLxlArnnjX6aR/8/nFRi1tywC37PMMnxp
	 V7JpqA+VvUEOgQ8jlmp1eJIwteydDtE63I9rl+x+PwXsJAvlD4JeYJI8wkpyklnFZTHKi
	 Cis13txYTdbvUwzVvR2CUnOgvHWkybXWgOXDdb8/22+PUK2jPQqscEgsACSUokx120KCJ
	 So8hR91yVgwP08l8H/NCH9V34yFd164bdupZT9Y1SRjmr8njx5GCJBBVmtPpisvifor3o
	 xYLlVh558hFK+iP2w6YZwRkust3CEOz4E7lQ+CFaNB9fBTGqYJkDZ5q9AjMEeY+qKZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mq+4Ow56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26608606A32A;
	Wed, 18 Nov 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mq+4Ow56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42A31F000C5;
	Wed, 18 Nov 2026 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997759;
	bh=bXcaRn3cue+gl2zKwMpnwNDwBUBUe5u0O7jptOzXp2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mq+4Ow56gIEKUrXkfLniABx7AsmwRrCk0VWjxvl/+MaQ7AvBKTOzTbWrItvU5ZML7
	 1cMviFkP/RxdN2tgB1dQoLQq9rrHO2lsWVcUjbg7qFY6k/Zce+fKg13DspPRkeD2M0
	 dj7/QEYqe3zw3KpASpe4dDx+kh/gwWZ4sdHboDgZcoev8T27Js2x4uv6kW+cRZW37Q
	 18vbEprXyTG7vHpBVe1ssEPiAp9yta/Abyt6c3mWwvv6yihMG34mJogV7uNDDjrV40
	 32gEg3JhzocARDiUxIlO3dRGcADb94EKdduZdGl8At9BHaNeF4NQo/RelEF87K7jan
	 MZgF5RqlpEx+Q==
Message-ID: <sashiko-outbox-220692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 08/13] PCI/TPH: Add pci_tph_dsm_supported() helper
 to detect device TPH ST _DSM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-9-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:29:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] PCI/TPH: commit message names pci_tph_dsm_supported() instead of
  pcie_*
- [Low] PCI/TPH: missing colon after Return in pcie_tph_dsm_supported()
  kernel-doc
- [Low] PCI/TPH: duplicated _DSM check and unused helper in
  pcie_tph_dsm_supported()
--

commit 04c9ebfe20073a30540b5afa000403cf34aaeb34
Author: Chengwen Feng <fengchengwen@huawei.com>

> PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST _DSM
>
> Add new helper pci_tph_dsm_supported() to check whether the root port
> of a given PCI device exposes the TPH ST ACPI _DSM method.

[Severity: Low]
The commit subject and message refer to pci_tph_dsm_supported(), whereas
the function defined and exported by the patch is pcie_tph_dsm_supported().

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index c8b867dd233d4..c3d940745fe4d 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -587,3 +587,31 @@ void pci_tph_init(struct pci_dev *pdev)
>  	save_size =3D sizeof(u32) + num_entries * sizeof(u16);
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
>  }
> +
> +/**
> + * pcie_tph_dsm_supported - Check if root port exposes TPH ST _DSM
> + * @pdev: target PCI device
> + *
> + * Return true if root port of @pdev provides TPH ST DSM function,
> + * false otherwise (ACPI disabled or DSM missing).
> + */

[Severity: Low]
Return is missing a trailing colon ("Return:"), which causes kernel-doc to
warn that no description was found for the return value of
pcie_tph_dsm_supported().

> +bool pcie_tph_dsm_supported(struct pci_dev *pdev)
> +{
> +#ifdef CONFIG_ACPI
> +	struct pci_dev *rp =3D pcie_find_root_port(pdev);
> +	acpi_handle handle;
> +
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return false;
> +
> +	handle =3D ACPI_HANDLE(rp->bus->bridge);
> +	if (!handle)
> +		return false;
> +
> +	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,
> +			      BIT(TPH_ST_DSM_FUNC_INDEX));
> +#else
> +	return false;
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(pcie_tph_dsm_supported);

[Severity: Low]
Could pcie_tph_get_cpu_st_ext() and tph_invoke_dsm() share a helper with
pcie_tph_dsm_supported() instead of duplicating the Root Port ACPI handle
lookup and acpi_check_dsm() call?

Sharing the lookup would also avoid pcie_tph_get_cpu_st_ext() passing a
NULL rp_acpi_handle to tph_invoke_dsm() -> acpi_evaluate_object(), which
logs an acpi_handle_warn() on AE_BAD_PARAMETER when the Root Port bridge
has no ACPI companion.

In addition, none of the follow-up VFIO patches in this series call
pcie_tph_dsm_supported(), leaving the exported helper unused in-tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D8
