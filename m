Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030329AbeEYVp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 May 2018 17:45:27 -0400
Date: Fri, 25 May 2018 16:45:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, Sathya Perla <sathya.perla@broadcom.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        alexander.duyck@gmail.com, john.fastabend@gmail.com,
        Jacob Keller <jacob.e.keller@intel.com>,
        Donald Dutile <ddutile@redhat.com>, oss-drivers@netronome.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Message-ID: <20180525214525.GB92995@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402224652.4058-1-jakub.kicinski@netronome.com>
 <20180524235748.GD15320@bhelgaas-glaptop.roam.corp.google.com>
 <20180524182015.1af7b4c9@cakuba>
 <20180525140223.GA45098@bhelgaas-glaptop.roam.corp.google.com>
 <20180525140521.662a9c96@cakuba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180525140521.662a9c96@cakuba>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 25, 2018 at 02:05:21PM -0700, Jakub Kicinski wrote:
> On Fri, 25 May 2018 09:02:23 -0500, Bjorn Helgaas wrote:
> > On Thu, May 24, 2018 at 06:20:15PM -0700, Jakub Kicinski wrote:
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
> 
> Think more of an FPGA which can be reprogrammed at runtime to have
> different capabilities than an erratum.  Some FWs simply have no use
> for VFs and save resources (and validation time) by not supporting it.

This is a bit of a gray area.  Reloading firmware or reprogramming an
FPGA has the potential to create a new and different device than we
had before, but the PCI core doesn't know that.  The typical sequence
is:

  - PCI core enumerates device
  - driver binds to device (we call .probe())
  - driver loads new firmware to device
  - driver resets device with pci_reset_function() or similar
  - pci_reset_function() saves config space
  - pci_reset_function() resets device
  - device uses new firmware when it comes out of reset
  - pci_reset_function() restores config space

Loading the new firmware might change what the device looks like in
config space -- it could change the number or size of BARs, the
capabilities advertised, etc.  We currently sweep that under the rug
and blindly restore the old config space.

It looks like your driver does the reset differently, so maybe it
keeps the original config space setup.

But all that said, I agree that we should allow a PF driver to prevent
VF enablement, whether because the firmware doesn't support it or the
PF driver just wants to prevent use of VFs for whatever reason (maybe
we don't have enough MMIO resources, we don't need the VFs, etc.)

> Okay, perfect.  That makes sense.  The patch below certainly fixes the
> first issue for us.  Thank you!
> 
> As far as the second issue goes - agreed, having the core reset the
> number of VFs to total_VFs definitely makes sense.  It doesn't cater to
> the case where FW is reloaded without reprobing, but we don't do this
> today anyway.
> 
> Should I try to come up with a patch to reset total_VFs after detach?

Yes, please.

Bjorn
