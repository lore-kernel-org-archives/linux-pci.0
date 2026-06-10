Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF2356773;
	Wed, 10 Jun 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119172; cv=none; b=c74poGqhk0jSFGuDdi7fHuGd8VHSVlvXuTXrvBluG3TkPlpBeLnZKUMNBXHLBYWB2QJ0LDAeF8FUIdAhYB5UTbWBTCJL7kIKP63vMj6SHw+3B4jNv3mdQRGZdHP6wX7XJaMGdL43MC+siCdvGFhra68xTRrtJUrR5jr/tpIiPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119172; c=relaxed/simple;
	bh=+ohC2m3lunPe2kDC19X2zynsTw4zYYR9U8nZ3UMjr/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZRQb2lQsWIMybiwv54D+j6rcfYFYmtg+9PCRYrIcfnMh0ihdyHRJRl4vf1y80ox3tA0G9s/b7hg7f29R2b1XTYRVi6pIT8RvuxEGnTSCr76ys0w6J+ZIUamW4viUYpVw6XCWaE/Ix9gp6xSymPpdmqxd69mCtBSB0G8qMEoFVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2q2jUNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2q2jUNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566701F00893;
	Wed, 10 Jun 2026 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781119170;
	bh=u+OFX4ShvIerpDOzkkMG4kqhjwCu9CbuQ9Bmbry73tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=K2q2jUNomfj2HJhbM3mQRyVWTlOWEa5HLmho6mBUc21MLPhjptzkIzoUnDORuyXJU
	 sWU5ChG1T/NU2ot9x/e9gzcptCrPW4abiaV6B9mxJiAIxuurHA0zNzoJXQpwCL6GvR
	 XPT1Dm44aiPi99Py+y7O9tS7Dgc/eR9IjF1WRAeOz/MI5MgJdzzBSPNF0oMNupaK2o
	 EWHooUGlVhqt5OQYPHlROi16pgw0loQenJNgWC/RYZq/Eyt+vzdurlgZ/bMUjG+Ez2
	 wcReK9Jy0rCIpnymTuIO8Ubqgl9gSy6Td2VkN+KKf4pusf0u/czL+8v1+EdI7DLs71
	 GdsWDK/gi36tA==
Date: Wed, 10 Jun 2026 14:19:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 1/3] PCI: Add d3cold as general reset method
Message-ID: <20260610191929.GA196607@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603112018.97AA41F00893@smtp.kernel.org>

[+cc Rafael, D3cold->D0 delays]

On Wed, Jun 03, 2026 at 11:20:18AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] pci_d3cold_reset() fails to wait for device readiness after transitioning from D3cold to D0, leading to immediate config read failures and state corruption.
> - [High] pci_d3cold_reset() does not prevent execution on single-function bridges, leading to permanent state corruption and physical data loss of all subordinate devices.
> --
> 
> commit c7a8523521475c131fd83bc43a00b0cc028fc9a1
> Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> 
> PCI: Add d3cold as general reset method
> 
> This patch adds D3cold power cycling as a reset method for single-function
> devices via ACPI _PR3, placing it at the end of the reset hierarchy.
> 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8f7cfcc000901..096868f80cd4c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> 
> [ ... ]
> 
> > +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> > +{
> > +	int ret;
> > +
> > +	if (dev->multifunction)
> > +		return -ENOTTY;
> > +
> 
> [Severity: High]
> Does this allow execution on single-function bridges, such as PCIe Root
> Ports?
> 
> If pci_set_power_state(dev, PCI_D3cold) is called on a bridge, it recursively
> updates all subordinate devices' tracking state to D3cold via
> __pci_bus_set_current_state() and physically removes power from them.
> 
> The subsequent transition back to D0 only updates the bridge itself. This
> leaves all downstream devices tracked as PCI_D3cold indefinitely, and they
> lose all their configuration and BARs since the reset framework only saves
> and restores the bridge's configuration state. 

Secondary Bus Reset has a similar issue: the hot reset on the
secondary side is propagated to downstream devices.
pci_parent_bus_reset() returns -ENOTTY if we try to use SBR to reset a
bridge.  I wonder if that check should be moved up to
pci_reset_bus_function() we don't try to use pci_reset_hotplug_slot()
on bridges either.

So I think it *is* a problem if we put a bridge in D3cold because
that's also a reset of any downstream devices.

> > +	if (!pci_pr3_present(dev))
> > +		return -ENOTTY;
> > +
> > +	if (probe)
> > +		return 0;
> > +
> > +	if (dev->current_state != PCI_D0)
> > +		return -EINVAL;
> > +
> > +	ret = pci_dev_reset_iommu_prepare(dev);
> > +	if (ret) {
> > +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = pci_set_power_state(dev, PCI_D3cold);
> > +	if (ret)
> > +		goto done;
> > +
> > +	ret = pci_set_power_state(dev, PCI_D0);
> 
> [Severity: High]
> Does this sequence fail to account for the mandatory wait time before the
> device is responsive to config space accesses?
> 
> A D3cold to D0 transition acts as a fundamental reset. pci_set_power_state()
> internally invokes pci_power_up(), which applies power and immediately
> attempts to read PCI_PM_CTRL without waiting for link training or handling
> Configuration Request Retry Status (CRS).

I don't think sashiko can infer this from the code, but my
understanding is that platform_pci_set_power_state(PCI_D0) is
responsible for delays after a D3cold -> D0 transition, so I don't
think this one is actually an issue:

  https://lore.kernel.org/all/CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com/

> Because the device is unready, this read can return 0xFFFF (Unsupported
> Request) and cause pci_power_up() to spuriously fail with -EIO. Should this
> include a polling delay, similar to pci_dev_wait(), to prevent the reset
> framework from blindly failing or restoring state to an uninitialized device?
> 
> > +
> > +done:
> > +	pci_dev_reset_iommu_done(dev);
> > +	return ret;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260603105853.326290-1-jtornosm@redhat.com?part=1
