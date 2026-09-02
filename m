Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A0391849
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379131; cv=none; b=NEsEZwRGIso0/JABWa8mJwlRXUXGY55Mz0Dn2HdyZ5Lq5gYu0i/2jXtyuHjvJU0n2QMjCe+3OxD63VfZSNE/fB4L/CSPWGOuGpy7kv7moehK3Wb6++mht28129pSc8tspmWnyXKg86yNDKXIU8qE5aNzy2+DQplobDtIUAe7v4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379131; c=relaxed/simple;
	bh=naArTXgJyYcWqFFQg+WJ1seJl7Myn8Sq+WepBpoiJmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aRRc480BNT/eFxMegGK+phSb05Fi8ZbmPYCHlb6ouEXCXyToBemMHFTte9K0dpIMnQfFY2S+Wkj2oO3YrDCcJRcsGAEDac1n6XqYmrZQ9eP5CkA8MqI0G2DFfp74ICJdfnI0lA5ZNJLfDPuE99RJRvmIn5kHOKtroP0hFtp9h6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlX0WTGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlX0WTGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174031F000E9;
	Wed,  2 Sep 2026 19:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379129;
	bh=OpZCSg6L97jdrgJAE7krjU1HuUUubaVXDNT3N3DRjtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mlX0WTGQxcVBb4ztp8iMZ+xSuha81aRGCDsCEx7sh/oUsJ+C4kijWbtQo2pm3LCdl
	 tjy1Dd+CInZkPZHrybr1j6UyUaaTuPi91NcbKhcfsF4Otnoeg5RfD03gJu518Fxwp1
	 0hsfgb5EIhnU73A1ytbYncwQtIqC8eP8j9arlVc53z9hC4rcG/H+OuQUgEmSELoZZ3
	 P/5gRA8MVABY8qGdkmywi3E/kyhGn+DnsIkdYjfVPQMz3QLsOy4bDq+SR2OxeAA0so
	 d1+lD2U3o1vALNv567gtiXJVRO4ZoT/rO2yAYO2ijnc+VPTBcLKz6AHeJAzIwrBd7c
	 PsB2VurbC0HMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] ACPI: scan: Stop calling acpi_bus_init_power()
 early
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3076831.e9J7NaK4W3@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <3076831.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 19:58:48 +0000
Message-Id: <20260902195849.174031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Global mutex init_power_lock in acpi_bus_init_power causes deadloc=
ks when power initialization of one device indirectly triggers initializati=
on of another.
- [High] The poisoned ACPI_D_STATE_DISABLED state is silently overwritten b=
y acpi_device_update_power() for devices without power resources.
- [High] Leaving device->flags.power_manageable =3D 1 when power initializa=
tion fails aborts system suspend.
- [High] TOCTOU race in acpi_device_set_power allows bypassing the disabled=
 power state safety check.

Pre-existing issues:
- [High] Unreleased ACPI power resource references if acpi_dev_pm_explicit_=
set() fails.
--

commit 6095d5c97ad32b03d70b1c09e3f9a5916aa85e11
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

    ACPI: scan: Stop calling acpi_bus_init_power() early

    There is a problem, introduced by commit 9d9bcae47fd5 ("ACPI: delay
    enumeration of devices with a _DEP pointing to an INT3472 device")
    inadvertently, that devices with missing dependencies may be put
    into power state D0 prematurely [1].

    Namely, acpi_bus_init_power() called by acpi_bus_get_power_flags()
    during the early initialization of ACPI device objects, may discover
    that all of the power resources needed by the given device to be in
    power state D0 are initially on, so it will reference count those
    power resources and transition the device into D0.

    Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-r=
ef-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]

> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 4269735aadde5..e13096cfd7909 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
[ ... ]
> @@ -157,6 +159,15 @@ int acpi_device_set_power(struct acpi_device *device=
, int state)
>  	    || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
>  		return -EINVAL;
> =20
> +	if (device->power.state =3D=3D ACPI_D_STATE_DISABLED)
> +		return -ENXIO;
> +
> +	if (device->power.state =3D=3D ACPI_STATE_UNKNOWN) {
> +		result =3D acpi_bus_init_power(device);
> +		if (result)
> +			return result;
> +	}
> +

[Severity: High]
Since device->power.state is checked outside of the init_power_lock, can a
TOCTOU race occur here?

If two threads enter acpi_device_set_power() concurrently for a device in
ACPI_STATE_UNKNOWN:

1. Thread 1 calls acpi_bus_init_power(), fails, and poisons the state to
ACPI_D_STATE_DISABLED.
2. Thread 2 acquires init_power_lock in acpi_bus_init_power(), sees the
state is no longer ACPI_STATE_UNKNOWN, and returns 0 (success).
3. Thread 2 then proceeds to apply power transitions to a device that Thread
1 just poisoned.

