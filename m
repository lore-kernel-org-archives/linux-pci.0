Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64486 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752260AbaBRTh3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 14:37:29 -0500
Date: Tue, 18 Feb 2014 19:36:54 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140218193654.GK2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <20140218185947.GA22340@obsidianresearch.com>
 <20140218190929.GF2010@mudshark.cambridge.arm.com>
 <1411925.bMiMyFpUnW@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411925.bMiMyFpUnW@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 07:32:33PM +0000, Arnd Bergmann wrote:
> On Tuesday 18 February 2014 19:09:29 Will Deacon wrote:
> > 
> > > Regarding the 0x6200.. There are two conflicting issues there 
> > >  - You really don't want to let the PCI core assign resources to that
> > >    range, it probably won't work.
> > 
> > Right, with kvmtool we don't support resource assignment (the BARs are fixed)
> > so everything is PCI_PROBE_ONLY.
> 
> Ok, I looked at the source now and can confirm:
> 
> * 0x0-0x1000 are used for lots of legacy ISA devices.
> * PCI devices get assigned IO addresses in 0x400 steps starting at 0x6200.
> * There are three PCI drivers doing this: VESA, PCI-SHMEM and virtio-pci.
> 
> Regarding the PCI_PROBE_ONLY flag, how do you set that? Should we
> have a standard DT property for that? On PowerPC we already specified
> "linux,pci-probe-only" and "linux,pci-assign-all-buses", which seems
> reasonable to use in architecture independent code as well.

For arch/arm/ it's done on the command line (pci=firmware) but yes, for the
generic driver it sounds like a good idea to put this in the device-tree.
I'll look at adding the ppc properties in the next version.

Cheers,

Will
