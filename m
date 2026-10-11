Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EB28CF4A;
	Sun, 11 Oct 2026 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685682; cv=none; b=OomK9rsFG1iI7pKflv8NPDg3kHXryVT7BuluokB/xiiplcG7RF1eKzLPRfPGIjW5S7xEm9zR1q68XDe/mEqkf+/6cTOkdUybmwkd8bpon2/8tMw14eNoTpxTorM6+gdCq403FxtEj5EjRjzgT3d065+nM4Xehx13u9On+62cspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685682; c=relaxed/simple;
	bh=vc8xr79SGrV6nufyBA6R6+4OK9/fPewrDQ0PJptcCYw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pjspr2GD5pOF1Nua+CsfGr8YF1Sa+sPZMaNabrfkHzE3hvyN6CN1CyKGeqKcJ37vH8tD6EYugdOdWKeKCyfEo1bstS1jfjs6wN2KQb10HJiF2wGOCOcBTWUwxQk8elB0Q7oU12FzzgGSUbvyOZ5dk0mjm/yxnZkCPOSDdTf1Dmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJKPYtiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJKPYtiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5101F00893;
	Sun, 11 Oct 2026 02:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685681;
	bh=k1OjBaL0LqaJ+CBHgbNMY8SH4ieyjKgKCRt6ZiW8R7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJKPYtiIDOhZ63ylKZ7lwsiDEHRhwzNcsDslhl14xOzLrlDqS/J7/z1eGDzNdqdBK
	 6zcP15CXbfWUyslU4Jz2H3xYtsBKYswZCiDg/uV38cp5DMMieFesiYuu9vSEqbfTJj
	 9zogb7cf7HyLRPh5PMNj9Jr+8ZfPk/No+xb2GNDnbgQcom4Ysr5n+/WcQU2+4javrR
	 oVh0lQPiagS1YQWkoC4ShmJbp6j5+GiX58YBdjJeDayhblEVjC9gs+B3x+Ituwku8g
	 RAdPEMNV/PVCXCsZw+9vaM0ZQ/mGfiHiq/WuIbV05reIshxGkjNvyqgvNMc9LdmuNQ
	 DL56eTCF/AJyw==
Message-ID: <sashiko-outbox-166981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 12/16] PCI/CXL: Reject reset with unsafe function
 scope
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011021422.3428136-13-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:28:00 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: CXL reset restriction fails to reject VFs, allowing device-wi=
de resets
--

commit bc92caba866b3736b7ca2232519b796c40f058e5
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Reject reset with unsafe function scope

The per-device PCI reset interface must not reset sibling functions.
Reject cxl_reset and cxl_bus for multifunction devices and PFs with
enabled VFs.

Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.=
notmuch/

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 3da8b316857f1..eccdb57945feb 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -496,6 +496,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool pro=
be)
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;
> =20
> +	if (pdev->multifunction || pci_num_vf(pdev))
> +		return -ENOTTY;

[Severity: High]
Does this check fail to reject Virtual Functions (VFs)?

Since VFs are initialized as single-function (pdev->multifunction =3D 0) and
pci_num_vf(pdev) returns 0 for non-PF devices, this restriction appears to =
be
bypassed for VFs.=20

If the CXL 3.0+ hardware exposes the CXL DVSEC on the VF, triggering a reset
on a VF would bypass this check and reset the entire CXL endpoint, disrupti=
ng
the PF and all sibling VFs. Should this check also include pdev->is_virtfn?

> +
>  	if (probe)
>  		return 0;
> =20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..fe611340f5ab1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *d=
ev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
> =20
> +	if (dev->multifunction || pci_num_vf(dev))
> +		return -ENOTTY;

[Severity: High]
Similarly, does this bus reset check allow VFs to bypass the restriction and
inadvertently trigger a bus reset affecting sibling functions?

> +
>  	if (probe)
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D12
