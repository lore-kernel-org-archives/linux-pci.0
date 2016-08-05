Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36142 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbcHERDM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Aug 2016 13:03:12 -0400
Date: Fri, 5 Aug 2016 12:03:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 1/2] vmd: Fix infinite loop executing irq's
Message-ID: <20160805170302.GA432@localhost>
References: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Thu, Aug 04, 2016 at 04:09:08PM -0600, Keith Busch wrote:
> We can't initialize the list head on deletion as this causes the node
> to point to itself, looping infinitely if the vmd IRQ handler happens
> to be servicing that node.
> 
> The list initialization supposed to fix a bug from multiple calls to
> disable the same IRQ. We can fix this instead just checking if the
> previous pointer indicates it was already deleted.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  arch/x86/pci/vmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index e88b417..2294907 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -136,8 +136,8 @@ static void vmd_irq_disable(struct irq_data *data)
>  	data->chip->irq_mask(data);
>  
>  	raw_spin_lock_irqsave(&list_lock, flags);
> -	list_del_rcu(&vmdirq->node);
> -	INIT_LIST_HEAD_RCU(&vmdirq->node);
> +	if (vmdirq->node.prev != LIST_POISON2)
> +		list_del_rcu(&vmdirq->node);

It doesn't seem quite right to test for LIST_POISON2.  It seems like a
little too much knowledge of list internals.  There are no other
similar tests in the kernel.  Surely this isn't the only case where we
need to remove from a list that another thread might be traversing.  I
would look for other similar situations and copy the way they handle
it.

I think I saw a Fixes: tag later, so I assume you'll pick that up for
v2.  Should this also be tagged for stable?  Are there any bug reports
we should reference?

>  	raw_spin_unlock_irqrestore(&list_lock, flags);
>  }
>  
