Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751353AbdISUUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Sep 2017 16:20:46 -0400
Date: Tue, 19 Sep 2017 14:20:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] vfio/pci: Virtualize Maximum Payload Size
Message-ID: <20170919142024.05723289@t450s.home>
In-Reply-To: <c3bbb645-50a9-a1b4-c8f2-8973f0478a2a@redhat.com>
References: <20170919164952.13200.78849.stgit@gimli.home>
        <c3bbb645-50a9-a1b4-c8f2-8973f0478a2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc +linux-pci, Sinan]

On Tue, 19 Sep 2017 19:50:37 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 19/09/2017 18:58, Alex Williamson wrote:
> > With virtual PCI-Express chipsets, we now see userspace/guest drivers
> > trying to match the physical MPS setting to a virtual downstream port.
> > Of course a lone physical device surrounded by virtual interconnects
> > cannot make a correct decision for a proper MPS setting.  Instead,
> > let's virtualize the MPS control register so that writes through to
> > hardware are disallowed.  Userspace drivers like QEMU assume they can
> > write anything to the device and we'll filter out anything dangerous.
> > Since mismatched MPS can lead to AER and other faults, let's add it
> > to the kernel side rather than relying on userspace virtualization to
> > handle it.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > 
> > Do we have any reason to suspect that a userspace driver has any
> > dependencies on the physical MPS setting or is this only tuning the
> > protocol layer and it's transparent to the driver?  Note that per the
> > PCI spec, a device supporting only 128B MPS can hardwire the control
> > register to 000b, but it doesn't seem PCIe compliant to hardwire it to
> > any given value, such as would be the appearance if we exposed this as
> > a read-only register rather than virtualizing it.  QEMU would then be
> > responsible for virtualizing it, which makes coordinating the upgrade
> > troublesome.
> > 
> >  drivers/vfio/pci/vfio_pci_config.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> > index 5628fe114347..91335e6de88a 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -849,11 +849,13 @@ static int __init init_pci_cap_exp_perm(struct perm_bits *perm)
> >  
> >  	/*
> >  	 * Allow writes to device control fields, except devctl_phantom,
> > -	 * which could confuse IOMMU, and the ARI bit in devctl2, which
> > +	 * which could confuse IOMMU, MPS, which can break communication
> > +	 * with other physical devices, and the ARI bit in devctl2, which
> >  	 * is set at probe time.  FLR gets virtualized via our writefn.
> >  	 */
> >  	p_setw(perm, PCI_EXP_DEVCTL,
> > -	       PCI_EXP_DEVCTL_BCR_FLR, ~PCI_EXP_DEVCTL_PHANTOM);
> > +	       PCI_EXP_DEVCTL_BCR_FLR | PCI_EXP_DEVCTL_PAYLOAD,
> > +	       ~PCI_EXP_DEVCTL_PHANTOM);
> >  	p_setw(perm, PCI_EXP_DEVCTL2, NO_VIRT, ~PCI_EXP_DEVCTL2_ARI);  
> Is it correct that the read value still will be the one written by the
> guest?

If we don't do this, the register is read-only, which is what I'm
suggesting in my comment above doesn't seem spec compliant.  If the
kernel makes it read-only, then userspace (ex. QEMU) would need to
virtualize it, and we get into a more complicated, two part fix.
 
> I see the MMRS can take the read MPS value in some pcie_bus_config
> values. So a consequence could be that the applied MMRS (which is not
> virtualized) is lower than what is set by host, due to a guest pcie root
> port MPSS for instance.
> 
> So if the above is not totally wrong, shouldn't we virtualize MMRS as well?

I think MPSS is Maximum Payload Size Supported and MMRS... did you mean
MRRS (Maximum Read Request Size)?

My impression is that MRRS is predominantly device and driver
dependent, not topology dependent.  A device can send a read request
with a size larger than MPS, which implies that the device supplying
the read data would split it into multiple TLPs based on MPS.  The
implementation note in PCIe rev3.1 sec 7.8.4 suggests there may be QoS
implications of MRRS such that if MRRS>MPS, then the device requesting
the data may use fewer tokens for the request.  I have no idea how we
could infer any sort of QoS policy though and I don't see that
in-kernel drivers are bound to any sort of policy.

The pcie_write_mrrs() function also implies a protocol (which I can't
find a spec reference to) where it will re-try writing MRRS if the
value written doesn't stick (and generate a dev_warn on each
iteration).  Unless we want extra warnings in VMs, that suggests we
don't want this to be read-only.

So I think we need to allow MRRS writes through to hardware, but I do
question whether we need to fill the gap that a VM might casually write
MRRS to a value less than the physical MPS.  This is what we'd expect
today where the virtual topology has an MPS of 128B regardless of the
physical topology.  Do we virtualize MRRS writes such that an MRRS
value less the physical MPS value never reaches hardware?  Can we
assume that's always invalid?  Thanks,

Alex
