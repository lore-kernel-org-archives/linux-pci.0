Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CC489886
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940321; cv=none; b=QIy6z1iYSH+ZxvaYEGMzyJ/YcTK0Wi7+Uu6QMqnoV5xD0xnEZp7GSIGqqWwxaPDKdTOwVGSKcVC006mPrc2Zd6MJI92ejCCFcvQKQp3xH3DXtPR1BtXknjIX8OwnMwxpzUu5uXkpeEIX/DBFjPhZFF8F/rRF2wpU0ItYI4jNZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940321; c=relaxed/simple;
	bh=YtaewfYGIjS9QSXUnXB9H7qFrrKUGzUCyWhBsB+H0WE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5vrUBy1mjXch3DfLoC7jDm2cBiO9CyCHVD/PEZh/7kjq1b8qHk04FTRJZRkLg00QI6heQiMxkBNdfNQxkVHAWU/KwYE7I2A0CW84TGkIKA8DOWtcPRGizBOdpd/nLqIjzSczDpb5gijguWlxli6WTbtbl2p3J/N+5WShgeRt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2pJhL4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2pJhL4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6082F1F00893;
	Fri,  2 Oct 2026 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940319;
	bh=nhoPYqn+VCzD75IrE+1ejxw7Q4DQsn9QigOsPlbx0Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2pJhL4fYiq8NilBXA2QcRAjthk6+R9y+d69EeFbLtqJYBxMuWlRXthzPWdAMxcZQ
	 H/XGqiWNEFHP0Gbq2w1QruivWuW4MqXaIiuuCwetsyKUqm7RDyUyJaRguWfBJwYdb4
	 hYrTJJNifYYTcKAki20cSsABCMI5J6+Qzm6UG8h1eBaPXbnpSBJCeUjK/dOjZb9+qG
	 wdU2B0OQGuk8E3toGH2UPNEjYt1EXs8xum3TSkdDFyaNXoX9efuHgCJyDDf8ioxH06
	 +mHrr4lg8ogthOBySCPi58L6bwOfBAafzNOxiQ7V3SULtZisb+vvliYWeBuwcakvk0
	 XzWFmUYuzjCIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261002110935.2004349-9-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-9-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:25:19 +0000
Message-Id: <20261002112519.6082F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] PCI: deadlock during hibernation due to unhandled PM notifiers
- [High] PCI: probe succeeds with uninitialized controller on DT error
- [High] PCI: NULL pointer dereference if event IRQ fires before root bus c=
reation
- [Medium] PCI: ghost devices left on bus if link bounces during suspend
--

commit e916ae87086b955078f323f09316792067184bfe
Author: John Madieu <john.madieu.xa@bp.renesas.com>
Subject: PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

This commit adds support for reacting to link-state changes by handling
the DL_UpDown signal on RZ/G3 and RZ/V2 PCIe controllers. It introduces
a link event interrupt, hotplug-like logic, and PM notifiers to serialize
with device suspend/resume.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 3b62b1be5b2a1..78e783928b9dc 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1095,6 +1103,98 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
>  	return ret;
>  }
> =20
> +static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host)
> +{
> +	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host);
> +	struct pci_bus *bus =3D bridge->bus;
> +	u32 val;
> +
> +	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
> +	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
> +		struct pci_dev *dev, *tmp;
> +
> +		dev_info(host->dev, "PCIe link down, removing devices\n");
> +
> +		pci_lock_rescan_remove();
> +		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,

[Severity: High]
The event IRQ is requested and enabled in rzg3s_pcie_host_setup() before
bridge->bus is allocated by pci_host_probe().

If the hardware generates a spurious interrupt during this narrow window,
bridge->bus could be NULL when this handler runs.

Will this dereference a NULL pointer?

> +						 bus_list)
> +			pci_stop_and_remove_bus_device(dev);
> +		pci_unlock_rescan_remove();
> +	} else {
> +		struct pci_bus *child;
> +		int ret;
> +
> +		dev_info(host->dev, "PCIe link up, rescanning bus\n");

[Severity: Medium]
On resume, the PM notifier wakes the IRQ thread.

If the link is currently up, it seems this branch is taken and rescans the =
bus
without removing the old devices that might have been hot-swapped while the
link was down.

Could this leave ghost devices on the bus if the link goes down and comes b=
ack
up while the system is suspended?

[ ... ]
> @@ -1723,8 +1838,14 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
> =20
>  	ret =3D rzg3s_pcie_host_init(host);
>  	if (ret) {
> -		dev_err_probe(dev, ret, "Failed to initialize the HW!\n");
> -		goto teardown_irqdomain;
> +		if (ret !=3D -ENODEV) {
> +			dev_err_probe(dev, ret,
> +				      "Failed to initialize the HW!\n");
> +			goto teardown_irqdomain;
> +		}
> +
> +		/* Link is down: hotplug via DL_UpDown will recover. */
> +		return 0;

[Severity: High]
If a mandatory resource is missing, such as resource_list_first_type()
returning NULL in rzg3s_pcie_config_init(), it returns -ENODEV.

This would be caught here as a safe link-down state and return success,
potentially leaving the controller uninitialized.

Does this pattern mask genuine configuration errors?

[ ... ]
> @@ -1905,6 +2026,31 @@ static void rzv2h_pcie_release_lanes(void *data)
>  	rzv2h_num_total_lanes -=3D host->num_lanes;
>  }
> =20
> +static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	struct rzg3s_pcie_host *host =3D container_of(nb, struct rzg3s_pcie_hos=
t,
> +						    pm_nb);
> +
> +	switch (action) {
> +	case PM_SUSPEND_PREPARE:
> +		/* Disable link up/down interrupts. */
> +		disable_irq(host->event_irq);
> +		break;

[Severity: High]
The switch statement only handles PM_SUSPEND_PREPARE and PM_POST_SUSPEND,
completely omitting PM_HIBERNATION_PREPARE and PM_RESTORE_PREPARE.

If a link event occurs during hibernation transitions, the threaded interru=
pt
could attempt to acquire the same lock the PM core is holding.

Can this missing hibernation support open a window for a deadlock?

> +
> +	case PM_POST_SUSPEND:
> +		/* Enable link up/down interrupts and force link re-scan. */
> +		writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
> +			       host->axi + RZG3S_PCI_PEIE0);
> +		WRITE_ONCE(host->link_rescan, true);
> +		enable_irq(host->event_irq);
> +		irq_wake_thread(host->event_irq, host);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D8
