Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30766 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbcHHQrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 12:47:22 -0400
Date: Mon, 8 Aug 2016 10:47:21 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] vmd: Synchronize with RCU freeing msi irq descs
Message-ID: <20160808164721.GA1792@localhost.localdomain>
References: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
 <1470348549-10855-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470348549-10855-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This one's fine

Acked-by Jon Derrick: <jonathan.derrick@intel.com>


On Thu, Aug 04, 2016 at 04:09:09PM -0600, Keith Busch wrote:
> This patch fixes a potential race when disabling MSI/MSI-x on a VMD domain
> device. If the vmd interrupt service is running, it may see a disabled
> irq. We can synchronize rcu just before freeing the msi descriptor. This
> is safe since the irq_desc lock isn't held, and the descriptor is valid
> even though it is disabled. After vmd_msi_free, though, the handler is
> reinitialiazed to handle_bad_irq, so we can't let the vmd isr's list
> iteration see the disabled irq after this.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  arch/x86/pci/vmd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index 2294907..e3c9b9e 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -213,6 +213,8 @@ static void vmd_msi_free(struct irq_domain *domain,
>  	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
>  	unsigned long flags;
>  
> +	synchronize_rcu();
> +
>  	/* XXX: Potential optimization to rebalance */
>  	raw_spin_lock_irqsave(&list_lock, flags);
>  	vmdirq->irq->count--;
> -- 
> 2.7.2
> 
