Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:50404 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaKKUYf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 15:24:35 -0500
Received: by mail-ie0-f169.google.com with SMTP id tr6so12340762ieb.28
        for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2014 12:24:35 -0800 (PST)
Date: Tue, 11 Nov 2014 13:24:30 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	David Vrabel <david.vrabel@citrix.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/3] x86/xen: Introduce a global flag to fix the MSI mask
 bug
Message-ID: <20141111202430.GH28161@google.com>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
 <1414377878-23497-2-git-send-email-wangyijing@huawei.com>
 <20141111000456.GB21470@google.com>
 <20141111154538.GC6597@laptop.dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141111154538.GC6597@laptop.dumpdata.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 11, 2014 at 10:45:38AM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Nov 10, 2014 at 05:04:56PM -0700, Bjorn Helgaas wrote:
> > On Mon, Oct 27, 2014 at 10:44:36AM +0800, Yijing Wang wrote:
> > > Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
> > > fixed MSI mask bug which may cause kernel crash. But the commit
> > > made MSI code complex. Introduce a new global flag "pci_msi_ignore_mask"
> > > to ignore MSI/MSI-X to fix this issue, it's a cleaner solution.
> > > And the commit 0e4ccb1505a9 will be reverted in the later patch.
> > 
> > The 0e4ccb1505a9 changelog says Xen guests can't write to MSI-X BARs.
> > But it makes mask_irq a no-op for both MSI-X and MSI.  The MSI mask bit is
> > in config space, not in memory space.  So why does mask_irq need to be a
> > no-op for MSI as well?  Are Xen guests prohibited from writing to config
> 
> The PV guests it refers do not do write to config space. They have
> an PCI frontend and backend driver which communicates to the backend (the
> trusted domain) to setup the MSI and MSI-X. The 'pci_xen_init' (arch/x86/pci/xen.c)
> is the one that sets up the overrides. When an MSI or MSI-X is requested
> it is done via the request_irq which ends up calling 'xen_setup_msi_irqs'.
> If you look there you can see:
> 
> 173         if (type == PCI_CAP_ID_MSIX)
> 174                 ret = xen_pci_frontend_enable_msix(dev, v, nvec);
> 175         else
> 176                 ret = xen_pci_frontend_enable_msi(dev, v);
> 177         if (ret)
> 178                 goto error;
> 
> Which are the calls to the Xen PCI driver to communicate with the
> backend to setup the MSI.
> 
> > space, too?  (It's fine if they are; it's just that the changelog
> > specifically mentioned MSI-X memory space tables, and it didn't mention
> > config space at all.)
> 
> Correct. The config space is accessible to the guest but if it writes
> to it - all of those values are ignored by the hypervisor - and that
> is because the backend is suppose to communicate to the hypervisor
> whether the guest can indeed setup MSI or MSI-X.
> 
> > 
> > And I *assume* there's some Xen mechanism that accomplishes the mask_irq in
> > a different way, since the actual mask_irq interface does nothing?  (This
> > is really a question for 0e4ccb1505a9, since I don't think this particular
> > patch changes anything in that respect.)
> 
> Correct. 'request_irq' ends up doing that. Or rather it ends up
> calling xen_setup_msi_irqs which takes care of that.
> 
> The Xen PV guests (not to be confused with Xen HVM guests) run without
> any emulated devices. That means most of the x86 platform things - ioports,
> VGA, etc - are removed. Instead that functionality is provided via 
> frontend drivers that communicate to the backend via a ring.
> 
> Hopefully this clarifies it?

I think so.  I propose the following changelog.  Let me know if it's still
inaccurate:

  PCI/MSI: Add pci_msi_ignore_mask to prevent MSI/MSI-X BAR writes

  MSI-X vector Mask Bits are in MSI-X Tables in PCI memory space.  Xen guests
  can't write to those tables.  MSI vector Mask Bits are in PCI configuration
  space.  Xen guests can write to config space, but those writes are ignored.

  Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and
  msix_mask_irq()") added a way to override default_mask_msi_irqs() and
  default_mask_msix_irqs() so they can be no-ops in Xen guests, but this is
  more complicated than necessary.

  Add "pci_msi_ignore_mask" in the core PCI MSI code.  If set,
  default_mask_msi_irqs() and default_mask_msix_irqs() return without doing
  anything.  This is less flexible, but much simpler.

I guess you mentioned PV and HVM guests, and it sounds like all this only
applies to HVM guests.

Bjorn
