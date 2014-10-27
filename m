Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46419 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaJ0TpQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Oct 2014 15:45:16 -0400
Date: Mon, 27 Oct 2014 15:45:01 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: David Vrabel <david.vrabel@citrix.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [Xen-devel] [PATCH 1/3] x86/xen: Introduce a global flag to fix
 the MSI mask bug
Message-ID: <20141027194501.GI14654@laptop.dumpdata.com>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
 <1414377878-23497-2-git-send-email-wangyijing@huawei.com>
 <544E27F6.8010607@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544E27F6.8010607@citrix.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 27, 2014 at 11:09:42AM +0000, David Vrabel wrote:
> On 27/10/14 02:44, Yijing Wang wrote:
> > Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
> > fixed MSI mask bug which may cause kernel crash. But the commit
> > made MSI code complex. Introduce a new global flag "pci_msi_ignore_mask"
> > to ignore MSI/MSI-X to fix this issue, it's a cleaner solution.
> > And the commit 0e4ccb1505a9 will be reverted in the later patch.
> 
> Reviewed-by: David Vrabel <david.vrabel@citrix.com>
> 
> In the sense that it keeps the odd Xen behaviour.  But...
> 
> Konrad, why was this fixed like this in the first place?  IMO, it would

As 0e4ccb1505a9 explains:
    PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()
    
    Certain platforms do not allow writes in the MSI-X BARs to setup or tear
    down vector values.  To combat against the generic code trying to write to
    that and either silently being ignored or crashing due to the pagetables
    being marked R/O this patch introduces a platform override.
    
    Note that we keep two separate, non-weak, functions default_mask_msi_irqs()
    and default_mask_msix_irqs() for the behavior of the arch_mask_msi_irqs()
    and arch_mask_msix_irqs(), as the default behavior is needed by x86 PCI
    code.
    
    For Xen, which does not allow the guest to write to MSI-X tables - as the
    hypervisor is solely responsible for setting the vector values - we
    implement two nops.
    
    This fixes a Xen guest crash when passing a PCI device with MSI-X to the
    guest.  See the bugzilla for more details.
    
    [bhelgaas: add bugzilla info]
    Reference: https://bugzilla.kernel.org/show_bug.cgi?id=64581

> have been better to get Xen to trap-and-emulate accesses to the relevant
> MSI/MSI-X registers.  The mask/unmask on setup/teardown isn't
> performance critical.
> 
> David
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
