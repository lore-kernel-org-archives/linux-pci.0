Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA9456DF1
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016087; cv=none; b=i8K5zUxji/U20cquYEU4XJcsWreUZpExIYAmbLJ6lvfbZxysUUxVxEQqf1yRi24Q/XtBuhw8bFdayIjt8PpL+AowUnZszFIoxn7p7XcBjMIVEst+tKzAQFXqvydPPLLMAIwxMdQiYU9oZjpPRery0RbOmKR981kmy5dLp1u/UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016087; c=relaxed/simple;
	bh=Pcmlw6UCjot/x67n6p9uuNEV99m65GrXGISGnWqsDpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EUpCHQj96pxKD84KwZaus8HwbQ6nK/LU0+5Wmhxs2dXr+WowVNEMuGsZLX594SeyVzFxX6lMIPrBDixqwXs3yHZEw8M82N96t9ohhlqnzmfHnPBkfatAynJIhqRxZ14AMCTKe7ERxyfsqTJetBkTS163AMuzDF9RNut4xfGAMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjl1dxdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjl1dxdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDB21F000E9;
	Thu,  6 Aug 2026 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016084;
	bh=Z5MCBUg3prhU/lbVU9cIj1GLHwDdPSqeYWngGIHQd6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pjl1dxdDHAm4jgOEpQ0DzUxf4gJnN3QV6cVdeTRCO5/O2HB51FrS4NSibHXBWtCkd
	 u+ZYjif82aQaeoSUyPbB7bp8u2j2lJtTh6e1ssyAubgGkNbSqH4kXn2zMN7Mr0162n
	 ElgwQk/6wPQ5vfmgyjTsCjoAAU9gMkThO3qLcg0DVLseww+jadK9RxIb3yuVlHLWgq
	 hKj2hiuE+6Qs6054djSKOlD0kMUw8pQLX9MarF89CX3TaHMPQJKJj4t36Gfaf5riIv
	 da5zVBFIReI/8CzKF6xMhvMbxTDBgPBrPvlhjO+q2zFIcg8jJEtiUwMIYvIs1GlyY+
	 QwYHfYIf5kyqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] PCI/P2PDMA: Extract pure ACS routing decision
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-10-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-10-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:34:43 +0000
Message-Id: <20260806113443.CFDB21F000E9@smtp.kernel.org>
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
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Assisted-by: Claude Opus 4.8 <noreply@anthropic.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D10

