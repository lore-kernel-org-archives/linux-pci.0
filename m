Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD163A3E91
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382303; cv=none; b=C/2Ox3/4lzY3bmQSlmenmAS3UA5BBPCz2wcHvLpsas2r/dGKfhNSvjrxevtcYPsWgy6/DkXpoGwor9SxCHLPTYyW+z4QtOcmQsBeZ28GcfAN7zx0ZEk9ZFNQqEkMPEv076UOpiRETXNTL9IuZUq3YkEiz2T0FNXxKGYGzhT9gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382303; c=relaxed/simple;
	bh=iFKQgebi9KM90Lpr4Ar0sc9ZtoQe0a0pH2jzWne/yKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JYxwzmF4ljzGb0idY1m+zK5oX5Fdn92VJlkqjkhoSUgheyF2+mOa3QlKJ670UjSNppUFcJvxgAGGqPpxkzbTwKCHKl9ybPJOLmzNAVKsP5Dzsls/Gyc03gNi7jLhYWLWLaD+gw0dqMb4PY8Wm0L3l8QTn36RzSPn6mD/AhmvbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzeu57Pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzeu57Pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF4D1F000E9;
	Wed,  2 Sep 2026 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788382301;
	bh=g9VHjmXSmpKfsEYryHoYwa1cm8WnyLTWm8CG/SqXm0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzeu57PvWW/FJ+4F5GpS8AGfI8vSCtDLH6vx1r08Nz6q8RW3VgXAhdpyBwWHJbrhZ
	 PAIAyXW20q4jftU38csSg9gtU6Jecnj2LJcz5Bc4ZGOK6wWy/AOdtGVmM9fhGHOveH
	 +lVEAuObs07wOs7XRUcyRTO7YFjGGJUQKtT9UDr4Lsol/+71kdTjBlZtDCtQOGP47i
	 ONZ8igtpbzXugg8HwGaPdBQGBgXJVHjaDi1/alRU+kD26zaURV7YlnjStTltkHJA5k
	 L3fVerimvYSKDcFplv9kaSdvF5hMsiGpmXPtjXXdwFdF6UMvkf5bC5u/1fZMGrcq2I
	 XUfshFbNscIPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] ACPI: scan: Take PCI device enumeration into
 account directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <6207934.MhkbZ0Pkbq@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <6207934.MhkbZ0Pkbq@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:51:40 +0000
Message-Id: <20260902205141.4DF4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypassing `acpi_bus_get_status()` for PCI companions leaves `devic=
e->status` stale, which can cause `acpi_device_is_present()` to incorrectly=
 return false.
--

commit 7f00077fea1f2ada305a470b1a050f31934232c4
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI: scan: Take PCI device enumeration into account directly

This commit skips evaluating ACPI device status during hierarchy walks
for devices already associated with a PCI companion, assuming they are
present and functional because the PCI devices are already enumerated.

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f4718b0207e0e..34f7f477a25ad 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
[ ... ]
> @@ -2353,10 +2355,26 @@ static int attach_subtree(struct acpi_device *dev=
ice, void *not_used)
>  	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
>  		register_dock_dependent_device(device, ejd);
> =20
> -	acpi_bus_get_status(device);
> -	/* Skip devices that are not ready for enumeration (e.g. not present) */
> -	if (!acpi_dev_ready_for_enumeration(device))
> -		return 0;
> +	/*
> +	 * If the given ACPI device object has been already associated with a
> +	 * PCI device found on the bus, its status is effectively "present
> +	 * and functional".
> +	 */
> +	pci =3D acpi_dev_get_pci_dev(device);
> +	if (pci) {
> +		acpi_handle_debug(device->handle, "PCI companion %s found\n",
> +				  pci_name(pci));
> +
> +		pci_dev_put(pci);
> +	} else {

[Severity: High]
Bypassing acpi_bus_get_status() for PCI companions leaves device->status
stale. Could this cause acpi_device_is_present() to incorrectly return fals=
e?

If the initial evaluation of the device status returned 0 (e.g., due to unm=
et
dependencies at boot or firmware quirks), device->status.present will remain
0 permanently because it is not explicitly updated here to reflect the
"present and functional" assumption.

This stale status might prevent ACPI power management features, such as
acpi_device_fix_up_power(), and other subsystems relying on
acpi_device_is_present() from properly operating on the device.

> +		acpi_bus_get_status(device);
> +		/*
> +		 * Skip devices that are not ready for enumeration (e.g. not
> +		 * present).
> +		 */
> +		if (!acpi_dev_ready_for_enumeration(device))
> +			return 0;
> +	}
> =20
>  	acpi_ec_register_opregions(device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5144065.31r3eYUQgx@=
rafael.j.wysocki?part=3D6
