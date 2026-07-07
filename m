Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5C3E0C5C;
	Tue,  7 Jul 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424810; cv=none; b=kfOcYxfHzcSm/1ev7t9tfslg+6QZs9l72JZ6ry7KbsG0+2YTtOOx1Lnl/adCUg3sjvSoEXOYAng+Fy6zUV1dKClEc/QREjsQ/i0n+Bo+Lp/oCbBq64pHoZMwjb0T/yOpAKG03VJQIKOPGnPsYh2Jgkvn1jCLgiej3QmB0jJcPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424810; c=relaxed/simple;
	bh=VzVtc5g3QcquYUQMR5pAoFYAIpomHpJ1yphYoXyI/4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HiTh6fPQDyb6GO/juuBNvCE2CYiFqR9dEsl7rVTIteteRGz7SOtmPNv+BM5ApN3FnieK3WD0zKCIIbnyqXrbQchDyyREOBX0oys+RWz5l7yksVaQGTPb2jMnX7Uf6DxmmuJiadGEv36T1Zc9VBDHCVhkyhp+s8iIary/EoqSiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0KP2JH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0KP2JH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A091F000E9;
	Tue,  7 Jul 2026 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783424808;
	bh=geI2G7Fz6/HzFMjDFhj2ueCOBJMqwY/reUO1vVILSBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0KP2JH6gamCY1Sa/Q6Gozf56bPHwJQMUFXRKXTSSf5UJZsdWq2mc19TPGi+K/h+4
	 T3d3YfVlemnxsq3K3ybIUhbPss+zSyPqUgZrz5sCPxBTdceAsbgVpV0AxKPWQAO7+1
	 J9ugHt8vyHQBoU4ipyuQPvaMEfdC2NHnIa2d0zRsAhNhAllT22KfXGLD3DaEZ+AwSD
	 cNo0V61+zTb4OWibEbd8YqOyKbMd+vNUK3E/4exXoXq4WJyk+FoOuJfydGHmwZYPpQ
	 XreS9E0rmdmQxm+tR4LVkWSP2+7faNu29Pk8BbHYvvTQDSgnQrRcNFMZCoayJ7wHPd
	 ynqpiFmCeJixQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12] PCI: Add support for PCIe WAKE# interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com>
References: <20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 11:46:47 +0000
Message-Id: <20260707114648.60A091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Exclusive allocation of a shared WAKE# GPIO breaks wakeup capabili=
ty for remaining devices if the first device is hot-removed.
- [High] The IRQ trigger type is configured after requesting the wake IRQ, =
causing the request to fail on irqchips requiring a trigger type.
- [High] Incorrect resource lifecycle check in `pci_remove_of_wake_gpio()` =
causes GPIO and IRQ leaks if the OF node is detached.
- [Medium] Unconditional system wakeup enablement bypasses standard PCI PM =
policy.
- [Medium] Unchecked return value of `device_init_wakeup()` can leave the d=
evice in a half-configured state.
--

--- Patch [1]: [PATCH v12] PCI: Add support for PCIe WAKE# interrupt ---
commit 788f29e12a6c04e2d11d2db4e00c40903e8d0022
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: PCI: Add support for PCIe WAKE# interrupt

This commit adds support for the PCIe WAKE# mechanism in the PCI core.
It searches for a WAKE# GPIO described in the device tree for the endpoint
or bridge, registers a dedicated wake IRQ, and handles waking the device
from low power states to an active state.

Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@=
oss.qualcomm.com/
Link: https://github.com/devicetree-org/dt-schema/pull/170

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 8b18c4ba845cf..5df6b11cdf9f9 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c

[ ... ]

> @@ -586,6 +588,82 @@ int of_irq_parse_and_map_pci(const struct pci_dev *d=
ev, u8 slot, u8 pin)
>  	return irq_create_of_mapping(&oirq);
>  }
>  EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
> +
> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_des=
c *wake)
> +{
> +	int ret, wake_irq, irq_type;
> +
> +	wake_irq =3D gpiod_to_irq(wake);
> +	if (wake_irq < 0) {
> +		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
> +		return;
> +	}
> +

[ ... ]

> +	ret =3D dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to set WAKE# IRQ: %d\n", ret);
> +		return;
> +	}
> +
> +	irq_type =3D gpiod_is_active_low(wake) ? IRQ_TYPE_LEVEL_LOW :
> +						IRQ_TYPE_LEVEL_HIGH;
> +	ret =3D irq_set_irq_type(wake_irq, irq_type);

[Severity: High]
Does this attempt to configure the IRQ trigger type too late?

If the irqchip requires a valid trigger type during IRQ allocation,
calling dev_pm_set_dedicated_wake_irq() before irq_set_irq_type() will fail.
This is because dev_pm_set_dedicated_wake_irq() calls request_threaded_irq()
without IRQF_TRIGGER_MASK flags, resulting in an -EINVAL return.

Should the trigger type be configured before requesting the wake IRQ?

> +	if (ret < 0) {
> +		dev_pm_clear_wake_irq(&pdev->dev);
> +		pci_err(pdev, "Failed to set irq_type: %d\n", ret);
> +		return;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);

[Severity: Medium]
Does unconditionally enabling system wakeup here bypass standard PCI power
management policy?

Standard PCI policy, as seen in pci_pm_init(), makes devices wakeup-capable
but leaves the enablement decision to user-space. Setting this to true
unconditionally might lead to unexpected battery drain or spurious wakeups.

[Severity: Medium]
What happens if device_init_wakeup() fails?

If it returns an error such as -ENOMEM when allocating the wakeup source,
dev->power.should_wakeup remains false. This leaves the device with a
dedicated wake IRQ requested but system wakeup disabled.

The PM core will then never enable the wake IRQ via
dev_pm_enable_wake_irq_check() during system suspend.

Should this check the return value and unroll the wake IRQ registration on
failure?

> +}
> +
> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn =3D pci_device_to_OF_node(dev);
> +	struct gpio_desc *gpio;
> +
> +	if (!dn && !dev->wake)
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

[Severity: High]
How does this exclusive GPIO acquisition handle hot-removal of shared wake
lines?

If multiple PCI devices share a WAKE# GPIO in the device tree,
fwnode_gpiod_get() grants exclusive access to the first probed device.
Subsequent devices receive -EBUSY and skip wake IRQ setup.

If the first device is later hot-removed or unbound,
pci_remove_of_wake_gpio() frees the GPIO and deregisters the wake IRQ.

This leaves the remaining active devices with no wake IRQ registered and
no way to acquire it, breaking their ability to wake the system.

Can this be handled to avoid permanent loss of wakeup capability for the
remaining devices?

> +	if (!IS_ERR(gpio)) {
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

[Severity: High]
Does checking the OF node pointer here cause resource leaks if the node
is detached?

During device teardown, pci_stop_dev() executes before pci_destroy_dev().
If the device's OF node was dynamically created (common in PCI hotplug with
device tree overlays), pci_stop_dev() calls of_pci_remove_node(), which
clears dev->dev.of_node.

When pci_destroy_dev() later calls pci_remove_of_wake_gpio(), this early
return will bypass the gpiod_put() and dev_pm_clear_wake_irq() calls because
the OF node was already cleared.

Should this check for the presence of the resource itself via
if (!dev->wake) instead of the OF node pointer?

> +
> +	device_init_wakeup(&dev->dev, false);
> +	dev_pm_clear_wake_irq(&dev->dev);
> +	gpiod_put(dev->wake);
> +	dev->wake =3D NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-wakeirq_su=
pport-v12-1-b4453f5bcc97@oss.qualcomm.com?part=3D1
