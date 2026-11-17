Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939958;
	b=4miADe104bJgqvJ9urFIRtv2fepNK+T7CSRh9HhOPL887agmqJwEVVWFJeQP40nVtbRG
	 +n1tliOb8E/cBiAWNTmiTZzrt+XhU78EGL5Wl1ryP+ke8S33yZKukqzi9xDf/9KrUlf+H
	 xxlFADGyGkXSeuCB9ZQrSDRMYB6N476GtB36a54WuydqzeCcVobEOY9CLyMdXvuDVehgL
	 SZV5cqDMAQhq2Df9Ippf7d63xOGAii9VkLTi6C4MUW1TpMDuKNWM8KMEOcKtSPQv66T1a
	 17TeEpIqUTEswA3dnll0Ww1H9nyV/LgXCKEOpfQpQFKxiaPbV3+c7DC1U+aTH12W/Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939958;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ed0Uritrr/48gFjn/SaZHMTtv1KYW+IYIw29ucrJhoE=;
	b=k9Khbi9JosluCVXnUKCz/20PkDVdBG9DAdqsrF+bx3cyZcuuBSTN50vQgeStdudCyqW9
	 eWVsmne++huq80CFGSXU0t2Y0qx1ASLuj6CYAJ+pPSK9Usu6D2as/Ew++ijo2D1HXpMcV
	 FW9fhRTauAsDsxHVYKlzXkPsvC1QGRSCLlE0mfAdKiAi50AY82O6CrYjNFZk0LfdbkG/o
	 /CMcKckHVUtQNkunp0pAgDlRbotyl8Q6Kb0H7EyrZ0iMGFTPEq+tMBDYYz6h9b41fRHaJ
	 f1Z02QuvoHhAJ3IUqhMm2rCe+F/hncUjUTdiECvlnVwxuNeunobY8SlUQqGDG/wUuTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9VjX7wH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B7606A31C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9VjX7wH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EC91F000C6;
	Tue, 17 Nov 2026 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794939958;
	bh=Ed0Uritrr/48gFjn/SaZHMTtv1KYW+IYIw29ucrJhoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9VjX7wHKz62j4NxsJhYoYSVeQg2FNJSu8D+Qy6jUREFKmjd9bU5rjFP0nLwXmuYi
	 LYq+w8alJd3Q1j0kKtwvztChdU6PVyV/muK/I9ozYfF/5rp/s9EbK5aPNAEZLzWgd0
	 r/dF2tIh7yk/u+EsbDxR2voR2Jg/nOxO+2T/Q9R9YIyI2w7LagBRJhIo05h2fNbBWg
	 UsjCK+w4CJpkwzkLRJRoACKZZYFvm/8T2Y58VndqqOg3J68/VcbRYMM+zb00Ktetoq
	 dIlTrzBdMBHudtw2Xny9m+UVDusKSo0/qyOS2GmvOdjYDPWG7zRJ1midvbn/F+9X8a
	 rZ7pXvy6eS6Jg==
Message-ID: <sashiko-outbox-219338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ACPI: PM: Avoid initializing power management for
 absent devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Linux PCI" <linux-pci@vger.kernel.org>
In-Reply-To: <2859265.mvXUDI8C0e@rafael.j.wysocki>
References: <2859265.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:25:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] ACPI: PM: acpi_bus_init_power() clears power_manageable without
  poisoning state
--

commit 0fdc7a0041a301b9912e9f5aa11b4ed9de27fe02
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI: PM: Avoid initializing power management for absent devices

This commit restores the device presence check in acpi_bus_init_power() and
updates find_child_checks() to reject absent devices rather than disabled
ones.

> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 76104f715efa1..ac2f8579110f0 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -360,6 +360,13 @@ int acpi_bus_init_power(struct acpi_device *device)
>  	if (device->power.state !=3D ACPI_STATE_UNKNOWN)
>  		return 0;
> =20
> +	if (!acpi_device_is_present(device)) {
> +		device->flags.power_manageable =3D 0;
> +		acpi_handle_debug(device->handle,
> +				  "Device not present, ACPI PM disabled\n");
> +		return -ENXIO;
> +	}

[Severity: High]
Can clearing device->flags.power_manageable while leaving
device->power.state as ACPI_STATE_UNKNOWN break ACPI PM and leak D0 power
resource references if the device later becomes present?

If acpi_bus_init_power() is called while a device is absent (for example
via acpi_power_up_if_adr_present() before a parent bridge is powered up or
during hotplug) and called again in acpi_bus_attach() after
acpi_bus_get_status() refreshes _STA, the second call proceeds to
acpi_device_init_power() with device->flags.power_manageable still set to 0
because 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power()
early") removed the re-initialization of power_manageable from
acpi_bus_attach().

Inside acpi_device_init_power(), acpi_device_get_power() sees
!device->flags.power_manageable and reports the parent's state (D0), after
which acpi_device_init_power() checks device->power.flags.power_resources
and calls acpi_power_on_resources() for D0:

drivers/acpi/device_pm.c:acpi_device_init_power() {
	...
	result =3D acpi_device_get_power(device, &state);
	if (result)
		return result;

	if (state < ACPI_STATE_D3_COLD && device->power.flags.power_resources) {
		/* Reference count the power resources. */
		result =3D acpi_power_on_resources(device, state);
	...
}

Because device->flags.power_manageable remains 0, subsequent calls to
acpi_device_set_power() fail with -EINVAL, leaving ACPI PM disabled for the
device and permanently leaking the D0 power resource references acquired
above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2859265.mvXUDI8C0e@=
rafael.j.wysocki?part=3D1
