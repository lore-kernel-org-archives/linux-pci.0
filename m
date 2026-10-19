Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442500;
	b=rfNOZzjmOJN/ytpkz3R2qYR9hYpQVVNxsYT1Y8pBrT0wS5N2SO2fEwaRHzgD5yJdlWTm
	 tS2erBNRc018nB7tjUIL3DKdjtwGz0RWXB49DUnpVNhbwvMM3saxdrVByvVkuK4tEPYas
	 mUOGXtvmMKHZ6I5T9qIj7wAhIzVm4byjYsUO4tYjMzecHu1CbI7vcVFEawNaxePSolP/J
	 NOCuo+NwwIJUtleuIfS4JWmSx06hVAlcgsj/CL0XgIkNVF9JBuPORZozM9UbZP/WycGMh
	 qEHdCS0kGzaLWecDhuOOeUkGluOEzJNG0ZbTpBJLyeVcjTe1A3yvcesjgo1yGKFWDeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xMYnA59rJUHE+9uisf/d1TkvwdnPXvlYGjJveBH3dyQ=;
	b=d/OdEWWJ6/ntJwWF25noUm0dIUv9UvrqOAcAQZ95TOWHnZ42s9e5obUyCcAeqSK+8wMg
	 TVMpa78AP0Z/OvCjjiRpzhQ1fWxtaOvAw5AwzgKz/Bc5rzJcKIM1dpy5rXNglzMpH+xSB
	 2kd57J8+H5BMmUBhWUjx4KR4iA6saBodByMy705dFwmfEiXVwykmmgspFxxPTVJY3r4ct
	 vOXNs6V2RBfBYmjScm2zXNp2RCYJvAnyRSQudYkqjXPDXXyGPr+4cLuOdwOia2pmkcaD8
	 6aEt4WDpd/BcdzdatvUHHqDooxbOmc/s1PhVLHfhGDhwAYHGUjghk9bNELNAhlwvyHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkdKKanw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCD606A31E;
	Mon, 19 Oct 2026 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkdKKanw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2FF1F000C4;
	Mon, 19 Oct 2026 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442499;
	bh=xMYnA59rJUHE+9uisf/d1TkvwdnPXvlYGjJveBH3dyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JkdKKanw3HqYQAKtt2YJikXnSCvXZIBoWsR3hMCT2baZBlcodp84EYn/1TfLTSMb0
	 JCdG/FlEGSvbgPGsUH7y0d9ZxixOcuUHW3tE3n/Uk4D9wBSozPbjyFh99Den+hk2kx
	 t2Rsu7dYHyeyaKDAmOVwc/qS5nqsCB/eecdrO6/AtzXrdL1r1s5ImmVp7dMAaRMlFk
	 VcBrhXY2xFYLFkXzoza6NsfCZWoVuhWn/gYy25h80rsoyPAPhss6YNFcUbbfXWYKII
	 W8oF1e3JrGNBl7ye4F070iPmNggKcujYrU4qty6xeYDRf2N2rkmce4/xzZqgxsYLFN
	 k5QHj8uc/3NUA==
Message-ID: <sashiko-outbox-178184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] thunderbolt: Call SXFP() on Apple systems with
 Alpine Ridge when suspending
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261019202900.39062-1-fbeltranmillalen@gmail.com>
References: <20261019202900.39062-1-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:41:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] thunderbolt: race between SXFP(0) in tb_suspend_noirq() and xHCI s=
uspend
--

commit 6db71ac20bf35e7effb2cbcdf23c8abfaf21c983
Author: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gmail.com>

thunderbolt: Call SXFP() on Apple systems with Alpine Ridge when suspending

This commit evaluates the SXFP(0) ACPI method under the NHI during
tb_suspend_noirq() on Apple systems with Alpine Ridge controllers to keep
the upstream PCIe link working on resume from suspend to RAM. Before
calling SXFP(0), it clears bit 26 of plug events CS_20 so the router is not
powered off permanently.

> diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
> index 53546bc477a5b..448d50ef1ee90 100644
> --- a/drivers/thunderbolt/acpi.c
> +++ b/drivers/thunderbolt/acpi.c
[ ... ]
> @@ -279,6 +281,50 @@ int tb_acpi_power_off_retimers(struct tb_port *port)
>  	return tb_acpi_retimer_set_power(port, false);
>  }
> =20
> +/**
> + * tb_acpi_apple_force_power() - Call SXFP(0) on Apple systems with Alpi=
ne Ridge
> + * @tb: Domain that is being suspended
> + *
> + * On Apple systems with Alpine Ridge the PCIe link to the upstream port
> + * of the controller does not come up on resume from system sleep if a
> + * device is connected, unless SXFP(0) ("Sx Force Power") under the NHI
> + * is called before entering it. Bit 26 of plug events CS_20 must be
> + * clear when SXFP(0) is called, otherwise the router is turned off and
> + * does not come back on resume.
> + *
> + * Call only when entering system sleep. Does nothing on other systems.
> + */
> +void tb_acpi_apple_force_power(struct tb *tb)
> +{
> +	struct tb_switch *sw =3D tb->root_switch;
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	if (!x86_apple_machine || !tb_switch_is_alpine_ridge(sw))
> +		return;
> +	/*
> +	 * Only when firmware handles system suspend, as in
> +	 * quirk_apple_poweroff_thunderbolt(): the OS does not know how to
> +	 * power the controller back on. pm_suspend_in_progress() excludes
> +	 * hibernation.
> +	 */
> +	if (!pm_suspend_in_progress() || !pm_suspend_via_firmware())
> +		return;
> +
> +	adev =3D ACPI_COMPANION(tb->nhi->dev);
> +	if (!adev || !acpi_has_method(adev->handle, "SXFP"))
> +		return;
> +
> +	if (tb_switch_set_bit26(sw, false))
> +		return;
> +
> +	tb_sw_dbg(sw, "ACPI: calling SXFP\n");
> +	status =3D acpi_execute_simple_method(adev->handle, "SXFP", 0);
> +	if (ACPI_FAILURE(status))
> +		tb_sw_warn(sw, "ACPI: SXFP failed: %s\n",
> +			   acpi_format_exception(status));
> +}

[Severity: High]
Can evaluating SXFP(0) in tb_acpi_apple_force_power() race with the
sibling xHCI controller's noirq suspend path when nothing is connected to
that side of the controller?

When tb_suspend_noirq() calls tb_acpi_apple_force_power(), evaluating
SXFP(0) immediately powers down the sibling Alpine Ridge xHCI PCI function
if no device is attached to that side. Both the NHI and the sibling xHCI
have async_suspend enabled via pci_device_add(), so
dpm_noirq_suspend_devices() runs their pci_pm_suspend_noirq() callbacks
in parallel unless a device_link orders them.

However, tb_apple_add_links() in drivers/thunderbolt/tb.c does not match
Alpine Ridge NHI device IDs:

drivers/thunderbolt/tb.c:tb_apple_add_links() {
	...
	switch (nhi_pdev->device) {
	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
		break;
	default:
		return false;
	}
	...
}

And Apple ACPI tables do not provide usb4-host-interface properties for
tb_acpi_add_links().

If nhi_suspend_noirq() -> tb_domain_suspend_noirq() -> tb_suspend_noirq()
-> tb_acpi_apple_force_power() runs before or concurrently with the
sibling xHCI's pci_pm_suspend_noirq() -> hcd_pci_suspend_noirq():

drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq() {
	...
	pci_save_state(pci_dev);

	if (HCD_DEAD(hcd))
		device_set_wakeup_enable(dev, 0);
	dev_dbg(dev, "wakeup: %d\n", device_may_wakeup(dev));

	retval =3D pci_prepare_to_sleep(pci_dev);
	...
}

pci_save_state() will read 0xffffffff from the powered-off xHCI into
pci_dev->saved_config_space[] and overwrite the saved PCIe capability
state, pci_prepare_to_sleep() will fail with -EIO because the device is
inaccessible, and pci_restore_state() will write 0xffffffff back into the
xHCI configuration space on resume.

Should device links be established between the NHI and the sibling xHCI
(or its upstream bridge) on Alpine Ridge so the xHCI is guaranteed to
complete its noirq suspend before the NHI calls SXFP(0)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019202900.3906=
2-1-fbeltranmillalen@gmail.com?part=3D1
