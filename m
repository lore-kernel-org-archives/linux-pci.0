Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068B48382C;
	Thu,  1 Oct 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892851; cv=none; b=ZYlMST+WE2dmdBl70iinh2ECQaBQabmNOn7GstbvPlhva3DsDBsInplptEiohYybrQ7yA9tzE3nUdNjixm92Hj7tTR1Qg5eVUH+hpD9nN/Zl8F/GRTaYMlKe+mGWbOo/ju2n+JOGdceQEuxTWebBy8bzeL6zkY9gW/m5QIov2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892851; c=relaxed/simple;
	bh=udSIicWed3K2WLnMs554Rn1vlAf3sgWwL+UXlNJ/5QM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H6MgXQjn+alclEdGFNO2EV/jagCD1x3SO+4VZLLUeypVWZZmsQStMNEsv/RQhFKodAAEH16tAhSC42iLFgJUMGdaFZedLWdACkBiGqYOf/bSdumARzdEaqtiHCpp/pRwArKl94iMfIYUbC3bzzEbJ3JdZBLcNndKlkbmd69RT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2O7ylT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2O7ylT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F51E1F000FF;
	Thu,  1 Oct 2026 22:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790892849;
	bh=Rb8iRRX5Hsg2IrEKJKaGrMm/c8KcdvcUQXH6Pmsqmmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=O2O7ylT/noIbJqz1BohDgB7w+ZctlMl1iZwmGe3zXkitScV955/VZfkpyTq03KhAx
	 mh77kUrhiuRnmqWnqCmNJpIfEVqaw5gpSjmQ+xp+rZ+xQBTNjkTadYPrDBBv19nAbJ
	 E0JhuUHyunSsB/u28popjruLozBQthbkynX/DE7oeiY0uFcrHVQrC1B3qvT3l/h9Mf
	 uoSIdNQWY5zKmxIlEnzfilUmNz85ZxnKuQpIUpjAIdQyyFXjMIUPkwSZJnDcde/m0l
	 ZPOKwP75zJuJ3hIwedQmx6pNkOGsbJKXKYFnWgWR+16kaqa3qvXd7Iee7YuDZXTfem
	 L+EG96TfvUTOQ==
Date: Thu, 1 Oct 2026 17:14:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, lukas@wunner.de, terry.bowman@amd.com,
	kanie@linux.alibaba.com, olof@lixom.net
Subject: Re: [PATCH v14 3/4] PCI/ACPI: Centralize pcie_ports_native checking
Message-ID: <20261001221408.GA2731929@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec0bafa-77f7-4807-bc08-a23b3b618e54@linux.intel.com>

