Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890A40A93D;
	Wed,  8 Jul 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506571; cv=none; b=DpQuC7xZ5MAQLiUR252TdpEG7F+1QuwNkUu5KNy5AEkrd316veMH+GcJJIOeDrpcAoCEEpyj51+a6Y/+BmlrFcwjOr6n35GLWU/zPPIBgnRDmST6ikD90/YOYZv5SzMVLmYLWOmQ63lVUFDIKjvMLufR8QgIw6mGmf8Sp2Orz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506571; c=relaxed/simple;
	bh=B8hXId4ZX7f7S6ngFkklUHJsscnK0hXfK5iRasErFFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=owRicMIxz4UAXz/dgwizYqvQn6KW/1eboeImBu6oA1lXxrOokgRNdtAoE4SYromVeaOsfftUi9+xG5UIdyeJOrOGZjTGgbll18Yj8afVBocYQV1FrcdyT8ZpfR7yw0Rhax1c2I+42KmF8mxp70mQHLgZfR3EkzJImdts4lblPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8c7LXCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8c7LXCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBD31F000E9;
	Wed,  8 Jul 2026 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783506562;
	bh=2PpCNt/AJnUvC3cEvtXRGP6pxtabFkxW29xf7fvWiQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8c7LXCOF2D7qf5eVX5vap8QW7DQBy97FEOFgwsGK4WGifhshlKcw3L04itM/0pKL
	 +wecITIPhRX7uq2khpKMrgGxatB8zYAwz+LGvKDphEcx6S1w/bibqJMc6vQQPRc6Bt
	 CIXXJmg79GJ3ZjmL7no032XRnpjugfYK7XesXzAVdE9Y3J1U2kvYWQl7wZbVO0i35Q
	 JJUFF/uMCKNQU2v5j4dReY4zMrlWeJY/98cNiYHtYaI/rFROCRACHam26VAlV5auiL
	 xysmdjitaIn0tpyBBy/how3q/BDcv0m02X9PbVNmBd6pox6cspxgXi7fidw+WSsYrA
	 1hBKZC8dzturw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/9] PCI: of: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708100302.517792-7-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:29:21 +0000
Message-Id: <20260708102921.BDBD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer in `np->fwnode.dev` on error paths and during bri=
dge removal, leading to a potential use-after-free.
--

--- Patch [6]: [PATCH v9 6/9] PCI: of: Use fw_devlink_set_device() ---
commit e05d94ee3b1f4fa9d5ff1b29db6b40e43eca7313
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Use fw_devlink_set_device()

The code directly set the fwnode.dev field. This commit updates the code
to use the dedicated fw_devlink_set_device() helper to perform this
operation.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 8b18c4ba845cf..ee9eb384b377a 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -803,7 +803,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bri=
dge *bridge)
>  	 * bus. Avoid any new device creation.
>  	 */
>  	of_node_set_flag(np, OF_POPULATED);
> -	np->fwnode.dev =3D &bridge->dev;
> +	fw_devlink_set_device(&np->fwnode, &bridge->dev);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a
use-after-free on error paths?

In of_pci_make_host_bridge_node(), if an error occurs after setting up the
fwnode (such as of_changeset_apply() or device_add_of_node() failing), the
error path removes the node from the tree and releases its reference, but
fails to clear the np->fwnode.dev pointer:

out_revert_cset:
	np->data =3D NULL;
	of_changeset_revert(cset);
out_free_node:
	of_node_put(np);

Because device_remove_of_node() only clears the forward pointer
(dev->fwnode) and not the backpointer, np->fwnode.dev remains dangling. If
another thread holds a reference to np, the node outlives the function.
When the bridge is later freed, any concurrent access via
get_dev_from_fwnode(&np->fwnode) could dereference freed memory.

The same dangling pointer issue appears to exist in
of_pci_remove_host_bridge_node() during teardown:

void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
{
...
	device_remove_of_node(&bridge->bus->dev);
	device_remove_of_node(&bridge->dev);
	of_changeset_revert(np->data);
	of_changeset_destroy(np->data);
	of_node_put(np);
}

>  	fwnode_dev_initialized(&np->fwnode, true);
> =20
>  	ret =3D of_changeset_apply(cset);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D6
