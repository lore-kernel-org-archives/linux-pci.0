Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453842640D
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600775; cv=none; b=KKv4WZlbWv1aWAYUuyV1LVX1YGAV3q1bEQjm2c6z0GEHuinHEXwyLr98IB3YQNQhT0pKWHatAiDH+dEWDWs2OczQvyDx539UMtqPelMuaAlLf5q5lR/OGCUE0/Gdt+KQerMk0oOYTqR51/p5qFoGIjV8t4TDCjeVb+mLPp2rYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600775; c=relaxed/simple;
	bh=CWLhb44JceD6Ohrb5A71pGlYjuSfOvm8G8ZrDiwhJiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Prkqz4dDJmMdsL4i/LNJnD0TUylXTvNiBN2SsW+xyik5/ODaLlHvbR1q0d2z90JnYLBgir7jfP7JgHHMKZ3NsFHbI18enASCg0mQu4D8UCZc5qKduG2jClVLP4Saf2cfXA8F26HuxSM42inXGBE4h05cGDFLDt2YV5I8Vb+3VPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8s7Pt0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8s7Pt0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF01F00A3A;
	Thu,  9 Jul 2026 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783600773;
	bh=d/fnDmIK4NNYiABWLYHcpQZbodNiRhaGApr0GdWpnf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8s7Pt0/D1Ix3vjLzcYZybs8x/I8IsRer/4bxfAjUtskYNv1Cq3aUbX+WWdnG5oRe
	 Jc/5a64ftpHw9kk2xfBnHtoheSZ645XLa5KM7NxnRDpdFX1+ujUMxlhSlV6/ZUqp5T
	 4zpFYNijK0yNCZSlZXXDhIaLVuh2ReSUwe91lHgllcj8DX7RGOIo6+ixVqnvoj6nGX
	 AOivSgTOHnLJZYv4XJ5K414tz6kf3yJjv2npf61lq09TV9SaZjfWSiET71oaxRk22D
	 5A6CQKsj/5tkdGt9DOgDBfShJ8pFZczgjfPAWsSqqWzez0VWklBHNpBpCSVgM3aP2h
	 Pr4dUYWwrCq6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: host-generic: Fix NULL pointer dereference on
 32-bit CAM systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Persvold" <spersvold@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260709122446.3151899-1-spersvold@gmail.com>
References: <20260709122446.3151899-1-spersvold@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:39:32 +0000
Message-Id: <20260709123933.5CFF01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / NULL Pointer Dereference in `pci_dw_ecam_bus_ops`=
 on 32-bit platforms.
- [High] Missing NULL pointer validation in `pci_ecam_map_bus()` leading to=
 invalid memory access.
- [High] Logic error in `pci_ecam_map_bus()` causes cross-device config spa=
ce corruption for CAM mode.
--

--- Patch [1]: [PATCH] PCI: host-generic: Fix NULL pointer dereference on 3=
2-bit CAM systems ---
commit 208f10f6fcd6715f0a5bbab0d769a909c797f297
Author: Steffen Persvold <spersvold@gmail.com>

PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems

This commit fixes a NULL pointer dereference on 32-bit systems using CAM
by defining pci_generic_cam_ops with .add_bus and .remove_bus callbacks
and updating the host generic driver to reference it.

> diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/cont=
roller/pci-host-generic.c
> index c1bc0d34348f4..9e85c6e9b4254 100644
> --- a/drivers/pci/controller/pci-host-generic.c
> +++ b/drivers/pci/controller/pci-host-generic.c

[ ... ]

> @@ -60,7 +51,7 @@ static const struct pci_ecam_ops pci_dw_ecam_bus_ops =
=3D {
> =20

[Severity: High]
This is a pre-existing issue, but pci_dw_ecam_bus_ops shown just above this
context seems to be missing the same .add_bus and .remove_bus callbacks.

If a 32-bit system uses snps,dw-pcie-ecam or similar compatibles, does it
also crash with a NULL pointer dereference during bus enumeration because
the per-bus mapping is never populated?

>  static const struct of_device_id gen_pci_of_match[] =3D {
>  	{ .compatible =3D "pci-host-cam-generic",
> -	  .data =3D &gen_pci_cfg_cam_bus_ops },
> +	  .data =3D &pci_generic_cam_ops },
> =20

[ ... ]

> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 119de32ff07bd..a9b3bce2492f0 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -208,6 +208,19 @@ const struct pci_ecam_ops pci_generic_ecam_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
> =20
> +/* CAM ops */
> +const struct pci_ecam_ops pci_generic_cam_ops =3D {
> +	.bus_shift	=3D 16,
> +	.pci_ops	=3D {
> +		.add_bus	=3D pci_ecam_add_bus,
> +		.remove_bus	=3D pci_ecam_remove_bus,
> +		.map_bus	=3D pci_ecam_map_bus,

[Severity: High]
This isn't a bug introduced by this patch, but there might be a missing
pointer check in pci_ecam_map_bus() when pci_ecam_add_bus() fails on
32-bit systems.

If pci_ecam_add_bus() fails, for example due to an ioremap failure, the
per-bus pointer remains NULL. pci_ecam_map_bus() handles it like this:

drivers/pci/ecam.c:pci_ecam_map_bus() {
    ...
    if (per_bus_mapping) {
        base =3D cfg->winp[busn];
        ...
        return base + (bus_offset | devfn_offset | where);
    }
    ...
}

Since the offset is usually non-zero, it returns a small non-NULL invalid
pointer. Can this bypass the null check in callers like
pci_generic_config_read() and cause an invalid memory access?

[Severity: High]
This is also a pre-existing issue, but using pci_ecam_map_bus() for CAM ops
might cause cross-device config space corruption.

In pci_ecam_map_bus(), the register offset is unconditionally masked:

drivers/pci/ecam.c:pci_ecam_map_bus() {
    ...
    bus_offset =3D (busn & PCIE_ECAM_BUS_MASK) << bus_shift;
    devfn_offset =3D (devfn & PCIE_ECAM_DEVFN_MASK) << devfn_shift;
    where &=3D PCIE_ECAM_REG_MASK;

    return base + (bus_offset | devfn_offset | where);
}

For CAM mode, bus_shift is 16, making devfn_shift 8. This places
devfn_offset in bits 8-15. However, PCIE_ECAM_REG_MASK is 0xfff, which
allows the where variable to occupy bits 0-11.

Does this allow extended config space offsets to overlap and bitwise OR
with devfn_offset, inadvertently redirecting accesses to adjacent devices
instead of the intended target?

> +		.read		=3D pci_generic_config_read,
> +		.write		=3D pci_generic_config_write,
> +	}
> +};
> +EXPORT_SYMBOL_GPL(pci_generic_cam_ops);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709122446.3151=
899-1-spersvold@gmail.com?part=3D1
