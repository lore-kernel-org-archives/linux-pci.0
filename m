Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409403B6360;
	Wed, 26 Aug 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774108; cv=none; b=KYMYpsBid7KbXxWT7Wmz3BhGpsB5i/DNepJ3X7n3tRdiAE9B5wRQUBeLAZTyt0j4MUcpAXft0Tq0H1yy96XSMtChq8O7ruZljyfVu6c5HCIcEKLwlGYp+MIMvgtm5daE+xITU2Bv96LUZxOfQBLqyJpHLBS75q0BedYik2WLpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774108; c=relaxed/simple;
	bh=dimVdknLV3jIQPYZtWaDjFFj6jBOJbD7A711cvrdhpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FtT2oQ5ikX6e6nIKJQxM7q42dobC+NpQdocGLMUEjITrkm7VB/P26zcknvbCBFvnhPxgj5lMPoDDgk7R4OvGns+xQtTDLV+KYbCjUywIt4A5c11LyQp2h38ccF3Gb6T4Wx4/xdUZVo0HTzU9bVp034d4Pr+1Rgbqi/WTyeQYeos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3Zaicrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Zaicrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1091F000E9;
	Wed, 26 Aug 2026 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787774105;
	bh=CpBGG32F3hkSEfDX8eOBQ2X3zREZIWoBTR0ZK60FFlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Q3Zaicrf8DvZVmYv2tghrgT57tO+zCw1TwRiGeAY2wd2Trcu3EEptie0r95kg1rRd
	 EmU7NAX3O2SYk9f7kjxhcvFKmXE6xoCZaRRvW+lhF+naFZwALkTuTttrK+DJimVq2Y
	 BES80/DTXx+bz6GhO5SSa2owDhD72cPkbCZCOHCWBIIH0ZKC4L/cUk9jILJdulIPoe
	 76xn5XxEmOD3WVLg5DFoqR2iEvclYd9j3kkjwil8aflS5hWBcqm9j6mP1rE7u3h9Hq
	 yfIAxlz+JC2lhk48SKGfL3M671Fk2vTAuJ8AYE0yxAYrLmTP+0AoXQufLlG9Ty+iAd
	 WCdYWJkA4vgJQ==
Date: Wed, 26 Aug 2026 14:55:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, joelsmith@tenstorrent.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI: quirks: Drop unassignable 32 GiB BAR 4 on
 Tenstorrent Blackhole
Message-ID: <20260826195503.GA1554946@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-blackhole_quirk-v1-2-fc004672cdbd@oss.tenstorrent.com>

[+cc Ilpo]

On Mon, Aug 24, 2026 at 11:57:07AM -0500, Anirudh Srinivasan wrote:
> Tenstorrent Blackhole cards expose a 32 GiB BAR 4 that is unused by most
> software talking to the card. This BAR cannot be assigned on hosts whose
> PCI aperture is smaller than 32 GiB (e.g some ARM/RISC-V systems). This
> failure also results in BAR 0 (256 MiB) and 2 (2 MiB) being unassigned
> because bridge windows are sized as the sum of all enabled child BARs.
> This makes the card completely unusable on such systems.
> 
>     spacemit-k1-pcie 80000000.pcie: PCI host bridge to bus 0000:00
>     pci_bus 0000:00: root bus resource [bus 00-ff]
>     pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x10000-0x10ffff])
>     pci_bus 0000:00: root bus resource [mem 0x1100110000-0x117fffffff] (bus address [0x00110000-0x7fffffff])
>     pci_bus 0000:00: root bus resource [mem 0x1800000000-0x18ffffffff pref]
> 
>     <snip>
> 
>     pci 0000:01:00.0: [1e52:b140] type 00 class 0x120000 PCIe Endpoint
>     pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x1fffffff 64bit pref]
>     pci 0000:01:00.0: BAR 2 [mem 0x1120000000-0x11200fffff 64bit pref]
>     pci 0000:01:00.0: BAR 4 [mem 0xfffffff800000000-0xffffffffffffffff 64bit pref]
> 
>     <snip>
> 
>     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: can't assign; no space
>     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: failed to assign
>     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
>     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
>     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: releasing
>     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: releasing
>     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: can't assign; no space
>     pci 0000:00:00.0: bridge window [mem size 0x820100000 64bit pref]: failed to assign
>     pci 0000:00:00.0: BAR 0 [mem 0x1108000000-0x110fffffff]: assigned
>     pci 0000:00:00.0: BAR 1 [mem 0x1110000000-0x1117ffffff]: assigned
>     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't assign; no space
>     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed to assign
>     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't assign; no space
>     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to assign
>     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't assign; no space
>     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to assign
>     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: can't assign; no space
>     pci 0000:01:00.0: BAR 4 [mem size 0x800000000 64bit pref]: failed to assign
>     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: can't assign; no space
>     pci 0000:01:00.0: BAR 0 [mem size 0x20000000 64bit pref]: failed to assign
>     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: can't assign; no space
>     pci 0000:01:00.0: BAR 2 [mem size 0x00100000 64bit pref]: failed to assign
> 
> Add a header fixup that walks the root-bus apertures and drops BAR 4
> when it is larger than every root-bus aperture. Resource assignment
> skips resources with zero flags (pdev_resource_assignable()), so the
> bridge window then sizes to BARs 0/2 and succeeds. This was tested on a
> Spacemit-K3 RISC-V board that has only 4GiB of BAR space. tt-smi and
> tt-bh-linux are able to run on the card.
> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
>  drivers/pci/quirks.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..df54e379c116b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6415,3 +6415,35 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +/*
> + * Drop unused 32 GiB BAR 4 on Tenstorrent Blackhole cards so the card is
> + * usable on systems with smaller host bridge apertures.
> + */
> +static void quirk_tenstorrent_blackhole_bar4(struct pci_dev *pdev)
> +{
> +	struct resource *res = &pdev->resource[4];
> +	struct pci_bus *bus = pdev->bus;
> +	struct resource *win;
> +
> +	if (!(res->flags & IORESOURCE_MEM))
> +		return;
> +
> +	/* Find the root bus; its resource list holds the host apertures */
> +	while (bus->parent)
> +		bus = bus->parent;
> +
> +	pci_bus_for_each_resource(bus, win) {
> +		if (!win || !(win->flags & IORESOURCE_MEM))
> +			continue;
> +		if (resource_size(res) <= resource_size(win))
> +			return;
> +	}
> +
> +	pci_info(pdev, "BAR 4 %pR larger than every host bridge aperture, dropping it\n",
> +		 res);
> +	res->start = 0;
> +	res->end = 0;
> +	res->flags = 0;

This seems problematic because the hardware BAR still exists even if
we zero out res->flags.

This is a problem because pci_enable_device() will successfully enable
a device and turn on PCI_COMMAND_MEMORY even though the hardware BAR
may contain junk.  And if a driver ioremaps this BAR, it is
ioremapping physical address 0, which doesn't end well.

I know this from bitter experience :)

If you have some device-specific way to actually disable the BAR in
the hardware, that could work.

> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TENSTORRENT, 0xb140, quirk_tenstorrent_blackhole_bar4);
> 
> -- 
> 2.43.0
> 
