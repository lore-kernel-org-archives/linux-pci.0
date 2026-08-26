Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D13B637C;
	Wed, 26 Aug 2026 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777378; cv=none; b=kH2wv/eiVa7dUx3GcjkzwX4jf7dt/IqHV13U8EaaNXXRclSV7lNaYrMvGKKK8BP2xw8mwPmjB6zUmfQ0HfSVIWeaGr/wH2j1FL/cRJKVi+gfdSr3rCHwmhwv3iog49So9G3iI69iwC9tBP1P0rFNxqHDdb3gM0+VWtz0/dzMEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777378; c=relaxed/simple;
	bh=eZXlyzYTvhpYQX0vYnsJvhLcp+1JvXo9isLsDoJSzb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bBVvXmvTqIvou6zUSetHIZX1FWskK+E0f1u2WOB6k1GXxf6rtaQMXGaeGVHkD8W+naZv60yvd4pWC7JzVUYLTyqqN6n0B+uIW7o2rr2vTU8z22S4mGEaKHP6Dfw28VChyakKnsrF4/ktxJWHJDxPtjlau7dKVKjUrPHIjRy8E3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGk3CVrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGk3CVrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555881F000E9;
	Wed, 26 Aug 2026 20:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787777376;
	bh=MXs0Xyjs6nbD9KqJTACrQAKLPmolu5C3YoQkbeWEKLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lGk3CVrCzwfeUEpV3JcH3T3kCLcDqaus+C3yFjlKUdHGv3KFS4HLQn6Nog7UlOLel
	 1d5Hi6bzqbXoGFFDVPexk1MwHlqSEogOCiXT47ZqiqXPTbr9e9R/fq8WA98h7cdESH
	 0KIBh+L5uwg+6ecoDoISbq0QMzuR4QvIbi4c3dRuxpx2osjP3nVyqG0o/ju4MyggQf
	 +n5YY/3fPDL8xI7MZXqla+K3uXTEIh1mlHOIgta8BVM/ckrWAOCuptZ898wA1FzC4L
	 OZSeipvssJNwNG3iVfDy7XnHqQyvo+G5n/mdz9TQQltKR1hsn9xnJ8IR4Ge3DrIpKQ
	 tBwOeYr0xpEdw==
Date: Wed, 26 Aug 2026 15:49:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, joelsmith@tenstorrent.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI: quirks: Drop unassignable 32 GiB BAR 4 on
 Tenstorrent Blackhole
Message-ID: <20260826204935.GA1557819@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEev2e9HzMt27wWchsQGKuLELVW5hqL4-XK4DuP6XSwS6zmouQ@mail.gmail.com>

