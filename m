Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8062 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbcEQSvE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 14:51:04 -0400
Date: Tue, 17 May 2016 12:51:02 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv2] x86/vmd: Initialize list item in irq disable
Message-ID: <20160517185101.GA1975@localhost.localdomain>
References: <1463505738-30666-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463505738-30666-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Acked-by Jon Derrick: <jonathan.derrick@intel.com>

On Tue, May 17, 2016 at 11:22:18AM -0600, Keith Busch wrote:
> Multiple calls to disable an IRQ would have caused the driver to
> dereference a poisoned list item. This re-initializes the list to
> allow multiple requests to disable the irq.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> v1 -> v2:
>   Used the patch with the correct macro
> 
>  arch/x86/pci/vmd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index b1662bf..3519a15 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -135,6 +135,7 @@ static void vmd_irq_disable(struct irq_data *data)
>  
>  	raw_spin_lock(&list_lock);
>  	list_del_rcu(&vmdirq->node);
> +	INIT_LIST_HEAD_RCU(&vmdirq->node);
>  	raw_spin_unlock(&list_lock);
>  }
>  
> -- 
> 2.7.2
> 
