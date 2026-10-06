Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688737F8CC;
	Tue,  6 Oct 2026 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309081; cv=none; b=eKVFN8xkP2LuMpEFV8jDT9DD7il9wfIUDg5zz8EakoCsT/4ZamiR4Zq1qa2BYFARNFMdhlvuVH8LvhurThOVvZed1eyPaikv/1r7vYh0planXEAs3Zmn0k4KWRlr3M8YRx7kovXkj/3J4pchq+PN4LIMUgwfiqCWWUEd0n2hjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309081; c=relaxed/simple;
	bh=YCIWOEMqw5vnxpxLy0Thc2k827fNlKN8XlUl9ggovKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NXtxueMVCi5V81on3pkNyoPbDURGshuxmM0BFWrarduqv3DP8unN7BJCYLVBFW/jCDNYlzN3J5R1GMwRNOXjGoI4mR2KM8735EkfiodSJA8gPAllDjWg6k9IkcxPXfp0Owqa3jFr+Cm3Gc+t4yQmmPSSYoA6/jA+OoG3hQzTDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io9suqr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io9suqr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477F41F0089B;
	Tue,  6 Oct 2026 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309079;
	bh=DLzFusgAR+EaFuTDmWuvGcyuHWPBSJyvcNUT9zpN7iA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Io9suqr9xmCwO2tHoXRfPwutODp7EkqpvTEOu5g7TjKNSWZ6BfdPc18d8OJARyHHR
	 CfWhD2m4h4+JXYJpOcWlRFKP64xrNjEDT5PhSK47umJCpLkU+frVU5NB+JTmFrActV
	 P+6t1ShAuksUOF3tRx0hBWqGM2Gs+1xAFRFiH7Jj2egkkE38d+9VwREj61HZri8wsM
	 MfewaHQ1yjzD2l9qGQB661nt/CCvE0Mn1ByjKTE9gkPcKBWvrfTp2+PboPv2AOqTbJ
	 Bn0xrLOcELJ26AkaKFYDdxQYSauYolUwtAIfFxe44hegLvZ9I/VYIzx1vnvT5qyKBY
	 5du1VXDL9UFgw==
Date: Tue, 6 Oct 2026 12:51:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, lukas@wunner.de, terry.bowman@amd.com,
	kanie@linux.alibaba.com, olof@lixom.net
Subject: Re: [PATCH v15 0/4] Simplify PCIe native ownership
Message-ID: <20261006175118.GA695965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Fri, Oct 02, 2026 at 02:18:24PM -0700, Kuppuswamy Sathyanarayanan wrote:
> This revives Bjorn's v12 from November 2020, rebased onto v7.3-rc3.
> 
>   https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/
> 
> The goal is unchanged.  Decide who owns each PCIe port service in one
> place, when we interpret the _OSC results in acpi_pci_root_create(), so
> that everywhere else only has to look at host_bridge->native_X.  For AER
> specifically, host_bridge->native_aer becomes the single answer to the
> question "may Linux touch the AER Capability?".  Today callers each have
> to remember to also test pcie_ports_native and pci_aer_available().
> 
> I posted v11.  Bjorn took it over at v12, split the _OSC changes in two
> and deferred the "pcie_ports=dpc-native" work.  The v12 review comments
> were agreed but never respun, and the series stalled.  v13 was that
> respin.
> 
>   https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com [v11]
> 
> Bjorn suggested reviving it in response to Guixin Liu's report that
> "pcie_ports=native" no longer enables DPC.  The DPC service binds on
> host_bridge->native_aer, and that flag did not reflect the command line,
> so DPC stayed off when firmware retained AER control.  Patch 3 fixes it
> by making the flag reflect it.
> 
>   https://lore.kernel.org/linux-pci/20260901064554.2178688-1-kanie@linux.alibaba.com/
> 
> Patch 3 has a side effect worth calling out.  drivers/cxl/core/ras.c did
> not exist in 2020 and tests host_bridge->native_aer with no
> pcie_ports_native fallback, so it has been quietly ignoring
> "pcie_ports=native".  Centralizing the check fixes that.
> 
> Binding the DPC service on host_bridge->native_dpc, rather than on
> native_aer, is left for a separate patch on top of Lukas's series that
> removes the DPC/AER dependency, as agreed with Bjorn.  That change
> alters behavior, so it does not belong in this cleanup.
> 
>   https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
>   https://lore.kernel.org/r/20261001221408.GA2731929@bhelgaas
> 
> Changes since v14:
>   * Patch 3: fold "pcie_ports=dpc-native" into the _OSC control mask as
>     well, so host_bridge->native_dpc and the "OS native features" line
>     reflect it (Bjorn).
>   * Picked up Guixin's Reviewed-by on patch 3.
> 
> v14 posting
> https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com
> 
> Changes since v13:
>   * Lukas suggested dropping AER cap check fix (patch 1 of v13). He has
>     a series underway to fix it cleanly (removing DPC/AER dependency).
>     So dropped the patch as suggested.
>     https://lore.kernel.org/r/aq95LGUHL-pnmTlr@wunner.de
>   * Addressed use of IS_ENABLED(CONFIG_PCIEPORTBUS) instead of #ifdef
>     (Lukas).
>   * Added Fixes tag in patch 3 (Guixin Liu).
>   * Added Acks from Rafael.
> 
> v13 posting
> https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com
> 
> Bjorn Helgaas (1):
>   PCI: Centralize pci_aer_available() checking
> 
> Kuppuswamy Sathyanarayanan (3):
>   PCI: Assume control of portdrv-related features only when portdrv
>     enabled
>   PCI/ACPI: Tidy _OSC control bit checking
>   PCI/ACPI: Centralize pcie_ports_native checking
> 
>  drivers/acpi/pci_root.c           | 78 +++++++++++++++++++++++++------
>  drivers/pci/hotplug/pciehp_core.c |  2 +-
>  drivers/pci/pci-acpi.c            |  3 --
>  drivers/pci/pcie/aer.c            |  6 +--
>  drivers/pci/pcie/aer_cxl_rch.c    |  2 +-
>  drivers/pci/pcie/err.c            |  2 +-
>  drivers/pci/pcie/portdrv.c        |  7 ++-
>  drivers/pci/pcie/portdrv.h        |  2 -
>  drivers/pci/probe.c               | 10 ++--
>  include/linux/pci.h               |  2 +
>  10 files changed, 80 insertions(+), 34 deletions(-)

I put the first three patches on pci/portdrv for v7.4, thanks!

I deferred the last ("PCI: Centralize pci_aer_available() checking")
while we sort out the MSI/AER question, but I want to make sure we get
the rest in v7.4.
