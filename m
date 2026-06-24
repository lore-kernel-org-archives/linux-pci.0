Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD1388E7A;
	Wed, 24 Jun 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301210; cv=none; b=IAs0JBRI45wXVClV7bVGAlNUGQX0mvR8cWad6La97gZRvf8gAyzUEFzU/deBkqyxRlb1YMDcPj44uh3rhAhiLgNRa0HZco9mGB16Bi3k8rQbcCh1jr3snq/uEm4sg7Iww/vVYildkJvk5C+xSHwoKgvnH+MoZjJPQyS+RHTvDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301210; c=relaxed/simple;
	bh=V2a+o1uLgtmsaBowYmt4kcWoLdoUhS2WJcofgBZxOME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JDuMWYuTZgwyxLZuc3Szu66hgWCO5ve1pW6eTLJaz0WVBmXJMiaKwzAoqzcnTBIUBJpMMejm028EmawvGqVqiUfSFMt2Wo7cgMkFONdfa40ilJv/A8kcx92nDE75VTKGy/xTcmFwQHz0dSrEBBt2FpEH3FsAiAnHTHVsn7qIACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNLAhUJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNLAhUJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7A51F00A3A;
	Wed, 24 Jun 2026 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301208;
	bh=joCNdQoYZzPJqf7GcFKRiheio82RTDUY1TudkMB5Zdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNLAhUJ/2U1x9r8MUHOfBVYUFHCLlodwIbqgJa6W/aRfGZtuSg+YAyJzT6mFpuNRI
	 kAIFCtu6Vt82t/1wNTwU3BS0lF4ic+lvgJXtpbYIhWcRcLyalO89b7Anm55dSJ4cMm
	 4FoH1QEYeEbFdaJs3d8CnfU2zWHcEplt1hlSVm+AMfYqBLjbiPOE+E0PhZaBrHxC9U
	 KvQcmK8xdus/NYukoGWlmmTvnMgzedt+5HOQXiJxJquG4zNVcRnvwMrerk7YR7thzx
	 YJk0+J4ODz6uEwajHu4xvq2c5+ozM2b30R34WPOedc0kLgAhBtPfccpzXCgw4y+Rhn
	 t1JHhl1ZTCQBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11] PCI: Add support for PCIe WAKE# interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260624-wakeirq_support-v11-1-120fbfaebe59@oss.qualcomm.com>
References: <20260624-wakeirq_support-v11-1-120fbfaebe59@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:40:07 +0000
Message-Id: <20260624114008.7F7A51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Hot-removing an endpoint sharing a WAKE# GPIO breaks wakeup for al=
l remaining endpoints on that line.
- [High] pci_remove_of_wake_gpio() unconditionally clears the device's wake=
up configuration and wake IRQ, even if it never acquired the WAKE# GPIO.
- [High] WAKE# GPIO configuration forces device wakeup to be enabled by def=
ault, violating PCI PM policy.
- [Medium] Calling platform_pci_configure_wake() after device_add() creates=
 a race condition that overwrites driver or userspace wakeup configuration.
- [Medium] Hardcoded IRQ_TYPE_LEVEL_LOW ignores Device Tree GPIO polarity f=
or the WAKE# interrupt.
- [Medium] WAKE# GPIO configuration permanently fails if the GPIO provider =
returns -EPROBE_DEFER.
--

commit 9e1cd6307066585f1f51b9e7de95ae7950936ba0
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
PCI: Add support for PCIe WAKE# interrupt

According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
two link wakeup mechanisms are defined: Beacon and WAKE#. This change adds
support for the WAKE# mechanism in the PCI core.

Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@=
oss.qualcomm.com/
Link: https://github.com/devicetree-org/dt-schema/pull/170

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 8b18c4ba845cf..0f5effe1d7026 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c

[ ... ]

> +	ret =3D dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to set WAKE# IRQ: %d\n", ret);
> +		return;
> +	}
> +
> +	ret =3D irq_set_irq_type(wake_irq, IRQ_TYPE_LEVEL_LOW);

[Severity: Medium]
Does hardcoding IRQ_TYPE_LEVEL_LOW here override the logical polarity
specified in the Device Tree?

If the WAKE# GPIO is specified via the wake-gpios property with flags like
GPIO_ACTIVE_HIGH, this explicit type setting might ignore those flags and
fail to trigger on platforms with an inverted physical signal.

> +	if (ret < 0) {
> +		dev_pm_clear_wake_irq(&pdev->dev);
> +		pci_err(pdev, "Failed to set irq_type: %d\n", ret);
> +		return;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);

[Severity: High]
Could this forcefully enable wakeup by default and violate standard PCI PM
policy?

Calling device_init_wakeup() with true marks the device as wakeup capable
and also sets dev->power.should_wakeup =3D true. The standard PCI core
behavior usually marks devices as wakeup capable but leaves enablement to
userspace opt-in.

> +}
> +
> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn =3D pci_device_to_OF_node(dev);
> +	struct gpio_desc *gpio;
> +
> +	if (!dn)
> +		return;
> +	/*
> +	 * fwnode_gpiod_get() may fail with -EBUSY (e.g. shared WAKE#), but the
> +	 * actual WAKE# trigger from the device would still work and the host
> +	 * controller driver will enable power to the topology.
> +	 *
> +	 * -EPROBE_DEFER cannot be propagated here since pci_device_add() has no
> +	 *  retry mechanism.
> +	 */
> +	gpio =3D fwnode_gpiod_get(of_fwnode_handle(dn), "wake", GPIOD_IN, NULL);
> +	if (!IS_ERR(gpio)) {

[Severity: Medium]
Since pci_device_add() has no retry mechanism, does swallowing -EPROBE_DEFER
here mean WAKE# functionality will permanently fail if the GPIO controller
providing the WAKE# line hasn't probed yet?

[Severity: High]
If multiple endpoints share a WAKE# GPIO, only the first device acquires
it while the rest fail with -EBUSY. Can this break wakeup capabilities
for all remaining endpoints if the first device is later hot-removed?

When the first device is removed, it frees the shared GPIO via
pci_remove_of_wake_gpio(), leaving the remaining active endpoints without
an associated wake IRQ.

> +		dev->wake =3D gpio;
> +		pci_configure_wake_irq(dev, gpio);
> +	}
> +}
> +
> +void pci_remove_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn =3D pci_device_to_OF_node(dev);
> +
> +	if (!dn)
> +		return;
> +
> +	device_init_wakeup(&dev->dev, false);
> +	dev_pm_clear_wake_irq(&dev->dev);
> +	gpiod_put(dev->wake);
> +	dev->wake =3D NULL;
> +}

[Severity: High]
Should this cleanup block be guarded by a check for dev->wake?

As it stands, if a PCI device with an OF node failed to acquire the GPIO
(e.g., it returned -EBUSY) or didn't have a wake property, this will still
unconditionally clear its PME wakeup capability and detach any dedicated
wake IRQ the driver might have configured itself.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc0..143b0bd35b3c9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

> @@ -2775,6 +2775,8 @@ void pci_device_add(struct pci_dev *dev, struct pci=
_bus *bus)
>  	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
>  	pci_tsm_init(dev);
> =20
> +	platform_pci_configure_wake(dev);

[Severity: Medium]
Does calling platform_pci_configure_wake() after device_add() create a race
condition?

By the time this is called, the device is already visible in sysfs and
uevents have fired. Local userspace tools configuring power/wakeup or
asynchronous driver probes could have their configurations silently
overwritten by the subsequent device_init_wakeup() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-wakeirq_su=
pport-v11-1-120fbfaebe59@oss.qualcomm.com?part=3D1
