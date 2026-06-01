Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954C3BFE3F
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325044; cv=none; b=I8RLTVf1vyKEUh8O9UluvKZ1/gFpa2qiKPpB2L/gU5erYolqLJk2UIxLzRFBZABPgN4unVUT4dpoyXRIwAJCoVPCX4MS4rhPZNfbIPMeZjxiYk0GcjjVM1giJQeZJEPiloRYDXmZBxHbmKBgTT+HwfhzJCS4y8jB93Sleow8AKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325044; c=relaxed/simple;
	bh=7BLVpNS5TAXT+k92avcACF2qkIPnYQvLuUsQ4wNB89k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qOQ5BaKsmjaG4/E2jWIQTcSNXd1Ust2Bi4HZpux5EIskWxCMTXXGeZ1xaTvMd/LM+zcim1pGDuLX1Qzq37lvrOEylQC79q3w14f240ko7RY8YY7+bcFD64l9zIQ67ftMOpHzGpnAWtbBHY0TRM+HFAhxypZbYCrRG4Hm6iVCGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CarPxYMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CarPxYMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919BD1F00893;
	Mon,  1 Jun 2026 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780325042;
	bh=xZiQAMS4i5menXEXm9LmXlVRIjzpBaxm+J/lKIec9Uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CarPxYMYa83aOPtb7BRUJCaiQnIyol2KtsllU/nO8gTPrv62/lzJ2OY+1zxfTWJU3
	 NuVDwNt9TIco8Wp4RR8trHpXhWfeP0j0gveXUYtQ+3KPETLqP90W6wG8xULExkApPX
	 M6vmCvObgkJpCW3kzZh6OT8usmFFoCBpEc0E/JG5RhORsvmqz1xXfAUp432rMGweGi
	 k1ZCugPZhjL7n5rOKnh2g6+DqyuXyKs2YVpsvwOiqYSwY9LWyJmPCU5V/FpaoCDhd2
	 2AreNsNPkcipYPU08Nnh4Xf+Us27qKLF2iayhYHt11pS+AQmN5KRGLZ2LjulqMzflD
	 9paV8i+8tU92w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] iommu/amd: Fix Use-After-Free in non-fatal probe
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601134204.2150602-5-praan@google.com>
References: <20260601134204.2150602-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 14:44:02 +0000
Message-Id: <20260601144402.919BD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The local variable `dev_data` is used uninitialized on the `io=
mmu_init_device` error path, leading to arbitrary memory operations.
- [Critical] Calling `amd_iommu_make_clear_dte` during device probe trigger=
s a NULL pointer dereference because `dev->iommu->iommu_dev` is not yet set.

Pre-existing issues:
- [High] Uncleared active DTE is copied to DMA aliases in `iommu_ignore_dev=
ice()`, bypassing IOMMU isolation.
--

commit 9fad373a2e7ad46c5f5a781a35dd6f77a626cb3b
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Fix Use-After-Free in non-fatal probe error path

When amd_iommu_probe_device() fails for optional features, the dev_data
remains globally linked with a pointer to the struct device. This patch
introduces amd_iommu_clear_device_dte() to clear the HW state and sets
dev_data->dev =3D NULL on the non-fatal error path to prevent a UAF.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel=
.org/

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c3b3750d4a22d..4ef6024c5a4ea 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -734,6 +734,15 @@ static int iommu_init_device(struct amd_iommu *iommu=
, struct device *dev)
>  	return 0;
>  }
> =20
> +static void amd_iommu_clear_device_dte(struct amd_iommu *iommu,
> +				       struct iommu_dev_data *dev_data)
> +{
> +	struct dev_table_entry new =3D {};
> +
> +	amd_iommu_make_clear_dte(dev_data, &new);

[Severity: Critical]
Does calling amd_iommu_make_clear_dte() during device probe trigger a null
pointer dereference?

If amd_iommu_make_clear_dte() is called during the probe error path, it
attempts to fetch the IOMMU via:

drivers/iommu/amd/amd_iommu.h:amd_iommu_make_clear_dte() {
    ...
    struct amd_iommu *iommu =3D get_amd_iommu_from_dev(dev_data->dev);
    ...
}

This internally accesses dev->iommu->iommu_dev. However, because execution
occurs during the ops->probe_device() phase, the IOMMU core has not yet
populated this pointer. This causes __iommu_get_iommu_dev() to return null,
leading to a null pointer dereference when accessing iommu->pci_seg later in
the function.

Could we pass the explicitly provided iommu pointer directly to
amd_iommu_make_clear_dte() instead of fetching it again?

> +	update_dte256(iommu, dev_data, &new);
> +}
> +
>  static void iommu_ignore_device(struct amd_iommu *iommu, struct device *=
dev)
>  {
>  	struct amd_iommu_pci_seg *pci_seg =3D iommu->pci_seg;
> @@ -753,14 +762,10 @@ static void iommu_ignore_device(struct amd_iommu *i=
ommu, struct device *dev)
>  	pci_seg->rlookup_table[devid] =3D NULL;
> =20
>  	/* Clear DTE if we have a live entry */

[Severity: High]
This is a pre-existing issue, but does iommu_ignore_device() copy an
uncleared active DTE to DMA aliases?

Just before clearing the DTE, setup_aliases() is called:

drivers/iommu/amd/iommu.c:iommu_ignore_device() {
    ...
	/* Clear aliases while rlookup is still valid */
	setup_aliases(iommu, dev);

	pci_seg->rlookup_table[devid] =3D NULL;

	/* Clear DTE if we have a live entry */
    ...
}

Because setup_aliases() is called before clearing the primary device's DTE,
clone_alias() will read the primary device's active, uncleared DTE and write
it to the alias's DTE. When the primary device's DTE is eventually cleared,
the aliases remain fully active and capable of unauthorized DMA, which bypa=
sses
IOMMU isolation for devices with aliases.

> -	if (dev_data) {
> -		struct dev_table_entry new =3D {};
> -
> -		amd_iommu_make_clear_dte(dev_data, &new);
> -		update_dte256(iommu, dev_data, &new);
> -	} else {
> +	if (dev_data)
> +		amd_iommu_clear_device_dte(iommu, dev_data);
> +	else
>  		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> -	}
>  }
> =20
> =20
> @@ -2517,6 +2522,11 @@ static struct iommu_device *amd_iommu_probe_device=
(struct device *dev)
>  err_deinit:
>  	iommu_ignore_device(iommu, dev);
>  out_err:
> +	if (dev_data) {

[Severity: Critical]
Is it possible that dev_data is used uninitialized on the iommu_init_device=
()
error path?

If iommu_init_device() fails, the code jumps to the err_deinit label and fa=
lls
through to out_err:

drivers/iommu/amd/iommu.c:amd_iommu_probe_device() {
    ...
	struct iommu_dev_data *dev_data;
    ...
	ret =3D iommu_init_device(iommu, dev);
	if (ret) {
		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
		iommu_dev =3D ERR_PTR(ret);
		goto err_deinit;
	}
    ...
err_deinit:
	iommu_ignore_device(iommu, dev);
out_err:
	if (dev_data) {
		amd_iommu_clear_device_dte(iommu, dev_data);
    ...
}

Because dev_data is declared without initialization and isn't assigned until
later in the function, it will contain stack garbage when the error path is
taken. This could result in passing a garbage pointer to
amd_iommu_clear_device_dte(), leading to arbitrary memory operations.

> +		amd_iommu_clear_device_dte(iommu, dev_data);
> +		dev_data->dev =3D NULL;
> +	}
> +
>  	return iommu_dev;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601134204.2150=
602-1-praan@google.com?part=3D4
