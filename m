Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53755292D
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089528; cv=none; b=aFyGpvuO2Mdz8TKtuWMoZ9LzoPqABMMJWTqk/2aMVnRSdAtHfxYbUB75NRi4h3V/1V/8RPZfuG7fLHEM/gWGquBBq1or7zTRBzbDzoxQfh4dxsvVvBInPTm3wFtY+24ORTEhIvjfTGYaCGox0S7K8it+pKb7lHpBIReNlgbnx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089528; c=relaxed/simple;
	bh=CQbgXd9izIg1rKz2pm0eDRGXwrKNSoIi/wVxto9Efhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCNQjBKxKHnZig/TzaXqmVBAz8vLxZB7BlpJzqhRq6wtHpMPewvy3+7n3TeqnATduQqTEPKVMtD4OaM7Bhxnn0Iks4wMRh+V82YhZHfhaZrmXHGOlZwvf4xQL+/1itp1bSKQRnaSGRPbR5/aZt7kNot/012WGDwjWSIbk2Q5yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/D9qAno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/D9qAno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2434E1F000FF;
	Tue, 22 Sep 2026 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089526;
	bh=m7/K17GatdvkuhS6ROX1jvB1YWDvwQlBrXbSvy4NTQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/D9qAnopOelr5qM1jUw/pZz/0U70OPcwCYg6VLnjTIa1/3MNrU4/666kAvPHpycr
	 bLKblB0atccf62QEYvNB4fP3oh8LL2mmP7OB1+OTd1Gbc4+cHqPLMs7UEyHsAdu0p+
	 VNTNG9id4/E+jKsfN4Y0zZlYDWAWKIndGgyW4a01lr/W9o9alG8SIojdSFtvX8MALS
	 jU6urgQ7PKzJuRRbhaHu9jtrmK0XXG4S6NUkp/1T0zdThfgYgRpxXI+/0P3c4XKjO9
	 FcJoopew1XVtaeaZK9bJpJs1yNhJKhS+UxxEzgN7cECZ+o8i5NunbCWmrJKyZooGgt
	 S2yjSRMCJmEJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260922144629.586997-8-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-8-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:05:25 +0000
Message-Id: <20260922150526.2434E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: rzg3s-host: misses PCIe link state changes during system susp=
end
- [Medium] pci: rzg3s-host: TOCTOU race in link event handler causes device=
 confusion
--

commit d39725457acf3fbf2e1dca55279894b4bb68e696
Author: John Madieu <john.madieu.xa@bp.renesas.com>
Subject: PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

This commit enables the DL_UpDown interrupt to provide hotplug-like behavior
by re-enumerating the bus on link-state changes. It processes link up and
down events to scan or remove devices accordingly, and updates the probe pa=
th
to tolerate an absent device.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index f4b27a77a89df..1c0353598b599 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1095,6 +1098,89 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
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

[Severity: Medium]
Is there a TOCTOU race here if the link flaps rapidly?

The handler reads the live link state to decide whether to remove or rescan
devices. If the link goes down and comes back up before this threaded handl=
er
runs, it will see DL_DOWN_STS =3D=3D 0 and take the else path.

> +		struct pci_dev *dev, *tmp;
> +
> +		dev_info(host->dev, "PCIe link down, removing devices\n");
> +
> +		pci_lock_rescan_remove();
> +		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
> +						 bus_list)
> +			pci_stop_and_remove_bus_device(dev);
> +		pci_unlock_rescan_remove();
> +	} else {
> +		int ret;
> +
> +		dev_info(host->dev, "PCIe link up, rescanning bus\n");
> +
> +		/*
> +		 * Attempt link speed negotiation now that the link is up.
> +		 * Failure is non-fatal: the device works at the negotiated
> +		 * speed.
> +		 */
> +		ret =3D rzg3s_pcie_set_max_link_speed(host);
> +		if (ret)
> +			dev_info(host->dev, "Failed to set max link speed\n");
> +
> +		pci_host_common_link_train_delay(host->max_link_speed);
> +
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(bus);

Because the DOWN event was missed, old devices are never removed from
bus->devices. Calling pci_rescan_bus() here will skip enumerating them,
leaving the kernel with a stale pci_dev bound to a potentially reset or
swapped device.

Could we tear down existing devices before rescanning, or otherwise account
for missed DOWN events?

> +		pci_unlock_rescan_remove();
> +	}
> +}
[ ... ]
> @@ -1723,8 +1824,14 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
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
Does this miss PCIe link state changes that happen during system suspend?

During system suspend, power is lost and the link state is reset. On
resume, rzg3s_pcie_resume_noirq() restarts the host, which eventually
calls rzg3s_pcie_host_setup().=20

If the link fails to come up, -ENODEV is swallowed here, assuming the
DL_UPDOWN interrupt will recover it. However, the DL_UPDOWN bit won't
trigger an edge interrupt on resume because the controller was just
initialized and isn't transitioning.=20

If a device was unplugged or plugged in during sleep, the PCI core is
never notified, potentially leading to device timeouts or state
corruption. Should we manually check the link state and synchronize the
PCI core after unmasking the interrupt in rzg3s_pcie_resume_noirq()?

>  	}
> =20
>  	ret =3D rzg3s_pcie_set_max_link_speed(host);

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the read-modify-write on W1C
interrupt registers drop concurrent interrupts?

In rzg3s_pcie_msi_irq() and rzg3s_pcie_intx_irq_ack(), the driver uses
rzg3s_pcie_update_bits() to acknowledge specific interrupts:

	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
			       RZG3S_PCI_PINTRCVIS_MSI,
			       RZG3S_PCI_PINTRCVIS_MSI);

Registers like RZG3S_PCI_PINTRCVIS are W1C (Write 1 to Clear). Reading
yields a 1 for every currently pending interrupt, and writing that value
back writes a 1 to all those bits. Any concurrent interrupts that were
pending at the time of the read will be silently cleared and lost,
resulting in device timeouts.

[Severity: Medium]
This is a pre-existing issue, but is the MSI hardware configured
unconditionally even if CONFIG_PCI_MSI is disabled?

During device resume, rzg3s_pcie_host_start() passes
rzg3s_pcie_msi_hw_setup() as the initialization callback:

	ret =3D rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
				    rzg3s_pcie_msi_hw_teardown);

If CONFIG_PCI_MSI is disabled, MSI software structures (like
msi->window_base) are never initialized and remain 0. This pushes
uninitialized zero values to hardware registers and routes MSI interrupts
to physical address 0. Any DMA write to address 0 will trigger a
spurious hardware event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D7
