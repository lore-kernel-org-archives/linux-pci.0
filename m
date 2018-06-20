Return-Path: <SRS0=dUK+=JG=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=dUK+=JG=netronome.com=jakub.kicinski@kernel.org>
Date: Tue, 19 Jun 2018 19:56:43 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, Sathya Perla <sathya.perla@broadcom.com>, Felix
 Manlunas <felix.manlunas@caviumnetworks.com>, alexander.duyck@gmail.com,
 john.fastabend@gmail.com, Jacob Keller <jacob.e.keller@intel.com>, Donald
 Dutile <ddutile@redhat.com>, oss-drivers@netronome.com, Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Message-ID: <20180619195643.7800f7ea@cakuba.netronome.com>
In-Reply-To: <20180619213715.GC33049@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402224652.4058-1-jakub.kicinski@netronome.com>
	<20180524235748.GD15320@bhelgaas-glaptop.roam.corp.google.com>
	<20180524182015.1af7b4c9@cakuba>
	<20180525140223.GA45098@bhelgaas-glaptop.roam.corp.google.com>
	<20180619213715.GC33049@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 19 Jun 2018 16:37:15 -0500, Bjorn Helgaas wrote:
> On Fri, May 25, 2018 at 09:02:23AM -0500, Bjorn Helgaas wrote:
> > On Thu, May 24, 2018 at 06:20:15PM -0700, Jakub Kicinski wrote:  
> > > Hi Bjorn!
> > > 
> > > On Thu, 24 May 2018 18:57:48 -0500, Bjorn Helgaas wrote:  
> > > > On Mon, Apr 02, 2018 at 03:46:52PM -0700, Jakub Kicinski wrote:  
> > > > > Some user space depends on enabling sriov_totalvfs number of VFs
> > > > > to not fail, e.g.:
> > > > > 
> > > > > $ cat .../sriov_totalvfs > .../sriov_numvfs
> > > > > 
> > > > > For devices which VF support depends on loaded FW we have the
> > > > > pci_sriov_{g,s}et_totalvfs() API.  However, this API uses 0 as
> > > > > a special "unset" value, meaning drivers can't limit sriov_totalvfs
> > > > > to 0.  Remove the special values completely and simply initialize
> > > > > driver_max_VFs to total_VFs.  Then always use driver_max_VFs.
> > > > > Add a helper for drivers to reset the VF limit back to total.    
> > > > 
> > > > I still can't really make sense out of the changelog.
> > > >
> > > > I think part of the reason it's confusing is because there are two
> > > > things going on:
> > > > 
> > > >   1) You want this:
> > > >   
> > > >        pci_sriov_set_totalvfs(dev, 0);
> > > >        x = pci_sriov_get_totalvfs(dev) 
> > > > 
> > > >      to return 0 instead of total_VFs.  That seems to connect with
> > > >      your subject line.  It means "sriov_totalvfs" in sysfs could be
> > > >      0, but I don't know how that is useful (I'm sure it is; just
> > > >      educate me :))  
> > > 
> > > Let me just quote the bug report that got filed on our internal bug
> > > tracker :)
> > > 
> > >   When testing Juju Openstack with Ubuntu 18.04, enabling SR-IOV causes
> > >   errors because Juju gets the sriov_totalvfs for SR-IOV-capable device
> > >   then tries to set that as the sriov_numvfs parameter.
> > > 
> > >   For SR-IOV incapable FW, the sriov_totalvfs parameter should be 0, 
> > >   but it's set to max.  When FW is switched to flower*, the correct 
> > >   sriov_totalvfs value is presented.
> > > 
> > > * flower is a project name  
> > 
> > From the point of view of the PCI core (which knows nothing about
> > device firmware and relies on the architected config space described
> > by the PCIe spec), this sounds like an erratum: with some firmware
> > installed, the device is not capable of SR-IOV, but still advertises
> > an SR-IOV capability with "TotalVFs > 0".
> > 
> > Regardless of whether that's an erratum, we do allow PF drivers to use
> > pci_sriov_set_totalvfs() to limit the number of VFs that may be
> > enabled by writing to the PF's "sriov_numvfs" sysfs file.
> > 
> > But the current implementation does not allow a PF driver to limit VFs
> > to 0, and that does seem nonsensical.
> >   
> > > My understanding is OpenStack uses sriov_totalvfs to determine how many
> > > VFs can be enabled, looks like this is the code:
> > > 
> > > http://git.openstack.org/cgit/openstack/charm-neutron-openvswitch/tree/hooks/neutron_ovs_utils.py#n464
> > >   
> > > >   2) You're adding the pci_sriov_reset_totalvfs() interface.  I'm not
> > > >      sure what you intend for this.  Is *every* driver supposed to
> > > >      call it in .remove()?  Could/should this be done in the core
> > > >      somehow instead of depending on every driver?  
> > > 
> > > Good question, I was just thinking yesterday we may want to call it
> > > from the core, but I don't think it's strictly necessary nor always
> > > sufficient (we may reload FW without re-probing).
> > > 
> > > We have a device which supports different number of VFs based on the FW
> > > loaded.  Some legacy FWs does not inform the driver how many VFs it can
> > > support, because it supports max.  So the flow in our driver is this:
> > > 
> > > load_fw(dev);
> > > ...
> > > max_vfs = ask_fw_for_max_vfs(dev);
> > > if (max_vfs >= 0)
> > > 	return pci_sriov_set_totalvfs(dev, max_vfs);
> > > else /* FW didn't tell us, assume max */
> > > 	return pci_sriov_reset_totalvfs(dev); 
> > > 
> > > We also reset the max on device remove, but that's not strictly
> > > necessary.
> > > 
> > > Other users of pci_sriov_set_totalvfs() always know the value to set
> > > the total to (either always get it from FW or it's a constant).
> > > 
> > > If you prefer we can work out the correct max for those legacy cases in
> > > the driver as well, although it seemed cleaner to just ask the core,
> > > since it already has total_VFs value handy :)
> > >   
> > > > I'm also having a hard time connecting your user-space command example
> > > > with the rest of this.  Maybe it will make more sense to me tomorrow
> > > > after some coffee.  
> > > 
> > > OpenStack assumes it will always be able to set sriov_numvfs to
> > > sriov_totalvfs, see this 'if':
> > > 
> > > http://git.openstack.org/cgit/openstack/charm-neutron-openvswitch/tree/hooks/neutron_ovs_utils.py#n512  
> > 
> > Thanks for educating me.  I think there are two issues here that we
> > can separate.  I extracted the patch below for the first.
> > 
> > The second is the question of resetting driver_max_VFs.  I think we
> > currently have a general issue in the core:
> > 
> >   - load PF driver 1
> >   - driver calls pci_sriov_set_totalvfs() to reduce driver_max_VFs
> >   - unload PF driver 1
> >   - load PF driver 2
> > 
> > Now driver_max_VFs is still stuck at the lower value set by driver 1.
> > I don't think that's the way this should work.
> > 
> > I guess this is partly a consequence of setting driver_max_VFs in
> > sriov_init(), which is called before driver attach and should only
> > depend on hardware characteristics, so it is related to the patch
> > below.  But I think we should fix it in general, not just for
> > netronome.  
> 
> Hi Jakub, the patch below is in v4.18-rc1 as 8d85a7a4f2c9 ("PCI/IOV:
> Allow PF drivers to limit total_VFs to 0").  If there's more we need
> to do here, would you mind rebasing what's left to v4.18-rc1 and
> reposting it?

Hi Bjorn!

Thanks a lot for looking into this!  My understanding is that we have
two ways forward:
 - add a pci_sriov_reset_totalvfs() helper for drivers to call;
 - make the core reset the totalVFs after driver is detached.

IMHO second option is better.  I went ahead and posted:

https://patchwork.ozlabs.org/patch/931210/

This works very well for nfp driver (modulo minor clean ups but I'd
rather route those via networking trees to avoid conflicts).

> > commit 4a338bc6f94b9ad824ac944f5dfc249d6838719c
> > Author: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Date:   Fri May 25 08:18:34 2018 -0500
> > 
> >     PCI/IOV: Allow PF drivers to limit total_VFs to 0
> >     
> >     Some SR-IOV PF drivers implement .sriov_configure(), which allows
> >     user-space to enable VFs by writing the desired number of VFs to the sysfs
> >     "sriov_numvfs" file (see sriov_numvfs_store()).
> >     
> >     The PCI core limits the number of VFs to the TotalVFs advertised by the
> >     device in its SR-IOV capability.  The PF driver can limit the number of VFs
> >     to even fewer (it may have pre-allocated data structures or knowledge of
> >     device limitations) by calling pci_sriov_set_totalvfs(), but previously it
> >     could not limit the VFs to 0.
> >     
> >     Change pci_sriov_get_totalvfs() so it always respects the VF limit imposed
> >     by the PF driver, even if the limit is 0.
> >     
> >     This sequence:
> >     
> >       pci_sriov_set_totalvfs(dev, 0);
> >       x = pci_sriov_get_totalvfs(dev);
> >     
> >     previously set "x" to TotalVFs from the SR-IOV capability.  Now it will set
> >     "x" to 0.
> >     
> >     Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 192b82898a38..d0d73dbbd5ca 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -469,6 +469,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >  	iov->nres = nres;
> >  	iov->ctrl = ctrl;
> >  	iov->total_VFs = total;
> > +	iov->driver_max_VFs = total;
> >  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID, &iov->vf_device);
> >  	iov->pgsz = pgsz;
> >  	iov->self = dev;
> > @@ -827,10 +828,7 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
> >  	if (!dev->is_physfn)
> >  		return 0;
> >  
> > -	if (dev->sriov->driver_max_VFs)
> > -		return dev->sriov->driver_max_VFs;
> > -
> > -	return dev->sriov->total_VFs;
> > +	return dev->sriov->driver_max_VFs;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
> >    
