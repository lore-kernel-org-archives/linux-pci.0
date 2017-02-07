Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932416AbdBGVqz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 16:46:55 -0500
Date: Tue, 7 Feb 2017 15:46:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Dongdong Liu <liudongdong3@huawei.com>, linux-pci@vger.kernel.org,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        charles.chenxin@huawei.com, linuxarm@huawei.com,
        Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH 3/3] PCI: generic: Fix the bug of pci_fixup_irqs() for
 arm64 platform.
Message-ID: <20170207214645.GB11659@bhelgaas-glaptop.roam.corp.google.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-4-git-send-email-liudongdong3@huawei.com>
 <20170203204530.GH10291@bhelgaas-glaptop.roam.corp.google.com>
 <20170206140827.GB14139@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206140827.GB14139@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 02:08:27PM +0000, Lorenzo Pieralisi wrote:
> On Fri, Feb 03, 2017 at 02:45:30PM -0600, Bjorn Helgaas wrote:
> > [+cc Tomasz, Lorenzo]
> > 
> > On Thu, Jan 12, 2017 at 02:28:24PM +0800, Dongdong Liu wrote:
> > > arch/arm64/pci.c pcibios_alloc_irq() has the same function as
> > > pci_fixup_irqs(), so we add condition #ifndef CONFIG_ARM64 for
> > > pci_fixup_irqs().
> > > 
> > > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > > Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > > Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> > > ---
> > >  drivers/pci/host/pci-host-common.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> > > index e3c48b5..f160afc 100644
> > > --- a/drivers/pci/host/pci-host-common.c
> > > +++ b/drivers/pci/host/pci-host-common.c
> > > @@ -145,7 +145,9 @@ int pci_host_common_probe(struct platform_device *pdev,
> > >  		return -ENODEV;
> > >  	}
> > >  
> > > +#ifndef CONFIG_ARM64
> > >  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > > +#endif
> > 
> > d8ed75d59332 ("ARM64: PCI: ACPI support for legacy IRQs parsing and
> > consolidation with DT code") added pcibios_alloc_irq() for arm64.
> > 
> > arm64 is the only arch that implements pcibios_alloc_irq().  And now
> > you want to add an ifdef here so arm64 is the only arch that doesn't
> > call pci_fixup_irqs().
> > 
> > I don't remember the details of why arm64 is so special here.
> > Obviously we'd prefer not to have the ifdef and not to have the
> > arm64-specific pcibios_alloc_irq().
> 
> Well, I am not sure ARM64 is more special than other architectures
> in this respect, actually I think that what ARM64 does is what we
> will end up doing when Matthew Minter's patches are merged and
> that's my aim for v4.12, pci_fixup_irqs() should not be used
> any longer, at least on ARM/ARM64 and I know what to do to make
> it disappear.

ARM64 is different from x86, even though both arches support both ACPI
and DT: on ARM64 we currently call of_irq_parse_and_map_pci() when we
call the driver's probe() method, whereas on x86 we don't call it
until the driver calls pci_enable_device().

Obviously it would be better if this were done at the same point on
both arches.  I don't know what that point *is*.  I could imagine
enumeration-time, probe-time, or enable-time.

OK, back to the patch at hand.  I think we're agreed that having
pci_host_common_probe() call pci_fixup_irqs() is wrong on all
architectures (it doesn't cover hot-added devices and it may clobber
an IRQ after a driver has claimed the device (since it "fixes" all PCI
devices).  And we hope to fix this in the next cycle using Matt's
work.

So I think I'm OK with this transient ugliness.  Although
pci-host-common.c is currently only available on ARM and ARM64, in
theory, it should be usable on x86.  I would probably use "#ifdef ARM"
instead of "#ifndef ARM64" so that when it is made available on x86,
we won't call pci_fixup_irqs() there.

What do you think of the following?


commit 4e3538fb84dcba2de5d5b0990ced7f3f881fda1e
Author: Dongdong Liu <liudongdong3@huawei.com>
Date:   Thu Jan 12 14:28:24 2017 +0800

    PCI: generic: Call pci_fixup_irqs() only on ARM
    
    pci_fixup_irqs() is problematic because:
    
      - it's called when we enumerate a host bridge, so we don't fixup IRQs for
        hot-added PCI devices, and
    
      - it fixes up IRQs for all PCI devices in the system, so if we call it
        multiple times, e.g., if we have several host controllers, we may
        reallocate an IRQ for a device after a driver has already claimed it.
    
    We plan to replace pci_fixup_irqs() soon, but we still need it on ARM
    because we don't have any other generic method for doing this.
    
    On ARM64, we don't need pci_fixup_irqs() because we do IRQ setup when we
    bind a driver to the device (in the pci_device_probe() ->
    pcibios_alloc_irq() path).
    
    pci-host-common.c is currently only used on ARM and ARM64.  In principle,
    it could be used on x86, and we wouldn't want pci_fixup_irqs() there
    either, because x86 does IRQ setup in the pci_enable_device() path.
    
    [bhelgaas: changelog, use #ifdef ARM, not #ifndef ARM64]
    Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
    Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index e3c48b5deb93..e9a53bae1c25 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -145,7 +145,9 @@ int pci_host_common_probe(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_ARM
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+#endif
 
 	/*
 	 * We insert PCI resources into the iomem_resource and
