Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0926ED40
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941715; cv=none; b=Ol/0GJwEXZ1Mf0cFvcdP5Yu15vxVW9RJkfMhmcakOjinmcy6x4PMYUIhgdhqTKQu1/bgUnqco+9qVITks6cQm+jc71i0JfpkY+3X77Xs6ZZ7Xuj7cQN2dX3U+Ih4cgelFaIwRoH/1hCyAQs869ZmNin3ASLTzijhsGzlngm66G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941715; c=relaxed/simple;
	bh=hyK6tNpoQGZOrgtXqbV2AAABZ4PSVFeGSoInZO4uqdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTEQok2dCB52UO4im5qfioUy7X4Et9RQ7Myc3Th90+LKyP0+KEIhlK5X9PZFcctOM0Vy+5hJ7f8+3MgS5ieEBjJX45BAL2HvzZRTjNTHqpUXYaH2BGQuskLdnXdgEfWKbHRbYyPFSZe8+uRjgL99t4O2QPYzqLGQvEoYvPFcijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTWJusw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTWJusw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679371F000FF;
	Fri,  2 Oct 2026 11:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941714;
	bh=ogoqeUAIMBoKpLvmoC4Kd3qGwjchEVZ53n1R+gFL2Ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WTWJusw68KUGX+K7uVqkvtrn1kW/1EwMaj/snBgDwBC/jY0TyIMWeRYxq+3tvurLC
	 tCT4hYKtbv/xi47SiBJmiDPgi9dCXJ3c7fBdhRxoTY+EBVMoZ6pwd0Gt0ji7I1BtcX
	 1xPbqLkJzYkT/veyQPL8twbkICK8L0davYrog2Rp0qm8b3sF9vbR9myFLk0f3ADDFO
	 Ehr6ALlmtcV/I1a1pyVucZzBSAkbu7CeEtNiuiVWMWUBKhsFviO6o7X+IGpuhAOBOl
	 e/VzZSuWK9kXsUjmdBS9WQqUGJjcyQBlzHdBbNcuZQcCPZ4fEHNN4O7r2g+U1eJk67
	 o0g7FD61OnPRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa
 systems
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:48:32 +0000
Message-Id: <20261002114833.679371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci/quirks: skipped workaround and UAF on rescan due to dangling r=
esource pointer
--

commit 988b9fe1c0d1202ac7629ed0f5250a0381f61b90
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI/quirks: Avoid certain address on Genoa systems

This commit addresses a 64kB iomem black hole on Genoa systems that causes
reads to return ~0 and blocks overlapping BARs from working. It reserves the
problematic space via a bridge quirk.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222074

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..5483b47d8d544 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

[ ... ]

> +static struct resource black_hole_res =3D DEFINE_RES_MEM_NAMED(0x9c00000=
0, SZ_64K,
> +							     "reserved");
> +
> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> +{
> +	struct resource *r;
> +
> +	pci_bus_for_each_resource(dev->bus, r) {
> +		if (!r || !r->flags || !resource_assigned(r))
> +			continue;
> +
> +		if (!__resource_contains_unbound(r, &black_hole_res))
> +			continue;
> +
> +		if (resource_assigned(&black_hole_res))
> +			pci_dbg(dev, "iomem black hole workaround already applied\n");

[Severity: High]
Can this lead to a use-after-free and cause the workaround to be skipped on
rescan?

During the first probe, insert_resource() sets black_hole_res.parent to the
dynamically allocated host bridge window. If the PCI bridge is subsequently
removed, the bridge's resources are released and freed.

However, release_resource() unlinks the parent but does not clear the parent
pointers of child resources. Because black_hole_res is statically allocated,
its parent pointer is left dangling.

When the bus is rescanned, resource_assigned(&black_hole_res) evaluates to
true due to the dangling parent pointer. The code erroneously logs "already
applied" and skips inserting the reservation into the new bridge window.

This leaves the new window unprotected, allowing subsequent BAR allocations
to fall into the 0x9c000000 black hole.

> +		else if (!insert_resource(r, &black_hole_res))
> +			pci_info(dev, "iomem black hole workaround enabled\n");
> +		else
> +			pci_dbg(dev, "iomem black hole workaround add failed\n");
> +		return;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_ho=
le);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D7
