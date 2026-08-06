Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24846D574
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016283; cv=none; b=scnxr4Dx30GOLEmy/D3IwdXgOX+DqUtKqXptqgVlTTgNc95m5by2G8orOUm1In2yGIwwCjCVORC1Gg2NNqqkwZCgAkfMHgFVgzYSlDH+VmFx8aNkOCsrozvnJTAjxxvkPE4do+ywiuRuk5I5ILur1+Th5+6kkKmJpYELFAdxtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016283; c=relaxed/simple;
	bh=g4lvJe19CX+yg/jtr9NFUiLVSItR7hkdaGsQ/7bYWzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hO79lMuIP6dYLyEJf92TLtlxcBFPCKw0U+YOpWHBM31urtABWbuHDqNTrm28EvgfkxXwrXK4mxXGOOCAWucNoxot1KujHhRSjYftrX93aby3mFeDgszNRcihzzIB4Ek6UTA59EYoAdnNxunxZ2d7l+XNSWy7+bK+nuys4PWfYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFxh6DX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFxh6DX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38101F000E9;
	Thu,  6 Aug 2026 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016275;
	bh=3aMkH32qwTzW2/o7t/BCY7MDSOxI30KjbL0qDwQGI6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFxh6DX8sHk6bf7VHqAzpKGE681SoaQAtjo112oT2LGxEh42/T6IIH858mdLWmL5R
	 HVuiqUS8RU0tH38Pv7U8oVZKejW3EikV//zFFq9JAGygKusKxmUfFybl16oJmoLQRx
	 VZtwxKwJEpxeB/FkRTckEFqya/aY2O0gEHUaYMkeUaDpz+hLSiMO8trUWZs+bi9M+Y
	 pe9E3NYbgW/xCJty4EBUdajO+9x5ckYA8NKVAPwvntQFnhy8Q3bqd539XBOrTOZojm
	 nLiFSNK7q30nt2ejKHsfiuDExqONGgW0CNapP5mSliheDwjHIZPIE3nFZ2rg1diEUK
	 1Ozq6OkOJXdUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] PCI/P2PDMA: Report ACS ports when the paths
 share no upstream bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-2-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-2-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:37:54 +0000
Message-Id: <20260806113754.C38101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional host bridge whitelist warnings cause severe log sp=
am during silent P2P provider discovery.
--

--- Patch [2]: [PATCH v2 02/13] PCI/P2PDMA: Report ACS ports when the paths=
 share no upstream bridge ---
commit b1b70f40984c0b642c7221458a704c5fa967c62e
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Report ACS ports when the paths share no upstream bridge

A provider and a client below different Root Ports share no upstream
bridge, so the search ends without a match and the walk takes the
host-bridge route directly. Neither path is examined for ACS, so no
redirect diagnostic is emitted and the host-bridge whitelist warning
stays suppressed.

Examine the paths before taking that route, so every redirecting port is
named in the pci=3Ddisable_acs_redir=3D hint.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 2d3b380cc5781..801c183ae6b7e 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -740,8 +741,12 @@ calc_map_type_and_dist(struct pci_dev *provider, str=
uct pci_dev *client,
>  		dist_a++;
>  	}
> =20
> -	*dist =3D dist_a + dist_b;
> -	goto map_through_host_bridge;
> +	/*
> +	 * The paths share no upstream bridge, so the request can only reach
> +	 * the peer through the host bridge. Examine the client path anyway,
> +	 * so the diagnostics below name every ACS port on both paths.
> +	 */
> +	no_common_upstream =3D true;
> =20
>  check_b_path_acs:
>  	bb =3D b;

[ ... ]

> @@ -761,6 +766,9 @@ calc_map_type_and_dist(struct pci_dev *provider, stru=
ct pci_dev *client,
>  	*dist =3D dist_a + dist_b;
> =20
>  	if (!acs_cnt) {
> +		if (no_common_upstream)
> +			goto map_through_host_bridge;
> +
>  		map_type =3D PCI_P2PDMA_MAP_BUS_ADDR;
>  		goto done;
>  	}

[Severity: Medium]
Will this change cause severe log spam during silent P2P discovery?

Previously, when there was no common upstream bridge, the code jumped direc=
tly
to map_through_host_bridge before checking ACS paths, leaving acs_redirects
set to false.

Now that the code falls through and evaluates the ACS paths, acs_redirects =
can
be set to true even when verbose is false. This true value is then passed i=
nto
host_bridge_whitelist():

drivers/pci/p2pdma.c:calc_map_type_and_dist() {
    ...
    if (verbose) {
        /* diagnostics ... */
    }
    acs_redirects =3D true;

map_through_host_bridge:
    if (!cpu_supports_p2pdma() &&
        !host_bridge_whitelist(provider, client, acs_redirects)) {
    ...
}

Since __host_bridge_whitelist() triggers its warning based solely on that
argument, bypassing the caller's verbose constraint:

drivers/pci/p2pdma.c:__host_bridge_whitelist() {
    ...
    if (warn)
        pci_warn(root, "Host bridge not in P2PDMA whitelist: %04x:%04x\n",
                 vendor, device);
    ...
}

Does calc_map_type_and_dist() need to pass (verbose && acs_redirects) inste=
ad
of just acs_redirects to prevent filling dmesg with warnings during silent
provider discovery loops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D2
