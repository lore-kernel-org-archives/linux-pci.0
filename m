Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38E421F12;
	Wed,  8 Jul 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506885; cv=none; b=exGg4LzoOuDZEcPtEUZFBkhFEfyA7rJRG1cuWwYkxVnFNA1iR614ZOzGH9MP1foIFEINexw2dDeCNgbAu6lg97IhHKG0VKW7qeut1oKkv30o5U+i5gPdnegBZnxCdxKv5TUAxAc0ksnsf0xlUQxcZJFEwCYGlkdCapF2qr9K7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506885; c=relaxed/simple;
	bh=Pu3q3ejMkUkldtjK5IUsHGFjzDzWqvMb4M+H/96BbwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q2Va18tomVVGJY3/1itwymFsuKc3+8eWI6ACXJCcRSTUueNhIkCnTBlOn3mMV8XbvoHItnNzI2NcmTXUYL6WfJrv1Slq+gR8hKxpmbcUVNoEuX1t0sm8aD0wrwSysMay3zeyKfYgmt1CFOHzTiF+rCuuZxVeigtsVGoz9bn/PJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC2NKuNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC2NKuNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2421F000E9;
	Wed,  8 Jul 2026 10:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783506875;
	bh=fR/Q89ysDf90d2ah5UqcxT8SNzthQDRJnKPh9K8lgao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TC2NKuNyzCSho/D5CtWhUBkTZY/BgPQMpXZUJ1qsBDkxB0epoiXIVH9C9/A6KezV9
	 iLwxMWEJl6ZNU/4veWMr8ZQgxqKqZJFarz90lQ7lkJHXrPyjavsE7pHNKNndf719og
	 /sSDu0EnImNyfa7hJbI/s6p/nfZ1ATMvowwtXWRd0rQcnItrtvJUBFl7715mRBSsOh
	 DEjMcGjy7PQibXs6lSCKXo6HlrTAudv4HbikjL8t4tGnRZhpHljfnYWilMxYxtN2Fo
	 z01HE+8GVzVM48eVrjn72pI8wax7dmr12Woj3p7K9JliDY1IT9srGWGLxOOzzZDe0v
	 NuvusPYVxfriQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/9] PCI: of: Clear fwnode->dev during root bridge
 node removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708100302.517792-8-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:34:34 +0000
Message-Id: <20260708103435.2E2421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing fw_devlink cleanup in the error path of of_pci_make_host_b=
ridge_node(), leaving a dangling fwnode->dev pointer.
- [High] Kernel panic on removal of overlay-provided PCI host bridge nodes =
due to unsafe changeset revert.
--

--- Patch [7]: [PATCH v9 7/9] PCI: of: Clear fwnode->dev during root bridge=
 node removal ---
commit 9e6873c21d6442ce4222fe6e9ac417348c8b3fbd
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Clear fwnode->dev during root bridge node removal

This commit clears fwnode->dev during of_pci_remove_host_bridge_node() to
prevent a dangling pointer. It ensures fw_devlink_set_device() is called
with a NULL device before the fwnode is cleared.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ee9eb384b377a..8dd558a490bbd 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -743,6 +743,7 @@ void of_pci_remove_host_bridge_node(struct pci_host_b=
ridge *bridge)
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
> =20
> +	fw_devlink_set_device(&np->fwnode, NULL);

[Severity: High]
This is a pre-existing issue, but does of_pci_make_host_bridge_node()
also need to clear the fwnode->dev pointer on its error path?

If device_add_of_node() fails in of_pci_make_host_bridge_node(), it jumps
to the error paths but leaves np->fwnode.dev pointing to the bridge device:

drivers/pci/of.c:of_pci_make_host_bridge_node() {
	...
	fw_devlink_set_device(&np->fwnode, &bridge->dev);
	...
	/* Add the of_node to host bridge and the root bus */
	ret =3D device_add_of_node(&bridge->dev, np);
	if (ret)
		goto out_revert_cset;

	ret =3D device_add_of_node(&bridge->bus->dev, np);
	if (ret)
		goto out_remove_bridge_dev_of_node;
	...
out_remove_bridge_dev_of_node:
	device_remove_of_node(&bridge->dev);
out_revert_cset:
	np->data =3D NULL;
	of_changeset_revert(cset);
out_free_node:
	of_node_put(np);
	...
}

If a concurrent thread acquired a reference to np, could the node outlive
the error path and result in a use-after-free where fwnode->dev points to
freed memory?

>  	device_remove_of_node(&bridge->bus->dev);
>  	device_remove_of_node(&bridge->dev);
>  	of_changeset_revert(np->data);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
of_changeset_revert(np->data) unconditionally cause a crash when removing
an overlay-provided PCI host bridge node?

When an overlay provides the device tree node for a PCI host bridge, the
node inherently has the OF_DYNAMIC flag set. If the bridge is removed,
of_pci_remove_host_bridge_node() assumes the node was created by
of_pci_make_host_bridge_node() and executes of_changeset_revert(np->data).

Since np->data is NULL for standard overlay nodes, does this result in a
NULL pointer dereference in __of_changeset_revert_entries() when it tries
to evaluate &ocs->entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D7
