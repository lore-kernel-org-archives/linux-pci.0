Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7F377AA9
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753688; cv=none; b=ATklGIxwkfol2f4QHLmH2B9qyr2a5lu7gU1qv8aCxxxvwICBXkOLPwsB9hK5kYFRKDHGO6Ax88FICXCJV27sEEFCosBL84h6/h057pX5Yj0fgrayW6VJ/JIqVZpMgdnnO0e9bz7VuKAskXMiQ5hxrAWkBSoZLrisMcZ0Cv1bxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753688; c=relaxed/simple;
	bh=8z4pnfqW3uUAnvIO8b76MudBE/rVAdxbdPt80xfmufQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BhL2PF2gGvATF7J4IZY1Gm3GhP4Is2hSvvpU4Ob0QHtyPjD0ekgQEA9jDSYh3eK2b3xcRb7aiT6G3pllK5nXsKriOnphQYhazLlRvlBCxMS1fFw6ZtqKTDMnzhmEz9ZiuB0q9+rQe9fuCbZnvq/c3Pzg1ZvDZvd8DWJdHVEzkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez8CFS+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez8CFS+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E1C1F000E9;
	Mon,  3 Aug 2026 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785753686;
	bh=hWBMM1hC9M/NTSG4Qn/7kO9mEaltmMRzw4+vX0qLpH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ez8CFS+7edZReAvPTJOmmSZR38y2H90XIqGtKpWG+1tFkG5RfXkCMhvOyoIy50dXb
	 l+9aZPaS8yz+oihIn7XqRWYSIfRTrrkJbqwt7jY4sYg6tjgeRDDfQLEK2g91RVn7y0
	 FEldlV6qacy1+s0yhIG9ki8eTpXwpGkLC9BrB+Y+ohlvhztQwkbiWZaPG+/7/vHzaz
	 Ae9aKfWbB1N8UZrkKy0kKA9eqWH2XeMNsJQX4v0mb1QdxWaaTT5bWEDP/GiqcG7Zw+
	 ZhmcRP4P2GqFQ5US2m4IIhKRILKBhqFrw/OJtVo+hD8y+o1ETTeg1ZPfkvgZg6cZJj
	 6n1cZBYr7uJFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI/IOV: Remember initial VF BAR sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marcin Bernatowicz" <marcin.bernatowicz@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803103007.209625-2-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-2-marcin.bernatowicz@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:41:25 +0000
Message-Id: <20260803104126.58E1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds stack read when processing a 64-bit BAR at the final=
 index.
- [High] Double multiplication of VF BAR size and incorrect per-VF size rec=
ording when initialized via Enhanced Allocation (EA).
--

--- Patch [1]: [PATCH v2 1/3] PCI/IOV: Remember initial VF BAR sizes ---
commit 267f03df0eb1d945e4b2134aa0c449cf8ddfcfca
Author: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>

PCI/IOV: Remember initial VF BAR sizes

SR-IOV initialization records the per-VF BAR sizes derived from the VF
BAR registers in the SR-IOV capability.

PF drivers may later change VF BAR sizes using VF Resizable BAR support
(pci_iov_vf_bar_set_size()). Save the initial per-VF BAR sizes so later
code can restore them when SR-IOV is disabled, when SR-IOV enable fails,
or when the PF driver is unbound while VF BARs are still resized.

The initial size is captured before the resource is multiplied by
TotalVFs, so it represents one VF's BAR size as advertised by hardware.

No functional change on its own.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b0d24839c0840..ae9309fc6dd73 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -869,6 +869,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  			goto failed;
>  		}
>  		iov->barsz[i] =3D resource_size(res);

[Severity: High]
This is a pre-existing issue, but does this handle Enhanced Allocation (EA)
initialized devices correctly?

If a device is initialized via EA in pci_ea_init(), the VF BAR resources are
initialized with a total size encompassing all VFs and marked with
IORESOURCE_PCI_FIXED.

Because they are fixed, __pci_read_base() is skipped earlier in the loop,
and resource_size(res) returns the total size instead of a single VF's size.

This results in iov->barsz[i] (and now iov->barsz_orig[i]) incorrectly savi=
ng
the total size, and the resource_set_size() call below multiplying the
already-total size by the number of VFs again, leading to exponential
inflation of requested resource sizes.

Can this cause resource allocation failures for EA-initialized devices?

> +		iov->barsz_orig[i] =3D iov->barsz[i];
>  		resource_set_size(res, resource_size(res) * total);
>  		pci_info(dev, "%s %pR: contains BAR %d for %d VFs\n",
>  			 res_name, res, i, total);

[Severity: High]
This isn't a bug introduced by this patch, but can this loop trigger an
out-of-bounds stack read if a 64-bit BAR is advertised at the final index
(BAR 5)?

Just above this diff hunk in sriov_init(), if the resource is not fixed,
__pci_read_base() is called:

	bar64 =3D __pci_read_base(dev, pci_bar_unknown, res,
				pos + PCI_SRIOV_BAR + i * 4,
				&sriovbars[i]);

sriovbars is a 6-element stack array. If i =3D 5 (the last BAR), &sriovbars=
[5]
is a pointer to the final element.

If the hardware advertises a 64-bit BAR, __pci_read_base() in
drivers/pci/probe.c processes it by reading from index 1:

	if (res->flags & IORESOURCE_MEM_64) {
		pci_read_config_dword(dev, pos + 4, &l);
		sz =3D sizes[1];

Since sizes points to the final element of the sriovbars array, sizes[1]
accesses memory past the end of the stack array. Could a malicious or
malfunctioning hot-plugged PCIe device trigger a KASAN panic here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803103007.2096=
25-1-marcin.bernatowicz@linux.intel.com?part=3D1
