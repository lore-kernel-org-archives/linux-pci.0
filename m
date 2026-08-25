Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F87326924;
	Tue, 25 Aug 2026 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625578; cv=none; b=pQ0OUA/JAzWKdLaZ8GlA2NN2rH0ki6DpIo/JHoojPXTmrR5qpGNmRpTgDCARliGpnzC8IIgPUQJUppLqkgLF8cJskumQlAKNIjET8JYWce7ScIfFEDXRFSxb2D4W4HI99YrQbvvdtCPnY0ryFPpcYUL8OESIYYbISuL4RLY4XKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625578; c=relaxed/simple;
	bh=1t1cg1stwjDsAsvTT7qp7zY4qGWWFg+ee1o3wslBTJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KuU9KjFAPbVxmROzNQJaGZJJRONpEjgTJ1a5It+nKsRv3yQe8xI/WHMmJaNpiPgn+NNol7m8t9OjdJh1vG2Zypkp2CKbEoTUmMFuDq+0Ds/mN03Av2HLEU1ZOY5sV2NQON6fT1k/sMUnY39GfYDohpMM8q/BtwTeqMORj+y90/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWVRVsW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWVRVsW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65AF1F000E9;
	Tue, 25 Aug 2026 02:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625576;
	bh=uicVxZvLJaOA4rI4B9VS5PB1hA2gvzl4HWAhE+ZIqWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWVRVsW8mX+DWPcutnx2MLlvvGE0o/E/sD9c+HcsPZncvXUCeXPadyhjk6HppiGzo
	 GXqnMXvlkYr/ISALJXjYjZ6HiGaa25VnRc1bjaTEpgyQHdPG8XMHBHizueyNLb7c8f
	 x2VXetSaLsiif0A4ytIdT5CjhUKzcywBvUbaMnnQVbnzggo2UabpyRLPbyallY7lQ/
	 apjFp12fksiIcIYshm/hgBBttGQGLEv2KhKt6CMdohXt+1KWmGr9xqi5PCyXq0qQ4F
	 ytpQD2Xk+v/ZsazNu75eyXVKOUj/nyT8cgSQKAe2BQiD72cIK6CktjTdtOprwjkBTc
	 iBx3q8ist3Dpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] PCI/CXL: Disable and re-enable CXL regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825022628.3651434-10-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-10-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:39:36 +0000
Message-Id: <20260825023936.A65AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `cxl_sbr_enable_regions()` silently ignores the return value of `c=
xl_sbr_collect_regions()`, leading to permanently disabled regions on alloc=
ation failure.
- [High] The global `cxl_sbr_region_ops` pointer can dangle if `cxl_driver_=
register()` fails, and lacks module pinning to protect against concurrent u=
nloads.
- [High] `cxl_sbr_enable_regions()` unconditionally re-enables regions even=
 if HDM decoder restoration fails.
- [Medium] The recommit path incorrectly treats legitimately missing HDM st=
ate (e.g., ports without devices, or emulated decoders) as a failure or log=
s spurious warnings.
--

--- Patch [9]: [PATCH v2 09/13] PCI/CXL: Disable and re-enable CXL regions =
---
commit cfc12109c423de14f05ed1c759bffe4684c3373e
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

PCI/CXL: Disable and re-enable CXL regions

A Secondary Bus Reset of a CXL Downstream Port needs every CXL region
routed through that Port disabled for the duration. This patch adds=20
callbacks to collect and disable those regions before the reset, and=20
subsequently restore HDM decoders and re-enable the regions afterward.

> diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
> index 233499bc1fad9..2b6f840e22a7d 100644
> --- a/drivers/cxl/core/dport_sbr.c
> +++ b/drivers/cxl/core/dport_sbr.c
[ ... ]
> +static void cxl_sbr_enable_regions(struct pci_dev *dport_pci)
> +{
> +	struct xarray *hdm_state;
> +	struct cxl_region *cxlr;
> +	struct xarray regions;
> +	unsigned long index;
> +
> +	xa_init(&regions);
> +
> +	cxl_sbr_collect_regions(dport_pci, &regions);

[Severity: High]
Does this code need to check the return value of cxl_sbr_collect_regions()?

If xa_insert() fails inside cxl_sbr_collect_regions():

	rc =3D xa_insert(regions, (unsigned long)cxlr, cxlr, GFP_KERNEL);
	if (rc) {
		put_device(&cxlr->dev);
		return rc;
	}

it returns an error and stops collecting. By discarding the return value he=
re,
could this silently skip some regions and leave them permanently offline and
unbound?

> +
> +	hdm_state =3D xa_load(&cxl_sbr_hdm_state, (unsigned long)dport_pci);
> +	if (hdm_state)
> +		cxl_sbr_recommit_decoders(dport_pci, hdm_state);
> +	else
> +		pci_warn(dport_pci, "no saved HDM state, decode not restored\n");

[Severity: Medium]
Is it possible for ports to legitimately have no HDM state (like ports with=
out
devices or with emulated decoders)?

The save path in cxl_port_save_hdm_state() appears to correctly skip such
ports without saving state. If that happens, wouldn't this path log a spuri=
ous
warning? Furthermore, wouldn't the recommit path in
cxl_port_recommit_decoders() incorrectly treat missing states as an -ENODATA
failure?

[Severity: High]
Since cxl_sbr_recommit_decoders() returns void, how does this code handle a
hardware programming failure?

If cxl_sbr_recommit_decoders() fails to reprogram the HDM decoders (e.g., d=
ue
to device timeout), won't the subsequent loop unconditionally call
cxl_region_enable() and rebind the region driver while the hardware is still
misconfigured? Could this lead to invalid memory accesses?

> +
> +	xa_for_each(&regions, index, cxlr)
> +		cxl_region_enable(cxlr);
> +
> +	cxl_sbr_put_regions(&regions);
> +	cxl_sbr_drop_hdm_state(dport_pci);
> +}
[ ... ]
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index fc0bec991a693..d1dd4924fba17 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -4263,12 +4264,14 @@ static struct cxl_driver cxl_region_driver =3D {
> =20
>  int cxl_region_init(void)
>  {
> +	pci_cxl_set_sbr_region_ops(&cxl_sbr_region_ops);
>  	return cxl_driver_register(&cxl_region_driver);
>  }

[Severity: High]
If cxl_driver_register() fails here, does the PCI subsystem retain a dangli=
ng
pointer to cxl_sbr_region_ops?

Also, since the PCI core doesn't hold a module reference, is there a risk of
the module being concurrently unloaded while a Secondary Bus Reset is in
progress?

> =20
>  void cxl_region_exit(void)
>  {
>  	cxl_driver_unregister(&cxl_region_driver);
> +	pci_cxl_set_sbr_region_ops(NULL);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D9
