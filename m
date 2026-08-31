Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C88383C67
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207268; cv=none; b=Tdu0R1QYcIZ1tZeG4n67MWzMHUUqnjRNMYLrkWCZCnRQfMzTX/W76kWKOQh4xoYQr+OthESzA5O6MISDKFwj49gERxS9cD1OC7Kd66uvi+A1O/z5B+IlBN6NgMPtiXlHH1SDUw6liGz6hmTq1Dw4ORLMTwe6PtSDX+aJUWq+bBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207268; c=relaxed/simple;
	bh=Jix3tJs8AbXT1wCIVwpAjkfRp2fydQXZwVeHhU5XadE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DEoJNxz7cKb3T6fVKVw8cMj5jsLJNxRqbv5eNUdLCTlw6nWMC1S4NBj4R0PUnDoBQ/ZqFsSKVnY9dyi36bZWBF4OK8rN7czxtviZ3rcOqVJxdXNhVjxQjQAvn84QZrxMzmbJixCbtVwSsJqBb0LhGOL64gFIiR4yxiONRzd+3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI8XsFPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI8XsFPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F091F000E9;
	Mon, 31 Aug 2026 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207266;
	bh=OZ6ygt/2MLRVTSaLA+SkIWFbuEbZ5dMlh0skzcso72Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kI8XsFPWLPN+iU3yPXgDteKpIw9tN2e1Z3niX5D8p0jl0vA241XitFSdVGkdkOn7Y
	 olgUCn2nBAguunNIWxDSOjQ/vIL4IbJ7dRf/IImVIOZlcvLWxUcDLqTJ8yT+ecSTeL
	 XFGqOOrutp8Q857NxkcsQSIWvNqxw1Ml0w+hqOR44pU8tfD1zDaeS60o31GTZhuZQs
	 jAs6FuI/QJHy5J3XU8G5RF149YbMh2Tac6nWlIoCBVW5lLiWidS1jRPrqKTTxw45Pk
	 RsjOzgD7qmU4yNEoXfBKZMgUt9Gj70rCfyx1wk9GyOZm0QP4VeqxG3HTsmXEt4cJbI
	 g2Nrc+binLsvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] ACPI: scan: Stop calling acpi_bus_init_power()
 early
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <10913616.nUPlyArG6x@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <10913616.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:14:26 +0000
Message-Id: <20260831201426.92F091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Transient failures in early PCI enumeration due to unmet ACPI depe=
ndencies permanently disable ACPI power management for the device.
- [High] Concurrent execution of `acpi_device_set_power` and `acpi_bus_atta=
ch` leads to power resource reference count leaks.
- [High] Bitfield data race on `struct acpi_device_flags` leading to corrup=
ted device flags.
- [High] Unprivileged sysfs access to a child's power state bypasses the pa=
rent's power resource initialization, leading to reference count underflow =
and permanent power leaks.
--

commit 00db710bd9860a36a16f28aa782d074b11d43aab
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI: scan: Stop calling acpi_bus_init_power() early

This commit prevents premature transition into the D0 power state for
devices with missing dependencies by changing when acpi_bus_init_power()
is called. It updates acpi_device_set_power() to initialize power upfront
and adjusts acpi_bus_attach() to use ACPI power state tracking instead of
the initialized flag.

Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-f=
ix-v2-1-29818173ea13@linux.spacemit.com/ [1]

> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index aa55ecfc2923c..a680e6972a8c2 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c

[ ... ]

> @@ -168,6 +168,12 @@ int acpi_device_set_power(struct acpi_device *device=
, int state)
>  	    || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
>  		return -EINVAL;
> =20
> +	if (device->power.state =3D=3D ACPI_STATE_UNKNOWN &&
> +	    acpi_bus_init_power(device)) {
> +		device->flags.power_manageable =3D 0;

[Severity: High]
If acpi_bus_init_power() fails transiently here because dependencies are
unmet (for instance, _PSC or _ON evaluations fail during early PCI
discovery), does this permanently disable ACPI power management for the
device? Since the prior restoration logic was removed from
acpi_bus_attach(), it appears there is no mechanism to recover from this
transient failure when dependencies are met later.

[Severity: High]
Because struct acpi_device_flags is a bitfield, does modifying
power_manageable here without mutual exclusion risk a data race?=20

If acpi_device_set_power() runs concurrently with async enumeration
(such as acpi_bus_attach() calling acpi_device_set_enumerated()), they
could perform concurrent read-modify-write operations on the bitfield.
This could cause one of the flag updates (like the visited or enumerated
flag) to be silently lost.

> +		return -ENODEV;
> +	}
> +
>  	acpi_handle_debug(device->handle, "Power state change: %s -> %s\n",
>  			  acpi_power_state_string(device->power.state),
>  			  acpi_power_state_string(state));

[ ... ]

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f48715ed827c7..1ad8dffc2dafe 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c

[ ... ]

> @@ -2364,16 +2361,13 @@ static int acpi_bus_attach(struct acpi_device *de=
vice, void *first_pass)
> =20
>  	acpi_ec_register_opregions(device);
> =20
> -	if (!device->flags.initialized) {
> -		device->flags.power_manageable =3D
> -			device->power.states[ACPI_STATE_D0].flags.valid;
> -		if (acpi_bus_init_power(device))
> -			device->flags.power_manageable =3D 0;
> +	if (device->flags.power_manageable &&
> +	    device->power.state =3D=3D ACPI_STATE_UNKNOWN &&
> +	    acpi_bus_init_power(device))

[Severity: High]
Is it possible for acpi_bus_attach() (running asynchronously via
acpi_scan_clear_dep_fn()) and acpi_device_set_power() (reachable via
sysfs power/control) to execute concurrently?=20

Both paths now perform a lockless check of
device->power.state =3D=3D ACPI_STATE_UNKNOWN and subsequently call
acpi_bus_init_power(). Could this lead to both threads acquiring power
resource references via acpi_power_on_resources(), keeping the hardware
powered on indefinitely when the second set of references is leaked?

[Severity: High]
Could an unprivileged user reading the real_power_state sysfs attribute
of a child device bypass this parent initialization?

If a sysfs read calls acpi_device_get_power() on the child, it can
locklessly mutate the parent's state to ACPI_STATE_D0:

acpi_device_get_power() {
    ...
    if (!device->power.flags.ignore_parent && parent &&
        parent->power.state =3D=3D ACPI_STATE_UNKNOWN &&
        result =3D=3D ACPI_STATE_D0)
            parent->power.state =3D ACPI_STATE_D0;
    ...
}

If this occurs before acpi_bus_attach() runs for the parent, the
lockless check here in acpi_bus_attach() will see a state other than
ACPI_STATE_UNKNOWN and skip calling acpi_bus_init_power().=20

Does this result in the parent's power resources never being initialized,
leading to a reference count underflow when the device later transitions
to D3?

> +		device->flags.power_manageable =3D 0;
> =20
> -		device->flags.initialized =3D true;
> -	} else if (device->flags.visited) {
> +	if (device->flags.visited)
>  		goto ok;
> -	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3435655.aeNJFYEL58@=
rafael.j.wysocki?part=3D1
