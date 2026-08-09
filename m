Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829A3911BC;
	Sun,  9 Aug 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786257010; cv=none; b=tS/6bQQ5Qf0tV/DrUp/IV4ns1B4lv6Jk8WuePS/fMKx2S3pspOa9sBOV3+y9WsnKxXnwWZznQF/JpAWLXnKrGUAgcVo1OCrOD8gRUDRdmLG9dMPu/ALgT83Z0d7tSsZtxnIsMYEXuRlVExcYdnd8IOLuLlDjNL/2Cb+bmPjCmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786257010; c=relaxed/simple;
	bh=GpkzSxGnkF7y7Fgqr25lG8BAFcc7bBpNvHUNc0MUHXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Htxw1G5NlCbuNt4zIoYjSGAjmAfVMhAZwHDLEhGguucnDoRP7WSizZYUFbjxtZJ15xKXkEzh6qUsBoY6csTtfGgmes4TatPxFLhGkQujL5CXNkMtlH0T4okvJem1Zi83EyyiuiKGNKvKbiH9Drc9kaJUO70W2Z/yRUKL832bS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 2F3EBC30;
	Sun, 09 Aug 2026 08:22:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EBA73600D16B; Sun,  9 Aug 2026 08:22:03 +0200 (CEST)
Date: Sun, 9 Aug 2026 08:22:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Message-ID: <angci4oGyGFtvbSQ@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de>
 <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de>
 <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>

On Sat, Aug 08, 2026 at 08:34:38PM -0700, Derek John Clark wrote:
> This was good instinct. I was able to drill down and find
> approximately where it is hanging.
> 
> rtsx_pci_remove() ->mfd_remove_devices() -> mfd_remove_devices_fn() ->
> platform_device_unregister() -> platform_device_del() -> device_del()
> -> bus_remove_device() -> device_release_driver() ->
> device_release_driver_internal() -> __device_release_driver() ->
> device_remove()
> 
> In device_remove() (drivers/base/dd.c) it gets past
> device_remove_groups() and hangs before completing this if block:
> 
> if (dev->bus && dev->bus->remove)
>     dev->bus->remove(dev);
> else if (dev->driver->remove)
>     dev->driver->remove(dev);

Okay, that ->remove callback should be rtsx_pci_sdmmc_drv_remove()
in drivers/mmc/host/rtsx_pci_sdmmc.c.  Can you maybe identify where
execution stops in that function?

Basically the rtsx_pci driver creates a child device of the PCI device
and the mmc host driver binds to that child device.  Removing the
mmc host driver fails here for some reason.

> > If you go to sleep and resume without SD card, do you then see in dmesg
> > that the card reader was de-enumerated and re-enumerated?  Normally
> > there should be at least a "Card not present" / "Card present" message
> > from pciehp, if it sensed a replaced device.  ("Card" refers to PCIe card,
> > not SD card.)
> 
> i get card not present, then card present, then link up.
> 
> > Also, what's the subsystem vendor/device ID as seen with lspci after
> > a successful system sleep transition (successful = without SD card)?
> 
> it reflects the Realtek device VID/PID. I also tested resume after the
> 1 cycle with it re-inserted and it works fine after the first cycle,
> presumably because the device id matches on the second run and beyond

Right, when the device is re-enumerated after the first system sleep
transition, the Realtek subdevice vendor/device ID is cached and that
matches on all subsequent system sleep transitions.  So if we manage
to find and eliminate the cause of the hang, there'll only be the
inconvenience of the removal/re-enumeration on first sleep.

Thanks,

Lukas
