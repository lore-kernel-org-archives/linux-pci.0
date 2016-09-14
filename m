Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754743AbcINWKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 18:10:45 -0400
Date: Wed, 14 Sep 2016 17:10:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] vmd: Synchronize with RCU freeing msi irq descs
Message-ID: <20160914221040.GF16581@localhost>
References: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
 <1470348549-10855-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470348549-10855-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

Applied with Jon's ack to pci/host-vmd for v4.9, thanks!

If anybody else reads this, this patch got lost for a while because it
was posted as the second patch of a series.  I had some comments on
the first patch that led to a little rework.  When that happens, I
mark the *entire* series as "Changes requested" or "Superseded"
because I'm expecting a complete repost with the rework.

It's too much work for me to track individual patches within a series.
So if you update one patch in a series, please just repost the entire
series, including other patches that may be unmodified.

Bjorn

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
