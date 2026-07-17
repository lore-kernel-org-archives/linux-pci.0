Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1CE2F12CE;
	Fri, 17 Jul 2026 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301566; cv=none; b=hFeJzzs35IvIkU29Pumz4bNSLZ4b65bit0VxF848NYz72Dbc1lOx+A0cqJBbpywgu+dolbIC3FNVBFFRY7p/H0E0jSoDGH0yBHew+/Ph3st6hDvIoELuzuBuSbtoNgzlZ4me/ALpt+Zgt3y8Ovir/LkmDIcf7d+m5BOAVPV5STI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301566; c=relaxed/simple;
	bh=6nGCmrXhFOVqAcm7A1Ay7RO0vqe4L883h6UEb/W1ixU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHU8VVXIlCH7NVmwRyMem5uxRrYWSQEF3cwur+wTQSTtIHre7eU8IjRojxRq2txicG2D2cym5f4duQx6L2gTJHJzzmDzC/KtEOmplSBYfuFPf6oN/8S36d0b/HtFHnQR+sBsLE0UXtyj2E8nEFVR3fzWidC41rlvXN3OMpx2kuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG0V4XgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG0V4XgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C991F000E9;
	Fri, 17 Jul 2026 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784301564;
	bh=FNm7BjOn5buSAIRfppowkHnyCHe4l0vf8qiel8Bf0+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RG0V4XgUS9uOhUsG1XeI32sXXYNbo65IQ4P1/DDlDED5aAop9EGDwT4xGo8YlKxnW
	 iBRYnwuPRT30Td6rbW/yhhESITUK2CaXptP63vnx1HSfQcnglMFLU5ewDHSW6VWw5Q
	 gxSfBLKMlcsm9GP6A8nDtKP+W+CQcBRHoQ7FRlxU4F+sqqqiP4+SyDgR8/9Jj4W6h0
	 Hdr09Sll6MykXYbav+NqH2mXKgWYbLn74zxZAX8zO/gl7NJ755q0MQuB68Z8cagPsG
	 H/jNe9JmirR4okyupata0NgcJMelrp87dlvR01jsk+OcRmsyEHbRMuvV0D0W9O9uUc
	 bjhJMIql7NiKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/10] PCI: of: Guard against node removal with
 incorrect np->data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717145147.823749-11-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-11-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:19:23 +0000
Message-Id: <20260717151924.38C991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe cast of `np->data` to `struct of_changeset *` without type =
validation, leading to type confusion and potential memory corruption.
--

--- Patch [10]: [PATCH v10 10/10] PCI: of: Guard against node removal with =
incorrect np->data ---
commit 3c2e9ae91c2c8b16b99779200dfab12179834af1
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Guard against node removal with incorrect np->data

This commit adds a check for !np->data in of_pci_remove_node() and
of_pci_remove_host_bridge_node() to prevent NULL pointer dereferences. It
protects against dynamic nodes created by device-tree overlays that do not
populate np->data.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 28896f748e8d3..9f35e1e07cdcd 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -654,7 +654,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	struct device_node *np;
> =20
>  	np =3D pci_device_to_OF_node(pdev);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC) || !np->data)
>  		return;
> =20
>  	fw_devlink_set_device(&np->fwnode, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does this still leave a type
confusion issue if np->data is populated by another subsystem?

While this patch prevents a NULL pointer dereference, it doesn't verify tha=
t a
non-NULL np->data actually points to a struct of_changeset. On some platfor=
ms
like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier (e.g., in
pci_dn_reconfig_notifier()) intercepts node additions and populates np->data
with its own structure, such as a struct pci_dn.

If that happens, and the device is later removed, of_pci_remove_node() will
see a non-NULL np->data, proceed past this check, and pass the foreign poin=
ter
to of_changeset_revert() and of_changeset_destroy() lower down in the funct=
ion:

	fw_devlink_set_device(&np->fwnode, NULL);
	device_remove_of_node(&pdev->dev);
	of_changeset_revert(np->data);
	of_changeset_destroy(np->data);

Could this result in memory corruption or a kernel panic when the wrong type
is cast and dereferenced?

[ ... ]

> @@ -750,7 +750,7 @@ void of_pci_remove_host_bridge_node(struct pci_host_b=
ridge *bridge)
>  	struct device_node *np;
> =20
>  	np =3D pci_bus_to_OF_node(bridge->bus);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC) || !np->data)
>  		return;
> =20
>  	fw_devlink_set_device(&np->fwnode, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but the same type confusion issue
seems to apply here in of_pci_remove_host_bridge_node().=20

If the host bridge node's np->data is populated by another subsystem with a
different structure, will passing it to of_changeset_revert() and
of_changeset_destroy() cause memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D10
