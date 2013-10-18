Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51568 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3JRFdZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2013 01:33:25 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: zhenzhong.duan@oracle.com, 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	'xen-devel' <xen-devel@lists.xen.org>,
	'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
	'Feng Jin' <joe.jin@oracle.com>,
	'Sucheta Chakraborty' <sucheta.chakraborty@qlogic.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <525E3320.5080700@oracle.com>
In-reply-to: <525E3320.5080700@oracle.com>
Subject: Re: [PATCH 2/3] PCI: Refactor MSI/MSIX mask restore code to fix
 interrupt lost issue
Date: Fri, 18 Oct 2013 14:32:14 +0900
Message-id: <000101cecbc3$67291550$357b3ff0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 16, 2013 3:33 PM, Zhenzhong Duan wrote:
> 
> Driver init call graph under baremetal:
> driver_init->
>     msix_capability_init->
>         msix_program_entries->
>             msix_mask_irq->
>                 entry->masked = 1
>     request_irq->
>         __setup_irq->
>             irq_startup->
>                 unmask_msi_irq->
>                     msix_mask_irq->
>                         entry->masked = 0;
> 
> So entry->masked is always updated with newest value and its value could be used
> to restore to mask register in device.
> 
> But in initial domain (aka priviliged guest), it's different.
> Driver init call graph under initial domain:
> driver_init->
>     msix_capability_init->
>         msix_program_entries->
>             msix_mask_irq->
>                 entry->masked = 1
>     request_irq->
>         __setup_irq->
>             irq_startup->
>                 __startup_pirq->
>                     EVTCHNOP_bind_pirq hypercall    (trap into Xen)
> [Xen:]
> pirq_guest_bind->
>     startup_msi_irq->
>         unmask_msi_irq->
>             msi_set_mask_bit->
>                 entry->msi_attrib.masked = 0;
> 
> So entry->msi_attrib.masked in xen side always has newest value. entry->masked
> in initial domain is untouched and is 1 after msix_capability_init.
> 
> Based on above, it's Xen's duty to restore entry->msi_attrib.masked to device,
> but with current code, entry->masked is used and MSI-x interrupt is masked.
> 
> Before patch, restore call graph under initial domain:
> pci_reset_function->
>     pci_restore_state->
>         __pci_restore_msix_state->
>             arch_restore_msi_irqs->
>                 xen_initdom_restore_msi_irqs->
>                     PHYSDEVOP_restore_msi hypercall (first mask restore)
>             msix_mask_irq(entry, entry->masked)     (second mask restore)
> 
> So msix_mask_irq call in initial domain call graph needs to be removed.
> 
> Based on this we can move the restore of the mask in default_restore_msi_irqs
> which would avoid restoring the invalid mask under Xen. Furthermore this
> simplifies the API by making everything related to restoring an MSI be in the
> platform specific APIs instead of just parts of it.
> 
> After patch, restore call graph under initial domain:
> pci_reset_function->
>     pci_restore_state->
>         __pci_restore_msix_state->
>             arch_restore_msi_irqs->
>                 xen_initdom_restore_msi_irqs->
>                     PHYSDEVOP_restore_msi hypercall (first mask restore)
> 
> Logic for baremetal is not changed.
> Before patch, restore call graph under baremetal:
> pci_reset_function->
>     pci_restore_state->
>         __pci_restore_msix_state->
>             arch_restore_msi_irqs->
>                 default_restore_msi_irqs->
>             msix_mask_irq(entry, entry->masked)     (first mask restore)
> 
> After patch, restore call graph under baremetal:
> pci_reset_function->
>     pci_restore_state->
>         __pci_restore_msix_state->
>             arch_restore_msi_irqs->
>                 default_restore_msi_irqs->
>                     msix_mask_irq(entry, entry->masked) (first mask restore)
> 
> The process for MSI code is similiar.
> 
> Tested-by: Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

It looks good. Also, I tested this patch on Exynos5440.

Best regards,
Jingoo Han

