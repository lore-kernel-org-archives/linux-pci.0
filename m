Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A7382F02;
	Wed, 10 Jun 2026 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121776; cv=none; b=u0LdC7PWOBbMdi4uxFbaw2fSzQlpu/7CTPKw0RbUzHc2wyI0SgiMImUveNjhDvVZUXRozy7msz7HHct3iKnMkdgt8uPBFesSgmznlh5ptvzTZoJ+1OWrE1MsOjd2AMMB5CXJ0e1/zzeWw86IfcCj31+8FdRC3IU/PX9l77I/FO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121776; c=relaxed/simple;
	bh=t1VmgNxhsaiU4iG7UlrS/CTtMYDXGou3AaqQ4fhOpYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Avf88pZJW4eTpREmgvsajFUxVFcV8+6UNK7nSWOSA3vAlwqPYyEaeYYJdlDqWIVtqu48hL+swrMDK8EDNJKtkrW9HupAJTfVkMq82Qe63C+LLaW6KycBlE5n/3MzlSDDbvuJmGTl6TX3eFKAZyRhdanM0qYJ8LryKWe7bByKZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB53BSqe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB53BSqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A21F00893;
	Wed, 10 Jun 2026 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121771;
	bh=uRGQIyb9ARwTpGn1WEGsKF1aAKDl7J7N9Qf6rWa6PLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VB53BSqeMT446JXcotrdCP41NslvjEbD28DsBMhPSxapvK87BwAUU/3kJPNpdMSj7
	 uz3y6YLzj3tV22LVlpBq2vcRbpzBtJ8ySAQmI3/bfD/XARSVVtTUs2k/y1nvVUFkjZ
	 lvIkapTsSqSE/6KUel9/2sBpVfrz+5h1DMliFe9jDDUB0LBVtK+euo9+JTEMnGgziE
	 l+iHBiK7XCKjoDhEXD0dCoHaUw25bswR/iwjTkUsPw94KBx/S/weNMZBydzKxSrBfq
	 Wu3psySJe3/7iMq9jMxKKbbDYQd4QDm7XvwTC04ABGGp3Ea7OJ3CtxJEQ2WrShpNV7
	 qfC3Iw/JwUmTQ==
Date: Wed, 10 Jun 2026 15:02:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
Message-ID: <20260610200249.GA388221@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cb5988-ce72-4acf-8e1c-0eb72b4fbd41@linux.ibm.com>

[+cc Alex]

On Wed, Jun 10, 2026 at 09:51:55AM -0700, Farhan Ali wrote:
> On 6/9/2026 3:33 PM, Bjorn Helgaas wrote:
> > On Wed, Jun 03, 2026 at 06:57:36PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > 
> > > Pre-existing issues:
> ...

> > > > +++ b/drivers/pci/pci.c
> > > > @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
> > > >   	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
> > > >   		return -ENOTTY;
> > > > +	if (!pci_dev_config_accessible(dev, "FLR"))
> > > > +		return -ENOTTY;
> > > > +
> > > [Severity: High]
> > > This isn't a bug introduced by this patch, but does placing this
> > > check in pcie_reset_flr() leave direct callers of pcie_flr()
> > > exposed to 60-second hangs?
> > > 
> > > Direct callers of pcie_flr() (like network and storage drivers
> > > during error recovery) bypass this wrapper. They will still
> > > experience a stall in pci_dev_wait() when attempting to reset a
> > > device with an inaccessible config space. Should this
> > > accessibility check be moved into pcie_flr() instead to protect
> > > all callers?
> >
> > I can't remember why we have both pcie_reset_flr() and pcie_flr(),
> > other than the fact that callers don't need to supply a "probe"
> > argument to pcie_flr().
> > 
> > Is there a reason to call pci_dev_config_accessible() here rather
> > than in pcie_flr()?
> 
> The reason we wanted the check in pcie_reset_flr() was so to be able
> to escalate to bus reset method if we can't do an FLR. I think the
> check could be moved to pcie_flr(). Is that more preferable?

What if we added a preliminary patch that folds the body of pcie_flr()
into pcie_reset_flr() and adds:

  #define pcie_flr(dev)	pcie_reset_flr(dev, PCI_RESET_DO_RESET)

That would mean pcie_flr() users would start paying attention to
PCI_DEV_FLAGS_NO_FLR_RESET and PCI_EXP_DEVCAP_FLR, which seems like a
good thing.
