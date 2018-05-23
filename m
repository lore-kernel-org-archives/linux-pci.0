Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934181AbeEWTxZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 15:53:25 -0400
Date: Wed, 23 May 2018 14:53:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: pci=earlydump on ARM
Message-ID: <20180523195322.GC150632@bhelgaas-glaptop.roam.corp.google.com>
References: <bug-199671-164391@https.bugzilla.kernel.org/>
 <bug-199671-164391-E4Mtn0How4@https.bugzilla.kernel.org/>
 <9756cf4c-0cec-00f7-3cc6-f09e34177cf9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9756cf4c-0cec-00f7-3cc6-f09e34177cf9@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 03:10:39PM -0400, Sinan Kaya wrote:
> > If that doesn't work or you'd rather brute-force it, you could try
> > doing something like "pci=earlydump".  This is currently only
> > implemented for x86, so it would be some work to implement something
> > similar for arm64.  It would be a nice upstream addition if you *did*
> > implement it.
> > 
> > In the earlydump output I would be looking for clues about the power
> > state of 03:00.0 to try to figure out if the bootloader left it powered
> > off or if Linux is doing something to turn it off.
> > 
> 
> Is it really possible to implement a generic version of this?
> 
> PCI on ARM64 is not really unified. There are several host bridge drivers
> for different types of access. 
> 
> If we limit the functionality to ACPI, the answer is still maybe if we
> can pass the base address of the MMCONFIG region. 
> 
> All products use a different MMCONFIG region.

On x86, early dump is implemented off to the side, outside the PCI
core, and it takes advantage of arch-specific knowledge about ways to
perform config accesses.

But I could imagine something in the pci_scan_device() area, where we
have the normal config accessors but we haven't yet touched the
device.  I think we could get 99% of the early dump utility in a
completely generic way.

There might be a few hand-crafted arch-specific quirks that touch PCI
devices even before that point, but those should be pretty rare.

Bjorn
