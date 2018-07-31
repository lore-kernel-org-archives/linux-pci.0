Return-Path: <SRS0=sYJ9=KP=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=sYJ9=KP=h08.hostsharing.net=foo00@kernel.org>
Date: Tue, 31 Jul 2018 23:22:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Deduplicate presence check on probe &
 resume
Message-ID: <20180731212253.GA26620@wunner.de>
References: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
 <f9c36223a126c86ecc7dc921f8f943d29926edc3.1532754355.git.lukas@wunner.de>
 <20180731080342.GA2534@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731080342.GA2534@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 31, 2018 at 11:03:42AM +0300, Mika Westerberg wrote:
> On Sat, Jul 28, 2018 at 07:22:00AM +0200, Lukas Wunner wrote:
> One small nit, see below:
> 
> > +/**
> > + * pciehp_check_presence() - synthesize event if presence has changed
> 
> You should document the argument as well so that the tool that is used
> to process these knows about it:
> 
>   @ctrl: ....

Right, I'll fix that up in a follow-up commit since Bjorn has already
pushed this version.

@Bjorn: I've double-checked all the rebased and newly applied patches
on the pci/hotplug branch, looks good.  Thanks for adding the reference
to the "Link Status Mapped to the LTSSM" table to the commit message,
and thanks to Sinan for pointing that table out.

Superb job everyone, thanks a lot!

Lukas
