Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbdJKRVS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 13:21:18 -0400
Date: Wed, 11 Oct 2017 12:21:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: Re: PCIe error reporting
Message-ID: <20171011172113.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
 <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00911C9@AcuExch.aculab.com>
 <20171011132525.GF25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009155B@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009155B@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 04:00:04PM +0000, David Laight wrote:
> From: Bjorn Helgaas
> > Sent: 11 October 2017 14:25
> ..
> > The current Linux behavior is based on the spec I cited above, which
> > says
> > 
> >   If any bits in the Control Field are returned cleared (masked to
> >   zero) by the _OSC control method, the respective feature is
> >   designated unsupported by the platform and must not be enabled by
> >   the operating system. Some of these features may be controlled by
> >   platform firmware prior to operating system boot or during runtime
> >   for a legacy operating system, while others may be
> >   disabled/inoperative until native operating system support is
> >   available.
> 
> That is a strange statement.
> 
> What an earth have 'legacy operating system' and 'native operating
> system' got to do with whether the ACPI features can be enabled.
> How are we supposed to write the os support if the features are
> disabled until it is available!

I wasn't involved in writing that spec, but my guess is that some
platforms want to do AER logging themselves, in a consistent way
regardless of what OS is running or whether that OS has AER support.
That means there has to be some way to coordinate control of the AER
registers between the platform (BIOS) and the OS, and _OSC is the ACPI
way to do that.

Linux should be setting OSC_PCI_EXPRESS_AER_CONTROL to request control
of AER, and apparently on your system the BIOS explicitly cleared that
bit to tell us "no, you're not allowed to use AER."  If the BIOS
cleared it unnecessarily, that's really a BIOS problem, not a Linux
problem.

It would be interesting to know what Windows does about AER on that
platform.  I would expect Windows to respect the platform's wishes as
expressed by _OSC, so if Windows does AER recovery, there might be a
problem in the way Linux uses _OSC.
