Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C518AE3
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686154; cv=none; b=lKQyDLZukCUK1p5lBofpanr2p9F+JR+B1IXhQTrg14TFNqj4M5ak9IDRzRZA7y9vLFJ8olO7m/fmXuGyqSA8OPc8mOYMt4hcsV7GX3cI3qd1R1p+fsBp2mgb9YuqRdqP4Kx8bJzEe4AUCYSS6Bl/X8cyRx7amgS8oPvwnEHllfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686154; c=relaxed/simple;
	bh=IIyCo2F2Q3tc9L4JcKK4LSvb6FJycWYrN8H0k2AZ1tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pchn2vIp4Uo1liRmt1pCI1oYD+cMYzREP6CMOBHgfbbqdXwX3d/FVxjxnU980OqahRAcmkcYhX3XEYIGQVFcE1cdT56NC8wLJkr6NcoQmIFBPaigcfolW0wJk0XiNccXqAqKYqLoxXGpgG50rdr7o5f+i2tynGCI5IjvOEyfvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVEWXb10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVEWXb10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387891F000E9;
	Sun,  2 Aug 2026 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785686153;
	bh=4OnQ5lzpFkWRDYgkBj5LOHxIted6lTu1yI5wdo9O/tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVEWXb10xf+RLPwp7D/GbexjTNszatn6cQRUQlkavD8y1wY2agIHfKVH/tYRsl2Wc
	 lESEeIdwOWxf8AQPOvE8pC0XgItLyaXPHecvS4dRGM0mpnUxbpiiuhuQRbffOZbr1u
	 eQjlV1jxYnUvIesAncXsiA7djkyZvTOtj6bVLVpvzKvC+btlARPxrc2U8zApI0giUe
	 QMz69hSpxSDH7jfZ8xjppjj1vj8i+SPI2Nz+sno2kvjhNTnTPrtOxkMRhiDsILWxMz
	 C6KoGDkau/bXl0K2PEjMUsgKf4X7rnROChoCKVizwBY+sbWmbmi/Utc9JRjZUs941X
	 FV9kf01rXMAWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] PCI/P2PDMA: Extract pure ACS routing decision
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-10-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-10-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:55:52 +0000
Message-Id: <20260802155553.387891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The ACS Egress Control routing decision (PCIe r7.0, sec 6.12.3,
> table 6-11) and the Egress Control Vector Size rule were embedded in
> functions that also perform config-space I/O and walk the PCIe
> hierarchy.  That made the branch-heavy logic -- in particular the paths
> that require an Egress Control Vector, which are unreachable on most
> hardware -- difficult to exercise in isolation.
>=20
> Factor the logic into two pure helpers:
>=20
>   - pci_acs_p2pdma_decision() maps the ACS control word, whether the
>     target port is known, and the target's Egress Control Vector bit to
>     a routing state.
>=20
>   - pci_acs_egress_port_valid() applies the "a vector size of 0 encodes
>     256 bits" rule to decide whether a target port is within the vector.
>=20
> pci_acs_p2pdma_state() and pci_acs_egress_ctrl_set() now call these.  No
> functional change intended: pci_acs_egress_ctrl_set() still checks the
> port range before reading the vector DWORD.
>=20
> The helpers are exposed under CONFIG_KUNIT via VISIBLE_IF_KUNIT so the
> following patch can unit-test them.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D10

