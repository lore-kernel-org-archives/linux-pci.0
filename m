Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13031 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbcFAVKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 17:10:32 -0400
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>,
	"Busch, Keith" <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCHv2] x86/vmd: Initialize list item in irq disable
Date: Wed, 1 Jun 2016 21:10:30 +0000
Message-ID: <8D943B239464E04C9184454D8B3F5CFF0AD53672@ORSMSX101.amr.corp.intel.com>
References: <1463505738-30666-1-git-send-email-keith.busch@intel.com>
 <20160517185101.GA1975@localhost.localdomain>
In-Reply-To: <20160517185101.GA1975@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Any plans to get this set in?

Thanks,
J

-----Original Message-----
From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Jon Derrick
Sent: Tuesday, May 17, 2016 12:51 PM
To: Busch, Keith <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv2] x86/vmd: Initialize list item in irq disable

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
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c index 
> b1662bf..3519a15 100644
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
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
