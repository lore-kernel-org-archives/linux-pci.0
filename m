Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AB364EB2;
	Thu,  8 Oct 2026 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502155; cv=none; b=YfLc+kOgpL/uKAsFsuOQfa3JQMiwwgcpTHP5Ubey30axDGdooscFer+2r1ZW1Rg4WhqjUwRIppI8K6gTOlU3dKYubCfrYTIVOi3p1DuELZKNxorlTE3+B706z6VU1fpmwNAaOv2TMybOPDJDqmS0ifOgxquSxD32QKfbCdENEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502155; c=relaxed/simple;
	bh=DAtdyRwAmVz4SjXPJjh/cQOiY0fPuVX/i36Eo1ZKfiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kBfNvKx2trh3zn1frgDELnvXImI8hLGgGRSM/Ev8DAnJNElNE8jtWywkSwLIC2FR0LSc2J+5Yd7Q+Ys9/3CVsd3dsx/0GuS3kF2WX/CZLh6Y6tBQFtZ9+m8qtli++71s6pLzwdOSFmzoNGxIw6CgHezhwgTbgGKqu7sMaHlXPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3q7B99t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3q7B99t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9BD1F000FF;
	Thu,  8 Oct 2026 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791502154;
	bh=Ts+cEh9XJnlZdfjN2hdl+FRuRgOhRs788AdZMXx3O6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=I3q7B99tllw7LSLon9/At9Vu7MHrdpTYoh285t5CSmHiGhHZlSYD3NHcg2zCjvZoL
	 kKcXpdVjnKrjyws3zyXtQD3AflEfZIEQdJ+KyNae+kyDNUPaO+UFZf8/vCe0NQIz2i
	 GOGthldRhh9cB9G7AfyAm510GsBeyO/0izFreIwxKHiMMJpfTMLDSsB5w13i8I7rmj
	 HQFDqAob92DteoZJlIEYZk7YzM5yk1+LWShf/qOJfcRLHn7qXH2gRaY2YSOdz6wx1k
	 8I3EbRfXysmezEAFrfZuBQEJ3aW62W8seCoo68Val1JSY/kcvzJdNV+LfEKPYujBYU
	 cZ1vJl1KZejUA==
Date: Thu, 8 Oct 2026 18:29:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: rafael@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, Darrell Gum <d@rrell.co>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCI: take native PME control on Apple machines
Message-ID: <20261008232912.GA940274@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924132859.24751-1-fbeltranmillalen@gmail.com>

[+cc Matthew (author of 7bc5a2bad0b8), Darrell, Andreas, Mika,
Yehezkel, Lukas, linux-usb]

On Thu, Sep 24, 2026 at 10:28:59AM -0300, Francisco Beltrán Millalén wrote:
> Since commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> negotiate_os_control() skips the _OSC handshake on Apple machines and
> hardcodes the set of features the OS takes over, because those firmwares
> return failure once _OSI("Darwin") has been acknowledged.  The hardcoded
> set is ~OSC_PCI_EXPRESS_PME_CONTROL, i.e. everything except PME.  No
> reason was given for leaving PME out.

It's clear there *was* a reason, but I don't know either.  Maybe
Matthew will remember?

