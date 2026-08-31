Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31C38887C
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210198; cv=none; b=frTXGTAqMIKFsoilgEWUGHdFMJWR03lbCV7jiZK6xYXg9EpGFbqzyQPUI7x2oX+g9xpTrubdTc12aABdsrlLSvPNmw7XW8Pjhs0GhS2m4aYKn5FtoeMLjIQW3eL1EvdyxHUXbYDU8WAx2nL8RXnl7ZeZn8mgWkO15zc7FCtXqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210198; c=relaxed/simple;
	bh=bVtGZ/v2fcyDyYR6VqJX2GIrSvZvlqPJWX339Zx2Omk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rUnueoGDcisMixPdlx1Iw6yOciOxG70FyksbihX7oNwH/Z/P8gDwKqKJv2awx7TAOmpUZYYS0qxtg1QpqmRTpKDulsgDIHo9zHbFxUbnlOx4BCBgHZ88pTFRMP80albHNbFOuEYCM1ob2HJ/DaLVFwyo/HVpMaB1xfUM3DVfc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYdFAMIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYdFAMIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857181F000E9;
	Mon, 31 Aug 2026 21:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210196;
	bh=m5TVHvZLuYa0OqYIRuOAiwDxc7frEECo7ZDE8nIr7WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYdFAMIkIOCyJCmuB9G50F11gFTJR1s9aHMdlQrROQSvCOMsRxaypeqhZ5WyZY0c+
	 mwETj/fprHI1oBy0mas6/v9NwVERjJVY9yHODSh3xQvVevHXp+gkijDcIrtvaXD8LD
	 4E9SS6JhvF1KUGSHvQFzX8pOBPVXg8EPgbD22IrlvLGzlK9mzEo0sI1fboOk35ISjC
	 8J99nSVyzTjaARXKJ67FQ0U5TmqG/c8SlSCTtd+y7n5sgTCzHvUIYFcz9I/DUiV1Up
	 y65RwOe9+D+22GG1WKoh5ZVdKxTwFxRG5J+qrr4cyhV3bEygpqMQ9V1FQ4GM1/0l8m
	 IXL66DrWh/wKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/7] ACPI: bus: Drop initialized flag from struct
 acpi_device_flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3782570.R56niFO833@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <3782570.R56niFO833@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:03:16 +0000
Message-Id: <20260831210316.857181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `initialized` flag causes the device enumeration chec=
k to remain true after a failed hot-remove eject, leading to a double-detac=
h and a NULL pointer dereference (e.g., in `acpi_pci_root_remove()`) upon s=
ubsequent status checks.
--

commit 8f4c1e701ec6dd8150885a28ad18d087926defd7
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI: bus: Drop initialized flag from struct acpi_device_flags

After previous changes, the ACPI device object "initialized" flag is
not particularly useful. It is set almost all the time and it is
only checked along with the "visited" flag, but checking the latter
is sufficient. Drop it accordingly.

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5aa3ecb000e14..019a43e3b5d7f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -281,7 +281,6 @@ static int acpi_scan_check_and_detach(struct acpi_dev=
ice *adev, void *p)
>  	 * that.
>  	 */
>  	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> -	adev->flags.initialized =3D false;
> =20
>  	/* For eject this is deferred to acpi_bus_post_eject() */
>  	if (!(flags & ACPI_SCAN_CHECK_FLAG_EJECT)) {

[Severity: High]
Could removing this state barrier cause a double-detach and a NULL pointer
dereference if a hot-remove eject fails?

When a hot-remove eject operation is initiated (ACPI_SCAN_CHECK_FLAG_EJECT),
acpi_scan_check_and_detach() executes handler->detach(adev).

For a PCI root device, acpi_pci_root_remove() frees the acpi_pci_root
structure and sets device->driver_data =3D NULL. At this stage, adev->handl=
er
and adev->flags.visited are intentionally left uncleared because they are
deferred to acpi_bus_post_eject().

If the firmware eject (_EJ0) fails, acpi_scan_hot_remove() aborts and
acpi_bus_post_eject() is skipped. This leaves the device in the tree with
adev->handler attached and visited =3D 1.

Before this patch, adev->flags.initialized =3D false was unconditionally set
during the eject phase, so a subsequent status check would evaluate
acpi_device_enumerated() to false and safely abort.

By removing the initialized flag, the status check relies solely on visited.
This bypasses the early return and executes handler->detach(adev) a second
time.

Handlers like acpi_pci_root_remove() do not check if acpi_driver_data() is
NULL on a second pass, and will crash when dereferencing root->bus:

drivers/acpi/pci_root.c:acpi_pci_root_remove() {
    ...
    struct acpi_pci_root *root =3D acpi_driver_data(device);
   =20
    pci_lock_rescan_remove();
    pci_stop_root_bus(root->bus);
    ...
}

[ ... ]

> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index b0d9057ccb8ab..596fbd748e88d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -654,7 +653,7 @@ void acpi_set_modalias(struct acpi_device *adev, cons=
t char *default_id,
> =20
>  static inline bool acpi_device_enumerated(struct acpi_device *adev)
>  {
> -	return adev && adev->flags.initialized && adev->flags.visited;
> +	return adev && adev->flags.visited;
>  }

[Severity: High]
Does this change bypass the protection that initialized provided during fai=
led
hot-remove operations as described above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3435655.aeNJFYEL58@=
rafael.j.wysocki?part=3D3
