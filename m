Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683335E944
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290305; cv=none; b=DAJD11V/Pg0qH/5uoM02QRRTnTbFbEnefK7Gfnl7K13+MdSgmqu2D/wn9e1skXPan3TFwJyOG+uB5Dxw8AKL8EakGJA4V+a6ujqaPOSmiw9IwfRoFID/nLSjSMKY6tScGLJ31yePcnllbSW5C9Nc+e4J2DHbECYm1fpAXDD450o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290305; c=relaxed/simple;
	bh=lZXGduFZyG1kzTKFEYa+2kEF//BVTcVRxA3QEzCYFk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L35CkHPCyz9lCO69g8Z4z4hXNG0QtkhYt8do3ZQBBmDunS7zt1vKojZ94NhTvR/5UM+ZbInKpVtw64B1lAbt83dV4GsFsTV9EiyKCK19H/M9daBcyvRWjcqUsjvJKgU7FOfPuSETIBKG+J22EOYJI7bORLUmzU4n6STBUMTCT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0dO5sJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0dO5sJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F791F000E9;
	Sun,  5 Jul 2026 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290303;
	bh=mJcM5cL99JTVF8bVUsGXmdD36kzB2hiwDiLYX6LyQaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0dO5sJI4ZgJoiFEk2dhYma4gvPz9LQXm+WDFgRh1s3xKgcqgGGfW4xJSYYAYYByP
	 03m1vRWU3yJfpi4fifpcst6XU0jyUSGR/waMKsSRZ7392K2vVzSXHAu082q0p4AASi
	 aNhhyouAtsojf2cIc5vCxyPLgNzfJjZMNbN+oyJcrJnq/WJpCOsJ0TmBp9isO5ExWP
	 Ulynpb4Dc5bcgiNvV3BGr+zSSDtBrz18P4RU3ZHLrQHAy4TrB1ftMxwnhYiGO4XoSv
	 uaX9O2/DMPlg97P7FDXXEsqiWdvEadGm55r4yqZYcgQuHwlp1lxdEPXzMVCrzSsel0
	 aQaCV0kFPIjpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] PCI, device core: Move "untrusted" concept to
 DEVICE_TRUST_ADVERSARY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-10-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-10-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:25:03 +0000
Message-Id: <20260705222503.B3F791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Global device trust default is bypassed for non-PCI devices during=
 IOMMU initialization because `device_initialize_trust()` fails to initiali=
ze `bus_trust`.
- [High] Driver binding overwrites `dev->bus_trust`, disabling dynamic IOMM=
U DMA protections and breaking PCI trust inheritance for downstream devices.
- [Low] Missing `#else` stub for `device_untrusted()` causes compilation er=
rors when `CONFIG_DEVICE_TRUST` is disabled.
- [Low] `enum device_trust` is used as a value type in `struct device`, but=
 it is neither defined nor forward-declared in `<linux/device.h>`.
--

commit e078ccf16f66fc647e7473fedd70781ac6e8fd5d
Author: Dan Williams <djbw@kernel.org>

PCI, device core: Move "untrusted" concept to DEVICE_TRUST_ADVERSARY

This commit elevates the PCI "untrusted" concept to a core device trust
level called DEVICE_TRUST_ADVERSARY. It adds a new bus_trust field to
struct device and uses it to manage trust states before device_add(),
syncing it to the private device trust structure afterwards. It updates
IOMMU and PCI subsystems to use the generic device_untrusted() interface.

> diff --git a/drivers/base/trust.c b/drivers/base/trust.c
> index 0fd494e1557dc..8efbe5c512501 100644
> --- a/drivers/base/trust.c
> +++ b/drivers/base/trust.c
> @@ -6,15 +6,28 @@
>  #include <linux/module.h>
>  #include "base.h"
> =20
> +/* If the bus did not initialize trust, set a default */
>  void device_initialize_trust(struct device *dev)
>  {
> +	dev->p->trust =3D dev->bus_trust;
>  	if (dev->p->trust =3D=3D DEVICE_TRUST_UNSET)
>  		dev->p->trust =3D DEVICE_DEFAULT_TRUST;
>  }

