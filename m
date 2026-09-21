Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB448F02F
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001169; cv=none; b=obKPvSqAVdgzVeM1ICzwEbQOZguf1tSx3VC+lKDnpb9JBVJmmFDqUmPovVo/dRTA9XnL5hwmLhtjTXCNKDRakNUWkabYFsrUwQFOENyEpXT+GelOc+lDUwRKVmabrAwejP0MyRgrbwoemNAVHToDacIUAmIhHQe3KJ1qs55UxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001169; c=relaxed/simple;
	bh=uQfykzHGmKBcNrMsOkwU3YOrxj1JeORiKU1rY4wDjKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mKDzm0idl6TOds3Fn/6wcloGB5UVJ93pyBvvU33i9lVGbkCKbLCfMHDkk6gBKrT3JBoOUFch90R5rbYcz+B0BV3lPgzZxDQZGvTNt9i/TdrroiTs8oEakS0NpYWLsX0HE4WqK6mPovRqjPtc3HSAEkfsxyVrOfFZGH1cqYRonLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/hiHtWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/hiHtWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF821F000FF;
	Mon, 21 Sep 2026 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001167;
	bh=aQeurx4vwDS+f0Q+68msfypevHRU4Y5v3qLzxsxiL8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K/hiHtWHBptSkn7LiGP5EyvWGocca8qiDrqy24Cgq3aR9YqU29JjVRdKIz7ZsU7fg
	 c3hiPMPwfslN9KLdgeCSssTtmYTQkjrHo3iDuhy6/PSldMTme4q8yV765y9Tp0k+uU
	 y7Ubfx7jNzw121HvARJpJp8IEQ05tUyOd91dY1uf0RGXlu5DBmksejFKJuaP9w3Tgu
	 FjOvyx9Bq5NGajuaXs5BLssbRaNn4tIIby6ortZ4+f6W0YuHi+5bj78AKU3xDReDf6
	 sx20PAP9ceGDx6P+RAsWhKC4wROG0aEcVWtzRGO12shnTbzVnCstoqgoZ5PS/QHCwH
	 F+3YmXYUKqMhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/8] PCI: vmd: Add support for second rootbus under
 VMD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-8-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-8-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:32:46 +0000
Message-Id: <20260921143247.4AF821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: vmd: root ports skipped during domain reset due to CFGBAR sta=
rt offset resize
- [High] pci: vmd: unprotected modification of global resource tree pointer=
s and structures
--

commit 21e75586431de95d78578f413b1e8f1a06a83836
Author: Szymon Durawa <szymon.durawa@linux.intel.com>
Subject: PCI: vmd: Add support for second rootbus under VMD

This commit introduces support for a second root bus under VMD, which is
needed starting from Intel Arrow Lake. It enumerates BUS1, divides the
MMIO space to be shared between both root buses, and resizes the CFGBAR
accordingly.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index c6b5e693916cb..51b8c2d9b7f0b 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -632,12 +664,24 @@ static void vmd_attach_resources(struct vmd_dev *vm=
d)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child =3D &vmd->resources[VMD_RES_MBAR_=
1];
>  	vmd->dev->resource[VMD_MEMBAR2].child =3D &vmd->resources[VMD_RES_MBAR_=
2];
> +
> +	if (vmd->bus1_rootbus) {
> +		vmd->resources[VMD_RES_MBAR_1].sibling =3D
> +			&vmd->resources[VMD_RES_BUS1_MBAR_1];
> +		vmd->resources[VMD_RES_MBAR_2].sibling =3D
> +			&vmd->resources[VMD_RES_BUS1_MBAR_2];
> +	}

[Severity: High]
Does manually assigning the .sibling pointers here introduce a data race?

These assignments link the BUS1 resources directly into the global iomem
resource tree without acquiring the resource_lock.

On the vmd_create_bus() error path later in vmd_enable_domain(), these
sibling pointers are cleared and the resource structures are zeroed, also
without locking:

drivers/pci/controller/vmd.c:vmd_enable_domain() {
	...
	vmd->resources[VMD_RES_MBAR_1].sibling =3D NULL;
	vmd->resources[VMD_RES_MBAR_2].sibling =3D NULL;
	vmd->resources[VMD_RES_BUS1_CFGBAR] =3D (struct resource){};
	...
}

Can concurrent readers (like /proc/iomem iterators traversing the tree)
encounter corrupted or zeroed structures, leading to a crash or invalid rea=
ds?

>  }

[ ... ]

> @@ -936,6 +997,62 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
>  		.end   =3D busn_end,
>  		.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
>  	};
> +
> +	if (vmd->bus1_rootbus) {

[ ... ]

> +		/*
> +		 * Resize BUS0 CFGBAR range to make space for BUS1
> +		 * owned devices by adjusting range end with value stored in
> +		 * VMD_BUSRANGE0 register.
> +		 */
> +		vmd->resources[VMD_RES_CFGBAR].start =3D bus0_start;
> +		vmd->resources[VMD_RES_CFGBAR].end =3D bus0_end;

[Severity: High]
Will this resize of the CFGBAR start address cause vmd_domain_reset() to
skip the root buses?

When vmd_configure_cfgbar() resizes vmd->resources[VMD_RES_CFGBAR].start to
the secondary bus start (e.g., 0xE2), vmd_domain_reset() will later read
this modified start address:

drivers/pci/controller/vmd.c:vmd_domain_reset() {
	...
	for (bus =3D 0; bus < max_buses; bus++) {
		ecam_bus =3D vmd_bus_to_ecam(vmd, vmd->resources[0].start + bus);
	...
}

Consequently, the ECAM loop skips the primary root buses (0xE0 and 0xE1).
Does this leave their bridge windows with potentially stale BIOS configurat=
ions
that conflict with OS enumeration?

> +
> +		vmd->resources[VMD_RES_BUS1_CFGBAR] =3D (struct resource){
> +			.name =3D "VMD CFGBAR BUS1",
> +			.start =3D bus1_start,
> +			.end =3D bus1_end,
> +			.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> +		};
> +	}
> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D7
