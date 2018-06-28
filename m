Return-Path: <SRS0=ua9z=JO=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=ua9z=JO=netronome.com=jakub.kicinski@kernel.org>
Date: Thu, 28 Jun 2018 15:26:16 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>, oss-drivers@netronome.com,
 Christoph Hellwig <hch@infradead.org>, Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH] PCI: reset driver SR-IOV state after remove
Message-ID: <20180628152616.45eb59c0@cakuba.netronome.com>
In-Reply-To: <20180628221058.GD120578@bhelgaas-glaptop.roam.corp.google.com>
References: <20180618220142.16527-1-jakub.kicinski@netronome.com>
	<20180626094002.7bf0ca16@cakuba.netronome.com>
	<20180628135623.GE90450@bhelgaas-glaptop.roam.corp.google.com>
	<CAJpBn1weH828hgog5ZeBC+tAsWC54qoTtC2eLf6iF=+Gx0kmtw@mail.gmail.com>
	<20180628180705.GB120578@bhelgaas-glaptop.roam.corp.google.com>
	<20180628111457.15436685@cakuba.netronome.com>
	<20180628221058.GD120578@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Jun 2018 17:10:59 -0500, Bjorn Helgaas wrote:
> On Thu, Jun 28, 2018 at 11:14:57AM -0700, Jakub Kicinski wrote:
> > On Thu, 28 Jun 2018 13:07:05 -0500, Bjorn Helgaas wrote:  
> > > On Thu, Jun 28, 2018 at 09:17:09AM -0700, Jakub Kicinski wrote:  
> > > > On Thu, Jun 28, 2018 at 6:56 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > > On Tue, Jun 26, 2018 at 09:40:02AM -0700, Jakub Kicinski wrote:    
> > > > >> On Mon, 18 Jun 2018 15:01:42 -0700, Jakub Kicinski wrote:    
> > > > >> > Bjorn points out that currently core and most of the drivers don't
> > > > >> > clean up dev->sriov->driver_max_VFs settings on .remove().  This
> > > > >> > means that if a different driver is bound afterwards it will
> > > > >> > inherit the old setting:
> > > > >> >
> > > > >> >   - load PF driver 1
> > > > >> >   - driver 1 calls pci_sriov_set_totalvfs() to reduce driver_max_VFs
> > > > >> >   - unload PF driver 1
> > > > >> >   - load PF driver 2
> > > > >> >   # driver 2 does not know to call pci_sriov_set_totalvfs()
> > > > >> >
> > > > >> > Some drivers (e.g. nfp) used to do the clean up by calling
> > > > >> > pci_sriov_set_totalvfs(dev, 0), since 0 was equivalent to no driver
> > > > >> > limit set.  After commit 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers
> > > > >> > to limit total_VFs to 0") 0 no longer has this special meaning.
> > > > >> >
> > > > >> > The need to reset driver_max_VFs comes from the fact that old FW
> > > > >> > builds may not expose its VF limits to the drivers, and depend on
> > > > >> > the ability to reject the configuration change when driver notifies
> > > > >> > the FW as part of struct pci_driver->sriov_configure() callback.
> > > > >> > Therefore if there is no information on VF count limits we should
> > > > >> > use the PCI capability max, and not the last value set by
> > > > >> > pci_sriov_set_totalvfs().
> > > > >> >
> > > > >> > Reset driver_max_VFs back to total_VFs after device remove.  If
> > > > >> > drivers want to reload FW/reconfigure the device while driver is
> > > > >> > bound we may add an explicit pci_sriov_reset_totalvfs(), but for
> > > > >> > now no driver is doing that.
> > > > >> >
> > > > >> > Fixes: 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers to limit total_VFs to 0")
> > > > >> > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>    
> > > > >>
> > > > >> Any comments? :(  Could this still make it into 4.18?    
> > > > >
> > > > > Is this a fix for something we broke during the v4.18 merge window?
> > > > > Or does it fix something that's been broken for a long time?  I think
> > > > > the latter, but haven't looked carefully yet.    
> > > > 
> > > > This is half of a fix, really.  NFP driver does
> > > > pci_sriov_set_totalvfs(pdev, 0) to clear the limit.  Now it will
> > > > disable SR-IOV completely.  If this patch gets applied I will drop
> > > > those pci_sriov_set_totalvfs(pdev, 0) calls from the driver and the
> > > > regression will be solved.    
> > > 
> > > Sorry, I missed the regression part.  8d85a7a4f2c9 ("PCI/IOV: Allow PF
> > > drivers to limit total_VFs to 0") appeared in v4.18-rc1, so I guess the
> > > problem is that nfp works correctly in v4.17, but is broken in v4.18-rc1?
> > > 
> > > I'd just like to understand the breakage and fix better.  In v4.17:
> > > 
> > >   # nfp loaded:
> > >   nfp_pci_probe
> > >     nfp_pcie_sriov_read_nfd_limit
> > >       nfp_rtsym_read_le("nfd_vf_cfg_max_vfs", &err)
> > >       if (err)                              # FW doesn't expose limit (?)
> > >         pci_sriov_set_totalvfs(0)
> > >           dev->sriov->driver_max_VFs = 0    # PCI_SRIOV_CTRL_VFE is clear
> > > 
> > >   # userspace writes N to sysfs "sriov_numvfs":
> > >   sriov_numvfs_store                    # write N
> > >     pci_sriov_get_totalvfs
> > >       return dev->sriov->total_VFs	# since driver_max_VFs == 0
> > >     driver->sriov_configure(N)
> > >       nfp_pcie_sriov_configure(N)
> > >         nfp_pcie_sriov_enable(N)
> > > 
> > > In v4.18-rc1, it's the same except pci_sriov_get_totalvfs() now returns 0:
> > > 
> > >   # nfp loaded:
> > >   nfp_pci_probe
> > >     nfp_pcie_sriov_read_nfd_limit
> > >       nfp_rtsym_read_le("nfd_vf_cfg_max_vfs", &err)
> > >       if (err)                              # FW doesn't expose limit (?)
> > >         pci_sriov_set_totalvfs(0)
> > >           dev->sriov->driver_max_VFs = 0    # PCI_SRIOV_CTRL_VFE is clear
> > > 
> > >   # userspace writes N to sysfs "sriov_numvfs":
> > >   sriov_numvfs_store                    # write N
> > >     pci_sriov_get_totalvfs
> > >       return 0                          # (driver_max_VFs == 0)
> > >     return -ERANGE                      # because N > 0
> > > 
> > > Am I on the right track?    
> > 
> > That's exactly it!  
> 
> OK.  This regression happens even on the first module load; it doesn't
> require an unload and reload.
> 
> If that's the case, *this* patch will not actually fix the regression,
> because it only changes things when we detach the driver.  The *nfp*
> patch that removes the pci_sriov_set_totalvfs(0) calls will fix the
> regression because driver_max_VFs will be unchanged from its initial
> setting (TotalVFs from the SR-IOV capability).
> 
> So if I'd figured this out earlier, we would have squashed the nfp
> patch into 8d85a7a4f2c9 and avoided the regression altogether.

True, this patch by itself does not fix anything for the NFP, the
pci_sriov_set_totalvfs(0) calls have to be removed as well.  I was
planning to route the patches separately because I had dependent
patches for net, but that's no longer true, so we could as well squash
the "PCI: reset driver SR-IOV state after remove" and "nfp: align
setting totalvfs to changes in PCI core".  Would that make sense?

> *This* patch fixes a legitimate unload/reload issue, but I'm not clear
> whether it's a regression anybody actually sees.  If you see it, what
> scenario is it?

The firmware of the card can come either from flash, initramfs or
disk.  The flash is limited in size, and the initramfs is sometimes
hard to automatically provision with the right FW for customers.  So
there are deployment scenarios where one firmware is loaded first and
then at a later stage in boot a more advanced/different firmware is
loaded.  If the second FW doesn't have VF limit symbol without this
patch and with pci_sriov_set_totalvfs(0) removed it would inherit the
settings from the first one.

IOW for the NFP we really need both.  
