Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8832C11E6
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782504046; cv=none; b=Xu/laHVvZv1shmNaNKy4aLaNoOK4vjJxxH2PRCLGBwqxOwAPkENZc8UjIjTbgdV+OL6BmFX5q6uBfmt/NOgn15gSlgHTi2sVZmXBDtKRYzAlcJwGoL5u1Wo9aHOtzK+WOa9rGoipQUX0Qp0hv/TgryPAcmYlOyv+2lSNxHpmdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782504046; c=relaxed/simple;
	bh=KHcIVMLyXlvcUI0gbxE/mGSguXZikEaX0woi607azvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JccKxglp8HbgqlSW4mYvX7WYuBWgh8rBH7bNYXvleqwnFv1p3ozSe7LWpj+dYe1D2m7YSHCV+IT6mTjxUaq7FSD1GRf5og/t+HtdKo+bIG8DaVf7RJR63G1C7lHgzSVbJK88SnI4C4UudWu+4BvihN5t0rFkIU8scKLAgh4Mr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZgqHPCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZgqHPCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DBB1F000E9;
	Fri, 26 Jun 2026 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782504044;
	bh=atFWSTjqWak5J9+Yy+N0eO7bPgbI0eYiODf4M/kfBwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZgqHPCp7C61S072tfQ39vDCd8q3AwZKmmQaAIyo+a1q6XuLSS4o5HV4uEbeqIC1l
	 RB4pTipkGihWuHeIAC0n4FZi9lfl7Z70LgDpFuV/wMeUVSYpQ958e9cwGyH5hp3oEB
	 HrwnY84DnmH2vvZoB1+mQKaSUwo8oHSJZrMPr1TrhOXD29evC8mOenZfyU5PEk3rGg
	 aQfnuMl0UfvXPg3t0KIb/dSdKoUsy8OvZgaK+7t8juihCBsemBGtgssoqol6CSeooC
	 y2heLEv+aIV1YRXP6gMW9+7YBUx2Z8b73vTJxPDquk04oqAwZw+pgLeFZy3jYlH0wu
	 iKnuVxRSnMU+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] pci: fix UAF when probe runs concurrent to dyn ID
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260626-pci_id_fix-v1-3-a35c803f1b95@garyguo.net>
References: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
 <20260626-pci_id_fix-v1-3-a35c803f1b95@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 20:00:44 +0000
Message-Id: <20260626200044.B1DBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Passing a pointer to a stack-allocated `struct pci_device_id` =
to driver `probe` functions introduces a stack use-after-free vulnerability=
 for drivers that store the pointer for later use.
--

commit 2537209ca17dda70306c583f96a659580e419b4a
Author: Gary Guo <gary@garyguo.net>

pci: fix UAF when probe runs concurrent to dyn ID removal

Dynamic IDs are only guaranteed to be valid when dynids.lock is held, as
remove_id_store can free the node. This patch copies the matched ID in
pci_match_device to avoid the UAF.

Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 464ee52346fa8..2c76bba9a7156 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c

[ ... ]

> @@ -474,15 +475,14 @@ void pci_probe_flush_workqueue(void)
>   */
>  static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pc=
i_dev)
>  {
> -	const struct pci_device_id *id;
> +	struct pci_device_id id;
>  	int error =3D 0;
> =20
>  	if (drv->probe) {
>  		error =3D -ENODEV;
> =20
> -		id =3D pci_match_device(drv, pci_dev);
> -		if (id)
> -			error =3D pci_call_probe(drv, pci_dev, id);
> +		if (pci_match_device(drv, pci_dev, &id))
> +			error =3D pci_call_probe(drv, pci_dev, &id);

[Severity: Critical]
Could passing a pointer to the stack-allocated struct pci_device_id to the
driver's probe function introduce a stack use-after-free regression?

Some drivers, like nsp32 and ata_generic, save the pointer to the ID passed
into their probe function for later use. For example:

drivers/scsi/nsp32.c:nsp32_probe() {
    ...
    data->pci_devid   =3D id;
    ...
}

When normal operations later access this saved pointer, won't they derefere=
nce
invalid stack memory since the __pci_device_probe() stack frame has already
been destroyed?=20

For example, when reading from procfs:

drivers/scsi/nsp32.c:nsp32_show_info() {
    ...
    model    =3D data->pci_devid->driver_data;
    ...
}

Similarly in ata_generic_init_one(), the id pointer is passed as host priva=
te
data for later use in ATA operations:

drivers/ata/ata_generic.c:ata_generic_init_one() {
    ...
    return ata_pci_bmdma_init_one(dev, ppi, &generic_sht, (void *)id, 0);
}

>  	}
>  	return error;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-pci_id_fix=
-v1-0-a35c803f1b95@garyguo.net?part=3D3
