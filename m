Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdBXOc3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Feb 2017 09:32:29 -0500
Date: Fri, 24 Feb 2017 08:32:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Inamdar <tinamdar@apm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH v1 0/3] PCI: Configure PCIe MPS settings
Message-ID: <20170224143224.GA15547@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170210215959.GR29169@bhelgaas-glaptop.roam.corp.google.com>
 <MWHPR03MB26690F3B4C7E83596C35D377BF520@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB26690F3B4C7E83596C35D377BF520@MWHPR03MB2669.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2017 at 11:16:03AM +0000, Dexuan Cui wrote:
> > From: devel [mailto:driverdev-devel..@...] On Behalf Of Bjorn Helgaas
> > Sent: Saturday, February 11, 2017 06:00
> > ...
> > On Wed, Feb 08, 2017 at 04:49:22PM -0600, Bjorn Helgaas wrote:
> > > The PCI core doesn't configure the PCIe MPS settings by itself.  Each
> > > host bridge driver has to call pcie_bus_configure_settings() to make
> > > this happen.
> > >
> > > Jon fixed this already for pcie-iproc.c.  I propose these similar
> > > patches for other drivers.
> > >
> > > HV guys, I included you because create_root_hv_pci_bus() is one place
> > > that calls pci_scan_child_bus() but does not call
> > > pcie_bus_configure_settings().  I know you probably don't strictly
> > > *need* to configure MPS settings in a paravirtual front-end, but the
> > > PCI core does other device configuration in this path:
> > >
> > >   pci_scan_child_bus
> > >     pci_scan_slot
> > >       pci_scan_single_device
> > >         pci_device_add
> > >           pci_configure_device
> > >           pci_init_capabilities
> > >
> > > and I would like to eventually migrate the MPS configuration into that
> > > same path.  Since we do this other configuration for HV devices
> > > already, I think pcie_bus_configure_settings() should also work (even
> > > if it ends up not doing anything to real devices).
> > >
> > > It would make that eventual migration easier if all the
> > > pci_scan_child_bus() callers had the same pattern of calling
> > > pcie_bus_configure_settings().
> > >
> > > So would it make sense to make a similar patch for HV?  It looks easy
> > > to add it to create_root_hv_pci_bus(), but I don't know exactly what
> > > to do about pci_devices_present_work().
> 
> (I'm sorry for the really late response. I neglected the thread somehow...)

No problem, I'm kind of bad about that, too.

> Hi Bjorn,
> IMO we don't need to make any change to pci-hyperv.c: when a
> PCIe device is passed through to a guest on Hyper-V, in the guest the
> device only directly appears on a new root bus, and the new root bus
> doesn't have any child bus, and the new root bus itself is actually only
> a logical concept instead of a concrete device (i.e. it doesn't have its
> own BDF at all).
> 
> So, in the path pci_scan_child_bus -> ... -> pci_device_add ->
> pci_configure_device -> pci_configure_mps, we're sure
> pci_upstream_bridge() is NULL, so pci_configure_mps does nothing.
> 
> And since the root bus has no child bus, we don't need to call
> pcie_bus_configure_settings(child).
> 
> Then you may ask how the MPS is set.
> I suppose the para-virtual PCI back-end driver on the host
> should take care of this properly.
> 
> FWIW, after passing through a Mellanox VF to Linux guest, in the
> guest I get this for the device by lspci:
>         DevCap: MaxPayload 512 bytes
>         DevCtl: MaxPayload 128 bytes, MaxReadReq 128 bytes

My question wasn't so much whether pci-hyperv.c *needs* to set MPS; I
don't expect a guest to need to or even be able to configure things
like that.

My question is whether it would do any harm if we did eventually do
MPS configuration in the generic pci_scan_child_bus() path.  If/when
we do that, the Hyper-V guest will attempt to do MPS configuration.  I
think this would be a no-op.  And I think it would also be a no-op if
we made pci-hyperv.c call pcie_bus_configure_settings() today.

I'm really just looking for confirmation of that.  If it is true that
these are no-ops, I would consider adding a pci-hyperv.c call to
pcie_bus_configure_settings() simply to make it conform to the pattern
that "everything that calls pci_scan_child_bus() should also call
pcie_bus_configure_settings()".

If every caller of pci_scan_child_bus() also calls
pcie_bus_configure_settings(), it will make it easier in the future to
fold pcie_bus_configure_settings() into pci_scan_child_bus().

Bjorn
