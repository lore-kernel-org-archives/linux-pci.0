Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B1264A97;
	Tue, 23 Jun 2026 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194468; cv=none; b=a0GmlERlX7xzncVDPYa3XJ/eotLNCsoboXJj+hdYg9Pb7GCWGiVbAvqiDVfQh5mDofypyCM4QO95CpuYc37R1hsxjC4OcbHFSsQQtmi4Rn3BhWEjmzUIT/Qfaxg1l99zXSgCMLvCsSQPs/SRRxozkkU2vX2iK7HTpHkAurXAhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194468; c=relaxed/simple;
	bh=PsVFpsgoGjBKQhRQRYOoMkpL8av662X0pNdwWXP53m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8TPo7YyX9P130vHNG1cNtxZNtN53rgSVlGnxgKKvoVhtW4g2aLIAqU+b++A4T+GufogqOesRM6CyRX98KXyKUrZqbSeZ0ucbD5QJVEpjeJI6rlnDlTOAFYlQcG+zFbHR44C1dbQcEbWCBpdzB4+Zf+caHGw2jBtjDERMb/I7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkgEEnBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkgEEnBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3DC1F000E9;
	Tue, 23 Jun 2026 06:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782194467;
	bh=t+ndf8nzelDbTnz45rutnNT56AmPFTnBuARSmzWV3Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jkgEEnBOJR5laz+6Mso+DrSNtV16IKVrjS756wp8ueoN04qxs5To78/gn88s9FWmg
	 4Kp+sHk9Lgu4YVunIzZIF0NQYWv3NZDAoxTduXnXTpFjbP61XwS+H6VXjpNFoQqTjn
	 lP7mQr+5Z7+On9OS7ESb54ksLJsWN7z3mo07+Y6XHJ2c9ZbtQ7eRw3UfBI/vEHf9kR
	 0BvAaLb7kfgUrsCafqh3JNalZD1WAnDhB2p8AG8VBOje3U/ZgtCZo5vWbJti9ajC44
	 qNBvzH4ksFbqW4lJdJ+ThLhLddVYqpelxOjd46uA63EREpFIJ6RUaWiRRadzoNNgBn
	 ACTJ3dTK1dLqw==
Date: Tue, 23 Jun 2026 08:00:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: sashiko@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/portdrv: Allow probing even without child services
Message-ID: <2amkuriysutyocs2cvokiwfyai2latvjphxkkxdeu2nkwlqzta@ysyp6yce45xc>
References: <20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
 <20260508233022.D20A8C2BCB0@smtp.kernel.org>
 <af574zaysKnXjx15@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af574zaysKnXjx15@google.com>

On Fri, May 08, 2026 at 05:12:19PM -0700, Brian Norris wrote:
> Hi sashiko-bot and Bjorn,
> 
> On Fri, May 08, 2026 at 11:30:22PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Moving `pci_set_master()` after child device registration causes child drivers to probe with Bus Mastering disabled, risking permanently lost MSI/MSI-X interrupts.
> > --
> > 
> > commit 9b851bf8faf271ab0b2daad51bfd51f89a1e87d4
> > Author: Brian Norris <briannorris@chromium.org>
> > 
> > PCI/portdrv: Allow probing even without child services
> > 
> > This commit modifies the PCIe port driver to allow probe to succeed even
> > if no child services are available. This ensures the port can still be
> > configured for runtime PM and low power modes on systems that only have
> > certain port services available or lack legacy INTx interrupts.
> > 
> > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > 
> > > --- a/drivers/pci/pcie/portdrv.c
> > > +++ b/drivers/pci/pcie/portdrv.c
> > > @@ -343,7 +343,6 @@ static int pcie_port_device_register(struct pci_dev *dev)
> > >  	if (!capabilities)
> > >  		return 0;
> > >  
> > > -	pci_set_master(dev);
> > >  	/*
> > >  	 * Initialize service irqs. Don't use service devices that
> > >  	 * require interrupts if there is no way to generate them.
> > 
> > [ ... ]
> > 
> > >  	/* Allocate child services if any */
> > > -	status = -ENODEV;
> > > -	nr_service = 0;
> > >  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> > >  		int service = 1 << i;
> > >  		if (!(capabilities & service))
> > >  			continue;
> > > -		if (!pcie_device_init(dev, service, irqs[i]))
> > > -			nr_service++;
> > > +		pcie_device_init(dev, service, irqs[i]);
> > >  	}
> > > -	if (!nr_service)
> > > -		goto error_cleanup_irqs;
> > >  
> > > -	return 0;
> > > +	pci_set_master(dev);
> > 
> > Does moving pci_set_master() after the pcie_device_init() loop risk dropping
> > MSI/MSI-X interrupts during child driver probes?
> > 
> > The pcie_device_init() function calls device_register(), which synchronously
> > invokes the probe routines of child service drivers like pciehp or aer.
> > During probe, these child drivers configure the hardware and enable their
> > interrupts.
> > 
> > Because PCIe MSI and MSI-X interrupts are memory write transactions, they
> > require the Bus Master Enable (BME) bit to be set in the PCI Command Register.
> > 
> > If a hardware event occurs immediately after the child driver unmasks the
> > interrupt but before pci_set_master(dev) is called, will the hardware attempt
> > to send an MSI and drop the memory write because BME is 0?
> > 
> > Since PCIe interrupts are edge-triggered messages, could these dropped
> > interrupts result in permanently missed hotplug events or cause hardware error
> > handling regressions?
> 
> Ha, that's funny. It's all a great question I think, and that's pretty
> much what I asked Bjorn here when he suggested moving this:
> 
> https://lore.kernel.org/all/aZfIfn9viQRj4uy4@google.com/
> 
> He seems to think it's not a problem:
> 
> https://lore.kernel.org/all/20260220164046.GA3528004@bhelgaas/
> 
> but I'm frankly not very convinced. I think it's perfectly possible that
> a child service will try to enable MSI, the device will try to write,
> and those writes will be dropped, producing a missing interrupt.
> 
> Bjorn, what do you think? Personally, I'd go back to something closer to
> v2, where we enable mastering before initializing children. But maybe
> you know better than this bot and me.
> 
> Frankly, this is all a distraction from the actual goal of my patch, so
> I'd rather not make arbitrary changes to the ordering if we're not sure.
> 

I do agree that this is a valid concern. Quoting Bjorn's reply in v2
https://lore.kernel.org/linux-pci/20260220164046.GA3528004@bhelgaas/:

"Setting MSI Enable allows the device to use MSI when it asserts an
interrupt, but my understanding is that it doesn't enable the
interrupt source itself.  The MSI Capability is an interrupt
mechanism, not itself a source -- there's no interrupt handler at this
point."

This seems not to be true because, pcie_device_init() can invoke the service
driver's probe() like aer_probe() and the probe callback can register the IRQ
handler for the service IRQs and enable the MSIs. So once the IRQ handler is
registered and relevant MSIs are enabled, then we ought to service the MSIs from
the endpoint. But that won't happen because of BME not getting set at this
point and leading to those MSIs getting lost.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
