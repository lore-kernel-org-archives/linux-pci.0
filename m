Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D593164C7
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778628918; cv=none; b=UUf1DXmJtF4Qy8e4uFPDk+pXTC33KK83mQtdyUSAk5dXA2k2PdywCseUfvsG2eEmuJVzGMWexsqvQQ/G6T7RqlGn6P17InrGY7zLIRu3gdqGFYyByCTBQens1UvXfY48Krx+/T77/YDk2QJpH/h1siyBccp/rJUyWb6PEoZM9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778628918; c=relaxed/simple;
	bh=wn5Pc69YvnBGGBNPNh+rTLc1pFiFbgC3WhcD/TPTdH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNl7ceNyj3voExgWICjTSu4e6QQOIyIbLQj0eejtJDS1jKWaTm4lUarBFo3oh57dMgcQKdu95DpKJ976s7obX/nDLLE988Y7utzpCa4IIVOrmfAJjaofyhwgAD9jwy3jRZ4lUHQkdBgC8nR/Jwzp7u48HXdclB3dBnl4YjVckb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBJ3WeCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBJ3WeCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0F8C2BCB0;
	Tue, 12 May 2026 23:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778628918;
	bh=wn5Pc69YvnBGGBNPNh+rTLc1pFiFbgC3WhcD/TPTdH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qBJ3WeCMHVovcI5A7g9TIqf/QblcXdFtIuvJnce03x0AguX/RZzUvp85YUGG7UD2s
	 UmYTt4BqnO3i+L6zTeHmW5B9xIEKkodgPQy/Zmb2UF6qgH3fP9PjJHekHtkutWzPBt
	 lZpZg9kDmOxy0P8m+tBYU9Nw9wC+y+l8fcnF0+C5MOjrNO/fOFX0j9zSvQJLVJ1F+5
	 eLx9g+Q3bGBC3YCWLCzXOKucJyt8Xt4wrGcTMgH8hxNK7SnPdYivRPTDgUyyW5IGLn
	 EZhmum7IL8Of5M2hM5/UektjVBCtFx/6WUVZSre41Z0EAaZ7EIPNAsSuDLRGzUsiaq
	 wNNC+XRzpG2sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/8] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511155930.34604-9-herve.codina@bootlin.com>
References: <20260511155930.34604-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:35:17 +0000
Message-Id: <20260512233518.0B0F8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing `fwnode_dev_initialized()` causes consumers of the PCI ho=
st bridge to indefinitely defer probe or suffer a 30-second boot delay.
--

commit 77e0afe5e647b8f57bcce68df03d0b7040fbfe25
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge node

This commit removes the fwnode_dev_initialized() call during the creation of
the PCI host bridge node to allow devlink to correctly create links for
devices in device-tree overlays.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 25fb02c3dc720..53a8a4f30eb66 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -811,7 +811,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bri=
dge *bridge)
>  	 */
>  	of_node_set_flag(np, OF_POPULATED);
>  	fw_devlink_set_device(&np->fwnode, &bridge->dev);
> -	fwnode_dev_initialized(&np->fwnode, true);

Will removing this cause consumers of the PCI host bridge to indefinitely
defer probe or suffer a 30-second boot delay?

The commit message indicates that the device related to this firmware node
is handled using driver core mechanisms and is fully compliant with devlink
expectations. However, isn't bridge->dev a structural device with no bus
(dev->bus =3D=3D NULL)? If so, it would never undergo driver matching or
probing.

If fwnode_dev_initialized() is removed, FWNODE_FLAG_INITIALIZED is cleared.
When consumer devices are parsed, fw_devlink creates a managed device link
from the consumer to bridge->dev, expecting it to eventually probe. Since
the bridge device never probes, its status remains DL_DEV_NO_DRIVER.

When the consumer device attempts to probe, device_links_check_suppliers()
might see a dormant supplier and return -EPROBE_DEFER.

Additionally, because device_add(&bridge->dev) executes before
of_pci_make_host_bridge_node() attaches the fwnode, device_add() would see a
NULL fwnode and skip the fallback fw_devlink_unblock_consumers() call.

> =20
>  	ret =3D of_changeset_apply(cset);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511155930.3460=
4-1-herve.codina@bootlin.com?part=3D8
