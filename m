Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4956 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161473AbbKEOvn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Nov 2015 09:51:43 -0500
Date: Thu, 5 Nov 2015 14:51:41 +0000
From: Keith Busch <keith.busch@intel.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCHv3 3/4] x86/pci: Initial commit for new VMD device
 driver
Message-ID: <20151105145141.GA11787@localhost.localdomain>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
 <1445967247-24310-4-git-send-email-keith.busch@intel.com>
 <alpine.DEB.2.11.1511021426020.4032@nanos>
 <20151103001552.GE13904@localhost.localdomain>
 <alpine.DEB.2.11.1511031001130.4032@nanos>
 <20151104144905.GI13904@localhost.localdomain>
 <alpine.DEB.2.11.1511041614070.4032@nanos>
 <563AF8B3.8030907@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563AF8B3.8030907@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 05, 2015 at 02:35:31PM +0800, Jiang Liu wrote:
> Hi Keith,
> 	Could you please try the attached patch?
> Thanks!
> Gerry

Thanks! I anticipated this and tested the same thing yesterday, and it
is successful.

I'll apply to the series and send a new revision hopefully today. Not
requiring a parent simplifies the driver since we don't define
irq_domain_ops now, and the functionality they provided moves to the
irq_chip.



> From: Liu Jiang <jiang.liu@linux.intel.com>
> Date: Thu, 5 Nov 2015 11:25:07 +0800
> Subject: [PATCH] msi: Relax msi_domain_alloc() to support parentless MSI
>  irqdomains
> 
> Previously msi_domain_alloc() assumes MSI irqdomains always have parent
> irqdomains, but that's not true for the new Intel VMD devices. So relax
> msi_domain_alloc() to support parentless MSI irqdomains.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
> ---
>  kernel/irq/msi.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 7e6512b9dc1f..e4d3d707efff 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -109,9 +109,11 @@ static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	if (irq_find_mapping(domain, hwirq) > 0)
>  		return -EEXIST;
>  
> -	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> -	if (ret < 0)
> -		return ret;
> +	if (domain->parent) {
> +		ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	for (i = 0; i < nr_irqs; i++) {
>  		ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
> -- 
> 1.7.10.4