[Severity: High]
Does this bypass the global trust default for non-PCI devices?

The fallback logic updates dev->p->trust to DEVICE_DEFAULT_TRUST but leaves
dev->bus_trust as DEVICE_TRUST_UNSET (0). Since device_untrusted() strictly
evaluates dev->bus_trust, does this leave the trust uninitialized?

Furthermore, IOMMU probes devices via BUS_NOTIFY_ADD_DEVICE in device_add()
before device_initialize_trust() is called. Is bus_trust always 0 during
IOMMU probing for these non-PCI devices, disabling protections like SWIOTLB
bounce buffering?

[ ... ]

> @@ -30,18 +43,23 @@ static enum device_trust driver_trust(struct module *=
mod)
>   * policy on trusting devices it attaches, update the device's trust
>   * level from that policy. Trust privileges beyond driver bind are
>   * realized in a bus's ->dma_configure().
> + *
> + * Reflect the operational trust level back to the public indicator.
>   */
>  bool device_trust_bind(const struct device_driver *drv, struct device *d=
ev)
>  {
>  	enum device_trust drv_trust =3D driver_trust(drv->owner);
> =20
> -	if (drv_trust !=3D DEVICE_TRUST_UNSET)
> +	if (drv_trust !=3D DEVICE_TRUST_UNSET) {
>  		dev->p->trust =3D drv_trust;
> +		dev->bus_trust =3D drv_trust;
> +	}
>  	return dev->p->trust > DEVICE_TRUST_NONE;
>  }

[Severity: High]
Does overwriting dev->bus_trust with the driver's software trust level disa=
ble
dynamic IOMMU DMA protections?

When device_untrusted() evaluates dev->bus_trust after binding, it will
transition to false. Will this silently disable protections like SWIOTLB
bounce buffering in dev_use_swiotlb() for active untrusted devices?

Also, if an untrusted parent bridge (e.g., a Thunderbolt port) binds to the
pcieport driver, its bus_trust becomes AUTO. Will hot-plugged downstream
devices fail to inherit the untrusted state because pci_untrusted(parent)
evaluates to false in set_pcie_untrusted()?

[ ... ]

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 7b2baffdd2f55..3e203d573a580 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -791,6 +793,7 @@ struct device {
>  	struct device_physical_location *physical_location;
> =20
>  	enum device_removable	removable;
> +	enum device_trust	bus_trust;
> =20
>  	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
>  };

[Severity: Low]
Is enum device_trust an incomplete type here?

Since <linux/device/trust.h> is not included in <linux/device.h>, does using
it as a value-type field cause a compilation error in files that don't incl=
ude
<linux/device/trust.h> manually?

[ ... ]

> diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
> index 3377d26dc485d..283d3196e5e69 100644
> --- a/include/linux/device/trust.h
> +++ b/include/linux/device/trust.h
[ ... ]
>  #ifdef CONFIG_DEVICE_TRUST
> +bool device_untrusted(struct device *dev);
>  void module_driver_trust(struct module *mod, const char *val);
> -void module_driver_trust_init(struct module *mod, bool distrust);
> +void module_driver_trust_init(struct module *mod, bool require_trust);
>  #else
>  static inline void module_driver_trust(struct module *mod, const char *v=
al)
>  {
>  	pr_warn("module: %s: trust=3D support disabled\n", mod->name);
>  }
> -static inline void module_driver_trust_init(struct module *mod, bool dis=
trust)
> +static inline void module_driver_trust_init(struct module *mod, bool req=
uire_trust)
>  {
>  }
>  #endif

[Severity: Low]
Does this missing #else stub for device_untrusted() cause build failures?

Since CONFIG_DEVICE_TRUST is selected by PCI, configuring a kernel without =
PCI
but with IOMMU DMA support leaves device_untrusted() implicitly declared in
core IOMMU code like dev_use_swiotlb(). Should there be a fallback inline
function here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D9
