Return-Path: <SRS0=GjYO=JP=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=GjYO=JP=netronome.com=jakub.kicinski@kernel.org>
Date: Fri, 29 Jun 2018 13:20:04 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 alexander.duyck@gmail.com, oss-drivers@netronome.com, Christoph Hellwig
 <hch@infradead.org>, Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH] PCI: reset driver SR-IOV state after remove
Message-ID: <20180629132004.5cd6eef0@cakuba.netronome.com>
In-Reply-To: <20180629200934.GB40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180618220142.16527-1-jakub.kicinski@netronome.com>
	<20180629200934.GB40928@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 29 Jun 2018 15:09:34 -0500, Bjorn Helgaas wrote:
> On Mon, Jun 18, 2018 at 03:01:42PM -0700, Jakub Kicinski wrote:
> > Bjorn points out that currently core and most of the drivers don't
> > clean up dev->sriov->driver_max_VFs settings on .remove().  This
> > means that if a different driver is bound afterwards it will
> > inherit the old setting:
> > 
> >   - load PF driver 1
> >   - driver 1 calls pci_sriov_set_totalvfs() to reduce driver_max_VFs
> >   - unload PF driver 1
> >   - load PF driver 2
> >   # driver 2 does not know to call pci_sriov_set_totalvfs()
> > 
> > Some drivers (e.g. nfp) used to do the clean up by calling
> > pci_sriov_set_totalvfs(dev, 0), since 0 was equivalent to no driver
> > limit set.  After commit 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers
> > to limit total_VFs to 0") 0 no longer has this special meaning.
> > 
> > The need to reset driver_max_VFs comes from the fact that old FW
> > builds may not expose its VF limits to the drivers, and depend on
> > the ability to reject the configuration change when driver notifies
> > the FW as part of struct pci_driver->sriov_configure() callback.
> > Therefore if there is no information on VF count limits we should
> > use the PCI capability max, and not the last value set by
> > pci_sriov_set_totalvfs().
> > 
> > Reset driver_max_VFs back to total_VFs after device remove.  If
> > drivers want to reload FW/reconfigure the device while driver is
> > bound we may add an explicit pci_sriov_reset_totalvfs(), but for
> > now no driver is doing that.
> > 
> > Fixes: 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers to limit total_VFs to 0")
> > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>  
> 
> Applied to for-linus for v4.18, thanks!

Awesome, thanks a lot!
