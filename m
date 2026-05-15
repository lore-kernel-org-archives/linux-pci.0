Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9040B6D8;
	Fri, 15 May 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863930; cv=none; b=rZFQ633TMJmQ3kDj5QYHq6Vkus7ab053UvVQDzuEMtTMkv8WSiuQdRVDSHJusOwdJQd/uxW5TB/IaW0MaylT2PlnBcYAVKDt41PzyFPqYmyW4pUNtFZGgNN2SpwbD7RW/ofWJy5uTf3ExRvekZhxrQIBwgLFWw3p0+0Ak1EyJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863930; c=relaxed/simple;
	bh=XUt+qDZuvmeMKzNhPUVeBrnoF1tfZAaOTunhYvVhKgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrPx5ymyR0eBvmwzRtI/sB01BfyCJ1nNADMHVZ+3Ck0KfODqPTZ20V/jqZzT6vBFEOaf9Jz06fBliIrB6z3UcHn+jNxYRLIO9Gyc+673hJMlR0zpdmGzcI6CQs2ireutPAOoeBWbyJ4QkD9ZJi42RS9yB8dmFQgTOMJo1g8FrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=oCSgKgai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sezACROT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="oCSgKgai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sezACROT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CD4CE1D000BC;
	Fri, 15 May 2026 12:52:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 12:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778863926;
	 x=1778950326; bh=bQeaDmipB8BpaTWUW4seEEeoE8dKC3jLG474aLzcMFg=; b=
	oCSgKgailXwY5FnNk8gEGKYII6n43nUa9tEqgqs5upxhoZnmQWh0gWG8/nBEp7Ru
	F6mda/359zgzp8wR4uL8BbPMEADY+svHrYeFs/7d5xuBiAiJjEdjsPP47ntC8dlH
	aSKhydsUUgfPL0Jo6qKb0CKVBddMmeNVo7YNqQz+CjkDdbwyDkLyHwFbUuJA5jKy
	e8gFzTYP4rPDKhGhuEMIo/1SgiQKuJCcDgR25Rdy1VTmPoOsxvRBJ6oNC5A8GucI
	toFT3Q9B7pkWmnNqAFCYqalyHVlR+b4DaegA4CgUmoCWdvSfIUcc8+2aZ/RJxeZi
	eDcqOyuKaa2pjQYJ6SpJRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778863926; x=
	1778950326; bh=bQeaDmipB8BpaTWUW4seEEeoE8dKC3jLG474aLzcMFg=; b=s
	ezACROT5fKD/m95BWp4n0H18dIElCpzGCFvXK1ijND8EhkiuyEBJUrAhn6nHr5x8
	j7iNJI8D9AQQknd5LbQW57okwkYN8zM2Jb/MJvqXr1G+zySolJArnY521/URPzMG
	NoD3FF45CDDeCgp80lx37WbRHW1jd/duEq3ptoYQ3TYcC6QN4PvwQZna5pGJNJJK
	x49QJ13Fo8Nawu1f8ABalKq/j3RlhW0oLKsHeAEab5zKuzGMxdvGEmsPgWJ2jxb8
	KbiKaG2tmWJDV/xGBuo3J9I3uVHa/SeIZHSmLGlru24HQUPeOergKPHtcc6ur//W
	/dxZdfkTG3ZrTD3F3W6RQ==
X-ME-Sender: <xms:Nk8HaqtaUVyJSiLUpGiCwUjPaVCvW6kQgFQS6C2JeGU3-lqbE3m5uA>
    <xme:Nk8Hag9nXsvHb_Cy5w098QKKDtjYQ9RMySBL5Cdy9cVEZHv7A4uVtnKZ4SQlcDxbG
    ZwJJmSUKmDbEkqo6UNw7pv8vpFtk5BESga-bbNB-suVxTQbwOZs9Q>
X-ME-Received: <xmr:Nk8Hal0Ys6BHUwAby6EVZwBT3qUZlZK73Dutb2F5RH1T578AhYPqO2_kZj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjthhorhhn
    ohhsmhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:Nk8HalBH3XOL1XLaW1lBxYIeW7Bn2p3Bp1NJRWpipN2fha4e1mW0Wg>
    <xmx:Nk8HaheFQpfQ0NXyXt__SoGyT0gIre-XuYxGrBddlRsd3LS-KTkTnA>
    <xmx:Nk8Hai6WisXShgOFeJlgZDiTVQa_wdo1ny9d5DGhFzcYh7A1yPArWw>
    <xmx:Nk8HakWgGj6hBeC2GuK4dHQVWmzGOuyrhek31oCaypiO4deh-lyldQ>
    <xmx:Nk8Hannnjssil9jtziSIEV3PWNJxGlmx9Zl4mJq59XE2_elE60CVDNJq>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 12:52:05 -0400 (EDT)
