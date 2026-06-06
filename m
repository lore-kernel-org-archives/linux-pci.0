Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6330E0EC
	for <linux-pci@vger.kernel.org>; Sat,  6 Jun 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780781004; cv=none; b=m0bFUv6mvGWkZchiNM+Q9w/Z2P/5mKEm2/Ee7A/j63mz557EwmrQldLqulqO3OLwzil3YySw0vV7ql/z8QPNfyB7QkPc7ldAVv0IImalN+mx5NdTTPrHwmCQbxVeK/pAkgi/ieLwygtIhzxjuFhHfLjY7lKahsjfgL0mCoJHNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780781004; c=relaxed/simple;
	bh=lSPj+OryKoZmvCG2UliazO0ttED2j9YVbCqnKBpcShg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT8ogxeJw3G3RjlelY6zUgozKEiOQXHsB111Bu2t3jAkSWgVt40LvNZJvmR0HsZCrDyruPBdFzK7Y2m2YJmnkJ8nId1uErnjZBAcSmK+bT8XXT3syOCfHhQDQzvidQRncJj7oe/EKp+9dwryL0xvhNMV5J+XuUg9WWJdltuN5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ika4TdmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ika4TdmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A4D1F00893;
	Sat,  6 Jun 2026 21:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780781003;
	bh=eWUNGZB+xkUYKscuHPv5kURfrkwAttnLVW9NCQ85WsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ika4TdmTjJ9qnMUuLWfEPNyN3UZJQI5cUDKH929qdDlmQ9VFMyuULQg18QK3pD3hg
	 MQlPWYuW/G80FtqPu5M2KABWDQdVBqPOD/ZFRq/t1/uPAMGTdIUFubDcQU8IzTsWVm
	 N9EpJsJ+06X8oTmquoChZxilD1PGXYR65Lz3RMBRgj2ibun/X2z9KOSyCQW+fhUEY+
	 bnfokWGAtY0x3bvuaorR2H5GDzxIQzG4qq3Ba4nUrNzYsGYIe7HG00a4G4NvjmPD/N
	 5d4k1oUY0eP16VGlgIFFxhgvd4z5ZGad6xI37Lvww4hAcZNaQthRoRwCE/AjAq8xJ4
	 L6jDsgfH0otWA==
Date: Sun, 7 Jun 2026 06:23:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260606212045.GA2380983@rocinante>
References: <20260606203022.743558-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606203022.743558-1-kwilczynski@kernel.org>

Hello,

> pci_proc_attach_device() creates procfs entries for PCI devices and is
> called from pci_bus_add_device().  It lazily creates the per-bus procfs
> directory (bus->procdir) via proc_mkdir() on first use, and returns
> early if proc_initialized is not yet set.
> 
> On x86 with ACPI, PCI enumeration occurs at subsys_initcall, before
> pci_proc_init() sets proc_initialized at device_initcall.  The
> for_each_pci_dev() loop in pci_proc_init() then creates procfs entries
> for these already-enumerated devices, but runs without holding
> pci_rescan_remove_lock.
> 
> On ARM64 with devicetree, PCI host bridges probe at device_initcall.
> With async probing enabled, pci_bus_add_device() can run concurrently
> with pci_proc_init(), and both may call pci_proc_attach_device() for
> the same device or for different devices on the same bus.  As
> pci_host_probe() holds pci_rescan_remove_lock while pci_proc_init()
> does not, there is no serialisation between the two paths.
> 
> When two threads concurrently call pci_proc_attach_device() for devices
> on the same bus, both observe bus->procdir as NULL and both call
> proc_mkdir().  The proc filesystem serialises directory creation
> internally, so only one caller succeeds.  The other receives NULL
> (duplicate entry) and unconditionally stores it to bus->procdir,
> corrupting the valid pointer set by the first caller.
> 
> Thus, extract the bus procfs directory creation from
> pci_proc_attach_device() into a new pci_proc_attach_bus() function,
> and call it from the two bus creation paths: pci_register_host_bridge()
> for root buses and pci_alloc_child_bus() for child buses.  These are
> the only two callers of pci_alloc_bus(), so for buses created after
> proc_initialized is set, bus->procdir is in place before any device
> can be added to the bus.
> 
> Therefore, by the time pci_proc_attach_device() runs on these buses,
> bus->procdir is already set and the racy proc_mkdir() call is never
> reached.
> 
> For buses created before pci_proc_init() sets proc_initialized (the
> common x86 ACPI case), the bus creation hooks return early.  As such,
> add a fallback call to pci_proc_attach_bus() from pci_proc_attach_device()
> to handle these pre-init buses.
> 
> Additionally, wrap the for_each_pci_dev() loop in pci_proc_init() with
> pci_lock_rescan_remove() to serialise against concurrent PCI bus
> operations, add an early return in pci_proc_attach_device() when
> dev->procent is already set to make the function idempotent, and clear
> bus->procdir in pci_proc_detach_bus() to prevent use of a dangling
> pointer after proc_remove().
> 
> Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@bytedance.com/

Applied to procfs, as I want this to have some soak time via linux-next,
plus 0-day bot will test it for me, too.

Lorenzo, do you think you could re-test this on your hardware platform?

Shuan, any chance for you to test this again on your RISC-V based platform?

Thank you!

	Krzysztof