[ ... ]
> @@ -293,20 +304,11 @@ int acpi_bus_set_power(acpi_handle handle, int stat=
e)
>  }
>  EXPORT_SYMBOL(acpi_bus_set_power);
> =20
> -int acpi_bus_init_power(struct acpi_device *device)
> +static int acpi_device_init_power(struct acpi_device *device)
>  {

[Severity: High]
This is a pre-existing issue, but does this function leak power resource
references?

If acpi_power_on_resources() succeeds but the subsequent call to
acpi_dev_pm_explicit_set(device, state) fails, it returns the error
immediately without dropping the power resource references acquired just
before.

[ ... ]
> @@ -340,9 +342,43 @@ int acpi_bus_init_power(struct acpi_device *device)
>  		state =3D ACPI_STATE_D0;
>  	}
>  	device->power.state =3D state;
> +
> +	acpi_handle_debug(device->handle, "Initial power state: %s\n",
> +			  acpi_power_state_string(state));
> +
>  	return 0;
>  }
> =20
> +int acpi_bus_init_power(struct acpi_device *device)
> +{
> +	static DEFINE_MUTEX(init_power_lock);
> +	int result;
> +
> +	/*
> +	 * This is done to prevent power state initialization from being carried
> +	 * out twice in parallel for the same device (not impossible, but very
> +	 * unlikely).
> +	 */
> +	guard(mutex)(&init_power_lock);

[Severity: High]
Can this global non-recursive mutex cause deadlocks?

If acpi_device_init_power() (called while holding this lock) evaluates ACPI
methods (e.g., _ON) that access an ACPI Operation Region, it can trigger a
runtime resume of the controller device. If the controller device's power
state is ACPI_STATE_UNKNOWN, its runtime resume path (e.g.,
acpi_device_set_power()) will recursively call acpi_bus_init_power(), leadi=
ng
to a deadlock on this static mutex.

> +
> +	if (device->power.state !=3D ACPI_STATE_UNKNOWN)
> +		return 0;
> +
> +	/*
> +	 * The ACPI device power state can be only initialized once.  If this
> +	 * fails, ACPI power management will not be used for the device going
> +	 * forward.
> +	 */
> +	result =3D acpi_device_init_power(device);
> +	if (result) {
> +		device->power.state =3D ACPI_D_STATE_DISABLED;

[Severity: High]
Is this disabled state fully protected from being overwritten by other
functions?

If acpi_bus_init_power() fails, the state is set to ACPI_D_STATE_DISABLED.
Later, if acpi_device_update_power() is called, it sees the state is not
ACPI_STATE_UNKNOWN, bypasses the initialization check, and calls
acpi_device_get_power(). If the device has no power resources, it executes
device->power.state =3D state;, unconditionally wiping out the
ACPI_D_STATE_DISABLED marker.

> +		acpi_handle_info(device->handle,
> +			"Failed to determine initial power state, ACPI PM disabled\n");
> +	}
> +
> +	return result;
> +}
> +
>  /**
>   * acpi_device_fix_up_power - Force device with missing _PSC into D0.
>   * @device: Device object whose power state is to be fixed up.
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f48715ed827c7..4586f1798685f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
[ ... ]
> @@ -2364,16 +2361,10 @@ static int acpi_bus_attach(struct acpi_device *de=
vice, void *first_pass)
> =20
>  	acpi_ec_register_opregions(device);
> =20
> -	if (!device->flags.initialized) {
> -		device->flags.power_manageable =3D
> -			device->power.states[ACPI_STATE_D0].flags.valid;
> -		if (acpi_bus_init_power(device))
> -			device->flags.power_manageable =3D 0;
> +	acpi_bus_init_power(device);

[Severity: High]
Does ignoring the return value of acpi_bus_init_power() here break system
suspend?

By no longer clearing device->flags.power_manageable when initialization
fails, the device remains power manageable but its state is marked
ACPI_D_STATE_DISABLED. During system suspend, acpi_dev_pm_low_power() will
see it is power manageable and call acpi_device_set_power(). Encountering
ACPI_D_STATE_DISABLED, acpi_device_set_power() returns -ENXIO, which
propagates to the PM core and aborts the suspend process entirely.

> =20
> -		device->flags.initialized =3D true;
> -	} else if (device->flags.visited) {
> +	if (device->flags.visited)
>  		goto ok;
> -	}
> =20
>  	ret =3D acpi_scan_attach_handler(device);
>  	if (ret < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5144065.31r3eYUQgx@=
rafael.j.wysocki?part=3D2
