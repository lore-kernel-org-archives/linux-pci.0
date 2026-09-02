Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602637B020
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380793; cv=none; b=QYDRi0D/imjBnBX4PpdZOz1rWyJJUPbPfBK0JxX6BZpGrKHawPzwkKJEI/JuK3kz2CDkBkLHHhcNmF44G/7nbUcG/mF5jK8zQzm2vPmiiPXdeKttu8KfrG8AA32ib/J/A2UjyPSNAMWAdJWX3U7jsK8PuGIlzp39zhTpGdwv6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380793; c=relaxed/simple;
	bh=ccpvm7/HRdI0W/0EjTUuZJ1yA8W0HrsrAP61D0OYMmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MG0C7jmRpWMNEVIMkn5qaHnF9jwSwbwK9xfq9ItmM++CJieMkTfbmRHeyNlopPBpA49QEqS287WgVc2zdpWFZ+S0T7p0FMjYpORqRvyXQH0fUgAJN4qlcyRr6wXBgDyC9u77qDWbFrX+R+XNWRee9cJEVGZB4RMpKthOqN/8xm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vegbadiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vegbadiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDB81F000E9;
	Wed,  2 Sep 2026 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788380791;
	bh=y9Dk4TKILolS8w15234AH9sIuwlvAYM4gOTi4oTKwWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vegbadiwgb8SX30XXNm2hyllQpuN/4JIy7z52pMBQ8hVsoj9Pu+uRECc0yDy6YlUs
	 m9JgIC1hBLYpb1ltBlSOgHYSke4OEdeak1AJhTIumvDspQJ0nEYab8JRpFBkWzZZz8
	 QVD8BT2cujqtzNXM9wjgYFWVGB+2IHwQQd1CBKIdjqglUNkV/6RFLxKZ6g2VJ+FiHl
	 UEQ3ZbjkdD/MIrqnNGSIQ149ZFqeYiDAY/I0lZUhgX5hVbWtcBUDSaKZT2u6tg/hVF
	 3PAa41VgdPGGnNpfFgVyIBWsqg1stZtoNKFWvSZlxmmgclQRRXQKo45p6SsKRr5nXt
	 Zc+uRNGxY/N2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] ACPI: scan: Add ACPI device enumerated marker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3985136.kQq0lBPeGt@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <3985136.kQq0lBPeGt@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:26:30 +0000
Message-Id: <20260902202631.3BDB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message establishes a strict structural invariant: 'T=
he rule regarding flags.visited and the "enumerated" field is that the latt=
er cannot be set until the former has been set and they need to be cleared =
in reverse order.' However, the implementation violates this rule in multip=
le paths. For early and fixed devices, `acpi_bus_register_early_device()` a=
nd `acpi_bus_add_fixed_device_object()` call `acpi_default_enumeration()`, =
which sets `enumerated =3D true`, but their `flags.visited` is never set to=
 1. Additionally, for generic devices, `acpi_scan_attach_handler()` calls `=
acpi_generic_device_attach()`, which triggers `acpi_default_enumeration()`,=
 setting `enumerated =3D true` before `acpi_bus_attach()` sets `device->fla=
gs.visited =3D 1`.
--

commit 193e84bf6b51af7db08c641525537f0a2b63b3c2
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI: scan: Add ACPI device enumerated marker

Currently, the "visited" flag of ACPI device objects has two roles.
One of them is to indicate that the given ACPI device object has been
enumerated, and the other is to indicate that acpi_bus_attach() has
processed the device. This commit adds a new "enumerated" bool field to
struct acpi_device to separate these purposes.

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7208cc5158660..2e853add5e605 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
[ ... ]
> @@ -2338,46 +2340,42 @@ static int acpi_scan_attach_handler(struct acpi_d=
evice *device)
>  	return ret;
>  }
> =20
> -static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
> +static int acpi_bus_attach(struct acpi_device *device, void *not_used)
>  {
[ ... ]
>  	acpi_bus_init_power(device);
> =20
> -	if (device->flags.visited)
> -		goto ok;
> -
>  	ret =3D acpi_scan_attach_handler(device);
>  	if (ret < 0)
>  		return 0;
> =20
> +	device->flags.visited =3D 1;

[Severity: Medium]
The commit message establishes a strict structural invariant: 'The rule
regarding flags.visited and the "enumerated" field is that the latter cannot
be set until the former has been set and they need to be cleared in reverse
order.'

Does the implementation violate this rule in multiple paths?

For generic devices, acpi_scan_attach_handler() (called just above) calls
acpi_generic_device_attach(), which triggers acpi_default_enumeration().
This sets enumerated =3D true before acpi_bus_attach() reaches this line to
set device->flags.visited =3D 1.

Additionally, for early and fixed devices, acpi_bus_register_early_device()
and acpi_bus_add_fixed_device_object() call acpi_default_enumeration(),
which sets enumerated =3D true, but their flags.visited is never set to 1.

> +
>  	if (device->flags.enumeration_by_parent ||
>  	    (!ret && (device->pnp.type.platform_id || device->pnp.type.backligh=
t)))
>  		acpi_default_enumeration(device);
>  	else
>  		acpi_device_set_enumerated(device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5144065.31r3eYUQgx@=
rafael.j.wysocki?part=3D4
