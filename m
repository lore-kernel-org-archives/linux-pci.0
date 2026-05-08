Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA22DA75C
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283023; cv=none; b=pMOHvRjlr8/iQ9+jh0lDud/ABn1QgtQjCnhE2C14FviIMAKIv63XV++LmOET5LlB+BRxS3r2lUFDAd65ggB7yhncMKk/eMLiebnspdMSZ3C9EqSg8d2vdf6e7Dcls4Hs9AQpknrG/bcHtQF5jhV+Q9Sf7l/erWQ3Y9uLxHPr/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283023; c=relaxed/simple;
	bh=mFt9oDbTTtBb8Y3wfB6C3gFl1lYyF7MsvjPeoede2jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IOCiY9N9p5U3hQBoxE93eKw/RLgD60cZhiySCJgaHv2wScESrNYLXn/c9kPCLQoo69+ErPHcrxSRiec+pAP7yIligGjUdFvAEXjtjL546VzeJFz1wz3CO50Ekf5dCfncfFmxUO55F1gnh/CW30S5462GYaqeOxfKxxw5hvDyLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEi9LIvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEi9LIvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A8C2BCB0;
	Fri,  8 May 2026 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778283023;
	bh=mFt9oDbTTtBb8Y3wfB6C3gFl1lYyF7MsvjPeoede2jQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NEi9LIvAWuED5+HoH2tuOQkKznC2rSrySdajAyH81ZHuCtJySp/ayPgXPhyMgnLZo
	 qZOvOhRhGLO9msnPW1nzQ+5hvAIXkuIEAaKccpZhaQbxP8ebnalWFUq6Wog0MxvkMm
	 KrRpm/GTQEfNS/NYbWzLS1/1nn+avyj3EA4FCDotJOSMfAyuznwTTMnCe9Ss2k72Iz
	 YqBkov3udZzBR6gyanN3hMfmTdNYSwgN290xe+/cQ7nqEO+vxz64ZTLiBoT5Iqr5IB
	 PlnC11Xx8kSZcjvsVx1OkUzOHxt5NBpyWh2MVkpujKZDYxSxiUv3ZiMR/IB9HZMloy
	 HeYUbDd6hw5Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/portdrv: Allow probing even without child
 services
Reply-To: sashiko@lists.linux.dev
To: "Brian Norris" <briannorris@chromium.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
References: <20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 23:30:22 +0000
Message-Id: <20260508233022.D20A8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving `pci_set_master()` after child device registration causes c=
hild drivers to probe with Bus Mastering disabled, risking permanently lost=
 MSI/MSI-X interrupts.
--

commit 9b851bf8faf271ab0b2daad51bfd51f89a1e87d4
Author: Brian Norris <briannorris@chromium.org>

PCI/portdrv: Allow probing even without child services

This commit modifies the PCIe port driver to allow probe to succeed even
if no child services are available. This ensures the port can still be
configured for runtime PM and low power modes on systems that only have
certain port services available or lack legacy INTx interrupts.

Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdw=
b33xkcdwk@76vnrx45fsfd/

> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -343,7 +343,6 @@ static int pcie_port_device_register(struct pci_dev *=
dev)
>  	if (!capabilities)
>  		return 0;
> =20
> -	pci_set_master(dev);
>  	/*
>  	 * Initialize service irqs. Don't use service devices that
>  	 * require interrupts if there is no way to generate them.

[ ... ]

>  	/* Allocate child services if any */
> -	status =3D -ENODEV;
> -	nr_service =3D 0;
>  	for (i =3D 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
>  		int service =3D 1 << i;
>  		if (!(capabilities & service))
>  			continue;
> -		if (!pcie_device_init(dev, service, irqs[i]))
> -			nr_service++;
> +		pcie_device_init(dev, service, irqs[i]);
>  	}
> -	if (!nr_service)
> -		goto error_cleanup_irqs;
> =20
> -	return 0;
> +	pci_set_master(dev);

Does moving pci_set_master() after the pcie_device_init() loop risk dropping
MSI/MSI-X interrupts during child driver probes?

The pcie_device_init() function calls device_register(), which synchronously
invokes the probe routines of child service drivers like pciehp or aer.
During probe, these child drivers configure the hardware and enable their
interrupts.

Because PCIe MSI and MSI-X interrupts are memory write transactions, they
require the Bus Master Enable (BME) bit to be set in the PCI Command Regist=
er.

If a hardware event occurs immediately after the child driver unmasks the
interrupt but before pci_set_master(dev) is called, will the hardware attem=
pt
to send an MSI and drop the memory write because BME is 0?

Since PCIe interrupts are edge-triggered messages, could these dropped
interrupts result in permanently missed hotplug events or cause hardware er=
ror
handling regressions?

> -error_cleanup_irqs:
> -	pci_free_irq_vectors(dev);
> -error_disable:
> -	pci_disable_device(dev);
> -	return status;
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508133629.v3.1=
.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid?part=3D1