On Wed, Aug 26, 2026 at 03:16:29PM -0500, Anirudh Srinivasan wrote:
> On Wed, Aug 26, 2026 at 2:55 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Aug 24, 2026 at 11:57:07AM -0500, Anirudh Srinivasan wrote:
> > > Tenstorrent Blackhole cards expose a 32 GiB BAR 4 that is unused by most
> > > software talking to the card. This BAR cannot be assigned on hosts whose
> > > PCI aperture is smaller than 32 GiB (e.g some ARM/RISC-V systems). This
> > > failure also results in BAR 0 (256 MiB) and 2 (2 MiB) being unassigned
> > > because bridge windows are sized as the sum of all enabled child BARs.
> > > This makes the card completely unusable on such systems.
> > >
> > >     spacemit-k1-pcie 80000000.pcie: PCI host bridge to bus 0000:00
> > >     pci_bus 0000:00: root bus resource [bus 00-ff]
> > >     pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x10000-0x10ffff])
> > >     pci_bus 0000:00: root bus resource [mem 0x1100110000-0x117fffffff] (bus address [0x00110000-0x7fffffff])
> > >     pci_bus 0000:00: root bus resource [mem 0x1800000000-0x18ffffffff pref]
> > >
> > >     <snip>
> > >
> > >     pci 0000:01:00.0: [1e52:b140] type 00 class 0x120000 PCIe Endpoint
> > >     pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x1fffffff 64bit pref]
> > >     pci 0000:01:00.0: BAR 2 [mem 0x1120000000-0x11200fffff 64bit pref]
> > >     pci 0000:01:00.0: BAR 4 [mem 0xfffffff800000000-0xffffffffffffffff 64bit pref]
> > >
> > >     <snip>
> > >
> > >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: can't assign; no space
> > >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: failed to assign
> > >     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
> > >     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
> > >     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: releasing
> > >     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: releasing
> > >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: can't assign; no space
> > >     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: failed to assign
> > >     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
> > >     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
> > >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't assign; no space
> > >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed to assign
> > >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't assign; no space
> > >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to assign
> > >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't assign; no space
> > >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to assign
> > >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't assign; no space
> > >     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed to assign
> > >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't assign; no space
> > >     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to assign
> > >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't assign; no space
> > >     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to assign
> > >
> > > Add a header fixup that walks the root-bus apertures and drops BAR 4
> > > when it is larger than every root-bus aperture. Resource assignment
> > > skips resources with zero flags (pdev_resource_assignable()), so the
> > > bridge window then sizes to BARs 0/2 and succeeds. This was tested on a
> > > Spacemit-K3 RISC-V board that has only 4GiB of BAR space. tt-smi and
> > > tt-bh-linux are able to run on the card.
> > >
> > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > > ---
> > >  drivers/pci/quirks.c | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index b09f27f7846fc..df54e379c116b 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -6415,3 +6415,35 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
> > >  #endif
> > > +
> > > +/*
> > > + * Drop unused 32 GiB BAR 4 on Tenstorrent Blackhole cards so the card is
> > > + * usable on systems with smaller host bridge apertures.
> > > + */
> > > +static void quirk_tenstorrent_blackhole_bar4(struct pci_dev *pdev)
> > > +{
> > > +     struct resource *res = &pdev->resource[4];
> > > +     struct pci_bus *bus = pdev->bus;
> > > +     struct resource *win;
> > > +
> > > +     if (!(res->flags & IORESOURCE_MEM))
> > > +             return;
> > > +
> > > +     /* Find the root bus; its resource list holds the host apertures */
> > > +     while (bus->parent)
> > > +             bus = bus->parent;
> > > +
> > > +     pci_bus_for_each_resource(bus, win) {
> > > +             if (!win || !(win->flags & IORESOURCE_MEM))
> > > +                     continue;
> > > +             if (resource_size(res) <= resource_size(win))
> > > +                     return;
> > > +     }
> > > +
> > > +     pci_info(pdev, "BAR 4 %pR larger than every host bridge aperture, dropping it\n",
> > > +              res);
> > > +     res->start = 0;
> > > +     res->end = 0;
> > > +     res->flags = 0;
> >
> > This seems problematic because the hardware BAR still exists even if
> > we zero out res->flags.
> >
> > This is a problem because pci_enable_device() will successfully enable
> > a device and turn on PCI_COMMAND_MEMORY even though the hardware BAR
> > may contain junk.  And if a driver ioremaps this BAR, it is
> > ioremapping physical address 0, which doesn't end well.
> >
> > I know this from bitter experience :)
> >
> > If you have some device-specific way to actually disable the BAR in
> > the hardware, that could work.
> 
> lspci for this device doesn't show this BAR region. Are you saying
> that BAR4 still exists (but points to 0) ? Our driver doesn't seem to
> have any issues with this, but some other driver may not play well
> with this.
> 
> $ lspci -d 1e52: -vvv
> 0000:01:00.0 Processing accelerators: Tenstorrent Inc Blackhole
>         Subsystem: Tenstorrent Inc p150a
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 27
>         Region 0: Memory at 1800000000 (64-bit, prefetchable) [size=512M]
>         Region 2: Memory at 1820000000 (64-bit, prefetchable) [size=1M]
>         Capabilities: <access denied>
>         Kernel driver in use: tenstorrent

I think by default lspci will show you what the kernel knows about the
device, i.e., what's in the dev->resource[] array.  If res->flags is
zeroed out, the kernel doesn't know anything about the BAR, so it
probably won't appear in lspci output.

But of course that doesn't change anything from the device's
perspective.  If you ioremap BAR 4 and read a word from it, I think it
might not work.  Based on your dmesg log, it doesn't look like
physical address 0 would be routed to PCI, so it probably causes some
kind of exception unless you happen to have RAM at physical address 0.
