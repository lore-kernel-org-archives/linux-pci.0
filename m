Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43208 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbcFQXA4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 19:00:56 -0400
Date: Fri, 17 Jun 2016 18:00:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] vmd: use untracked irq handler
Message-ID: <20160617230052.GA21200@localhost>
References: <1466200821-29159-1-git-send-email-keith.busch@intel.com>
 <1466200821-29159-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466200821-29159-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 04:00:21PM -0600, Keith Busch wrote:
> There is no way to know which device in a VMD tiggered an interrupt

s/tiggered/triggered/

> without invoking every registered driver's actions. This uses the
> untracked irq handler so that a less used device does not trigger
> spurious interrupt.
> 
> We have been previously recommending users enable "noirqdebug", but do
> not want to force a system setting just to keep this domain functional.

I applaud that goal.

> Signed-off-by: Keith Busch <keith.busch@intel.com>

Since this depends on the previous patch and I'm not qualified to review
that one, I'll ack this and somebody else can merge both or none:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/x86/pci/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index 7792aba..613cac7 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -195,7 +195,7 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
>  	vmdirq->virq = virq;
>  
>  	irq_domain_set_info(domain, virq, vmdirq->irq->vmd_vector, info->chip,
> -			    vmdirq, handle_simple_irq, vmd, NULL);
> +			    vmdirq, handle_untracked_irq, vmd, NULL);
>  	return 0;
>  }
>  
> -- 
> 2.7.2
> 