> The result is that host_bridge->native_pme stays 0, so portdrv never
> registers the PME service for any root port.  A PCIe device that
> runtime suspends still arms PME# (the PCI core enables it because
> pci_dev_run_wake() only looks at capability), asserts it when it needs
> attention, and is never resumed: no service handles the root port
> interrupt, and the polling fallback in pci_pme_list_scan() skips the
> device whenever the bridge above it is runtime suspended, which is
> exactly when the device itself is suspended.
> 
> On a MacBookPro14,3 this silently breaks USB-C hotplug.  Both xHCI
> controllers sit inside the Thunderbolt (Alpine Ridge) switches and
> runtime suspend to D3hot when idle, together with their parent
> bridges.  Plugging a SuperSpeed device in is then never noticed:
> 
>   0000:7d:00.0 suspended, PMCSR 0x8103 (D3hot, PME_En=1, PME_Status=1)
>   ... no kernel message at all, for minutes ...
> 
> The device only appears once something else resumes the controller,
> which makes it look intermittent.  The firmware on this machine does not
> handle PME on behalf of the OS either: XHC2/XHC3 declare _PRW returning
> GPE 0x6D, that GPE is enabled and has never fired, and its _L6D handler
> notifies PWRB, XHC1 and HDEF only - never XHC2 or XHC3.
> 
> With PME control taken, the root port PME interrupt is serviced and the
> controller is resumed as soon as something is plugged in.
> 
> Use calculate_control() for the assumed set rather than open coding it:
> that is by definition the set that would have been requested, it drops a
> magic constant, and on a kernel built without some of those features it
> no longer claims control of services the OS cannot provide.
> 
> Note this also makes pme_is_native() true for pciehp (drivers/pci/
> hotplug/pciehp_core.c), so hotplug ports now disable their interrupt
> across suspend and clear spurious events on resume, as they do on every
> non-Apple machine.  x86_apple_machine covers Macs back to 2006, so this
> reaches models that were never tested with native PME.
> 
> Tested on a MacBookPro14,3, 6.18.49, with a USB 3.1 SATA enclosure:
> 
>   - before: plugged in at 09:20 with 0000:7d:00.0 runtime suspended, still
>     invisible at 09:21 with PME_Status latched at 1; only appeared when
>     0000:7d:00.0 was forced to power/control=on.
>   - with pcie_ports=native (which reaches the same code path in
>     get_port_device_capability()): pcie_pme bound to 5 root ports, and the
>     same enclosure enumerated in the same second it was plugged in, 66 s
>     after the controller had suspended, with nothing forced.
>   - with this patch, nothing forced: pcie_pme bound to 5 root ports and the
>     _OSC line now reads "OS assumes control of [PCIeHotplug SHPCHotplug PME
>     AER PCIeCapability LTR DPC]".  The enclosure was unplugged at 20:42:13,
>     0000:7d:00.0 runtime suspended to D3hot, and on plugging it back in at
>     20:43:06 (53 s later) the root port took a PME interrupt and the device
>     enumerated in the same second.
>   - wifi, internal keyboard, touchbar and audio all came up; 66 warnings
>     and 45 errors during boot, against 65/43 on the distribution kernel.
> 
> One rough edge, reproducible on both boots: the port driver logs
> "PME: Spurious native interrupt!" right before the device is resumed.
> pcie_pme_handle_request() falls back to pcie_pme_walk_bus() when the root
> port reports its own requester ID without PCI_PM_CTRL_PME_STATUS set, and
> that walk skips PCIe devices, so the xHCI is never attributed.  The device
> is still resumed and the wakeup works, but attributing PMEs from PCIe
> devices behind a switch looks like a separate shortcoming; it is not
> addressed here.
> 
> Boot with pcie_ports=native also showed no new AER/DPC activity and
> slightly fewer warnings than a boot without it, so taking the remaining
> control bit does not appear to disturb anything else on this machine.
> 
> Fixes: 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>

I don't object from a PCI standpoint, but Rafael generally takes care
of acpi/pci_root.c.  I would again suggest putting some of the commit
log detail below "---" and relying on the https://patch.msgid.link/
tag Rafael adds.

> ---
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -568,9 +568,14 @@
>  	 * Apple always return failure on _OSC calls when _OSI("Darwin") has
>  	 * been called successfully. We know the feature set supported by the
>  	 * platform, so avoid calling _OSC at all
> +	 *
> +	 * Assume control of the same features that would have been requested,
> +	 * PCIe PME included.  Leaving PME out disables the PME service for
> +	 * every root port, and nothing takes over: a device that runtime
> +	 * suspends asserts PME# and is never resumed.
>  	 */
>  	if (x86_apple_machine) {
> -		root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
> +		root->osc_control_set = calculate_control();
>  		decode_osc_control(root, "OS assumes control of",
>  				   root->osc_control_set);
>  		return;
