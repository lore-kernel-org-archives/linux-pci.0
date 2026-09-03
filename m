Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8239A4D6
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456279; cv=none; b=ilpFDsSsWz6Okj4xANnuOL3B4NxvU4et8xIs3MYfyrJ9MczbG2EMTi6BnLWb5eXROY12pFKz5cKuYrqh7gM9YaMkegGawUUK1pgK2RdI83p0ZRZoz9aRQOmEEHBgtwQZlp7rbi302gXP1HcRrnXWAUcYC7ImQqtfouCX5rSqiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456279; c=relaxed/simple;
	bh=/6GcFj+49xH1m6Iar7DqrlSkodpQsQY+TIx4wCpknRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAs2ErwbucKR3AH9uJc8cEBmCzmeokmBCszwbpWuDECFFB9sFX0dibs7Wf9a9nJoQvAyAowL6J1sO1+Ds0MDX+gw2Ai/GEM790IvJF5l2ZS3nqY73nOCCK0O6WrJN1Mm7Epi0SwymKALbu5cagAZ8GK5L7gqi2kLPNe0Y+LbaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlK/Sm9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlK/Sm9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB90B1F000E9;
	Thu,  3 Sep 2026 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788456278;
	bh=oRtbqlNDhBPECmQ0gPSCOoBNIHrxY286lFODqRvh+Ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RlK/Sm9EG1plUf33KqlwdCidtHSEjxf6GIYjHCxfrNPKcS+gNWKJknvHVaGRI7DxP
	 ZNuTPheZ2iQHy74GjRrTfw4BAJlzmFTqD2juCjCrYF8dH6/Q+o7B9SIoisgCPHsDvx
	 ATwws8y247mTB2uTrZNeuPcuZ3A4plX6uw18lOhHVnMEUdVgxe8Bys739iT73zvR/w
	 fq8BHOERDliAQGRMbm5uPrd44MrOTKT6M4TkvgGn/zKKmxgJx/knPWa8FJq+2pDqXm
	 o76sI8qO5+nYjgYhdv/mvLjG3U6FQH4cgd0dFol6AEoOnhfeN50rV8USWfCQY3UigM
	 s/2uVLAgKHIMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] ACPI: scan: Stop calling acpi_bus_init_power()
 early
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2295263.irdbgypaU6@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
 <2295263.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 17:24:37 +0000
Message-Id: <20260903172437.CB90B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Non-power-manageable devices are incorrectly left in `ACPI_STATE_D=
0` instead of inheriting their parent's power state, breaking the non-recur=
sive power state hierarchy.
--

commit 1b9c3462d28f35e1a6f47e065a29b14b3971db3a
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI: scan: Stop calling acpi_bus_init_power() early

This commit stops calling acpi_bus_init_power() from
acpi_bus_get_power_flags() to prevent devices with missing dependencies
from being put into D0 prematurely. It introduces a separate invocation
during PCI device initialization and uses ACPI power state tracking to
decide when to initialize a device's power state.

Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-f=
ix-v2-1-29818173ea13@linux.spacemit.com/

> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 4269735aadde5..76104f715efa1 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
[ ... ]
> @@ -340,9 +346,36 @@ int acpi_bus_init_power(struct acpi_device *device)
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
> +	int result;
> +
> +	if (device->power.state !=3D ACPI_STATE_UNKNOWN)
> +		return 0;

[Severity: High]
Does this check prevent non-PM devices from ever executing
acpi_device_init_power()?

In acpi_add_single_object(), struct acpi_device is zero-initialized, which
defaults device->power.state to 0 (ACPI_STATE_D0). If a non-PM device skips
the ACPI_STATE_UNKNOWN assignment in acpi_bus_get_power_flags(), this early
return will silently freeze its state at D0 instead of letting it inherit
its parent's power state.

> +
> +	/*
> +	 * The ACPI device power state can be only initialized once.  If this
> +	 * fails, ACPI power management will not be used for the device going
> +	 * forward.
> +	 */
> +	result =3D acpi_device_init_power(device);
[ ... ]
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f48715ed827c7..f219a16e018a4 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
[ ... ]
> @@ -1145,8 +1146,7 @@ static void acpi_bus_get_power_flags(struct acpi_de=
vice *device)
>  			device->power.states[ACPI_STATE_D3_COLD].flags.valid =3D 1;
>  	}
> =20
> -	if (acpi_bus_init_power(device))
> -		device->flags.power_manageable =3D 0;
> +	device->power.state =3D ACPI_STATE_UNKNOWN;

[Severity: High]
Will non-power-manageable devices be incorrectly left in ACPI_STATE_D0
because of this new assignment's placement?

Earlier in acpi_bus_get_power_flags(), the code returns early for non-PM
devices:

	/* Presence of _PS0|_PR0 indicates 'power manageable' */
	if (!acpi_has_method(device->handle, "_PS0") &&
	    !acpi_has_method(device->handle, "_PR0"))
		return;

Because this early return happens before the assignment to
ACPI_STATE_UNKNOWN, non-PM devices bypass it and retain their
zero-initialized D0 state.

Can this break the non-recursive ACPI power state hierarchy check?

If intermediate non-PM devices are left in D0, a PM-capable child device
might be incorrectly allowed to power up to D0 even if its grandparent is
physically powered off (D3_COLD). This could lead to bus errors or system
crashes when the child attempts to access powered-off hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6044499.DvuYhMxLoT@=
rafael.j.wysocki?part=3D2