On Thu, Oct 01, 2026 at 02:48:46PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 10/1/2026 1:54 PM, Bjorn Helgaas wrote:
> > On Tue, Sep 22, 2026 at 01:45:47PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> If the user booted with "pcie_ports=native", we take control of the PCIe
> >> port services unconditionally, regardless of what _OSC says.
> >>
> >> Centralize the testing of pcie_ports_native in acpi_pci_root_create(),
> >> where we interpret the _OSC results, so other places only have to check
> >> host_bridge->native_X and we don't have to sprinkle tests of
> >> pcie_ports_native everywhere.
> >>
> >> Rather than overriding the host_bridge->native_X flags after the fact,
> >> fold "pcie_ports=native" into the _OSC control mask we evaluate, i.e.,
> >> proceed as though the platform had granted control of the port services.
> >> That way there is a single mechanism deciding each native_X flag, and we
> >> can report exactly which features we are overriding _OSC for instead of
> >> just noting that we are overriding something:
> >>
> >>   acpi PNP0A08:00: _OSC: OS forcing control ("pcie_ports=native") of [PCIeHotplug PME AER DPC]
> >>
> >> Forcing host_bridge->native_aer also restores DPC service binding under
> >> "pcie_ports=native", which regressed in commit 97ca178c899d ("PCI/DPC:
> >> Allow DPC on all Downstream Ports when OS controls AER").  That commit
> >> replaced the AER service test in get_port_device_capability() with
> >> host->native_aer, so DPC stayed off when host_bridge->native_aer was not
> >> set.
> >>
> >> This also extends "pcie_ports=native" to host_bridge->native_dpc, which
> >> had no pcie_ports_native fallback before.  That effect is narrow.
> >> native_dpc is only consumed by pci_dpc_recovered(), where with
> >> CONFIG_PCIE_EDR=n it previously gave up immediately and now lets pciehp
> >> wait for DPC recovery before treating a Link Down as a hotplug event.
> >>
> >> host_bridge->native_ltr is deliberately not forced.  "pcie_ports="
> >> controls PCIe port services and LTR is not one.  There is no
> >> PCIE_PORT_SERVICE_LTR, and native_ltr is only used by
> >> pci_configure_ltr() to enable ASPM L1.2, so forcing it would be an ASPM
> >> policy decision users did not ask for.
> >>
> >> SHPC hotplug is left alone for a simpler reason: SHPC is a conventional
> >> PCI feature rather than a PCIe one, so "pcie_ports=" has no bearing on
> >> it.
> ...

> >> +	/*
> >> +	 * If the user specified "pcie_ports=native", use the PCIe port
> >> +	 * services regardless of what _OSC says, i.e., proceed as though the
> >> +	 * platform had granted us control of them.  This may conflict with
> >> +	 * firmware that expects to own those features.
> >> +	 */
> >> +	if (pcie_ports_native) {
> >> +		u32 override = OSC_PCIE_PORT_SERVICE_CONTROLS & ~ctrl;
> >> +
> >> +		if (override)
> >> +			decode_osc_control(root, "OS forcing control (\"pcie_ports=native\") of",
> >> +					   override);
> >> +		ctrl |= override;
> >> +	}
> >> +
> >>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
> >>  		  host_bridge->native_pcie_hotplug);
> >>  	OSC_OWNER(ctrl, OSC_PCI_SHPC_NATIVE_HP_CONTROL,
> >> @@ -1051,6 +1079,14 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >>  	OSC_OWNER(ext_ctrl, OSC_CXL_ERROR_REPORTING_CONTROL,
> >>  		  host_bridge->native_cxl_error);
> >>  
> >> +	dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
> >> +		 FLAG(host_bridge->native_shpc_hotplug),
> >> +		 FLAG(host_bridge->native_pcie_hotplug),
> >> +		 FLAG(host_bridge->native_pme),
> >> +		 FLAG(host_bridge->native_aer),
> >> +		 FLAG(host_bridge->native_dpc),
> > 
> > I think the native_dpc printed here is inaccurate if booted with
> > "pci=dpc-native", isn't it?
> 
> Yes, it is inaccurate.  "pcie_ports=dpc-native" has never set
> native_dpc, but this patch is the first to print it, so I will fix it
> here.
> 
> I will fold it into the same override block, so both parameters go
> through the control mask and get logged the same way, something like:
> 
> 	u32 override = 0;
> 
> 	if (pcie_ports_native)
> 		override = OSC_PCIE_PORT_SERVICE_CONTROLS & ~ctrl;
> 	else if (pcie_ports_dpc_native)
> 		override = OSC_PCI_EXPRESS_DPC_CONTROL & ~ctrl;
> 
> 	if (override) {
> 		decode_osc_control(root, pcie_ports_native ?
> 				   "OS forcing control (\"pcie_ports=native\") of" :
> 				   "OS forcing control (\"pcie_ports=dpc-native\") of",
> 				   override);
> 		ctrl |= override;
> 	}

Sounds good.

> > The DPC probe handling still seems kind of convoluted.  In portdrv.c,
> > we have this:
> > 
> >   get_port_device_capability()
> >   {
> >     if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> > 	pci_aer_available() &&
> > 	(pcie_ports_dpc_native || host->native_aer))
> > 	    services |= PCIE_PORT_SERVICE_DPC;
> > 
> > And then we have this in dpc.c:
> > 
> >   dpc_probe()
> >   {
> >     if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
> > 	    return -ENOTSUPP;
> > 
> > The combination of get_port_device_capability() and dpc_probe() makes
> > my head hurt.
> > 
> > It seems like the DPC clause of get_port_device_capability() should be
> > parallel to the AER clause, i.e., set PCIE_PORT_SERVICE_DPC if the
> > device has a DPC Capability and the OS owns DPC (host->native_dpc).
> > Anything other than that needs explanation.
> > 
> > I'm confused about why host->native_dpc is not involved in the
> > dpc_probe() path at all.
> 
> Agreed, DPC should be decided on its own, independent of AER.  Today it
> is tied to AER in several places:
> 
> 1. portdrv binds DPC on host->native_aer, not native_dpc, following
>    the PCIe r7.0 sec 6.2.11 implementation note that links DPC control
>    to AER control (97ca178c899d).
> 2. The pci_aer_available() test in the same clause means "pci=noaer"
>    also disables DPC.
> 3. dpc_probe() repeats the ownership check via pcie_aer_is_native(),
>    which also tests dev->aer_cap, so DPC never binds on ports without
>    an AER Capability.
> 4. native_dpc is only consumed by pci_dpc_recovered().
> 
> With the change above, both "pcie_ports=native" and
> "pcie_ports=dpc-native" set native_dpc, so binding on native_dpc would
> work for them.  The problem is the default case, with no "pcie_ports="
> parameter.  We only request OSC_PCI_EXPRESS_DPC_CONTROL when
> CONFIG_PCIE_EDR=y, as the PCI Firmware spec requires, so on an EDR=n
> kernel native_dpc is never set on ACPI systems.

Right, I forgot about that.  This deserves a comment in the code
somewhere.

I think we still need to be able to use DPC without EDR on non-ACPI
systems.

> Today DPC still binds there through native_aer, and switching
> portdrv to test native_dpc alone would silently turn DPC off on
> those systems.

It would be nice if we could make native_dpc be the end result of AER,
EDR, and anything else that determines whether the OS can actually use
DPC.

> I think the simplest fix is to make PCIE_DPC "select PCIE_EDR if ACPI",
> so an ACPI kernel with DPC always negotiates DPC control and native_dpc
> reflects what firmware actually granted.  Then portdrv can bind DPC on
> "DPC Capability && native_dpc", just like the AER clause.
> 
> Lukas has posted a series that removes the DPC/AER dependency:
> 
>   https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
> 
> His 1/7 lets DPC work without an AER Capability, and 2/7 removes the
> dpc_probe() check entirely, so portdrv becomes the only place that
> decides.  The native_dpc change fits naturally on top of that.
> 
> Would you like me to do the native_dpc change in this series, or as a
> separate patch on top of Lukas's series?  If we do it as a separate
> patch on top of Lukas's work, this series can stay a cleanup (plus the
> fix for Guixin's issue).

Doing it on top of Lukas's series sounds good to me.
