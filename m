Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60442 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbcBAVNB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Feb 2016 16:13:01 -0500
Date: Mon, 1 Feb 2016 15:12:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160201211258.GD4861@localhost>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org>
 <20160129230645.GG12965@localhost>
 <56AC0065.5030909@codeaurora.org>
 <20160130133027.GA16394@localhost>
 <20160201152507.GA30869@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160201152507.GA30869@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 01, 2016 at 03:25:07PM +0000, Lorenzo Pieralisi wrote:
> On Sat, Jan 30, 2016 at 07:30:27AM -0600, Bjorn Helgaas wrote:
> 
> [...]
> 
> > > Most non-UEFI firmwares I have seen on ARM rely on device specific
> > > driver like synopsys etc. to do the device initialization and ask
> > > kernel to do the enumeration.
> > > 
> > > ACPI systems on the other hand handle the resource assignment before
> > > the OS starts.
> > 
> > My guess is that this is more of a tradition than anything actually
> > required by the spec.
> 
> I share your opinion, and that tradition on ARM64 should be built
> on top of existing DT based systems where the bootloader assigns
> *NOTHING* in 90% of designs.
> 
> That's why I want to see resource claiming carried out by default
> on ACPI on ARM64, this would foster the tradition :), hopefully.
> 
> > The bottom line is that Linux can't rely on much consistency across
> > the universe of architectures and firmwares.  I think the only thing
> > that really makes sense for us to do is:
> > 
> >   - Read whatever assignments the firmware may have made
> >   - Keep them unchanged if they seem sensible
> 
> Here I take "sensible" as "it can be successfully claimed" - ie the resource
> is allocated in a valid way, though it may not be optimal (eg bridge window
> apertures).

Yes.  But even if platforms assign resources in a way they can be
successfully claimed, I don't think platforms should rely on that
assignment being unchanged.  For example, even if the boot-time
configuration is valid, the kernel may need to move things around to
deal with hotplug.  I know we don't really do that today, but I think
we should be able to do it in principle.

Bjorn