Date: Fri, 15 May 2026 10:52:03 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Message-ID: <20260515105203.12b14c5a@shazbot.org>
In-Reply-To: <20260514122316.23467-1-jtornosm@redhat.com>
References: <2c4dbba3-f9ed-48d9-a0c4-d590904f3fdf@app.fastmail.com>
	<20260514122316.23467-1-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 14:23:15 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Hello Alex,
> 
> Thank you again for your feedbak.
> 
> > This fall through is invalid, if D3cold can't be reached the reset should
> > be handled by pci_pm_reset() where NoSoftRst is honored.  pci_pr3_preset()
> > should be tested in all cases, not just probe.  I think we also need to
> > test device flags that would prevent a D3cold transition,
> > like pci_pm_reset().  Thanks,  
> Ok, I've implemented it as a strict method (only when _PR3 is present) as
> you suggested for the next version. I think it can be very helpful.
> 
> However, I'm facing a challenge with a part of our deployment scenario and
> if possible I would appreciate your guidance (spoiler: d3hot possibility
> would be very helpful).
> 
> Let me comment on about this setup in our lab:
> - Qualcomm WiFi cards (ath11k 17cb:1103, ath12k 17cb:1107) and modems
>   (SDX62/SDX65 17cb:0308)
> - M.2 format devices using passive PCIe adapters (not native M.2 slots)
> Problem:
> - No FLR capability on devices
> - NoSoftRst+ set (blocks PM reset)
> - SBR broken through passive adapters (PERST# signal not properly wired)
> - No _PR3 ACPI resources for standard PCIe slots (only for native M.2/
>   Thunderbolt)
> - d3cold_allowed=1 but pci_pr3_present() returns false
> Result:
> Default kernel has no working reset method (reset_methods shows only "bus"
> which doesn't work).
> 
> I've tested the D3hot transition behavior and this is what I see before/
> after:
> - Command register: Cleared to 0x0000 (device disabled)
> - BARs: Preserved (0x84200004 unchanged)
> - Device successfully reinitializes and works in VFIO passthrough, so we
>   can use it.

Are you testing with the patch that marks these devices
PCI_DEV_FLAGS_NO_BUS_RESET?

I want to be sure that bouncing the device through D3hot is actually an
improvement versus no reset at all, and we're not just performing a
no-op reset to avoid the bus reset.

That said, if you're testing before BAR restore and those registers
aren't being cleared, this seems at best a device specific reset, but
evidence is a bit sketchy.  In the general case, a transition through
D3hot for a device that does not claim NoSoftRst- cannot be consider to
satisfy a reset request.
 
> I don't dare to generalize D3hot in pci_pm_reset() with something like:
> if (csr & PCI_PM_CTRL_NO_SOFT_RESET) {
>   pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);
> 
>   /* If device supports D3hot, try reset despite NoSoftRst */
>   if (!pmc & PCI_PM_CAP_D3HOT_MASK)
>     return -ENOTTY;
> }
> because some devices could truly advertise NoSoftRst+ and d3hot could not be
> usable as a reset.

This should be the default, no assumed reset.  The device is
specifically able to indicate soft reset via D3hot.

> I don't know if some device-specific quirk could be acceptable to bypass
> NoSoftRst check for these Qualcomm devices (similar to
> PCI_DEV_FLAGS_FORCE_PM_RESET from v2), although d3hot is usable in these
> cases.
> 
> Or maybe the generalization could be to create a user parameter to bypass
> PCI_PM_CTRL_NO_SOFT_RESET for the configured device. This would be manual but
> at least it would allow the device to work on VMs.

vfio-pci will try to put unused device into a low power state when
they're unused.  If the kernel exposes no function level reset
mechanism, wouldn't the device experience D3hot after some idle timeout
and then be usable again?  Could you otherwise set the device power
state via sysfs?  It's certainly possible to create a userspace vfio
stub driver that uses the low-power ioctl to trigger D3hot.

Unfortunately not all devices are sufficiently spec compliant to work
cleanly with vfio, especially consumer grade devices without vendor
involvement.

> And finally, what I would choose: move pm to the end of the resets methods
> ignoring NoSoftRst, prioritizing hardware resets first (FLR, bus, d3cold)
> and using d3hot as the last resource if none of the others work. But this is
> an important change and there could be some reasons for pm positioning that
> I ignore, so if you don't mind I would like to consult you first.

We're getting into policy there, where the purpose of exposing
reset_methods through sysfs is to allow userspace to define policy.
There's obviously some policy in the default ordering, but we generally
take the approach of flagging broken resets rather than enforcing an
order.  In general I agree with your suspicion of pm reset, there's no
hard definition of a soft reset in the spec afaik.  In fact, QEMU tries
to infer whether the vfio reset ioctl likely implements pm reset by
looking at the device features and will prefer a bus reset when the
alternative is likely a pm reset.

If you can block the known broken resets and manage to trigger a D3hot
transition externally, that may provide a reasonably useful
environment.  We've also been known to implement the sketchier resets
that can't fully be justified as a kernel quirk in QEMU itself.  Thanks,

Alex
