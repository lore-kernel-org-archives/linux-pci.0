Return-Path: <SRS0=9mgH=ZT=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=9mgH=ZT=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 6 Feb 2017 14:08:27 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dongdong Liu <liudongdong3@huawei.com>, linux-pci@vger.kernel.org,
	wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
	charles.chenxin@huawei.com, linuxarm@huawei.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH 3/3] PCI: generic: Fix the bug of pci_fixup_irqs() for
 arm64 platform.
Message-ID: <20170206140827.GB14139@red-moon>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-4-git-send-email-liudongdong3@huawei.com>
 <20170203204530.GH10291@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203204530.GH10291@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 02:45:30PM -0600, Bjorn Helgaas wrote:
> [+cc Tomasz, Lorenzo]
> 
> On Thu, Jan 12, 2017 at 02:28:24PM +0800, Dongdong Liu wrote:
> > arch/arm64/pci.c pcibios_alloc_irq() has the same function as
> > pci_fixup_irqs(), so we add condition #ifndef CONFIG_ARM64 for
> > pci_fixup_irqs().
> > 
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> > ---
> >  drivers/pci/host/pci-host-common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> > index e3c48b5..f160afc 100644
> > --- a/drivers/pci/host/pci-host-common.c
> > +++ b/drivers/pci/host/pci-host-common.c
> > @@ -145,7 +145,9 @@ int pci_host_common_probe(struct platform_device *pdev,
> >  		return -ENODEV;
> >  	}
> >  
> > +#ifndef CONFIG_ARM64
> >  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > +#endif
> 
> d8ed75d59332 ("ARM64: PCI: ACPI support for legacy IRQs parsing and
> consolidation with DT code") added pcibios_alloc_irq() for arm64.
> 
> arm64 is the only arch that implements pcibios_alloc_irq().  And now
> you want to add an ifdef here so arm64 is the only arch that doesn't
> call pci_fixup_irqs().
> 
> I don't remember the details of why arm64 is so special here.
> Obviously we'd prefer not to have the ifdef and not to have the
> arm64-specific pcibios_alloc_irq().

Well, I am not sure ARM64 is more special than other architectures
in this respect, actually I think that what ARM64 does is what we
will end up doing when Matthew Minter's patches are merged and
that's my aim for v4.12, pci_fixup_irqs() should not be used
any longer, at least on ARM/ARM64 and I know what to do to make
it disappear.

ARM64 relies on pcibios_alloc_irq() because of probe sequence. Before
d8ed75d59332 ("ARM64: PCI: ACPI support for legacy IRQs parsing and
consolidation with DT code") legacy IRQs were assigned at
pcibios_add_device() time. This does not work at all on ACPI (ie scan
handlers dependency), so to have a single callback DT/ACPI we
moved the allocation at pcibios_alloc_irq() time and I suspect
that's where (in pci_device_probe()) the host bridge hook to
init legacy IRQs will be called when we manage to merge Matt's
code. I will send you Matt's code rebased for v4.12, I take an
action on that (except for x86 code that IIRC is unfathomable
from this perspective and that's what blocked Matt's attempt).

Now this patch. Yes, using pci_fixup_irqs() is wrong on ARM64
(because we may reallocate an IRQ for a device that is already
bound to a driver - but that's a problem on ARM too - ie multiple
host controllers), the call has to be there for legacy IRQs to "work"
on ARM though so the ifdef.

How are we fixing this ? We merge this patch and I will remove
this stuff completely for v4.12 by using Matt's approach (ie moving
the legacy IRQ allocation to a per-host bridge callback ?)

Thanks,
Lorenzo
