Return-Path: <SRS0=1drt=EV=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=1drt=EV=intel.com=keith.busch@kernel.org>
Date: Fri, 26 Jan 2018 16:15:58 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH 0/8] PCI/DPC: Simplify RP PIO logging
Message-ID: <20180126231558.GA21531@localhost.localdomain>
References: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 26, 2018 at 04:55:30PM -0600, Bjorn Helgaas wrote:
> These are almost all just cleanups.  
> 
> The only behavior change I intend is this: If a port does not support
> the "RP Extensions for DPC" and it reports an "RP PIO error", we
> previously read the RP PIO log registers.  I don't know if that's a
> legal situation, but I couldn't find an explicit prohibition in the
> spec.
> 
> Anyway, the rest is all cleanups and simplifications that are not
> intended to change any behavior.
> 
> These are currently on my pci/dpc branch [1] on top of patches 3 and 5
> from your v2 series [2], Keith:
> 
>   6b9045b34b57 PCI/DPC: Fix interrupt message number print
>   eed85ff4c0da PCI/DPC: Enable DPC only if AER is available
> 
> Your patch 1 ("PCI/AER: Return correct value when AER is not
> supported") is on pci/aer.  Patches 2 and 4 go together and I think
> you're still working on those.
> 
> You don't need to worry about integrating your work with these
> patches; I'm just kibbitzing and will drop these completely if you
> don't like them, or I'll take care of putting the pieces back together
> if you do.

No problem at all. I happened to pull your tree a few moments before you
posted this series, so I had a head start reviewing it. I'm happy with
the cleanups, and this doesn't trip up the updates I'm working on. I'm ok
to base the remaining DPC updates on this if you want to move it forward:

Reviewed-by: Keith Busch <keith.busch@intel.com>

I do need to merge pci/dpc with pci/aer to complete the rest of my DPC
updates, and there is a trivial merge conflict, but no biggie.
