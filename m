Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947811A9F90;
	Thu, 11 Jun 2026 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205740; cv=none; b=M3dmWVK2S5sOW3yYPm/Ev7tR462PvD+3mmZJrdZByLn8Oo8rSIzqDexxTDvBLSxKP2b89fxHU64KvspMxx6nvKvvLueSlMaHEzE02HBZXryDb5c9O31vX76ar4I/lMrTa54RDb3Jc8gNwtMn/Sgeehe6QWDaKCVHBFZcQp8FqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205740; c=relaxed/simple;
	bh=Pw861pdoo9N09qehcEhnOhj3re8WkTipqy4nRRTkvec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EZT4qcPTWnhgIHRHobsxoIfeDoLms66bHFnNT8caBeINWCYCvmcrP6mZth3LuvPaMnaCfj8bmRybagZxdlW6WF41WsqnRkPtZ9QGfO3FwlpHD5+1tZRJUgSlmMe7c5pp/QrIwADkT9iYnghAOWZ5cTECFVongIxvrJ7EqvTl1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZPjhWmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZPjhWmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB6F1F000E9;
	Thu, 11 Jun 2026 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205739;
	bh=7DQIY84KMFU50PV58qAUhS5Ox7glBhIAQ2/U/d5tYmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WZPjhWmkVWOgcUQUloxfWNirt+HR6opFspwrA2OBJZ2CKgMomGFtNHH93XaGoMvb3
	 CpCMBxDXz+jFqJHo/BV3aEQz2o55ZBBQdyIlMi2D/496kvDm8HkXwEaW6qOutXLwXR
	 qxjQZwLsQcv3a4mKXR4qdfea9SYKfL4NT5QtJpT9PzV7nAvbvmNIBvMn5jQW0lMya6
	 SqQDK+BrGO4PBkfeIUF3GqEsF9Dl87EEPs9f+2pebR2FdqRuyTPHivhNpr4FVyLdrk
	 l8++yuq/VDSyVNujCCOaQbwBTk8dScqOcG6ilusHM0YOlNloaFWQfym4cE+yPpU7X1
	 yQmh8zU3CpXSg==
Date: Thu, 11 Jun 2026 14:22:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
Message-ID: <20260611192217.GA405982@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49059c51-e61b-48b2-81a9-2e164e0bd763@linux.ibm.com>

On Wed, Jun 10, 2026 at 02:56:48PM -0700, Farhan Ali wrote:
> On 6/10/2026 1:02 PM, Bjorn Helgaas wrote:
> > On Wed, Jun 10, 2026 at 09:51:55AM -0700, Farhan Ali wrote:
> > > On 6/9/2026 3:33 PM, Bjorn Helgaas wrote:
> > > > On Wed, Jun 03, 2026 at 06:57:36PM +0000, sashiko-bot@kernel.org wrote:
> > > > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > > > 
> > > > > Pre-existing issues:
> > > ...
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
> > > > > >    	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
> > > > > >    		return -ENOTTY;
> > > > > > +	if (!pci_dev_config_accessible(dev, "FLR"))
> > > > > > +		return -ENOTTY;
> > > > > > +
> > > > > [Severity: High]
> > > > > This isn't a bug introduced by this patch, but does placing this
> > > > > check in pcie_reset_flr() leave direct callers of pcie_flr()
> > > > > exposed to 60-second hangs?
> > > > > 
> > > > > Direct callers of pcie_flr() (like network and storage drivers
> > > > > during error recovery) bypass this wrapper. They will still
> > > > > experience a stall in pci_dev_wait() when attempting to reset a
> > > > > device with an inaccessible config space. Should this
> > > > > accessibility check be moved into pcie_flr() instead to protect
> > > > > all callers?
> > > >
> > > > I can't remember why we have both pcie_reset_flr() and pcie_flr(),
> > > > other than the fact that callers don't need to supply a "probe"
> > > > argument to pcie_flr().
> > > > 
> > > > Is there a reason to call pci_dev_config_accessible() here rather
> > > > than in pcie_flr()?
> > >
> > > The reason we wanted the check in pcie_reset_flr() was so to be able
> > > to escalate to bus reset method if we can't do an FLR. I think the
> > > check could be moved to pcie_flr(). Is that more preferable?
> >
> > What if we added a preliminary patch that folds the body of pcie_flr()
> > into pcie_reset_flr() and adds:
> > 
> >    #define pcie_flr(dev)	pcie_reset_flr(dev, PCI_RESET_DO_RESET)
> > 
> > That would mean pcie_flr() users would start paying attention to
> > PCI_DEV_FLAGS_NO_FLR_RESET and PCI_EXP_DEVCAP_FLR, which seems like a
> > good thing.
> 
> Looking at the history, it seems commit 56f107d7813f ("PCI: Add
> pcie_reset_flr() with 'probe' argument") added pcie_reset_flr() to
> add the probe and remove pcie_has_flr(). It also notes that callers
> of pcie_flr() that didn't call pcie_has_flr() remain. I guess it
> didn't want to change the drivers that called pcie_flr()
> unconditionally?

I think it's a mistake that we expose both pcie_reset_flr() and
pcie_flr() to drivers.  It's unnecessary complication and may lead to
pcie_flr() being used to work around device defects, e.g., the 82599
issue, without any explanation.

Ideally I think we should convert the dozen or so callers of
pcie_flr() to pcie_reset_flr().  Since they never called
pcie_has_flr(), they initiate an FLR without checking for FLR support,
so they *could* have the same defect as 82599, i.e., they don't
advertise PCI_EXP_DEVCAP_FLR but FLR does actually work.

So converting would be slightly risky but I think the number is small
enough to be manageable, though it would be out of scope for *this*
series, of course.

> There is also reset_intel_82599_sfp_virtfn() that mentions the need
> to FLR without checking for FLR support due to some quirk. So I
> wonder if there were genuine reasons to avoid doing the check for
> PCI_DEV_FLAGS_NO_FLR_RESET and PCI_EXP_DEVCAP_FLR?

Yes.  That device looks defective in that FLR is mandatory for PFs and
VFs and PCI_EXP_DEVCAP_FLR must be set, but it is not set for 82599
VFs.

When c763e7b58f71 ("PCI: add Intel 82599 Virtual Function
specific reset method") added reset_intel_82599_sfp_virtfn(),
pcie_flr() read PCI_EXP_DEVCAP to check for PCI_EXP_DEVCAP_FLR every
time it was called.

PCI_EXP_DEVCAP is a read-only register that is now cached in
dev->devcap by set_pcie_port_type(), and pcie_reset_flr() checks the
cached value for PCI_EXP_DEVCAP_FLR.

So I think reset_intel_82599_sfp_virtfn() could be reworked to be an
early quirk that sets PCI_EXP_DEVCAP_FLR in dev->devcap, instead of
being a device-specific reset method.  Then pcie_reset_flr() should
just work.
