Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29A3822AB;
	Fri, 18 Sep 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763366; cv=none; b=HgDZ7neCegRQ0+MxRs0KsF9qDK9pARQNUvTEOxuS7ZpV1Br+MgWu0sK2N/cyQCbbHPF7eRzsEe9PCD2BFXZ5wtVmIHobCZUh2XwITmTMMqeeUAfUvFVfC/+DXFKrH4fX2xamWs8BMmkpmJWK2XhIrW3PsMDwP34hVRHf+VDxL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763366; c=relaxed/simple;
	bh=QSPlHzjfqGQHz5rYsLmYmjhWMFsDZLXBK8ZbBsuZT4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RGBbUd+QezIdDdhQlF2MlJqWj4g3uDh8pw+cY4wviGx0M2qYOdiURYiSYsckmV6n0nWxx9NWVWKGo2kGhabhyBT+35KYiH/88FOsyT6nWQOQpJGCk6Fojsw4WKsEax26d0JovNxDWJUixNv0vEqOpt1g+y3GWSQnhvMHZJ6psaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPX8YLEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPX8YLEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720D21F000FF;
	Fri, 18 Sep 2026 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789763363;
	bh=0JsPjrcrxVszax6GzSwyEEMk274SAvTkKeqYWmVA7/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZPX8YLEqSW7OEBK5foj4Z40rjGX4pZyBjaejyk2vJB9dXeIxQxrrmYHYBVZtnE6KR
	 SR7LTNWIXgYEb4jEMSNX4QlFTbkEvqN89TN7DAz3kEOzIHYT70n2xhlYZbvW12kuky
	 jpR1ZYVus2nSwT/Gr5G2OEWFDLD81yh8FVVGbxzZFEpQFfKponNDPUEchkc8XLKhQM
	 vqS74uVApCxC5sYj8IzI6mcFuU1l3oTTT934CudENH5vXEga8LbrSKWr2rWuMHpj7l
	 KTc43zBhbdE79buJqcDFA3qNPTO00WbuJKreSOFnu6FRYaYc4gLocjcwkuKCHCMyop
	 yo1unuLtM5T5Q==
Date: Fri, 18 Sep 2026 15:29:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
Cc: bhelgaas@google.com, eduardo.habkost@lambdal.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bilbao@vt.edu
Subject: Re: [PATCH] PCI/ASPM: Don't reconfigure ASPM entering low-power state
Message-ID: <20260918202922.GA1192452@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507214914.GA22065@bhelgaas>

On Thu, May 07, 2026 at 04:49:14PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 27, 2026 at 09:01:04PM -0700, Carlos Bilbao (Lambda) wrote:
> > From: Carlos Bilbao <carlos.bilbao@kernel.org>
> > 
> > Reconfiguring ASPM when a device transitions to low-power state can enable
> > L1.1/L1.2 substates on the PCIe link at a time when the device is sleeping
> > and may be unable to exit them. ASPM should be reconfigured on D0 entry
> > (resume), not on the way down.
> > 
> > pci_set_low_power_state() calls pcie_aspm_pm_state_change() after writing
> > D3hot to PCI_PM_CTRL. pcie_aspm_pm_state_change() resets link->aspm_capable
> > to link->aspm_support and then calls pcie_config_aspm_path(), which can
> > enable ASPM L1.1/L1.2 substates on the PCIe link. If the device cannot
> > recover the link from L1.2 while in D3hot, subsequent config space reads
> > return 0xFFFF ("device inaccessible") and pci_power_up() fails with message
> > "Unable to change power state from D3hot to D0, device inaccessible".
> > 
> > This was observed on NVIDIA H100 SXM5 GPUs bound to vfio-pci when Linux
> > runtime PM suspends them to D3hot: the GPU becomes permanently inaccessible
> > and disappears from the PCIe bus.
> > 
> > The call to pcie_aspm_pm_state_change() in pci_set_low_power_state() was
> > restored by commit f93e71aea6c6 ("Revert "PCI/ASPM: Remove
> > pcie_aspm_pm_state_change()""), which reverted
> > commit 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()").
> > The revert was necessary because the
> > removal broke suspend/resume on certain platforms that required ASPM to be
> > reconfigured on D0 entry. However, the revert restored the call in both
> > pci_set_full_power_state() (D0 entry) and pci_set_low_power_state()
> > (low-power entry).
> > 
> > Only the D0-entry call is needed to fix the suspend/resume regression. The
> > low-power-entry call is harmful: reconfiguring ASPM immediately after
> > putting a device into D3hot can enable link substates that the device or
> > platform cannot exit while the device is sleeping.
> > 
> > Remove the pcie_aspm_pm_state_change() call from pci_set_low_power_state().
> > ASPM will still be reconfigured correctly when the device returns to D0 via
> > pci_set_full_power_state().
> > 
> > Fixes: f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
> > Link: https://lore.kernel.org/r/20240102232550.1751655-1-helgaas@kernel.org
> > Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
> 
> Applied to pci/aspm for v7.2, thanks!
>
> > ---
> >  drivers/pci/pci.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b2ccb8e122f2..8b47887019f9 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1542,9 +1542,6 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
> >  				     pci_power_name(dev->current_state),
> >  				     pci_power_name(state));
> >  
> > -	if (dev->bus->self)
> > -		pcie_aspm_pm_state_change(dev->bus->self, locked);

While backporting this, Sashiko noticed that "locked" is no longer
used and could possibly be removed from the set_low_power paths.  I
guess ASPM needs "locked" because it holds pci_bus_sem while
evaluating all the devices in the path to the device, but since we're
not touching ASPM in the set_low_power path, we don't need that.

> >  	return 0;
> >  }
> >  
> > -- 
> > 2.50.1 (Apple Git-155)
> > 
