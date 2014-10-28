Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:22635 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbaJ1Qos (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Oct 2014 12:44:48 -0400
Message-ID: <544FC7FC.9040807@citrix.com>
Date: Tue, 28 Oct 2014 16:44:44 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH 1/3] x86/xen: Introduce a global flag to fix
 the MSI mask bug
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com> <1414377878-23497-2-git-send-email-wangyijing@huawei.com> <544E27F6.8010607@citrix.com> <20141027194501.GI14654@laptop.dumpdata.com>
In-Reply-To: <20141027194501.GI14654@laptop.dumpdata.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/10/14 19:45, Konrad Rzeszutek Wilk wrote:
> On Mon, Oct 27, 2014 at 11:09:42AM +0000, David Vrabel wrote:
>> On 27/10/14 02:44, Yijing Wang wrote:
>>> Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
>>> fixed MSI mask bug which may cause kernel crash. But the commit
>>> made MSI code complex. Introduce a new global flag "pci_msi_ignore_mask"
>>> to ignore MSI/MSI-X to fix this issue, it's a cleaner solution.
>>> And the commit 0e4ccb1505a9 will be reverted in the later patch.
>>
>> Reviewed-by: David Vrabel <david.vrabel@citrix.com>
>>
>> In the sense that it keeps the odd Xen behaviour.  But...
>>
>> Konrad, why was this fixed like this in the first place?  IMO, it would
> 
> As 0e4ccb1505a9 explains:
>     PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()
>     
>     Certain platforms do not allow writes in the MSI-X BARs to setup or tear
>     down vector values.  To combat against the generic code trying to write to
>     that and either silently being ignored or crashing due to the pagetables
>     being marked R/O this patch introduces a platform override.
>     
>     Note that we keep two separate, non-weak, functions default_mask_msi_irqs()
>     and default_mask_msix_irqs() for the behavior of the arch_mask_msi_irqs()
>     and arch_mask_msix_irqs(), as the default behavior is needed by x86 PCI
>     code.
>     
>     For Xen, which does not allow the guest to write to MSI-X tables - as the
>     hypervisor is solely responsible for setting the vector values - we
>     implement two nops.

My question specifically was: could this be fixed by allowing writes to
set/clear the mask bit?  If so, why was this not done and could we do
this now?

David
