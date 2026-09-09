Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD921ABD7;
	Wed,  9 Sep 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941877; cv=none; b=KvbT8fDWZocbvN9TfjmwZ3i2OGAzF8HrXEB7pGuQiuqM9ZsSFKfYHEvBnjj15/MHVw7B47GySz/bFOf5UoIb0F0XAGOxe32D/5yncQJAuXGoTAL4vNx/NsUpFP5Ryxrori70XLxdzOGZ9arJEyY0/WRpVf0z8C5Q4ute+TX2TPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941877; c=relaxed/simple;
	bh=OsIFQr4zAu5DAIm2yWuwKKj8MCQUHmn01bgfauVqAnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uwc5bGCZh9Cn8EXQadLYn5EZ52L4X9bYXjr8j0isUZSmly2pDJL8960qzTEcopggwmqzaAkMGI9AFXm9hriPgUVc1A+3fkFSBie8bO5PSq6VTXiQatc/8v/8TwDFYiOxfT5Copt2E79hhPn4eKt0+tP0sUvqA3l8/wle+0ULgf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRDKdi0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRDKdi0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E91F00A3A;
	Wed,  9 Sep 2026 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941875;
	bh=znI3mxLmYJ4Zn/MS6hx/rXnP0YQkcYfi5GUOixdw6A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VRDKdi0g7cLLjIwK3DAg9glB7BGgNs7hFL/94ccDC7642LNs53hXqBAPa2FbBWfQ4
	 W3Hwth1IdE33LHdopflJxRWdaSDbpnhl2M0U+A8PhKibxe+PHzQMv0ebYxtVOzb3uO
	 cIspYUtlvXc2Ms/aOWU+d41/DVuau7lAegWPelm2GN+tbZCBcl/FQ/NJRfsIgeI9P5
	 YmKc51ECOD5EfkWFaZZF3aru06tU2LX1W1yJUDhk8ExN9sD+f87ajHi74b7KVK2j8a
	 UBDf3GHLUH8vwwJSiDSMnUEbNaqLbE4/xTUVQWV+Pe4dFjBOrunWzdv1oPHi/+dtOQ
	 E7XnP6I/gesIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909080114.591938-11-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-11-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:17:54 +0000
Message-Id: <20260909081755.444E91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing NULL check on `np` in `of_pci_remove_node` and `of_pci_rem=
ove_host_bridge_node` leading to kernel panic.
- [High] Dangling pointer in `pdev->cset` and `bridge->cset` after freeing,=
 leading to potential use-after-free or double-free.
--

commit 506858ef76ab83f59a005bd51f3fde0f4d73a6a2
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Avoid np->data usage for the node changeset

This patch modifies how OF changeset references are stored during PCI node
creation. Instead of using np->data, which can be altered by platform code,
it stores the changeset in pdev->cset or bridge->cset. This ensures the
correct changeset is reverted and destroyed during node removal.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 0a5797652e183..cd87128c71ddc 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -732,15 +732,16 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  {
>  	struct device_node *np;
> =20
> -	np =3D pci_device_to_OF_node(pdev);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!pdev->cset)
>  		return;
> =20
> +	np =3D pci_device_to_OF_node(pdev);
>  	fw_devlink_set_device(&np->fwnode, NULL);

[Severity: High]
Will this result in an invalid pointer dereference if np is NULL?

The previous implementation had a NULL check for np, but the new code compu=
tes
&np->fwnode unconditionally. If pdev->dev.of_node is cleared prior to remov=
al,
pci_device_to_OF_node() will return NULL, causing fw_devlink_set_device() to
dereference an offset address.

>  	device_remove_of_node(&pdev->dev);
> -	of_changeset_revert(np->data);
> -	of_changeset_destroy(np->data);
> +	of_changeset_revert(pdev->cset);
> +	of_changeset_destroy(pdev->cset);
>  	of_node_put(np);
> +	kfree(pdev->cset);

[Severity: High]
Is it possible for of_pci_remove_node() to be called twice for the same dev=
ice?

If so, leaving pdev->cset as a dangling pointer could lead to a double-free.
Should pdev->cset be set to NULL after kfree() so that the earlier
if (!pdev->cset) check can prevent a second execution?

[ ... ]

> @@ -828,16 +828,17 @@ void of_pci_remove_host_bridge_node(struct pci_host=
_bridge *bridge)
>  {
>  	struct device_node *np;
> =20
> -	np =3D pci_bus_to_OF_node(bridge->bus);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!bridge->cset)
>  		return;
> =20
> +	np =3D pci_bus_to_OF_node(bridge->bus);
>  	fw_devlink_set_device(&np->fwnode, NULL);

[Severity: High]
Can np evaluate to NULL here?

Similar to the issue in of_pci_remove_node(), if pci_bus_to_OF_node() retur=
ns
NULL, the missing NULL check will cause a crash during the &np->fwnode poin=
ter
arithmetic.

>  	device_remove_of_node(&bridge->bus->dev);
>  	device_remove_of_node(&bridge->dev);
> -	of_changeset_revert(np->data);
> -	of_changeset_destroy(np->data);
> +	of_changeset_revert(bridge->cset);
> +	of_changeset_destroy(bridge->cset);
>  	of_node_put(np);
> +	kfree(bridge->cset);

[Severity: High]
Could this lead to a use-after-free or double-free on bridge->cset?

If a removal API like pci_stop_root_bus() is invoked multiple times, the
dangling pointer bypasses the if (!bridge->cset) check at the start of the
function, resulting in a double-free on the changeset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D10
