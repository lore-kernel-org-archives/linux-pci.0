Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FE5221D6
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068973; cv=none; b=dqLASz6gckHjQyB4rpFkO41Opmcg2mPM3j803V1d3A04UFjsMExoJDk5x9egRe/4Uc9gxmwl/UYYyHZrSqtghgIhFJuWZ8w2EmhMtFqTesXoJtbm6mWy0txLW0RdNLzQsL4pNAuAGJ/dq8NQ41yyOl2sZMcwXglimHprD8+HZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068973; c=relaxed/simple;
	bh=Wkon9DRFcqLc6nvHHqetLyKWi86tX47HBY90RH3Z9m4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DOuWnPrxN77Clq5hHV0nqjRI45yAHe/TOs+D9Iz0YyGSebvQtIZzjvM4s6sb59kpY1AhTA1vPYtLlwteATm8fLHBAXMaw5PVkxy87ZTRm3dEKXCKgFane1p/ahx9AN2QZhd788iUsts1ih7ef6xydrlUV+fnRhMx3ufeTULUpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaQtoP9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaQtoP9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51201F000C4;
	Thu, 15 Oct 2026 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068971;
	bh=lleSWzBnRdxviikNNWEgicdVg5ef4qlsZtp+vJfC0DI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jaQtoP9tv6o82ZpvVYz5gIyaRXyp+0abxKiyno+18AS77yW8sR5QcQZd4fSbz2hmc
	 xTLJnH0XFJBo5AVc/8SDPDKpE2RdWzdb+pd5oX9q2n8DSrT+4pGTwSBZR/JcT/2i0F
	 6do05uMNwyZ1LH6et5sWpgUGWJOdary5vfNHIlOz7/n40bxWxVe3N80VSNE2+lhtnZ
	 nsRHWZKdg9Ly+D49zJeZYyZixmTH6kk6WPgk3DKezFTua78yIhx1l3AFYZlHQYvLTG
	 /uG1CZF3M/tXf69UF72++ln/EI13HsP5Z9zjOAjgO+Bf5wmMj/50jeVvlXPfAcaZo1
	 ndVtXMVoASPkQ==
Message-ID: <sashiko-outbox-172875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20261015124843.203905-1-mario.limonciello@amd.com>
References: <20261015124843.203905-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:56:10 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci: missing EXPORT_SYMBOL for pci_realloc_enabled_by_user() breaks=
 amdgpu
--

commit 9eeda1e99dc9a34bbbe5670a252bc894b1208696
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amdgpu: Gate VFCT bus fallback on pci=3Drealloc

This patch modifies the soft filter system to gate the VFCT bus fallback
so it only runs when pci=3Drealloc is explicitly requested by the user. It
introduces pci_realloc_enabled_by_user() in the PCI core and uses it in
the AMDGPU driver.

Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadc=
h@gmail.com/

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index f9315e0472fe9..9651260278c18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
[ ... ]
> @@ -459,7 +457,10 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_devi=
ce *adev,
>  	if (vhdr->PCIBus =3D=3D adev->pdev->bus->number)
>  		return 0;
> =20
> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> +	/* Allow bus renumbering only when the user requested pci=3Drealloc. */
> +	if (!pci_realloc_enabled_by_user())
> +		return -ENODEV;
> +

[ ... ]

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed16ef7c26fa7..d9450585082c0 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1799,6 +1799,11 @@ static bool pci_realloc_enabled(enum enable_type e=
nable)
>  	return enable >=3D user_enabled;
>  }
> =20
> +bool pci_realloc_enabled_by_user(void)
> +{
> +	return pci_realloc_enable =3D=3D user_enabled;
> +}
> +

[Severity: Low]
Will this cause a module build failure (undefined reference) if the amdgpu
driver is compiled as a loadable module (CONFIG_DRM_AMDGPU=3Dm)?

Since setup-bus.c is built into the core kernel and pci_realloc_enabled_by_=
user()
lacks an EXPORT_SYMBOL or EXPORT_SYMBOL_GPL macro, the linker won't be able
to resolve this symbol during modpost for amdgpu.ko.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015124843.2039=
05-1-mario.limonciello@amd.com?part=3D1
