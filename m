Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A135C6B4;
	Wed, 22 Jul 2026 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753374; cv=none; b=oHn0tnG4lciMeDoH/3FOyaazEf8Gvx74ug7P6frWWfP6xB5N9EWSPpAVLBXD0iaDU8ZvYOtnQVTlbrPRY+h3Ht7uG6+CwBXOiR2QLNLqfFHSdlOBq9a0Vp//q9JEzJZa2CjiCDmGJnQMdmcP2+sAqf0JMESk7qtGxMGj9elq8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753374; c=relaxed/simple;
	bh=KWgriz5QD02WosL/s5QlZ8sWm9x8jJ5uVfYTMQ0UNp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fcsG532DlyG8TGRzpWsRBpNx2eqSYKsDJ+OqNtHhZZc7HVHuoJJv7PqU441tzkDi76RA6yXJKPFj4+8PU5AkNCyl7oTzAMSCSewparug+Wukm9zIXRnRd3H7Ew6HXTNCMM6sw2SA845HTVVcfMlA1bxjvslnVBjtgtP8uBiHzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRXzSsVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRXzSsVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2F1F000E9;
	Wed, 22 Jul 2026 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753372;
	bh=z1Px7wlSMvAtpTuhDzmSdxQ/s0+Uaq2GwqNMZQggC8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QRXzSsVT5SjOc1MIxxlOGfscK9Zh0nMnPXdjwvIEjOncRNbT0BLhKgvDIMUjo7ho7
	 STTBT5Skv6+2LAMXvNvVt40TyOH2ju2naUz9oj35nd8JSbDsePl8U8/shOcoMUN/bb
	 X4/V29aNO66JiK9swV+v1lAQZdZ0ZmR3IuhFBj8v2xPToycQ415ZeMys7B24cBftPW
	 jkA580SrQaCa/1kPCWxQbfBo1mM6Z+l9v/QSRsrnDmGO4ojb+nc+aI0TArXInG7kEj
	 tU9vfvQyAJ3K/vsKD4dTiSfv/Ba6n7dKK490pnfIPUHQLOEK9mkMGlaIh094ieYAoU
	 4iO6Mmuzgj1Eg==
Date: Wed, 22 Jul 2026 15:49:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <20260722204931.GA779078@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al68lFtbq_Q4RCL2@google.com>

On Mon, Jul 20, 2026 at 05:25:56PM -0700, Brian Norris wrote:
> On Mon, Jul 20, 2026 at 03:44:19PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jul 17, 2026 at 10:26:53AM +0200, Lukas Wunner wrote:
> > > On Thu, Jul 16, 2026 at 12:26:41PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > > > > The PCIe port driver fails to probe if it finds no child services,
> > > > > presumably under the assumption that the driver is not useful in that
> > > > > case. However, the driver *can* still be useful for power management
> > > > > support -- namely, it still configures the port for runtime PM / D3,
> > > > > which may be important for allowing a bridge to enter low power modes.
> > > > > 
> > > > > Thus, allow probe to succeed even if no IRQs and no child services are
> > > > > available. This also mirrors existing behavior for ports that have no
> > > > > PCIe capabilities, where we'd also probe successfully.
> > > > > 
> > > > > This change is a bit more important after commit f5cd8a929c82 ("PCI:
> > > > > dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> > > > > controller"), because it's common for some DWC-based systems to:
> > > > > 
> > > > > 1. have only have the "aer" and "pcie_pme" port services available and
> > > > > 2. not define legacy INTx interrupts properly in their device tree.
> > > > > 
> > > > > After commit f5cd8a929c82, such systems may fail
> > > > > pcie_init_service_irqs() and so exit with -ENODEV.
> > > > > 
> > > > > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > 
> > > > Applied to pci/portdrv for v7.3, thank you!
> > > 
> > > Some thoughts on the version now applied to pci/portdrv:
> > > 
> > > * After this patch, the return value of pcie_device_init() is no longer
> > >   evaluated, so that function should be changed to return void as part
> > >   of this patch.
> 
> Yes, seems reasonable.
> 
> But then, possibly negated below.
> 
> > > * If no port services are initalized, e.g. because pcie_device_init()
> > >   failed for all of them, the allocated IRQ vectors are not freed.
> > >   They're hogged, which may be a problem on systems which only support
> > >   very few IRQ vectors such as Sophgo SG2042:
> > > 
> > >   https://lore.kernel.org/r/0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn
> > 
> > Seems like a good idea to free IRQ vectors we don't use.  It *looks*
> > like it should be safe to call pci_free_irq_vectors() here and then
> > again in pcie_port_device_remove() if a port is removed, but Brian
> > wasn't sure, and I didn't look any deeper than pci_disable_msix() and
> > pci_disable_msi().
> 
> I think everything in pci_free_irq_vectors() is written such that it can
> safely be called twice. I'll see if I can verify that better and submit
> an update. I was just unsure at the moment of review, especially
> considering you had other real double-cleanup bugs in your proposal.
> 
> > I guess if we did this we'd need to retain the pcie_device_init().
> 
> Ack.
> 
> > > * It might be clearer to call pci_clear_master() directly in the
> > >   if-block which is amended to "goto out".  Then the "goto out"
> > >   can be changed to a "return 0".  It seems "if (!capabilities)"
> > >   cannot happen through any other code path, so it's unclear why
> > >   the "out" label is necessary.
> > 
> > It does look nicer that way.
> 
> Hmm, yes. I may have rewritten it enough times that it was never clear
> how many error paths we were going to have. As soon as you get more than
> 1 error path, it gets tricky to do this.
> 
> I'll revisit this one along with the previous suggestions.
> 
> > > * There's a duplicate "have" in the commit message ("have only have").
> > 
> > I fixed this on pci/portdrv.
> 
> Commit message looks good, thanks.
> 
> > What do you think, Brian?
> 
> I'll give the above a shot. I suppose that would work best as a v4
> (pretending your pci/portdrv is only a reference, and not a patch-basis
> target).

Yep, sounds good, I'll watch for it.
