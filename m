Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75335A398
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625983; cv=none; b=up9WCQPn25WvjEb90L7oe0Ze6PVxPZYplY+5Bq7kNPEvvGSUlhhRHxHAAqSORmYghsPErAhYjlZMFNnNR6ILSiMYpq41mkBTyLRqDyGoeYJNz5bERokTXwjizsC0GZ5jL8Wrei0Aytl87N+q8O/ZeQFAn1sZiDKm/ZXiML4eLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625983; c=relaxed/simple;
	bh=WBlFuW4GjqRL25YpevkXL7zkUc76XGLQbTdYarPmXKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bav7rj7m9cPHZqHvkJ1L7L20i0phLw6sX1HGyUFcDJZgnzsdrxjIBmcoUAuqY0VZeazi2HM2DTou6MmHEsE2qUpTSTdCb0nOyTBrucpyEbcVlfemPa/gNrc2oupJoc/r/ENhEhci8NAkLe08O9EcRPK5/rxtmPH7PmJZgDuaaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKNoXjbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKNoXjbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973D1C2BCB8;
	Tue, 12 May 2026 22:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778625982;
	bh=WBlFuW4GjqRL25YpevkXL7zkUc76XGLQbTdYarPmXKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YKNoXjbAnEyCL9TYu01L2vNfYQuhFwcMIav7PlBvguCJx5euqD+TVofMkIhMhdtwP
	 x/lkzMOA5a9X8QLQ1rJIgm97optm3n1fli20EnUpBwdNlXjMuhkbCIXhsQLz3ogH5r
	 0AhAEiGuISxFFU9Z03cBFytNdIBNMfliH4vaDvS48qfc2iT7rG5/i0jb4pj2AGiaut
	 khtxiy5EvCyy/ThSBsYjDogxTLVKkA1zE75eSl88iHDxLYTkcWIZrmp07WfY8nlGQY
	 sC0aslt/n9C8o5woXhbYKoRP6xksNIBp0ThoHpJGsc2A/N/7g9XWggPVXp7eD40PJV
	 voHkUpFOMJ68g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/8] PCI: of: Set fwnode device of newly created PCI
 device nodes
Reply-To: sashiko@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511155930.34604-8-herve.codina@bootlin.com>
References: <20260511155930.34604-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 22:46:21 +0000
Message-Id: <20260512224622.973D1C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch fails to achieve its stated goal because `of_changeset_a=
pply()` unconditionally sets the `FWNODE_FLAG_NOT_DEVICE` flag, causing `fw=
_devlink` to ignore the explicitly set fwnode device.
- [High] Dangling `fwnode->dev` pointer leads to a Use-After-Free when the =
PCI device is removed.
--

commit 3981405050778ad9837921511772531243255e6a
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Set fwnode device of newly created PCI device nodes

This commit sets the fwnode device field of dynamically created PCI device
nodes to the corresponding PCI device. This aims to allow fw_devlink to
properly use the PCI device as a supplier, instead of falling back to the
PCI root bridge.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 7506208815a47..25fb02c3dc720 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -709,6 +709,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto out_free_node;
> =20
> +	/*
> +	 * Set the fwnode device in order to have fw_devlink creating links
> +	 * pointing to this PCI device instead of walking up to the PCI host
> +	 * bridge.
> +	 */
> +	fw_devlink_set_device(&np->fwnode, &pdev->dev);

Can this lead to a use-after-free regression when the PCI device is removed?

During PCI device removal, of_pci_remove_node() calls
device_remove_of_node(&pdev->dev) which explicitly sets pdev->dev.fwnode
to NULL.

Later, when device_del(&pdev->dev) is executed, its built-in fwnode cleanup
mechanism is completely bypassed because pdev->dev.fwnode was already clear=
ed:

    if (dev->fwnode && dev->fwnode->dev =3D=3D dev)
        fw_devlink_set_device(dev->fwnode, NULL);

This leaves np->fwnode.dev as a dangling pointer to &pdev->dev.

If the OF node outlives the PCI device, any subsequent operation that acces=
ses
the node through fw_devlink will dereference the freed pdev->dev memory.

> +
>  	ret =3D of_changeset_apply(cset);

Does this code actually prevent fw_devlink from walking up to the PCI host
bridge?

of_changeset_apply() invokes __of_attach_node(), which unconditionally
executes fwnode_set_flag(&np->fwnode, FWNODE_FLAG_NOT_DEVICE).

When fw_devlink attempts to resolve a supplier, it checks for this flag:

    if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NOT_DEVICE))
        sup_dev =3D fwnode_get_next_parent_dev(sup_handle);

Because FWNODE_FLAG_NOT_DEVICE is set, fw_devlink bypasses the explicitly
mapped np->fwnode.dev and walks up the tree to the parent device anyway.

>  	if (ret)
>  		goto out_free_node;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511155930.3460=
4-1-herve.codina@bootlin.com?part=3D7
