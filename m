Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931499;
	b=OdUcz5HuBAx6UxXnK0E697SZKQXKHPNWAKb2RFv/89HCWy0w4m/qEeK3FMq9X1zSTPiu
	 pY3gvaCdOhWNgBqu9xUc232pHVKYIt/w6ntFxBgZE+XeVt5ty/ep9iu3D7UZxsp60A/oZ
	 hdU0sEakuSV4ba3MdLGHC1Ow3zuDrMwN8XA0WVPQ6q+I+2uUR47N+cljNaDK/id0yFMjB
	 tvE9vfL0i2dxM42EKMKoEIksp4r+hhH7yPJuQklEwOZODxEd0KvnVKBjAn2yugMa1N9S1
	 TAnDrP+zgPzl9Dh6IAqveT89vtzVuXPp79waHaGsm6Lk0i4Eh5eVmftmfOsZgUXz9WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931499;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eVBF4o0kEai+HPD0JhvCdx6pzmewisIty/Isb77lxGM=;
	b=tBY5R/2IxKZTKXyt3hNfZMCg2PaAH70SO6DPDmupNk3+/BCT2c9s5DH4ZIg8clC5MuYQ
	 YT3ETKnZMVD3bZfv0Zuijf/sukxhD/aZqF2eePrYyH21U/7lRp8cPxlpzkXlW9aR322zI
	 IAxekSfoGSECGh/70fWF6livyEMwl0TDZvSJwR1Lqo5U0YW633L09YuataaclibYCa3X2
	 1r8VWU9qmaeultQ2VUIhfQhkbYVMZyMxk1mM17CIXhOEZttVj8uu32vYagfb6DSlENv/M
	 mYIusGZmYRgSWrDigHRz8P2CfrEfEguZJJuBWiD6A5//W0CQ+nitkDNmAtm6hfGjTqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nu6Z0NrX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BD606A31C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nu6Z0NrX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76291F000C4;
	Tue, 17 Nov 2026 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794931499;
	bh=eVBF4o0kEai+HPD0JhvCdx6pzmewisIty/Isb77lxGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nu6Z0NrX6Xg3ih97kVPrwhWQsE+ddaN+aYZc0X+5fXYqDr82FBeSyk3+rTe1hm+MT
	 UPaT2/UUk1AnecXHPoWxRfmSTzhmvFxvLbICguz+EbvadS5AYcy2hRqk1AhJRMHqPz
	 +q1RDS2Gk2+bm0m97JCjwX7xlq070mBj6RVGEeXhJ9w6RODOpJ5Dq2IQpN+79mjTMV
	 f4sM5gdTpONscVZllD+nDGdddlK+ozgot8EjIM95QqMKumf3wWjm224uFuKQLVvbdF
	 to9ZD5ppyUfOM3Rgi5/ez9E4K2DE6pkfxy7bxwgyK7IP3tpwR7kHp0kz0JfLaXSpH+
	 PltTCr7lpnrkA==
Message-ID: <sashiko-outbox-219138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] ACPI: PM: Avoid initializing power management for
 absent devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Linux PCI" <linux-pci@vger.kernel.org>
In-Reply-To: <6047463.DvuYhMxLoT@rafael.j.wysocki>
References: <6047463.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 16:04:58 +0000
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
- [High] ACPI: PM: acpi_bus_init_power() leaves absent devices
  power_manageable in unknown state
--

commit e1ff9e3263028781a317610ed251f6f169a95bfb
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI: PM: Avoid initializing power management for absent devices

This commit restores the device presence check in acpi_bus_init_power()
and updates find_child_checks() to reject absent devices rather than
disabled ones.

> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 76104f715efa1..8007a0d64bb5b 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -360,6 +360,9 @@ int acpi_bus_init_power(struct acpi_device *device)
>  	if (device->power.state !=3D ACPI_STATE_UNKNOWN)
>  		return 0;
> =20
> +	if (!acpi_device_is_present(device))
> +		return -ENXIO;
> +
>  	/*
>  	 * The ACPI device power state can be only initialized once.  If this
>  	 * fails, ACPI power management will not be used for the device going

[Severity: High]
Does returning -ENXIO early here leave device->flags.power_manageable set
to 1 with device->power.state stuck at ACPI_STATE_UNKNOWN (0xff)?

acpi_bus_get_power_flags() sets power_manageable =3D 1 and power.state =3D
ACPI_STATE_UNKNOWN for any device with _PS0 or _PR0, and 2f4ddf2bd1ba
("ACPI: scan: Stop calling acpi_bus_init_power() early") stopped clearing
power_manageable when acpi_bus_attach() skips a non-present device.

When a physical PCI device is bound to a single matching _ADR companion
whose _STA reports not present (via check_one_child(), which bypasses
find_child_checks()), acpi_bus_attach() logs FW_BUG and falls through to
acpi_bus_init_power() without updating device->status:

drivers/acpi/scan.c:acpi_bus_attach() {
    ...
	pci =3D acpi_dev_get_pci_dev(device);
	if (pci) {
		if (!acpi_device_is_present(device))
			pci_info(pci, FW_BUG "ACPI status differs from reality\n");

		pci_dev_put(pci);
	} else if (!acpi_dev_ready_for_enumeration(device)) {
    ...
	acpi_bus_init_power(device);
}

With this early return, acpi_bus_init_power() fails without taking D0
power resource references or clearing power_manageable.  Because
acpi_pci_power_manageable() and acpi_bus_power_manageable() still see
power_manageable =3D=3D 1, subsequent power transitions on the PCI companion
(or on absent _ADR-bound SATA/USB devices) call acpi_device_set_power(),
which fails with -ENODEV because state < device->power.state (0xff) is
always true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6047463.DvuYhMxLoT@=
rafael.j.wysocki?part=3D1
